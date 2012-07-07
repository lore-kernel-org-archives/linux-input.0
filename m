From: littlebat <dashing.meng@gmail.com>
Subject: Bug#679750: Lenovo G360: ALPS Touchpad Recognized as "PS/2 Generic
	Mouse"(with newly dmesg information)
Date: Sat, 7 Jul 2012 13:35:19 +0800
Message-ID: <20120707133519.25bf82d4.dashing.meng@gmail.com>
References: <20120706113942.40152322.dashing.meng@gmail.com>
	<20120706051141.GA2937@thinkpad-t410>
Reply-To: littlebat <dashing.meng@gmail.com>, 679750@bugs.debian.org
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Sat__7_Jul_2012_13_35_19_+0800_amjr5p9Y4..xlEyg"
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.679750.B679750.134163824329843@bugs.debian.org>
In-Reply-To: <20120706051141.GA2937@thinkpad-t410>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: Seth Forshee <seth.forshee@canonical.com>
Cc: linux-input@vger.kernel.org, 679750@bugs.debian.org, jrnieder@gmail.com, rik.theys@gmail.com
List-Id: linux-input@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Sat__7_Jul_2012_13_35_19_+0800_amjr5p9Y4..xlEyg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Jul 2012 00:11:41 -0500
Seth Forshee <seth.forshee@canonical.com> wrote:

> On Fri, Jul 06, 2012 at 11:39:42AM +0800, littlebat wrote:
> > I found these lines in my dmesg information:
> > [   19.995850] psmouse serio4: alps: E6 report: 00 00 64
> > [   20.021288] psmouse serio4: alps: E7 report: 73 03 50
> > [   20.623609] input: PS/2 Generic Mouse
> > as /devices/platform/i8042/serio4/input/input9
> 
> Thanks, this is the information we need to check whether or not your
> touchpad uses any of the known ALPS protocols.
> 
> I'm attaching a patch to use as a starting point. Basically we're just
> going to try each protocol version until either we find one that works
> or run out of options. You should have an external mouse available,
> because it's likely that your touchpad will not be usable. I've also
> heard that some of the workarounds that people use to get the "disable
> touchpad while typing" behavior can cause the touchpad to no longer
> function once it starts behaving as a touchpad, so you should look out
> for that as well.
> 
> I won't be able to respond further until next Monday, but it's pretty
> simple to modify the driver to try different protocol versions so I'll
> give you some instructions. The patch adds the following line. I've
> identified the two fields you'll need to change.
> 
>     { { 0x73, 0x03, 0x50 }, 0x8a, ALPS_PROTO_V4, 0x8f, 0x8f, 0 },
>                               ^         ^
>                               |         |
>                     command_mode_resp   |
>                                   proto_version
> 
> Not surprisingly, to try different protocol versions you just need to
> change the proto_version field. Try ALPS_PROTO_V4 first, if that
> doesn't work try ALPS_PROTO_V3, etc., until you've tried them all or
> found one that works.
> 
> The first time you run the patch though you need to be on the lookout
> for a message in dmesg that says "Unknown command mode response"
> followed by two hex digits. If you see this then you need to change
> command_mode_resp to match the response printed in the message. Be
> sure to leave the 0x characters in place; only replace the 8a
> characters. Then try the same protocol version again.
> 
> The basic test procedure after booting with a test version of the
> driver is:
> 
>  1. Check dmesg for any errors from the alps driver. If you see
> anything other than the "Unknown command mode response" message then
> it probably means your touchpad doesn't use that protocol version, so
>     you should move on to the next one. If the device name isn't
> showing up as something with ALPS in it, that also indicates your
> device isn't using that version.
> 
>  2. Thoroughly test the touchpad. You may see erratic behavior -- the
>     pointer jumping around, random clicks, etc -- which means it's
> using a different protocol.
> 
> If you find a protocol version that works, let me know and I'll help
> get it added to the driver. If you don't then there's not much more I
> can do to help without hardware.

Thanks.

I have changed "proto_version" from V4 to V1, and changed
"command_mode_resp" to 0x73(followed by unknown response while entering
command mode: 73 01 0d) or 0x8a, 0x00, etc.. But, none of them works.

Briefly, "proto_version" V4 with "command_mode_resp" 0x00, 0x01, 0x73,
0x0d and V3 with 0x0d, 0x73, show the almost same symptoms:
1, dmesg output:
[   19.105550] psmouse serio4: alps: E6 report: 00 00 64
[   19.130028] psmouse serio4: alps: E7 report: 73 03 50
[   19.149304] psmouse serio4: alps: unknown response while entering
command mode: 73 01 0d 
[   19.149311] psmouse serio4: alps: touchpad failed to enter command
mode
2, xinput --list shows it is a "PS/2 Generic Mouse"
3, No "touchpad" found in "Xorg.0.log" except "PS/2 Generic Mouse"
4, No touchpad tab in gnome mouse setting dialog.
Detail information see attachments, here is V4 with 0x73:
V4-73-dmesg.txt, V4-73-inputdevices.txt, V4-73-xinputlist.txt,
V4-73-Xorg.0.log

And, V2 or V1 with 0x8a or 0x00, show the almost same symptoms below:
1, dmesg output:
[   19.935069] psmouse serio4: alps: E6 report: 00 00 64
[   19.960457] psmouse serio4: alps: E7 report: 73 03 50
[   20.000732] psmouse serio4: alps: Status: 10 00 0a
[   20.026497] input: PS/2 Mouse
as /devices/platform/i8042/serio4/input/input9 
[   20.042797] input: AlpsPS/2 ALPS GlidePoint
as /devices/platform/i8042/serio4/input/input10
2, xinput --list shows there are "AlpsPS/2 ALPS GlidePoint" and "PS/2
Mouse"
3, Xorg.0.log shows:
[    30.225] (--) AlpsPS/2 ALPS GlidePoint: touchpad found
...
But,
[    30.245] (EE) Query no Synaptics: 6003C8
[    30.245] (--) AlpsPS/2 ALPS GlidePoint: no supported touchpad found
[    30.245] (EE) AlpsPS/2 ALPS GlidePoint Unable to query/initialize
Synaptics hardware. 
[    30.257] (EE) PreInit returned 11 for "AlpsPS/2 ALPS GlidePoint"
4, There is touchpad tab in gnome mouse setting dialog, but the
functions of "edge scrolling" and "disable touchpad when typing" still
can't work even if I can setup them in touchpad tab in gnome mouse
setting dialog.
Detail information see attachments, here is V2 with 0x00:
V2-00-dmesg.txt, V2-00-inputdevices.txt, V2-00-xinputlist.txt,
V2-00-Xorg.0.log

I have also changed "command_mode_resp" and even the other fields I can
find in the alps.c, but no lucky. V4, V3 can't find the touchpad, V2,
V1 can find a touchpad but still can't work.

What's the next step can I do?

Thanks.

PS: I found linux-input@vger.kernel.org archived the posts at
http://www.spinics.net/lists/linux-input/ several hours later after
post even if I hadn't subscribed this mail list at that time. But, it
seems don't archived post with big size attachment(My previous post
"Lenovo G360: ALPS Touchpad Recognized as "PS/2 Generic Mouse"(with
newly dmesg information)" with 6 attachments hasn't been archived after
posting 24h later. )

--Multipart=_Sat__7_Jul_2012_13_35_19_+0800_amjr5p9Y4..xlEyg
Content-Type: text/plain;
 name="V4-73-dmesg.txt"
Content-Disposition: attachment;
 filename="V4-73-dmesg.txt"
Content-Transfer-Encoding: 7bit

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.4.4debugpsmouse (mengdaxing@ldebian) (gcc version 4.4.5 (Debian 4.4.5-8) ) #1 SMP Fri Jul 6 07:44:49 CST 2012
[    0.000000] Command line: root=/dev/sda7 acpi_backlight=vendor ro
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009c400 (usable)
[    0.000000]  BIOS-e820: 000000000009c400 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000dc000 - 00000000000e0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007727c000 (usable)
[    0.000000]  BIOS-e820: 000000007727c000 - 0000000077282000 (reserved)
[    0.000000]  BIOS-e820: 0000000077282000 - 00000000773ee000 (usable)
[    0.000000]  BIOS-e820: 00000000773ee000 - 000000007740f000 (reserved)
[    0.000000]  BIOS-e820: 000000007740f000 - 000000007746f000 (usable)
[    0.000000]  BIOS-e820: 000000007746f000 - 0000000077470000 (reserved)
[    0.000000]  BIOS-e820: 0000000077470000 - 00000000774f1000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000774f1000 - 000000007770f000 (reserved)
[    0.000000]  BIOS-e820: 000000007770f000 - 0000000077717000 (usable)
[    0.000000]  BIOS-e820: 0000000077717000 - 000000007771f000 (reserved)
[    0.000000]  BIOS-e820: 000000007771f000 - 000000007775e000 (usable)
[    0.000000]  BIOS-e820: 000000007775e000 - 000000007779f000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000007779f000 - 00000000777e1000 (usable)
[    0.000000]  BIOS-e820: 00000000777e1000 - 00000000777ff000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000777ff000 - 0000000077800000 (usable)
[    0.000000]  BIOS-e820: 0000000077800000 - 000000007c000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000f0804000 - 00000000f0805000 (reserved)
[    0.000000]  BIOS-e820: 00000000feaff000 - 00000000feb00000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
[    0.000000]  BIOS-e820: 00000000fed1c000 - 00000000fed90000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI present.
[    0.000000] DMI: LENOVO                           G360            /LL1                             , BIOS 61CN06WW   10/27/2011
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> (reserved)
[    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
[    0.000000] No AGP bridge found
[    0.000000] last_pfn = 0x77800 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-D3FFF write-protect
[    0.000000]   D4000-DBFFF uncachable
[    0.000000]   DC000-FFFFF write-through
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 disabled
[    0.000000]   1 base 078000000 mask FF8000000 uncachable
[    0.000000]   2 base 000000000 mask F80000000 write-back
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] found SMP MP-table at [ffff8800000f6200] f6200
[    0.000000] initial memory mapped : 0 - 20000000
[    0.000000] Base memory trampoline at [ffff880000097000] 97000 size 20480
[    0.000000] init_memory_mapping: 0000000000000000-0000000077800000
[    0.000000]  0000000000 - 0077800000 page 2M
[    0.000000] kernel direct mapping tables up to 77800000 @ 1fffd000-20000000
[    0.000000] RAMDISK: 6fc5c000 - 7726c000
[    0.000000] ACPI: RSDP 00000000000f60c0 00024 (v02 PTLTD )
[    0.000000] ACPI: XSDT 00000000777f2fcb 0005C (v01 LENOVO CB-01    06040000  LTP 00000000)
[    0.000000] ACPI: FACP 00000000777e3000 000F4 (v03 LENOVO CB-01    06040000 PTEC 00000001)
[    0.000000] ACPI: DSDT 00000000777e4000 0BBBF (v02 LENOVO CB-01    06040000 INTL 20060912)
[    0.000000] ACPI: FACS 000000007779bfc0 00040
[    0.000000] ACPI: HPET 00000000777fed86 00038 (v01 LENOVO CB-01    06040000 PTEC 00000001)
[    0.000000] ACPI: MCFG 00000000777fedbe 0003C (v01 LENOVO CB-01    06040000 PTEC 00000001)
[    0.000000] ACPI: APIC 00000000777fedfa 00068 (v01 LENOVO CB-01    06040000  LTP 00000000)
[    0.000000] ACPI: BOOT 00000000777fee62 00028 (v01 LENOVO CB-01    06040000  LTP 00000001)
[    0.000000] ACPI: SLIC 00000000777fee8a 00176 (v01 LENOVO CB-01    06040000  LTP 00000000)
[    0.000000] ACPI: SSDT 00000000777e2000 009F1 (v01  PmRef    CpuPm 00003000 INTL 20050624)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-0000000077800000
[    0.000000] Initmem setup node 0 0000000000000000-0000000077800000
[    0.000000]   NODE_DATA [00000000777dd000 - 00000000777e0fff]
[    0.000000]  [ffffea0000000000-ffffea0001bfffff] PMD -> [ffff88006d600000-ffff88006f1fffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   empty
[    0.000000] Movable zone start PFN for each node
[    0.000000] Early memory PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009c
[    0.000000]     0: 0x00000100 -> 0x0007727c
[    0.000000]     0: 0x00077282 -> 0x000773ee
[    0.000000]     0: 0x0007740f -> 0x0007746f
[    0.000000]     0: 0x0007770f -> 0x00077717
[    0.000000]     0: 0x0007771f -> 0x0007775e
[    0.000000]     0: 0x0007779f -> 0x000777e1
[    0.000000]     0: 0x000777ff -> 0x00077800
[    0.000000] On node 0 totalpages: 488542
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 5 pages reserved
[    0.000000]   DMA zone: 3919 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 6636 pages used for memmap
[    0.000000]   DMA32 zone: 477926 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x04] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 40
[    0.000000] PM: Registered nosave memory: 000000000009c000 - 000000000009d000
[    0.000000] PM: Registered nosave memory: 000000000009d000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000dc000
[    0.000000] PM: Registered nosave memory: 00000000000dc000 - 00000000000e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 - 00000000000e4000
[    0.000000] PM: Registered nosave memory: 00000000000e4000 - 0000000000100000
[    0.000000] PM: Registered nosave memory: 000000007727c000 - 0000000077282000
[    0.000000] PM: Registered nosave memory: 00000000773ee000 - 000000007740f000
[    0.000000] PM: Registered nosave memory: 000000007746f000 - 0000000077470000
[    0.000000] PM: Registered nosave memory: 0000000077470000 - 00000000774f1000
[    0.000000] PM: Registered nosave memory: 00000000774f1000 - 000000007770f000
[    0.000000] PM: Registered nosave memory: 0000000077717000 - 000000007771f000
[    0.000000] PM: Registered nosave memory: 000000007775e000 - 000000007779f000
[    0.000000] PM: Registered nosave memory: 00000000777e1000 - 00000000777ff000
[    0.000000] Allocating PCI resources starting at 7c000000 (gap: 7c000000:64000000)
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:2 nr_node_ids:1
[    0.000000] PERCPU: Embedded 28 pages/cpu @ffff88006fa00000 s82304 r8192 d24192 u1048576
[    0.000000] pcpu-alloc: s82304 r8192 d24192 u1048576 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 481845
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: root=/dev/sda7 acpi_backlight=vendor ro
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 1795820k/1957888k available (3581k kernel code, 3720k absent, 158348k reserved, 3112k data, 604k init)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] NR_IRQS:33024 nr_irqs:512 16
[    0.000000] Extended CMOS year: 2000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 7864320 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
[    0.000000] hpet clockevent registered
[    0.000000] Fast TSC calibration using PIT
[    0.004000] Detected 2127.875 MHz processor.
[    0.000002] Calibrating delay loop (skipped), value calculated using timer frequency.. 4255.75 BogoMIPS (lpj=8511500)
[    0.000151] pid_max: default: 32768 minimum: 301
[    0.000262] Security Framework initialized
[    0.000338] AppArmor: AppArmor disabled by boot time parameter
[    0.000550] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.001356] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.001763] Mount-cache hash table entries: 256
[    0.002042] Initializing cgroup subsys cpuacct
[    0.002115] Initializing cgroup subsys memory
[    0.002198] Initializing cgroup subsys devices
[    0.002270] Initializing cgroup subsys freezer
[    0.002341] Initializing cgroup subsys net_cls
[    0.002412] Initializing cgroup subsys blkio
[    0.002488] Initializing cgroup subsys perf_event
[    0.002586] CPU: Physical Processor ID: 0
[    0.002657] CPU: Processor Core ID: 0
[    0.002730] mce: CPU supports 9 MCE banks
[    0.002810] CPU0: Thermal monitoring enabled (TM1)
[    0.002889] using mwait in idle threads.
[    0.003970] ACPI: Core revision 20120320
[    0.023641] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.063387] CPU0: Intel(R) Pentium(R) CPU        P6200  @ 2.13GHz stepping 05
[    0.168637] Performance Events: PEBS fmt1+, 16-deep LBR, Westmere events, Intel PMU driver.
[    0.168914] CPUID marked event: 'bus cycles' unavailable
[    0.168993] ... version:                3
[    0.169065] ... bit width:              48
[    0.169138] ... generic registers:      4
[    0.169212] ... value mask:             0000ffffffffffff
[    0.169288] ... max period:             000000007fffffff
[    0.169369] ... fixed-purpose events:   3
[    0.169442] ... event mask:             000000070000000f
[    0.169669] NMI watchdog: enabled, takes one hw-pmu counter.
[    0.169864] Booting Node   0, Processors  #1 Ok.
[    0.180932] CPU1: Thermal monitoring handled by SMI
[    0.183045] NMI watchdog: enabled, takes one hw-pmu counter.
[    0.183167] Brought up 2 CPUs
[    0.183237] Total of 2 processors activated (8511.50 BogoMIPS).
[    0.184540] devtmpfs: initialized
[    0.188736] PM: Registering ACPI NVS region [mem 0x77470000-0x774f0fff] (528384 bytes)
[    0.188864] PM: Registering ACPI NVS region [mem 0x7775e000-0x7779efff] (266240 bytes)
[    0.189079] dummy: 
[    0.189208] NET: Registered protocol family 16
[    0.189408] ACPI: bus type pci registered
[    0.189562] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.189673] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    0.234956] PCI: Using configuration type 1 for base access
[    0.235661] bio: create slab <bio-0> at 0
[    0.235826] ACPI: Added _OSI(Module Device)
[    0.235905] ACPI: Added _OSI(Processor Device)
[    0.235983] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.236060] ACPI: Added _OSI(Processor Aggregator Device)
[    0.237679] ACPI: EC: Look up EC in DSDT
[    0.245777] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.246332] ACPI: SSDT 000000007771ac18 003AE (v01  PmRef  Cpu0Ist 00003000 INTL 20050624)
[    0.246895] ACPI: Dynamic OEM Table Load:
[    0.247058] ACPI: SSDT           (null) 003AE (v01  PmRef  Cpu0Ist 00003000 INTL 20050624)
[    0.247431] ACPI: SSDT 0000000077718018 00891 (v01  PmRef  Cpu0Cst 00003001 INTL 20050624)
[    0.250461] ACPI: Dynamic OEM Table Load:
[    0.250619] ACPI: SSDT           (null) 00891 (v01  PmRef  Cpu0Cst 00003001 INTL 20050624)
[    0.251168] ACPI: SSDT 0000000077719a98 00303 (v01  PmRef    ApIst 00003000 INTL 20050624)
[    0.251801] ACPI: Dynamic OEM Table Load:
[    0.251962] ACPI: SSDT           (null) 00303 (v01  PmRef    ApIst 00003000 INTL 20050624)
[    0.252320] ACPI: SSDT 0000000077717d98 00119 (v01  PmRef    ApCst 00003000 INTL 20050624)
[    0.252897] ACPI: Dynamic OEM Table Load:
[    0.253057] ACPI: SSDT           (null) 00119 (v01  PmRef    ApCst 00003000 INTL 20050624)
[    0.263407] ACPI: Interpreter enabled
[    0.263483] ACPI: (supports S0 S3 S4 S5)
[    0.263747] ACPI: Using IOAPIC for interrupt routing
[    0.273151] ACPI: EC: GPE = 0x16, I/O: command/status = 0x66, data = 0x62
[    0.273426] ACPI: No dock devices found.
[    0.273505] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.274090] \_SB_.PCI0:_OSC invalid UUID
[    0.274092] _OSC request data:1 8 1f 
[    0.274097] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    0.274921] pci_root PNP0A08:00: host bridge window [io  0x0000-0x0cf7]
[    0.275009] pci_root PNP0A08:00: host bridge window [io  0x0d00-0xffff]
[    0.275090] pci_root PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff]
[    0.275196] pci_root PNP0A08:00: host bridge window [mem 0x000d4000-0x000d7fff]
[    0.275300] pci_root PNP0A08:00: host bridge window [mem 0x000d8000-0x000dbfff]
[    0.275403] pci_root PNP0A08:00: host bridge window [mem 0x000e0000-0x000e3fff]
[    0.275509] pci_root PNP0A08:00: host bridge window [mem 0x7c000000-0xfeafffff]
[    0.275649] PCI host bridge to bus 0000:00
[    0.275724] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
[    0.275807] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
[    0.275889] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
[    0.275972] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff]
[    0.276056] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff]
[    0.276142] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3fff]
[    0.276228] pci_bus 0000:00: root bus resource [mem 0x7c000000-0xfeafffff]
[    0.276319] pci 0000:00:00.0: [8086:0044] type 00 class 0x060000
[    0.276338] DMAR: BIOS has allocated no shadow GTT; disabling IOMMU for graphics
[    0.276463] pci 0000:00:01.0: [8086:0045] type 01 class 0x060400
[    0.276497] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.276512] pci 0000:00:02.0: [8086:0046] type 00 class 0x030000
[    0.276524] pci 0000:00:02.0: reg 10: [mem 0xf0000000-0xf03fffff 64bit]
[    0.276531] pci 0000:00:02.0: reg 18: [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.276537] pci 0000:00:02.0: reg 20: [io  0x1800-0x1807]
[    0.276619] pci 0000:00:1a.0: [8086:3b3c] type 00 class 0x0c0320
[    0.276646] pci 0000:00:1a.0: reg 10: [mem 0xf0806000-0xf08063ff]
[    0.276759] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    0.276795] pci 0000:00:1b.0: [8086:3b56] type 00 class 0x040300
[    0.276816] pci 0000:00:1b.0: reg 10: [mem 0xf0800000-0xf0803fff 64bit]
[    0.276916] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.276948] pci 0000:00:1c.0: [8086:3b42] type 01 class 0x060400
[    0.277053] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.277086] pci 0000:00:1c.1: [8086:3b44] type 01 class 0x060400
[    0.277190] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.277226] pci 0000:00:1c.4: [8086:3b4a] type 01 class 0x060400
[    0.277329] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.277372] pci 0000:00:1d.0: [8086:3b34] type 00 class 0x0c0320
[    0.277398] pci 0000:00:1d.0: reg 10: [mem 0xf0806400-0xf08067ff]
[    0.277511] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.277541] pci 0000:00:1e.0: [8086:2448] type 01 class 0x060401
[    0.277631] pci 0000:00:1f.0: [8086:3b09] type 00 class 0x060100
[    0.277767] pci 0000:00:1f.2: [8086:3b29] type 00 class 0x010601
[    0.277796] pci 0000:00:1f.2: reg 10: [io  0x1818-0x181f]
[    0.277808] pci 0000:00:1f.2: reg 14: [io  0x180c-0x180f]
[    0.277820] pci 0000:00:1f.2: reg 18: [io  0x1810-0x1817]
[    0.277832] pci 0000:00:1f.2: reg 1c: [io  0x1808-0x180b]
[    0.277843] pci 0000:00:1f.2: reg 20: [io  0x1820-0x183f]
[    0.277856] pci 0000:00:1f.2: reg 24: [mem 0xf0805000-0xf08057ff]
[    0.277925] pci 0000:00:1f.2: PME# supported from D3hot
[    0.277952] pci 0000:00:1f.3: [8086:3b30] type 00 class 0x0c0500
[    0.277973] pci 0000:00:1f.3: reg 10: [mem 0xf0806800-0xf08068ff 64bit]
[    0.278005] pci 0000:00:1f.3: reg 20: [io  0x1840-0x185f]
[    0.278058] pci 0000:00:1f.6: [8086:3b32] type 00 class 0x118000
[    0.278087] pci 0000:00:1f.6: reg 10: [mem 0xf0804000-0xf0804fff 64bit]
[    0.278237] pci 0000:01:00.0: [10de:0a70] type 00 class 0x030000
[    0.278252] pci 0000:01:00.0: reg 10: [mem 0xac000000-0xacffffff]
[    0.278269] pci 0000:01:00.0: reg 14: [mem 0xb0000000-0xbfffffff 64bit pref]
[    0.278285] pci 0000:01:00.0: reg 1c: [mem 0xae000000-0xafffffff 64bit pref]
[    0.278297] pci 0000:01:00.0: reg 24: [io  0x2000-0x207f]
[    0.278310] pci 0000:01:00.0: reg 30: [mem 0x00000000-0x0007ffff pref]
[    0.278407] pci 0000:00:01.0: PCI bridge to [bus 01-01]
[    0.278485] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.278488] pci 0000:00:01.0:   bridge window [mem 0xac000000-0xadefffff]
[    0.278492] pci 0000:00:01.0:   bridge window [mem 0xae000000-0xbfffffff 64bit pref]
[    0.278551] pci 0000:00:1c.0: PCI bridge to [bus 02-02]
[    0.278734] pci 0000:03:00.0: [168c:002b] type 00 class 0x028000
[    0.278778] pci 0000:03:00.0: reg 10: [mem 0xf0500000-0xf050ffff 64bit]
[    0.278978] pci 0000:03:00.0: supports D1
[    0.278980] pci 0000:03:00.0: PME# supported from D0 D1 D3hot
[    0.279064] pci 0000:00:1c.1: PCI bridge to [bus 03-03]
[    0.279150] pci 0000:00:1c.1:   bridge window [mem 0xf0500000-0xf05fffff]
[    0.279236] pci 0000:08:00.0: [1969:2060] type 00 class 0x020000
[    0.279266] pci 0000:08:00.0: reg 10: [mem 0xf0400000-0xf043ffff 64bit]
[    0.279282] pci 0000:08:00.0: reg 18: [io  0x3000-0x307f]
[    0.279411] pci 0000:08:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.284612] pci 0000:00:1c.4: PCI bridge to [bus 08-08]
[    0.284705] pci 0000:00:1c.4:   bridge window [io  0x3000-0x3fff]
[    0.284711] pci 0000:00:1c.4:   bridge window [mem 0xf0400000-0xf04fffff]
[    0.284792] pci 0000:00:1e.0: PCI bridge to [bus 0a-0a] (subtractive decode)
[    0.284886] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7] (subtractive decode)
[    0.284889] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff] (subtractive decode)
[    0.284891] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
[    0.284894] pci 0000:00:1e.0:   bridge window [mem 0x000d4000-0x000d7fff] (subtractive decode)
[    0.284897] pci 0000:00:1e.0:   bridge window [mem 0x000d8000-0x000dbfff] (subtractive decode)
[    0.284899] pci 0000:00:1e.0:   bridge window [mem 0x000e0000-0x000e3fff] (subtractive decode)
[    0.284902] pci 0000:00:1e.0:   bridge window [mem 0x7c000000-0xfeafffff] (subtractive decode)
[    0.284932] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.285202] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
[    0.285280] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
[    0.285447] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
[    0.285516] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
[    0.285591] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP05._PRT]
[    0.285739] \_SB_.PCI0:_OSC invalid UUID
[    0.285741] _OSC request data:1 1f 1f 
[    0.285745]  pci0000:00: Requesting ACPI _OSC control (0x1d)
[    0.285865] \_SB_.PCI0:_OSC invalid UUID
[    0.285867] _OSC request data:1 0 1d 
[    0.285871]  pci0000:00: ACPI _OSC request failed (AE_ERROR), returned control mask: 0x1d
[    0.285975] ACPI _OSC control for PCIe not granted, disabling ASPM
[    0.292254] ACPI: PCI Root Bridge [CPBG] (domain 0000 [bus ff])
[    0.292407] PCI host bridge to bus 0000:ff
[    0.292487] pci 0000:ff:00.0: [8086:2c62] type 00 class 0x060000
[    0.292509] pci 0000:ff:00.1: [8086:2d01] type 00 class 0x060000
[    0.292531] pci 0000:ff:02.0: [8086:2d10] type 00 class 0x060000
[    0.292551] pci 0000:ff:02.1: [8086:2d11] type 00 class 0x060000
[    0.292570] pci 0000:ff:02.2: [8086:2d12] type 00 class 0x060000
[    0.292594] pci 0000:ff:02.3: [8086:2d13] type 00 class 0x060000
[    0.292629]  pci0000:ff: Requesting ACPI _OSC control (0x1d)
[    0.292709]  pci0000:ff: ACPI _OSC request failed (AE_NOT_FOUND), returned control mask: 0x1d
[    0.292817] ACPI _OSC control for PCIe not granted, disabling ASPM
[    0.293151] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 12 14 15)
[    0.293782] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
[    0.294473] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 12 14 15)
[    0.295105] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *11 12 14 15)
[    0.295738] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
[    0.296483] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
[    0.297237] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
[    0.297935] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 *11 12 14 15)
[    0.298617] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.298732] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=none,locks=none
[    0.298840] vgaarb: loaded
[    0.298909] vgaarb: bridge control possible 0000:01:00.0
[    0.298989] vgaarb: no bridge control possible 0000:00:02.0
[    0.299098] PCI: Using ACPI for IRQ routing
[    0.309104] PCI: pci_cache_line_size set to 64 bytes
[    0.309201] reserve RAM buffer: 000000000009c400 - 000000000009ffff 
[    0.309203] reserve RAM buffer: 000000007727c000 - 0000000077ffffff 
[    0.309209] reserve RAM buffer: 00000000773ee000 - 0000000077ffffff 
[    0.309214] reserve RAM buffer: 000000007746f000 - 0000000077ffffff 
[    0.309218] reserve RAM buffer: 0000000077717000 - 0000000077ffffff 
[    0.309222] reserve RAM buffer: 000000007775e000 - 0000000077ffffff 
[    0.309225] reserve RAM buffer: 00000000777e1000 - 0000000077ffffff 
[    0.309227] reserve RAM buffer: 0000000077800000 - 0000000077ffffff 
[    0.309364] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.309825] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.311923] Switching to clocksource hpet
[    0.313813] pnp: PnP ACPI init
[    0.313908] ACPI: bus type pnp registered
[    0.314386] pnp 00:00: [bus 00-fe]
[    0.314389] pnp 00:00: [io  0x0000-0x0cf7 window]
[    0.314391] pnp 00:00: [io  0x0cf8-0x0cff]
[    0.314393] pnp 00:00: [io  0x0d00-0xffff window]
[    0.314396] pnp 00:00: [mem 0x000a0000-0x000bffff window]
[    0.314398] pnp 00:00: [mem 0x000c0000-0x000c3fff window]
[    0.314400] pnp 00:00: [mem 0x000c4000-0x000c7fff window]
[    0.314402] pnp 00:00: [mem 0x000c8000-0x000cbfff window]
[    0.314406] pnp 00:00: [mem 0x000cc000-0x000cffff window]
[    0.314408] pnp 00:00: [mem 0x000d0000-0x000d3fff window]
[    0.314410] pnp 00:00: [mem 0x000d4000-0x000d7fff window]
[    0.314412] pnp 00:00: [mem 0x000d8000-0x000dbfff window]
[    0.314415] pnp 00:00: [mem 0x000dc000-0x000dffff window]
[    0.314417] pnp 00:00: [mem 0x000e0000-0x000e3fff window]
[    0.314419] pnp 00:00: [mem 0x000e4000-0x000e7fff window]
[    0.314421] pnp 00:00: [mem 0x000e8000-0x000ebfff window]
[    0.314423] pnp 00:00: [mem 0x000ec000-0x000effff window]
[    0.314425] pnp 00:00: [mem 0x000f0000-0x000fffff window]
[    0.314427] pnp 00:00: [mem 0x7c000000-0xfeafffff window]
[    0.314429] pnp 00:00: [mem 0xfed40000-0xfed44fff window]
[    0.314486] pnp 00:00: Plug and Play ACPI device, IDs PNP0a08 PNP0a03 (active)
[    0.314593] pnp 00:01: [io  0x0000-0x001f]
[    0.314596] pnp 00:01: [io  0x0081-0x0091]
[    0.314598] pnp 00:01: [io  0x0093-0x009f]
[    0.314600] pnp 00:01: [io  0x00c0-0x00df]
[    0.314602] pnp 00:01: [dma 4]
[    0.314636] pnp 00:01: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.314646] pnp 00:02: [mem 0xff000000-0xffffffff]
[    0.314678] pnp 00:02: Plug and Play ACPI device, IDs INT0800 (active)
[    0.314767] pnp 00:03: [irq 0 disabled]
[    0.314780] pnp 00:03: [irq 8]
[    0.314782] pnp 00:03: [mem 0xfed00000-0xfed003ff]
[    0.314821] pnp 00:03: Plug and Play ACPI device, IDs PNP0103 (active)
[    0.314832] pnp 00:04: [io  0x00f0]
[    0.314838] pnp 00:04: [irq 13]
[    0.314871] pnp 00:04: Plug and Play ACPI device, IDs PNP0c04 (active)
[    0.314884] pnp 00:05: [io  0x002e-0x002f]
[    0.314886] pnp 00:05: [io  0x004e-0x004f]
[    0.314888] pnp 00:05: [io  0x0061]
[    0.314889] pnp 00:05: [io  0x0063]
[    0.314891] pnp 00:05: [io  0x0065]
[    0.314893] pnp 00:05: [io  0x0067]
[    0.314895] pnp 00:05: [io  0x0070]
[    0.314898] pnp 00:05: [io  0x0080]
[    0.314900] pnp 00:05: [io  0x0092]
[    0.314902] pnp 00:05: [io  0x00b2-0x00b3]
[    0.314904] pnp 00:05: [io  0x0680-0x069f]
[    0.314905] pnp 00:05: [io  0x0500-0x050f]
[    0.314907] pnp 00:05: [io  0x0600-0x0603]
[    0.314909] pnp 00:05: [io  0xffff]
[    0.314911] pnp 00:05: [io  0x0400-0x047f]
[    0.314913] pnp 00:05: [io  0x1180-0x11ff]
[    0.314915] pnp 00:05: [io  0x164e-0x164f]
[    0.314916] pnp 00:05: [io  0xfe00]
[    0.314918] pnp 00:05: [io  0x0068]
[    0.314920] pnp 00:05: [io  0x006c]
[    0.314922] pnp 00:05: [io  0x0700-0x070f]
[    0.314985] system 00:05: [io  0x0680-0x069f] has been reserved
[    0.315068] system 00:05: [io  0x0500-0x050f] has been reserved
[    0.315148] system 00:05: [io  0x0600-0x0603] has been reserved
[    0.315227] system 00:05: [io  0xffff] has been reserved
[    0.315305] system 00:05: [io  0x0400-0x047f] has been reserved
[    0.315385] system 00:05: [io  0x1180-0x11ff] has been reserved
[    0.315467] system 00:05: [io  0x164e-0x164f] has been reserved
[    0.315549] system 00:05: [io  0xfe00] has been reserved
[    0.315631] system 00:05: [io  0x0700-0x070f] has been reserved
[    0.315715] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.315754] pnp 00:06: [io  0x06a0-0x06af]
[    0.315756] pnp 00:06: [io  0x06b0-0x06ff]
[    0.315807] system 00:06: [io  0x06a0-0x06af] has been reserved
[    0.315888] system 00:06: [io  0x06b0-0x06ff] has been reserved
[    0.315969] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.316019] pnp 00:07: [io  0x0070-0x0077]
[    0.316058] pnp 00:07: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.316090] pnp 00:08: [io  0x0060]
[    0.316092] pnp 00:08: [io  0x0064]
[    0.316098] pnp 00:08: [irq 1]
[    0.316135] pnp 00:08: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.316149] pnp 00:09: [irq 12]
[    0.316183] pnp 00:09: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.316479] pnp 00:0a: [mem 0xfed1c000-0xfed1ffff]
[    0.316482] pnp 00:0a: [mem 0xfed10000-0xfed13fff]
[    0.316484] pnp 00:0a: [mem 0xfed18000-0xfed18fff]
[    0.316486] pnp 00:0a: [mem 0xfed19000-0xfed19fff]
[    0.316489] pnp 00:0a: [mem 0xe0000000-0xefffffff]
[    0.316491] pnp 00:0a: [mem 0x00000000-0xffffffffffffffff disabled]
[    0.316493] pnp 00:0a: [mem 0xfeaff000-0xfeafffff]
[    0.316496] pnp 00:0a: [mem 0xfed20000-0xfed3ffff]
[    0.316499] pnp 00:0a: [mem 0xfed90000-0xfed8ffff disabled]
[    0.316501] pnp 00:0a: [mem 0xfed40000-0xfed44fff]
[    0.316503] pnp 00:0a: [mem 0xfed45000-0xfed8ffff]
[    0.316505] pnp 00:0a: [mem 0xff000000-0xffffffff]
[    0.316507] pnp 00:0a: [mem 0xfee00000-0xfeefffff]
[    0.316572] system 00:0a: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.316655] system 00:0a: [mem 0xfed10000-0xfed13fff] has been reserved
[    0.316736] system 00:0a: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.316819] system 00:0a: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.316904] system 00:0a: [mem 0xe0000000-0xefffffff] has been reserved
[    0.316986] system 00:0a: [mem 0xfeaff000-0xfeafffff] has been reserved
[    0.317068] system 00:0a: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.317151] system 00:0a: [mem 0xfed40000-0xfed44fff] has been reserved
[    0.317235] system 00:0a: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.317319] system 00:0a: [mem 0xff000000-0xffffffff] has been reserved
[    0.317402] system 00:0a: [mem 0xfee00000-0xfeefffff] could not be reserved
[    0.317485] system 00:0a: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.317672] pnp 00:0b: [bus ff]
[    0.317715] pnp 00:0b: Plug and Play ACPI device, IDs PNP0a03 (active)
[    0.318045] pnp: PnP ACPI: found 12 devices
[    0.318123] ACPI: ACPI bus type pnp unregistered
[    0.325222] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 02-02] add_size 1000
[    0.325227] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 02-02] add_size 200000
[    0.325230] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff] to [bus 02-02] add_size 200000
[    0.325242] pci 0000:00:1c.1: bridge window [io  0x1000-0x0fff] to [bus 03-03] add_size 1000
[    0.325246] pci 0000:00:1c.1: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 03-03] add_size 200000
[    0.325259] pci 0000:00:1c.4: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 08-08] add_size 200000
[    0.325277] pci 0000:00:1c.0: res[14]=[mem 0x00100000-0x000fffff] get_res_add_size add_size 200000
[    0.325280] pci 0000:00:1c.0: res[15]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 200000
[    0.325283] pci 0000:00:1c.1: res[15]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 200000
[    0.325286] pci 0000:00:1c.4: res[15]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 200000
[    0.325289] pci 0000:00:1c.0: res[13]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
[    0.325291] pci 0000:00:1c.1: res[13]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
[    0.325297] pci 0000:00:1c.0: BAR 14: assigned [mem 0x7c000000-0x7c1fffff]
[    0.325381] pci 0000:00:1c.0: BAR 15: assigned [mem 0x7c200000-0x7c3fffff 64bit pref]
[    0.325489] pci 0000:00:1c.1: BAR 15: assigned [mem 0x7c400000-0x7c5fffff 64bit pref]
[    0.325594] pci 0000:00:1c.4: BAR 15: assigned [mem 0x7c600000-0x7c7fffff 64bit pref]
[    0.325702] pci 0000:00:1c.0: BAR 13: assigned [io  0x4000-0x4fff]
[    0.325784] pci 0000:00:1c.1: BAR 13: assigned [io  0x5000-0x5fff]
[    0.325869] pci 0000:01:00.0: BAR 6: assigned [mem 0xad000000-0xad07ffff pref]
[    0.325974] pci 0000:00:01.0: PCI bridge to [bus 01-01]
[    0.326051] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.326134] pci 0000:00:01.0:   bridge window [mem 0xac000000-0xadefffff]
[    0.326218] pci 0000:00:01.0:   bridge window [mem 0xae000000-0xbfffffff 64bit pref]
[    0.326325] pci 0000:00:1c.0: PCI bridge to [bus 02-02]
[    0.326406] pci 0000:00:1c.0:   bridge window [io  0x4000-0x4fff]
[    0.326492] pci 0000:00:1c.0:   bridge window [mem 0x7c000000-0x7c1fffff]
[    0.326577] pci 0000:00:1c.0:   bridge window [mem 0x7c200000-0x7c3fffff 64bit pref]
[    0.326687] pci 0000:00:1c.1: PCI bridge to [bus 03-03]
[    0.326767] pci 0000:00:1c.1:   bridge window [io  0x5000-0x5fff]
[    0.326854] pci 0000:00:1c.1:   bridge window [mem 0xf0500000-0xf05fffff]
[    0.326940] pci 0000:00:1c.1:   bridge window [mem 0x7c400000-0x7c5fffff 64bit pref]
[    0.327051] pci 0000:00:1c.4: PCI bridge to [bus 08-08]
[    0.327133] pci 0000:00:1c.4:   bridge window [io  0x3000-0x3fff]
[    0.327218] pci 0000:00:1c.4:   bridge window [mem 0xf0400000-0xf04fffff]
[    0.327307] pci 0000:00:1c.4:   bridge window [mem 0x7c600000-0x7c7fffff 64bit pref]
[    0.327416] pci 0000:00:1e.0: PCI bridge to [bus 0a-0a]
[    0.327546] pci 0000:00:1e.0: setting latency timer to 64
[    0.327550] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    0.327553] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    0.327555] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    0.327557] pci_bus 0000:00: resource 7 [mem 0x000d4000-0x000d7fff]
[    0.327560] pci_bus 0000:00: resource 8 [mem 0x000d8000-0x000dbfff]
[    0.327562] pci_bus 0000:00: resource 9 [mem 0x000e0000-0x000e3fff]
[    0.327564] pci_bus 0000:00: resource 10 [mem 0x7c000000-0xfeafffff]
[    0.327567] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
[    0.327569] pci_bus 0000:01: resource 1 [mem 0xac000000-0xadefffff]
[    0.327571] pci_bus 0000:01: resource 2 [mem 0xae000000-0xbfffffff 64bit pref]
[    0.327573] pci_bus 0000:02: resource 0 [io  0x4000-0x4fff]
[    0.327576] pci_bus 0000:02: resource 1 [mem 0x7c000000-0x7c1fffff]
[    0.327578] pci_bus 0000:02: resource 2 [mem 0x7c200000-0x7c3fffff 64bit pref]
[    0.327580] pci_bus 0000:03: resource 0 [io  0x5000-0x5fff]
[    0.327583] pci_bus 0000:03: resource 1 [mem 0xf0500000-0xf05fffff]
[    0.327585] pci_bus 0000:03: resource 2 [mem 0x7c400000-0x7c5fffff 64bit pref]
[    0.327587] pci_bus 0000:08: resource 0 [io  0x3000-0x3fff]
[    0.327589] pci_bus 0000:08: resource 1 [mem 0xf0400000-0xf04fffff]
[    0.327592] pci_bus 0000:08: resource 2 [mem 0x7c600000-0x7c7fffff 64bit pref]
[    0.327594] pci_bus 0000:0a: resource 4 [io  0x0000-0x0cf7]
[    0.327596] pci_bus 0000:0a: resource 5 [io  0x0d00-0xffff]
[    0.327599] pci_bus 0000:0a: resource 6 [mem 0x000a0000-0x000bffff]
[    0.327601] pci_bus 0000:0a: resource 7 [mem 0x000d4000-0x000d7fff]
[    0.327603] pci_bus 0000:0a: resource 8 [mem 0x000d8000-0x000dbfff]
[    0.327605] pci_bus 0000:0a: resource 9 [mem 0x000e0000-0x000e3fff]
[    0.327608] pci_bus 0000:0a: resource 10 [mem 0x7c000000-0xfeafffff]
[    0.327676] NET: Registered protocol family 2
[    0.327847] IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.328425] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
[    0.329808] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.330216] TCP: Hash tables configured (established 262144 bind 65536)
[    0.330298] TCP: reno registered
[    0.330374] UDP hash table entries: 1024 (order: 3, 32768 bytes)
[    0.330468] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes)
[    0.330674] NET: Registered protocol family 1
[    0.330770] pci 0000:00:02.0: Boot video device
[    0.330926] PCI: CLS 64 bytes, default 64
[    0.330978] Unpacking initramfs...
[    3.241872] Freeing initrd memory: 120896k freed
[    3.269558] Simple Boot Flag at 0x36 set to 0x1
[    3.270132] audit: initializing netlink socket (disabled)
[    3.270224] type=2000 audit(1341652373.152:1): initialized
[    3.284521] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    3.285086] VFS: Disk quotas dquot_6.5.2
[    3.285186] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    3.285348] msgmni has been set to 3743
[    3.285586] alg: No test for stdrng (krng)
[    3.285690] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    3.285795] io scheduler noop registered
[    3.285868] io scheduler deadline registered
[    3.285954] io scheduler cfq registered (default)
[    3.286145] pcieport 0000:00:01.0: irq 40 for MSI/MSI-X
[    3.286366] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    3.286463] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    3.286545] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    3.287073] intel_idle: MWAIT substates: 0x120
[    3.287075] intel_idle: v0.4 model 0x25
[    3.287076] intel_idle: lapic_timer_reliable_states 0xffffffff
[    3.287115] GHES: HEST is not enabled!
[    3.287249] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    3.287846] Linux agpgart interface v0.103
[    3.287993] agpgart-intel 0000:00:00.0: Intel HD Graphics Chipset
[    3.288189] agpgart-intel 0000:00:00.0: detected gtt size: 2097152K total, 262144K mappable
[    3.289128] agpgart-intel 0000:00:00.0: detected 32768K stolen memory
[    3.289357] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xd0000000
[    3.289557] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    3.292912] i8042: Detected active multiplexing controller, rev 1.1
[    3.294680] serio: i8042 KBD port at 0x60,0x64 irq 1
[    3.297259] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[    3.297364] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[    3.297461] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[    3.297560] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[    3.297750] mousedev: PS/2 mouse device common for all mice
[    3.297880] rtc_cmos 00:07: RTC can wake from S4
[    3.298095] rtc_cmos 00:07: rtc core: registered rtc_cmos as rtc0
[    3.298207] rtc0: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[    3.298329] cpuidle: using governor ladder
[    3.298441] cpuidle: using governor menu
[    3.298638] TCP: cubic registered
[    3.298794] NET: Registered protocol family 10
[    3.299140] Mobile IPv6
[    3.299212] NET: Registered protocol family 17
[    3.299288] Registering the dns_resolver key type
[    3.300109] PM: Hibernation image not present or could not be loaded.
[    3.300135] registered taskstats version 1
[    3.300959] rtc_cmos 00:07: setting system clock to 2012-07-07 09:12:53 UTC (1341652373)
[    3.301273] Initializing network drop monitor service
[    3.315477] Freeing unused kernel memory: 604k freed
[    3.315644] Write protecting the kernel read-only data: 6144k
[    3.317701] Freeing unused kernel memory: 496k freed
[    3.320521] Freeing unused kernel memory: 720k freed
[    3.343592] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    3.451144] udev[54]: starting version 164
[    3.468043] usbcore: registered new interface driver usbfs
[    3.468148] usbcore: registered new interface driver hub
[    3.468975] usbcore: registered new device driver usb
[    3.469904] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    3.470035] ehci_hcd 0000:00:1a.0: setting latency timer to 64
[    3.470040] ehci_hcd 0000:00:1a.0: EHCI Host Controller
[    3.470140] ehci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
[    3.470271] ehci_hcd 0000:00:1a.0: debug port 2
[    3.474318] ehci_hcd 0000:00:1a.0: cache line size of 64 is not supported
[    3.474344] ehci_hcd 0000:00:1a.0: irq 16, io mem 0xf0806000
[    3.482878] ehci_hcd 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    3.483010] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    3.483092] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.483197] usb usb1: Product: EHCI Host Controller
[    3.483274] usb usb1: Manufacturer: Linux 3.4.4debugpsmouse ehci_hcd
[    3.483357] usb usb1: SerialNumber: 0000:00:1a.0
[    3.483606] hub 1-0:1.0: USB hub found
[    3.483683] hub 1-0:1.0: 3 ports detected
[    3.483885] ehci_hcd 0000:00:1d.0: setting latency timer to 64
[    3.483889] ehci_hcd 0000:00:1d.0: EHCI Host Controller
[    3.483981] ehci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    3.484114] ehci_hcd 0000:00:1d.0: debug port 2
[    3.488201] ehci_hcd 0000:00:1d.0: cache line size of 64 is not supported
[    3.510396] SCSI subsystem initialized
[    3.523678] ehci_hcd 0000:00:1d.0: irq 23, io mem 0xf0806400
[    3.530705] thermal LNXTHERM:00: registered as thermal_zone0
[    3.530819] ACPI: Thermal Zone [TZ00] (56 C)
[    3.534765] ehci_hcd 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    3.534879] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    3.534963] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.535068] usb usb2: Product: EHCI Host Controller
[    3.535147] usb usb2: Manufacturer: Linux 3.4.4debugpsmouse ehci_hcd
[    3.535230] usb usb2: SerialNumber: 0000:00:1d.0
[    3.535415] hub 2-0:1.0: USB hub found
[    3.535564] hub 2-0:1.0: 3 ports detected
[    3.537996] libata version 3.00 loaded.
[    3.539215] ahci 0000:00:1f.2: version 3.0
[    3.539293] ahci 0000:00:1f.2: irq 41 for MSI/MSI-X
[    3.539335] ahci: SSS flag set, parallel bus scan disabled
[    3.539462] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 4 ports 3 Gbps 0x32 impl SATA mode
[    3.539573] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pio slum part ems apst 
[    3.539688] ahci 0000:00:1f.2: setting latency timer to 64
[    3.555316] scsi0 : ahci
[    3.555626] scsi1 : ahci
[    3.555871] scsi2 : ahci
[    3.556099] scsi3 : ahci
[    3.556333] scsi4 : ahci
[    3.556564] scsi5 : ahci
[    3.556752] ata1: DUMMY
[    3.556833] ata2: SATA max UDMA/133 abar m2048@0xf0805000 port 0xf0805180 irq 41
[    3.556950] ata3: DUMMY
[    3.557027] ata4: DUMMY
[    3.557108] ata5: SATA max UDMA/133 abar m2048@0xf0805000 port 0xf0805300 irq 41
[    3.557226] ata6: SATA max UDMA/133 abar m2048@0xf0805000 port 0xf0805380 irq 41
[    3.615140] atl1c 0000:08:00.0: version 1.0.1.0-NAPI
[    3.794599] usb 1-1: new high-speed USB device number 2 using ehci_hcd
[    3.874565] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    3.926954] usb 1-1: New USB device found, idVendor=8087, idProduct=0020
[    3.927079] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.927520] hub 1-1:1.0: USB hub found
[    3.927792] hub 1-1:1.0: 6 ports detected
[    3.927939] ata2.00: ATA-8: TOSHIBA MK3265GSX, GJ205E, max UDMA/100
[    3.928031] ata2.00: 625142448 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    3.929050] ata2.00: configured for UDMA/100
[    3.929254] scsi 1:0:0:0: Direct-Access     ATA      TOSHIBA MK3265GS GJ20 PQ: 0 ANSI: 5
[    4.038487] usb 2-1: new high-speed USB device number 2 using ehci_hcd
[    4.170850] usb 2-1: New USB device found, idVendor=8087, idProduct=0020
[    4.170942] usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    4.171423] hub 2-1:1.0: USB hub found
[    4.171543] hub 2-1:1.0: 8 ports detected
[    4.242584] usb 1-1.1: new low-speed USB device number 3 using ehci_hcd
[    4.246403] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    4.249441] ata5.00: ATAPI: PLDS DVD-RW DS8A8SH, KL31, max UDMA/100
[    4.255602] ata5.00: configured for UDMA/100
[    4.263232] scsi 4:0:0:0: CD-ROM            PLDS     DVD-RW DS8A8SH   KL31 PQ: 0 ANSI: 5
[    4.266381] Refined TSC clocksource calibration: 2127.999 MHz.
[    4.266472] Switching to clocksource tsc
[    4.338013] usb 1-1.1: New USB device found, idVendor=15d9, idProduct=0a4f
[    4.338105] usb 1-1.1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    4.338217] usb 1-1.1: Product:  USB OPTICAL MOUSE
[    4.442517] usb 2-1.2: new low-speed USB device number 3 using ehci_hcd
[    4.537679] usb 2-1.2: New USB device found, idVendor=0079, idProduct=0011
[    4.537773] usb 2-1.2: New USB device strings: Mfr=0, Product=2, SerialNumber=0
[    4.537885] usb 2-1.2: Product: USB Gamepad 
[    4.544716] input:  USB OPTICAL MOUSE as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1/1-1.1:1.0/input/input1
[    4.545029] generic-usb 0003:15D9:0A4F.0001: input,hidraw0: USB HID v1.11 Mouse [ USB OPTICAL MOUSE] on usb-0000:00:1a.0-1.1/input0
[    4.545270] usbcore: registered new interface driver usbhid
[    4.545354] usbhid: USB HID core driver
[    4.582256] ata6: SATA link down (SStatus 0 SControl 300)
[    4.589356] sd 1:0:0:0: [sda] 625142448 512-byte logical blocks: (320 GB/298 GiB)
[    4.589530] sd 1:0:0:0: [sda] Write Protect is off
[    4.589617] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    4.589747] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    4.594844] sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
[    4.594958] cdrom: Uniform CD-ROM driver Revision: 3.20
[    4.595268] sr 4:0:0:0: Attached scsi CD-ROM sr0
[    4.610415] usb 2-1.4: new high-speed USB device number 4 using ehci_hcd
[    4.717040]  sda: sda1 sda2 sda3 < sda5 sda6 sda7 > sda4
[    4.717202] usb 2-1.4: New USB device found, idVendor=5986, idProduct=0294
[    4.717292] usb 2-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.717402] usb 2-1.4: Product: Lenovo EasyCamera
[    4.717485] usb 2-1.4: Manufacturer: Bison Corp.
[    4.718250] sd 1:0:0:0: [sda] Attached SCSI disk
[    4.722416] sd 1:0:0:0: Attached scsi generic sg0 type 0
[    4.722618] sr 4:0:0:0: Attached scsi generic sg1 type 5
[    5.504801] nbd: registered device at major 43
[    5.520919] device-mapper: uevent: version 1.0.3
[    5.521086] device-mapper: ioctl: 4.22.0-ioctl (2011-10-19) initialised: dm-devel@redhat.com
[    5.670530] EXT4-fs (sda7): mounted filesystem with ordered data mode. Opts: (null)
[   17.628561] udev[413]: starting version 164
[   17.878652] input: Lid Switch as /devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input2
[   17.879234] ACPI: Lid Switch [LID]
[   17.879369] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input3
[   17.879478] ACPI: Power Button [PWRB]
[   17.879591] input: Sleep Button as /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input4
[   17.879702] ACPI: Sleep Button [SLPB]
[   17.879818] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input5
[   17.879927] ACPI: Power Button [PWRF]
[   18.087536] microcode: CPU0 sig=0x20655, pf=0x10, revision=0x2
[   18.099301] microcode: CPU1 sig=0x20655, pf=0x10, revision=0x2
[   18.102059] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[   18.193981] ACPI: Requesting acpi_cpufreq
[   18.281028] intel ips 0000:00:1f.6: No CPUID match found.
[   18.281110] intel ips 0000:00:1f.6: IPS not supported on this CPU
[   18.516890] ACPI Warning: 0x0000000000001840-0x000000000000185f SystemIO conflicts with Region \_SB_.PCI0.SBUS.SMBI 1 (20120320/utaddress-251)
[   18.517123] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[   18.527739] input: PC Speaker as /devices/platform/pcspkr/input/input6
[   18.543968] input: USB Gamepad  as /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.0/input/input7
[   18.544207] dragonrise 0003:0079:0011.0002: input,hidraw1: USB HID v1.10 Joystick [USB Gamepad ] on usb-0000:00:1d.0-1.2/input0
[   18.625237] Linux media interface: v0.10
[   18.874696] Linux video capture interface: v2.00
[   18.986451] ACPI: Battery Slot [BAT1] (battery present)
[   18.989490] ACPI: AC Adapter [ACAD] (on-line)
[   18.994811] wmi: Mapper loaded
[   19.062711] cfg80211: Calling CRDA to update world regulatory domain
[   19.105550] psmouse serio4: alps: E6 report: 00 00 64
[   19.130028] psmouse serio4: alps: E7 report: 73 03 50
[   19.149304] psmouse serio4: alps: unknown response while entering command mode: 73 01 0d
[   19.149311] psmouse serio4: alps: touchpad failed to enter command mode
[   19.324387] input: Ideapad extra buttons as /devices/platform/ideapad/input/input8
[   19.607328] [drm] Initialized drm 1.1.0 20060810
[   19.665378] uvcvideo: Found UVC 1.00 device Lenovo EasyCamera (5986:0294)
[   19.667566] input: Lenovo EasyCamera as /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.4/2-1.4:1.0/input/input9
[   19.667738] usbcore: registered new interface driver uvcvideo
[   19.667822] USB Video Class driver (1.1.1)
[   19.772454] input: PS/2 Generic Mouse as /devices/platform/i8042/serio4/input/input10
[   21.049809] i915 0000:00:02.0: setting latency timer to 64
[   21.103551] i915 0000:00:02.0: irq 42 for MSI/MSI-X
[   21.103563] [drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
[   21.103652] [drm] Driver supports precise vblank timestamp query.
[   21.103813] [drm:intel_dsm_platform_mux_info] *ERROR* MUX INFO call failed
[   21.103919] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=none:owns=io+mem
[   21.104027] vgaarb: transferring owner from PCI:0000:00:02.0 to PCI:0000:01:00.0
[   21.510193] fbcon: inteldrmfb (fb0) is primary device
[   21.619734] ath: EEPROM regdomain: 0x65
[   21.619738] ath: EEPROM indicates we should expect a direct regpair map
[   21.619743] ath: Country alpha2 being used: 00
[   21.619746] ath: Regpair used: 0x65
[   21.656989] ieee80211 phy0: Selected rate control algorithm 'ath9k_rate_control'
[   21.657322] Registered led device: ath9k-phy0
[   21.657329] ieee80211 phy0: Atheros AR9285 Rev:2 mem=0xffffc90010920000, irq=17
[   21.790523] Console: switching to colour frame buffer device 170x48
[   21.798030] fb0: inteldrmfb frame buffer device
[   21.798033] drm: registered panic notifier
[   21.798420] ACPI Exception: AE_NOT_FOUND, Evaluating _DOD (20120320/video-1147)
[   21.798474] video: probe of LNXVIDEO:00 failed with error 5
[   21.801070] input: Video Bus as /devices/LNXSYSTM:00/device:00/PNP0A08:00/LNXVIDEO:01/input/input11
[   21.801253] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[   21.801528] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 0
[   21.801680] snd_hda_intel 0000:00:1b.0: irq 43 for MSI/MSI-X
[   21.873287] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/input/input12
[   21.877417] input: HDA Intel Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input13
[   21.877670] input: HDA Intel Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input14
[   22.105384] EXT4-fs (sda7): re-mounted. Opts: (null)
[   22.170023] EXT4-fs (sda7): re-mounted. Opts: errors=remount-ro
[   22.300074] loop: module loaded
[   23.694904] fuse init (API version 7.18)
[   24.305189] ADDRCONF(NETDEV_UP): wlan0: link is not ready
[   25.894367] input: ACPI Virtual Keyboard Device as /devices/virtual/input/input15
[   26.861883] atl1c 0000:08:00.0: irq 44 for MSI/MSI-X
[   27.882839] Clocksource tsc unstable (delta = -126514396 ns)
[   27.884078] Switching to clocksource hpet
[   28.224284] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   30.610345] sshd (1643): /proc/1643/oom_adj is deprecated, please use /proc/1643/oom_score_adj instead.
[   54.585466] wlan0: authenticate with ec:17:2f:2f:e9:b6
[   54.598924] wlan0: send auth to ec:17:2f:2f:e9:b6 (try 1/3)
[   54.602121] wlan0: authenticated
[   54.609165] wlan0: associate with ec:17:2f:2f:e9:b6 (try 1/3)
[   54.613379] wlan0: RX AssocResp from ec:17:2f:2f:e9:b6 (capab=0x431 status=0 aid=1)
[   54.613384] wlan0: associated
[   54.620466] ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready

--Multipart=_Sat__7_Jul_2012_13_35_19_+0800_amjr5p9Y4..xlEyg
Content-Type: text/plain;
 name="V4-73-inputdevices.txt"
Content-Disposition: attachment;
 filename="V4-73-inputdevices.txt"
Content-Transfer-Encoding: 7bit

I: Bus=0011 Vendor=0001 Product=0001 Version=ab41
N: Name="AT Translated Set 2 keyboard"
P: Phys=isa0060/serio0/input0
S: Sysfs=/devices/platform/i8042/serio0/input/input0
U: Uniq=
H: Handlers=sysrq kbd event0 
B: PROP=0
B: EV=120013
B: KEY=402000000 3803078f800d001 feffffdfffefffff fffffffffffffffe
B: MSC=10
B: LED=7

I: Bus=0003 Vendor=15d9 Product=0a4f Version=0111
N: Name=" USB OPTICAL MOUSE"
P: Phys=usb-0000:00:1a.0-1.1/input0
S: Sysfs=/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1/1-1.1:1.0/input/input1
U: Uniq=
H: Handlers=mouse0 event1 
B: PROP=0
B: EV=17
B: KEY=70000 0 0 0 0
B: REL=103
B: MSC=10

I: Bus=0019 Vendor=0000 Product=0005 Version=0000
N: Name="Lid Switch"
P: Phys=PNP0C0D/button/input0
S: Sysfs=/devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input2
U: Uniq=
H: Handlers=event2 
B: PROP=0
B: EV=21
B: SW=1

I: Bus=0019 Vendor=0000 Product=0001 Version=0000
N: Name="Power Button"
P: Phys=PNP0C0C/button/input0
S: Sysfs=/devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input3
U: Uniq=
H: Handlers=kbd event3 
B: PROP=0
B: EV=3
B: KEY=10000000000000 0

I: Bus=0019 Vendor=0000 Product=0003 Version=0000
N: Name="Sleep Button"
P: Phys=PNP0C0E/button/input0
S: Sysfs=/devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input4
U: Uniq=
H: Handlers=kbd event4 
B: PROP=0
B: EV=3
B: KEY=4000 0 0

I: Bus=0019 Vendor=0000 Product=0001 Version=0000
N: Name="Power Button"
P: Phys=LNXPWRBN/button/input0
S: Sysfs=/devices/LNXSYSTM:00/LNXPWRBN:00/input/input5
U: Uniq=
H: Handlers=kbd event5 
B: PROP=0
B: EV=3
B: KEY=10000000000000 0

I: Bus=0010 Vendor=001f Product=0001 Version=0100
N: Name="PC Speaker"
P: Phys=isa0061/input0
S: Sysfs=/devices/platform/pcspkr/input/input6
U: Uniq=
H: Handlers=kbd event6 
B: PROP=0
B: EV=40001
B: SND=6

I: Bus=0003 Vendor=0079 Product=0011 Version=0110
N: Name="USB Gamepad "
P: Phys=usb-0000:00:1d.0-1.2/input0
S: Sysfs=/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.0/input/input7
U: Uniq=
H: Handlers=event7 js0 
B: PROP=0
B: EV=1b
B: KEY=3ff00000000 0 0 0 0
B: ABS=3
B: MSC=10

I: Bus=0019 Vendor=0000 Product=0000 Version=0000
N: Name="Ideapad extra buttons"
P: Phys=ideapad/input0
S: Sysfs=/devices/platform/ideapad/input/input8
U: Uniq=
H: Handlers=kbd rfkill event8 
B: PROP=0
B: EV=13
B: KEY=1400800000000 300000 0 0
B: MSC=10

I: Bus=0003 Vendor=5986 Product=0294 Version=1403
N: Name="Lenovo EasyCamera"
P: Phys=usb-0000:00:1d.0-1.4/button
S: Sysfs=/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.4/2-1.4:1.0/input/input9
U: Uniq=
H: Handlers=kbd event9 
B: PROP=0
B: EV=3
B: KEY=100000 0 0 0

I: Bus=0011 Vendor=0002 Product=0001 Version=0000
N: Name="PS/2 Generic Mouse"
P: Phys=isa0060/serio4/input0
S: Sysfs=/devices/platform/i8042/serio4/input/input10
U: Uniq=
H: Handlers=mouse1 event10 
B: PROP=0
B: EV=7
B: KEY=70000 0 0 0 0
B: REL=3

I: Bus=0019 Vendor=0000 Product=0006 Version=0000
N: Name="Video Bus"
P: Phys=LNXVIDEO/video/input0
S: Sysfs=/devices/LNXSYSTM:00/device:00/PNP0A08:00/LNXVIDEO:01/input/input11
U: Uniq=
H: Handlers=kbd event11 
B: PROP=0
B: EV=3
B: KEY=3e000b00000000 0 0 0

I: Bus=0001 Vendor=10ec Product=0272 Version=0001
N: Name="HDA Digital PCBeep"
P: Phys=card0/codec#0/beep0
S: Sysfs=/devices/pci0000:00/0000:00:1b.0/input/input12
U: Uniq=
H: Handlers=kbd event12 
B: PROP=0
B: EV=40001
B: SND=6

I: Bus=0000 Vendor=0000 Product=0000 Version=0000
N: Name="HDA Intel Mic"
P: Phys=ALSA
S: Sysfs=/devices/pci0000:00/0000:00:1b.0/sound/card0/input13
U: Uniq=
H: Handlers=event13 
B: PROP=0
B: EV=21
B: SW=10

I: Bus=0000 Vendor=0000 Product=0000 Version=0000
N: Name="HDA Intel Headphone"
P: Phys=ALSA
S: Sysfs=/devices/pci0000:00/0000:00:1b.0/sound/card0/input14
U: Uniq=
H: Handlers=event14 
B: PROP=0
B: EV=21
B: SW=4

I: Bus=0003 Vendor=0000 Product=0000 Version=0004
N: Name="ACPI Virtual Keyboard Device"
P: Phys=
S: Sysfs=/devices/virtual/input/input15
U: Uniq=
H: Handlers=sysrq kbd rfkill event15 
B: PROP=0
B: EV=3
B: KEY=ffffffffffffffff ffffffffffffffff ffffffffffffffff fffffffffffffffe


--Multipart=_Sat__7_Jul_2012_13_35_19_+0800_amjr5p9Y4..xlEyg
Content-Type: text/plain;
 name="V4-73-xinputlist.txt"
Content-Disposition: attachment;
 filename="V4-73-xinputlist.txt"
Content-Transfer-Encoding: quoted-printable

=E2=8E=A1 Virtual core pointer                    	id=3D2	[master pointer  =
(3)]
	Reporting 3 classes:
		Class originated from: 13
		Buttons supported: 10
		Button labels: Button Left Button Middle Button Right Button Wheel Up But=
ton Wheel Down Button Horiz Wheel Left Button Horiz Wheel Right None None N=
one
		Button state:
		Class originated from: 13
		Detail for Valuator 0:
		  Label: Rel X
		  Range: -1.000000 - -1.000000
		  Resolution: 1 units/m
		  Mode: relative
		Class originated from: 13
		Detail for Valuator 1:
		  Label: Rel Y
		  Range: -1.000000 - -1.000000
		  Resolution: 1 units/m
		  Mode: relative

=E2=8E=9C   =E2=86=B3 Virtual core XTEST pointer              	id=3D4	[slav=
e  pointer  (2)]
	Reporting 3 classes:
		Class originated from: 4
		Buttons supported: 10
		Button labels: Button Left Button Middle Button Right Button Wheel Up But=
ton Wheel Down Button Horiz Wheel Left Button Horiz Wheel Right None None N=
one
		Button state:
		Class originated from: 4
		Detail for Valuator 0:
		  Label: Rel X
		  Range: -1.000000 - -1.000000
		  Resolution: 0 units/m
		  Mode: relative
		Class originated from: 4
		Detail for Valuator 1:
		  Label: Rel Y
		  Range: -1.000000 - -1.000000
		  Resolution: 0 units/m
		  Mode: relative

=E2=8E=9C   =E2=86=B3  USB OPTICAL MOUSE                      	id=3D10	[sla=
ve  pointer  (2)]
	Reporting 3 classes:
		Class originated from: 10
		Buttons supported: 7
		Button labels: Button Left Button Middle Button Right Button Wheel Up But=
ton Wheel Down Button Horiz Wheel Left Button Horiz Wheel Right
		Button state:
		Class originated from: 10
		Detail for Valuator 0:
		  Label: Rel X
		  Range: -1.000000 - -1.000000
		  Resolution: 1 units/m
		  Mode: relative
		Class originated from: 10
		Detail for Valuator 1:
		  Label: Rel Y
		  Range: -1.000000 - -1.000000
		  Resolution: 1 units/m
		  Mode: relative

=E2=8E=9C   =E2=86=B3 PS/2 Generic Mouse                      	id=3D13	[sla=
ve  pointer  (2)]
	Reporting 3 classes:
		Class originated from: 13
		Buttons supported: 5
		Button labels: Button Left Button Middle Button Right Button Wheel Up But=
ton Wheel Down
		Button state:
		Class originated from: 13
		Detail for Valuator 0:
		  Label: Rel X
		  Range: -1.000000 - -1.000000
		  Resolution: 1 units/m
		  Mode: relative
		Class originated from: 13
		Detail for Valuator 1:
		  Label: Rel Y
		  Range: -1.000000 - -1.000000
		  Resolution: 1 units/m
		  Mode: relative

=E2=8E=A3 Virtual core keyboard                   	id=3D3	[master keyboard =
(2)]
	Reporting 1 classes:
		Class originated from: 12
		Keycodes supported: 248

    =E2=86=B3 Virtual core XTEST keyboard             	id=3D5	[slave  keybo=
ard (3)]
	Reporting 1 classes:
		Class originated from: 5
		Keycodes supported: 248

    =E2=86=B3 Power Button                            	id=3D6	[slave  keybo=
ard (3)]
	Reporting 1 classes:
		Class originated from: 6
		Keycodes supported: 248

    =E2=86=B3 Video Bus                               	id=3D7	[slave  keybo=
ard (3)]
	Reporting 1 classes:
		Class originated from: 7
		Keycodes supported: 248

    =E2=86=B3 Power Button                            	id=3D8	[slave  keybo=
ard (3)]
	Reporting 1 classes:
		Class originated from: 8
		Keycodes supported: 248

    =E2=86=B3 Sleep Button                            	id=3D9	[slave  keybo=
ard (3)]
	Reporting 1 classes:
		Class originated from: 9
		Keycodes supported: 248

    =E2=86=B3 Lenovo EasyCamera                       	id=3D11	[slave  keyb=
oard (3)]
	Reporting 1 classes:
		Class originated from: 11
		Keycodes supported: 248

    =E2=86=B3 AT Translated Set 2 keyboard            	id=3D12	[slave  keyb=
oard (3)]
	Reporting 1 classes:
		Class originated from: 12
		Keycodes supported: 248

    =E2=86=B3 Ideapad extra buttons                   	id=3D14	[slave  keyb=
oard (3)]
	Reporting 1 classes:
		Class originated from: 14
		Keycodes supported: 248

    =E2=86=B3 ACPI Virtual Keyboard Device            	id=3D15	[slave  keyb=
oard (3)]
	Reporting 1 classes:
		Class originated from: 15
		Keycodes supported: 248


--Multipart=_Sat__7_Jul_2012_13_35_19_+0800_amjr5p9Y4..xlEyg
Content-Type: application/octet-stream;
 name="V4-73-Xorg.0.log"
Content-Disposition: attachment;
 filename="V4-73-Xorg.0.log"
Content-Transfer-Encoding: base64

WyAgICAzMC4xNDZdIApYLk9yZyBYIFNlcnZlciAxLjEwLjQKUmVsZWFzZSBEYXRlOiAyMDExLTA4
LTE5ClsgICAgMzAuMTQ2XSBYIFByb3RvY29sIFZlcnNpb24gMTEsIFJldmlzaW9uIDAKWyAgICAz
MC4xNDZdIEJ1aWxkIE9wZXJhdGluZyBTeXN0ZW06IExpbnV4IDMuMC4wLTEtYW1kNjQgeDg2XzY0
IERlYmlhbgpbICAgIDMwLjE0Nl0gQ3VycmVudCBPcGVyYXRpbmcgU3lzdGVtOiBMaW51eCBsZGVi
aWFuIDMuNC40ZGVidWdwc21vdXNlICMxIFNNUCBGcmkgSnVsIDYgMDc6NDQ6NDkgQ1NUIDIwMTIg
eDg2XzY0ClsgICAgMzAuMTQ2XSBLZXJuZWwgY29tbWFuZCBsaW5lOiByb290PS9kZXYvc2RhNyBh
Y3BpX2JhY2tsaWdodD12ZW5kb3Igcm8KWyAgICAzMC4xNDZdIEJ1aWxkIERhdGU6IDI4IEF1Z3Vz
dCAyMDExICAwOTozOTo0M1BNClsgICAgMzAuMTQ2XSB4b3JnLXNlcnZlciAyOjEuMTAuNC0xfmJw
bzYwKzEgKEN5cmlsIEJydWxlYm9pcyA8a2liaUBkZWJpYW4ub3JnPikgClsgICAgMzAuMTQ2XSBD
dXJyZW50IHZlcnNpb24gb2YgcGl4bWFuOiAwLjI0LjAKWyAgICAzMC4xNDZdIAlCZWZvcmUgcmVw
b3J0aW5nIHByb2JsZW1zLCBjaGVjayBodHRwOi8vd2lraS54Lm9yZwoJdG8gbWFrZSBzdXJlIHRo
YXQgeW91IGhhdmUgdGhlIGxhdGVzdCB2ZXJzaW9uLgpbICAgIDMwLjE0Nl0gTWFya2VyczogKC0t
KSBwcm9iZWQsICgqKikgZnJvbSBjb25maWcgZmlsZSwgKD09KSBkZWZhdWx0IHNldHRpbmcsCgko
KyspIGZyb20gY29tbWFuZCBsaW5lLCAoISEpIG5vdGljZSwgKElJKSBpbmZvcm1hdGlvbmFsLAoJ
KFdXKSB3YXJuaW5nLCAoRUUpIGVycm9yLCAoTkkpIG5vdCBpbXBsZW1lbnRlZCwgKD8/KSB1bmtu
b3duLgpbICAgIDMwLjE0Nl0gKD09KSBMb2cgZmlsZTogIi92YXIvbG9nL1hvcmcuMC5sb2ciLCBU
aW1lOiBTYXQgSnVsICA3IDA5OjEzOjIwIDIwMTIKWyAgICAzMC4xNjZdICg9PSkgVXNpbmcgc3lz
dGVtIGNvbmZpZyBkaXJlY3RvcnkgIi91c3Ivc2hhcmUvWDExL3hvcmcuY29uZi5kIgpbICAgIDMw
LjE2Nl0gKD09KSBObyBMYXlvdXQgc2VjdGlvbi4gIFVzaW5nIHRoZSBmaXJzdCBTY3JlZW4gc2Vj
dGlvbi4KWyAgICAzMC4xNjZdICg9PSkgTm8gc2NyZWVuIHNlY3Rpb24gYXZhaWxhYmxlLiBVc2lu
ZyBkZWZhdWx0cy4KWyAgICAzMC4xNjZdICgqKikgfC0tPlNjcmVlbiAiRGVmYXVsdCBTY3JlZW4g
U2VjdGlvbiIgKDApClsgICAgMzAuMTY2XSAoKiopIHwgICB8LS0+TW9uaXRvciAiPGRlZmF1bHQg
bW9uaXRvcj4iClsgICAgMzAuMTY2XSAoPT0pIE5vIG1vbml0b3Igc3BlY2lmaWVkIGZvciBzY3Jl
ZW4gIkRlZmF1bHQgU2NyZWVuIFNlY3Rpb24iLgoJVXNpbmcgYSBkZWZhdWx0IG1vbml0b3IgY29u
ZmlndXJhdGlvbi4KWyAgICAzMC4xNjZdICg9PSkgQXV0b21hdGljYWxseSBhZGRpbmcgZGV2aWNl
cwpbICAgIDMwLjE2Nl0gKD09KSBBdXRvbWF0aWNhbGx5IGVuYWJsaW5nIGRldmljZXMKWyAgICAz
MC4xNjZdIChXVykgVGhlIGRpcmVjdG9yeSAiL3Vzci9zaGFyZS9mb250cy9YMTEvY3lyaWxsaWMi
IGRvZXMgbm90IGV4aXN0LgpbICAgIDMwLjE2Nl0gCUVudHJ5IGRlbGV0ZWQgZnJvbSBmb250IHBh
dGguClsgICAgMzAuMTY2XSAoPT0pIEZvbnRQYXRoIHNldCB0bzoKCS91c3Ivc2hhcmUvZm9udHMv
WDExL21pc2MsCgkvdXNyL3NoYXJlL2ZvbnRzL1gxMS8xMDBkcGkvOnVuc2NhbGVkLAoJL3Vzci9z
aGFyZS9mb250cy9YMTEvNzVkcGkvOnVuc2NhbGVkLAoJL3Vzci9zaGFyZS9mb250cy9YMTEvVHlw
ZTEsCgkvdXNyL3NoYXJlL2ZvbnRzL1gxMS8xMDBkcGksCgkvdXNyL3NoYXJlL2ZvbnRzL1gxMS83
NWRwaSwKCS92YXIvbGliL2RlZm9tYS94LXR0Y2lkZm9udC1jb25mLmQvZGlycy9UcnVlVHlwZSwK
CWJ1aWx0LWlucwpbICAgIDMwLjE2Nl0gKD09KSBNb2R1bGVQYXRoIHNldCB0byAiL3Vzci9saWIv
eG9yZy9tb2R1bGVzIgpbICAgIDMwLjE2Nl0gKElJKSBUaGUgc2VydmVyIHJlbGllcyBvbiB1ZGV2
IHRvIHByb3ZpZGUgdGhlIGxpc3Qgb2YgaW5wdXQgZGV2aWNlcy4KCUlmIG5vIGRldmljZXMgYmVj
b21lIGF2YWlsYWJsZSwgcmVjb25maWd1cmUgdWRldiBvciBkaXNhYmxlIEF1dG9BZGREZXZpY2Vz
LgpbICAgIDMwLjE2Nl0gKElJKSBMb2FkZXIgbWFnaWM6IDB4N2QzYWUwClsgICAgMzAuMTY2XSAo
SUkpIE1vZHVsZSBBQkkgdmVyc2lvbnM6ClsgICAgMzAuMTY2XSAJWC5PcmcgQU5TSSBDIEVtdWxh
dGlvbjogMC40ClsgICAgMzAuMTY2XSAJWC5PcmcgVmlkZW8gRHJpdmVyOiAxMC4wClsgICAgMzAu
MTY2XSAJWC5PcmcgWElucHV0IGRyaXZlciA6IDEyLjIKWyAgICAzMC4xNjZdIAlYLk9yZyBTZXJ2
ZXIgRXh0ZW5zaW9uIDogNS4wClsgICAgMzAuMTY3XSAoLS0pIFBDSToqKDA6MDoyOjApIDgwODY6
MDA0NjoxN2FhOjM5MjAgcmV2IDI0LCBNZW0gQCAweGYwMDAwMDAwLzQxOTQzMDQsIDB4ZDAwMDAw
MDAvMjY4NDM1NDU2LCBJL08gQCAweDAwMDAxODAwLzgKWyAgICAzMC4xNjddICgtLSkgUENJOiAo
MDoxOjA6MCkgMTBkZTowYTcwOjE3YWE6Mzk2OCByZXYgMTYyLCBNZW0gQCAweGFjMDAwMDAwLzE2
Nzc3MjE2LCAweGIwMDAwMDAwLzI2ODQzNTQ1NiwgMHhhZTAwMDAwMC8zMzU1NDQzMiwgSS9PIEAg
MHgwMDAwMjAwMC8xMjgsIEJJT1MgQCAweD8/Pz8/Pz8/LzUyNDI4OApbICAgIDMwLjE2N10gKElJ
KSBPcGVuIEFDUEkgc3VjY2Vzc2Z1bCAoL3Zhci9ydW4vYWNwaWQuc29ja2V0KQpbICAgIDMwLjE2
N10gKElJKSBMb2FkTW9kdWxlOiAiZXh0bW9kIgpbICAgIDMwLjE5Nl0gKElJKSBMb2FkaW5nIC91
c3IvbGliL3hvcmcvbW9kdWxlcy9leHRlbnNpb25zL2xpYmV4dG1vZC5zbwpbICAgIDMwLjE5Nl0g
KElJKSBNb2R1bGUgZXh0bW9kOiB2ZW5kb3I9IlguT3JnIEZvdW5kYXRpb24iClsgICAgMzAuMTk2
XSAJY29tcGlsZWQgZm9yIDEuMTAuNCwgbW9kdWxlIHZlcnNpb24gPSAxLjAuMApbICAgIDMwLjE5
Nl0gCU1vZHVsZSBjbGFzczogWC5PcmcgU2VydmVyIEV4dGVuc2lvbgpbICAgIDMwLjE5Nl0gCUFC
SSBjbGFzczogWC5PcmcgU2VydmVyIEV4dGVuc2lvbiwgdmVyc2lvbiA1LjAKWyAgICAzMC4xOTZd
IChJSSkgTG9hZGluZyBleHRlbnNpb24gU0VMaW51eApbICAgIDMwLjE5Nl0gKElJKSBMb2FkaW5n
IGV4dGVuc2lvbiBNSVQtU0NSRUVOLVNBVkVSClsgICAgMzAuMTk2XSAoSUkpIExvYWRpbmcgZXh0
ZW5zaW9uIFhGcmVlODYtVmlkTW9kZUV4dGVuc2lvbgpbICAgIDMwLjE5Nl0gKElJKSBMb2FkaW5n
IGV4dGVuc2lvbiBYRnJlZTg2LURHQQpbICAgIDMwLjE5Nl0gKElJKSBMb2FkaW5nIGV4dGVuc2lv
biBEUE1TClsgICAgMzAuMTk2XSAoSUkpIExvYWRpbmcgZXh0ZW5zaW9uIFhWaWRlbwpbICAgIDMw
LjE5Nl0gKElJKSBMb2FkaW5nIGV4dGVuc2lvbiBYVmlkZW8tTW90aW9uQ29tcGVuc2F0aW9uClsg
ICAgMzAuMTk2XSAoSUkpIExvYWRpbmcgZXh0ZW5zaW9uIFgtUmVzb3VyY2UKWyAgICAzMC4xOTZd
IChJSSkgTG9hZE1vZHVsZTogImRiZSIKWyAgICAzMC4xOTZdIChJSSkgTG9hZGluZyAvdXNyL2xp
Yi94b3JnL21vZHVsZXMvZXh0ZW5zaW9ucy9saWJkYmUuc28KWyAgICAzMC4xOTddIChJSSkgTW9k
dWxlIGRiZTogdmVuZG9yPSJYLk9yZyBGb3VuZGF0aW9uIgpbICAgIDMwLjE5N10gCWNvbXBpbGVk
IGZvciAxLjEwLjQsIG1vZHVsZSB2ZXJzaW9uID0gMS4wLjAKWyAgICAzMC4xOTddIAlNb2R1bGUg
Y2xhc3M6IFguT3JnIFNlcnZlciBFeHRlbnNpb24KWyAgICAzMC4xOTddIAlBQkkgY2xhc3M6IFgu
T3JnIFNlcnZlciBFeHRlbnNpb24sIHZlcnNpb24gNS4wClsgICAgMzAuMTk3XSAoSUkpIExvYWRp
bmcgZXh0ZW5zaW9uIERPVUJMRS1CVUZGRVIKWyAgICAzMC4xOTddIChJSSkgTG9hZE1vZHVsZTog
ImdseCIKWyAgICAzMC4xOTddIChJSSkgTG9hZGluZyAvdXNyL2xpYi94b3JnL21vZHVsZXMvZXh0
ZW5zaW9ucy9saWJnbHguc28KWyAgICAzMC4xOTddIChJSSkgTW9kdWxlIGdseDogdmVuZG9yPSJY
Lk9yZyBGb3VuZGF0aW9uIgpbICAgIDMwLjE5N10gCWNvbXBpbGVkIGZvciAxLjEwLjQsIG1vZHVs
ZSB2ZXJzaW9uID0gMS4wLjAKWyAgICAzMC4xOTddIAlBQkkgY2xhc3M6IFguT3JnIFNlcnZlciBF
eHRlbnNpb24sIHZlcnNpb24gNS4wClsgICAgMzAuMTk3XSAoPT0pIEFJR0xYIGVuYWJsZWQKWyAg
ICAzMC4xOTddIChJSSkgTG9hZGluZyBleHRlbnNpb24gR0xYClsgICAgMzAuMTk3XSAoSUkpIExv
YWRNb2R1bGU6ICJyZWNvcmQiClsgICAgMzAuMTk3XSAoSUkpIExvYWRpbmcgL3Vzci9saWIveG9y
Zy9tb2R1bGVzL2V4dGVuc2lvbnMvbGlicmVjb3JkLnNvClsgICAgMzAuMTk3XSAoSUkpIE1vZHVs
ZSByZWNvcmQ6IHZlbmRvcj0iWC5PcmcgRm91bmRhdGlvbiIKWyAgICAzMC4xOTddIAljb21waWxl
ZCBmb3IgMS4xMC40LCBtb2R1bGUgdmVyc2lvbiA9IDEuMTMuMApbICAgIDMwLjE5N10gCU1vZHVs
ZSBjbGFzczogWC5PcmcgU2VydmVyIEV4dGVuc2lvbgpbICAgIDMwLjE5N10gCUFCSSBjbGFzczog
WC5PcmcgU2VydmVyIEV4dGVuc2lvbiwgdmVyc2lvbiA1LjAKWyAgICAzMC4xOTddIChJSSkgTG9h
ZGluZyBleHRlbnNpb24gUkVDT1JEClsgICAgMzAuMTk3XSAoSUkpIExvYWRNb2R1bGU6ICJkcmki
ClsgICAgMzAuMTk3XSAoSUkpIExvYWRpbmcgL3Vzci9saWIveG9yZy9tb2R1bGVzL2V4dGVuc2lv
bnMvbGliZHJpLnNvClsgICAgMzAuMTk3XSAoSUkpIE1vZHVsZSBkcmk6IHZlbmRvcj0iWC5Pcmcg
Rm91bmRhdGlvbiIKWyAgICAzMC4xOTddIAljb21waWxlZCBmb3IgMS4xMC40LCBtb2R1bGUgdmVy
c2lvbiA9IDEuMC4wClsgICAgMzAuMTk4XSAJQUJJIGNsYXNzOiBYLk9yZyBTZXJ2ZXIgRXh0ZW5z
aW9uLCB2ZXJzaW9uIDUuMApbICAgIDMwLjE5OF0gKElJKSBMb2FkaW5nIGV4dGVuc2lvbiBYRnJl
ZTg2LURSSQpbICAgIDMwLjE5OF0gKElJKSBMb2FkTW9kdWxlOiAiZHJpMiIKWyAgICAzMC4xOThd
IChJSSkgTG9hZGluZyAvdXNyL2xpYi94b3JnL21vZHVsZXMvZXh0ZW5zaW9ucy9saWJkcmkyLnNv
ClsgICAgMzAuMTk4XSAoSUkpIE1vZHVsZSBkcmkyOiB2ZW5kb3I9IlguT3JnIEZvdW5kYXRpb24i
ClsgICAgMzAuMTk4XSAJY29tcGlsZWQgZm9yIDEuMTAuNCwgbW9kdWxlIHZlcnNpb24gPSAxLjIu
MApbICAgIDMwLjE5OF0gCUFCSSBjbGFzczogWC5PcmcgU2VydmVyIEV4dGVuc2lvbiwgdmVyc2lv
biA1LjAKWyAgICAzMC4xOThdIChJSSkgTG9hZGluZyBleHRlbnNpb24gRFJJMgpbICAgIDMwLjE5
OF0gKD09KSBNYXRjaGVkIGludGVsIGFzIGF1dG9jb25maWd1cmVkIGRyaXZlciAwClsgICAgMzAu
MTk4XSAoPT0pIE1hdGNoZWQgdmVzYSBhcyBhdXRvY29uZmlndXJlZCBkcml2ZXIgMQpbICAgIDMw
LjE5OF0gKD09KSBNYXRjaGVkIGZiZGV2IGFzIGF1dG9jb25maWd1cmVkIGRyaXZlciAyClsgICAg
MzAuMTk4XSAoPT0pIEFzc2lnbmVkIHRoZSBkcml2ZXIgdG8gdGhlIHhmODZDb25maWdMYXlvdXQK
WyAgICAzMC4xOThdIChJSSkgTG9hZE1vZHVsZTogImludGVsIgpbICAgIDMwLjE5OF0gKElJKSBM
b2FkaW5nIC91c3IvbGliL3hvcmcvbW9kdWxlcy9kcml2ZXJzL2ludGVsX2Rydi5zbwpbICAgIDMw
LjE5OF0gKElJKSBNb2R1bGUgaW50ZWw6IHZlbmRvcj0iWC5PcmcgRm91bmRhdGlvbiIKWyAgICAz
MC4xOThdIAljb21waWxlZCBmb3IgMS4xMC40LCBtb2R1bGUgdmVyc2lvbiA9IDIuMTUuMApbICAg
IDMwLjE5OF0gCU1vZHVsZSBjbGFzczogWC5PcmcgVmlkZW8gRHJpdmVyClsgICAgMzAuMTk4XSAJ
QUJJIGNsYXNzOiBYLk9yZyBWaWRlbyBEcml2ZXIsIHZlcnNpb24gMTAuMApbICAgIDMwLjE5OF0g
KElJKSBMb2FkTW9kdWxlOiAidmVzYSIKWyAgICAzMC4xOThdIChXVykgV2FybmluZywgY291bGRu
J3Qgb3BlbiBtb2R1bGUgdmVzYQpbICAgIDMwLjE5OF0gKElJKSBVbmxvYWRNb2R1bGU6ICJ2ZXNh
IgpbICAgIDMwLjE5OF0gKElJKSBVbmxvYWRpbmcgdmVzYQpbICAgIDMwLjE5OF0gKEVFKSBGYWls
ZWQgdG8gbG9hZCBtb2R1bGUgInZlc2EiIChtb2R1bGUgZG9lcyBub3QgZXhpc3QsIDApClsgICAg
MzAuMTk4XSAoSUkpIExvYWRNb2R1bGU6ICJmYmRldiIKWyAgICAzMC4xOTldIChXVykgV2Fybmlu
ZywgY291bGRuJ3Qgb3BlbiBtb2R1bGUgZmJkZXYKWyAgICAzMC4xOTldIChJSSkgVW5sb2FkTW9k
dWxlOiAiZmJkZXYiClsgICAgMzAuMTk5XSAoSUkpIFVubG9hZGluZyBmYmRldgpbICAgIDMwLjE5
OV0gKEVFKSBGYWlsZWQgdG8gbG9hZCBtb2R1bGUgImZiZGV2IiAobW9kdWxlIGRvZXMgbm90IGV4
aXN0LCAwKQpbICAgIDMwLjE5OV0gKElJKSBpbnRlbDogRHJpdmVyIGZvciBJbnRlbCBJbnRlZ3Jh
dGVkIEdyYXBoaWNzIENoaXBzZXRzOiBpODEwLAoJaTgxMC1kYzEwMCwgaTgxMGUsIGk4MTUsIGk4
MzBNLCA4NDVHLCA4NTQsIDg1MkdNLzg1NUdNLCA4NjVHLCA5MTVHLAoJRTcyMjEgKGk5MTUpLCA5
MTVHTSwgOTQ1RywgOTQ1R00sIDk0NUdNRSwgUGluZXZpZXcgR00sIFBpbmV2aWV3IEcsCgk5NjVH
LCBHMzUsIDk2NVEsIDk0NkdaLCA5NjVHTSwgOTY1R01FL0dMRSwgRzMzLCBRMzUsIFEzMywgR000
NSwKCTQgU2VyaWVzLCBHNDUvRzQzLCBRNDUvUTQzLCBHNDEsIEI0MywgQjQzLCBDbGFya2RhbGUs
IEFycmFuZGFsZSwKCVNhbmR5YnJpZGdlLCBTYW5keWJyaWRnZSwgU2FuZHlicmlkZ2UsIFNhbmR5
YnJpZGdlLCBTYW5keWJyaWRnZSwKCVNhbmR5YnJpZGdlLCBTYW5keWJyaWRnZQpbICAgIDMwLjE5
OV0gKCsrKSB1c2luZyBWVCBudW1iZXIgNwoKWyAgICAzMC4yMDddIChJSSkgTG9hZGluZyAvdXNy
L2xpYi94b3JnL21vZHVsZXMvZHJpdmVycy9pbnRlbF9kcnYuc28KWyAgICAzMC4yMDddIGRybU9w
ZW5EZXZpY2U6IG5vZGUgbmFtZSBpcyAvZGV2L2RyaS9jYXJkMApbICAgIDMwLjIwN10gZHJtT3Bl
bkRldmljZTogb3BlbiByZXN1bHQgaXMgOSwgKE9LKQpbICAgIDMwLjIwN10gZHJtT3BlbkJ5QnVz
aWQ6IFNlYXJjaGluZyBmb3IgQnVzSUQgcGNpOjAwMDA6MDA6MDIuMApbICAgIDMwLjIwN10gZHJt
T3BlbkRldmljZTogbm9kZSBuYW1lIGlzIC9kZXYvZHJpL2NhcmQwClsgICAgMzAuMjA3XSBkcm1P
cGVuRGV2aWNlOiBvcGVuIHJlc3VsdCBpcyA5LCAoT0spClsgICAgMzAuMjA3XSBkcm1PcGVuQnlC
dXNpZDogZHJtT3Blbk1pbm9yIHJldHVybnMgOQpbICAgIDMwLjIwN10gZHJtT3BlbkJ5QnVzaWQ6
IGRybUdldEJ1c2lkIHJlcG9ydHMgcGNpOjAwMDA6MDA6MDIuMApbICAgIDMwLjIwN10gKElJKSBp
bnRlbCgwKTogQ3JlYXRpbmcgZGVmYXVsdCBEaXNwbGF5IHN1YnNlY3Rpb24gaW4gU2NyZWVuIHNl
Y3Rpb24KCSJEZWZhdWx0IFNjcmVlbiBTZWN0aW9uIiBmb3IgZGVwdGgvZmJicHAgMjQvMzIKWyAg
ICAzMC4yMDddICg9PSkgaW50ZWwoMCk6IERlcHRoIDI0LCAoLS0pIGZyYW1lYnVmZmVyIGJwcCAz
MgpbICAgIDMwLjIwN10gKD09KSBpbnRlbCgwKTogUkdCIHdlaWdodCA4ODgKWyAgICAzMC4yMDdd
ICg9PSkgaW50ZWwoMCk6IERlZmF1bHQgdmlzdWFsIGlzIFRydWVDb2xvcgpbICAgIDMwLjIwN10g
KElJKSBpbnRlbCgwKTogSW50ZWdyYXRlZCBHcmFwaGljcyBDaGlwc2V0OiBJbnRlbChSKSBBcnJh
bmRhbGUKWyAgICAzMC4yMDddICgtLSkgaW50ZWwoMCk6IENoaXBzZXQ6ICJBcnJhbmRhbGUiClsg
ICAgMzAuMjA3XSAoKiopIGludGVsKDApOiBSZWxheGVkIGZlbmNpbmcgZW5hYmxlZApbICAgIDMw
LjIwN10gKCoqKSBpbnRlbCgwKTogRnJhbWVidWZmZXIgdGlsZWQKWyAgICAzMC4yMDddICgqKikg
aW50ZWwoMCk6IFBpeG1hcHMgdGlsZWQKWyAgICAzMC4yMDddICgqKikgaW50ZWwoMCk6IDNEIGJ1
ZmZlcnMgdGlsZWQKWyAgICAzMC4yMDddICgqKikgaW50ZWwoMCk6IFN3YXBCdWZmZXJzIHdhaXQg
ZW5hYmxlZApbICAgIDMwLjIwN10gKD09KSBpbnRlbCgwKTogdmlkZW8gb3ZlcmxheSBrZXkgc2V0
IHRvIDB4MTAxZmUKWyAgICAzMC4yMDddIChJSSkgaW50ZWwoMCk6IE91dHB1dCBMVkRTMSBoYXMg
bm8gbW9uaXRvciBzZWN0aW9uClsgICAgMzAuMjA4XSAoSUkpIGludGVsKDApOiBmb3VuZCBiYWNr
bGlnaHQgY29udHJvbCBpbnRlcmZhY2UgL3N5cy9jbGFzcy9iYWNrbGlnaHQvaW50ZWxfYmFja2xp
Z2h0ClsgICAgMzAuMjA4XSAoSUkpIGludGVsKDApOiBPdXRwdXQgVkdBMSBoYXMgbm8gbW9uaXRv
ciBzZWN0aW9uClsgICAgMzAuMjA4XSAoSUkpIGludGVsKDApOiBFRElEIGZvciBvdXRwdXQgTFZE
UzEKWyAgICAzMC4yMDhdIChJSSkgaW50ZWwoMCk6IE1hbnVmYWN0dXJlcjogQVVPICBNb2RlbDog
NDAyYyAgU2VyaWFsIzogMApbICAgIDMwLjIwOF0gKElJKSBpbnRlbCgwKTogWWVhcjogMjAxMCAg
V2VlazogMApbICAgIDMwLjIwOF0gKElJKSBpbnRlbCgwKTogRURJRCBWZXJzaW9uOiAxLjMKWyAg
ICAzMC4yMDhdIChJSSkgaW50ZWwoMCk6IERpZ2l0YWwgRGlzcGxheSBJbnB1dApbICAgIDMwLjIw
OF0gKElJKSBpbnRlbCgwKTogTWF4IEltYWdlIFNpemUgW2NtXTogaG9yaXouOiAyOSAgdmVydC46
IDE2ClsgICAgMzAuMjA4XSAoSUkpIGludGVsKDApOiBHYW1tYTogMi4yMApbICAgIDMwLjIwOF0g
KElJKSBpbnRlbCgwKTogTm8gRFBNUyBjYXBhYmlsaXRpZXMgc3BlY2lmaWVkClsgICAgMzAuMjA4
XSAoSUkpIGludGVsKDApOiBTdXBwb3J0ZWQgY29sb3IgZW5jb2RpbmdzOiBSR0IgNDo0OjQgWUNy
Q2IgNDo0OjQgClsgICAgMzAuMjA4XSAoSUkpIGludGVsKDApOiBGaXJzdCBkZXRhaWxlZCB0aW1p
bmcgaXMgcHJlZmVycmVkIG1vZGUKWyAgICAzMC4yMDhdIChJSSkgaW50ZWwoMCk6IHJlZFg6IDAu
NTkwIHJlZFk6IDAuMzQ1ICAgZ3JlZW5YOiAwLjMyNSBncmVlblk6IDAuNTQwClsgICAgMzAuMjA4
XSAoSUkpIGludGVsKDApOiBibHVlWDogMC4xNTAgYmx1ZVk6IDAuMTQ1ICAgd2hpdGVYOiAwLjMx
MyB3aGl0ZVk6IDAuMzI5ClsgICAgMzAuMjA4XSAoSUkpIGludGVsKDApOiBNYW51ZmFjdHVyZXIn
cyBtYXNrOiAwClsgICAgMzAuMjA4XSAoSUkpIGludGVsKDApOiBTdXBwb3J0ZWQgZGV0YWlsZWQg
dGltaW5nOgpbICAgIDMwLjIwOF0gKElJKSBpbnRlbCgwKTogY2xvY2s6IDY5LjMgTUh6ICAgSW1h
Z2UgU2l6ZTogIDI5MyB4IDE2NCBtbQpbICAgIDMwLjIwOF0gKElJKSBpbnRlbCgwKTogaF9hY3Rp
dmU6IDEzNjYgIGhfc3luYzogMTQxNCAgaF9zeW5jX2VuZCAxNDQ2IGhfYmxhbmtfZW5kIDE0NTYg
aF9ib3JkZXI6IDAKWyAgICAzMC4yMDhdIChJSSkgaW50ZWwoMCk6IHZfYWN0aXZlOiA3NjggIHZf
c3luYzogNzcxICB2X3N5bmNfZW5kIDc3NyB2X2JsYW5raW5nOiA3OTMgdl9ib3JkZXI6IDAKWyAg
ICAzMC4yMDhdIChJSSkgaW50ZWwoMCk6IFVua25vd24gdmVuZG9yLXNwZWNpZmljIGJsb2NrIGYK
WyAgICAzMC4yMDhdIChJSSkgaW50ZWwoMCk6ICBBVU8KWyAgICAzMC4yMDhdIChJSSkgaW50ZWwo
MCk6ICBCMTMzWFcwNCBWMApbICAgIDMwLjIwOF0gKElJKSBpbnRlbCgwKTogRURJRCAoaW4gaGV4
KToKWyAgICAzMC4yMDhdIChJSSkgaW50ZWwoMCk6IAkwMGZmZmZmZmZmZmZmZjAwMDZhZjJjNDAw
MDAwMDAwMApbICAgIDMwLjIwOF0gKElJKSBpbnRlbCgwKTogCTAwMTQwMTAzODAxZDEwNzgwYTE1
ODU5NzU4NTM4YTI2ClsgICAgMzAuMjA4XSAoSUkpIGludGVsKDApOiAJMjU1MDU0MDAwMDAwMDEw
MTAxMDEwMTAxMDEwMTAxMDEKWyAgICAzMC4yMDhdIChJSSkgaW50ZWwoMCk6IAkwMTAxMDEwMTAx
MDExMjFiNTY1YTUwMDAxOTMwMzAyMApbICAgIDMwLjIwOF0gKElJKSBpbnRlbCgwKTogCTM2MDAy
NWE0MTAwMDAwMTgwMDAwMDAwZjAwMDAwMDAwClsgICAgMzAuMjA4XSAoSUkpIGludGVsKDApOiAJ
MDAwMDAwMDAwMDAwMDAwMDAwMjAwMDAwMDBmZTAwNDEKWyAgICAzMC4yMDhdIChJSSkgaW50ZWwo
MCk6IAk1NTRmMGEyMDIwMjAyMDIwMjAyMDIwMjAwMDAwMDBmZQpbICAgIDMwLjIwOF0gKElJKSBp
bnRlbCgwKTogCTAwNDIzMTMzMzM1ODU3MzAzNDIwNTYzMDIwMGEwMDU2ClsgICAgMzAuMjA4XSAo
SUkpIGludGVsKDApOiBFRElEIHZlbmRvciAiQVVPIiwgcHJvZCBpZCAxNjQyOApbICAgIDMwLjIw
OF0gKElJKSBpbnRlbCgwKTogUHJpbnRpbmcgRERDIGdhdGhlcmVkIE1vZGVsaW5lczoKWyAgICAz
MC4yMDhdIChJSSkgaW50ZWwoMCk6IE1vZGVsaW5lICIxMzY2eDc2OCJ4MC4wICAgNjkuMzAgIDEz
NjYgMTQxNCAxNDQ2IDE0NTYgIDc2OCA3NzEgNzc3IDc5MyAtaHN5bmMgLXZzeW5jICg0Ny42IGtI
eikKWyAgICAzMC4yMDhdIChJSSkgaW50ZWwoMCk6IE5vdCB1c2luZyBkZWZhdWx0IG1vZGUgIjMy
MHgyNDAiIChkb3VibGVzY2FuIG1vZGUgbm90IHN1cHBvcnRlZCkKWyAgICAzMC4yMDhdIChJSSkg
aW50ZWwoMCk6IE5vdCB1c2luZyBkZWZhdWx0IG1vZGUgIjQwMHgzMDAiIChkb3VibGVzY2FuIG1v
ZGUgbm90IHN1cHBvcnRlZCkKWyAgICAzMC4yMDhdIChJSSkgaW50ZWwoMCk6IE5vdCB1c2luZyBk
ZWZhdWx0IG1vZGUgIjQwMHgzMDAiIChkb3VibGVzY2FuIG1vZGUgbm90IHN1cHBvcnRlZCkKWyAg
ICAzMC4yMDhdIChJSSkgaW50ZWwoMCk6IE5vdCB1c2luZyBkZWZhdWx0IG1vZGUgIjUxMngzODQi
IChkb3VibGVzY2FuIG1vZGUgbm90IHN1cHBvcnRlZCkKWyAgICAzMC4yMDhdIChJSSkgaW50ZWwo
MCk6IE5vdCB1c2luZyBkZWZhdWx0IG1vZGUgIjY0MHg0ODAiIChkb3VibGVzY2FuIG1vZGUgbm90
IHN1cHBvcnRlZCkKWyAgICAzMC4yMDhdIChJSSkgaW50ZWwoMCk6IE5vdCB1c2luZyBkZWZhdWx0
IG1vZGUgIjY0MHg1MTIiIChkb3VibGVzY2FuIG1vZGUgbm90IHN1cHBvcnRlZCkKWyAgICAzMC4y
MDhdIChJSSkgaW50ZWwoMCk6IE5vdCB1c2luZyBkZWZhdWx0IG1vZGUgIjgwMHg2MDAiIChkb3Vi
bGVzY2FuIG1vZGUgbm90IHN1cHBvcnRlZCkKWyAgICAzMC4yMDhdIChJSSkgaW50ZWwoMCk6IE5v
dCB1c2luZyBkZWZhdWx0IG1vZGUgIjg5Nng2NzIiIChkb3VibGVzY2FuIG1vZGUgbm90IHN1cHBv
cnRlZCkKWyAgICAzMC4yMDhdIChJSSkgaW50ZWwoMCk6IE5vdCB1c2luZyBkZWZhdWx0IG1vZGUg
IjkyOHg2OTYiIChkb3VibGVzY2FuIG1vZGUgbm90IHN1cHBvcnRlZCkKWyAgICAzMC4yMDhdIChJ
SSkgaW50ZWwoMCk6IE5vdCB1c2luZyBkZWZhdWx0IG1vZGUgIjk2MHg3MjAiIChkb3VibGVzY2Fu
IG1vZGUgbm90IHN1cHBvcnRlZCkKWyAgICAzMC4yMDhdIChJSSkgaW50ZWwoMCk6IE5vdCB1c2lu
ZyBkZWZhdWx0IG1vZGUgIjU3Nng0MzIiIChkb3VibGVzY2FuIG1vZGUgbm90IHN1cHBvcnRlZCkK
WyAgICAzMC4yMDhdIChJSSkgaW50ZWwoMCk6IE5vdCB1c2luZyBkZWZhdWx0IG1vZGUgIjY4MHgz
ODQiIChkb3VibGVzY2FuIG1vZGUgbm90IHN1cHBvcnRlZCkKWyAgICAzMC4yMDhdIChJSSkgaW50
ZWwoMCk6IE5vdCB1c2luZyBkZWZhdWx0IG1vZGUgIjY4MHgzODQiIChkb3VibGVzY2FuIG1vZGUg
bm90IHN1cHBvcnRlZCkKWyAgICAzMC4yMDhdIChJSSkgaW50ZWwoMCk6IE5vdCB1c2luZyBkZWZh
dWx0IG1vZGUgIjcwMHg1MjUiIChkb3VibGVzY2FuIG1vZGUgbm90IHN1cHBvcnRlZCkKWyAgICAz
MC4yMDhdIChJSSkgaW50ZWwoMCk6IE5vdCB1c2luZyBkZWZhdWx0IG1vZGUgIjcyMHg0NTAiIChk
b3VibGVzY2FuIG1vZGUgbm90IHN1cHBvcnRlZCkKWyAgICAzMC4yMDhdIChJSSkgaW50ZWwoMCk6
IE5vdCB1c2luZyBkZWZhdWx0IG1vZGUgIjgwMHg1MTIiIChkb3VibGVzY2FuIG1vZGUgbm90IHN1
cHBvcnRlZCkKWyAgICAzMC4yMDhdIChJSSkgaW50ZWwoMCk6IE5vdCB1c2luZyBkZWZhdWx0IG1v
ZGUgIjg0MHg1MjUiIChkb3VibGVzY2FuIG1vZGUgbm90IHN1cHBvcnRlZCkKWyAgICAzMC4yMDhd
IChJSSkgaW50ZWwoMCk6IE5vdCB1c2luZyBkZWZhdWx0IG1vZGUgIjg0MHg1MjUiIChkb3VibGVz
Y2FuIG1vZGUgbm90IHN1cHBvcnRlZCkKWyAgICAzMC4yMDhdIChJSSkgaW50ZWwoMCk6IE5vdCB1
c2luZyBkZWZhdWx0IG1vZGUgIjk2MHg1NDAiIChkb3VibGVzY2FuIG1vZGUgbm90IHN1cHBvcnRl
ZCkKWyAgICAzMC4yMDhdIChJSSkgaW50ZWwoMCk6IE5vdCB1c2luZyBkZWZhdWx0IG1vZGUgIjk2
MHg2MDAiIChkb3VibGVzY2FuIG1vZGUgbm90IHN1cHBvcnRlZCkKWyAgICAzMC4yMDhdIChJSSkg
aW50ZWwoMCk6IE5vdCB1c2luZyBkZWZhdWx0IG1vZGUgIjEwMjR4NzY4IiAoZG91Ymxlc2NhbiBt
b2RlIG5vdCBzdXBwb3J0ZWQpClsgICAgMzAuMjA4XSAoSUkpIGludGVsKDApOiBQcmludGluZyBw
cm9iZWQgbW9kZXMgZm9yIG91dHB1dCBMVkRTMQpbICAgIDMwLjIwOF0gKElJKSBpbnRlbCgwKTog
TW9kZWxpbmUgIjEzNjZ4NzY4Ing2MC4wICAgNjkuMzAgIDEzNjYgMTQxNCAxNDQ2IDE0NTYgIDc2
OCA3NzEgNzc3IDc5MyAtaHN5bmMgLXZzeW5jICg0Ny42IGtIeikKWyAgICAzMC4yMDhdIChJSSkg
aW50ZWwoMCk6IE1vZGVsaW5lICIxMzYweDc2OCJ4NTkuOCAgIDg0Ljc1ICAxMzYwIDE0MzIgMTU2
OCAxNzc2ICA3NjggNzcxIDc4MSA3OTggLWhzeW5jICt2c3luYyAoNDcuNyBrSHopClsgICAgMzAu
MjA4XSAoSUkpIGludGVsKDApOiBNb2RlbGluZSAiMTM2MHg3NjgieDYwLjAgICA3Mi4wMCAgMTM2
MCAxNDA4IDE0NDAgMTUyMCAgNzY4IDc3MSA3ODEgNzkwICtoc3luYyAtdnN5bmMgKDQ3LjQga0h6
KQpbICAgIDMwLjIwOF0gKElJKSBpbnRlbCgwKTogTW9kZWxpbmUgIjEwMjR4NzY4Ing2MC4wICAg
NjUuMDAgIDEwMjQgMTA0OCAxMTg0IDEzNDQgIDc2OCA3NzEgNzc3IDgwNiAtaHN5bmMgLXZzeW5j
ICg0OC40IGtIeikKWyAgICAzMC4yMDhdIChJSSkgaW50ZWwoMCk6IE1vZGVsaW5lICI4MDB4NjAw
Ing2MC4zICAgNDAuMDAgIDgwMCA4NDAgOTY4IDEwNTYgIDYwMCA2MDEgNjA1IDYyOCAraHN5bmMg
K3ZzeW5jICgzNy45IGtIeikKWyAgICAzMC4yMDhdIChJSSkgaW50ZWwoMCk6IE1vZGVsaW5lICI4
MDB4NjAwIng1Ni4yICAgMzYuMDAgIDgwMCA4MjQgODk2IDEwMjQgIDYwMCA2MDEgNjAzIDYyNSAr
aHN5bmMgK3ZzeW5jICgzNS4yIGtIeikKWyAgICAzMC4yMDhdIChJSSkgaW50ZWwoMCk6IE1vZGVs
aW5lICI2NDB4NDgwIng1OS45ICAgMjUuMTggIDY0MCA2NTYgNzUyIDgwMCAgNDgwIDQ5MCA0OTIg
NTI1IC1oc3luYyAtdnN5bmMgKDMxLjUga0h6KQpbICAgIDMwLjIwOF0gKElJKSBpbnRlbCgwKTog
RURJRCBmb3Igb3V0cHV0IFZHQTEKWyAgICAzMC4yMDhdIChJSSkgaW50ZWwoMCk6IE91dHB1dCBM
VkRTMSBjb25uZWN0ZWQKWyAgICAzMC4yMDhdIChJSSkgaW50ZWwoMCk6IE91dHB1dCBWR0ExIGRp
c2Nvbm5lY3RlZApbICAgIDMwLjIwOF0gKElJKSBpbnRlbCgwKTogVXNpbmcgZXhhY3Qgc2l6ZXMg
Zm9yIGluaXRpYWwgbW9kZXMKWyAgICAzMC4yMDldIChJSSkgaW50ZWwoMCk6IE91dHB1dCBMVkRT
MSB1c2luZyBpbml0aWFsIG1vZGUgMTM2Nng3NjgKWyAgICAzMC4yMDldIChJSSkgaW50ZWwoMCk6
IFVzaW5nIGRlZmF1bHQgZ2FtbWEgb2YgKDEuMCwgMS4wLCAxLjApIHVubGVzcyBvdGhlcndpc2Ug
c3RhdGVkLgpbICAgIDMwLjIwOV0gKElJKSBpbnRlbCgwKTogS2VybmVsIHBhZ2UgZmxpcHBpbmcg
c3VwcG9ydCBkZXRlY3RlZCwgZW5hYmxpbmcKWyAgICAzMC4yMDldICgqKikgaW50ZWwoMCk6IERp
c3BsYXkgZGltZW5zaW9uczogKDI5MCwgMTYwKSBtbQpbICAgIDMwLjIwOV0gKCoqKSBpbnRlbCgw
KTogRFBJIHNldCB0byAoMTE5LCAxMjEpClsgICAgMzAuMjA5XSAoSUkpIExvYWRpbmcgc3ViIG1v
ZHVsZSAiZmIiClsgICAgMzAuMjA5XSAoSUkpIExvYWRNb2R1bGU6ICJmYiIKWyAgICAzMC4yMDld
IChJSSkgTG9hZGluZyAvdXNyL2xpYi94b3JnL21vZHVsZXMvbGliZmIuc28KWyAgICAzMC4yMDld
IChJSSkgTW9kdWxlIGZiOiB2ZW5kb3I9IlguT3JnIEZvdW5kYXRpb24iClsgICAgMzAuMjA5XSAJ
Y29tcGlsZWQgZm9yIDEuMTAuNCwgbW9kdWxlIHZlcnNpb24gPSAxLjAuMApbICAgIDMwLjIwOV0g
CUFCSSBjbGFzczogWC5PcmcgQU5TSSBDIEVtdWxhdGlvbiwgdmVyc2lvbiAwLjQKWyAgICAzMC4y
MDldIChJSSkgTG9hZGluZyBzdWIgbW9kdWxlICJkcmkyIgpbICAgIDMwLjIwOV0gKElJKSBMb2Fk
TW9kdWxlOiAiZHJpMiIKWyAgICAzMC4yMDldIChJSSkgTG9hZGluZyAvdXNyL2xpYi94b3JnL21v
ZHVsZXMvZXh0ZW5zaW9ucy9saWJkcmkyLnNvClsgICAgMzAuMjA5XSAoSUkpIE1vZHVsZSBkcmky
OiB2ZW5kb3I9IlguT3JnIEZvdW5kYXRpb24iClsgICAgMzAuMjA5XSAJY29tcGlsZWQgZm9yIDEu
MTAuNCwgbW9kdWxlIHZlcnNpb24gPSAxLjIuMApbICAgIDMwLjIwOV0gCUFCSSBjbGFzczogWC5P
cmcgU2VydmVyIEV4dGVuc2lvbiwgdmVyc2lvbiA1LjAKWyAgICAzMC4yMDldICg9PSkgRGVwdGgg
MjQgcGl4bWFwIGZvcm1hdCBpcyAzMiBicHAKWyAgICAzMC4yMDldIChJSSkgaW50ZWwoMCk6IFtE
UkkyXSBTZXR1cCBjb21wbGV0ZQpbICAgIDMwLjIwOV0gKElJKSBpbnRlbCgwKTogW0RSSTJdICAg
RFJJIGRyaXZlcjogaTk2NQpbICAgIDMwLjIwOV0gKElJKSBpbnRlbCgwKTogQWxsb2NhdGVkIG5l
dyBmcmFtZSBidWZmZXIgMTQwOHg3Njggc3RyaWRlIDU2MzIsIHRpbGVkClsgICAgMzAuMjE3XSAo
SUkpIFVYQSgwKTogRHJpdmVyIHJlZ2lzdGVyZWQgc3VwcG9ydCBmb3IgdGhlIGZvbGxvd2luZyBv
cGVyYXRpb25zOgpbICAgIDMwLjIxN10gKElJKSAgICAgICAgIHNvbGlkClsgICAgMzAuMjE3XSAo
SUkpICAgICAgICAgY29weQpbICAgIDMwLjIxN10gKElJKSAgICAgICAgIGNvbXBvc2l0ZSAoUkVO
REVSIGFjY2VsZXJhdGlvbikKWyAgICAzMC4yMTddIChJSSkgICAgICAgICBwdXRfaW1hZ2UKWyAg
ICAzMC4yMTddIChJSSkgICAgICAgICBnZXRfaW1hZ2UKWyAgICAzMC4yMTddICg9PSkgaW50ZWwo
MCk6IEJhY2tpbmcgc3RvcmUgZGlzYWJsZWQKWyAgICAzMC4yMTddICg9PSkgaW50ZWwoMCk6IFNp
bGtlbiBtb3VzZSBlbmFibGVkClsgICAgMzAuMjE3XSAoSUkpIGludGVsKDApOiBJbml0aWFsaXpp
bmcgSFcgQ3Vyc29yClsgICAgMzAuMjgwXSAoSUkpIGludGVsKDApOiBSYW5kUiAxLjIgZW5hYmxl
ZCwgaWdub3JlIHRoZSBmb2xsb3dpbmcgUmFuZFIgZGlzYWJsZWQgbWVzc2FnZS4KWyAgICAzMC4y
ODBdICg9PSkgaW50ZWwoMCk6IERQTVMgZW5hYmxlZApbICAgIDMwLjI4MF0gKD09KSBpbnRlbCgw
KTogSW50ZWwgWHZNQyBkZWNvZGVyIGVuYWJsZWQKWyAgICAzMC4yODBdIChJSSkgaW50ZWwoMCk6
IFNldCB1cCB0ZXh0dXJlZCB2aWRlbwpbICAgIDMwLjI4MF0gKElJKSBpbnRlbCgwKTogW1h2TUNd
IHh2bWNfdmxkIGRyaXZlciBpbml0aWFsaXplZC4KWyAgICAzMC4yODBdIChJSSkgaW50ZWwoMCk6
IGRpcmVjdCByZW5kZXJpbmc6IERSSTIgRW5hYmxlZApbICAgIDMwLjI4MF0gKD09KSBpbnRlbCgw
KTogaG90cGx1ZyBkZXRlY3Rpb246ICJlbmFibGVkIgpbICAgIDMwLjI4MF0gKC0tKSBSYW5kUiBk
aXNhYmxlZApbICAgIDMwLjI4MV0gKElJKSBJbml0aWFsaXppbmcgYnVpbHQtaW4gZXh0ZW5zaW9u
IEdlbmVyaWMgRXZlbnQgRXh0ZW5zaW9uClsgICAgMzAuMjgxXSAoSUkpIEluaXRpYWxpemluZyBi
dWlsdC1pbiBleHRlbnNpb24gU0hBUEUKWyAgICAzMC4yODFdIChJSSkgSW5pdGlhbGl6aW5nIGJ1
aWx0LWluIGV4dGVuc2lvbiBNSVQtU0hNClsgICAgMzAuMjgxXSAoSUkpIEluaXRpYWxpemluZyBi
dWlsdC1pbiBleHRlbnNpb24gWElucHV0RXh0ZW5zaW9uClsgICAgMzAuMjgxXSAoSUkpIEluaXRp
YWxpemluZyBidWlsdC1pbiBleHRlbnNpb24gWFRFU1QKWyAgICAzMC4yODFdIChJSSkgSW5pdGlh
bGl6aW5nIGJ1aWx0LWluIGV4dGVuc2lvbiBCSUctUkVRVUVTVFMKWyAgICAzMC4yODFdIChJSSkg
SW5pdGlhbGl6aW5nIGJ1aWx0LWluIGV4dGVuc2lvbiBTWU5DClsgICAgMzAuMjgxXSAoSUkpIElu
aXRpYWxpemluZyBidWlsdC1pbiBleHRlbnNpb24gWEtFWUJPQVJEClsgICAgMzAuMjgxXSAoSUkp
IEluaXRpYWxpemluZyBidWlsdC1pbiBleHRlbnNpb24gWEMtTUlTQwpbICAgIDMwLjI4MV0gKElJ
KSBJbml0aWFsaXppbmcgYnVpbHQtaW4gZXh0ZW5zaW9uIFNFQ1VSSVRZClsgICAgMzAuMjgxXSAo
SUkpIEluaXRpYWxpemluZyBidWlsdC1pbiBleHRlbnNpb24gWElORVJBTUEKWyAgICAzMC4yODFd
IChJSSkgSW5pdGlhbGl6aW5nIGJ1aWx0LWluIGV4dGVuc2lvbiBYRklYRVMKWyAgICAzMC4yODFd
IChJSSkgSW5pdGlhbGl6aW5nIGJ1aWx0LWluIGV4dGVuc2lvbiBSRU5ERVIKWyAgICAzMC4yODFd
IChJSSkgSW5pdGlhbGl6aW5nIGJ1aWx0LWluIGV4dGVuc2lvbiBSQU5EUgpbICAgIDMwLjI4MV0g
KElJKSBJbml0aWFsaXppbmcgYnVpbHQtaW4gZXh0ZW5zaW9uIENPTVBPU0lURQpbICAgIDMwLjI4
MV0gKElJKSBJbml0aWFsaXppbmcgYnVpbHQtaW4gZXh0ZW5zaW9uIERBTUFHRQpbICAgIDMwLjI4
MV0gKElJKSBTRUxpbnV4OiBEaXNhYmxlZCBvbiBzeXN0ZW0KWyAgICAzMC4yOTddIChJSSkgQUlH
TFg6IGVuYWJsZWQgR0xYX01FU0FfY29weV9zdWJfYnVmZmVyClsgICAgMzAuMjk3XSAoSUkpIEFJ
R0xYOiBlbmFibGVkIEdMWF9JTlRFTF9zd2FwX2V2ZW50ClsgICAgMzAuMjk3XSAoSUkpIEFJR0xY
OiBlbmFibGVkIEdMWF9TR0lfc3dhcF9jb250cm9sIGFuZCBHTFhfTUVTQV9zd2FwX2NvbnRyb2wK
WyAgICAzMC4yOTddIChJSSkgQUlHTFg6IGVuYWJsZWQgR0xYX1NHSV9tYWtlX2N1cnJlbnRfcmVh
ZApbICAgIDMwLjI5N10gKElJKSBBSUdMWDogR0xYX0VYVF90ZXh0dXJlX2Zyb21fcGl4bWFwIGJh
Y2tlZCBieSBidWZmZXIgb2JqZWN0cwpbICAgIDMwLjI5N10gKElJKSBBSUdMWDogTG9hZGVkIGFu
ZCBpbml0aWFsaXplZCAvdXNyL2xpYi9kcmkvaTk2NV9kcmkuc28KWyAgICAzMC4yOTddIChJSSkg
R0xYOiBJbml0aWFsaXplZCBEUkkyIEdMIHByb3ZpZGVyIGZvciBzY3JlZW4gMApbICAgIDMwLjI5
OF0gKElJKSBpbnRlbCgwKTogU2V0dGluZyBzY3JlZW4gcGh5c2ljYWwgc2l6ZSB0byAzNjEgeCAy
MDMKWyAgICAzMC4zODldIChJSSkgY29uZmlnL3VkZXY6IEFkZGluZyBpbnB1dCBkZXZpY2UgUG93
ZXIgQnV0dG9uICgvZGV2L2lucHV0L2V2ZW50NSkKWyAgICAzMC4zODldICgqKikgUG93ZXIgQnV0
dG9uOiBBcHBseWluZyBJbnB1dENsYXNzICJldmRldiBrZXlib2FyZCBjYXRjaGFsbCIKWyAgICAz
MC4zODldIChJSSkgTG9hZE1vZHVsZTogImV2ZGV2IgpbICAgIDMwLjM4OV0gKElJKSBMb2FkaW5n
IC91c3IvbGliL3hvcmcvbW9kdWxlcy9pbnB1dC9ldmRldl9kcnYuc28KWyAgICAzMC4zODldIChJ
SSkgTW9kdWxlIGV2ZGV2OiB2ZW5kb3I9IlguT3JnIEZvdW5kYXRpb24iClsgICAgMzAuMzg5XSAJ
Y29tcGlsZWQgZm9yIDEuMTAuMywgbW9kdWxlIHZlcnNpb24gPSAyLjYuMApbICAgIDMwLjM4OV0g
CU1vZHVsZSBjbGFzczogWC5PcmcgWElucHV0IERyaXZlcgpbICAgIDMwLjM4OV0gCUFCSSBjbGFz
czogWC5PcmcgWElucHV0IGRyaXZlciwgdmVyc2lvbiAxMi4yClsgICAgMzAuMzg5XSAoSUkpIFVz
aW5nIGlucHV0IGRyaXZlciAnZXZkZXYnIGZvciAnUG93ZXIgQnV0dG9uJwpbICAgIDMwLjM4OV0g
KElJKSBMb2FkaW5nIC91c3IvbGliL3hvcmcvbW9kdWxlcy9pbnB1dC9ldmRldl9kcnYuc28KWyAg
ICAzMC4zODldICgqKikgUG93ZXIgQnV0dG9uOiBhbHdheXMgcmVwb3J0cyBjb3JlIGV2ZW50cwpb
ICAgIDMwLjM4OV0gKCoqKSBQb3dlciBCdXR0b246IERldmljZTogIi9kZXYvaW5wdXQvZXZlbnQ1
IgpbICAgIDMwLjM4OV0gKC0tKSBQb3dlciBCdXR0b246IEZvdW5kIGtleXMKWyAgICAzMC4zODld
IChJSSkgUG93ZXIgQnV0dG9uOiBDb25maWd1cmluZyBhcyBrZXlib2FyZApbICAgIDMwLjM4OV0g
KCoqKSBPcHRpb24gImNvbmZpZ19pbmZvIiAidWRldjovc3lzL2RldmljZXMvTE5YU1lTVE06MDAv
TE5YUFdSQk46MDAvaW5wdXQvaW5wdXQ1L2V2ZW50NSIKWyAgICAzMC4zODldIChJSSkgWElOUFVU
OiBBZGRpbmcgZXh0ZW5kZWQgaW5wdXQgZGV2aWNlICJQb3dlciBCdXR0b24iICh0eXBlOiBLRVlC
T0FSRCkKWyAgICAzMC4zODldICgqKikgT3B0aW9uICJ4a2JfcnVsZXMiICJldmRldiIKWyAgICAz
MC4zODldICgqKikgT3B0aW9uICJ4a2JfbW9kZWwiICJwYzEwNSIKWyAgICAzMC4zODldICgqKikg
T3B0aW9uICJ4a2JfbGF5b3V0IiAidXMiClsgICAgMzAuMzkzXSAoSUkpIGNvbmZpZy91ZGV2OiBB
ZGRpbmcgaW5wdXQgZGV2aWNlIFZpZGVvIEJ1cyAoL2Rldi9pbnB1dC9ldmVudDExKQpbICAgIDMw
LjM5NF0gKCoqKSBWaWRlbyBCdXM6IEFwcGx5aW5nIElucHV0Q2xhc3MgImV2ZGV2IGtleWJvYXJk
IGNhdGNoYWxsIgpbICAgIDMwLjM5NF0gKElJKSBVc2luZyBpbnB1dCBkcml2ZXIgJ2V2ZGV2JyBm
b3IgJ1ZpZGVvIEJ1cycKWyAgICAzMC4zOTRdIChJSSkgTG9hZGluZyAvdXNyL2xpYi94b3JnL21v
ZHVsZXMvaW5wdXQvZXZkZXZfZHJ2LnNvClsgICAgMzAuMzk0XSAoKiopIFZpZGVvIEJ1czogYWx3
YXlzIHJlcG9ydHMgY29yZSBldmVudHMKWyAgICAzMC4zOTRdICgqKikgVmlkZW8gQnVzOiBEZXZp
Y2U6ICIvZGV2L2lucHV0L2V2ZW50MTEiClsgICAgMzAuMzk0XSAoLS0pIFZpZGVvIEJ1czogRm91
bmQga2V5cwpbICAgIDMwLjM5NF0gKElJKSBWaWRlbyBCdXM6IENvbmZpZ3VyaW5nIGFzIGtleWJv
YXJkClsgICAgMzAuMzk0XSAoKiopIE9wdGlvbiAiY29uZmlnX2luZm8iICJ1ZGV2Oi9zeXMvZGV2
aWNlcy9MTlhTWVNUTTowMC9kZXZpY2U6MDAvUE5QMEEwODowMC9MTlhWSURFTzowMS9pbnB1dC9p
bnB1dDExL2V2ZW50MTEiClsgICAgMzAuMzk0XSAoSUkpIFhJTlBVVDogQWRkaW5nIGV4dGVuZGVk
IGlucHV0IGRldmljZSAiVmlkZW8gQnVzIiAodHlwZTogS0VZQk9BUkQpClsgICAgMzAuMzk0XSAo
KiopIE9wdGlvbiAieGtiX3J1bGVzIiAiZXZkZXYiClsgICAgMzAuMzk0XSAoKiopIE9wdGlvbiAi
eGtiX21vZGVsIiAicGMxMDUiClsgICAgMzAuMzk0XSAoKiopIE9wdGlvbiAieGtiX2xheW91dCIg
InVzIgpbICAgIDMwLjQwMl0gKElJKSBjb25maWcvdWRldjogQWRkaW5nIGlucHV0IGRldmljZSBQ
b3dlciBCdXR0b24gKC9kZXYvaW5wdXQvZXZlbnQzKQpbICAgIDMwLjQwMl0gKCoqKSBQb3dlciBC
dXR0b246IEFwcGx5aW5nIElucHV0Q2xhc3MgImV2ZGV2IGtleWJvYXJkIGNhdGNoYWxsIgpbICAg
IDMwLjQwMl0gKElJKSBVc2luZyBpbnB1dCBkcml2ZXIgJ2V2ZGV2JyBmb3IgJ1Bvd2VyIEJ1dHRv
bicKWyAgICAzMC40MDJdIChJSSkgTG9hZGluZyAvdXNyL2xpYi94b3JnL21vZHVsZXMvaW5wdXQv
ZXZkZXZfZHJ2LnNvClsgICAgMzAuNDAyXSAoKiopIFBvd2VyIEJ1dHRvbjogYWx3YXlzIHJlcG9y
dHMgY29yZSBldmVudHMKWyAgICAzMC40MDJdICgqKikgUG93ZXIgQnV0dG9uOiBEZXZpY2U6ICIv
ZGV2L2lucHV0L2V2ZW50MyIKWyAgICAzMC40MDJdICgtLSkgUG93ZXIgQnV0dG9uOiBGb3VuZCBr
ZXlzClsgICAgMzAuNDAyXSAoSUkpIFBvd2VyIEJ1dHRvbjogQ29uZmlndXJpbmcgYXMga2V5Ym9h
cmQKWyAgICAzMC40MDJdICgqKikgT3B0aW9uICJjb25maWdfaW5mbyIgInVkZXY6L3N5cy9kZXZp
Y2VzL0xOWFNZU1RNOjAwL2RldmljZTowMC9QTlAwQzBDOjAwL2lucHV0L2lucHV0My9ldmVudDMi
ClsgICAgMzAuNDAyXSAoSUkpIFhJTlBVVDogQWRkaW5nIGV4dGVuZGVkIGlucHV0IGRldmljZSAi
UG93ZXIgQnV0dG9uIiAodHlwZTogS0VZQk9BUkQpClsgICAgMzAuNDAyXSAoKiopIE9wdGlvbiAi
eGtiX3J1bGVzIiAiZXZkZXYiClsgICAgMzAuNDAyXSAoKiopIE9wdGlvbiAieGtiX21vZGVsIiAi
cGMxMDUiClsgICAgMzAuNDAyXSAoKiopIE9wdGlvbiAieGtiX2xheW91dCIgInVzIgpbICAgIDMw
LjQwMl0gKElJKSBjb25maWcvdWRldjogQWRkaW5nIGlucHV0IGRldmljZSBMaWQgU3dpdGNoICgv
ZGV2L2lucHV0L2V2ZW50MikKWyAgICAzMC40MDNdIChJSSkgTm8gaW5wdXQgZHJpdmVyL2lkZW50
aWZpZXIgc3BlY2lmaWVkIChpZ25vcmluZykKWyAgICAzMC40MDNdIChJSSkgY29uZmlnL3VkZXY6
IEFkZGluZyBpbnB1dCBkZXZpY2UgU2xlZXAgQnV0dG9uICgvZGV2L2lucHV0L2V2ZW50NCkKWyAg
ICAzMC40MDNdICgqKikgU2xlZXAgQnV0dG9uOiBBcHBseWluZyBJbnB1dENsYXNzICJldmRldiBr
ZXlib2FyZCBjYXRjaGFsbCIKWyAgICAzMC40MDNdIChJSSkgVXNpbmcgaW5wdXQgZHJpdmVyICdl
dmRldicgZm9yICdTbGVlcCBCdXR0b24nClsgICAgMzAuNDAzXSAoSUkpIExvYWRpbmcgL3Vzci9s
aWIveG9yZy9tb2R1bGVzL2lucHV0L2V2ZGV2X2Rydi5zbwpbICAgIDMwLjQwM10gKCoqKSBTbGVl
cCBCdXR0b246IGFsd2F5cyByZXBvcnRzIGNvcmUgZXZlbnRzClsgICAgMzAuNDAzXSAoKiopIFNs
ZWVwIEJ1dHRvbjogRGV2aWNlOiAiL2Rldi9pbnB1dC9ldmVudDQiClsgICAgMzAuNDAzXSAoLS0p
IFNsZWVwIEJ1dHRvbjogRm91bmQga2V5cwpbICAgIDMwLjQwM10gKElJKSBTbGVlcCBCdXR0b246
IENvbmZpZ3VyaW5nIGFzIGtleWJvYXJkClsgICAgMzAuNDAzXSAoKiopIE9wdGlvbiAiY29uZmln
X2luZm8iICJ1ZGV2Oi9zeXMvZGV2aWNlcy9MTlhTWVNUTTowMC9kZXZpY2U6MDAvUE5QMEMwRTow
MC9pbnB1dC9pbnB1dDQvZXZlbnQ0IgpbICAgIDMwLjQwM10gKElJKSBYSU5QVVQ6IEFkZGluZyBl
eHRlbmRlZCBpbnB1dCBkZXZpY2UgIlNsZWVwIEJ1dHRvbiIgKHR5cGU6IEtFWUJPQVJEKQpbICAg
IDMwLjQwM10gKCoqKSBPcHRpb24gInhrYl9ydWxlcyIgImV2ZGV2IgpbICAgIDMwLjQwM10gKCoq
KSBPcHRpb24gInhrYl9tb2RlbCIgInBjMTA1IgpbICAgIDMwLjQwM10gKCoqKSBPcHRpb24gInhr
Yl9sYXlvdXQiICJ1cyIKWyAgICAzMC40MDVdIChJSSkgY29uZmlnL3VkZXY6IEFkZGluZyBpbnB1
dCBkZXZpY2UgIFVTQiBPUFRJQ0FMIE1PVVNFICgvZGV2L2lucHV0L2V2ZW50MSkKWyAgICAzMC40
MDVdICgqKikgIFVTQiBPUFRJQ0FMIE1PVVNFOiBBcHBseWluZyBJbnB1dENsYXNzICJldmRldiBw
b2ludGVyIGNhdGNoYWxsIgpbICAgIDMwLjQwNV0gKElJKSBVc2luZyBpbnB1dCBkcml2ZXIgJ2V2
ZGV2JyBmb3IgJyBVU0IgT1BUSUNBTCBNT1VTRScKWyAgICAzMC40MDVdIChJSSkgTG9hZGluZyAv
dXNyL2xpYi94b3JnL21vZHVsZXMvaW5wdXQvZXZkZXZfZHJ2LnNvClsgICAgMzAuNDA1XSAoKiop
ICBVU0IgT1BUSUNBTCBNT1VTRTogYWx3YXlzIHJlcG9ydHMgY29yZSBldmVudHMKWyAgICAzMC40
MDVdICgqKikgIFVTQiBPUFRJQ0FMIE1PVVNFOiBEZXZpY2U6ICIvZGV2L2lucHV0L2V2ZW50MSIK
WyAgICAzMC40MDVdICgtLSkgIFVTQiBPUFRJQ0FMIE1PVVNFOiBGb3VuZCAzIG1vdXNlIGJ1dHRv
bnMKWyAgICAzMC40MDVdICgtLSkgIFVTQiBPUFRJQ0FMIE1PVVNFOiBGb3VuZCBzY3JvbGwgd2hl
ZWwocykKWyAgICAzMC40MDVdICgtLSkgIFVTQiBPUFRJQ0FMIE1PVVNFOiBGb3VuZCByZWxhdGl2
ZSBheGVzClsgICAgMzAuNDA1XSAoLS0pICBVU0IgT1BUSUNBTCBNT1VTRTogRm91bmQgeCBhbmQg
eSByZWxhdGl2ZSBheGVzClsgICAgMzAuNDA1XSAoSUkpICBVU0IgT1BUSUNBTCBNT1VTRTogQ29u
ZmlndXJpbmcgYXMgbW91c2UKWyAgICAzMC40MDVdIChJSSkgIFVTQiBPUFRJQ0FMIE1PVVNFOiBB
ZGRpbmcgc2Nyb2xsd2hlZWwgc3VwcG9ydApbICAgIDMwLjQwNV0gKCoqKSAgVVNCIE9QVElDQUwg
TU9VU0U6IFlBeGlzTWFwcGluZzogYnV0dG9ucyA0IGFuZCA1ClsgICAgMzAuNDA1XSAoKiopICBV
U0IgT1BUSUNBTCBNT1VTRTogRW11bGF0ZVdoZWVsQnV0dG9uOiA0LCBFbXVsYXRlV2hlZWxJbmVy
dGlhOiAxMCwgRW11bGF0ZVdoZWVsVGltZW91dDogMjAwClsgICAgMzAuNDA1XSAoKiopIE9wdGlv
biAiY29uZmlnX2luZm8iICJ1ZGV2Oi9zeXMvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MWEu
MC91c2IxLzEtMS8xLTEuMS8xLTEuMToxLjAvaW5wdXQvaW5wdXQxL2V2ZW50MSIKWyAgICAzMC40
MDVdIChJSSkgWElOUFVUOiBBZGRpbmcgZXh0ZW5kZWQgaW5wdXQgZGV2aWNlICIgVVNCIE9QVElD
QUwgTU9VU0UiICh0eXBlOiBNT1VTRSkKWyAgICAzMC40MDVdIChJSSkgIFVTQiBPUFRJQ0FMIE1P
VVNFOiBpbml0aWFsaXplZCBmb3IgcmVsYXRpdmUgYXhlcy4KWyAgICAzMC40MDVdICgqKikgIFVT
QiBPUFRJQ0FMIE1PVVNFOiAoYWNjZWwpIGtlZXBpbmcgYWNjZWxlcmF0aW9uIHNjaGVtZSAxClsg
ICAgMzAuNDA1XSAoKiopICBVU0IgT1BUSUNBTCBNT1VTRTogKGFjY2VsKSBhY2NlbGVyYXRpb24g
cHJvZmlsZSAwClsgICAgMzAuNDA1XSAoKiopICBVU0IgT1BUSUNBTCBNT1VTRTogKGFjY2VsKSBh
Y2NlbGVyYXRpb24gZmFjdG9yOiAyLjAwMApbICAgIDMwLjQwNV0gKCoqKSAgVVNCIE9QVElDQUwg
TU9VU0U6IChhY2NlbCkgYWNjZWxlcmF0aW9uIHRocmVzaG9sZDogNApbICAgIDMwLjQwNl0gKElJ
KSBjb25maWcvdWRldjogQWRkaW5nIGlucHV0IGRldmljZSAgVVNCIE9QVElDQUwgTU9VU0UgKC9k
ZXYvaW5wdXQvbW91c2UwKQpbICAgIDMwLjQwNl0gKElJKSBObyBpbnB1dCBkcml2ZXIvaWRlbnRp
ZmllciBzcGVjaWZpZWQgKGlnbm9yaW5nKQpbICAgIDMwLjQwNl0gKElJKSBjb25maWcvdWRldjog
QWRkaW5nIGlucHV0IGRldmljZSBIREEgRGlnaXRhbCBQQ0JlZXAgKC9kZXYvaW5wdXQvZXZlbnQx
MikKWyAgICAzMC40MDZdIChJSSkgTm8gaW5wdXQgZHJpdmVyL2lkZW50aWZpZXIgc3BlY2lmaWVk
IChpZ25vcmluZykKWyAgICAzMC40MDZdIChJSSkgY29uZmlnL3VkZXY6IEFkZGluZyBpbnB1dCBk
ZXZpY2UgSERBIEludGVsIE1pYyAoL2Rldi9pbnB1dC9ldmVudDEzKQpbICAgIDMwLjQwNl0gKElJ
KSBObyBpbnB1dCBkcml2ZXIvaWRlbnRpZmllciBzcGVjaWZpZWQgKGlnbm9yaW5nKQpbICAgIDMw
LjQwNl0gKElJKSBjb25maWcvdWRldjogQWRkaW5nIGlucHV0IGRldmljZSBIREEgSW50ZWwgSGVh
ZHBob25lICgvZGV2L2lucHV0L2V2ZW50MTQpClsgICAgMzAuNDA3XSAoSUkpIE5vIGlucHV0IGRy
aXZlci9pZGVudGlmaWVyIHNwZWNpZmllZCAoaWdub3JpbmcpClsgICAgMzAuNDA4XSAoSUkpIGNv
bmZpZy91ZGV2OiBBZGRpbmcgaW5wdXQgZGV2aWNlIFVTQiBHYW1lcGFkICAoL2Rldi9pbnB1dC9l
dmVudDcpClsgICAgMzAuNDA4XSAoSUkpIE5vIGlucHV0IGRyaXZlci9pZGVudGlmaWVyIHNwZWNp
ZmllZCAoaWdub3JpbmcpClsgICAgMzAuNDA4XSAoSUkpIGNvbmZpZy91ZGV2OiBBZGRpbmcgaW5w
dXQgZGV2aWNlIFVTQiBHYW1lcGFkICAoL2Rldi9pbnB1dC9qczApClsgICAgMzAuNDA4XSAoSUkp
IE5vIGlucHV0IGRyaXZlci9pZGVudGlmaWVyIHNwZWNpZmllZCAoaWdub3JpbmcpClsgICAgMzAu
NDA4XSAoSUkpIGNvbmZpZy91ZGV2OiBBZGRpbmcgaW5wdXQgZGV2aWNlIExlbm92byBFYXN5Q2Ft
ZXJhICgvZGV2L2lucHV0L2V2ZW50OSkKWyAgICAzMC40MDhdICgqKikgTGVub3ZvIEVhc3lDYW1l
cmE6IEFwcGx5aW5nIElucHV0Q2xhc3MgImV2ZGV2IGtleWJvYXJkIGNhdGNoYWxsIgpbICAgIDMw
LjQwOF0gKElJKSBVc2luZyBpbnB1dCBkcml2ZXIgJ2V2ZGV2JyBmb3IgJ0xlbm92byBFYXN5Q2Ft
ZXJhJwpbICAgIDMwLjQwOF0gKElJKSBMb2FkaW5nIC91c3IvbGliL3hvcmcvbW9kdWxlcy9pbnB1
dC9ldmRldl9kcnYuc28KWyAgICAzMC40MDldICgqKikgTGVub3ZvIEVhc3lDYW1lcmE6IGFsd2F5
cyByZXBvcnRzIGNvcmUgZXZlbnRzClsgICAgMzAuNDA5XSAoKiopIExlbm92byBFYXN5Q2FtZXJh
OiBEZXZpY2U6ICIvZGV2L2lucHV0L2V2ZW50OSIKWyAgICAzMC40MDldICgtLSkgTGVub3ZvIEVh
c3lDYW1lcmE6IEZvdW5kIGtleXMKWyAgICAzMC40MDldIChJSSkgTGVub3ZvIEVhc3lDYW1lcmE6
IENvbmZpZ3VyaW5nIGFzIGtleWJvYXJkClsgICAgMzAuNDA5XSAoKiopIE9wdGlvbiAiY29uZmln
X2luZm8iICJ1ZGV2Oi9zeXMvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MWQuMC91c2IyLzIt
MS8yLTEuNC8yLTEuNDoxLjAvaW5wdXQvaW5wdXQ5L2V2ZW50OSIKWyAgICAzMC40MDldIChJSSkg
WElOUFVUOiBBZGRpbmcgZXh0ZW5kZWQgaW5wdXQgZGV2aWNlICJMZW5vdm8gRWFzeUNhbWVyYSIg
KHR5cGU6IEtFWUJPQVJEKQpbICAgIDMwLjQwOV0gKCoqKSBPcHRpb24gInhrYl9ydWxlcyIgImV2
ZGV2IgpbICAgIDMwLjQwOV0gKCoqKSBPcHRpb24gInhrYl9tb2RlbCIgInBjMTA1IgpbICAgIDMw
LjQwOV0gKCoqKSBPcHRpb24gInhrYl9sYXlvdXQiICJ1cyIKWyAgICAzMC40MTJdIChJSSkgY29u
ZmlnL3VkZXY6IEFkZGluZyBpbnB1dCBkZXZpY2UgQVQgVHJhbnNsYXRlZCBTZXQgMiBrZXlib2Fy
ZCAoL2Rldi9pbnB1dC9ldmVudDApClsgICAgMzAuNDEyXSAoKiopIEFUIFRyYW5zbGF0ZWQgU2V0
IDIga2V5Ym9hcmQ6IEFwcGx5aW5nIElucHV0Q2xhc3MgImV2ZGV2IGtleWJvYXJkIGNhdGNoYWxs
IgpbICAgIDMwLjQxMl0gKElJKSBVc2luZyBpbnB1dCBkcml2ZXIgJ2V2ZGV2JyBmb3IgJ0FUIFRy
YW5zbGF0ZWQgU2V0IDIga2V5Ym9hcmQnClsgICAgMzAuNDEyXSAoSUkpIExvYWRpbmcgL3Vzci9s
aWIveG9yZy9tb2R1bGVzL2lucHV0L2V2ZGV2X2Rydi5zbwpbICAgIDMwLjQxMl0gKCoqKSBBVCBU
cmFuc2xhdGVkIFNldCAyIGtleWJvYXJkOiBhbHdheXMgcmVwb3J0cyBjb3JlIGV2ZW50cwpbICAg
IDMwLjQxMl0gKCoqKSBBVCBUcmFuc2xhdGVkIFNldCAyIGtleWJvYXJkOiBEZXZpY2U6ICIvZGV2
L2lucHV0L2V2ZW50MCIKWyAgICAzMC40MTJdICgtLSkgQVQgVHJhbnNsYXRlZCBTZXQgMiBrZXli
b2FyZDogRm91bmQga2V5cwpbICAgIDMwLjQxMl0gKElJKSBBVCBUcmFuc2xhdGVkIFNldCAyIGtl
eWJvYXJkOiBDb25maWd1cmluZyBhcyBrZXlib2FyZApbICAgIDMwLjQxMl0gKCoqKSBPcHRpb24g
ImNvbmZpZ19pbmZvIiAidWRldjovc3lzL2RldmljZXMvcGxhdGZvcm0vaTgwNDIvc2VyaW8wL2lu
cHV0L2lucHV0MC9ldmVudDAiClsgICAgMzAuNDEyXSAoSUkpIFhJTlBVVDogQWRkaW5nIGV4dGVu
ZGVkIGlucHV0IGRldmljZSAiQVQgVHJhbnNsYXRlZCBTZXQgMiBrZXlib2FyZCIgKHR5cGU6IEtF
WUJPQVJEKQpbICAgIDMwLjQxMl0gKCoqKSBPcHRpb24gInhrYl9ydWxlcyIgImV2ZGV2IgpbICAg
IDMwLjQxMl0gKCoqKSBPcHRpb24gInhrYl9tb2RlbCIgInBjMTA1IgpbICAgIDMwLjQxMl0gKCoq
KSBPcHRpb24gInhrYl9sYXlvdXQiICJ1cyIKWyAgICAzMC40MTNdIChJSSkgY29uZmlnL3VkZXY6
IEFkZGluZyBpbnB1dCBkZXZpY2UgUFMvMiBHZW5lcmljIE1vdXNlICgvZGV2L2lucHV0L2V2ZW50
MTApClsgICAgMzAuNDEzXSAoKiopIFBTLzIgR2VuZXJpYyBNb3VzZTogQXBwbHlpbmcgSW5wdXRD
bGFzcyAiZXZkZXYgcG9pbnRlciBjYXRjaGFsbCIKWyAgICAzMC40MTNdIChJSSkgVXNpbmcgaW5w
dXQgZHJpdmVyICdldmRldicgZm9yICdQUy8yIEdlbmVyaWMgTW91c2UnClsgICAgMzAuNDEzXSAo
SUkpIExvYWRpbmcgL3Vzci9saWIveG9yZy9tb2R1bGVzL2lucHV0L2V2ZGV2X2Rydi5zbwpbICAg
IDMwLjQxM10gKCoqKSBQUy8yIEdlbmVyaWMgTW91c2U6IGFsd2F5cyByZXBvcnRzIGNvcmUgZXZl
bnRzClsgICAgMzAuNDEzXSAoKiopIFBTLzIgR2VuZXJpYyBNb3VzZTogRGV2aWNlOiAiL2Rldi9p
bnB1dC9ldmVudDEwIgpbICAgIDMwLjQxM10gKC0tKSBQUy8yIEdlbmVyaWMgTW91c2U6IEZvdW5k
IDMgbW91c2UgYnV0dG9ucwpbICAgIDMwLjQxM10gKC0tKSBQUy8yIEdlbmVyaWMgTW91c2U6IEZv
dW5kIHJlbGF0aXZlIGF4ZXMKWyAgICAzMC40MTNdICgtLSkgUFMvMiBHZW5lcmljIE1vdXNlOiBG
b3VuZCB4IGFuZCB5IHJlbGF0aXZlIGF4ZXMKWyAgICAzMC40MTNdIChJSSkgUFMvMiBHZW5lcmlj
IE1vdXNlOiBDb25maWd1cmluZyBhcyBtb3VzZQpbICAgIDMwLjQxM10gKCoqKSBQUy8yIEdlbmVy
aWMgTW91c2U6IFlBeGlzTWFwcGluZzogYnV0dG9ucyA0IGFuZCA1ClsgICAgMzAuNDEzXSAoKiop
IFBTLzIgR2VuZXJpYyBNb3VzZTogRW11bGF0ZVdoZWVsQnV0dG9uOiA0LCBFbXVsYXRlV2hlZWxJ
bmVydGlhOiAxMCwgRW11bGF0ZVdoZWVsVGltZW91dDogMjAwClsgICAgMzAuNDEzXSAoKiopIE9w
dGlvbiAiY29uZmlnX2luZm8iICJ1ZGV2Oi9zeXMvZGV2aWNlcy9wbGF0Zm9ybS9pODA0Mi9zZXJp
bzQvaW5wdXQvaW5wdXQxMC9ldmVudDEwIgpbICAgIDMwLjQxM10gKElJKSBYSU5QVVQ6IEFkZGlu
ZyBleHRlbmRlZCBpbnB1dCBkZXZpY2UgIlBTLzIgR2VuZXJpYyBNb3VzZSIgKHR5cGU6IE1PVVNF
KQpbICAgIDMwLjQxM10gKElJKSBQUy8yIEdlbmVyaWMgTW91c2U6IGluaXRpYWxpemVkIGZvciBy
ZWxhdGl2ZSBheGVzLgpbICAgIDMwLjQxM10gKCoqKSBQUy8yIEdlbmVyaWMgTW91c2U6IChhY2Nl
bCkga2VlcGluZyBhY2NlbGVyYXRpb24gc2NoZW1lIDEKWyAgICAzMC40MTNdICgqKikgUFMvMiBH
ZW5lcmljIE1vdXNlOiAoYWNjZWwpIGFjY2VsZXJhdGlvbiBwcm9maWxlIDAKWyAgICAzMC40MTNd
ICgqKikgUFMvMiBHZW5lcmljIE1vdXNlOiAoYWNjZWwpIGFjY2VsZXJhdGlvbiBmYWN0b3I6IDIu
MDAwClsgICAgMzAuNDEzXSAoKiopIFBTLzIgR2VuZXJpYyBNb3VzZTogKGFjY2VsKSBhY2NlbGVy
YXRpb24gdGhyZXNob2xkOiA0ClsgICAgMzAuNDEzXSAoSUkpIGNvbmZpZy91ZGV2OiBBZGRpbmcg
aW5wdXQgZGV2aWNlIFBTLzIgR2VuZXJpYyBNb3VzZSAoL2Rldi9pbnB1dC9tb3VzZTEpClsgICAg
MzAuNDEzXSAoSUkpIE5vIGlucHV0IGRyaXZlci9pZGVudGlmaWVyIHNwZWNpZmllZCAoaWdub3Jp
bmcpClsgICAgMzAuNDE0XSAoSUkpIGNvbmZpZy91ZGV2OiBBZGRpbmcgaW5wdXQgZGV2aWNlIElk
ZWFwYWQgZXh0cmEgYnV0dG9ucyAoL2Rldi9pbnB1dC9ldmVudDgpClsgICAgMzAuNDE0XSAoKiop
IElkZWFwYWQgZXh0cmEgYnV0dG9uczogQXBwbHlpbmcgSW5wdXRDbGFzcyAiZXZkZXYga2V5Ym9h
cmQgY2F0Y2hhbGwiClsgICAgMzAuNDE0XSAoSUkpIFVzaW5nIGlucHV0IGRyaXZlciAnZXZkZXYn
IGZvciAnSWRlYXBhZCBleHRyYSBidXR0b25zJwpbICAgIDMwLjQxNF0gKElJKSBMb2FkaW5nIC91
c3IvbGliL3hvcmcvbW9kdWxlcy9pbnB1dC9ldmRldl9kcnYuc28KWyAgICAzMC40MTRdICgqKikg
SWRlYXBhZCBleHRyYSBidXR0b25zOiBhbHdheXMgcmVwb3J0cyBjb3JlIGV2ZW50cwpbICAgIDMw
LjQxNF0gKCoqKSBJZGVhcGFkIGV4dHJhIGJ1dHRvbnM6IERldmljZTogIi9kZXYvaW5wdXQvZXZl
bnQ4IgpbICAgIDMwLjQxNF0gKC0tKSBJZGVhcGFkIGV4dHJhIGJ1dHRvbnM6IEZvdW5kIGtleXMK
WyAgICAzMC40MTRdIChJSSkgSWRlYXBhZCBleHRyYSBidXR0b25zOiBDb25maWd1cmluZyBhcyBr
ZXlib2FyZApbICAgIDMwLjQxNF0gKCoqKSBPcHRpb24gImNvbmZpZ19pbmZvIiAidWRldjovc3lz
L2RldmljZXMvcGxhdGZvcm0vaWRlYXBhZC9pbnB1dC9pbnB1dDgvZXZlbnQ4IgpbICAgIDMwLjQx
NF0gKElJKSBYSU5QVVQ6IEFkZGluZyBleHRlbmRlZCBpbnB1dCBkZXZpY2UgIklkZWFwYWQgZXh0
cmEgYnV0dG9ucyIgKHR5cGU6IEtFWUJPQVJEKQpbICAgIDMwLjQxNF0gKCoqKSBPcHRpb24gInhr
Yl9ydWxlcyIgImV2ZGV2IgpbICAgIDMwLjQxNF0gKCoqKSBPcHRpb24gInhrYl9tb2RlbCIgInBj
MTA1IgpbICAgIDMwLjQxNF0gKCoqKSBPcHRpb24gInhrYl9sYXlvdXQiICJ1cyIKWyAgICAzMC40
MTRdIChJSSkgY29uZmlnL3VkZXY6IEFkZGluZyBpbnB1dCBkZXZpY2UgUEMgU3BlYWtlciAoL2Rl
di9pbnB1dC9ldmVudDYpClsgICAgMzAuNDE0XSAoSUkpIE5vIGlucHV0IGRyaXZlci9pZGVudGlm
aWVyIHNwZWNpZmllZCAoaWdub3JpbmcpClsgICAgMzAuNDE3XSAoSUkpIGNvbmZpZy91ZGV2OiBB
ZGRpbmcgaW5wdXQgZGV2aWNlIEFDUEkgVmlydHVhbCBLZXlib2FyZCBEZXZpY2UgKC9kZXYvaW5w
dXQvZXZlbnQxNSkKWyAgICAzMC40MThdICgqKikgQUNQSSBWaXJ0dWFsIEtleWJvYXJkIERldmlj
ZTogQXBwbHlpbmcgSW5wdXRDbGFzcyAiZXZkZXYga2V5Ym9hcmQgY2F0Y2hhbGwiClsgICAgMzAu
NDE4XSAoSUkpIFVzaW5nIGlucHV0IGRyaXZlciAnZXZkZXYnIGZvciAnQUNQSSBWaXJ0dWFsIEtl
eWJvYXJkIERldmljZScKWyAgICAzMC40MThdIChJSSkgTG9hZGluZyAvdXNyL2xpYi94b3JnL21v
ZHVsZXMvaW5wdXQvZXZkZXZfZHJ2LnNvClsgICAgMzAuNDE4XSAoKiopIEFDUEkgVmlydHVhbCBL
ZXlib2FyZCBEZXZpY2U6IGFsd2F5cyByZXBvcnRzIGNvcmUgZXZlbnRzClsgICAgMzAuNDE4XSAo
KiopIEFDUEkgVmlydHVhbCBLZXlib2FyZCBEZXZpY2U6IERldmljZTogIi9kZXYvaW5wdXQvZXZl
bnQxNSIKWyAgICAzMC40MThdICgtLSkgQUNQSSBWaXJ0dWFsIEtleWJvYXJkIERldmljZTogRm91
bmQga2V5cwpbICAgIDMwLjQxOF0gKElJKSBBQ1BJIFZpcnR1YWwgS2V5Ym9hcmQgRGV2aWNlOiBD
b25maWd1cmluZyBhcyBrZXlib2FyZApbICAgIDMwLjQxOF0gKCoqKSBPcHRpb24gImNvbmZpZ19p
bmZvIiAidWRldjovc3lzL2RldmljZXMvdmlydHVhbC9pbnB1dC9pbnB1dDE1L2V2ZW50MTUiClsg
ICAgMzAuNDE4XSAoSUkpIFhJTlBVVDogQWRkaW5nIGV4dGVuZGVkIGlucHV0IGRldmljZSAiQUNQ
SSBWaXJ0dWFsIEtleWJvYXJkIERldmljZSIgKHR5cGU6IEtFWUJPQVJEKQpbICAgIDMwLjQxOF0g
KCoqKSBPcHRpb24gInhrYl9ydWxlcyIgImV2ZGV2IgpbICAgIDMwLjQxOF0gKCoqKSBPcHRpb24g
InhrYl9tb2RlbCIgInBjMTA1IgpbICAgIDMwLjQxOF0gKCoqKSBPcHRpb24gInhrYl9sYXlvdXQi
ICJ1cyIKWyAgICAzMS4xMzFdIChJSSkgaW50ZWwoMCk6IEVESUQgdmVuZG9yICJBVU8iLCBwcm9k
IGlkIDE2NDI4ClsgICAgMzEuMTMxXSAoSUkpIGludGVsKDApOiBQcmludGluZyBEREMgZ2F0aGVy
ZWQgTW9kZWxpbmVzOgpbICAgIDMxLjEzMV0gKElJKSBpbnRlbCgwKTogTW9kZWxpbmUgIjEzNjZ4
NzY4IngwLjAgICA2OS4zMCAgMTM2NiAxNDE0IDE0NDYgMTQ1NiAgNzY4IDc3MSA3NzcgNzkzIC1o
c3luYyAtdnN5bmMgKDQ3LjYga0h6KQpbICAgIDMxLjEzMl0gKElJKSBpbnRlbCgwKTogRURJRCB2
ZW5kb3IgIkFVTyIsIHByb2QgaWQgMTY0MjgKWyAgICAzMS4xMzNdIChJSSkgaW50ZWwoMCk6IFBy
aW50aW5nIEREQyBnYXRoZXJlZCBNb2RlbGluZXM6ClsgICAgMzEuMTMzXSAoSUkpIGludGVsKDAp
OiBNb2RlbGluZSAiMTM2Nng3NjgieDAuMCAgIDY5LjMwICAxMzY2IDE0MTQgMTQ0NiAxNDU2ICA3
NjggNzcxIDc3NyA3OTMgLWhzeW5jIC12c3luYyAoNDcuNiBrSHopClsgICAgMzEuMTQzXSAoSUkp
IGludGVsKDApOiBFRElEIHZlbmRvciAiQVVPIiwgcHJvZCBpZCAxNjQyOApbICAgIDMxLjE0M10g
KElJKSBpbnRlbCgwKTogUHJpbnRpbmcgRERDIGdhdGhlcmVkIE1vZGVsaW5lczoKWyAgICAzMS4x
NDNdIChJSSkgaW50ZWwoMCk6IE1vZGVsaW5lICIxMzY2eDc2OCJ4MC4wICAgNjkuMzAgIDEzNjYg
MTQxNCAxNDQ2IDE0NTYgIDc2OCA3NzEgNzc3IDc5MyAtaHN5bmMgLXZzeW5jICg0Ny42IGtIeikK
WyAgICA0OC45MDZdIChJSSkgaW50ZWwoMCk6IEVESUQgdmVuZG9yICJBVU8iLCBwcm9kIGlkIDE2
NDI4ClsgICAgNDguOTA2XSAoSUkpIGludGVsKDApOiBQcmludGluZyBEREMgZ2F0aGVyZWQgTW9k
ZWxpbmVzOgpbICAgIDQ4LjkwNl0gKElJKSBpbnRlbCgwKTogTW9kZWxpbmUgIjEzNjZ4NzY4Ingw
LjAgICA2OS4zMCAgMTM2NiAxNDE0IDE0NDYgMTQ1NiAgNzY4IDc3MSA3NzcgNzkzIC1oc3luYyAt
dnN5bmMgKDQ3LjYga0h6KQpbICAgIDQ4LjkwN10gKElJKSBpbnRlbCgwKTogRURJRCB2ZW5kb3Ig
IkFVTyIsIHByb2QgaWQgMTY0MjgKWyAgICA0OC45MDddIChJSSkgaW50ZWwoMCk6IFByaW50aW5n
IEREQyBnYXRoZXJlZCBNb2RlbGluZXM6ClsgICAgNDguOTA3XSAoSUkpIGludGVsKDApOiBNb2Rl
bGluZSAiMTM2Nng3NjgieDAuMCAgIDY5LjMwICAxMzY2IDE0MTQgMTQ0NiAxNDU2ICA3NjggNzcx
IDc3NyA3OTMgLWhzeW5jIC12c3luYyAoNDcuNiBrSHopClsgICAgNDguOTA4XSAoSUkpIGludGVs
KDApOiBFRElEIHZlbmRvciAiQVVPIiwgcHJvZCBpZCAxNjQyOApbICAgIDQ4LjkwOF0gKElJKSBp
bnRlbCgwKTogUHJpbnRpbmcgRERDIGdhdGhlcmVkIE1vZGVsaW5lczoKWyAgICA0OC45MDhdIChJ
SSkgaW50ZWwoMCk6IE1vZGVsaW5lICIxMzY2eDc2OCJ4MC4wICAgNjkuMzAgIDEzNjYgMTQxNCAx
NDQ2IDE0NTYgIDc2OCA3NzEgNzc3IDc5MyAtaHN5bmMgLXZzeW5jICg0Ny42IGtIeikKWyAgICA1
MS45NTZdIChJSSkgaW50ZWwoMCk6IEVESUQgdmVuZG9yICJBVU8iLCBwcm9kIGlkIDE2NDI4Clsg
ICAgNTEuOTU2XSAoSUkpIGludGVsKDApOiBQcmludGluZyBEREMgZ2F0aGVyZWQgTW9kZWxpbmVz
OgpbICAgIDUxLjk1Nl0gKElJKSBpbnRlbCgwKTogTW9kZWxpbmUgIjEzNjZ4NzY4IngwLjAgICA2
OS4zMCAgMTM2NiAxNDE0IDE0NDYgMTQ1NiAgNzY4IDc3MSA3NzcgNzkzIC1oc3luYyAtdnN5bmMg
KDQ3LjYga0h6KQo=

--Multipart=_Sat__7_Jul_2012_13_35_19_+0800_amjr5p9Y4..xlEyg
Content-Type: text/plain;
 name="V2-00-dmesg.txt"
Content-Disposition: attachment;
 filename="V2-00-dmesg.txt"
Content-Transfer-Encoding: 7bit

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.4.4debugpsmouse (mengdaxing@ldebian) (gcc version 4.4.5 (Debian 4.4.5-8) ) #1 SMP Fri Jul 6 07:44:49 CST 2012
[    0.000000] Command line: root=/dev/sda7 acpi_backlight=vendor ro
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009c400 (usable)
[    0.000000]  BIOS-e820: 000000000009c400 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000dc000 - 00000000000e0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007727c000 (usable)
[    0.000000]  BIOS-e820: 000000007727c000 - 0000000077282000 (reserved)
[    0.000000]  BIOS-e820: 0000000077282000 - 00000000773ee000 (usable)
[    0.000000]  BIOS-e820: 00000000773ee000 - 000000007740f000 (reserved)
[    0.000000]  BIOS-e820: 000000007740f000 - 000000007746f000 (usable)
[    0.000000]  BIOS-e820: 000000007746f000 - 0000000077470000 (reserved)
[    0.000000]  BIOS-e820: 0000000077470000 - 00000000774f1000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000774f1000 - 000000007770f000 (reserved)
[    0.000000]  BIOS-e820: 000000007770f000 - 0000000077717000 (usable)
[    0.000000]  BIOS-e820: 0000000077717000 - 000000007771f000 (reserved)
[    0.000000]  BIOS-e820: 000000007771f000 - 000000007775e000 (usable)
[    0.000000]  BIOS-e820: 000000007775e000 - 000000007779f000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000007779f000 - 00000000777e1000 (usable)
[    0.000000]  BIOS-e820: 00000000777e1000 - 00000000777ff000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000777ff000 - 0000000077800000 (usable)
[    0.000000]  BIOS-e820: 0000000077800000 - 000000007c000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000f0804000 - 00000000f0805000 (reserved)
[    0.000000]  BIOS-e820: 00000000feaff000 - 00000000feb00000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
[    0.000000]  BIOS-e820: 00000000fed1c000 - 00000000fed90000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI present.
[    0.000000] DMI: LENOVO                           G360            /LL1                             , BIOS 61CN06WW   10/27/2011
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> (reserved)
[    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
[    0.000000] No AGP bridge found
[    0.000000] last_pfn = 0x77800 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-D3FFF write-protect
[    0.000000]   D4000-DBFFF uncachable
[    0.000000]   DC000-FFFFF write-through
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 disabled
[    0.000000]   1 base 078000000 mask FF8000000 uncachable
[    0.000000]   2 base 000000000 mask F80000000 write-back
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] found SMP MP-table at [ffff8800000f6200] f6200
[    0.000000] initial memory mapped : 0 - 20000000
[    0.000000] Base memory trampoline at [ffff880000097000] 97000 size 20480
[    0.000000] init_memory_mapping: 0000000000000000-0000000077800000
[    0.000000]  0000000000 - 0077800000 page 2M
[    0.000000] kernel direct mapping tables up to 77800000 @ 1fffd000-20000000
[    0.000000] RAMDISK: 6fc5c000 - 7726c000
[    0.000000] ACPI: RSDP 00000000000f60c0 00024 (v02 PTLTD )
[    0.000000] ACPI: XSDT 00000000777f2fcb 0005C (v01 LENOVO CB-01    06040000  LTP 00000000)
[    0.000000] ACPI: FACP 00000000777e3000 000F4 (v03 LENOVO CB-01    06040000 PTEC 00000001)
[    0.000000] ACPI: DSDT 00000000777e4000 0BBBF (v02 LENOVO CB-01    06040000 INTL 20060912)
[    0.000000] ACPI: FACS 000000007779bfc0 00040
[    0.000000] ACPI: HPET 00000000777fed86 00038 (v01 LENOVO CB-01    06040000 PTEC 00000001)
[    0.000000] ACPI: MCFG 00000000777fedbe 0003C (v01 LENOVO CB-01    06040000 PTEC 00000001)
[    0.000000] ACPI: APIC 00000000777fedfa 00068 (v01 LENOVO CB-01    06040000  LTP 00000000)
[    0.000000] ACPI: BOOT 00000000777fee62 00028 (v01 LENOVO CB-01    06040000  LTP 00000001)
[    0.000000] ACPI: SLIC 00000000777fee8a 00176 (v01 LENOVO CB-01    06040000  LTP 00000000)
[    0.000000] ACPI: SSDT 00000000777e2000 009F1 (v01  PmRef    CpuPm 00003000 INTL 20050624)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-0000000077800000
[    0.000000] Initmem setup node 0 0000000000000000-0000000077800000
[    0.000000]   NODE_DATA [00000000777dd000 - 00000000777e0fff]
[    0.000000]  [ffffea0000000000-ffffea0001bfffff] PMD -> [ffff88006d600000-ffff88006f1fffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   empty
[    0.000000] Movable zone start PFN for each node
[    0.000000] Early memory PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009c
[    0.000000]     0: 0x00000100 -> 0x0007727c
[    0.000000]     0: 0x00077282 -> 0x000773ee
[    0.000000]     0: 0x0007740f -> 0x0007746f
[    0.000000]     0: 0x0007770f -> 0x00077717
[    0.000000]     0: 0x0007771f -> 0x0007775e
[    0.000000]     0: 0x0007779f -> 0x000777e1
[    0.000000]     0: 0x000777ff -> 0x00077800
[    0.000000] On node 0 totalpages: 488542
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 5 pages reserved
[    0.000000]   DMA zone: 3919 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 6636 pages used for memmap
[    0.000000]   DMA32 zone: 477926 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x04] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 40
[    0.000000] PM: Registered nosave memory: 000000000009c000 - 000000000009d000
[    0.000000] PM: Registered nosave memory: 000000000009d000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000dc000
[    0.000000] PM: Registered nosave memory: 00000000000dc000 - 00000000000e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 - 00000000000e4000
[    0.000000] PM: Registered nosave memory: 00000000000e4000 - 0000000000100000
[    0.000000] PM: Registered nosave memory: 000000007727c000 - 0000000077282000
[    0.000000] PM: Registered nosave memory: 00000000773ee000 - 000000007740f000
[    0.000000] PM: Registered nosave memory: 000000007746f000 - 0000000077470000
[    0.000000] PM: Registered nosave memory: 0000000077470000 - 00000000774f1000
[    0.000000] PM: Registered nosave memory: 00000000774f1000 - 000000007770f000
[    0.000000] PM: Registered nosave memory: 0000000077717000 - 000000007771f000
[    0.000000] PM: Registered nosave memory: 000000007775e000 - 000000007779f000
[    0.000000] PM: Registered nosave memory: 00000000777e1000 - 00000000777ff000
[    0.000000] Allocating PCI resources starting at 7c000000 (gap: 7c000000:64000000)
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:2 nr_node_ids:1
[    0.000000] PERCPU: Embedded 28 pages/cpu @ffff88006fa00000 s82304 r8192 d24192 u1048576
[    0.000000] pcpu-alloc: s82304 r8192 d24192 u1048576 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 481845
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: root=/dev/sda7 acpi_backlight=vendor ro
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 1795820k/1957888k available (3581k kernel code, 3720k absent, 158348k reserved, 3112k data, 604k init)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] NR_IRQS:33024 nr_irqs:512 16
[    0.000000] Extended CMOS year: 2000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 7864320 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
[    0.000000] hpet clockevent registered
[    0.000000] Fast TSC calibration using PIT
[    0.004000] Detected 2128.062 MHz processor.
[    0.000003] Calibrating delay loop (skipped), value calculated using timer frequency.. 4256.12 BogoMIPS (lpj=8512248)
[    0.000152] pid_max: default: 32768 minimum: 301
[    0.000262] Security Framework initialized
[    0.000338] AppArmor: AppArmor disabled by boot time parameter
[    0.000551] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.001347] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.001755] Mount-cache hash table entries: 256
[    0.002035] Initializing cgroup subsys cpuacct
[    0.002109] Initializing cgroup subsys memory
[    0.002191] Initializing cgroup subsys devices
[    0.002264] Initializing cgroup subsys freezer
[    0.002336] Initializing cgroup subsys net_cls
[    0.002408] Initializing cgroup subsys blkio
[    0.002485] Initializing cgroup subsys perf_event
[    0.002585] CPU: Physical Processor ID: 0
[    0.002656] CPU: Processor Core ID: 0
[    0.002729] mce: CPU supports 9 MCE banks
[    0.002809] CPU0: Thermal monitoring enabled (TM1)
[    0.002889] using mwait in idle threads.
[    0.003999] ACPI: Core revision 20120320
[    0.023651] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.063400] CPU0: Intel(R) Pentium(R) CPU        P6200  @ 2.13GHz stepping 05
[    0.171134] Performance Events: PEBS fmt1+, 16-deep LBR, Westmere events, Intel PMU driver.
[    0.171408] CPUID marked event: 'bus cycles' unavailable
[    0.171487] ... version:                3
[    0.171563] ... bit width:              48
[    0.171636] ... generic registers:      4
[    0.171708] ... value mask:             0000ffffffffffff
[    0.171785] ... max period:             000000007fffffff
[    0.171862] ... fixed-purpose events:   3
[    0.171935] ... event mask:             000000070000000f
[    0.172158] NMI watchdog: enabled, takes one hw-pmu counter.
[    0.172351] Booting Node   0, Processors  #1 Ok.
[    0.183421] CPU1: Thermal monitoring handled by SMI
[    0.185533] NMI watchdog: enabled, takes one hw-pmu counter.
[    0.185656] Brought up 2 CPUs
[    0.185729] Total of 2 processors activated (8512.24 BogoMIPS).
[    0.187031] devtmpfs: initialized
[    0.191230] PM: Registering ACPI NVS region [mem 0x77470000-0x774f0fff] (528384 bytes)
[    0.191358] PM: Registering ACPI NVS region [mem 0x7775e000-0x7779efff] (266240 bytes)
[    0.191569] dummy: 
[    0.191699] NET: Registered protocol family 16
[    0.191896] ACPI: bus type pci registered
[    0.192052] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.192160] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    0.237598] PCI: Using configuration type 1 for base access
[    0.238298] bio: create slab <bio-0> at 0
[    0.238461] ACPI: Added _OSI(Module Device)
[    0.238536] ACPI: Added _OSI(Processor Device)
[    0.238610] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.238689] ACPI: Added _OSI(Processor Aggregator Device)
[    0.240307] ACPI: EC: Look up EC in DSDT
[    0.248392] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.248948] ACPI: SSDT 000000007771ac18 003AE (v01  PmRef  Cpu0Ist 00003000 INTL 20050624)
[    0.249514] ACPI: Dynamic OEM Table Load:
[    0.249675] ACPI: SSDT           (null) 003AE (v01  PmRef  Cpu0Ist 00003000 INTL 20050624)
[    0.250047] ACPI: SSDT 0000000077718018 00891 (v01  PmRef  Cpu0Cst 00003001 INTL 20050624)
[    0.253055] ACPI: Dynamic OEM Table Load:
[    0.253213] ACPI: SSDT           (null) 00891 (v01  PmRef  Cpu0Cst 00003001 INTL 20050624)
[    0.253763] ACPI: SSDT 0000000077719a98 00303 (v01  PmRef    ApIst 00003000 INTL 20050624)
[    0.254392] ACPI: Dynamic OEM Table Load:
[    0.254551] ACPI: SSDT           (null) 00303 (v01  PmRef    ApIst 00003000 INTL 20050624)
[    0.254907] ACPI: SSDT 0000000077717d98 00119 (v01  PmRef    ApCst 00003000 INTL 20050624)
[    0.255483] ACPI: Dynamic OEM Table Load:
[    0.255643] ACPI: SSDT           (null) 00119 (v01  PmRef    ApCst 00003000 INTL 20050624)
[    0.264844] ACPI: Interpreter enabled
[    0.264922] ACPI: (supports S0 S3 S4 S5)
[    0.265189] ACPI: Using IOAPIC for interrupt routing
[    0.277136] ACPI: EC: GPE = 0x16, I/O: command/status = 0x66, data = 0x62
[    0.277422] ACPI: No dock devices found.
[    0.277506] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.278094] \_SB_.PCI0:_OSC invalid UUID
[    0.278096] _OSC request data:1 8 1f 
[    0.278101] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    0.278929] pci_root PNP0A08:00: host bridge window [io  0x0000-0x0cf7]
[    0.279015] pci_root PNP0A08:00: host bridge window [io  0x0d00-0xffff]
[    0.279100] pci_root PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff]
[    0.279205] pci_root PNP0A08:00: host bridge window [mem 0x000d4000-0x000d7fff]
[    0.279314] pci_root PNP0A08:00: host bridge window [mem 0x000d8000-0x000dbfff]
[    0.279418] pci_root PNP0A08:00: host bridge window [mem 0x000e0000-0x000e3fff]
[    0.279524] pci_root PNP0A08:00: host bridge window [mem 0x7c000000-0xfeafffff]
[    0.279663] PCI host bridge to bus 0000:00
[    0.279739] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
[    0.279821] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
[    0.279902] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
[    0.279987] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff]
[    0.280070] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff]
[    0.280153] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3fff]
[    0.280235] pci_bus 0000:00: root bus resource [mem 0x7c000000-0xfeafffff]
[    0.280329] pci 0000:00:00.0: [8086:0044] type 00 class 0x060000
[    0.280348] DMAR: BIOS has allocated no shadow GTT; disabling IOMMU for graphics
[    0.280474] pci 0000:00:01.0: [8086:0045] type 01 class 0x060400
[    0.280508] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.280523] pci 0000:00:02.0: [8086:0046] type 00 class 0x030000
[    0.280535] pci 0000:00:02.0: reg 10: [mem 0xf0000000-0xf03fffff 64bit]
[    0.280542] pci 0000:00:02.0: reg 18: [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.280547] pci 0000:00:02.0: reg 20: [io  0x1800-0x1807]
[    0.280624] pci 0000:00:1a.0: [8086:3b3c] type 00 class 0x0c0320
[    0.280650] pci 0000:00:1a.0: reg 10: [mem 0xf0806000-0xf08063ff]
[    0.280762] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    0.280798] pci 0000:00:1b.0: [8086:3b56] type 00 class 0x040300
[    0.280820] pci 0000:00:1b.0: reg 10: [mem 0xf0800000-0xf0803fff 64bit]
[    0.280920] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.280952] pci 0000:00:1c.0: [8086:3b42] type 01 class 0x060400
[    0.281055] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.281088] pci 0000:00:1c.1: [8086:3b44] type 01 class 0x060400
[    0.281191] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.281227] pci 0000:00:1c.4: [8086:3b4a] type 01 class 0x060400
[    0.281330] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.281373] pci 0000:00:1d.0: [8086:3b34] type 00 class 0x0c0320
[    0.281399] pci 0000:00:1d.0: reg 10: [mem 0xf0806400-0xf08067ff]
[    0.281516] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.281545] pci 0000:00:1e.0: [8086:2448] type 01 class 0x060401
[    0.281635] pci 0000:00:1f.0: [8086:3b09] type 00 class 0x060100
[    0.281771] pci 0000:00:1f.2: [8086:3b29] type 00 class 0x010601
[    0.281799] pci 0000:00:1f.2: reg 10: [io  0x1818-0x181f]
[    0.281810] pci 0000:00:1f.2: reg 14: [io  0x180c-0x180f]
[    0.281822] pci 0000:00:1f.2: reg 18: [io  0x1810-0x1817]
[    0.281833] pci 0000:00:1f.2: reg 1c: [io  0x1808-0x180b]
[    0.281845] pci 0000:00:1f.2: reg 20: [io  0x1820-0x183f]
[    0.281857] pci 0000:00:1f.2: reg 24: [mem 0xf0805000-0xf08057ff]
[    0.281925] pci 0000:00:1f.2: PME# supported from D3hot
[    0.281951] pci 0000:00:1f.3: [8086:3b30] type 00 class 0x0c0500
[    0.281973] pci 0000:00:1f.3: reg 10: [mem 0xf0806800-0xf08068ff 64bit]
[    0.282004] pci 0000:00:1f.3: reg 20: [io  0x1840-0x185f]
[    0.282056] pci 0000:00:1f.6: [8086:3b32] type 00 class 0x118000
[    0.282084] pci 0000:00:1f.6: reg 10: [mem 0xf0804000-0xf0804fff 64bit]
[    0.282234] pci 0000:01:00.0: [10de:0a70] type 00 class 0x030000
[    0.282250] pci 0000:01:00.0: reg 10: [mem 0xac000000-0xacffffff]
[    0.282266] pci 0000:01:00.0: reg 14: [mem 0xb0000000-0xbfffffff 64bit pref]
[    0.282283] pci 0000:01:00.0: reg 1c: [mem 0xae000000-0xafffffff 64bit pref]
[    0.282295] pci 0000:01:00.0: reg 24: [io  0x2000-0x207f]
[    0.282307] pci 0000:01:00.0: reg 30: [mem 0x00000000-0x0007ffff pref]
[    0.282412] pci 0000:00:01.0: PCI bridge to [bus 01-01]
[    0.282492] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.282495] pci 0000:00:01.0:   bridge window [mem 0xac000000-0xadefffff]
[    0.282499] pci 0000:00:01.0:   bridge window [mem 0xae000000-0xbfffffff 64bit pref]
[    0.282557] pci 0000:00:1c.0: PCI bridge to [bus 02-02]
[    0.282742] pci 0000:03:00.0: [168c:002b] type 00 class 0x028000
[    0.282785] pci 0000:03:00.0: reg 10: [mem 0xf0500000-0xf050ffff 64bit]
[    0.282986] pci 0000:03:00.0: supports D1
[    0.282988] pci 0000:03:00.0: PME# supported from D0 D1 D3hot
[    0.283071] pci 0000:00:1c.1: PCI bridge to [bus 03-03]
[    0.283155] pci 0000:00:1c.1:   bridge window [mem 0xf0500000-0xf05fffff]
[    0.283241] pci 0000:08:00.0: [1969:2060] type 00 class 0x020000
[    0.283271] pci 0000:08:00.0: reg 10: [mem 0xf0400000-0xf043ffff 64bit]
[    0.283286] pci 0000:08:00.0: reg 18: [io  0x3000-0x307f]
[    0.283412] pci 0000:08:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.293490] pci 0000:00:1c.4: PCI bridge to [bus 08-08]
[    0.293584] pci 0000:00:1c.4:   bridge window [io  0x3000-0x3fff]
[    0.293589] pci 0000:00:1c.4:   bridge window [mem 0xf0400000-0xf04fffff]
[    0.293670] pci 0000:00:1e.0: PCI bridge to [bus 0a-0a] (subtractive decode)
[    0.293768] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7] (subtractive decode)
[    0.293771] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff] (subtractive decode)
[    0.293773] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
[    0.293776] pci 0000:00:1e.0:   bridge window [mem 0x000d4000-0x000d7fff] (subtractive decode)
[    0.293780] pci 0000:00:1e.0:   bridge window [mem 0x000d8000-0x000dbfff] (subtractive decode)
[    0.293782] pci 0000:00:1e.0:   bridge window [mem 0x000e0000-0x000e3fff] (subtractive decode)
[    0.293785] pci 0000:00:1e.0:   bridge window [mem 0x7c000000-0xfeafffff] (subtractive decode)
[    0.293815] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.294083] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
[    0.294161] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
[    0.294329] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
[    0.294399] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
[    0.294474] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP05._PRT]
[    0.294623] \_SB_.PCI0:_OSC invalid UUID
[    0.294624] _OSC request data:1 1f 1f 
[    0.294629]  pci0000:00: Requesting ACPI _OSC control (0x1d)
[    0.294750] \_SB_.PCI0:_OSC invalid UUID
[    0.294751] _OSC request data:1 0 1d 
[    0.294755]  pci0000:00: ACPI _OSC request failed (AE_ERROR), returned control mask: 0x1d
[    0.294863] ACPI _OSC control for PCIe not granted, disabling ASPM
[    0.301152] ACPI: PCI Root Bridge [CPBG] (domain 0000 [bus ff])
[    0.301305] PCI host bridge to bus 0000:ff
[    0.301384] pci 0000:ff:00.0: [8086:2c62] type 00 class 0x060000
[    0.301406] pci 0000:ff:00.1: [8086:2d01] type 00 class 0x060000
[    0.301431] pci 0000:ff:02.0: [8086:2d10] type 00 class 0x060000
[    0.301450] pci 0000:ff:02.1: [8086:2d11] type 00 class 0x060000
[    0.301474] pci 0000:ff:02.2: [8086:2d12] type 00 class 0x060000
[    0.301493] pci 0000:ff:02.3: [8086:2d13] type 00 class 0x060000
[    0.301528]  pci0000:ff: Requesting ACPI _OSC control (0x1d)
[    0.301608]  pci0000:ff: ACPI _OSC request failed (AE_NOT_FOUND), returned control mask: 0x1d
[    0.301717] ACPI _OSC control for PCIe not granted, disabling ASPM
[    0.302044] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 12 14 15)
[    0.302677] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
[    0.303376] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 12 14 15)
[    0.304008] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *11 12 14 15)
[    0.304639] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
[    0.305380] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
[    0.306124] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
[    0.306817] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 *11 12 14 15)
[    0.307497] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.307613] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=none,locks=none
[    0.307721] vgaarb: loaded
[    0.307792] vgaarb: bridge control possible 0000:01:00.0
[    0.307869] vgaarb: no bridge control possible 0000:00:02.0
[    0.307976] PCI: Using ACPI for IRQ routing
[    0.317983] PCI: pci_cache_line_size set to 64 bytes
[    0.318080] reserve RAM buffer: 000000000009c400 - 000000000009ffff 
[    0.318082] reserve RAM buffer: 000000007727c000 - 0000000077ffffff 
[    0.318088] reserve RAM buffer: 00000000773ee000 - 0000000077ffffff 
[    0.318093] reserve RAM buffer: 000000007746f000 - 0000000077ffffff 
[    0.318097] reserve RAM buffer: 0000000077717000 - 0000000077ffffff 
[    0.318101] reserve RAM buffer: 000000007775e000 - 0000000077ffffff 
[    0.318104] reserve RAM buffer: 00000000777e1000 - 0000000077ffffff 
[    0.318106] reserve RAM buffer: 0000000077800000 - 0000000077ffffff 
[    0.318245] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.318706] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.320805] Switching to clocksource hpet
[    0.322696] pnp: PnP ACPI init
[    0.322787] ACPI: bus type pnp registered
[    0.323267] pnp 00:00: [bus 00-fe]
[    0.323270] pnp 00:00: [io  0x0000-0x0cf7 window]
[    0.323273] pnp 00:00: [io  0x0cf8-0x0cff]
[    0.323275] pnp 00:00: [io  0x0d00-0xffff window]
[    0.323277] pnp 00:00: [mem 0x000a0000-0x000bffff window]
[    0.323279] pnp 00:00: [mem 0x000c0000-0x000c3fff window]
[    0.323282] pnp 00:00: [mem 0x000c4000-0x000c7fff window]
[    0.323284] pnp 00:00: [mem 0x000c8000-0x000cbfff window]
[    0.323286] pnp 00:00: [mem 0x000cc000-0x000cffff window]
[    0.323288] pnp 00:00: [mem 0x000d0000-0x000d3fff window]
[    0.323290] pnp 00:00: [mem 0x000d4000-0x000d7fff window]
[    0.323292] pnp 00:00: [mem 0x000d8000-0x000dbfff window]
[    0.323294] pnp 00:00: [mem 0x000dc000-0x000dffff window]
[    0.323296] pnp 00:00: [mem 0x000e0000-0x000e3fff window]
[    0.323298] pnp 00:00: [mem 0x000e4000-0x000e7fff window]
[    0.323301] pnp 00:00: [mem 0x000e8000-0x000ebfff window]
[    0.323303] pnp 00:00: [mem 0x000ec000-0x000effff window]
[    0.323305] pnp 00:00: [mem 0x000f0000-0x000fffff window]
[    0.323307] pnp 00:00: [mem 0x7c000000-0xfeafffff window]
[    0.323309] pnp 00:00: [mem 0xfed40000-0xfed44fff window]
[    0.323366] pnp 00:00: Plug and Play ACPI device, IDs PNP0a08 PNP0a03 (active)
[    0.323474] pnp 00:01: [io  0x0000-0x001f]
[    0.323477] pnp 00:01: [io  0x0081-0x0091]
[    0.323478] pnp 00:01: [io  0x0093-0x009f]
[    0.323480] pnp 00:01: [io  0x00c0-0x00df]
[    0.323482] pnp 00:01: [dma 4]
[    0.323517] pnp 00:01: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.323527] pnp 00:02: [mem 0xff000000-0xffffffff]
[    0.323561] pnp 00:02: Plug and Play ACPI device, IDs INT0800 (active)
[    0.323649] pnp 00:03: [irq 0 disabled]
[    0.323662] pnp 00:03: [irq 8]
[    0.323665] pnp 00:03: [mem 0xfed00000-0xfed003ff]
[    0.323701] pnp 00:03: Plug and Play ACPI device, IDs PNP0103 (active)
[    0.323712] pnp 00:04: [io  0x00f0]
[    0.323718] pnp 00:04: [irq 13]
[    0.323753] pnp 00:04: Plug and Play ACPI device, IDs PNP0c04 (active)
[    0.323767] pnp 00:05: [io  0x002e-0x002f]
[    0.323769] pnp 00:05: [io  0x004e-0x004f]
[    0.323771] pnp 00:05: [io  0x0061]
[    0.323773] pnp 00:05: [io  0x0063]
[    0.323774] pnp 00:05: [io  0x0065]
[    0.323776] pnp 00:05: [io  0x0067]
[    0.323778] pnp 00:05: [io  0x0070]
[    0.323780] pnp 00:05: [io  0x0080]
[    0.323781] pnp 00:05: [io  0x0092]
[    0.323783] pnp 00:05: [io  0x00b2-0x00b3]
[    0.323785] pnp 00:05: [io  0x0680-0x069f]
[    0.323787] pnp 00:05: [io  0x0500-0x050f]
[    0.323789] pnp 00:05: [io  0x0600-0x0603]
[    0.323790] pnp 00:05: [io  0xffff]
[    0.323792] pnp 00:05: [io  0x0400-0x047f]
[    0.323794] pnp 00:05: [io  0x1180-0x11ff]
[    0.323796] pnp 00:05: [io  0x164e-0x164f]
[    0.323797] pnp 00:05: [io  0xfe00]
[    0.323799] pnp 00:05: [io  0x0068]
[    0.323801] pnp 00:05: [io  0x006c]
[    0.323803] pnp 00:05: [io  0x0700-0x070f]
[    0.323867] system 00:05: [io  0x0680-0x069f] has been reserved
[    0.323953] system 00:05: [io  0x0500-0x050f] has been reserved
[    0.324035] system 00:05: [io  0x0600-0x0603] has been reserved
[    0.324114] system 00:05: [io  0xffff] has been reserved
[    0.324192] system 00:05: [io  0x0400-0x047f] has been reserved
[    0.324273] system 00:05: [io  0x1180-0x11ff] has been reserved
[    0.324352] system 00:05: [io  0x164e-0x164f] has been reserved
[    0.324434] system 00:05: [io  0xfe00] has been reserved
[    0.324513] system 00:05: [io  0x0700-0x070f] has been reserved
[    0.324593] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.324630] pnp 00:06: [io  0x06a0-0x06af]
[    0.324632] pnp 00:06: [io  0x06b0-0x06ff]
[    0.324685] system 00:06: [io  0x06a0-0x06af] has been reserved
[    0.324766] system 00:06: [io  0x06b0-0x06ff] has been reserved
[    0.324846] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.324899] pnp 00:07: [io  0x0070-0x0077]
[    0.324937] pnp 00:07: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.324968] pnp 00:08: [io  0x0060]
[    0.324970] pnp 00:08: [io  0x0064]
[    0.324976] pnp 00:08: [irq 1]
[    0.325013] pnp 00:08: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.325027] pnp 00:09: [irq 12]
[    0.325063] pnp 00:09: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.325364] pnp 00:0a: [mem 0xfed1c000-0xfed1ffff]
[    0.325367] pnp 00:0a: [mem 0xfed10000-0xfed13fff]
[    0.325369] pnp 00:0a: [mem 0xfed18000-0xfed18fff]
[    0.325371] pnp 00:0a: [mem 0xfed19000-0xfed19fff]
[    0.325373] pnp 00:0a: [mem 0xe0000000-0xefffffff]
[    0.325376] pnp 00:0a: [mem 0x00000000-0xffffffffffffffff disabled]
[    0.325378] pnp 00:0a: [mem 0xfeaff000-0xfeafffff]
[    0.325380] pnp 00:0a: [mem 0xfed20000-0xfed3ffff]
[    0.325382] pnp 00:0a: [mem 0xfed90000-0xfed8ffff disabled]
[    0.325384] pnp 00:0a: [mem 0xfed40000-0xfed44fff]
[    0.325386] pnp 00:0a: [mem 0xfed45000-0xfed8ffff]
[    0.325388] pnp 00:0a: [mem 0xff000000-0xffffffff]
[    0.325390] pnp 00:0a: [mem 0xfee00000-0xfeefffff]
[    0.325453] system 00:0a: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.325535] system 00:0a: [mem 0xfed10000-0xfed13fff] has been reserved
[    0.325618] system 00:0a: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.325701] system 00:0a: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.325784] system 00:0a: [mem 0xe0000000-0xefffffff] has been reserved
[    0.325868] system 00:0a: [mem 0xfeaff000-0xfeafffff] has been reserved
[    0.325950] system 00:0a: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.326036] system 00:0a: [mem 0xfed40000-0xfed44fff] has been reserved
[    0.326117] system 00:0a: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.326199] system 00:0a: [mem 0xff000000-0xffffffff] has been reserved
[    0.326285] system 00:0a: [mem 0xfee00000-0xfeefffff] could not be reserved
[    0.326370] system 00:0a: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.326556] pnp 00:0b: [bus ff]
[    0.326600] pnp 00:0b: Plug and Play ACPI device, IDs PNP0a03 (active)
[    0.326970] pnp: PnP ACPI: found 12 devices
[    0.327048] ACPI: ACPI bus type pnp unregistered
[    0.334127] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 02-02] add_size 1000
[    0.334132] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 02-02] add_size 200000
[    0.334136] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff] to [bus 02-02] add_size 200000
[    0.334148] pci 0000:00:1c.1: bridge window [io  0x1000-0x0fff] to [bus 03-03] add_size 1000
[    0.334152] pci 0000:00:1c.1: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 03-03] add_size 200000
[    0.334164] pci 0000:00:1c.4: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 08-08] add_size 200000
[    0.334183] pci 0000:00:1c.0: res[14]=[mem 0x00100000-0x000fffff] get_res_add_size add_size 200000
[    0.334186] pci 0000:00:1c.0: res[15]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 200000
[    0.334189] pci 0000:00:1c.1: res[15]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 200000
[    0.334192] pci 0000:00:1c.4: res[15]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 200000
[    0.334195] pci 0000:00:1c.0: res[13]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
[    0.334197] pci 0000:00:1c.1: res[13]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
[    0.334203] pci 0000:00:1c.0: BAR 14: assigned [mem 0x7c000000-0x7c1fffff]
[    0.334292] pci 0000:00:1c.0: BAR 15: assigned [mem 0x7c200000-0x7c3fffff 64bit pref]
[    0.334401] pci 0000:00:1c.1: BAR 15: assigned [mem 0x7c400000-0x7c5fffff 64bit pref]
[    0.334507] pci 0000:00:1c.4: BAR 15: assigned [mem 0x7c600000-0x7c7fffff 64bit pref]
[    0.334614] pci 0000:00:1c.0: BAR 13: assigned [io  0x4000-0x4fff]
[    0.334695] pci 0000:00:1c.1: BAR 13: assigned [io  0x5000-0x5fff]
[    0.334781] pci 0000:01:00.0: BAR 6: assigned [mem 0xad000000-0xad07ffff pref]
[    0.334884] pci 0000:00:01.0: PCI bridge to [bus 01-01]
[    0.334961] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.335042] pci 0000:00:01.0:   bridge window [mem 0xac000000-0xadefffff]
[    0.335127] pci 0000:00:01.0:   bridge window [mem 0xae000000-0xbfffffff 64bit pref]
[    0.335234] pci 0000:00:1c.0: PCI bridge to [bus 02-02]
[    0.335312] pci 0000:00:1c.0:   bridge window [io  0x4000-0x4fff]
[    0.335398] pci 0000:00:1c.0:   bridge window [mem 0x7c000000-0x7c1fffff]
[    0.335484] pci 0000:00:1c.0:   bridge window [mem 0x7c200000-0x7c3fffff 64bit pref]
[    0.335594] pci 0000:00:1c.1: PCI bridge to [bus 03-03]
[    0.335671] pci 0000:00:1c.1:   bridge window [io  0x5000-0x5fff]
[    0.335759] pci 0000:00:1c.1:   bridge window [mem 0xf0500000-0xf05fffff]
[    0.335844] pci 0000:00:1c.1:   bridge window [mem 0x7c400000-0x7c5fffff 64bit pref]
[    0.335955] pci 0000:00:1c.4: PCI bridge to [bus 08-08]
[    0.336034] pci 0000:00:1c.4:   bridge window [io  0x3000-0x3fff]
[    0.336122] pci 0000:00:1c.4:   bridge window [mem 0xf0400000-0xf04fffff]
[    0.336207] pci 0000:00:1c.4:   bridge window [mem 0x7c600000-0x7c7fffff 64bit pref]
[    0.336318] pci 0000:00:1e.0: PCI bridge to [bus 0a-0a]
[    0.336446] pci 0000:00:1e.0: setting latency timer to 64
[    0.336451] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    0.336453] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    0.336456] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    0.336458] pci_bus 0000:00: resource 7 [mem 0x000d4000-0x000d7fff]
[    0.336460] pci_bus 0000:00: resource 8 [mem 0x000d8000-0x000dbfff]
[    0.336462] pci_bus 0000:00: resource 9 [mem 0x000e0000-0x000e3fff]
[    0.336465] pci_bus 0000:00: resource 10 [mem 0x7c000000-0xfeafffff]
[    0.336467] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
[    0.336469] pci_bus 0000:01: resource 1 [mem 0xac000000-0xadefffff]
[    0.336472] pci_bus 0000:01: resource 2 [mem 0xae000000-0xbfffffff 64bit pref]
[    0.336474] pci_bus 0000:02: resource 0 [io  0x4000-0x4fff]
[    0.336476] pci_bus 0000:02: resource 1 [mem 0x7c000000-0x7c1fffff]
[    0.336478] pci_bus 0000:02: resource 2 [mem 0x7c200000-0x7c3fffff 64bit pref]
[    0.336481] pci_bus 0000:03: resource 0 [io  0x5000-0x5fff]
[    0.336483] pci_bus 0000:03: resource 1 [mem 0xf0500000-0xf05fffff]
[    0.336485] pci_bus 0000:03: resource 2 [mem 0x7c400000-0x7c5fffff 64bit pref]
[    0.336488] pci_bus 0000:08: resource 0 [io  0x3000-0x3fff]
[    0.336490] pci_bus 0000:08: resource 1 [mem 0xf0400000-0xf04fffff]
[    0.336492] pci_bus 0000:08: resource 2 [mem 0x7c600000-0x7c7fffff 64bit pref]
[    0.336495] pci_bus 0000:0a: resource 4 [io  0x0000-0x0cf7]
[    0.336497] pci_bus 0000:0a: resource 5 [io  0x0d00-0xffff]
[    0.336500] pci_bus 0000:0a: resource 6 [mem 0x000a0000-0x000bffff]
[    0.336502] pci_bus 0000:0a: resource 7 [mem 0x000d4000-0x000d7fff]
[    0.336504] pci_bus 0000:0a: resource 8 [mem 0x000d8000-0x000dbfff]
[    0.336506] pci_bus 0000:0a: resource 9 [mem 0x000e0000-0x000e3fff]
[    0.336509] pci_bus 0000:0a: resource 10 [mem 0x7c000000-0xfeafffff]
[    0.336576] NET: Registered protocol family 2
[    0.336745] IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.337318] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
[    0.338700] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.339107] TCP: Hash tables configured (established 262144 bind 65536)
[    0.339189] TCP: reno registered
[    0.339269] UDP hash table entries: 1024 (order: 3, 32768 bytes)
[    0.339360] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes)
[    0.339563] NET: Registered protocol family 1
[    0.339660] pci 0000:00:02.0: Boot video device
[    0.339817] PCI: CLS 64 bytes, default 64
[    0.339870] Unpacking initramfs...
[    3.244045] Freeing initrd memory: 120896k freed
[    3.271756] Simple Boot Flag at 0x36 set to 0x1
[    3.272292] audit: initializing netlink socket (disabled)
[    3.272382] type=2000 audit(1341659157.156:1): initialized
[    3.286674] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    3.287241] VFS: Disk quotas dquot_6.5.2
[    3.287337] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    3.287493] msgmni has been set to 3743
[    3.287737] alg: No test for stdrng (krng)
[    3.287835] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    3.287953] io scheduler noop registered
[    3.288025] io scheduler deadline registered
[    3.288113] io scheduler cfq registered (default)
[    3.288304] pcieport 0000:00:01.0: irq 40 for MSI/MSI-X
[    3.288523] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    3.288620] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    3.288704] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    3.289204] intel_idle: MWAIT substates: 0x120
[    3.289206] intel_idle: v0.4 model 0x25
[    3.289208] intel_idle: lapic_timer_reliable_states 0xffffffff
[    3.289247] GHES: HEST is not enabled!
[    3.289377] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    3.289939] Linux agpgart interface v0.103
[    3.290082] agpgart-intel 0000:00:00.0: Intel HD Graphics Chipset
[    3.290279] agpgart-intel 0000:00:00.0: detected gtt size: 2097152K total, 262144K mappable
[    3.291216] agpgart-intel 0000:00:00.0: detected 32768K stolen memory
[    3.291441] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xd0000000
[    3.291664] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    3.296342] i8042: Detected active multiplexing controller, rev 1.1
[    3.298322] serio: i8042 KBD port at 0x60,0x64 irq 1
[    3.300899] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[    3.301004] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[    3.301103] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[    3.301202] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[    3.301390] mousedev: PS/2 mouse device common for all mice
[    3.301522] rtc_cmos 00:07: RTC can wake from S4
[    3.301739] rtc_cmos 00:07: rtc core: registered rtc_cmos as rtc0
[    3.301850] rtc0: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[    3.301973] cpuidle: using governor ladder
[    3.302086] cpuidle: using governor menu
[    3.302281] TCP: cubic registered
[    3.302437] NET: Registered protocol family 10
[    3.302777] Mobile IPv6
[    3.302846] NET: Registered protocol family 17
[    3.302923] Registering the dns_resolver key type
[    3.303291] PM: Hibernation image not present or could not be loaded.
[    3.303305] registered taskstats version 1
[    3.304017] rtc_cmos 00:07: setting system clock to 2012-07-07 11:05:58 UTC (1341659158)
[    3.304335] Initializing network drop monitor service
[    3.317425] Freeing unused kernel memory: 604k freed
[    3.317609] Write protecting the kernel read-only data: 6144k
[    3.319627] Freeing unused kernel memory: 496k freed
[    3.322428] Freeing unused kernel memory: 720k freed
[    3.348987] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    3.454092] udev[54]: starting version 164
[    3.498037] SCSI subsystem initialized
[    3.513101] usbcore: registered new interface driver usbfs
[    3.513208] usbcore: registered new interface driver hub
[    3.513391] usbcore: registered new device driver usb
[    3.514374] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    3.514507] ehci_hcd 0000:00:1a.0: setting latency timer to 64
[    3.514511] ehci_hcd 0000:00:1a.0: EHCI Host Controller
[    3.514617] ehci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
[    3.514755] ehci_hcd 0000:00:1a.0: debug port 2
[    3.518814] ehci_hcd 0000:00:1a.0: cache line size of 64 is not supported
[    3.519829] libata version 3.00 loaded.
[    3.538765] ehci_hcd 0000:00:1a.0: irq 16, io mem 0xf0806000
[    3.539143] thermal LNXTHERM:00: registered as thermal_zone0
[    3.539236] ACPI: Thermal Zone [TZ00] (59 C)
[    3.547581] ehci_hcd 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    3.547704] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    3.547815] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.547919] usb usb1: Product: EHCI Host Controller
[    3.547999] usb usb1: Manufacturer: Linux 3.4.4debugpsmouse ehci_hcd
[    3.548083] usb usb1: SerialNumber: 0000:00:1a.0
[    3.548431] hub 1-0:1.0: USB hub found
[    3.548511] hub 1-0:1.0: 3 ports detected
[    3.548671] ahci 0000:00:1f.2: version 3.0
[    3.548748] ahci 0000:00:1f.2: irq 41 for MSI/MSI-X
[    3.548793] ahci: SSS flag set, parallel bus scan disabled
[    3.548915] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 4 ports 3 Gbps 0x32 impl SATA mode
[    3.549023] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pio slum part ems apst 
[    3.549135] ahci 0000:00:1f.2: setting latency timer to 64
[    3.564193] scsi0 : ahci
[    3.564464] scsi1 : ahci
[    3.564730] scsi2 : ahci
[    3.564987] scsi3 : ahci
[    3.565242] scsi4 : ahci
[    3.565469] scsi5 : ahci
[    3.565665] ata1: DUMMY
[    3.565747] ata2: SATA max UDMA/133 abar m2048@0xf0805000 port 0xf0805180 irq 41
[    3.565865] ata3: DUMMY
[    3.565943] ata4: DUMMY
[    3.566024] ata5: SATA max UDMA/133 abar m2048@0xf0805000 port 0xf0805300 irq 41
[    3.566144] ata6: SATA max UDMA/133 abar m2048@0xf0805000 port 0xf0805380 irq 41
[    3.566390] ehci_hcd 0000:00:1d.0: setting latency timer to 64
[    3.566397] ehci_hcd 0000:00:1d.0: EHCI Host Controller
[    3.566517] ehci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    3.566694] ehci_hcd 0000:00:1d.0: debug port 2
[    3.570790] ehci_hcd 0000:00:1d.0: cache line size of 64 is not supported
[    3.570817] ehci_hcd 0000:00:1d.0: irq 23, io mem 0xf0806400
[    3.579577] ehci_hcd 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    3.579701] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    3.579797] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.579914] usb usb2: Product: EHCI Host Controller
[    3.580001] usb usb2: Manufacturer: Linux 3.4.4debugpsmouse ehci_hcd
[    3.580093] usb usb2: SerialNumber: 0000:00:1d.0
[    3.580449] hub 2-0:1.0: USB hub found
[    3.580543] hub 2-0:1.0: 3 ports detected
[    3.624021] atl1c 0000:08:00.0: version 1.0.1.0-NAPI
[    3.859462] usb 1-1: new high-speed USB device number 2 using ehci_hcd
[    3.883462] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    3.937627] ata2.00: ATA-8: TOSHIBA MK3265GSX, GJ205E, max UDMA/100
[    3.937722] ata2.00: 625142448 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    3.938762] ata2.00: configured for UDMA/100
[    3.939209] scsi 1:0:0:0: Direct-Access     ATA      TOSHIBA MK3265GS GJ20 PQ: 0 ANSI: 5
[    3.991745] usb 1-1: New USB device found, idVendor=8087, idProduct=0020
[    3.991837] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.992316] hub 1-1:1.0: USB hub found
[    3.992491] hub 1-1:1.0: 6 ports detected
[    4.103364] usb 2-1: new high-speed USB device number 2 using ehci_hcd
[    4.235651] usb 2-1: New USB device found, idVendor=8087, idProduct=0020
[    4.235742] usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    4.236219] hub 2-1:1.0: USB hub found
[    4.236351] hub 2-1:1.0: 8 ports detected
[    4.259304] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    4.262370] ata5.00: ATAPI: PLDS DVD-RW DS8A8SH, KL31, max UDMA/100
[    4.263676] ata5.00: configured for UDMA/100
[    4.271302] Refined TSC clocksource calibration: 2127.999 MHz.
[    4.271336] scsi 4:0:0:0: CD-ROM            PLDS     DVD-RW DS8A8SH   KL31 PQ: 0 ANSI: 5
[    4.271496] Switching to clocksource tsc
[    4.307376] usb 1-1.1: new low-speed USB device number 3 using ehci_hcd
[    4.403072] usb 1-1.1: New USB device found, idVendor=15d9, idProduct=0a4f
[    4.403175] usb 1-1.1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    4.403282] usb 1-1.1: Product:  USB OPTICAL MOUSE
[    4.507287] usb 2-1.2: new low-speed USB device number 3 using ehci_hcd
[    4.591157] ata6: SATA link down (SStatus 0 SControl 300)
[    4.597687] sd 1:0:0:0: [sda] 625142448 512-byte logical blocks: (320 GB/298 GiB)
[    4.597827] sd 1:0:0:0: [sda] Write Protect is off
[    4.597901] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    4.597917] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    4.602749] usb 2-1.2: New USB device found, idVendor=0079, idProduct=0011
[    4.602845] usb 2-1.2: New USB device strings: Mfr=0, Product=2, SerialNumber=0
[    4.602957] usb 2-1.2: Product: USB Gamepad 
[    4.611154] input:  USB OPTICAL MOUSE as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1/1-1.1:1.0/input/input1
[    4.611543] generic-usb 0003:15D9:0A4F.0001: input,hidraw0: USB HID v1.11 Mouse [ USB OPTICAL MOUSE] on usb-0000:00:1a.0-1.1/input0
[    4.611785] usbcore: registered new interface driver usbhid
[    4.611870] usbhid: USB HID core driver
[    4.675207] usb 2-1.4: new high-speed USB device number 4 using ehci_hcd
[    4.726642]  sda: sda1 sda2 sda3 < sda5 sda6 sda7 > sda4
[    4.728414] sd 1:0:0:0: [sda] Attached SCSI disk
[    4.736609] sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
[    4.736727] cdrom: Uniform CD-ROM driver Revision: 3.20
[    4.737040] sr 4:0:0:0: Attached scsi CD-ROM sr0
[    4.740245] sd 1:0:0:0: Attached scsi generic sg0 type 0
[    4.740360] sr 4:0:0:0: Attached scsi generic sg1 type 5
[    4.782046] usb 2-1.4: New USB device found, idVendor=5986, idProduct=0294
[    4.782140] usb 2-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.782246] usb 2-1.4: Product: Lenovo EasyCamera
[    4.782320] usb 2-1.4: Manufacturer: Bison Corp.
[    5.543938] nbd: registered device at major 43
[    5.559928] device-mapper: uevent: version 1.0.3
[    5.560252] device-mapper: ioctl: 4.22.0-ioctl (2011-10-19) initialised: dm-devel@redhat.com
[    5.711851] EXT4-fs (sda7): mounted filesystem with ordered data mode. Opts: (null)
[   17.536963] udev[369]: starting version 164
[   17.843837] input: Lid Switch as /devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input2
[   17.844431] ACPI: Lid Switch [LID]
[   17.844563] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input3
[   17.844673] ACPI: Power Button [PWRB]
[   17.844833] input: Sleep Button as /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input4
[   17.844936] ACPI: Sleep Button [SLPB]
[   17.845145] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input5
[   17.845556] ACPI: Power Button [PWRF]
[   18.079584] intel ips 0000:00:1f.6: No CPUID match found.
[   18.079665] intel ips 0000:00:1f.6: IPS not supported on this CPU
[   18.126195] ACPI: Requesting acpi_cpufreq
[   18.163997] microcode: CPU0 sig=0x20655, pf=0x10, revision=0x2
[   18.186631] microcode: CPU1 sig=0x20655, pf=0x10, revision=0x2
[   18.192903] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[   18.276187] input: USB Gamepad  as /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.0/input/input6
[   18.276396] dragonrise 0003:0079:0011.0002: input,hidraw1: USB HID v1.10 Joystick [USB Gamepad ] on usb-0000:00:1d.0-1.2/input0
[   18.448477] input: PC Speaker as /devices/platform/pcspkr/input/input7
[   18.535547] ACPI: AC Adapter [ACAD] (on-line)
[   18.902340] cfg80211: Calling CRDA to update world regulatory domain
[   19.495754] psmouse serio4: alps: E6 report: 00 00 64
[   19.521210] psmouse serio4: alps: E7 report: 73 03 50
[   19.619902] ACPI: Battery Slot [BAT1] (battery present)
[   19.622671] wmi: Mapper loaded
[   19.765567] input: Ideapad extra buttons as /devices/platform/ideapad/input/input8
[   19.934146] Linux media interface: v0.10
[   19.935069] psmouse serio4: alps: E6 report: 00 00 64
[   19.960457] psmouse serio4: alps: E7 report: 73 03 50
[   20.000732] psmouse serio4: alps: Status: 10 00 0a
[   20.026497] input: PS/2 Mouse as /devices/platform/i8042/serio4/input/input9
[   20.042797] input: AlpsPS/2 ALPS GlidePoint as /devices/platform/i8042/serio4/input/input10
[   20.059219] ACPI Warning: 0x0000000000001840-0x000000000000185f SystemIO conflicts with Region \_SB_.PCI0.SBUS.SMBI 1 (20120320/utaddress-251)
[   20.059430] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[   20.128642] Linux video capture interface: v2.00
[   20.593510] [drm] Initialized drm 1.1.0 20060810
[   20.719237] uvcvideo: Found UVC 1.00 device Lenovo EasyCamera (5986:0294)
[   20.721643] input: Lenovo EasyCamera as /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.4/2-1.4:1.0/input/input11
[   20.721840] usbcore: registered new interface driver uvcvideo
[   20.721916] USB Video Class driver (1.1.1)
[   21.159986] i915 0000:00:02.0: setting latency timer to 64
[   21.214361] i915 0000:00:02.0: irq 42 for MSI/MSI-X
[   21.214373] [drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
[   21.214459] [drm] Driver supports precise vblank timestamp query.
[   21.214618] [drm:intel_dsm_platform_mux_info] *ERROR* MUX INFO call failed
[   21.214726] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=none:owns=io+mem
[   21.214838] vgaarb: transferring owner from PCI:0000:00:02.0 to PCI:0000:01:00.0
[   21.627715] fbcon: inteldrmfb (fb0) is primary device
[   21.752240] ath: EEPROM regdomain: 0x65
[   21.752244] ath: EEPROM indicates we should expect a direct regpair map
[   21.752250] ath: Country alpha2 being used: 00
[   21.752253] ath: Regpair used: 0x65
[   21.778755] ieee80211 phy0: Selected rate control algorithm 'ath9k_rate_control'
[   21.779204] Registered led device: ath9k-phy0
[   21.779216] ieee80211 phy0: Atheros AR9285 Rev:2 mem=0xffffc90010920000, irq=17
[   21.875313] Console: switching to colour frame buffer device 170x48
[   21.882817] fb0: inteldrmfb frame buffer device
[   21.882820] drm: registered panic notifier
[   21.883109] ACPI Exception: AE_NOT_FOUND, Evaluating _DOD (20120320/video-1147)
[   21.883164] video: probe of LNXVIDEO:00 failed with error 5
[   21.885789] input: Video Bus as /devices/LNXSYSTM:00/device:00/PNP0A08:00/LNXVIDEO:01/input/input12
[   21.885970] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[   21.886100] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 0
[   21.886247] snd_hda_intel 0000:00:1b.0: irq 43 for MSI/MSI-X
[   21.960568] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/input/input13
[   21.964914] input: HDA Intel Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input14
[   21.965033] input: HDA Intel Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input15
[   22.123821] EXT4-fs (sda7): re-mounted. Opts: (null)
[   22.166595] EXT4-fs (sda7): re-mounted. Opts: errors=remount-ro
[   22.641608] loop: module loaded
[   23.759344] fuse init (API version 7.18)
[   24.781223] ADDRCONF(NETDEV_UP): wlan0: link is not ready
[   25.360823] input: ACPI Virtual Keyboard Device as /devices/virtual/input/input16
[   26.317349] Clocksource tsc unstable (delta = -555400892 ns)
[   27.338689] atl1c 0000:08:00.0: irq 44 for MSI/MSI-X
[   27.338709] Switching to clocksource hpet
[   28.700870] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   30.397841] sshd (1952): /proc/1952/oom_adj is deprecated, please use /proc/1952/oom_score_adj instead.
[   53.614877] wlan0: authenticate with ec:17:2f:2f:e9:b6
[   53.628120] wlan0: send auth to ec:17:2f:2f:e9:b6 (try 1/3)
[   53.630538] wlan0: authenticated
[   53.638363] wlan0: associate with ec:17:2f:2f:e9:b6 (try 1/3)
[   53.644330] wlan0: RX AssocResp from ec:17:2f:2f:e9:b6 (capab=0x431 status=0 aid=1)
[   53.644339] wlan0: associated
[   53.651270] ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready

--Multipart=_Sat__7_Jul_2012_13_35_19_+0800_amjr5p9Y4..xlEyg
Content-Type: text/plain;
 name="V2-00-inputdevices.txt"
Content-Disposition: attachment;
 filename="V2-00-inputdevices.txt"
Content-Transfer-Encoding: 7bit

I: Bus=0011 Vendor=0001 Product=0001 Version=ab41
N: Name="AT Translated Set 2 keyboard"
P: Phys=isa0060/serio0/input0
S: Sysfs=/devices/platform/i8042/serio0/input/input0
U: Uniq=
H: Handlers=sysrq kbd event0 
B: PROP=0
B: EV=120013
B: KEY=402000000 3803078f800d001 feffffdfffefffff fffffffffffffffe
B: MSC=10
B: LED=7

I: Bus=0003 Vendor=15d9 Product=0a4f Version=0111
N: Name=" USB OPTICAL MOUSE"
P: Phys=usb-0000:00:1a.0-1.1/input0
S: Sysfs=/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1/1-1.1:1.0/input/input1
U: Uniq=
H: Handlers=mouse0 event1 
B: PROP=0
B: EV=17
B: KEY=70000 0 0 0 0
B: REL=103
B: MSC=10

I: Bus=0019 Vendor=0000 Product=0005 Version=0000
N: Name="Lid Switch"
P: Phys=PNP0C0D/button/input0
S: Sysfs=/devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input2
U: Uniq=
H: Handlers=event2 
B: PROP=0
B: EV=21
B: SW=1

I: Bus=0019 Vendor=0000 Product=0001 Version=0000
N: Name="Power Button"
P: Phys=PNP0C0C/button/input0
S: Sysfs=/devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input3
U: Uniq=
H: Handlers=kbd event3 
B: PROP=0
B: EV=3
B: KEY=10000000000000 0

I: Bus=0019 Vendor=0000 Product=0003 Version=0000
N: Name="Sleep Button"
P: Phys=PNP0C0E/button/input0
S: Sysfs=/devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input4
U: Uniq=
H: Handlers=kbd event4 
B: PROP=0
B: EV=3
B: KEY=4000 0 0

I: Bus=0019 Vendor=0000 Product=0001 Version=0000
N: Name="Power Button"
P: Phys=LNXPWRBN/button/input0
S: Sysfs=/devices/LNXSYSTM:00/LNXPWRBN:00/input/input5
U: Uniq=
H: Handlers=kbd event5 
B: PROP=0
B: EV=3
B: KEY=10000000000000 0

I: Bus=0003 Vendor=0079 Product=0011 Version=0110
N: Name="USB Gamepad "
P: Phys=usb-0000:00:1d.0-1.2/input0
S: Sysfs=/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.0/input/input6
U: Uniq=
H: Handlers=event6 js0 
B: PROP=0
B: EV=1b
B: KEY=3ff00000000 0 0 0 0
B: ABS=3
B: MSC=10

I: Bus=0010 Vendor=001f Product=0001 Version=0100
N: Name="PC Speaker"
P: Phys=isa0061/input0
S: Sysfs=/devices/platform/pcspkr/input/input7
U: Uniq=
H: Handlers=kbd event7 
B: PROP=0
B: EV=40001
B: SND=6

I: Bus=0019 Vendor=0000 Product=0000 Version=0000
N: Name="Ideapad extra buttons"
P: Phys=ideapad/input0
S: Sysfs=/devices/platform/ideapad/input/input8
U: Uniq=
H: Handlers=kbd rfkill event8 
B: PROP=0
B: EV=13
B: KEY=1400800000000 300000 0 0
B: MSC=10

I: Bus=0011 Vendor=0002 Product=0008 Version=0000
N: Name="PS/2 Mouse"
P: Phys=isa0060/serio4/input1
S: Sysfs=/devices/platform/i8042/serio4/input/input9
U: Uniq=
H: Handlers=mouse1 event9 
B: PROP=0
B: EV=7
B: KEY=70000 0 0 0 0
B: REL=3

I: Bus=0011 Vendor=0002 Product=0008 Version=7335
N: Name="AlpsPS/2 ALPS GlidePoint"
P: Phys=isa0060/serio4/input0
S: Sysfs=/devices/platform/i8042/serio4/input/input10
U: Uniq=
H: Handlers=mouse2 event10 
B: PROP=0
B: EV=b
B: KEY=420 70000 0 0 0 0
B: ABS=1000003

I: Bus=0003 Vendor=5986 Product=0294 Version=1403
N: Name="Lenovo EasyCamera"
P: Phys=usb-0000:00:1d.0-1.4/button
S: Sysfs=/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.4/2-1.4:1.0/input/input11
U: Uniq=
H: Handlers=kbd event11 
B: PROP=0
B: EV=3
B: KEY=100000 0 0 0

I: Bus=0019 Vendor=0000 Product=0006 Version=0000
N: Name="Video Bus"
P: Phys=LNXVIDEO/video/input0
S: Sysfs=/devices/LNXSYSTM:00/device:00/PNP0A08:00/LNXVIDEO:01/input/input12
U: Uniq=
H: Handlers=kbd event12 
B: PROP=0
B: EV=3
B: KEY=3e000b00000000 0 0 0

I: Bus=0001 Vendor=10ec Product=0272 Version=0001
N: Name="HDA Digital PCBeep"
P: Phys=card0/codec#0/beep0
S: Sysfs=/devices/pci0000:00/0000:00:1b.0/input/input13
U: Uniq=
H: Handlers=kbd event13 
B: PROP=0
B: EV=40001
B: SND=6

I: Bus=0000 Vendor=0000 Product=0000 Version=0000
N: Name="HDA Intel Mic"
P: Phys=ALSA
S: Sysfs=/devices/pci0000:00/0000:00:1b.0/sound/card0/input14
U: Uniq=
H: Handlers=event14 
B: PROP=0
B: EV=21
B: SW=10

I: Bus=0000 Vendor=0000 Product=0000 Version=0000
N: Name="HDA Intel Headphone"
P: Phys=ALSA
S: Sysfs=/devices/pci0000:00/0000:00:1b.0/sound/card0/input15
U: Uniq=
H: Handlers=event15 
B: PROP=0
B: EV=21
B: SW=4

I: Bus=0003 Vendor=0000 Product=0000 Version=0004
N: Name="ACPI Virtual Keyboard Device"
P: Phys=
S: Sysfs=/devices/virtual/input/input16
U: Uniq=
H: Handlers=sysrq kbd rfkill event16 
B: PROP=0
B: EV=3
B: KEY=ffffffffffffffff ffffffffffffffff ffffffffffffffff fffffffffffffffe


--Multipart=_Sat__7_Jul_2012_13_35_19_+0800_amjr5p9Y4..xlEyg
Content-Type: text/plain;
 name="V2-00-xinputlist.txt"
Content-Disposition: attachment;
 filename="V2-00-xinputlist.txt"
Content-Transfer-Encoding: quoted-printable

=E2=8E=A1 Virtual core pointer                    	id=3D2	[master pointer  =
(3)]
	Reporting 3 classes:
		Class originated from: 14
		Buttons supported: 12
		Button labels: Button Left Button Middle Button Right Button Wheel Up But=
ton Wheel Down Button Horiz Wheel Left Button Horiz Wheel Right None None N=
one None None
		Button state:
		Class originated from: 14
		Detail for Valuator 0:
		  Label: Rel X
		  Range: -1.000000 - -1.000000
		  Resolution: 1 units/m
		  Mode: relative
		Class originated from: 14
		Detail for Valuator 1:
		  Label: Rel Y
		  Range: -1.000000 - -1.000000
		  Resolution: 1 units/m
		  Mode: relative

=E2=8E=9C   =E2=86=B3 Virtual core XTEST pointer              	id=3D4	[slav=
e  pointer  (2)]
	Reporting 3 classes:
		Class originated from: 4
		Buttons supported: 10
		Button labels: Button Left Button Middle Button Right Button Wheel Up But=
ton Wheel Down Button Horiz Wheel Left Button Horiz Wheel Right None None N=
one
		Button state:
		Class originated from: 4
		Detail for Valuator 0:
		  Label: Rel X
		  Range: -1.000000 - -1.000000
		  Resolution: 0 units/m
		  Mode: relative
		Class originated from: 4
		Detail for Valuator 1:
		  Label: Rel Y
		  Range: -1.000000 - -1.000000
		  Resolution: 0 units/m
		  Mode: relative

=E2=8E=9C   =E2=86=B3  USB OPTICAL MOUSE                      	id=3D10	[sla=
ve  pointer  (2)]
	Reporting 3 classes:
		Class originated from: 10
		Buttons supported: 7
		Button labels: Button Left Button Middle Button Right Button Wheel Up But=
ton Wheel Down Button Horiz Wheel Left Button Horiz Wheel Right
		Button state:
		Class originated from: 10
		Detail for Valuator 0:
		  Label: Rel X
		  Range: -1.000000 - -1.000000
		  Resolution: 1 units/m
		  Mode: relative
		Class originated from: 10
		Detail for Valuator 1:
		  Label: Rel Y
		  Range: -1.000000 - -1.000000
		  Resolution: 1 units/m
		  Mode: relative

=E2=8E=9C   =E2=86=B3 AlpsPS/2 ALPS GlidePoint                	id=3D13	[sla=
ve  pointer  (2)]
	Reporting 3 classes:
		Class originated from: 13
		Buttons supported: 12
		Button labels: Button Left Button Middle Button Right Button Wheel Up But=
ton Wheel Down Button Horiz Wheel Left Button Horiz Wheel Right None None N=
one None None
		Button state:
		Class originated from: 13
		Detail for Valuator 0:
		  Label: Rel X
		  Range: 0.000000 - 1023.000000
		  Resolution: 0 units/m
		  Mode: relative
		Class originated from: 13
		Detail for Valuator 1:
		  Label: Rel Y
		  Range: 0.000000 - 767.000000
		  Resolution: 0 units/m
		  Mode: relative

=E2=8E=9C   =E2=86=B3 PS/2 Mouse                              	id=3D14	[sla=
ve  pointer  (2)]
	Reporting 3 classes:
		Class originated from: 14
		Buttons supported: 5
		Button labels: Button Left Button Middle Button Right Button Wheel Up But=
ton Wheel Down
		Button state:
		Class originated from: 14
		Detail for Valuator 0:
		  Label: Rel X
		  Range: -1.000000 - -1.000000
		  Resolution: 1 units/m
		  Mode: relative
		Class originated from: 14
		Detail for Valuator 1:
		  Label: Rel Y
		  Range: -1.000000 - -1.000000
		  Resolution: 1 units/m
		  Mode: relative

=E2=8E=A3 Virtual core keyboard                   	id=3D3	[master keyboard =
(2)]
	Reporting 1 classes:
		Class originated from: 12
		Keycodes supported: 248

    =E2=86=B3 Virtual core XTEST keyboard             	id=3D5	[slave  keybo=
ard (3)]
	Reporting 1 classes:
		Class originated from: 5
		Keycodes supported: 248

    =E2=86=B3 Power Button                            	id=3D6	[slave  keybo=
ard (3)]
	Reporting 1 classes:
		Class originated from: 6
		Keycodes supported: 248

    =E2=86=B3 Video Bus                               	id=3D7	[slave  keybo=
ard (3)]
	Reporting 1 classes:
		Class originated from: 7
		Keycodes supported: 248

    =E2=86=B3 Power Button                            	id=3D8	[slave  keybo=
ard (3)]
	Reporting 1 classes:
		Class originated from: 8
		Keycodes supported: 248

    =E2=86=B3 Sleep Button                            	id=3D9	[slave  keybo=
ard (3)]
	Reporting 1 classes:
		Class originated from: 9
		Keycodes supported: 248

    =E2=86=B3 Lenovo EasyCamera                       	id=3D11	[slave  keyb=
oard (3)]
	Reporting 1 classes:
		Class originated from: 11
		Keycodes supported: 248

    =E2=86=B3 AT Translated Set 2 keyboard            	id=3D12	[slave  keyb=
oard (3)]
	Reporting 1 classes:
		Class originated from: 12
		Keycodes supported: 248

    =E2=86=B3 Ideapad extra buttons                   	id=3D15	[slave  keyb=
oard (3)]
	Reporting 1 classes:
		Class originated from: 15
		Keycodes supported: 248

    =E2=86=B3 ACPI Virtual Keyboard Device            	id=3D16	[slave  keyb=
oard (3)]
	Reporting 1 classes:
		Class originated from: 16
		Keycodes supported: 248


--Multipart=_Sat__7_Jul_2012_13_35_19_+0800_amjr5p9Y4..xlEyg
Content-Type: application/octet-stream;
 name="V2-00-Xorg.0.log"
Content-Disposition: attachment;
 filename="V2-00-Xorg.0.log"
Content-Transfer-Encoding: base64

WyAgICAyOS44NTVdIApYLk9yZyBYIFNlcnZlciAxLjEwLjQKUmVsZWFzZSBEYXRlOiAyMDExLTA4
LTE5ClsgICAgMjkuODU2XSBYIFByb3RvY29sIFZlcnNpb24gMTEsIFJldmlzaW9uIDAKWyAgICAy
OS44NTZdIEJ1aWxkIE9wZXJhdGluZyBTeXN0ZW06IExpbnV4IDMuMC4wLTEtYW1kNjQgeDg2XzY0
IERlYmlhbgpbICAgIDI5Ljg1Nl0gQ3VycmVudCBPcGVyYXRpbmcgU3lzdGVtOiBMaW51eCBsZGVi
aWFuIDMuNC40ZGVidWdwc21vdXNlICMxIFNNUCBGcmkgSnVsIDYgMDc6NDQ6NDkgQ1NUIDIwMTIg
eDg2XzY0ClsgICAgMjkuODU2XSBLZXJuZWwgY29tbWFuZCBsaW5lOiByb290PS9kZXYvc2RhNyBh
Y3BpX2JhY2tsaWdodD12ZW5kb3Igcm8KWyAgICAyOS44NTZdIEJ1aWxkIERhdGU6IDI4IEF1Z3Vz
dCAyMDExICAwOTozOTo0M1BNClsgICAgMjkuODU2XSB4b3JnLXNlcnZlciAyOjEuMTAuNC0xfmJw
bzYwKzEgKEN5cmlsIEJydWxlYm9pcyA8a2liaUBkZWJpYW4ub3JnPikgClsgICAgMjkuODU2XSBD
dXJyZW50IHZlcnNpb24gb2YgcGl4bWFuOiAwLjI0LjAKWyAgICAyOS44NTZdIAlCZWZvcmUgcmVw
b3J0aW5nIHByb2JsZW1zLCBjaGVjayBodHRwOi8vd2lraS54Lm9yZwoJdG8gbWFrZSBzdXJlIHRo
YXQgeW91IGhhdmUgdGhlIGxhdGVzdCB2ZXJzaW9uLgpbICAgIDI5Ljg1Nl0gTWFya2VyczogKC0t
KSBwcm9iZWQsICgqKikgZnJvbSBjb25maWcgZmlsZSwgKD09KSBkZWZhdWx0IHNldHRpbmcsCgko
KyspIGZyb20gY29tbWFuZCBsaW5lLCAoISEpIG5vdGljZSwgKElJKSBpbmZvcm1hdGlvbmFsLAoJ
KFdXKSB3YXJuaW5nLCAoRUUpIGVycm9yLCAoTkkpIG5vdCBpbXBsZW1lbnRlZCwgKD8/KSB1bmtu
b3duLgpbICAgIDI5Ljg1Nl0gKD09KSBMb2cgZmlsZTogIi92YXIvbG9nL1hvcmcuMC5sb2ciLCBU
aW1lOiBTYXQgSnVsICA3IDExOjA2OjI1IDIwMTIKWyAgICAyOS44OTddICg9PSkgVXNpbmcgc3lz
dGVtIGNvbmZpZyBkaXJlY3RvcnkgIi91c3Ivc2hhcmUvWDExL3hvcmcuY29uZi5kIgpbICAgIDI5
Ljg5N10gKD09KSBObyBMYXlvdXQgc2VjdGlvbi4gIFVzaW5nIHRoZSBmaXJzdCBTY3JlZW4gc2Vj
dGlvbi4KWyAgICAyOS44OTddICg9PSkgTm8gc2NyZWVuIHNlY3Rpb24gYXZhaWxhYmxlLiBVc2lu
ZyBkZWZhdWx0cy4KWyAgICAyOS45MDFdICgqKikgfC0tPlNjcmVlbiAiRGVmYXVsdCBTY3JlZW4g
U2VjdGlvbiIgKDApClsgICAgMjkuOTAxXSAoKiopIHwgICB8LS0+TW9uaXRvciAiPGRlZmF1bHQg
bW9uaXRvcj4iClsgICAgMjkuOTAxXSAoPT0pIE5vIG1vbml0b3Igc3BlY2lmaWVkIGZvciBzY3Jl
ZW4gIkRlZmF1bHQgU2NyZWVuIFNlY3Rpb24iLgoJVXNpbmcgYSBkZWZhdWx0IG1vbml0b3IgY29u
ZmlndXJhdGlvbi4KWyAgICAyOS45MDFdICg9PSkgQXV0b21hdGljYWxseSBhZGRpbmcgZGV2aWNl
cwpbICAgIDI5LjkwMV0gKD09KSBBdXRvbWF0aWNhbGx5IGVuYWJsaW5nIGRldmljZXMKWyAgICAy
OS45MDFdIChXVykgVGhlIGRpcmVjdG9yeSAiL3Vzci9zaGFyZS9mb250cy9YMTEvY3lyaWxsaWMi
IGRvZXMgbm90IGV4aXN0LgpbICAgIDI5LjkwMV0gCUVudHJ5IGRlbGV0ZWQgZnJvbSBmb250IHBh
dGguClsgICAgMjkuOTAxXSAoPT0pIEZvbnRQYXRoIHNldCB0bzoKCS91c3Ivc2hhcmUvZm9udHMv
WDExL21pc2MsCgkvdXNyL3NoYXJlL2ZvbnRzL1gxMS8xMDBkcGkvOnVuc2NhbGVkLAoJL3Vzci9z
aGFyZS9mb250cy9YMTEvNzVkcGkvOnVuc2NhbGVkLAoJL3Vzci9zaGFyZS9mb250cy9YMTEvVHlw
ZTEsCgkvdXNyL3NoYXJlL2ZvbnRzL1gxMS8xMDBkcGksCgkvdXNyL3NoYXJlL2ZvbnRzL1gxMS83
NWRwaSwKCS92YXIvbGliL2RlZm9tYS94LXR0Y2lkZm9udC1jb25mLmQvZGlycy9UcnVlVHlwZSwK
CWJ1aWx0LWlucwpbICAgIDI5LjkwMV0gKD09KSBNb2R1bGVQYXRoIHNldCB0byAiL3Vzci9saWIv
eG9yZy9tb2R1bGVzIgpbICAgIDI5LjkwMV0gKElJKSBUaGUgc2VydmVyIHJlbGllcyBvbiB1ZGV2
IHRvIHByb3ZpZGUgdGhlIGxpc3Qgb2YgaW5wdXQgZGV2aWNlcy4KCUlmIG5vIGRldmljZXMgYmVj
b21lIGF2YWlsYWJsZSwgcmVjb25maWd1cmUgdWRldiBvciBkaXNhYmxlIEF1dG9BZGREZXZpY2Vz
LgpbICAgIDI5LjkwMV0gKElJKSBMb2FkZXIgbWFnaWM6IDB4N2QzYWUwClsgICAgMjkuOTAxXSAo
SUkpIE1vZHVsZSBBQkkgdmVyc2lvbnM6ClsgICAgMjkuOTAxXSAJWC5PcmcgQU5TSSBDIEVtdWxh
dGlvbjogMC40ClsgICAgMjkuOTAxXSAJWC5PcmcgVmlkZW8gRHJpdmVyOiAxMC4wClsgICAgMjku
OTAxXSAJWC5PcmcgWElucHV0IGRyaXZlciA6IDEyLjIKWyAgICAyOS45MDFdIAlYLk9yZyBTZXJ2
ZXIgRXh0ZW5zaW9uIDogNS4wClsgICAgMjkuOTAyXSAoLS0pIFBDSToqKDA6MDoyOjApIDgwODY6
MDA0NjoxN2FhOjM5MjAgcmV2IDI0LCBNZW0gQCAweGYwMDAwMDAwLzQxOTQzMDQsIDB4ZDAwMDAw
MDAvMjY4NDM1NDU2LCBJL08gQCAweDAwMDAxODAwLzgKWyAgICAyOS45MDJdICgtLSkgUENJOiAo
MDoxOjA6MCkgMTBkZTowYTcwOjE3YWE6Mzk2OCByZXYgMTYyLCBNZW0gQCAweGFjMDAwMDAwLzE2
Nzc3MjE2LCAweGIwMDAwMDAwLzI2ODQzNTQ1NiwgMHhhZTAwMDAwMC8zMzU1NDQzMiwgSS9PIEAg
MHgwMDAwMjAwMC8xMjgsIEJJT1MgQCAweD8/Pz8/Pz8/LzUyNDI4OApbICAgIDI5LjkwMl0gKElJ
KSBPcGVuIEFDUEkgc3VjY2Vzc2Z1bCAoL3Zhci9ydW4vYWNwaWQuc29ja2V0KQpbICAgIDI5Ljkw
Ml0gKElJKSBMb2FkTW9kdWxlOiAiZXh0bW9kIgpbICAgIDI5Ljk2MF0gKElJKSBMb2FkaW5nIC91
c3IvbGliL3hvcmcvbW9kdWxlcy9leHRlbnNpb25zL2xpYmV4dG1vZC5zbwpbICAgIDI5Ljk2MF0g
KElJKSBNb2R1bGUgZXh0bW9kOiB2ZW5kb3I9IlguT3JnIEZvdW5kYXRpb24iClsgICAgMjkuOTYw
XSAJY29tcGlsZWQgZm9yIDEuMTAuNCwgbW9kdWxlIHZlcnNpb24gPSAxLjAuMApbICAgIDI5Ljk2
MF0gCU1vZHVsZSBjbGFzczogWC5PcmcgU2VydmVyIEV4dGVuc2lvbgpbICAgIDI5Ljk2MF0gCUFC
SSBjbGFzczogWC5PcmcgU2VydmVyIEV4dGVuc2lvbiwgdmVyc2lvbiA1LjAKWyAgICAyOS45NjBd
IChJSSkgTG9hZGluZyBleHRlbnNpb24gU0VMaW51eApbICAgIDI5Ljk2MF0gKElJKSBMb2FkaW5n
IGV4dGVuc2lvbiBNSVQtU0NSRUVOLVNBVkVSClsgICAgMjkuOTYwXSAoSUkpIExvYWRpbmcgZXh0
ZW5zaW9uIFhGcmVlODYtVmlkTW9kZUV4dGVuc2lvbgpbICAgIDI5Ljk2MF0gKElJKSBMb2FkaW5n
IGV4dGVuc2lvbiBYRnJlZTg2LURHQQpbICAgIDI5Ljk2MV0gKElJKSBMb2FkaW5nIGV4dGVuc2lv
biBEUE1TClsgICAgMjkuOTYxXSAoSUkpIExvYWRpbmcgZXh0ZW5zaW9uIFhWaWRlbwpbICAgIDI5
Ljk2MV0gKElJKSBMb2FkaW5nIGV4dGVuc2lvbiBYVmlkZW8tTW90aW9uQ29tcGVuc2F0aW9uClsg
ICAgMjkuOTYxXSAoSUkpIExvYWRpbmcgZXh0ZW5zaW9uIFgtUmVzb3VyY2UKWyAgICAyOS45NjFd
IChJSSkgTG9hZE1vZHVsZTogImRiZSIKWyAgICAyOS45NjFdIChJSSkgTG9hZGluZyAvdXNyL2xp
Yi94b3JnL21vZHVsZXMvZXh0ZW5zaW9ucy9saWJkYmUuc28KWyAgICAyOS45NjFdIChJSSkgTW9k
dWxlIGRiZTogdmVuZG9yPSJYLk9yZyBGb3VuZGF0aW9uIgpbICAgIDI5Ljk2MV0gCWNvbXBpbGVk
IGZvciAxLjEwLjQsIG1vZHVsZSB2ZXJzaW9uID0gMS4wLjAKWyAgICAyOS45NjFdIAlNb2R1bGUg
Y2xhc3M6IFguT3JnIFNlcnZlciBFeHRlbnNpb24KWyAgICAyOS45NjFdIAlBQkkgY2xhc3M6IFgu
T3JnIFNlcnZlciBFeHRlbnNpb24sIHZlcnNpb24gNS4wClsgICAgMjkuOTYxXSAoSUkpIExvYWRp
bmcgZXh0ZW5zaW9uIERPVUJMRS1CVUZGRVIKWyAgICAyOS45NjFdIChJSSkgTG9hZE1vZHVsZTog
ImdseCIKWyAgICAyOS45NjFdIChJSSkgTG9hZGluZyAvdXNyL2xpYi94b3JnL21vZHVsZXMvZXh0
ZW5zaW9ucy9saWJnbHguc28KWyAgICAyOS45NjFdIChJSSkgTW9kdWxlIGdseDogdmVuZG9yPSJY
Lk9yZyBGb3VuZGF0aW9uIgpbICAgIDI5Ljk2MV0gCWNvbXBpbGVkIGZvciAxLjEwLjQsIG1vZHVs
ZSB2ZXJzaW9uID0gMS4wLjAKWyAgICAyOS45NjFdIAlBQkkgY2xhc3M6IFguT3JnIFNlcnZlciBF
eHRlbnNpb24sIHZlcnNpb24gNS4wClsgICAgMjkuOTYxXSAoPT0pIEFJR0xYIGVuYWJsZWQKWyAg
ICAyOS45NjFdIChJSSkgTG9hZGluZyBleHRlbnNpb24gR0xYClsgICAgMjkuOTYxXSAoSUkpIExv
YWRNb2R1bGU6ICJyZWNvcmQiClsgICAgMjkuOTYxXSAoSUkpIExvYWRpbmcgL3Vzci9saWIveG9y
Zy9tb2R1bGVzL2V4dGVuc2lvbnMvbGlicmVjb3JkLnNvClsgICAgMjkuOTYxXSAoSUkpIE1vZHVs
ZSByZWNvcmQ6IHZlbmRvcj0iWC5PcmcgRm91bmRhdGlvbiIKWyAgICAyOS45NjFdIAljb21waWxl
ZCBmb3IgMS4xMC40LCBtb2R1bGUgdmVyc2lvbiA9IDEuMTMuMApbICAgIDI5Ljk2MV0gCU1vZHVs
ZSBjbGFzczogWC5PcmcgU2VydmVyIEV4dGVuc2lvbgpbICAgIDI5Ljk2MV0gCUFCSSBjbGFzczog
WC5PcmcgU2VydmVyIEV4dGVuc2lvbiwgdmVyc2lvbiA1LjAKWyAgICAyOS45NjFdIChJSSkgTG9h
ZGluZyBleHRlbnNpb24gUkVDT1JEClsgICAgMjkuOTYxXSAoSUkpIExvYWRNb2R1bGU6ICJkcmki
ClsgICAgMjkuOTYxXSAoSUkpIExvYWRpbmcgL3Vzci9saWIveG9yZy9tb2R1bGVzL2V4dGVuc2lv
bnMvbGliZHJpLnNvClsgICAgMjkuOTYyXSAoSUkpIE1vZHVsZSBkcmk6IHZlbmRvcj0iWC5Pcmcg
Rm91bmRhdGlvbiIKWyAgICAyOS45NjJdIAljb21waWxlZCBmb3IgMS4xMC40LCBtb2R1bGUgdmVy
c2lvbiA9IDEuMC4wClsgICAgMjkuOTYyXSAJQUJJIGNsYXNzOiBYLk9yZyBTZXJ2ZXIgRXh0ZW5z
aW9uLCB2ZXJzaW9uIDUuMApbICAgIDI5Ljk2Ml0gKElJKSBMb2FkaW5nIGV4dGVuc2lvbiBYRnJl
ZTg2LURSSQpbICAgIDI5Ljk2Ml0gKElJKSBMb2FkTW9kdWxlOiAiZHJpMiIKWyAgICAyOS45NjJd
IChJSSkgTG9hZGluZyAvdXNyL2xpYi94b3JnL21vZHVsZXMvZXh0ZW5zaW9ucy9saWJkcmkyLnNv
ClsgICAgMjkuOTYyXSAoSUkpIE1vZHVsZSBkcmkyOiB2ZW5kb3I9IlguT3JnIEZvdW5kYXRpb24i
ClsgICAgMjkuOTYyXSAJY29tcGlsZWQgZm9yIDEuMTAuNCwgbW9kdWxlIHZlcnNpb24gPSAxLjIu
MApbICAgIDI5Ljk2Ml0gCUFCSSBjbGFzczogWC5PcmcgU2VydmVyIEV4dGVuc2lvbiwgdmVyc2lv
biA1LjAKWyAgICAyOS45NjJdIChJSSkgTG9hZGluZyBleHRlbnNpb24gRFJJMgpbICAgIDI5Ljk2
Ml0gKD09KSBNYXRjaGVkIGludGVsIGFzIGF1dG9jb25maWd1cmVkIGRyaXZlciAwClsgICAgMjku
OTYyXSAoPT0pIE1hdGNoZWQgdmVzYSBhcyBhdXRvY29uZmlndXJlZCBkcml2ZXIgMQpbICAgIDI5
Ljk2Ml0gKD09KSBNYXRjaGVkIGZiZGV2IGFzIGF1dG9jb25maWd1cmVkIGRyaXZlciAyClsgICAg
MjkuOTYyXSAoPT0pIEFzc2lnbmVkIHRoZSBkcml2ZXIgdG8gdGhlIHhmODZDb25maWdMYXlvdXQK
WyAgICAyOS45NjJdIChJSSkgTG9hZE1vZHVsZTogImludGVsIgpbICAgIDI5Ljk2Ml0gKElJKSBM
b2FkaW5nIC91c3IvbGliL3hvcmcvbW9kdWxlcy9kcml2ZXJzL2ludGVsX2Rydi5zbwpbICAgIDI5
Ljk2Ml0gKElJKSBNb2R1bGUgaW50ZWw6IHZlbmRvcj0iWC5PcmcgRm91bmRhdGlvbiIKWyAgICAy
OS45NjJdIAljb21waWxlZCBmb3IgMS4xMC40LCBtb2R1bGUgdmVyc2lvbiA9IDIuMTUuMApbICAg
IDI5Ljk2Ml0gCU1vZHVsZSBjbGFzczogWC5PcmcgVmlkZW8gRHJpdmVyClsgICAgMjkuOTYyXSAJ
QUJJIGNsYXNzOiBYLk9yZyBWaWRlbyBEcml2ZXIsIHZlcnNpb24gMTAuMApbICAgIDI5Ljk2Ml0g
KElJKSBMb2FkTW9kdWxlOiAidmVzYSIKWyAgICAyOS45NjJdIChXVykgV2FybmluZywgY291bGRu
J3Qgb3BlbiBtb2R1bGUgdmVzYQpbICAgIDI5Ljk2Ml0gKElJKSBVbmxvYWRNb2R1bGU6ICJ2ZXNh
IgpbICAgIDI5Ljk2Ml0gKElJKSBVbmxvYWRpbmcgdmVzYQpbICAgIDI5Ljk2M10gKEVFKSBGYWls
ZWQgdG8gbG9hZCBtb2R1bGUgInZlc2EiIChtb2R1bGUgZG9lcyBub3QgZXhpc3QsIDApClsgICAg
MjkuOTYzXSAoSUkpIExvYWRNb2R1bGU6ICJmYmRldiIKWyAgICAyOS45NjNdIChXVykgV2Fybmlu
ZywgY291bGRuJ3Qgb3BlbiBtb2R1bGUgZmJkZXYKWyAgICAyOS45NjNdIChJSSkgVW5sb2FkTW9k
dWxlOiAiZmJkZXYiClsgICAgMjkuOTYzXSAoSUkpIFVubG9hZGluZyBmYmRldgpbICAgIDI5Ljk2
M10gKEVFKSBGYWlsZWQgdG8gbG9hZCBtb2R1bGUgImZiZGV2IiAobW9kdWxlIGRvZXMgbm90IGV4
aXN0LCAwKQpbICAgIDI5Ljk2M10gKElJKSBpbnRlbDogRHJpdmVyIGZvciBJbnRlbCBJbnRlZ3Jh
dGVkIEdyYXBoaWNzIENoaXBzZXRzOiBpODEwLAoJaTgxMC1kYzEwMCwgaTgxMGUsIGk4MTUsIGk4
MzBNLCA4NDVHLCA4NTQsIDg1MkdNLzg1NUdNLCA4NjVHLCA5MTVHLAoJRTcyMjEgKGk5MTUpLCA5
MTVHTSwgOTQ1RywgOTQ1R00sIDk0NUdNRSwgUGluZXZpZXcgR00sIFBpbmV2aWV3IEcsCgk5NjVH
LCBHMzUsIDk2NVEsIDk0NkdaLCA5NjVHTSwgOTY1R01FL0dMRSwgRzMzLCBRMzUsIFEzMywgR000
NSwKCTQgU2VyaWVzLCBHNDUvRzQzLCBRNDUvUTQzLCBHNDEsIEI0MywgQjQzLCBDbGFya2RhbGUs
IEFycmFuZGFsZSwKCVNhbmR5YnJpZGdlLCBTYW5keWJyaWRnZSwgU2FuZHlicmlkZ2UsIFNhbmR5
YnJpZGdlLCBTYW5keWJyaWRnZSwKCVNhbmR5YnJpZGdlLCBTYW5keWJyaWRnZQpbICAgIDI5Ljk2
M10gKCsrKSB1c2luZyBWVCBudW1iZXIgNwoKWyAgICAyOS45NjldIChJSSkgTG9hZGluZyAvdXNy
L2xpYi94b3JnL21vZHVsZXMvZHJpdmVycy9pbnRlbF9kcnYuc28KWyAgICAyOS45NjldIGRybU9w
ZW5EZXZpY2U6IG5vZGUgbmFtZSBpcyAvZGV2L2RyaS9jYXJkMApbICAgIDI5Ljk2OV0gZHJtT3Bl
bkRldmljZTogb3BlbiByZXN1bHQgaXMgOSwgKE9LKQpbICAgIDI5Ljk2OV0gZHJtT3BlbkJ5QnVz
aWQ6IFNlYXJjaGluZyBmb3IgQnVzSUQgcGNpOjAwMDA6MDA6MDIuMApbICAgIDI5Ljk2OV0gZHJt
T3BlbkRldmljZTogbm9kZSBuYW1lIGlzIC9kZXYvZHJpL2NhcmQwClsgICAgMjkuOTY5XSBkcm1P
cGVuRGV2aWNlOiBvcGVuIHJlc3VsdCBpcyA5LCAoT0spClsgICAgMjkuOTY5XSBkcm1PcGVuQnlC
dXNpZDogZHJtT3Blbk1pbm9yIHJldHVybnMgOQpbICAgIDI5Ljk2OV0gZHJtT3BlbkJ5QnVzaWQ6
IGRybUdldEJ1c2lkIHJlcG9ydHMgcGNpOjAwMDA6MDA6MDIuMApbICAgIDI5Ljk2OV0gKElJKSBp
bnRlbCgwKTogQ3JlYXRpbmcgZGVmYXVsdCBEaXNwbGF5IHN1YnNlY3Rpb24gaW4gU2NyZWVuIHNl
Y3Rpb24KCSJEZWZhdWx0IFNjcmVlbiBTZWN0aW9uIiBmb3IgZGVwdGgvZmJicHAgMjQvMzIKWyAg
ICAyOS45NjldICg9PSkgaW50ZWwoMCk6IERlcHRoIDI0LCAoLS0pIGZyYW1lYnVmZmVyIGJwcCAz
MgpbICAgIDI5Ljk2OV0gKD09KSBpbnRlbCgwKTogUkdCIHdlaWdodCA4ODgKWyAgICAyOS45Njld
ICg9PSkgaW50ZWwoMCk6IERlZmF1bHQgdmlzdWFsIGlzIFRydWVDb2xvcgpbICAgIDI5Ljk2OV0g
KElJKSBpbnRlbCgwKTogSW50ZWdyYXRlZCBHcmFwaGljcyBDaGlwc2V0OiBJbnRlbChSKSBBcnJh
bmRhbGUKWyAgICAyOS45NjldICgtLSkgaW50ZWwoMCk6IENoaXBzZXQ6ICJBcnJhbmRhbGUiClsg
ICAgMjkuOTY5XSAoKiopIGludGVsKDApOiBSZWxheGVkIGZlbmNpbmcgZW5hYmxlZApbICAgIDI5
Ljk2OV0gKCoqKSBpbnRlbCgwKTogRnJhbWVidWZmZXIgdGlsZWQKWyAgICAyOS45NjldICgqKikg
aW50ZWwoMCk6IFBpeG1hcHMgdGlsZWQKWyAgICAyOS45NjldICgqKikgaW50ZWwoMCk6IDNEIGJ1
ZmZlcnMgdGlsZWQKWyAgICAyOS45NjldICgqKikgaW50ZWwoMCk6IFN3YXBCdWZmZXJzIHdhaXQg
ZW5hYmxlZApbICAgIDI5Ljk2OV0gKD09KSBpbnRlbCgwKTogdmlkZW8gb3ZlcmxheSBrZXkgc2V0
IHRvIDB4MTAxZmUKWyAgICAyOS45NjldIChJSSkgaW50ZWwoMCk6IE91dHB1dCBMVkRTMSBoYXMg
bm8gbW9uaXRvciBzZWN0aW9uClsgICAgMjkuOTY5XSAoSUkpIGludGVsKDApOiBmb3VuZCBiYWNr
bGlnaHQgY29udHJvbCBpbnRlcmZhY2UgL3N5cy9jbGFzcy9iYWNrbGlnaHQvaW50ZWxfYmFja2xp
Z2h0ClsgICAgMjkuOTY5XSAoSUkpIGludGVsKDApOiBPdXRwdXQgVkdBMSBoYXMgbm8gbW9uaXRv
ciBzZWN0aW9uClsgICAgMjkuOTY5XSAoSUkpIGludGVsKDApOiBFRElEIGZvciBvdXRwdXQgTFZE
UzEKWyAgICAyOS45NjldIChJSSkgaW50ZWwoMCk6IE1hbnVmYWN0dXJlcjogQVVPICBNb2RlbDog
NDAyYyAgU2VyaWFsIzogMApbICAgIDI5Ljk3MF0gKElJKSBpbnRlbCgwKTogWWVhcjogMjAxMCAg
V2VlazogMApbICAgIDI5Ljk3MF0gKElJKSBpbnRlbCgwKTogRURJRCBWZXJzaW9uOiAxLjMKWyAg
ICAyOS45NzBdIChJSSkgaW50ZWwoMCk6IERpZ2l0YWwgRGlzcGxheSBJbnB1dApbICAgIDI5Ljk3
MF0gKElJKSBpbnRlbCgwKTogTWF4IEltYWdlIFNpemUgW2NtXTogaG9yaXouOiAyOSAgdmVydC46
IDE2ClsgICAgMjkuOTcwXSAoSUkpIGludGVsKDApOiBHYW1tYTogMi4yMApbICAgIDI5Ljk3MF0g
KElJKSBpbnRlbCgwKTogTm8gRFBNUyBjYXBhYmlsaXRpZXMgc3BlY2lmaWVkClsgICAgMjkuOTcw
XSAoSUkpIGludGVsKDApOiBTdXBwb3J0ZWQgY29sb3IgZW5jb2RpbmdzOiBSR0IgNDo0OjQgWUNy
Q2IgNDo0OjQgClsgICAgMjkuOTcwXSAoSUkpIGludGVsKDApOiBGaXJzdCBkZXRhaWxlZCB0aW1p
bmcgaXMgcHJlZmVycmVkIG1vZGUKWyAgICAyOS45NzBdIChJSSkgaW50ZWwoMCk6IHJlZFg6IDAu
NTkwIHJlZFk6IDAuMzQ1ICAgZ3JlZW5YOiAwLjMyNSBncmVlblk6IDAuNTQwClsgICAgMjkuOTcw
XSAoSUkpIGludGVsKDApOiBibHVlWDogMC4xNTAgYmx1ZVk6IDAuMTQ1ICAgd2hpdGVYOiAwLjMx
MyB3aGl0ZVk6IDAuMzI5ClsgICAgMjkuOTcwXSAoSUkpIGludGVsKDApOiBNYW51ZmFjdHVyZXIn
cyBtYXNrOiAwClsgICAgMjkuOTcwXSAoSUkpIGludGVsKDApOiBTdXBwb3J0ZWQgZGV0YWlsZWQg
dGltaW5nOgpbICAgIDI5Ljk3MF0gKElJKSBpbnRlbCgwKTogY2xvY2s6IDY5LjMgTUh6ICAgSW1h
Z2UgU2l6ZTogIDI5MyB4IDE2NCBtbQpbICAgIDI5Ljk3MF0gKElJKSBpbnRlbCgwKTogaF9hY3Rp
dmU6IDEzNjYgIGhfc3luYzogMTQxNCAgaF9zeW5jX2VuZCAxNDQ2IGhfYmxhbmtfZW5kIDE0NTYg
aF9ib3JkZXI6IDAKWyAgICAyOS45NzBdIChJSSkgaW50ZWwoMCk6IHZfYWN0aXZlOiA3NjggIHZf
c3luYzogNzcxICB2X3N5bmNfZW5kIDc3NyB2X2JsYW5raW5nOiA3OTMgdl9ib3JkZXI6IDAKWyAg
ICAyOS45NzBdIChJSSkgaW50ZWwoMCk6IFVua25vd24gdmVuZG9yLXNwZWNpZmljIGJsb2NrIGYK
WyAgICAyOS45NzBdIChJSSkgaW50ZWwoMCk6ICBBVU8KWyAgICAyOS45NzBdIChJSSkgaW50ZWwo
MCk6ICBCMTMzWFcwNCBWMApbICAgIDI5Ljk3MF0gKElJKSBpbnRlbCgwKTogRURJRCAoaW4gaGV4
KToKWyAgICAyOS45NzBdIChJSSkgaW50ZWwoMCk6IAkwMGZmZmZmZmZmZmZmZjAwMDZhZjJjNDAw
MDAwMDAwMApbICAgIDI5Ljk3MF0gKElJKSBpbnRlbCgwKTogCTAwMTQwMTAzODAxZDEwNzgwYTE1
ODU5NzU4NTM4YTI2ClsgICAgMjkuOTcwXSAoSUkpIGludGVsKDApOiAJMjU1MDU0MDAwMDAwMDEw
MTAxMDEwMTAxMDEwMTAxMDEKWyAgICAyOS45NzBdIChJSSkgaW50ZWwoMCk6IAkwMTAxMDEwMTAx
MDExMjFiNTY1YTUwMDAxOTMwMzAyMApbICAgIDI5Ljk3MF0gKElJKSBpbnRlbCgwKTogCTM2MDAy
NWE0MTAwMDAwMTgwMDAwMDAwZjAwMDAwMDAwClsgICAgMjkuOTcwXSAoSUkpIGludGVsKDApOiAJ
MDAwMDAwMDAwMDAwMDAwMDAwMjAwMDAwMDBmZTAwNDEKWyAgICAyOS45NzBdIChJSSkgaW50ZWwo
MCk6IAk1NTRmMGEyMDIwMjAyMDIwMjAyMDIwMjAwMDAwMDBmZQpbICAgIDI5Ljk3MF0gKElJKSBp
bnRlbCgwKTogCTAwNDIzMTMzMzM1ODU3MzAzNDIwNTYzMDIwMGEwMDU2ClsgICAgMjkuOTcwXSAo
SUkpIGludGVsKDApOiBFRElEIHZlbmRvciAiQVVPIiwgcHJvZCBpZCAxNjQyOApbICAgIDI5Ljk3
MF0gKElJKSBpbnRlbCgwKTogUHJpbnRpbmcgRERDIGdhdGhlcmVkIE1vZGVsaW5lczoKWyAgICAy
OS45NzBdIChJSSkgaW50ZWwoMCk6IE1vZGVsaW5lICIxMzY2eDc2OCJ4MC4wICAgNjkuMzAgIDEz
NjYgMTQxNCAxNDQ2IDE0NTYgIDc2OCA3NzEgNzc3IDc5MyAtaHN5bmMgLXZzeW5jICg0Ny42IGtI
eikKWyAgICAyOS45NzBdIChJSSkgaW50ZWwoMCk6IE5vdCB1c2luZyBkZWZhdWx0IG1vZGUgIjMy
MHgyNDAiIChkb3VibGVzY2FuIG1vZGUgbm90IHN1cHBvcnRlZCkKWyAgICAyOS45NzBdIChJSSkg
aW50ZWwoMCk6IE5vdCB1c2luZyBkZWZhdWx0IG1vZGUgIjQwMHgzMDAiIChkb3VibGVzY2FuIG1v
ZGUgbm90IHN1cHBvcnRlZCkKWyAgICAyOS45NzBdIChJSSkgaW50ZWwoMCk6IE5vdCB1c2luZyBk
ZWZhdWx0IG1vZGUgIjQwMHgzMDAiIChkb3VibGVzY2FuIG1vZGUgbm90IHN1cHBvcnRlZCkKWyAg
ICAyOS45NzBdIChJSSkgaW50ZWwoMCk6IE5vdCB1c2luZyBkZWZhdWx0IG1vZGUgIjUxMngzODQi
IChkb3VibGVzY2FuIG1vZGUgbm90IHN1cHBvcnRlZCkKWyAgICAyOS45NzBdIChJSSkgaW50ZWwo
MCk6IE5vdCB1c2luZyBkZWZhdWx0IG1vZGUgIjY0MHg0ODAiIChkb3VibGVzY2FuIG1vZGUgbm90
IHN1cHBvcnRlZCkKWyAgICAyOS45NzBdIChJSSkgaW50ZWwoMCk6IE5vdCB1c2luZyBkZWZhdWx0
IG1vZGUgIjY0MHg1MTIiIChkb3VibGVzY2FuIG1vZGUgbm90IHN1cHBvcnRlZCkKWyAgICAyOS45
NzBdIChJSSkgaW50ZWwoMCk6IE5vdCB1c2luZyBkZWZhdWx0IG1vZGUgIjgwMHg2MDAiIChkb3Vi
bGVzY2FuIG1vZGUgbm90IHN1cHBvcnRlZCkKWyAgICAyOS45NzBdIChJSSkgaW50ZWwoMCk6IE5v
dCB1c2luZyBkZWZhdWx0IG1vZGUgIjg5Nng2NzIiIChkb3VibGVzY2FuIG1vZGUgbm90IHN1cHBv
cnRlZCkKWyAgICAyOS45NzBdIChJSSkgaW50ZWwoMCk6IE5vdCB1c2luZyBkZWZhdWx0IG1vZGUg
IjkyOHg2OTYiIChkb3VibGVzY2FuIG1vZGUgbm90IHN1cHBvcnRlZCkKWyAgICAyOS45NzBdIChJ
SSkgaW50ZWwoMCk6IE5vdCB1c2luZyBkZWZhdWx0IG1vZGUgIjk2MHg3MjAiIChkb3VibGVzY2Fu
IG1vZGUgbm90IHN1cHBvcnRlZCkKWyAgICAyOS45NzBdIChJSSkgaW50ZWwoMCk6IE5vdCB1c2lu
ZyBkZWZhdWx0IG1vZGUgIjU3Nng0MzIiIChkb3VibGVzY2FuIG1vZGUgbm90IHN1cHBvcnRlZCkK
WyAgICAyOS45NzBdIChJSSkgaW50ZWwoMCk6IE5vdCB1c2luZyBkZWZhdWx0IG1vZGUgIjY4MHgz
ODQiIChkb3VibGVzY2FuIG1vZGUgbm90IHN1cHBvcnRlZCkKWyAgICAyOS45NzBdIChJSSkgaW50
ZWwoMCk6IE5vdCB1c2luZyBkZWZhdWx0IG1vZGUgIjY4MHgzODQiIChkb3VibGVzY2FuIG1vZGUg
bm90IHN1cHBvcnRlZCkKWyAgICAyOS45NzBdIChJSSkgaW50ZWwoMCk6IE5vdCB1c2luZyBkZWZh
dWx0IG1vZGUgIjcwMHg1MjUiIChkb3VibGVzY2FuIG1vZGUgbm90IHN1cHBvcnRlZCkKWyAgICAy
OS45NzBdIChJSSkgaW50ZWwoMCk6IE5vdCB1c2luZyBkZWZhdWx0IG1vZGUgIjcyMHg0NTAiIChk
b3VibGVzY2FuIG1vZGUgbm90IHN1cHBvcnRlZCkKWyAgICAyOS45NzBdIChJSSkgaW50ZWwoMCk6
IE5vdCB1c2luZyBkZWZhdWx0IG1vZGUgIjgwMHg1MTIiIChkb3VibGVzY2FuIG1vZGUgbm90IHN1
cHBvcnRlZCkKWyAgICAyOS45NzBdIChJSSkgaW50ZWwoMCk6IE5vdCB1c2luZyBkZWZhdWx0IG1v
ZGUgIjg0MHg1MjUiIChkb3VibGVzY2FuIG1vZGUgbm90IHN1cHBvcnRlZCkKWyAgICAyOS45NzBd
IChJSSkgaW50ZWwoMCk6IE5vdCB1c2luZyBkZWZhdWx0IG1vZGUgIjg0MHg1MjUiIChkb3VibGVz
Y2FuIG1vZGUgbm90IHN1cHBvcnRlZCkKWyAgICAyOS45NzBdIChJSSkgaW50ZWwoMCk6IE5vdCB1
c2luZyBkZWZhdWx0IG1vZGUgIjk2MHg1NDAiIChkb3VibGVzY2FuIG1vZGUgbm90IHN1cHBvcnRl
ZCkKWyAgICAyOS45NzBdIChJSSkgaW50ZWwoMCk6IE5vdCB1c2luZyBkZWZhdWx0IG1vZGUgIjk2
MHg2MDAiIChkb3VibGVzY2FuIG1vZGUgbm90IHN1cHBvcnRlZCkKWyAgICAyOS45NzBdIChJSSkg
aW50ZWwoMCk6IE5vdCB1c2luZyBkZWZhdWx0IG1vZGUgIjEwMjR4NzY4IiAoZG91Ymxlc2NhbiBt
b2RlIG5vdCBzdXBwb3J0ZWQpClsgICAgMjkuOTcwXSAoSUkpIGludGVsKDApOiBQcmludGluZyBw
cm9iZWQgbW9kZXMgZm9yIG91dHB1dCBMVkRTMQpbICAgIDI5Ljk3MF0gKElJKSBpbnRlbCgwKTog
TW9kZWxpbmUgIjEzNjZ4NzY4Ing2MC4wICAgNjkuMzAgIDEzNjYgMTQxNCAxNDQ2IDE0NTYgIDc2
OCA3NzEgNzc3IDc5MyAtaHN5bmMgLXZzeW5jICg0Ny42IGtIeikKWyAgICAyOS45NzBdIChJSSkg
aW50ZWwoMCk6IE1vZGVsaW5lICIxMzYweDc2OCJ4NTkuOCAgIDg0Ljc1ICAxMzYwIDE0MzIgMTU2
OCAxNzc2ICA3NjggNzcxIDc4MSA3OTggLWhzeW5jICt2c3luYyAoNDcuNyBrSHopClsgICAgMjku
OTcwXSAoSUkpIGludGVsKDApOiBNb2RlbGluZSAiMTM2MHg3NjgieDYwLjAgICA3Mi4wMCAgMTM2
MCAxNDA4IDE0NDAgMTUyMCAgNzY4IDc3MSA3ODEgNzkwICtoc3luYyAtdnN5bmMgKDQ3LjQga0h6
KQpbICAgIDI5Ljk3MF0gKElJKSBpbnRlbCgwKTogTW9kZWxpbmUgIjEwMjR4NzY4Ing2MC4wICAg
NjUuMDAgIDEwMjQgMTA0OCAxMTg0IDEzNDQgIDc2OCA3NzEgNzc3IDgwNiAtaHN5bmMgLXZzeW5j
ICg0OC40IGtIeikKWyAgICAyOS45NzBdIChJSSkgaW50ZWwoMCk6IE1vZGVsaW5lICI4MDB4NjAw
Ing2MC4zICAgNDAuMDAgIDgwMCA4NDAgOTY4IDEwNTYgIDYwMCA2MDEgNjA1IDYyOCAraHN5bmMg
K3ZzeW5jICgzNy45IGtIeikKWyAgICAyOS45NzBdIChJSSkgaW50ZWwoMCk6IE1vZGVsaW5lICI4
MDB4NjAwIng1Ni4yICAgMzYuMDAgIDgwMCA4MjQgODk2IDEwMjQgIDYwMCA2MDEgNjAzIDYyNSAr
aHN5bmMgK3ZzeW5jICgzNS4yIGtIeikKWyAgICAyOS45NzBdIChJSSkgaW50ZWwoMCk6IE1vZGVs
aW5lICI2NDB4NDgwIng1OS45ICAgMjUuMTggIDY0MCA2NTYgNzUyIDgwMCAgNDgwIDQ5MCA0OTIg
NTI1IC1oc3luYyAtdnN5bmMgKDMxLjUga0h6KQpbICAgIDI5Ljk3MF0gKElJKSBpbnRlbCgwKTog
RURJRCBmb3Igb3V0cHV0IFZHQTEKWyAgICAyOS45NzBdIChJSSkgaW50ZWwoMCk6IE91dHB1dCBM
VkRTMSBjb25uZWN0ZWQKWyAgICAyOS45NzBdIChJSSkgaW50ZWwoMCk6IE91dHB1dCBWR0ExIGRp
c2Nvbm5lY3RlZApbICAgIDI5Ljk3MF0gKElJKSBpbnRlbCgwKTogVXNpbmcgZXhhY3Qgc2l6ZXMg
Zm9yIGluaXRpYWwgbW9kZXMKWyAgICAyOS45NzBdIChJSSkgaW50ZWwoMCk6IE91dHB1dCBMVkRT
MSB1c2luZyBpbml0aWFsIG1vZGUgMTM2Nng3NjgKWyAgICAyOS45NzBdIChJSSkgaW50ZWwoMCk6
IFVzaW5nIGRlZmF1bHQgZ2FtbWEgb2YgKDEuMCwgMS4wLCAxLjApIHVubGVzcyBvdGhlcndpc2Ug
c3RhdGVkLgpbICAgIDI5Ljk3MF0gKElJKSBpbnRlbCgwKTogS2VybmVsIHBhZ2UgZmxpcHBpbmcg
c3VwcG9ydCBkZXRlY3RlZCwgZW5hYmxpbmcKWyAgICAyOS45NzBdICgqKikgaW50ZWwoMCk6IERp
c3BsYXkgZGltZW5zaW9uczogKDI5MCwgMTYwKSBtbQpbICAgIDI5Ljk3MF0gKCoqKSBpbnRlbCgw
KTogRFBJIHNldCB0byAoMTE5LCAxMjEpClsgICAgMjkuOTcwXSAoSUkpIExvYWRpbmcgc3ViIG1v
ZHVsZSAiZmIiClsgICAgMjkuOTcwXSAoSUkpIExvYWRNb2R1bGU6ICJmYiIKWyAgICAyOS45NzFd
IChJSSkgTG9hZGluZyAvdXNyL2xpYi94b3JnL21vZHVsZXMvbGliZmIuc28KWyAgICAyOS45NzFd
IChJSSkgTW9kdWxlIGZiOiB2ZW5kb3I9IlguT3JnIEZvdW5kYXRpb24iClsgICAgMjkuOTcxXSAJ
Y29tcGlsZWQgZm9yIDEuMTAuNCwgbW9kdWxlIHZlcnNpb24gPSAxLjAuMApbICAgIDI5Ljk3MV0g
CUFCSSBjbGFzczogWC5PcmcgQU5TSSBDIEVtdWxhdGlvbiwgdmVyc2lvbiAwLjQKWyAgICAyOS45
NzFdIChJSSkgTG9hZGluZyBzdWIgbW9kdWxlICJkcmkyIgpbICAgIDI5Ljk3MV0gKElJKSBMb2Fk
TW9kdWxlOiAiZHJpMiIKWyAgICAyOS45NzFdIChJSSkgTG9hZGluZyAvdXNyL2xpYi94b3JnL21v
ZHVsZXMvZXh0ZW5zaW9ucy9saWJkcmkyLnNvClsgICAgMjkuOTcxXSAoSUkpIE1vZHVsZSBkcmky
OiB2ZW5kb3I9IlguT3JnIEZvdW5kYXRpb24iClsgICAgMjkuOTcxXSAJY29tcGlsZWQgZm9yIDEu
MTAuNCwgbW9kdWxlIHZlcnNpb24gPSAxLjIuMApbICAgIDI5Ljk3MV0gCUFCSSBjbGFzczogWC5P
cmcgU2VydmVyIEV4dGVuc2lvbiwgdmVyc2lvbiA1LjAKWyAgICAyOS45NzFdICg9PSkgRGVwdGgg
MjQgcGl4bWFwIGZvcm1hdCBpcyAzMiBicHAKWyAgICAyOS45NzFdIChJSSkgaW50ZWwoMCk6IFtE
UkkyXSBTZXR1cCBjb21wbGV0ZQpbICAgIDI5Ljk3MV0gKElJKSBpbnRlbCgwKTogW0RSSTJdICAg
RFJJIGRyaXZlcjogaTk2NQpbICAgIDI5Ljk3MV0gKElJKSBpbnRlbCgwKTogQWxsb2NhdGVkIG5l
dyBmcmFtZSBidWZmZXIgMTQwOHg3Njggc3RyaWRlIDU2MzIsIHRpbGVkClsgICAgMjkuOTc4XSAo
SUkpIFVYQSgwKTogRHJpdmVyIHJlZ2lzdGVyZWQgc3VwcG9ydCBmb3IgdGhlIGZvbGxvd2luZyBv
cGVyYXRpb25zOgpbICAgIDI5Ljk3OF0gKElJKSAgICAgICAgIHNvbGlkClsgICAgMjkuOTc4XSAo
SUkpICAgICAgICAgY29weQpbICAgIDI5Ljk3OF0gKElJKSAgICAgICAgIGNvbXBvc2l0ZSAoUkVO
REVSIGFjY2VsZXJhdGlvbikKWyAgICAyOS45NzldIChJSSkgICAgICAgICBwdXRfaW1hZ2UKWyAg
ICAyOS45NzldIChJSSkgICAgICAgICBnZXRfaW1hZ2UKWyAgICAyOS45NzldICg9PSkgaW50ZWwo
MCk6IEJhY2tpbmcgc3RvcmUgZGlzYWJsZWQKWyAgICAyOS45NzldICg9PSkgaW50ZWwoMCk6IFNp
bGtlbiBtb3VzZSBlbmFibGVkClsgICAgMjkuOTc5XSAoSUkpIGludGVsKDApOiBJbml0aWFsaXpp
bmcgSFcgQ3Vyc29yClsgICAgMzAuMDQwXSAoSUkpIGludGVsKDApOiBSYW5kUiAxLjIgZW5hYmxl
ZCwgaWdub3JlIHRoZSBmb2xsb3dpbmcgUmFuZFIgZGlzYWJsZWQgbWVzc2FnZS4KWyAgICAzMC4w
NDBdICg9PSkgaW50ZWwoMCk6IERQTVMgZW5hYmxlZApbICAgIDMwLjA0MF0gKD09KSBpbnRlbCgw
KTogSW50ZWwgWHZNQyBkZWNvZGVyIGVuYWJsZWQKWyAgICAzMC4wNDBdIChJSSkgaW50ZWwoMCk6
IFNldCB1cCB0ZXh0dXJlZCB2aWRlbwpbICAgIDMwLjA0MF0gKElJKSBpbnRlbCgwKTogW1h2TUNd
IHh2bWNfdmxkIGRyaXZlciBpbml0aWFsaXplZC4KWyAgICAzMC4wNDBdIChJSSkgaW50ZWwoMCk6
IGRpcmVjdCByZW5kZXJpbmc6IERSSTIgRW5hYmxlZApbICAgIDMwLjA0MF0gKD09KSBpbnRlbCgw
KTogaG90cGx1ZyBkZXRlY3Rpb246ICJlbmFibGVkIgpbICAgIDMwLjA0MF0gKC0tKSBSYW5kUiBk
aXNhYmxlZApbICAgIDMwLjA0MF0gKElJKSBJbml0aWFsaXppbmcgYnVpbHQtaW4gZXh0ZW5zaW9u
IEdlbmVyaWMgRXZlbnQgRXh0ZW5zaW9uClsgICAgMzAuMDQwXSAoSUkpIEluaXRpYWxpemluZyBi
dWlsdC1pbiBleHRlbnNpb24gU0hBUEUKWyAgICAzMC4wNDFdIChJSSkgSW5pdGlhbGl6aW5nIGJ1
aWx0LWluIGV4dGVuc2lvbiBNSVQtU0hNClsgICAgMzAuMDQxXSAoSUkpIEluaXRpYWxpemluZyBi
dWlsdC1pbiBleHRlbnNpb24gWElucHV0RXh0ZW5zaW9uClsgICAgMzAuMDQxXSAoSUkpIEluaXRp
YWxpemluZyBidWlsdC1pbiBleHRlbnNpb24gWFRFU1QKWyAgICAzMC4wNDFdIChJSSkgSW5pdGlh
bGl6aW5nIGJ1aWx0LWluIGV4dGVuc2lvbiBCSUctUkVRVUVTVFMKWyAgICAzMC4wNDFdIChJSSkg
SW5pdGlhbGl6aW5nIGJ1aWx0LWluIGV4dGVuc2lvbiBTWU5DClsgICAgMzAuMDQxXSAoSUkpIElu
aXRpYWxpemluZyBidWlsdC1pbiBleHRlbnNpb24gWEtFWUJPQVJEClsgICAgMzAuMDQxXSAoSUkp
IEluaXRpYWxpemluZyBidWlsdC1pbiBleHRlbnNpb24gWEMtTUlTQwpbICAgIDMwLjA0MV0gKElJ
KSBJbml0aWFsaXppbmcgYnVpbHQtaW4gZXh0ZW5zaW9uIFNFQ1VSSVRZClsgICAgMzAuMDQxXSAo
SUkpIEluaXRpYWxpemluZyBidWlsdC1pbiBleHRlbnNpb24gWElORVJBTUEKWyAgICAzMC4wNDFd
IChJSSkgSW5pdGlhbGl6aW5nIGJ1aWx0LWluIGV4dGVuc2lvbiBYRklYRVMKWyAgICAzMC4wNDFd
IChJSSkgSW5pdGlhbGl6aW5nIGJ1aWx0LWluIGV4dGVuc2lvbiBSRU5ERVIKWyAgICAzMC4wNDFd
IChJSSkgSW5pdGlhbGl6aW5nIGJ1aWx0LWluIGV4dGVuc2lvbiBSQU5EUgpbICAgIDMwLjA0MV0g
KElJKSBJbml0aWFsaXppbmcgYnVpbHQtaW4gZXh0ZW5zaW9uIENPTVBPU0lURQpbICAgIDMwLjA0
MV0gKElJKSBJbml0aWFsaXppbmcgYnVpbHQtaW4gZXh0ZW5zaW9uIERBTUFHRQpbICAgIDMwLjA0
MV0gKElJKSBTRUxpbnV4OiBEaXNhYmxlZCBvbiBzeXN0ZW0KWyAgICAzMC4wNTBdIChJSSkgQUlH
TFg6IGVuYWJsZWQgR0xYX01FU0FfY29weV9zdWJfYnVmZmVyClsgICAgMzAuMDUwXSAoSUkpIEFJ
R0xYOiBlbmFibGVkIEdMWF9JTlRFTF9zd2FwX2V2ZW50ClsgICAgMzAuMDUwXSAoSUkpIEFJR0xY
OiBlbmFibGVkIEdMWF9TR0lfc3dhcF9jb250cm9sIGFuZCBHTFhfTUVTQV9zd2FwX2NvbnRyb2wK
WyAgICAzMC4wNTBdIChJSSkgQUlHTFg6IGVuYWJsZWQgR0xYX1NHSV9tYWtlX2N1cnJlbnRfcmVh
ZApbICAgIDMwLjA1MF0gKElJKSBBSUdMWDogR0xYX0VYVF90ZXh0dXJlX2Zyb21fcGl4bWFwIGJh
Y2tlZCBieSBidWZmZXIgb2JqZWN0cwpbICAgIDMwLjA1MF0gKElJKSBBSUdMWDogTG9hZGVkIGFu
ZCBpbml0aWFsaXplZCAvdXNyL2xpYi9kcmkvaTk2NV9kcmkuc28KWyAgICAzMC4wNTBdIChJSSkg
R0xYOiBJbml0aWFsaXplZCBEUkkyIEdMIHByb3ZpZGVyIGZvciBzY3JlZW4gMApbICAgIDMwLjA1
MV0gKElJKSBpbnRlbCgwKTogU2V0dGluZyBzY3JlZW4gcGh5c2ljYWwgc2l6ZSB0byAzNjEgeCAy
MDMKWyAgICAzMC4xNDRdIChJSSkgY29uZmlnL3VkZXY6IEFkZGluZyBpbnB1dCBkZXZpY2UgUG93
ZXIgQnV0dG9uICgvZGV2L2lucHV0L2V2ZW50NSkKWyAgICAzMC4xNDRdICgqKikgUG93ZXIgQnV0
dG9uOiBBcHBseWluZyBJbnB1dENsYXNzICJldmRldiBrZXlib2FyZCBjYXRjaGFsbCIKWyAgICAz
MC4xNDRdIChJSSkgTG9hZE1vZHVsZTogImV2ZGV2IgpbICAgIDMwLjE0NF0gKElJKSBMb2FkaW5n
IC91c3IvbGliL3hvcmcvbW9kdWxlcy9pbnB1dC9ldmRldl9kcnYuc28KWyAgICAzMC4xNDRdIChJ
SSkgTW9kdWxlIGV2ZGV2OiB2ZW5kb3I9IlguT3JnIEZvdW5kYXRpb24iClsgICAgMzAuMTQ0XSAJ
Y29tcGlsZWQgZm9yIDEuMTAuMywgbW9kdWxlIHZlcnNpb24gPSAyLjYuMApbICAgIDMwLjE0NF0g
CU1vZHVsZSBjbGFzczogWC5PcmcgWElucHV0IERyaXZlcgpbICAgIDMwLjE0NF0gCUFCSSBjbGFz
czogWC5PcmcgWElucHV0IGRyaXZlciwgdmVyc2lvbiAxMi4yClsgICAgMzAuMTQ0XSAoSUkpIFVz
aW5nIGlucHV0IGRyaXZlciAnZXZkZXYnIGZvciAnUG93ZXIgQnV0dG9uJwpbICAgIDMwLjE0NF0g
KElJKSBMb2FkaW5nIC91c3IvbGliL3hvcmcvbW9kdWxlcy9pbnB1dC9ldmRldl9kcnYuc28KWyAg
ICAzMC4xNDRdICgqKikgUG93ZXIgQnV0dG9uOiBhbHdheXMgcmVwb3J0cyBjb3JlIGV2ZW50cwpb
ICAgIDMwLjE0NF0gKCoqKSBQb3dlciBCdXR0b246IERldmljZTogIi9kZXYvaW5wdXQvZXZlbnQ1
IgpbICAgIDMwLjE0NF0gKC0tKSBQb3dlciBCdXR0b246IEZvdW5kIGtleXMKWyAgICAzMC4xNDRd
IChJSSkgUG93ZXIgQnV0dG9uOiBDb25maWd1cmluZyBhcyBrZXlib2FyZApbICAgIDMwLjE0NF0g
KCoqKSBPcHRpb24gImNvbmZpZ19pbmZvIiAidWRldjovc3lzL2RldmljZXMvTE5YU1lTVE06MDAv
TE5YUFdSQk46MDAvaW5wdXQvaW5wdXQ1L2V2ZW50NSIKWyAgICAzMC4xNDRdIChJSSkgWElOUFVU
OiBBZGRpbmcgZXh0ZW5kZWQgaW5wdXQgZGV2aWNlICJQb3dlciBCdXR0b24iICh0eXBlOiBLRVlC
T0FSRCkKWyAgICAzMC4xNDRdICgqKikgT3B0aW9uICJ4a2JfcnVsZXMiICJldmRldiIKWyAgICAz
MC4xNDRdICgqKikgT3B0aW9uICJ4a2JfbW9kZWwiICJwYzEwNSIKWyAgICAzMC4xNDRdICgqKikg
T3B0aW9uICJ4a2JfbGF5b3V0IiAidXMiClsgICAgMzAuMTQ2XSAoSUkpIGNvbmZpZy91ZGV2OiBB
ZGRpbmcgaW5wdXQgZGV2aWNlIFZpZGVvIEJ1cyAoL2Rldi9pbnB1dC9ldmVudDEyKQpbICAgIDMw
LjE0Nl0gKCoqKSBWaWRlbyBCdXM6IEFwcGx5aW5nIElucHV0Q2xhc3MgImV2ZGV2IGtleWJvYXJk
IGNhdGNoYWxsIgpbICAgIDMwLjE0Nl0gKElJKSBVc2luZyBpbnB1dCBkcml2ZXIgJ2V2ZGV2JyBm
b3IgJ1ZpZGVvIEJ1cycKWyAgICAzMC4xNDZdIChJSSkgTG9hZGluZyAvdXNyL2xpYi94b3JnL21v
ZHVsZXMvaW5wdXQvZXZkZXZfZHJ2LnNvClsgICAgMzAuMTQ2XSAoKiopIFZpZGVvIEJ1czogYWx3
YXlzIHJlcG9ydHMgY29yZSBldmVudHMKWyAgICAzMC4xNDZdICgqKikgVmlkZW8gQnVzOiBEZXZp
Y2U6ICIvZGV2L2lucHV0L2V2ZW50MTIiClsgICAgMzAuMTQ2XSAoLS0pIFZpZGVvIEJ1czogRm91
bmQga2V5cwpbICAgIDMwLjE0Nl0gKElJKSBWaWRlbyBCdXM6IENvbmZpZ3VyaW5nIGFzIGtleWJv
YXJkClsgICAgMzAuMTQ2XSAoKiopIE9wdGlvbiAiY29uZmlnX2luZm8iICJ1ZGV2Oi9zeXMvZGV2
aWNlcy9MTlhTWVNUTTowMC9kZXZpY2U6MDAvUE5QMEEwODowMC9MTlhWSURFTzowMS9pbnB1dC9p
bnB1dDEyL2V2ZW50MTIiClsgICAgMzAuMTQ2XSAoSUkpIFhJTlBVVDogQWRkaW5nIGV4dGVuZGVk
IGlucHV0IGRldmljZSAiVmlkZW8gQnVzIiAodHlwZTogS0VZQk9BUkQpClsgICAgMzAuMTQ2XSAo
KiopIE9wdGlvbiAieGtiX3J1bGVzIiAiZXZkZXYiClsgICAgMzAuMTQ2XSAoKiopIE9wdGlvbiAi
eGtiX21vZGVsIiAicGMxMDUiClsgICAgMzAuMTQ2XSAoKiopIE9wdGlvbiAieGtiX2xheW91dCIg
InVzIgpbICAgIDMwLjE1NF0gKElJKSBjb25maWcvdWRldjogQWRkaW5nIGlucHV0IGRldmljZSBQ
b3dlciBCdXR0b24gKC9kZXYvaW5wdXQvZXZlbnQzKQpbICAgIDMwLjE1NF0gKCoqKSBQb3dlciBC
dXR0b246IEFwcGx5aW5nIElucHV0Q2xhc3MgImV2ZGV2IGtleWJvYXJkIGNhdGNoYWxsIgpbICAg
IDMwLjE1NF0gKElJKSBVc2luZyBpbnB1dCBkcml2ZXIgJ2V2ZGV2JyBmb3IgJ1Bvd2VyIEJ1dHRv
bicKWyAgICAzMC4xNTRdIChJSSkgTG9hZGluZyAvdXNyL2xpYi94b3JnL21vZHVsZXMvaW5wdXQv
ZXZkZXZfZHJ2LnNvClsgICAgMzAuMTU0XSAoKiopIFBvd2VyIEJ1dHRvbjogYWx3YXlzIHJlcG9y
dHMgY29yZSBldmVudHMKWyAgICAzMC4xNTRdICgqKikgUG93ZXIgQnV0dG9uOiBEZXZpY2U6ICIv
ZGV2L2lucHV0L2V2ZW50MyIKWyAgICAzMC4xNTRdICgtLSkgUG93ZXIgQnV0dG9uOiBGb3VuZCBr
ZXlzClsgICAgMzAuMTU0XSAoSUkpIFBvd2VyIEJ1dHRvbjogQ29uZmlndXJpbmcgYXMga2V5Ym9h
cmQKWyAgICAzMC4xNTRdICgqKikgT3B0aW9uICJjb25maWdfaW5mbyIgInVkZXY6L3N5cy9kZXZp
Y2VzL0xOWFNZU1RNOjAwL2RldmljZTowMC9QTlAwQzBDOjAwL2lucHV0L2lucHV0My9ldmVudDMi
ClsgICAgMzAuMTU0XSAoSUkpIFhJTlBVVDogQWRkaW5nIGV4dGVuZGVkIGlucHV0IGRldmljZSAi
UG93ZXIgQnV0dG9uIiAodHlwZTogS0VZQk9BUkQpClsgICAgMzAuMTU0XSAoKiopIE9wdGlvbiAi
eGtiX3J1bGVzIiAiZXZkZXYiClsgICAgMzAuMTU0XSAoKiopIE9wdGlvbiAieGtiX21vZGVsIiAi
cGMxMDUiClsgICAgMzAuMTU0XSAoKiopIE9wdGlvbiAieGtiX2xheW91dCIgInVzIgpbICAgIDMw
LjE1NF0gKElJKSBjb25maWcvdWRldjogQWRkaW5nIGlucHV0IGRldmljZSBMaWQgU3dpdGNoICgv
ZGV2L2lucHV0L2V2ZW50MikKWyAgICAzMC4xNTVdIChJSSkgTm8gaW5wdXQgZHJpdmVyL2lkZW50
aWZpZXIgc3BlY2lmaWVkIChpZ25vcmluZykKWyAgICAzMC4xNTVdIChJSSkgY29uZmlnL3VkZXY6
IEFkZGluZyBpbnB1dCBkZXZpY2UgU2xlZXAgQnV0dG9uICgvZGV2L2lucHV0L2V2ZW50NCkKWyAg
ICAzMC4xNTVdICgqKikgU2xlZXAgQnV0dG9uOiBBcHBseWluZyBJbnB1dENsYXNzICJldmRldiBr
ZXlib2FyZCBjYXRjaGFsbCIKWyAgICAzMC4xNTVdIChJSSkgVXNpbmcgaW5wdXQgZHJpdmVyICdl
dmRldicgZm9yICdTbGVlcCBCdXR0b24nClsgICAgMzAuMTU1XSAoSUkpIExvYWRpbmcgL3Vzci9s
aWIveG9yZy9tb2R1bGVzL2lucHV0L2V2ZGV2X2Rydi5zbwpbICAgIDMwLjE1NV0gKCoqKSBTbGVl
cCBCdXR0b246IGFsd2F5cyByZXBvcnRzIGNvcmUgZXZlbnRzClsgICAgMzAuMTU1XSAoKiopIFNs
ZWVwIEJ1dHRvbjogRGV2aWNlOiAiL2Rldi9pbnB1dC9ldmVudDQiClsgICAgMzAuMTU1XSAoLS0p
IFNsZWVwIEJ1dHRvbjogRm91bmQga2V5cwpbICAgIDMwLjE1NV0gKElJKSBTbGVlcCBCdXR0b246
IENvbmZpZ3VyaW5nIGFzIGtleWJvYXJkClsgICAgMzAuMTU1XSAoKiopIE9wdGlvbiAiY29uZmln
X2luZm8iICJ1ZGV2Oi9zeXMvZGV2aWNlcy9MTlhTWVNUTTowMC9kZXZpY2U6MDAvUE5QMEMwRTow
MC9pbnB1dC9pbnB1dDQvZXZlbnQ0IgpbICAgIDMwLjE1NV0gKElJKSBYSU5QVVQ6IEFkZGluZyBl
eHRlbmRlZCBpbnB1dCBkZXZpY2UgIlNsZWVwIEJ1dHRvbiIgKHR5cGU6IEtFWUJPQVJEKQpbICAg
IDMwLjE1NV0gKCoqKSBPcHRpb24gInhrYl9ydWxlcyIgImV2ZGV2IgpbICAgIDMwLjE1NV0gKCoq
KSBPcHRpb24gInhrYl9tb2RlbCIgInBjMTA1IgpbICAgIDMwLjE1NV0gKCoqKSBPcHRpb24gInhr
Yl9sYXlvdXQiICJ1cyIKWyAgICAzMC4xNTddIChJSSkgY29uZmlnL3VkZXY6IEFkZGluZyBpbnB1
dCBkZXZpY2UgIFVTQiBPUFRJQ0FMIE1PVVNFICgvZGV2L2lucHV0L2V2ZW50MSkKWyAgICAzMC4x
NTddICgqKikgIFVTQiBPUFRJQ0FMIE1PVVNFOiBBcHBseWluZyBJbnB1dENsYXNzICJldmRldiBw
b2ludGVyIGNhdGNoYWxsIgpbICAgIDMwLjE1N10gKElJKSBVc2luZyBpbnB1dCBkcml2ZXIgJ2V2
ZGV2JyBmb3IgJyBVU0IgT1BUSUNBTCBNT1VTRScKWyAgICAzMC4xNTddIChJSSkgTG9hZGluZyAv
dXNyL2xpYi94b3JnL21vZHVsZXMvaW5wdXQvZXZkZXZfZHJ2LnNvClsgICAgMzAuMTU3XSAoKiop
ICBVU0IgT1BUSUNBTCBNT1VTRTogYWx3YXlzIHJlcG9ydHMgY29yZSBldmVudHMKWyAgICAzMC4x
NTddICgqKikgIFVTQiBPUFRJQ0FMIE1PVVNFOiBEZXZpY2U6ICIvZGV2L2lucHV0L2V2ZW50MSIK
WyAgICAzMC4xNTddICgtLSkgIFVTQiBPUFRJQ0FMIE1PVVNFOiBGb3VuZCAzIG1vdXNlIGJ1dHRv
bnMKWyAgICAzMC4xNTddICgtLSkgIFVTQiBPUFRJQ0FMIE1PVVNFOiBGb3VuZCBzY3JvbGwgd2hl
ZWwocykKWyAgICAzMC4xNTddICgtLSkgIFVTQiBPUFRJQ0FMIE1PVVNFOiBGb3VuZCByZWxhdGl2
ZSBheGVzClsgICAgMzAuMTU3XSAoLS0pICBVU0IgT1BUSUNBTCBNT1VTRTogRm91bmQgeCBhbmQg
eSByZWxhdGl2ZSBheGVzClsgICAgMzAuMTU3XSAoSUkpICBVU0IgT1BUSUNBTCBNT1VTRTogQ29u
ZmlndXJpbmcgYXMgbW91c2UKWyAgICAzMC4xNTddIChJSSkgIFVTQiBPUFRJQ0FMIE1PVVNFOiBB
ZGRpbmcgc2Nyb2xsd2hlZWwgc3VwcG9ydApbICAgIDMwLjE1N10gKCoqKSAgVVNCIE9QVElDQUwg
TU9VU0U6IFlBeGlzTWFwcGluZzogYnV0dG9ucyA0IGFuZCA1ClsgICAgMzAuMTU3XSAoKiopICBV
U0IgT1BUSUNBTCBNT1VTRTogRW11bGF0ZVdoZWVsQnV0dG9uOiA0LCBFbXVsYXRlV2hlZWxJbmVy
dGlhOiAxMCwgRW11bGF0ZVdoZWVsVGltZW91dDogMjAwClsgICAgMzAuMTU3XSAoKiopIE9wdGlv
biAiY29uZmlnX2luZm8iICJ1ZGV2Oi9zeXMvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MWEu
MC91c2IxLzEtMS8xLTEuMS8xLTEuMToxLjAvaW5wdXQvaW5wdXQxL2V2ZW50MSIKWyAgICAzMC4x
NTddIChJSSkgWElOUFVUOiBBZGRpbmcgZXh0ZW5kZWQgaW5wdXQgZGV2aWNlICIgVVNCIE9QVElD
QUwgTU9VU0UiICh0eXBlOiBNT1VTRSkKWyAgICAzMC4xNTddIChJSSkgIFVTQiBPUFRJQ0FMIE1P
VVNFOiBpbml0aWFsaXplZCBmb3IgcmVsYXRpdmUgYXhlcy4KWyAgICAzMC4xNTddICgqKikgIFVT
QiBPUFRJQ0FMIE1PVVNFOiAoYWNjZWwpIGtlZXBpbmcgYWNjZWxlcmF0aW9uIHNjaGVtZSAxClsg
ICAgMzAuMTU3XSAoKiopICBVU0IgT1BUSUNBTCBNT1VTRTogKGFjY2VsKSBhY2NlbGVyYXRpb24g
cHJvZmlsZSAwClsgICAgMzAuMTU3XSAoKiopICBVU0IgT1BUSUNBTCBNT1VTRTogKGFjY2VsKSBh
Y2NlbGVyYXRpb24gZmFjdG9yOiAyLjAwMApbICAgIDMwLjE1N10gKCoqKSAgVVNCIE9QVElDQUwg
TU9VU0U6IChhY2NlbCkgYWNjZWxlcmF0aW9uIHRocmVzaG9sZDogNApbICAgIDMwLjE1N10gKElJ
KSBjb25maWcvdWRldjogQWRkaW5nIGlucHV0IGRldmljZSAgVVNCIE9QVElDQUwgTU9VU0UgKC9k
ZXYvaW5wdXQvbW91c2UwKQpbICAgIDMwLjE1N10gKElJKSBObyBpbnB1dCBkcml2ZXIvaWRlbnRp
ZmllciBzcGVjaWZpZWQgKGlnbm9yaW5nKQpbICAgIDMwLjE1OF0gKElJKSBjb25maWcvdWRldjog
QWRkaW5nIGlucHV0IGRldmljZSBIREEgRGlnaXRhbCBQQ0JlZXAgKC9kZXYvaW5wdXQvZXZlbnQx
MykKWyAgICAzMC4xNThdIChJSSkgTm8gaW5wdXQgZHJpdmVyL2lkZW50aWZpZXIgc3BlY2lmaWVk
IChpZ25vcmluZykKWyAgICAzMC4xNTldIChJSSkgY29uZmlnL3VkZXY6IEFkZGluZyBpbnB1dCBk
ZXZpY2UgSERBIEludGVsIE1pYyAoL2Rldi9pbnB1dC9ldmVudDE0KQpbICAgIDMwLjE1OV0gKElJ
KSBObyBpbnB1dCBkcml2ZXIvaWRlbnRpZmllciBzcGVjaWZpZWQgKGlnbm9yaW5nKQpbICAgIDMw
LjE1OV0gKElJKSBjb25maWcvdWRldjogQWRkaW5nIGlucHV0IGRldmljZSBIREEgSW50ZWwgSGVh
ZHBob25lICgvZGV2L2lucHV0L2V2ZW50MTUpClsgICAgMzAuMTU5XSAoSUkpIE5vIGlucHV0IGRy
aXZlci9pZGVudGlmaWVyIHNwZWNpZmllZCAoaWdub3JpbmcpClsgICAgMzAuMTYxXSAoSUkpIGNv
bmZpZy91ZGV2OiBBZGRpbmcgaW5wdXQgZGV2aWNlIFVTQiBHYW1lcGFkICAoL2Rldi9pbnB1dC9l
dmVudDYpClsgICAgMzAuMTYxXSAoSUkpIE5vIGlucHV0IGRyaXZlci9pZGVudGlmaWVyIHNwZWNp
ZmllZCAoaWdub3JpbmcpClsgICAgMzAuMTYxXSAoSUkpIGNvbmZpZy91ZGV2OiBBZGRpbmcgaW5w
dXQgZGV2aWNlIFVTQiBHYW1lcGFkICAoL2Rldi9pbnB1dC9qczApClsgICAgMzAuMTYxXSAoSUkp
IE5vIGlucHV0IGRyaXZlci9pZGVudGlmaWVyIHNwZWNpZmllZCAoaWdub3JpbmcpClsgICAgMzAu
MTYxXSAoSUkpIGNvbmZpZy91ZGV2OiBBZGRpbmcgaW5wdXQgZGV2aWNlIExlbm92byBFYXN5Q2Ft
ZXJhICgvZGV2L2lucHV0L2V2ZW50MTEpClsgICAgMzAuMTYxXSAoKiopIExlbm92byBFYXN5Q2Ft
ZXJhOiBBcHBseWluZyBJbnB1dENsYXNzICJldmRldiBrZXlib2FyZCBjYXRjaGFsbCIKWyAgICAz
MC4xNjFdIChJSSkgVXNpbmcgaW5wdXQgZHJpdmVyICdldmRldicgZm9yICdMZW5vdm8gRWFzeUNh
bWVyYScKWyAgICAzMC4xNjFdIChJSSkgTG9hZGluZyAvdXNyL2xpYi94b3JnL21vZHVsZXMvaW5w
dXQvZXZkZXZfZHJ2LnNvClsgICAgMzAuMTYxXSAoKiopIExlbm92byBFYXN5Q2FtZXJhOiBhbHdh
eXMgcmVwb3J0cyBjb3JlIGV2ZW50cwpbICAgIDMwLjE2MV0gKCoqKSBMZW5vdm8gRWFzeUNhbWVy
YTogRGV2aWNlOiAiL2Rldi9pbnB1dC9ldmVudDExIgpbICAgIDMwLjE2MV0gKC0tKSBMZW5vdm8g
RWFzeUNhbWVyYTogRm91bmQga2V5cwpbICAgIDMwLjE2MV0gKElJKSBMZW5vdm8gRWFzeUNhbWVy
YTogQ29uZmlndXJpbmcgYXMga2V5Ym9hcmQKWyAgICAzMC4xNjFdICgqKikgT3B0aW9uICJjb25m
aWdfaW5mbyIgInVkZXY6L3N5cy9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDoxZC4wL3VzYjIv
Mi0xLzItMS40LzItMS40OjEuMC9pbnB1dC9pbnB1dDExL2V2ZW50MTEiClsgICAgMzAuMTYxXSAo
SUkpIFhJTlBVVDogQWRkaW5nIGV4dGVuZGVkIGlucHV0IGRldmljZSAiTGVub3ZvIEVhc3lDYW1l
cmEiICh0eXBlOiBLRVlCT0FSRCkKWyAgICAzMC4xNjFdICgqKikgT3B0aW9uICJ4a2JfcnVsZXMi
ICJldmRldiIKWyAgICAzMC4xNjFdICgqKikgT3B0aW9uICJ4a2JfbW9kZWwiICJwYzEwNSIKWyAg
ICAzMC4xNjFdICgqKikgT3B0aW9uICJ4a2JfbGF5b3V0IiAidXMiClsgICAgMzAuMTY1XSAoSUkp
IGNvbmZpZy91ZGV2OiBBZGRpbmcgaW5wdXQgZGV2aWNlIEFUIFRyYW5zbGF0ZWQgU2V0IDIga2V5
Ym9hcmQgKC9kZXYvaW5wdXQvZXZlbnQwKQpbICAgIDMwLjE2NV0gKCoqKSBBVCBUcmFuc2xhdGVk
IFNldCAyIGtleWJvYXJkOiBBcHBseWluZyBJbnB1dENsYXNzICJldmRldiBrZXlib2FyZCBjYXRj
aGFsbCIKWyAgICAzMC4xNjVdIChJSSkgVXNpbmcgaW5wdXQgZHJpdmVyICdldmRldicgZm9yICdB
VCBUcmFuc2xhdGVkIFNldCAyIGtleWJvYXJkJwpbICAgIDMwLjE2NV0gKElJKSBMb2FkaW5nIC91
c3IvbGliL3hvcmcvbW9kdWxlcy9pbnB1dC9ldmRldl9kcnYuc28KWyAgICAzMC4xNjVdICgqKikg
QVQgVHJhbnNsYXRlZCBTZXQgMiBrZXlib2FyZDogYWx3YXlzIHJlcG9ydHMgY29yZSBldmVudHMK
WyAgICAzMC4xNjVdICgqKikgQVQgVHJhbnNsYXRlZCBTZXQgMiBrZXlib2FyZDogRGV2aWNlOiAi
L2Rldi9pbnB1dC9ldmVudDAiClsgICAgMzAuMTY1XSAoLS0pIEFUIFRyYW5zbGF0ZWQgU2V0IDIg
a2V5Ym9hcmQ6IEZvdW5kIGtleXMKWyAgICAzMC4xNjVdIChJSSkgQVQgVHJhbnNsYXRlZCBTZXQg
MiBrZXlib2FyZDogQ29uZmlndXJpbmcgYXMga2V5Ym9hcmQKWyAgICAzMC4xNjVdICgqKikgT3B0
aW9uICJjb25maWdfaW5mbyIgInVkZXY6L3N5cy9kZXZpY2VzL3BsYXRmb3JtL2k4MDQyL3Nlcmlv
MC9pbnB1dC9pbnB1dDAvZXZlbnQwIgpbICAgIDMwLjE2NV0gKElJKSBYSU5QVVQ6IEFkZGluZyBl
eHRlbmRlZCBpbnB1dCBkZXZpY2UgIkFUIFRyYW5zbGF0ZWQgU2V0IDIga2V5Ym9hcmQiICh0eXBl
OiBLRVlCT0FSRCkKWyAgICAzMC4xNjVdICgqKikgT3B0aW9uICJ4a2JfcnVsZXMiICJldmRldiIK
WyAgICAzMC4xNjVdICgqKikgT3B0aW9uICJ4a2JfbW9kZWwiICJwYzEwNSIKWyAgICAzMC4xNjVd
ICgqKikgT3B0aW9uICJ4a2JfbGF5b3V0IiAidXMiClsgICAgMzAuMTY1XSAoSUkpIGNvbmZpZy91
ZGV2OiBBZGRpbmcgaW5wdXQgZGV2aWNlIEFscHNQUy8yIEFMUFMgR2xpZGVQb2ludCAoL2Rldi9p
bnB1dC9ldmVudDEwKQpbICAgIDMwLjE2NV0gKCoqKSBBbHBzUFMvMiBBTFBTIEdsaWRlUG9pbnQ6
IEFwcGx5aW5nIElucHV0Q2xhc3MgImV2ZGV2IHRvdWNocGFkIGNhdGNoYWxsIgpbICAgIDMwLjE2
NV0gKCoqKSBBbHBzUFMvMiBBTFBTIEdsaWRlUG9pbnQ6IEFwcGx5aW5nIElucHV0Q2xhc3MgInRv
dWNocGFkIGNhdGNoYWxsIgpbICAgIDMwLjE2NV0gKElJKSBMb2FkTW9kdWxlOiAic3luYXB0aWNz
IgpbICAgIDMwLjE2NV0gKElJKSBMb2FkaW5nIC91c3IvbGliL3hvcmcvbW9kdWxlcy9pbnB1dC9z
eW5hcHRpY3NfZHJ2LnNvClsgICAgMzAuMjIzXSAoSUkpIE1vZHVsZSBzeW5hcHRpY3M6IHZlbmRv
cj0iWC5PcmcgRm91bmRhdGlvbiIKWyAgICAzMC4yMjNdIAljb21waWxlZCBmb3IgMS4xMC4zLCBt
b2R1bGUgdmVyc2lvbiA9IDEuNC4xClsgICAgMzAuMjIzXSAJTW9kdWxlIGNsYXNzOiBYLk9yZyBY
SW5wdXQgRHJpdmVyClsgICAgMzAuMjIzXSAJQUJJIGNsYXNzOiBYLk9yZyBYSW5wdXQgZHJpdmVy
LCB2ZXJzaW9uIDEyLjIKWyAgICAzMC4yMjNdIChJSSkgVXNpbmcgaW5wdXQgZHJpdmVyICdzeW5h
cHRpY3MnIGZvciAnQWxwc1BTLzIgQUxQUyBHbGlkZVBvaW50JwpbICAgIDMwLjIyM10gKElJKSBM
b2FkaW5nIC91c3IvbGliL3hvcmcvbW9kdWxlcy9pbnB1dC9zeW5hcHRpY3NfZHJ2LnNvClsgICAg
MzAuMjIzXSAoKiopIEFscHNQUy8yIEFMUFMgR2xpZGVQb2ludDogYWx3YXlzIHJlcG9ydHMgY29y
ZSBldmVudHMKWyAgICAzMC4yMjNdICgqKikgT3B0aW9uICJEZXZpY2UiICIvZGV2L2lucHV0L2V2
ZW50MTAiClsgICAgMzAuMjIzXSAoLS0pIEFscHNQUy8yIEFMUFMgR2xpZGVQb2ludDogeC1heGlz
IHJhbmdlIDAgLSAxMDIzClsgICAgMzAuMjIzXSAoLS0pIEFscHNQUy8yIEFMUFMgR2xpZGVQb2lu
dDogeS1heGlzIHJhbmdlIDAgLSA3NjcKWyAgICAzMC4yMjNdICgtLSkgQWxwc1BTLzIgQUxQUyBH
bGlkZVBvaW50OiBwcmVzc3VyZSByYW5nZSAwIC0gMTI3ClsgICAgMzAuMjIzXSAoLS0pIEFscHNQ
Uy8yIEFMUFMgR2xpZGVQb2ludDogYnV0dG9uczogbGVmdCByaWdodCBtaWRkbGUKWyAgICAzMC4y
MjNdICgtLSkgQWxwc1BTLzIgQUxQUyBHbGlkZVBvaW50OiBpbnZhbGlkIGZpbmdlciB3aWR0aCBy
YW5nZS4gIGRlZmF1bHRpbmcgdG8gMCAtIDE2ClsgICAgMzAuMjIzXSAoLS0pIEFscHNQUy8yIEFM
UFMgR2xpZGVQb2ludDogdG91Y2hwYWQgZm91bmQKWyAgICAzMC4yMjNdICgqKikgQWxwc1BTLzIg
QUxQUyBHbGlkZVBvaW50OiBhbHdheXMgcmVwb3J0cyBjb3JlIGV2ZW50cwpbICAgIDMwLjIyNF0g
KCoqKSBPcHRpb24gImNvbmZpZ19pbmZvIiAidWRldjovc3lzL2RldmljZXMvcGxhdGZvcm0vaTgw
NDIvc2VyaW80L2lucHV0L2lucHV0MTAvZXZlbnQxMCIKWyAgICAzMC4yMjRdIChJSSkgWElOUFVU
OiBBZGRpbmcgZXh0ZW5kZWQgaW5wdXQgZGV2aWNlICJBbHBzUFMvMiBBTFBTIEdsaWRlUG9pbnQi
ICh0eXBlOiBUT1VDSFBBRCkKWyAgICAzMC4yMjRdICgqKikgQWxwc1BTLzIgQUxQUyBHbGlkZVBv
aW50OiAoYWNjZWwpIE1pblNwZWVkIGlzIG5vdyBjb25zdGFudCBkZWNlbGVyYXRpb24gMi41Clsg
ICAgMzAuMjI0XSAoKiopIEFscHNQUy8yIEFMUFMgR2xpZGVQb2ludDogTWF4U3BlZWQgaXMgbm93
IDEuNzUKWyAgICAzMC4yMjRdICgqKikgQWxwc1BTLzIgQUxQUyBHbGlkZVBvaW50OiBBY2NlbEZh
Y3RvciBpcyBub3cgMC4xNTYKWyAgICAzMC4yMjRdICgqKikgQWxwc1BTLzIgQUxQUyBHbGlkZVBv
aW50OiAoYWNjZWwpIGtlZXBpbmcgYWNjZWxlcmF0aW9uIHNjaGVtZSAxClsgICAgMzAuMjI0XSAo
KiopIEFscHNQUy8yIEFMUFMgR2xpZGVQb2ludDogKGFjY2VsKSBhY2NlbGVyYXRpb24gcHJvZmls
ZSAxClsgICAgMzAuMjI0XSAoKiopIEFscHNQUy8yIEFMUFMgR2xpZGVQb2ludDogKGFjY2VsKSBh
Y2NlbGVyYXRpb24gZmFjdG9yOiAyLjAwMApbICAgIDMwLjIyNF0gKCoqKSBBbHBzUFMvMiBBTFBT
IEdsaWRlUG9pbnQ6IChhY2NlbCkgYWNjZWxlcmF0aW9uIHRocmVzaG9sZDogNApbICAgIDMwLjIy
NV0gKC0tKSBBbHBzUFMvMiBBTFBTIEdsaWRlUG9pbnQ6IHRvdWNocGFkIGZvdW5kClsgICAgMzAu
MjI1XSAoSUkpIGNvbmZpZy91ZGV2OiBBZGRpbmcgaW5wdXQgZGV2aWNlIEFscHNQUy8yIEFMUFMg
R2xpZGVQb2ludCAoL2Rldi9pbnB1dC9tb3VzZTIpClsgICAgMzAuMjI1XSAoKiopIEFscHNQUy8y
IEFMUFMgR2xpZGVQb2ludDogQXBwbHlpbmcgSW5wdXRDbGFzcyAidG91Y2hwYWQgY2F0Y2hhbGwi
ClsgICAgMzAuMjI1XSAoSUkpIFVzaW5nIGlucHV0IGRyaXZlciAnc3luYXB0aWNzJyBmb3IgJ0Fs
cHNQUy8yIEFMUFMgR2xpZGVQb2ludCcKWyAgICAzMC4yMjVdIChJSSkgTG9hZGluZyAvdXNyL2xp
Yi94b3JnL21vZHVsZXMvaW5wdXQvc3luYXB0aWNzX2Rydi5zbwpbICAgIDMwLjIyNV0gKCoqKSBB
bHBzUFMvMiBBTFBTIEdsaWRlUG9pbnQ6IGFsd2F5cyByZXBvcnRzIGNvcmUgZXZlbnRzClsgICAg
MzAuMjI1XSAoKiopIE9wdGlvbiAiRGV2aWNlIiAiL2Rldi9pbnB1dC9tb3VzZTIiClsgICAgMzAu
MjI1XSAoLS0pIEFscHNQUy8yIEFMUFMgR2xpZGVQb2ludDogaW52YWxpZCB4LWF4aXMgcmFuZ2Uu
ICBkZWZhdWx0aW5nIHRvIDE2MTUgLSA1Njg1ClsgICAgMzAuMjI1XSAoLS0pIEFscHNQUy8yIEFM
UFMgR2xpZGVQb2ludDogaW52YWxpZCB5LWF4aXMgcmFuZ2UuICBkZWZhdWx0aW5nIHRvIDE3Mjkg
LSA0MTcxClsgICAgMzAuMjI1XSAoLS0pIEFscHNQUy8yIEFMUFMgR2xpZGVQb2ludDogaW52YWxp
ZCBwcmVzc3VyZSByYW5nZS4gIGRlZmF1bHRpbmcgdG8gMCAtIDI1NgpbICAgIDMwLjIyNV0gKC0t
KSBBbHBzUFMvMiBBTFBTIEdsaWRlUG9pbnQ6IGludmFsaWQgZmluZ2VyIHdpZHRoIHJhbmdlLiAg
ZGVmYXVsdGluZyB0byAwIC0gMTYKWyAgICAzMC4yNDVdIChFRSkgUXVlcnkgbm8gU3luYXB0aWNz
OiA2MDAzQzgKWyAgICAzMC4yNDVdICgtLSkgQWxwc1BTLzIgQUxQUyBHbGlkZVBvaW50OiBubyBz
dXBwb3J0ZWQgdG91Y2hwYWQgZm91bmQKWyAgICAzMC4yNDVdIChFRSkgQWxwc1BTLzIgQUxQUyBH
bGlkZVBvaW50IFVuYWJsZSB0byBxdWVyeS9pbml0aWFsaXplIFN5bmFwdGljcyBoYXJkd2FyZS4K
WyAgICAzMC4yNTddIChFRSkgUHJlSW5pdCByZXR1cm5lZCAxMSBmb3IgIkFscHNQUy8yIEFMUFMg
R2xpZGVQb2ludCIKWyAgICAzMC4yNTddIChJSSkgVW5sb2FkTW9kdWxlOiAic3luYXB0aWNzIgpb
ICAgIDMwLjI1N10gKElJKSBVbmxvYWRpbmcgc3luYXB0aWNzClsgICAgMzAuMjU3XSAoSUkpIGNv
bmZpZy91ZGV2OiBBZGRpbmcgaW5wdXQgZGV2aWNlIFBTLzIgTW91c2UgKC9kZXYvaW5wdXQvZXZl
bnQ5KQpbICAgIDMwLjI1N10gKCoqKSBQUy8yIE1vdXNlOiBBcHBseWluZyBJbnB1dENsYXNzICJl
dmRldiBwb2ludGVyIGNhdGNoYWxsIgpbICAgIDMwLjI1N10gKElJKSBVc2luZyBpbnB1dCBkcml2
ZXIgJ2V2ZGV2JyBmb3IgJ1BTLzIgTW91c2UnClsgICAgMzAuMjU3XSAoSUkpIExvYWRpbmcgL3Vz
ci9saWIveG9yZy9tb2R1bGVzL2lucHV0L2V2ZGV2X2Rydi5zbwpbICAgIDMwLjI1N10gKCoqKSBQ
Uy8yIE1vdXNlOiBhbHdheXMgcmVwb3J0cyBjb3JlIGV2ZW50cwpbICAgIDMwLjI1N10gKCoqKSBQ
Uy8yIE1vdXNlOiBEZXZpY2U6ICIvZGV2L2lucHV0L2V2ZW50OSIKWyAgICAzMC4yNTddICgtLSkg
UFMvMiBNb3VzZTogRm91bmQgMyBtb3VzZSBidXR0b25zClsgICAgMzAuMjU3XSAoLS0pIFBTLzIg
TW91c2U6IEZvdW5kIHJlbGF0aXZlIGF4ZXMKWyAgICAzMC4yNTddICgtLSkgUFMvMiBNb3VzZTog
Rm91bmQgeCBhbmQgeSByZWxhdGl2ZSBheGVzClsgICAgMzAuMjU3XSAoSUkpIFBTLzIgTW91c2U6
IENvbmZpZ3VyaW5nIGFzIG1vdXNlClsgICAgMzAuMjU3XSAoKiopIFBTLzIgTW91c2U6IFlBeGlz
TWFwcGluZzogYnV0dG9ucyA0IGFuZCA1ClsgICAgMzAuMjU3XSAoKiopIFBTLzIgTW91c2U6IEVt
dWxhdGVXaGVlbEJ1dHRvbjogNCwgRW11bGF0ZVdoZWVsSW5lcnRpYTogMTAsIEVtdWxhdGVXaGVl
bFRpbWVvdXQ6IDIwMApbICAgIDMwLjI1N10gKCoqKSBPcHRpb24gImNvbmZpZ19pbmZvIiAidWRl
djovc3lzL2RldmljZXMvcGxhdGZvcm0vaTgwNDIvc2VyaW80L2lucHV0L2lucHV0OS9ldmVudDki
ClsgICAgMzAuMjU3XSAoSUkpIFhJTlBVVDogQWRkaW5nIGV4dGVuZGVkIGlucHV0IGRldmljZSAi
UFMvMiBNb3VzZSIgKHR5cGU6IE1PVVNFKQpbICAgIDMwLjI1OF0gKElJKSBQUy8yIE1vdXNlOiBp
bml0aWFsaXplZCBmb3IgcmVsYXRpdmUgYXhlcy4KWyAgICAzMC4yNThdICgqKikgUFMvMiBNb3Vz
ZTogKGFjY2VsKSBrZWVwaW5nIGFjY2VsZXJhdGlvbiBzY2hlbWUgMQpbICAgIDMwLjI1OF0gKCoq
KSBQUy8yIE1vdXNlOiAoYWNjZWwpIGFjY2VsZXJhdGlvbiBwcm9maWxlIDAKWyAgICAzMC4yNThd
ICgqKikgUFMvMiBNb3VzZTogKGFjY2VsKSBhY2NlbGVyYXRpb24gZmFjdG9yOiAyLjAwMApbICAg
IDMwLjI1OF0gKCoqKSBQUy8yIE1vdXNlOiAoYWNjZWwpIGFjY2VsZXJhdGlvbiB0aHJlc2hvbGQ6
IDQKWyAgICAzMC4yNThdIChJSSkgY29uZmlnL3VkZXY6IEFkZGluZyBpbnB1dCBkZXZpY2UgUFMv
MiBNb3VzZSAoL2Rldi9pbnB1dC9tb3VzZTEpClsgICAgMzAuMjU4XSAoSUkpIE5vIGlucHV0IGRy
aXZlci9pZGVudGlmaWVyIHNwZWNpZmllZCAoaWdub3JpbmcpClsgICAgMzAuMjU4XSAoSUkpIGNv
bmZpZy91ZGV2OiBBZGRpbmcgaW5wdXQgZGV2aWNlIElkZWFwYWQgZXh0cmEgYnV0dG9ucyAoL2Rl
di9pbnB1dC9ldmVudDgpClsgICAgMzAuMjU4XSAoKiopIElkZWFwYWQgZXh0cmEgYnV0dG9uczog
QXBwbHlpbmcgSW5wdXRDbGFzcyAiZXZkZXYga2V5Ym9hcmQgY2F0Y2hhbGwiClsgICAgMzAuMjU4
XSAoSUkpIFVzaW5nIGlucHV0IGRyaXZlciAnZXZkZXYnIGZvciAnSWRlYXBhZCBleHRyYSBidXR0
b25zJwpbICAgIDMwLjI1OF0gKElJKSBMb2FkaW5nIC91c3IvbGliL3hvcmcvbW9kdWxlcy9pbnB1
dC9ldmRldl9kcnYuc28KWyAgICAzMC4yNThdICgqKikgSWRlYXBhZCBleHRyYSBidXR0b25zOiBh
bHdheXMgcmVwb3J0cyBjb3JlIGV2ZW50cwpbICAgIDMwLjI1OF0gKCoqKSBJZGVhcGFkIGV4dHJh
IGJ1dHRvbnM6IERldmljZTogIi9kZXYvaW5wdXQvZXZlbnQ4IgpbICAgIDMwLjI1OF0gKC0tKSBJ
ZGVhcGFkIGV4dHJhIGJ1dHRvbnM6IEZvdW5kIGtleXMKWyAgICAzMC4yNThdIChJSSkgSWRlYXBh
ZCBleHRyYSBidXR0b25zOiBDb25maWd1cmluZyBhcyBrZXlib2FyZApbICAgIDMwLjI1OF0gKCoq
KSBPcHRpb24gImNvbmZpZ19pbmZvIiAidWRldjovc3lzL2RldmljZXMvcGxhdGZvcm0vaWRlYXBh
ZC9pbnB1dC9pbnB1dDgvZXZlbnQ4IgpbICAgIDMwLjI1OF0gKElJKSBYSU5QVVQ6IEFkZGluZyBl
eHRlbmRlZCBpbnB1dCBkZXZpY2UgIklkZWFwYWQgZXh0cmEgYnV0dG9ucyIgKHR5cGU6IEtFWUJP
QVJEKQpbICAgIDMwLjI1OF0gKCoqKSBPcHRpb24gInhrYl9ydWxlcyIgImV2ZGV2IgpbICAgIDMw
LjI1OF0gKCoqKSBPcHRpb24gInhrYl9tb2RlbCIgInBjMTA1IgpbICAgIDMwLjI1OF0gKCoqKSBP
cHRpb24gInhrYl9sYXlvdXQiICJ1cyIKWyAgICAzMC4yNTldIChJSSkgY29uZmlnL3VkZXY6IEFk
ZGluZyBpbnB1dCBkZXZpY2UgUEMgU3BlYWtlciAoL2Rldi9pbnB1dC9ldmVudDcpClsgICAgMzAu
MjU5XSAoSUkpIE5vIGlucHV0IGRyaXZlci9pZGVudGlmaWVyIHNwZWNpZmllZCAoaWdub3Jpbmcp
ClsgICAgMzAuMjYyXSAoSUkpIGNvbmZpZy91ZGV2OiBBZGRpbmcgaW5wdXQgZGV2aWNlIEFDUEkg
VmlydHVhbCBLZXlib2FyZCBEZXZpY2UgKC9kZXYvaW5wdXQvZXZlbnQxNikKWyAgICAzMC4yNjJd
ICgqKikgQUNQSSBWaXJ0dWFsIEtleWJvYXJkIERldmljZTogQXBwbHlpbmcgSW5wdXRDbGFzcyAi
ZXZkZXYga2V5Ym9hcmQgY2F0Y2hhbGwiClsgICAgMzAuMjYyXSAoSUkpIFVzaW5nIGlucHV0IGRy
aXZlciAnZXZkZXYnIGZvciAnQUNQSSBWaXJ0dWFsIEtleWJvYXJkIERldmljZScKWyAgICAzMC4y
NjJdIChJSSkgTG9hZGluZyAvdXNyL2xpYi94b3JnL21vZHVsZXMvaW5wdXQvZXZkZXZfZHJ2LnNv
ClsgICAgMzAuMjYyXSAoKiopIEFDUEkgVmlydHVhbCBLZXlib2FyZCBEZXZpY2U6IGFsd2F5cyBy
ZXBvcnRzIGNvcmUgZXZlbnRzClsgICAgMzAuMjYyXSAoKiopIEFDUEkgVmlydHVhbCBLZXlib2Fy
ZCBEZXZpY2U6IERldmljZTogIi9kZXYvaW5wdXQvZXZlbnQxNiIKWyAgICAzMC4yNjJdICgtLSkg
QUNQSSBWaXJ0dWFsIEtleWJvYXJkIERldmljZTogRm91bmQga2V5cwpbICAgIDMwLjI2Ml0gKElJ
KSBBQ1BJIFZpcnR1YWwgS2V5Ym9hcmQgRGV2aWNlOiBDb25maWd1cmluZyBhcyBrZXlib2FyZApb
ICAgIDMwLjI2Ml0gKCoqKSBPcHRpb24gImNvbmZpZ19pbmZvIiAidWRldjovc3lzL2RldmljZXMv
dmlydHVhbC9pbnB1dC9pbnB1dDE2L2V2ZW50MTYiClsgICAgMzAuMjYyXSAoSUkpIFhJTlBVVDog
QWRkaW5nIGV4dGVuZGVkIGlucHV0IGRldmljZSAiQUNQSSBWaXJ0dWFsIEtleWJvYXJkIERldmlj
ZSIgKHR5cGU6IEtFWUJPQVJEKQpbICAgIDMwLjI2Ml0gKCoqKSBPcHRpb24gInhrYl9ydWxlcyIg
ImV2ZGV2IgpbICAgIDMwLjI2Ml0gKCoqKSBPcHRpb24gInhrYl9tb2RlbCIgInBjMTA1IgpbICAg
IDMwLjI2Ml0gKCoqKSBPcHRpb24gInhrYl9sYXlvdXQiICJ1cyIKWyAgICAzMS4yODVdIChJSSkg
aW50ZWwoMCk6IEVESUQgdmVuZG9yICJBVU8iLCBwcm9kIGlkIDE2NDI4ClsgICAgMzEuMjg1XSAo
SUkpIGludGVsKDApOiBQcmludGluZyBEREMgZ2F0aGVyZWQgTW9kZWxpbmVzOgpbICAgIDMxLjI4
NV0gKElJKSBpbnRlbCgwKTogTW9kZWxpbmUgIjEzNjZ4NzY4IngwLjAgICA2OS4zMCAgMTM2NiAx
NDE0IDE0NDYgMTQ1NiAgNzY4IDc3MSA3NzcgNzkzIC1oc3luYyAtdnN5bmMgKDQ3LjYga0h6KQpb
ICAgIDMxLjI4N10gKElJKSBpbnRlbCgwKTogRURJRCB2ZW5kb3IgIkFVTyIsIHByb2QgaWQgMTY0
MjgKWyAgICAzMS4yODddIChJSSkgaW50ZWwoMCk6IFByaW50aW5nIEREQyBnYXRoZXJlZCBNb2Rl
bGluZXM6ClsgICAgMzEuMjg3XSAoSUkpIGludGVsKDApOiBNb2RlbGluZSAiMTM2Nng3NjgieDAu
MCAgIDY5LjMwICAxMzY2IDE0MTQgMTQ0NiAxNDU2ICA3NjggNzcxIDc3NyA3OTMgLWhzeW5jIC12
c3luYyAoNDcuNiBrSHopClsgICAgMzEuMzA4XSAoSUkpIGludGVsKDApOiBFRElEIHZlbmRvciAi
QVVPIiwgcHJvZCBpZCAxNjQyOApbICAgIDMxLjMwOF0gKElJKSBpbnRlbCgwKTogUHJpbnRpbmcg
RERDIGdhdGhlcmVkIE1vZGVsaW5lczoKWyAgICAzMS4zMDhdIChJSSkgaW50ZWwoMCk6IE1vZGVs
aW5lICIxMzY2eDc2OCJ4MC4wICAgNjkuMzAgIDEzNjYgMTQxNCAxNDQ2IDE0NTYgIDc2OCA3NzEg
Nzc3IDc5MyAtaHN5bmMgLXZzeW5jICg0Ny42IGtIeikKWyAgICA0OC4wMTNdIChJSSkgaW50ZWwo
MCk6IEVESUQgdmVuZG9yICJBVU8iLCBwcm9kIGlkIDE2NDI4ClsgICAgNDguMDEzXSAoSUkpIGlu
dGVsKDApOiBQcmludGluZyBEREMgZ2F0aGVyZWQgTW9kZWxpbmVzOgpbICAgIDQ4LjAxM10gKElJ
KSBpbnRlbCgwKTogTW9kZWxpbmUgIjEzNjZ4NzY4IngwLjAgICA2OS4zMCAgMTM2NiAxNDE0IDE0
NDYgMTQ1NiAgNzY4IDc3MSA3NzcgNzkzIC1oc3luYyAtdnN5bmMgKDQ3LjYga0h6KQpbICAgIDQ4
LjAxNV0gKElJKSBpbnRlbCgwKTogRURJRCB2ZW5kb3IgIkFVTyIsIHByb2QgaWQgMTY0MjgKWyAg
ICA0OC4wMTVdIChJSSkgaW50ZWwoMCk6IFByaW50aW5nIEREQyBnYXRoZXJlZCBNb2RlbGluZXM6
ClsgICAgNDguMDE1XSAoSUkpIGludGVsKDApOiBNb2RlbGluZSAiMTM2Nng3NjgieDAuMCAgIDY5
LjMwICAxMzY2IDE0MTQgMTQ0NiAxNDU2ICA3NjggNzcxIDc3NyA3OTMgLWhzeW5jIC12c3luYyAo
NDcuNiBrSHopClsgICAgNDguMDE2XSAoSUkpIGludGVsKDApOiBFRElEIHZlbmRvciAiQVVPIiwg
cHJvZCBpZCAxNjQyOApbICAgIDQ4LjAxNl0gKElJKSBpbnRlbCgwKTogUHJpbnRpbmcgRERDIGdh
dGhlcmVkIE1vZGVsaW5lczoKWyAgICA0OC4wMTZdIChJSSkgaW50ZWwoMCk6IE1vZGVsaW5lICIx
MzY2eDc2OCJ4MC4wICAgNjkuMzAgIDEzNjYgMTQxNCAxNDQ2IDE0NTYgIDc2OCA3NzEgNzc3IDc5
MyAtaHN5bmMgLXZzeW5jICg0Ny42IGtIeikKWyAgICA1MC44MTRdIChJSSkgaW50ZWwoMCk6IEVE
SUQgdmVuZG9yICJBVU8iLCBwcm9kIGlkIDE2NDI4ClsgICAgNTAuODE0XSAoSUkpIGludGVsKDAp
OiBQcmludGluZyBEREMgZ2F0aGVyZWQgTW9kZWxpbmVzOgpbICAgIDUwLjgxNF0gKElJKSBpbnRl
bCgwKTogTW9kZWxpbmUgIjEzNjZ4NzY4IngwLjAgICA2OS4zMCAgMTM2NiAxNDE0IDE0NDYgMTQ1
NiAgNzY4IDc3MSA3NzcgNzkzIC1oc3luYyAtdnN5bmMgKDQ3LjYga0h6KQo=

--Multipart=_Sat__7_Jul_2012_13_35_19_+0800_amjr5p9Y4..xlEyg--
