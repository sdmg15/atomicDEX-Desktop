import osproc
import os
import vcpkg

var g_date = "date"
when defined(windows):
    g_date = "date[remote-api]"

let g_packages = [
    (name: "entt", head: false),
    (name: "folly", head: false),
    (name: "boost-multiprecision", head: false),
    (name: "boost-random", head: false),
    (name: "boost-lockfree", head: false),
    (name: "boost-stacktrace", head: false),
    (name: "doctest", head: false),
    (name: "fmt", head: false),
    (name: "curl", head: false),
    (name: "nlohmann-json", head: false),
    (name: "range-v3", head: false),
    (name: "libsodium", head: false),
    (name: "spdlog", head: false),
    (name: "cpprestsdk", head: false),
    (name: "cpp-taskflow", head: false),
    (name: g_date, head: false)]

proc download_packages*() =
    echo "Downloading packages ... please wait"
    var vcpkg_custom_ports_path = os.getCurrentDir().joinPath("vcpkg-custom-ports")
    if not os.existsDir(vcpkg_custom_ports_path):
        echo "Installing custom ports"
        discard execCmd("git clone https://github.com/KomodoPlatform/vcpkg-custom-ports vcpkg-custom-ports")
    for idx, package in g_packages:
        if package.head:
            when defined(windows):
                discard execCmd(g_vcpkg_local_path & " install " & package.name & ":x64-windows --head --overlay-ports=" & vcpkg_custom_ports_path)
            when defined(linux) or defined(osx):
                discard execCmd(g_vcpkg_local_path & " install " & package.name & " --head --overlay-ports=" & vcpkg_custom_ports_path)
        else:
            when defined(windows):
                discard execCmd(g_vcpkg_local_path & " install " & package.name & ":x64-windows --overlay-ports=" & vcpkg_custom_ports_path)
            when defined(linux) or defined(osx):
                discard execCmd(g_vcpkg_local_path & " install " & package.name & " --overlay-ports=" & vcpkg_custom_ports_path)
    echo "Downloading packages finished"
