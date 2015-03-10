From: Andy Isaacson <adi@hexapodia.org>
Subject: 3.19: Thinkpad T440s clickpad always gives button3
Date: Mon, 9 Mar 2015 17:34:58 -0700
Message-ID: <20150310003458.GA14045@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from straum.hexapodia.org ([192.235.78.53]:34647 "EHLO
	straum.hexapodia.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbbCJAk2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Mar 2015 20:40:28 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I recently upgraded from 3.15.10 to 3.19.0 (I skipped a bunch of
versions due to some GPU issues which I finally resolved).  In the
upgrade, the touchpad stopped delivering button1 and now always delivers
button3 events on click.

I normally use the laptop after disabling the touchpad and simply using
the TrackPoint, or an external mouse.  I use the following to disable
it:

synclient HorizHysteresis=10000 VertHysteresis=10000

Ah! in testing to send this message, I noticed that 1-finger taps are
turning into button1 events, two-finger taps turn into button3 events,
and three-finger taps turn into button2 events.  Clicking the trackpad
is the buggy behavior, it always turns into a button3 rather than a
button1.

dmesg is fairly uninformative regarding what quirks/etc are enabled, but
I've appended the whole thing below.

Xorg.0.log says

[    19.739] (II) config/udev: Adding input device SynPS/2 Synaptics TouchPad (/dev/input/event16)
[    19.739] (**) SynPS/2 Synaptics TouchPad: Applying InputClass "evdev touchpad catchall"
[    19.739] (**) SynPS/2 Synaptics TouchPad: Applying InputClass "touchpad catchall"
[    19.739] (**) SynPS/2 Synaptics TouchPad: Applying InputClass "Default clickpad buttons"
[    19.739] (II) LoadModule: "synaptics"
[    19.739] (II) Loading /usr/lib/xorg/modules/input/synaptics_drv.so
[    19.740] (II) Module synaptics: vendor="X.Org Foundation"
[    19.740]    compiled for 1.16.0.901, module version = 1.8.99
[    19.740]    Module class: X.Org XInput Driver
[    19.740]    ABI class: X.Org XInput driver, version 21.0
[    19.740] (II) Using input driver 'synaptics' for 'SynPS/2 Synaptics TouchPad'
[    19.740] (**) SynPS/2 Synaptics TouchPad: always reports core events
[    19.740] (**) Option "Device" "/dev/input/event16"
[    19.772] (II) synaptics: SynPS/2 Synaptics TouchPad: found clickpad property
[    19.772] (II) synaptics: SynPS/2 Synaptics TouchPad: found top buttonpad property
[    19.772] (--) synaptics: SynPS/2 Synaptics TouchPad: x-axis range 1024 - 5112 (res 42)
[    19.772] (--) synaptics: SynPS/2 Synaptics TouchPad: y-axis range 2024 - 4832 (res 42)
[    19.772] (--) synaptics: SynPS/2 Synaptics TouchPad: pressure range 0 - 255
[    19.772] (--) synaptics: SynPS/2 Synaptics TouchPad: finger width range 0 - 15
[    19.772] (--) synaptics: SynPS/2 Synaptics TouchPad: buttons: left double triple
[    19.772] (--) synaptics: SynPS/2 Synaptics TouchPad: Vendor 0x2 Product 0x7
[    19.772] (**) Option "SoftButtonAreas" "50% 0 82% 0 0 0 0 0"
[    19.772] (**) Option "SecondarySoftButtonAreas" "58% 0 0 15% 42% 58% 0 15%"
[    19.772] (--) synaptics: SynPS/2 Synaptics TouchPad: touchpad found
[    19.772] (**) SynPS/2 Synaptics TouchPad: always reports core events
[    19.808] (**) Option "config_info" "udev:/sys/devices/platform/i8042/serio1/input/input7/event16"
[    19.808] (II) XINPUT: Adding extended input device "SynPS/2 Synaptics TouchPad" (type: TOUCHPAD, id 11)
[    19.808] (**) synaptics: SynPS/2 Synaptics TouchPad: (accel) MinSpeed is now constant deceleration 2.5
[    19.808] (**) synaptics: SynPS/2 Synaptics TouchPad: (accel) MaxSpeed is now 1.75
[    19.808] (**) synaptics: SynPS/2 Synaptics TouchPad: (accel) AccelFactor is now 0.040
[    19.808] (**) SynPS/2 Synaptics TouchPad: (accel) keeping acceleration scheme 1
[    19.808] (**) SynPS/2 Synaptics TouchPad: (accel) acceleration profile 1
[    19.808] (**) SynPS/2 Synaptics TouchPad: (accel) acceleration factor: 2.000
[    19.808] (**) SynPS/2 Synaptics TouchPad: (accel) acceleration threshold: 4
[    19.808] (--) synaptics: SynPS/2 Synaptics TouchPad: touchpad found
[    19.808] (II) config/udev: Adding input device SynPS/2 Synaptics TouchPad (/dev/input/mouse1)
[    19.808] (**) SynPS/2 Synaptics TouchPad: Ignoring device from InputClass "touchpad ignore duplicates"
[    19.809] (II) config/udev: Adding input device TPPS/2 IBM TrackPoint (/dev/input/event17)
[    19.809] (**) TPPS/2 IBM TrackPoint: Applying InputClass "evdev pointer catchall"
[    19.809] (II) Using input driver 'evdev' for 'TPPS/2 IBM TrackPoint'
[    19.809] (**) TPPS/2 IBM TrackPoint: always reports core events
[    19.809] (**) evdev: TPPS/2 IBM TrackPoint: Device: "/dev/input/event17"
[    19.809] (--) evdev: TPPS/2 IBM TrackPoint: Vendor 0x2 Product 0xa
[    19.809] (--) evdev: TPPS/2 IBM TrackPoint: Found 3 mouse buttons
[    19.809] (--) evdev: TPPS/2 IBM TrackPoint: Found relative axes
[    19.809] (--) evdev: TPPS/2 IBM TrackPoint: Found x and y relative axes
[    19.809] (II) evdev: TPPS/2 IBM TrackPoint: Configuring as mouse
[    19.809] (**) evdev: TPPS/2 IBM TrackPoint: YAxisMapping: buttons 4 and 5
[    19.809] (**) evdev: TPPS/2 IBM TrackPoint: EmulateWheelButton: 4, EmulateWheelInertia: 10, EmulateWheelTimeout: 200
[    19.809] (**) Option "config_info" "udev:/sys/devices/platform/i8042/serio1/serio2/input/input18/event17"
[    19.809] (II) XINPUT: Adding extended input device "TPPS/2 IBM TrackPoint" (type: MOUSE, id 12)
[    19.809] (II) evdev: TPPS/2 IBM TrackPoint: initialized for relative axes.
[    19.809] (**) TPPS/2 IBM TrackPoint: (accel) keeping acceleration scheme 1
[    19.809] (**) TPPS/2 IBM TrackPoint: (accel) acceleration profile 0
[    19.809] (**) TPPS/2 IBM TrackPoint: (accel) acceleration factor: 2.000
[    19.809] (**) TPPS/2 IBM TrackPoint: (accel) acceleration threshold: 4
[    19.809] (II) config/udev: Adding input device TPPS/2 IBM TrackPoint (/dev/input/mouse2)

-andy

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.19.0 (adi@t440s) (gcc version 4.9.2 (Debian 4.9.2-5) ) #30 SMP Tue Mar 3 14:42:01 PST 2015
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-3.19.0 root=/dev/mapper/t440s-root ro
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000009bfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009c000-0x000000000009cfff] reserved
[    0.000000] BIOS-e820: [mem 0x000000000009d000-0x000000000009dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x00000000000bffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000cf34cfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cf34d000-0x00000000cf54efff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000cf54f000-0x00000000da41bfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000da41c000-0x00000000da61bfff] type 20
[    0.000000] BIOS-e820: [mem 0x00000000da61c000-0x00000000dcd22fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000dcd23000-0x00000000dce7efff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000dce7f000-0x00000000dcefefff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000dceff000-0x00000000dcefffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000dcf00000-0x00000000df9fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f80f8000-0x00000000f80f8fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe101000-0x00000000fe112fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000021e5fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.31 by Lenovo
[    0.000000] efi:  ACPI=0xdcefe000  ACPI 2.0=0xdcefe014  SMBIOS=0xdcd22000 
[    0.000000] efi: mem00: [Conventional Memory|   |  |  |  |   |WB|WT|WC|UC] range=[0x0000000000000000-0x0000000000058000) (0MB)
[    0.000000] efi: mem01: [Reserved           |   |  |  |  |   |WB|WT|WC|UC] range=[0x0000000000058000-0x0000000000059000) (0MB)
[    0.000000] efi: mem02: [Conventional Memory|   |  |  |  |   |WB|WT|WC|UC] range=[0x0000000000059000-0x000000000009c000) (0MB)
[    0.000000] efi: mem03: [Reserved           |   |  |  |  |   |WB|WT|WC|UC] range=[0x000000000009c000-0x000000000009d000) (0MB)
[    0.000000] efi: mem04: [Boot Data          |   |  |  |  |   |WB|WT|WC|UC] range=[0x000000000009d000-0x000000000009e000) (0MB)
[    0.000000] efi: mem05: [Reserved           |   |  |  |  |   |WB|WT|WC|UC] range=[0x000000000009e000-0x00000000000a0000) (0MB)
[    0.000000] efi: mem06: [Loader Data        |   |  |  |  |   |WB|WT|WC|UC] range=[0x0000000000100000-0x00000000010f4000) (15MB)
[    0.000000] efi: mem07: [Conventional Memory|   |  |  |  |   |WB|WT|WC|UC] range=[0x00000000010f4000-0x0000000002000000) (15MB)
[    0.000000] efi: mem08: [Loader Data        |   |  |  |  |   |WB|WT|WC|UC] range=[0x0000000002000000-0x0000000002ff4000) (15MB)
[    0.000000] efi: mem09: [Conventional Memory|   |  |  |  |   |WB|WT|WC|UC] range=[0x0000000002ff4000-0x0000000036fa8000) (831MB)
[    0.000000] efi: mem10: [Loader Data        |   |  |  |  |   |WB|WT|WC|UC] range=[0x0000000036fa8000-0x00000000377cc000) (8MB)
[    0.000000] efi: mem11: [Conventional Memory|   |  |  |  |   |WB|WT|WC|UC] range=[0x00000000377cc000-0x00000000983c1000) (1547MB)
[    0.000000] efi: mem12: [Loader Data        |   |  |  |  |   |WB|WT|WC|UC] range=[0x00000000983c1000-0x00000000cd7d9000) (852MB)
[    0.000000] efi: mem13: [Boot Data          |   |  |  |  |   |WB|WT|WC|UC] range=[0x00000000cd7d9000-0x00000000cd7f9000) (0MB)
[    0.000000] efi: mem14: [Conventional Memory|   |  |  |  |   |WB|WT|WC|UC] range=[0x00000000cd7f9000-0x00000000cf336000) (27MB)
[    0.000000] efi: mem15: [Boot Data          |   |  |  |  |   |WB|WT|WC|UC] range=[0x00000000cf336000-0x00000000cf34d000) (0MB)
[    0.000000] efi: mem16: [Reserved           |   |  |  |  |   |WB|WT|WC|UC] range=[0x00000000cf34d000-0x00000000cf54f000) (2MB)
[    0.000000] efi: mem17: [Boot Data          |   |  |  |  |   |WB|WT|WC|UC] range=[0x00000000cf54f000-0x00000000d07c9000) (18MB)
[    0.000000] efi: mem18: [Conventional Memory|   |  |  |  |   |WB|WT|WC|UC] range=[0x00000000d07c9000-0x00000000d09ea000) (2MB)
[    0.000000] efi: mem19: [Loader Code        |   |  |  |  |   |WB|WT|WC|UC] range=[0x00000000d09ea000-0x00000000d0a08000) (0MB)
[    0.000000] efi: mem20: [Conventional Memory|   |  |  |  |   |WB|WT|WC|UC] range=[0x00000000d0a08000-0x00000000d2b82000) (33MB)
[    0.000000] efi: mem21: [Boot Data          |   |  |  |  |   |WB|WT|WC|UC] range=[0x00000000d2b82000-0x00000000d4dc8000) (34MB)
[    0.000000] efi: mem22: [Conventional Memory|   |  |  |  |   |WB|WT|WC|UC] range=[0x00000000d4dc8000-0x00000000d4ddd000) (0MB)
[    0.000000] efi: mem23: [Boot Data          |   |  |  |  |   |WB|WT|WC|UC] range=[0x00000000d4ddd000-0x00000000d641c000) (22MB)
[    0.000000] efi: mem24: [Conventional Memory|   |  |  |  |   |WB|WT|WC|UC] range=[0x00000000d641c000-0x00000000d9eb3000) (58MB)
[    0.000000] efi: mem25: [Loader Data        |   |  |  |  |   |WB|WT|WC|UC] range=[0x00000000d9eb3000-0x00000000d9ebc000) (0MB)
[    0.000000] efi: mem26: [Boot Code          |   |  |  |  |   |WB|WT|WC|UC] range=[0x00000000d9ebc000-0x00000000da41c000) (5MB)
[    0.000000] efi: mem27: [Runtime Code       |RUN|  |  |  |   |WB|WT|WC|UC] range=[0x00000000da41c000-0x00000000da61c000) (2MB)
[    0.000000] efi: mem28: [Runtime Data       |RUN|  |  |  |   |WB|WT|WC|UC] range=[0x00000000da61c000-0x00000000db3f5000) (13MB)
[    0.000000] efi: mem29: [Reserved           |   |  |  |  |   |WB|WT|WC|UC] range=[0x00000000db3f5000-0x00000000dcd23000) (25MB)
[    0.000000] efi: mem30: [ACPI Memory NVS    |   |  |  |  |   |WB|WT|WC|UC] range=[0x00000000dcd23000-0x00000000dce7f000) (1MB)
[    0.000000] efi: mem31: [ACPI Reclaim Memory|   |  |  |  |   |WB|WT|WC|UC] range=[0x00000000dce7f000-0x00000000dceff000) (0MB)
[    0.000000] efi: mem32: [Boot Data          |   |  |  |  |   |WB|WT|WC|UC] range=[0x00000000dceff000-0x00000000dcf00000) (0MB)
[    0.000000] efi: mem33: [Conventional Memory|   |  |  |  |   |WB|WT|WC|UC] range=[0x0000000100000000-0x000000021e600000) (4582MB)
[    0.000000] efi: mem34: [Reserved           |   |  |  |  |   |  |  |  |  ] range=[0x00000000000a0000-0x00000000000c0000) (0MB)
[    0.000000] efi: mem35: [Reserved           |   |  |  |  |   |  |  |  |  ] range=[0x00000000dcf00000-0x00000000dfa00000) (43MB)
[    0.000000] efi: mem36: [Memory Mapped I/O  |RUN|  |  |  |   |  |  |  |UC] range=[0x00000000f80f8000-0x00000000f80f9000) (0MB)
[    0.000000] efi: mem37: [Reserved           |   |  |  |  |   |  |  |  |  ] range=[0x00000000fe101000-0x00000000fe113000) (0MB)
[    0.000000] efi: mem38: [Memory Mapped I/O  |RUN|  |  |  |   |  |  |  |UC] range=[0x00000000fed1c000-0x00000000fed20000) (0MB)
[    0.000000] efi: mem39: [Reserved           |   |  |  |  |   |  |  |  |  ] range=[0x0000000000000000-0x0000000000000000) (0MB)
[    0.000000] efi: mem40: [Reserved           |   |  |  |  |   |  |  |  |  ] range=[0x0000000000000000-0x0000000000000000) (0MB)
[    0.000000] efi: mem41: [Reserved           |   |  |  |  |   |  |  |  |  ] range=[0x0000000000000000-0x0000000000000000) (0MB)
[    0.000000] efi: mem42: [Reserved           |   |  |  |  |   |  |  |  |  ] range=[0x0000000000000000-0x0000000000000000) (0MB)
[    0.000000] efi: mem43: [Reserved           |   |  |  |  |   |  |  |  |  ] range=[0x0000000000000000-0x0000000000000000) (0MB)
[    0.000000] efi: mem44: [Reserved           |   |  |  |  |   |  |  |  |  ] range=[0x0000000000000000-0x0000000000000000) (0MB)
[    0.000000] efi: mem45: [Reserved           |   |  |  |  |   |  |  |  |  ] range=[0x0000000000000000-0x0000000000000000) (0MB)
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: LENOVO 20AQCTO1WW/20AQCTO1WW, BIOS GJET61WW (2.11 ) 10/02/2013
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] AGP: No AGP bridge found
[    0.000000] e820: last_pfn = 0x21e600 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: write-back
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 00E0000000 mask 7FE0000000 uncachable
[    0.000000]   1 base 00DE000000 mask 7FFE000000 uncachable
[    0.000000]   2 base 00DD000000 mask 7FFF000000 uncachable
[    0.000000]   3 base 00DCF00000 mask 7FFFF00000 uncachable
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] PAT configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- UC  
[    0.000000] e820: last_pfn = 0xdcf00 max_arch_pfn = 0x400000000
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [ffff880000096000] 96000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] BRK [0x02969000, 0x02969fff] PGTABLE
[    0.000000] BRK [0x0296a000, 0x0296afff] PGTABLE
[    0.000000] BRK [0x0296b000, 0x0296bfff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x21e400000-0x21e5fffff]
[    0.000000]  [mem 0x21e400000-0x21e5fffff] page 2M
[    0.000000] BRK [0x0296c000, 0x0296cfff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x200000000-0x21e3fffff]
[    0.000000]  [mem 0x200000000-0x21e3fffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x1e0000000-0x1ffffffff]
[    0.000000]  [mem 0x1e0000000-0x1ffffffff] page 1G
[    0.000000] init_memory_mapping: [mem 0x00100000-0xcf34cfff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0x3fffffff] page 2M
[    0.000000]  [mem 0x40000000-0xbfffffff] page 1G
[    0.000000]  [mem 0xc0000000-0xcf1fffff] page 2M
[    0.000000]  [mem 0xcf200000-0xcf34cfff] page 4k
[    0.000000] init_memory_mapping: [mem 0xcf54f000-0xda41bfff]
[    0.000000]  [mem 0xcf54f000-0xcf5fffff] page 4k
[    0.000000]  [mem 0xcf600000-0xda3fffff] page 2M
[    0.000000]  [mem 0xda400000-0xda41bfff] page 4k
[    0.000000] BRK [0x0296d000, 0x0296dfff] PGTABLE
[    0.000000] BRK [0x0296e000, 0x0296efff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0xdceff000-0xdcefffff]
[    0.000000]  [mem 0xdceff000-0xdcefffff] page 4k
[    0.000000] init_memory_mapping: [mem 0x100000000-0x1dfffffff]
[    0.000000]  [mem 0x100000000-0x1dfffffff] page 1G
[    0.000000] RAMDISK: [mem 0x36fa8000-0x377cbfff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000DCEFE014 000024 (v02 LENOVO)
[    0.000000] ACPI: XSDT 0x00000000DCEFE170 0000F4 (v01 LENOVO TP-GJ    00002110 PTEC 00000002)
[    0.000000] ACPI: FACP 0x00000000DCEF9000 00010C (v05 LENOVO TP-GJ    00002110 PTEC 00000002)
[    0.000000] ACPI: DSDT 0x00000000DCEE3000 010B3E (v01 LENOVO TP-GJ    00002110 INTL 20120711)
[    0.000000] ACPI: FACS 0x00000000DCE4A000 000040
[    0.000000] ACPI: DBGP 0x00000000DCEFC000 000034 (v01 LENOVO TP-GJ    00002110 PTEC 00000002)
[    0.000000] ACPI: ECDT 0x00000000DCEFB000 000052 (v01 LENOVO TP-GJ    00002110 PTEC 00000002)
[    0.000000] ACPI: HPET 0x00000000DCEF8000 000038 (v01 LENOVO TP-GJ    00002110 PTEC 00000002)
[    0.000000] ACPI: APIC 0x00000000DCEF7000 000098 (v01 LENOVO TP-GJ    00002110 PTEC 00000002)
[    0.000000] ACPI: MCFG 0x00000000DCEF6000 00003C (v01 LENOVO TP-GJ    00002110 PTEC 00000002)
[    0.000000] ACPI: SSDT 0x00000000DCEF5000 000033 (v01 LENOVO TP-SSDT1 00000100 INTL 20120711)
[    0.000000] ACPI: SSDT 0x00000000DCEF4000 00044F (v01 LENOVO TP-SSDT2 00000200 INTL 20120711)
[    0.000000] ACPI: SSDT 0x00000000DCEE2000 0009CB (v01 LENOVO SataAhci 00001000 INTL 20120711)
[    0.000000] ACPI: SSDT 0x00000000DCEE1000 000152 (v01 LENOVO Rmv_Batt 00001000 INTL 20120711)
[    0.000000] ACPI: SSDT 0x00000000DCEE0000 0007D4 (v01 LENOVO Cpu0Ist  00003000 INTL 20120711)
[    0.000000] ACPI: SSDT 0x00000000DCEDF000 000AD8 (v01 LENOVO CpuPm    00003000 INTL 20120711)
[    0.000000] ACPI: SSDT 0x00000000DCEDD000 001215 (v01 LENOVO SaSsdt   00003000 INTL 20120711)
[    0.000000] ACPI: SSDT 0x00000000DCEDC000 000379 (v01 LENOVO CppcTabl 00001000 INTL 20120711)
[    0.000000] ACPI: PCCT 0x00000000DCEDB000 00006E (v05 LENOVO TP-GJ    00002110 PTEC 00000002)
[    0.000000] ACPI: SSDT 0x00000000DCEDA000 000AC4 (v01 LENOVO Cpc_Tabl 00001000 INTL 20120711)
[    0.000000] ACPI: TCPA 0x00000000DCED9000 000032 (v02 PTL    LENOVO   06040000 LNVO 00000001)
[    0.000000] ACPI: UEFI 0x00000000DCED8000 000042 (v01 LENOVO TP-GJ    00002110 PTEC 00000002)
[    0.000000] ACPI: MSDM 0x00000000DCDB2000 000055 (v03 LENOVO TP-GJ    00002110 PTEC 00000002)
[    0.000000] ACPI: ASF! 0x00000000DCEFD000 0000A5 (v32 LENOVO TP-GJ    00002110 PTEC 00000002)
[    0.000000] ACPI: BATB 0x00000000DCED7000 000046 (v01 LENOVO TP-GJ    00002110 PTEC 00000002)
[    0.000000] ACPI: FPDT 0x00000000DCED6000 000064 (v01 LENOVO TP-GJ    00002110 PTEC 00000002)
[    0.000000] ACPI: UEFI 0x00000000DCED5000 0002E2 (v01 LENOVO TP-GJ    00002110 PTEC 00000002)
[    0.000000] ACPI: SSDT 0x00000000DCED4000 00047F (v01 LENOVO IsctTabl 00001000 INTL 20120711)
[    0.000000] ACPI: BGRT 0x00000000DCED3000 000038 (v01 LENOVO TP-GJ    00002110 PTEC 00000002)
[    0.000000] ACPI: DMAR 0x00000000DCED2000 0000B0 (v01 LENOVO TP-GJ    00002110 PTEC 00000002)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000021e5fffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x21e5f8000-0x21e5fcfff]
[    0.000000]  [ffffea0000000000-ffffea00087fffff] PMD -> [ffff880215c00000-ffff88021dbfffff] on node 0
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00001000-0x00ffffff]
[    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
[    0.000000]   Normal   [mem 0x100000000-0x21e5fffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00001000-0x00057fff]
[    0.000000]   node   0: [mem 0x00059000-0x0009bfff]
[    0.000000]   node   0: [mem 0x0009d000-0x0009dfff]
[    0.000000]   node   0: [mem 0x00100000-0xcf34cfff]
[    0.000000]   node   0: [mem 0xcf54f000-0xda41bfff]
[    0.000000]   node   0: [mem 0xdceff000-0xdcefffff]
[    0.000000]   node   0: [mem 0x100000000-0x21e5fffff]
[    0.000000] Initmem setup node 0 [mem 0x00001000-0x21e5fffff]
[    0.000000] On node 0 totalpages: 2066358
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 23 pages reserved
[    0.000000]   DMA zone: 3995 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 13897 pages used for memmap
[    0.000000]   DMA32 zone: 889371 pages, LIFO batch:31
[    0.000000]   Normal zone: 18328 pages used for memmap
[    0.000000]   Normal zone: 1172992 pages, LIFO batch:31
[    0.000000] Reserving Intel graphics stolen memory at 0xdda00000-0xdf9fffff
[    0.000000] ACPI: PM-Timer IO Port: 0x1808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-39
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a301 base: 0xfed00000
[    0.000000] smpboot: Allowing 8 CPUs, 4 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x00058000-0x00058fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009c000-0x0009cfff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x000bffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000c0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xcf34d000-0xcf54efff]
[    0.000000] PM: Registered nosave memory: [mem 0xda41c000-0xda61bfff]
[    0.000000] PM: Registered nosave memory: [mem 0xda61c000-0xdcd22fff]
[    0.000000] PM: Registered nosave memory: [mem 0xdcd23000-0xdce7efff]
[    0.000000] PM: Registered nosave memory: [mem 0xdce7f000-0xdcefefff]
[    0.000000] PM: Registered nosave memory: [mem 0xdcf00000-0xdf9fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xdfa00000-0xf80f7fff]
[    0.000000] PM: Registered nosave memory: [mem 0xf80f8000-0xf80f8fff]
[    0.000000] PM: Registered nosave memory: [mem 0xf80f9000-0xfe100fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfe101000-0xfe112fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfe113000-0xfed1bfff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed20000-0xffffffff]
[    0.000000] e820: [mem 0xdfa00000-0xf80f7fff] available for PCI devices
[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:8 nr_node_ids:1
[    0.000000] PERCPU: Embedded 29 pages/cpu @ffff88021e200000 s80192 r8192 d30400 u262144
[    0.000000] pcpu-alloc: s80192 r8192 d30400 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 2034046
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-3.19.0 root=/dev/mapper/t440s-root ro
[    0.000000] log_buf_len individual max cpu contribution: 131072 bytes
[    0.000000] log_buf_len total cpu_extra contributions: 917504 bytes
[    0.000000] log_buf_len min size: 1048576 bytes
[    0.000000] log_buf_len: 2097152 bytes
[    0.000000] early log buf free: 1029232(98%)
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] xsave: enabled xstate_bv 0x7, cntxt size 0x340 using standard form
[    0.000000] AGP: Checking aperture...
[    0.000000] AGP: No AGP bridge found
[    0.000000] Memory: 7964436K/8265432K available (3764K kernel code, 821K rwdata, 1476K rodata, 1020K init, 1624K bss, 300996K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] 	Additional per-CPU info printed with stalls.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=8.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.000000] NR_IRQS:33024 nr_irqs:760 16
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2693.824 MHz processor
[    0.000011] Calibrating delay loop (skipped), value calculated using timer frequency.. 5387.64 BogoMIPS (lpj=10775296)
[    0.000018] pid_max: default: 32768 minimum: 301
[    0.000024] ACPI: Core revision 20141107
[    0.017844] ACPI: All ACPI Tables successfully acquired
[    0.059721] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.061507] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.062245] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.062259] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.062495] Initializing cgroup subsys memory
[    0.062502] Initializing cgroup subsys devices
[    0.062506] Initializing cgroup subsys freezer
[    0.062509] Initializing cgroup subsys net_cls
[    0.062513] Initializing cgroup subsys blkio
[    0.062516] Initializing cgroup subsys perf_event
[    0.062520] Initializing cgroup subsys net_prio
[    0.062523] Initializing cgroup subsys hugetlb
[    0.062550] CPU: Physical Processor ID: 0
[    0.062552] CPU: Processor Core ID: 0
[    0.062558] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.063628] mce: CPU supports 7 MCE banks
[    0.063642] CPU0: Thermal monitoring enabled (TM1)
[    0.063655] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 1024
Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 1024, 1GB 4
[    0.063755] Freeing SMP alternatives memory: 12K (ffffffff817ce000 - ffffffff817d1000)
[    0.066967] ftrace: allocating 18769 entries in 74 pages
[    0.074991] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.114665] smpboot: CPU0: Intel(R) Core(TM) i7-4600U CPU @ 2.10GHz (fam: 06, model: 45, stepping: 01)
[    0.114674] TSC deadline timer enabled
[    0.114699] Performance Events: PEBS fmt2+, 16-deep LBR, Haswell events, full-width counters, Intel PMU driver.
[    0.114724] ... version:                3
[    0.114726] ... bit width:              48
[    0.114728] ... generic registers:      4
[    0.114730] ... value mask:             0000ffffffffffff
[    0.114733] ... max period:             0000ffffffffffff
[    0.114735] ... fixed-purpose events:   3
[    0.114737] ... event mask:             000000070000000f
[    0.115033] x86: Booting SMP configuration:
[    0.115036] .... node  #0, CPUs:      #1
[    0.129447] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.129533]  #2 #3
[    0.158074] x86: Booted up 1 node, 4 CPUs
[    0.158080] smpboot: Total of 4 processors activated (21550.59 BogoMIPS)
[    0.162433] devtmpfs: initialized
[    0.166717] PM: Registering ACPI NVS region [mem 0xdcd23000-0xdce7efff] (1425408 bytes)
[    0.166911] prandom: seed boundary self test passed
[    0.167457] prandom: 100 self tests passed
[    0.167645] NET: Registered protocol family 16
[    0.178236] cpuidle: using governor ladder
[    0.190235] cpuidle: using governor menu
[    0.190272] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.190276] ACPI: bus type PCI registered
[    0.190427] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.190432] PCI: not using MMCONFIG
[    0.190435] PCI: Using configuration type 1 for base access
[    0.206644] ACPI: Added _OSI(Module Device)
[    0.206648] ACPI: Added _OSI(Processor Device)
[    0.206650] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.206652] ACPI: Added _OSI(Processor Aggregator Device)
[    0.208552] ACPI : EC: EC description table is found, configuring boot EC
[    0.214189] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.216124] ACPI: Dynamic OEM Table Load:
[    0.216141] ACPI: SSDT 0xFFFF880214B08800 000436 (v01 PmRef  Cpu0Cst  00003001 INTL 20120711)
[    0.216834] ACPI: Dynamic OEM Table Load:
[    0.216848] ACPI: SSDT 0xFFFF880214B09000 0005AA (v01 PmRef  ApIst    00003000 INTL 20120711)
[    0.217599] ACPI: Dynamic OEM Table Load:
[    0.217611] ACPI: SSDT 0xFFFF880214598000 000119 (v01 PmRef  ApCst    00003000 INTL 20120711)
[    0.218696] ACPI: Interpreter enabled
[    0.218707] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_] (20141107/hwxface-580)
[    0.218716] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20141107/hwxface-580)
[    0.218734] ACPI: (supports S0 S3 S4 S5)
[    0.218737] ACPI: Using IOAPIC for interrupt routing
[    0.218754] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.219116] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in ACPI motherboard resources
[    0.219183] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.221510] ACPI: Power Resource [PUBS] (on)
[    0.222154] acpi PNP0C0A:01: ACPI dock station (docks/bays count: 1)
[    0.225522] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
[    0.225582] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
[    0.225639] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
[    0.225694] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
[    0.225750] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
[    0.225805] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
[    0.225860] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
[    0.225914] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
[    0.225978] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3f])
[    0.225985] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.226094] acpi PNP0A08:00: _OSC: platform does not support [PCIeCapability]
[    0.226143] acpi PNP0A08:00: _OSC: not requesting control; platform does not support [PCIeCapability]
[    0.226148] acpi PNP0A08:00: _OSC: OS requested [PCIeHotplug PME AER PCIeCapability]
[    0.226152] acpi PNP0A08:00: _OSC: platform willing to grant [PCIeHotplug PME AER]
[    0.226155] acpi PNP0A08:00: _OSC failed (AE_SUPPORT); disabling ASPM
[    0.226214] PCI host bridge to bus 0000:00
[    0.226218] pci_bus 0000:00: root bus resource [bus 00-3f]
[    0.226221] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
[    0.226224] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
[    0.226228] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
[    0.226231] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000c3fff]
[    0.226240] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7fff]
[    0.226246] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000cbfff]
[    0.226249] pci_bus 0000:00: root bus resource [mem 0x000cc000-0x000cffff]
[    0.226252] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3fff]
[    0.226255] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff]
[    0.226259] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff]
[    0.226262] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff]
[    0.226265] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3fff]
[    0.226268] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7fff]
[    0.226271] pci_bus 0000:00: root bus resource [mem 0x000e8000-0x000ebfff]
[    0.226274] pci_bus 0000:00: root bus resource [mem 0x000ec000-0x000effff]
[    0.226277] pci_bus 0000:00: root bus resource [mem 0xdfa00000-0xfebfffff]
[    0.226280] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed4bfff]
[    0.226290] pci 0000:00:00.0: [8086:0a04] type 00 class 0x060000
[    0.226376] pci 0000:00:02.0: [8086:0a16] type 00 class 0x030000
[    0.226388] pci 0000:00:02.0: reg 0x10: [mem 0xf0000000-0xf03fffff 64bit]
[    0.226396] pci 0000:00:02.0: reg 0x18: [mem 0xe0000000-0xefffffff 64bit pref]
[    0.226401] pci 0000:00:02.0: reg 0x20: [io  0x3000-0x303f]
[    0.226482] pci 0000:00:03.0: [8086:0a0c] type 00 class 0x040300
[    0.226491] pci 0000:00:03.0: reg 0x10: [mem 0xf0630000-0xf0633fff 64bit]
[    0.226593] pci 0000:00:14.0: [8086:9c31] type 00 class 0x0c0330
[    0.226611] pci 0000:00:14.0: reg 0x10: [mem 0xf0620000-0xf062ffff 64bit]
[    0.226669] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.226696] pci 0000:00:14.0: System wakeup disabled by ACPI
[    0.226742] pci 0000:00:16.0: [8086:9c3a] type 00 class 0x078000
[    0.226762] pci 0000:00:16.0: reg 0x10: [mem 0xf0639000-0xf063901f 64bit]
[    0.226831] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.226902] pci 0000:00:19.0: [8086:155a] type 00 class 0x020000
[    0.226918] pci 0000:00:19.0: reg 0x10: [mem 0xf0600000-0xf061ffff]
[    0.226925] pci 0000:00:19.0: reg 0x14: [mem 0xf063e000-0xf063efff]
[    0.226933] pci 0000:00:19.0: reg 0x18: [io  0x3080-0x309f]
[    0.226991] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    0.227018] pci 0000:00:19.0: System wakeup disabled by ACPI
[    0.227063] pci 0000:00:1b.0: [8086:9c20] type 00 class 0x040300
[    0.227077] pci 0000:00:1b.0: reg 0x10: [mem 0xf0634000-0xf0637fff 64bit]
[    0.227143] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.227178] pci 0000:00:1b.0: System wakeup disabled by ACPI
[    0.227220] pci 0000:00:1c.0: [8086:9c1a] type 01 class 0x060400
[    0.227286] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.227355] pci 0000:00:1c.1: [8086:9c14] type 01 class 0x060400
[    0.227429] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.227460] pci 0000:00:1c.1: System wakeup disabled by ACPI
[    0.227510] pci 0000:00:1d.0: [8086:9c26] type 00 class 0x0c0320
[    0.227530] pci 0000:00:1d.0: reg 0x10: [mem 0xf063d000-0xf063d3ff]
[    0.227619] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.227651] pci 0000:00:1d.0: System wakeup disabled by ACPI
[    0.227695] pci 0000:00:1f.0: [8086:9c43] type 00 class 0x060100
[    0.227862] pci 0000:00:1f.2: [8086:9c03] type 00 class 0x010601
[    0.227876] pci 0000:00:1f.2: reg 0x10: [io  0x30a8-0x30af]
[    0.227883] pci 0000:00:1f.2: reg 0x14: [io  0x30b4-0x30b7]
[    0.227890] pci 0000:00:1f.2: reg 0x18: [io  0x30a0-0x30a7]
[    0.227897] pci 0000:00:1f.2: reg 0x1c: [io  0x30b0-0x30b3]
[    0.227904] pci 0000:00:1f.2: reg 0x20: [io  0x3060-0x307f]
[    0.227911] pci 0000:00:1f.2: reg 0x24: [mem 0xf063c000-0xf063c7ff]
[    0.227947] pci 0000:00:1f.2: PME# supported from D3hot
[    0.228007] pci 0000:00:1f.3: [8086:9c22] type 00 class 0x0c0500
[    0.228020] pci 0000:00:1f.3: reg 0x10: [mem 0xf0638000-0xf06380ff 64bit]
[    0.228039] pci 0000:00:1f.3: reg 0x20: [io  0xefa0-0xefbf]
[    0.228178] pci 0000:02:00.0: [10ec:5227] type 00 class 0xff0000
[    0.228201] pci 0000:02:00.0: reg 0x10: [mem 0xf0500000-0xf0500fff]
[    0.228341] pci 0000:02:00.0: supports D1 D2
[    0.228343] pci 0000:02:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.238260] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.238267] pci 0000:00:1c.0:   bridge window [mem 0xf0500000-0xf05fffff]
[    0.238485] pci 0000:03:00.0: [8086:08b2] type 00 class 0x028000
[    0.238572] pci 0000:03:00.0: reg 0x10: [mem 0xf0400000-0xf0401fff 64bit]
[    0.238862] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    0.250406] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.250413] pci 0000:00:1c.1:   bridge window [mem 0xf0400000-0xf04fffff]
[    0.251421] ACPI: Enabled 4 GPEs in block 00 to 7F
[    0.251484] ACPI : EC: GPE = 0x25, I/O: command/status = 0x66, data = 0x62
[    0.251570] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=mem,locks=none
[    0.251575] vgaarb: loaded
[    0.251577] vgaarb: setting as boot device: PCI:0000:00:02.0
[    0.251580] vgaarb: bridge control possible 0000:00:02.0
[    0.251689] PCI: Using ACPI for IRQ routing
[    0.252998] PCI: pci_cache_line_size set to 64 bytes
[    0.253329] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
[    0.253331] e820: reserve RAM buffer [mem 0x0009c000-0x0009ffff]
[    0.253332] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[    0.253334] e820: reserve RAM buffer [mem 0xcf34d000-0xcfffffff]
[    0.253335] e820: reserve RAM buffer [mem 0xda41c000-0xdbffffff]
[    0.253337] e820: reserve RAM buffer [mem 0xdcf00000-0xdfffffff]
[    0.253339] e820: reserve RAM buffer [mem 0x21e600000-0x21fffffff]
[    0.253496] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.253505] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.255534] Switched to clocksource hpet
[    0.261145] pnp: PnP ACPI init
[    0.261473] system 00:00: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.261478] system 00:00: [mem 0x000f0000-0x000fffff] could not be reserved
[    0.261482] system 00:00: [mem 0x00100000-0xdf9fffff] could not be reserved
[    0.261486] system 00:00: [mem 0xfec00000-0xfed3ffff] could not be reserved
[    0.261489] system 00:00: [mem 0xfed4c000-0xffffffff] has been reserved
[    0.261494] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.261605] system 00:01: [io  0x1800-0x189f] could not be reserved
[    0.261610] system 00:01: [io  0x0800-0x087f] has been reserved
[    0.261613] system 00:01: [io  0x0880-0x08ff] has been reserved
[    0.261616] system 00:01: [io  0x0900-0x097f] has been reserved
[    0.261619] system 00:01: [io  0x0980-0x09ff] has been reserved
[    0.261622] system 00:01: [io  0x0a00-0x0a7f] has been reserved
[    0.261625] system 00:01: [io  0x0a80-0x0aff] has been reserved
[    0.261629] system 00:01: [io  0x0b00-0x0b7f] has been reserved
[    0.261632] system 00:01: [io  0x0b80-0x0bff] has been reserved
[    0.261635] system 00:01: [io  0x15e0-0x15ef] has been reserved
[    0.261638] system 00:01: [io  0x1600-0x167f] has been reserved
[    0.261641] system 00:01: [io  0x1640-0x165f] has been reserved
[    0.261645] system 00:01: [mem 0xf8000000-0xfbffffff] could not be reserved
[    0.261649] system 00:01: [mem 0x00000000-0x00000fff] could not be reserved
[    0.261652] system 00:01: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.261656] system 00:01: [mem 0xfed10000-0xfed13fff] has been reserved
[    0.261659] system 00:01: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.261662] system 00:01: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.261666] system 00:01: [mem 0xfed45000-0xfed4bfff] has been reserved
[    0.261670] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.261728] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.261755] pnp 00:03: Plug and Play ACPI device, IDs LEN0071 PNP0303 (active)
[    0.261782] pnp 00:04: Plug and Play ACPI device, IDs LEN0036 PNP0f13 (active)
[    0.261825] pnp 00:05: Plug and Play ACPI device, IDs SMO1200 PNP0c31 (active)
[    0.262248] pnp: PnP ACPI: found 6 devices
[    0.268648] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.268655] pci 0000:00:1c.0:   bridge window [mem 0xf0500000-0xf05fffff]
[    0.268664] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.268669] pci 0000:00:1c.1:   bridge window [mem 0xf0400000-0xf04fffff]
[    0.268679] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    0.268681] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    0.268683] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    0.268685] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff]
[    0.268687] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff]
[    0.268688] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff]
[    0.268690] pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff]
[    0.268692] pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff]
[    0.268694] pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff]
[    0.268695] pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff]
[    0.268697] pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff]
[    0.268699] pci_bus 0000:00: resource 15 [mem 0x000e0000-0x000e3fff]
[    0.268701] pci_bus 0000:00: resource 16 [mem 0x000e4000-0x000e7fff]
[    0.268702] pci_bus 0000:00: resource 17 [mem 0x000e8000-0x000ebfff]
[    0.268704] pci_bus 0000:00: resource 18 [mem 0x000ec000-0x000effff]
[    0.268706] pci_bus 0000:00: resource 19 [mem 0xdfa00000-0xfebfffff]
[    0.268708] pci_bus 0000:00: resource 20 [mem 0xfed40000-0xfed4bfff]
[    0.268710] pci_bus 0000:02: resource 1 [mem 0xf0500000-0xf05fffff]
[    0.268712] pci_bus 0000:03: resource 1 [mem 0xf0400000-0xf04fffff]
[    0.268745] NET: Registered protocol family 2
[    0.268971] TCP established hash table entries: 65536 (order: 7, 524288 bytes)
[    0.269129] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.269251] TCP: Hash tables configured (established 65536 bind 65536)
[    0.269271] TCP: reno registered
[    0.269287] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    0.269318] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    0.269381] NET: Registered protocol family 1
[    0.269399] pci 0000:00:02.0: Video device with shadowed ROM
[    0.269821] PCI: CLS 64 bytes, default 64
[    0.269864] Unpacking initramfs...
[    0.439174] Freeing initrd memory: 8336K (ffff880036fa8000 - ffff8800377cc000)
[    0.439189] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.439193] software IO TLB [mem 0xc97d9000-0xcd7d9000] (64MB) mapped at [ffff8800c97d9000-ffff8800cd7d8fff]
[    0.439405] RAPL PMU detected, hw unit 2^-14 Joules, API unit is 2^-32 Joules, 4 fixed counters 655360 ms ovfl timer
[    0.439463] Scanning for low memory corruption every 60 seconds
[    0.439843] futex hash table entries: 2048 (order: 5, 131072 bytes)
[    0.439878] audit: initializing netlink subsys (disabled)
[    0.439895] audit: type=2000 audit(1425692128.436:1): initialized
[    0.440112] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.441923] VFS: Disk quotas dquot_6.5.2
[    0.441966] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.442269] bounce: pool size: 64 pages
[    0.442311] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.442354] io scheduler noop registered
[    0.442361] io scheduler deadline registered
[    0.442404] io scheduler cfq registered (default)
[    0.442681] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.442701] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    0.442720] efifb: probing for efifb
[    0.442738] efifb: framebuffer at 0xe0000000, mapped to 0xffffc90004f00000, using 8128k, total 8128k
[    0.442742] efifb: mode is 1920x1080x32, linelength=7680, pages=1
[    0.442744] efifb: scrolling: redraw
[    0.442747] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.449841] Console: switching to colour frame buffer device 240x67
[    0.456852] fb0: EFI VGA frame buffer device
[    0.456884] intel_idle: MWAIT substates: 0x11142120
[    0.456886] intel_idle: v0.4 model 0x45
[    0.456887] intel_idle: lapic_timer_reliable_states 0xffffffff
[    0.457192] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.457641] Linux agpgart interface v0.103
[    0.457739] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    0.459809] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.459862] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.460019] mousedev: PS/2 mouse device common for all mice
[    0.460088] rtc_cmos 00:02: RTC can wake from S4
[    0.460270] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
[    0.460329] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    0.460515] TCP: cubic registered
[    0.460706] NET: Registered protocol family 10
[    0.461020] NET: Registered protocol family 17
[    0.461060] Key type dns_resolver registered
[    0.461255] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    0.461738] registered taskstats version 1
[    0.462298] rtc_cmos 00:02: setting system clock to 2015-03-07 01:35:28 UTC (1425692128)
[    0.462420] PM: Hibernation image not present or could not be loaded.
[    0.462640] Freeing unused kernel memory: 1020K (ffffffff816cf000 - ffffffff817ce000)
[    0.462683] Write protecting the kernel read-only data: 6144k
[    0.462935] Freeing unused kernel memory: 320K (ffff8800023b0000 - ffff880002400000)
[    0.463130] Freeing unused kernel memory: 572K (ffff880002571000 - ffff880002600000)
[    0.497538] systemd-udevd[75]: starting version 215
[    0.497888] random: systemd-udevd urandom read with 4 bits of entropy available
[    0.512886] pps_core: LinuxPPS API ver. 1 registered
[    0.512940] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.513238] thermal LNXTHERM:00: registered as thermal_zone0
[    0.513268] PTP clock support registered
[    0.513334] ACPI: Thermal Zone [THM0] (52 C)
[    0.514349] e1000e: Intel(R) PRO/1000 Network Driver - 2.3.2-k
[    0.514383] e1000e: Copyright(c) 1999 - 2014 Intel Corporation.
[    0.514479] rtsx_pci 0000:02:00.0: rtsx_pci_acquire_irq: pcr->msi_en = 1, pci->irq = 40
[    0.514538] e1000e 0000:00:19.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    0.514818] ACPI: bus type USB registered
[    0.514887] usbcore: registered new interface driver usbfs
[    0.514951] usbcore: registered new interface driver hub
[    0.515035] usbcore: registered new device driver usb
[    0.516141] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.516345] ehci-pci: EHCI PCI platform driver
[    0.522611] SCSI subsystem initialized
[    0.523927] libata version 3.00 loaded.
[    0.529581] AVX2 version of gcm_enc/dec engaged.
[    0.529627] AES CTR mode by8 optimization enabled
[    0.679652] e1000e 0000:00:19.0 eth0: registered PHC clock
[    0.681276] e1000e 0000:00:19.0 eth0: (PCI Express:2.5GT/s:Width x1) 28:d2:44:34:db:4f
[    0.682873] e1000e 0000:00:19.0 eth0: Intel(R) PRO/1000 Network Connection
[    0.684491] e1000e 0000:00:19.0 eth0: MAC: 11, PHY: 12, PBA No: 1000FF-0FF
[    0.686236] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.687885] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    0.689540] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    0.689621] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    0.691204] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.692794] usb usb1: Product: xHCI Host Controller
[    0.694366] usb usb1: Manufacturer: Linux 3.19.0 xhci-hcd
[    0.695934] usb usb1: SerialNumber: 0000:00:14.0
[    0.697717] hub 1-0:1.0: USB hub found
[    0.699264] hub 1-0:1.0: 9 ports detected
[    0.702763] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.704321] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    0.705917] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[    0.707489] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.709054] usb usb2: Product: xHCI Host Controller
[    0.710618] usb usb2: Manufacturer: Linux 3.19.0 xhci-hcd
[    0.712169] usb usb2: SerialNumber: 0000:00:14.0
[    0.713835] hub 2-0:1.0: USB hub found
[    0.715359] hub 2-0:1.0: 4 ports detected
[    0.717923] ehci-pci 0000:00:1d.0: EHCI Host Controller
[    0.719645] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 3
[    0.721173] ehci-pci 0000:00:1d.0: debug port 2
[    0.726570] ehci-pci 0000:00:1d.0: cache line size of 64 is not supported
[    0.726585] ehci-pci 0000:00:1d.0: irq 23, io mem 0xf063d000
[    0.739402] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    0.740928] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[    0.742411] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.743894] usb usb3: Product: EHCI Host Controller
[    0.745380] usb usb3: Manufacturer: Linux 3.19.0 ehci_hcd
[    0.746861] usb usb3: SerialNumber: 0000:00:1d.0
[    0.748493] hub 3-0:1.0: USB hub found
[    0.749997] hub 3-0:1.0: 3 ports detected
[    0.751646] ahci 0000:00:1f.2: version 3.0
[    0.767438] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 3 ports 6 Gbps 0x5 impl SATA mode
[    0.768939] ahci 0000:00:1f.2: flags: 64bit ncq pm led clo only pio slum part deso sadm sds apst 
[    0.770928] scsi host0: ahci
[    0.772571] scsi host1: ahci
[    0.774179] scsi host2: ahci
[    0.775705] ata1: SATA max UDMA/133 abar m2048@0xf063c000 port 0xf063c100 irq 43
[    0.777177] ata2: DUMMY
[    0.778621] ata3: SATA max UDMA/133 abar m2048@0xf063c000 port 0xf063c200 irq 43
[    1.011349] usb 1-3: new high-speed USB device number 2 using xhci_hcd
[    1.027537] usb 2-3: new SuperSpeed USB device number 2 using xhci_hcd
[    1.045037] usb 2-3: New USB device found, idVendor=17ef, idProduct=1010
[    1.046501] usb 2-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.047945] usb 2-3: Product: Lenovo ThinkPad Dock   
[    1.049369] usb 2-3: Manufacturer: LENOVO                 
[    1.051201] hub 2-3:1.0: USB hub found
[    1.052719] hub 2-3:1.0: 4 ports detected
[    1.063301] usb 3-1: new high-speed USB device number 2 using ehci-pci
[    1.099312] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.100719] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.102382] ata3.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
[    1.102386] ata3.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
[    1.104660] ata3.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
[    1.107127] ata3.00: ACPI cmd ef/10:09:00:00:00:a0 (SET FEATURES) succeeded
[    1.107585] ata3.00: ATA-9: SanDisk SSD U110 16GB, U219001, max UDMA/133
[    1.109537] ata3.00: 31277232 sectors, multi 1: LBA48 NCQ (depth 31/32)
[    1.111847] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
[    1.111852] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
[    1.113950] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
[    1.116633] ata3.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
[    1.116639] ata3.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
[    1.118960] ata3.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
[    1.120543] ata1.00: failed to get NCQ Send/Recv Log Emask 0x1
[    1.120547] ata1.00: ATA-9: Samsung SSD 840 EVO 500GB, EXT0BB0Q, max UDMA/133
[    1.122869] ata1.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    1.125214] ata3.00: ACPI cmd ef/10:09:00:00:00:a0 (SET FEATURES) succeeded
[    1.125538] ata3.00: configured for UDMA/133
[    1.127181] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
[    1.127186] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
[    1.128598] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
[    1.130185] ata1.00: failed to get NCQ Send/Recv Log Emask 0x1
[    1.130189] ata1.00: configured for UDMA/133
[    1.131838] scsi 0:0:0:0: Direct-Access     ATA      Samsung SSD 840  BB0Q PQ: 0 ANSI: 5
[    1.133721] scsi 2:0:0:0: Direct-Access     ATA      SanDisk SSD U110 001  PQ: 0 ANSI: 5
[    1.137108] sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/465 GiB)
[    1.137158] sd 2:0:0:0: [sdb] 31277232 512-byte logical blocks: (16.0 GB/14.9 GiB)
[    1.137236] sd 2:0:0:0: [sdb] Write Protect is off
[    1.137239] sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    1.137270] sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.139878]  sdb: sdb1 sdb2 sdb3
[    1.140444] sd 2:0:0:0: [sdb] Attached SCSI disk
[    1.145807] sd 0:0:0:0: [sda] Write Protect is off
[    1.147186] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.147197] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.150381]  sda: sda1 sda2 sda3
[    1.152172] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.154116] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    1.155664] sd 2:0:0:0: Attached scsi generic sg1 type 0
[    1.195585] usb 3-1: New USB device found, idVendor=8087, idProduct=8000
[    1.197542] usb 3-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.200145] hub 3-1:1.0: USB hub found
[    1.201829] hub 3-1:1.0: 8 ports detected
[    1.203231] usb 1-3: New USB device found, idVendor=17ef, idProduct=1010
[    1.204632] usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.206034] usb 1-3: Product: Lenovo ThinkPad Dock   
[    1.207449] usb 1-3: Manufacturer: LENOVO                 
[    1.209574] hub 1-3:1.0: USB hub found
[    1.211593] hub 1-3:1.0: 4 ports detected
[    1.232636] device-mapper: uevent: version 1.0.3
[    1.234194] device-mapper: ioctl: 4.29.0-ioctl (2014-10-28) initialised: dm-devel@redhat.com
[    1.387219] usb 1-6: new full-speed USB device number 3 using xhci_hcd
[    1.435185] tsc: Refined TSC clocksource calibration: 2693.761 MHz
[    1.516396] usb 1-6: New USB device found, idVendor=138a, idProduct=0017
[    1.516400] usb 1-6: New USB device strings: Mfr=0, Product=0, SerialNumber=1
[    1.516402] usb 1-6: SerialNumber: 5119ca0a6c85
[    1.599313] usb 1-3.4: new high-speed USB device number 4 using xhci_hcd
[    1.699432] usb 1-3.4: New USB device found, idVendor=17ef, idProduct=100f
[    1.699436] usb 1-3.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    1.699438] usb 1-3.4: Product: Lenovo ThinkPad Dock
[    1.699440] usb 1-3.4: Manufacturer: Lenovo
[    1.699441] usb 1-3.4: SerialNumber: Rev1.2
[    1.699835] hub 1-3.4:1.0: USB hub found
[    1.699856] hub 1-3.4:1.0: 3 ports detected
[    1.811063] usb 1-7: new full-speed USB device number 5 using xhci_hcd
[    1.940219] usb 1-7: New USB device found, idVendor=8087, idProduct=07dc
[    1.940224] usb 1-7: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.011016] usb 1-3.4.3: new low-speed USB device number 6 using xhci_hcd
[    2.102854] usb 1-3.4.3: New USB device found, idVendor=0461, idProduct=4e22
[    2.102858] usb 1-3.4.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.102860] usb 1-3.4.3: Product: USB Optical Mouse
[    2.102862] usb 1-3.4.3: Manufacturer: PixArt
[    2.103098] usb 1-3.4.3: ep 0x81 - rounding interval to 64 microframes, ep desc says 80 microframes
[    2.104698] hidraw: raw HID events driver (C) Jiri Kosina
[    2.106506] usbcore: registered new interface driver usbhid
[    2.106508] usbhid: USB HID core driver
[    2.106987] input: PixArt USB Optical Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.4/1-3.4.3/1-3.4.3:1.0/0003:0461:4E22.0001/input/input2
[    2.107100] hid-generic 0003:0461:4E22.0001: input,hidraw0: USB HID v1.11 Mouse [PixArt USB Optical Mouse] on usb-0000:00:14.0-3.4.3/input0
[    2.210920] usb 1-8: new high-speed USB device number 7 using xhci_hcd
[    2.434953] Switched to clocksource tsc
[    2.463199] usb 1-8: New USB device found, idVendor=5986, idProduct=026a
[    2.463204] usb 1-8: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.463206] usb 1-8: Product: Integrated Camera
[    2.463207] usb 1-8: Manufacturer: SunplusIT INC.
[    5.938393] usb 2-3.2: new SuperSpeed USB device number 3 using xhci_hcd
[    5.954363] usb 2-3.2: New USB device found, idVendor=152d, idProduct=0567
[    5.954368] usb 2-3.2: New USB device strings: Mfr=10, Product=11, SerialNumber=3
[    5.954370] usb 2-3.2: Product: USB to ATA/ATAPI Bridge
[    5.954372] usb 2-3.2: Manufacturer: JMicron
[    5.954373] usb 2-3.2: SerialNumber: 00A12345678D
[    5.956107] usb-storage 2-3.2:1.0: USB Mass Storage device detected
[    5.956184] usb-storage 2-3.2:1.0: Quirks match for vid 152d pid 0567: 4000000
[    5.956211] scsi host3: usb-storage 2-3.2:1.0
[    5.956325] usbcore: registered new interface driver usb-storage
[    6.953557] scsi 3:0:0:0: Direct-Access     ST1000LM 024 HN-M101MBB   0C02 PQ: 0 ANSI: 6
[    6.953915] sd 3:0:0:0: Attached scsi generic sg2 type 0
[    6.954069] sd 3:0:0:0: [sdc] 1953525168 512-byte logical blocks: (1.00 TB/931 GiB)
[    6.954311] sd 3:0:0:0: [sdc] Write Protect is off
[    6.954316] sd 3:0:0:0: [sdc] Mode Sense: 3b 00 10 08
[    6.954545] sd 3:0:0:0: [sdc] No Caching mode page found
[    6.954547] sd 3:0:0:0: [sdc] Assuming drive cache: write through
[    6.983122]  sdc: sdc1
[    6.984124] sd 3:0:0:0: [sdc] Attached SCSI disk
[    8.231553] NET: Registered protocol family 38
[    8.390923] PM: Starting manual resume from disk
[    8.392424] PM: Hibernation image partition 254:2 present
[    8.392425] PM: Looking for hibernation image.
[    8.392582] PM: Image not found (code -22)
[    8.392583] PM: Hibernation image not present or could not be loaded.
[    8.436681] EXT4-fs (dm-1): mounted filesystem with ordered data mode. Opts: (null)
[    8.499279] random: nonblocking pool is initialized
[    8.528727] systemd[1]: systemd 215 running in system mode. (+PAM +AUDIT +SELINUX +IMA +SYSVINIT +LIBCRYPTSETUP +GCRYPT +ACL +XZ -SECCOMP -APPARMOR)
[    8.530526] systemd[1]: Detected architecture 'x86-64'.
[    8.549377] systemd[1]: Inserted module 'autofs4'
[    8.551279] systemd[1]: Set hostname to <t440s>.
[    8.649249] systemd[1]: Starting Forward Password Requests to Wall Directory Watch.
[    8.650951] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    8.652607] systemd[1]: Starting Remote File Systems (Pre).
[    8.655917] systemd[1]: Reached target Remote File Systems (Pre).
[    8.657548] systemd[1]: Starting Dispatch Password Requests to Console Directory Watch.
[    8.659205] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    8.660848] systemd[1]: Expecting device dev-disk-by\x2duuid-175881f6\x2d4f68\x2d490d\x2d8490\x2d97d8ed31016f.device...
[    8.664276] systemd[1]: Expecting device dev-mapper-sda3_crypt.device...
[    8.667752] systemd[1]: Starting Arbitrary Executable File Formats File System Automount Point.
[    8.671375] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    8.673145] systemd[1]: Expecting device dev-mapper-t440s\x2dswap_1.device...
[    8.676749] systemd[1]: Expecting device dev-disk-by\x2duuid-B23B\x2dF4EE.device...
[    8.680399] systemd[1]: Expecting device dev-disk-by\x2duuid-1a944c1b\x2dace1\x2d442d\x2da3a6\x2d13d21e789aa2.device...
[    8.684194] systemd[1]: Starting Root Slice.
[    8.693591] systemd[1]: Created slice Root Slice.
[    8.695488] systemd[1]: Starting /dev/initctl Compatibility Named Pipe.
[    8.699385] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
[    8.701318] systemd[1]: Starting Delayed Shutdown Socket.
[    8.705235] systemd[1]: Listening on Delayed Shutdown Socket.
[    8.707169] systemd[1]: Starting Journal Socket (/dev/log).
[    8.711136] systemd[1]: Listening on Journal Socket (/dev/log).
[    8.713187] systemd[1]: Starting Syslog Socket.
[    8.717118] systemd[1]: Listening on Syslog Socket.
[    8.719029] systemd[1]: Starting Device-mapper event daemon FIFOs.
[    8.723659] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    8.725560] systemd[1]: Starting LVM2 metadata daemon socket.
[    8.729433] systemd[1]: Listening on LVM2 metadata daemon socket.
[    8.731353] systemd[1]: Starting User and Session Slice.
[    8.735366] systemd[1]: Created slice User and Session Slice.
[    8.737310] systemd[1]: Starting udev Control Socket.
[    8.741227] systemd[1]: Listening on udev Control Socket.
[    8.743154] systemd[1]: Starting udev Kernel Socket.
[    8.747057] systemd[1]: Listening on udev Kernel Socket.
[    8.748978] systemd[1]: Starting Journal Socket.
[    8.752831] systemd[1]: Listening on Journal Socket.
[    8.754723] systemd[1]: Starting System Slice.
[    8.758592] systemd[1]: Created slice System Slice.
[    8.760440] systemd[1]: Starting File System Check on Root Device...
[    8.764515] systemd[1]: Starting system-systemd\x2dfsck.slice.
[    8.768532] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[    8.770368] systemd[1]: Mounting Huge Pages File System...
[    8.774480] systemd[1]: Starting system-systemd\x2dcryptsetup.slice.
[    8.778600] systemd[1]: Created slice system-systemd\x2dcryptsetup.slice.
[    8.780592] systemd[1]: Starting udev Coldplug all Devices...
[    8.786049] systemd[1]: Started Set Up Additional Binary Formats.
[    8.790578] systemd[1]: Starting Load Kernel Modules...
[    8.796135] systemd[1]: Mounting POSIX Message Queue File System...
[    8.800201] fuse init (API version 7.23)
[    8.802608] systemd[1]: Starting Create list of required static device nodes for the current kernel...
[    8.806356] loop: module loaded
[    8.809056] systemd[1]: Mounting Debug File System...
[    8.813103] systemd[1]: Starting system-getty.slice.
[    8.817050] systemd[1]: Created slice system-getty.slice.
[    8.818811] systemd[1]: Starting Journal Service...
[    8.824345] systemd[1]: Started Journal Service.
[    8.897711] systemd-udevd[270]: starting version 215
[    9.021226] [drm] Initialized drm 1.1.0 20060810
[    9.021227] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input3
[    9.021680] ACPI: Lid Switch [LID]
[    9.021759] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input4
[    9.021762] ACPI: Power Button [PWRF]
[    9.029350] ACPI: Deprecated procfs I/F for AC is loaded, please retry with CONFIG_ACPI_PROCFS_POWER cleared
[    9.029578] ACPI: AC Adapter [AC] (on-line)
[    9.031461] Non-volatile memory driver v1.3
[    9.037279] thinkpad_acpi: ThinkPad ACPI Extras v0.25
[    9.037892] tpm_tis 00:05: 1.2 TPM (device-id 0x0, rev-id 78)
[    9.040723] thinkpad_acpi: http://ibm-acpi.sf.net/
[    9.042470] thinkpad_acpi: ThinkPad BIOS GJET61WW (2.11 ), EC unknown
[    9.043056] ACPI: Deprecated procfs I/F for battery is loaded, please retry with CONFIG_ACPI_PROCFS_POWER cleared
[    9.043060] ACPI: Battery Slot [BAT0] (battery present)
[    9.047506] thinkpad_acpi: Lenovo ThinkPad T440s, model 20AQCTO1WW
[    9.047600] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    9.051766] i915 0000:00:02.0: enabling device (0006 -> 0007)
[    9.055605] [drm] Memory usable by graphics device = 2048M
[    9.057078] thinkpad_acpi: Unsupported brightness interface, please contact ibm-acpi-devel@lists.sourceforge.net
[    9.057100] thinkpad_acpi: radio switch found; radios are enabled
[    9.057193] thinkpad_acpi: This ThinkPad has standard ACPI backlight brightness control, supported by the ACPI video driver
[    9.057194] thinkpad_acpi: Disabling thinkpad-acpi brightness events by default...
[    9.064987] sound hdaudioC1D0: autoconfig: line_outs=1 (0x16/0x0/0x0/0x0/0x0) type:line
[    9.065476] checking generic (e0000000 7f0000) vs hw (e0000000 10000000)
[    9.065477] fb: switching to inteldrmfb from EFI VGA
[    9.066080] ACPI: Deprecated procfs I/F for battery is loaded, please retry with CONFIG_ACPI_PROCFS_POWER cleared
[    9.066084] ACPI: Battery Slot [BAT1] (battery present)
[    9.068076] thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio is unblocked
[    9.068967] cfg80211: Calling CRDA to update world regulatory domain
[    9.070696] input: ThinkPad Extra Buttons as /devices/platform/thinkpad_acpi/input/input5
[    9.076479] Intel(R) Wireless WiFi driver for Linux, in-tree:d
[    9.076480] Copyright(c) 2003- 2014 Intel Corporation
[    9.079343] iwlwifi 0000:03:00.0: Direct firmware load for iwlwifi-7260-12.ucode failed with error -2
[    9.079354] iwlwifi 0000:03:00.0: Direct firmware load for iwlwifi-7260-11.ucode failed with error -2
[    9.079362] iwlwifi 0000:03:00.0: Direct firmware load for iwlwifi-7260-10.ucode failed with error -2
[    9.079364] iwlwifi 0000:03:00.0: request for firmware file 'iwlwifi-7260-10.ucode' failed.
[    9.079785] EFI Variables Facility v0.08 2004-May-17
[    9.082263] iwlwifi 0000:03:00.0: Firmware has old API version, expected v10 through v12, got v9.
[    9.082264] iwlwifi 0000:03:00.0: New firmware can be obtained from http://www.intellinuxwireless.org/.
[    9.082496] iwlwifi 0000:03:00.0: loaded firmware version 23.214.9.0 op_mode iwlmvm
[    9.085845] input: PC Speaker as /devices/platform/pcspkr/input/input6
[    9.086856] Error: Driver 'pcspkr' is already registered, aborting...
[    9.100386] tpm_tis 00:05: TPM is disabled/deactivated (0x6)
[    9.108148] sound hdaudioC1D0:    speaker_outs=1 (0x14/0x0/0x0/0x0/0x0)
[    9.108150] sound hdaudioC1D0:    hp_outs=1 (0x15/0x0/0x0/0x0/0x0)
[    9.108151] sound hdaudioC1D0:    mono: mono_out=0x0
[    9.108152] sound hdaudioC1D0:    inputs:
[    9.109300] Console: switching to colour dummy device 80x25
[    9.109449] [drm] Replacing VGA console driver
[    9.109925] sound hdaudioC1D0:      Dock Mic=0x19
[    9.109929] sound hdaudioC1D0:      Mic=0x1a
[    9.109931] sound hdaudioC1D0:      Internal Mic=0x12
[    9.110145] iwlwifi 0000:03:00.0: Detected Intel(R) Dual Band Wireless AC 7260, REV=0x144
[    9.110551] iwlwifi 0000:03:00.0: L1 Enabled - LTR Enabled
[    9.111112] iwlwifi 0000:03:00.0: L1 Enabled - LTR Enabled
[    9.130577] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/sound/card1/hdaudioC1D0/input8
[    9.131148] input: HDA Intel PCH Dock Mic as /devices/pci0000:00/0000:00:1b.0/sound/card1/input9
[    9.131223] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1b.0/sound/card1/input10
[    9.131296] input: HDA Intel PCH Dock Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card1/input11
[    9.131370] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card1/input12
[    9.144423] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    9.144430] [drm] Driver supports precise vblank timestamp query.
[    9.144511] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=mem
[    9.218129] ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
[    9.219817] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input13
[    9.219923] [drm] Initialized i915 1.6.0 20141121 for 0000:00:02.0 on minor 0
[    9.220079] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[    9.235984] Adding 8265724k swap on /dev/mapper/t440s-swap_1.  Priority:-1 extents:1 across:8265724k SS
[    9.241169] input: HDA Intel HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:03.0/sound/card0/input14
[    9.241246] input: HDA Intel HDMI HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:03.0/sound/card0/input15
[    9.241316] input: HDA Intel HDMI HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:03.0/sound/card0/input16
[    9.247443] media: Linux media interface: v0.10
[    9.250447] Linux video capture interface: v2.00
[    9.259817] uvcvideo: Found UVC 1.00 device Integrated Camera (5986:026a)
[    9.268393] input: Integrated Camera as /devices/pci0000:00/0000:00:14.0/usb1/1-8/1-8:1.0/input/input17
[    9.268467] usbcore: registered new interface driver uvcvideo
[    9.268471] USB Video Class driver (1.1.1)
[    9.274233] cfg80211: World regulatory domain updated:
[    9.274241] cfg80211:  DFS Master region: unset
[    9.274244] cfg80211:   (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp), (dfs_cac_time)
[    9.274249] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (N/A, 2000 mBm), (N/A)
[    9.274253] cfg80211:   (2457000 KHz - 2482000 KHz @ 40000 KHz), (N/A, 2000 mBm), (N/A)
[    9.274256] cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz), (N/A, 2000 mBm), (N/A)
[    9.274261] cfg80211:   (5170000 KHz - 5250000 KHz @ 80000 KHz, 160000 KHz AUTO), (N/A, 2000 mBm), (N/A)
[    9.274265] cfg80211:   (5250000 KHz - 5330000 KHz @ 80000 KHz, 160000 KHz AUTO), (N/A, 2000 mBm), (0 s)
[    9.274270] cfg80211:   (5490000 KHz - 5730000 KHz @ 160000 KHz), (N/A, 2000 mBm), (0 s)
[    9.274274] cfg80211:   (5735000 KHz - 5835000 KHz @ 80000 KHz), (N/A, 2000 mBm), (N/A)
[    9.274277] cfg80211:   (57240000 KHz - 63720000 KHz @ 2160000 KHz), (N/A, 0 mBm), (N/A)
[    9.324262] [drm] GMBUS [i915 gmbus dpb] timed out, falling back to bit banging on pin 5
[    9.347808] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
[    9.362415] fbcon: inteldrmfb (fb0) is primary device
[    9.392429] Bluetooth: Core ver 2.20
[    9.392441] NET: Registered protocol family 31
[    9.392442] Bluetooth: HCI device and connection manager initialized
[    9.392445] Bluetooth: HCI socket layer initialized
[    9.392446] Bluetooth: L2CAP socket layer initialized
[    9.392452] Bluetooth: SCO socket layer initialized
[    9.397669] usbcore: registered new interface driver btusb
[    9.415589] Bluetooth: hci0: read Intel version: 370710018002030d37
[    9.415590] Bluetooth: hci0: Intel device is already patched. patch num: 37
[    9.544439] psmouse serio1: synaptics: Touchpad model: 1, fw: 8.1, id: 0x1e2b1, caps: 0xd001a3/0x940300/0x127c00, board id: 2668, fw id: 1293989
[    9.544446] psmouse serio1: synaptics: serio: Synaptics pass-through port at isa0060/serio1/input0
[    9.584360] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input7
[   10.465202] [drm:intel_set_cpu_fifo_underrun_reporting [i915]] *ERROR* uncleared fifo underrun on pipe B
[   10.465275] [drm:intel_cpu_fifo_underrun_irq_handler [i915]] *ERROR* CPU pipe B FIFO underrun
[   10.498188] Console: switching to colour frame buffer device 240x67
[   10.512901] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[   10.512903] i915 0000:00:02.0: registered panic notifier
[   10.550070] EXT4-fs (dm-1): re-mounted. Opts: errors=remount-ro
[   10.592023] FAT-fs (sda1): utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
[   10.647146] systemd-journald[259]: Received request to flush runtime journal from PID 1
[   10.923794] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   11.913451] [drm:intel_set_cpu_fifo_underrun_reporting [i915]] *ERROR* uncleared fifo underrun on pipe B
[   11.916779] [drm:intel_cpu_fifo_underrun_irq_handler [i915]] *ERROR* CPU pipe B FIFO underrun
[   13.550704] psmouse serio2: trackpoint: IBM TrackPoint firmware: 0x0e, buttons: 3/3
[   13.763295] input: TPPS/2 IBM TrackPoint as /devices/platform/i8042/serio1/serio2/input/input18
[   14.460200] e1000e: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
[   14.463664] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   18.683615] RPC: Registered named UNIX socket transport module.
[   18.685908] RPC: Registered udp transport module.
[   18.688108] RPC: Registered tcp transport module.
[   18.690492] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   18.712561] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   18.871384] vboxdrv: Found 4 processor cores.
[   18.873751] vboxdrv: fAsync=0 offMin=0x1e3 offMax=0x10ad
[   18.877147] vboxdrv: TSC mode is 'synchronous', kernel timer mode is 'normal'.
[   18.878412] vboxdrv: Successfully loaded version 4.3.18_Debian (interface 0x001a0008).
[   18.908852] vboxpci: pci-stub module not available, cannot detach PCI devices
[   18.910017] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   18.910017] Bluetooth: BNEP filters: protocol multicast
[   18.910021] Bluetooth: BNEP socket layer initialized
[   18.914664] vboxpci: IOMMU not found (not compiled)
