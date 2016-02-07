From: Manuel Reimer <Manuel.Spam@nurfuerspam.de>
Subject: Re: Pull USB plug while fftest on PS4 pad --> Kernel panic
Date: Sun, 7 Feb 2016 22:57:02 +0100
Message-ID: <n98eje$6qa$1@ger.gmane.org>
References: <n932md$odm$1@ger.gmane.org> <n97j48$219$1@ger.gmane.org>
 <20160207205954.965227df774b56a6a23f2463@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:43197 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754500AbcBGV5Q (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 7 Feb 2016 16:57:16 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-input-2@m.gmane.org>)
	id 1aSXKS-0002MJ-H1
	for linux-input@vger.kernel.org; Sun, 07 Feb 2016 22:57:12 +0100
Received: from p5dd5670f.dip0.t-ipconnect.de ([93.213.103.15])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Sun, 07 Feb 2016 22:57:12 +0100
Received: from Manuel.Spam by p5dd5670f.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Sun, 07 Feb 2016 22:57:12 +0100
In-Reply-To: <20160207205954.965227df774b56a6a23f2463@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

On 02/07/2016 08:59 PM, Antonio Ospite wrote:
> You are. However when reporting crashes you get more chances to have
> people looking at the issue if you paste the exact "Oops" text from the
> kernel logs.

Nothing was logged to journal, but I was able to catch the log output 
using the serial console.

> If you wanted to try looking at the issue yourself, here is a brief
> tutorial on how to debug some kinds of kernel crashes:
>
> http://ao2.it/it/blog/2010/11/02/bug-hunting-linux-kernel-land-unpretentious-primer

In my Oops the module name is missing and __kmalloc_track_caller may be 
some core kernel function?

As I couldn't find a reliable place to store the Oops output: Sorry for 
the following wall of text:






[   96.693913] BUG: unable to handle kernel paging request at 
000000000000ff05
[   96.696904] IP: [<ffffffff811c2df1>] __kmalloc_track_caller+0x91/0x230
[   96.696904] PGD 0
[   96.696904] Oops: 0000 [#1] PREEMPT SMP
[   96.696904] Modules linked in: hid_sony ff_memless cfg80211 rfkill 
psmouse input_leds ppdev pcspkr crct10dif_pclmul crc32_pclmul 
aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd 
led_class serio_raw parport_pc fjes joydev acpi_cpufreq parport battery 
intel_agp intel_gtt mousedev tpm_tis mac_hid tpm e1000 button evdev 
i2c_piix4 ac video vboxvideo(O) drm processor sch_fq_codel vboxsf(O) 
vboxguest(O) ip_tables x_tables hid_generic usbhid hid xfs libcrc32c 
sr_mod cdrom sd_mod ata_generic pata_acpi atkbd libps2 crc32c_intel 
ohci_pci ohci_hcd ata_piix ahci libahci i8042 serio usbcore usb_common 
libata scsi_mod
[   96.696904] CPU: 0 PID: 170 Comm: kworker/0:10 Tainted: G           O 
    4.4.1-2-ARCH #1
[   96.696904] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS 
VirtualBox 12/01/2006
[   96.696904] Workqueue: usb_hub_wq hub_event [usbcore]
[   96.696904] task: ffff88003dab6e00 ti: ffff880037fe4000 task.ti: 
ffff880037fe4000
[   96.696904] RIP: 0010:[<ffffffff811c2df1>]  [<ffffffff811c2df1>] 
__kmalloc_track_caller+0x91/0x230
[   96.696904] RSP: 0018:ffff880037fe72f8  EFLAGS: 00010206
[   96.696904] RAX: 0000000000000000 RBX: ffff880037968580 RCX: 
0000000000280f80
[   96.696904] RDX: 0000000000280f00 RSI: 0000000000280f00 RDI: 
0000000000018aa0
[   96.696904] RBP: ffff880037fe7330 R08: ffff88003d0331f8 R09: 
ffff88003e001c00
[   96.696904] R10: ffffea0000001400 R11: 000000000000000d R12: 
00000000024000c0
[   96.696904] R13: 000000000000001b R14: ffff88003e001c00 R15: 
000000000000ff05
[   96.696904] FS:  00007f0d132c8780(0000) GS:ffff88003fc00000(0000) 
knlGS:0000000000000000
[   96.696904] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[   96.696904] CR2: 000000000000ff05 CR3: 000000003da89000 CR4: 
00000000000406f0
[   96.696904] Stack:
[   96.696904]  ffff88003e026710 ffffffff81180d23 ffff880037968580 
000000000000001b
[   96.696904]  00000000024000c0 0000000000000004 000000000000a1ff 
ffff880037fe7358
[   96.696904]  ffffffff81180cd1 ffff88003d08ca50 ffff88003e026700 
ffff88003d08ca50
[   96.696904] Call Trace:
[   96.696904]  [<ffffffff81180d23>] ? kstrdup_const+0x23/0x30
[   96.696904]  [<ffffffff81180cd1>] kstrdup+0x31/0x60
[   96.696904]  [<ffffffff81180d23>] kstrdup_const+0x23/0x30
[   96.696904]  [<ffffffff81256d18>] __kernfs_new_node+0x28/0xc0
[   96.696904]  [<ffffffff81257dc6>] kernfs_new_node+0x26/0x50
[   96.696904]  [<ffffffff81259853>] kernfs_create_link+0x23/0x80
[   96.696904]  [<ffffffff8125a526>] 
sysfs_do_create_link_sd.isra.0+0x66/0xc0
[   96.696904]  [<ffffffff8125a5a5>] sysfs_create_link+0x25/0x40
[   96.696904]  [<ffffffff813e8057>] device_add+0x2f7/0x690
[   96.696904]  [<ffffffff813e85e0>] device_create_groups_vargs+0xe0/0xf0
[   96.696904]  [<ffffffff813e86c6>] device_create_with_groups+0x46/0x60
[   96.696904]  [<ffffffffa038a442>] led_classdev_register+0xc2/0x200 
[led_class]
[   96.696904]  [<ffffffffa035085b>] ? sony_probe+0xa0b/0xf30 [hid_sony]
[   96.696904]  [<ffffffffa0350816>] sony_probe+0x9c6/0xf30 [hid_sony]
[   96.696904]  [<ffffffffa023eaa3>] hid_device_probe+0xd3/0x140 [hid]
[   96.696904]  [<ffffffff813eb652>] driver_probe_device+0x222/0x4a0
[   96.696904]  [<ffffffff813eb9d1>] __device_attach_driver+0x71/0xa0
[   96.696904]  [<ffffffff813eb960>] ? __driver_attach+0x90/0x90
[   96.696904]  [<ffffffff813e9367>] bus_for_each_drv+0x67/0xb0
[   96.696904]  [<ffffffff813eb32c>] __device_attach+0xdc/0x170
[   96.696904]  [<ffffffff813eba43>] device_initial_probe+0x13/0x20
[   96.696904]  [<ffffffff813ea5f2>] bus_probe_device+0x92/0xa0
[   96.696904]  [<ffffffff813e816c>] device_add+0x40c/0x690
[   96.696904]  [<ffffffff812679a1>] ? debugfs_create_file+0xb1/0xe0
[   96.696904]  [<ffffffffa023fb9b>] hid_add_device+0xdb/0x2a0 [hid]
[   96.696904]  [<ffffffff81188a5e>] ? kmalloc_order_trace+0x2e/0xe0
[   96.696904]  [<ffffffffa020132f>] ? usbhid_probe+0x23f/0x410 [usbhid]
[   96.696904]  [<ffffffffa02013d2>] usbhid_probe+0x2e2/0x410 [usbhid]
[   96.696904]  [<ffffffffa009d20d>] usb_probe_interface+0x1bd/0x300 
[usbcore]
[   96.696904]  [<ffffffff813eb652>] driver_probe_device+0x222/0x4a0
[   96.696904]  [<ffffffff813eb9d1>] __device_attach_driver+0x71/0xa0
[   96.696904]  [<ffffffff813eb960>] ? __driver_attach+0x90/0x90
[   96.696904]  [<ffffffff813e9367>] bus_for_each_drv+0x67/0xb0
[   96.696904]  [<ffffffff813eb32c>] __device_attach+0xdc/0x170
[   96.696904]  [<ffffffff813eba43>] device_initial_probe+0x13/0x20
[   96.696904]  [<ffffffff813ea5f2>] bus_probe_device+0x92/0xa0
[   96.696904]  [<ffffffff813e816c>] device_add+0x40c/0x690
[   96.696904]  [<ffffffffa009b056>] usb_set_configuration+0x516/0x8f0 
[usbcore]
[   96.696904]  [<ffffffffa00a5a5e>] generic_probe+0x2e/0x80 [usbcore]
[   96.696904]  [<ffffffffa009d012>] usb_probe_device+0x32/0x70 [usbcore]
[   96.696904]  [<ffffffff813eb652>] driver_probe_device+0x222/0x4a0
[   96.696904]  [<ffffffff813eb9d1>] __device_attach_driver+0x71/0xa0
[   96.696904]  [<ffffffff813eb960>] ? __driver_attach+0x90/0x90
[   96.696904]  [<ffffffff813e9367>] bus_for_each_drv+0x67/0xb0
[   96.696904]  [<ffffffff813eb32c>] __device_attach+0xdc/0x170
[   96.696904]  [<ffffffff813eba43>] device_initial_probe+0x13/0x20
[   96.696904]  [<ffffffff813ea5f2>] bus_probe_device+0x92/0xa0
[   96.696904]  [<ffffffff813e816c>] device_add+0x40c/0x690
[   96.696904]  [<ffffffff813c4913>] ? add_device_randomness+0xd3/0x140
[   96.696904]  [<ffffffffa00906bb>] usb_new_device+0x1cb/0x400 [usbcore]
[   96.696904]  [<ffffffffa0092238>] hub_event+0x978/0x1550 [usbcore]
[   96.696904]  [<ffffffff8108e21b>] process_one_work+0x14b/0x440
[   96.696904]  [<ffffffff8108e558>] worker_thread+0x48/0x4a0
[   96.696904]  [<ffffffff8108e510>] ? process_one_work+0x440/0x440
[   96.696904]  [<ffffffff81093ff8>] kthread+0xd8/0xf0
[   96.696904]  [<ffffffff81093f20>] ? kthread_worker_fn+0x170/0x170
[   96.696904]  [<ffffffff81591e8f>] ret_from_fork+0x3f/0x70
[   96.696904]  [<ffffffff81093f20>] ? kthread_worker_fn+0x170/0x170
[   96.696904] Code: 08 48 39 f2 75 e7 48 83 78 10 00 4c 8b 38 0f 84 28 
01 00 00 4d 85 ff 0f 84 1f 01 00 00 49 63 41 20 49 8b 39 48 8d 8a 80 00 
00 00 <49> 8b 1c 07 4c 89 f8 65 48 0f c7 0f 0f 94 c0 84 c0 74 ac 49 63
[   96.696904] RIP  [<ffffffff811c2df1>] __kmalloc_track_caller+0x91/0x230
[   96.696904]  RSP <ffff880037fe72f8>
[   96.696904] CR2: 000000000000ff05
[   96.696904] ---[ end trace fe8dea9fa86458e3 ]---
[  117.102330] clocksource: timekeeping watchdog: Marking clocksource 
'tsc' as unstable because the skew is too large:
[  117.571561] clocksource:                       'acpi_pm' wd_now: 
d0e778 wd_last: 5dc44c mask: ffffff
[  117.982252] clocksource:                       'tsc' cs_now: 
15f17a8d7e3 cs_last: 14a8f5fa192 mask: ffffffffffffffff
[  118.455264] BUG: unable to handle kernel paging request at 
000000000000ff05
[  118.458409] IP: [<ffffffff811c0102>] kmem_cache_alloc+0x72/0x1e0
[  118.458409] PGD 0
[  118.458409] Oops: 0000 [#2] PREEMPT SMP
[  118.458409] Modules linked in: hid_sony ff_memless cfg80211 rfkill 
psmouse input_leds ppdev pcspkr crct10dif_pclmul crc32_pclmul 
aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd 
led_class serio_raw parport_pc fjes joydev acpi_cpufreq parport battery 
intel_agp intel_gtt mousedev tpm_tis mac_hid tpm e1000 button evdev 
i2c_piix4 ac video vboxvideo(O) drm processor sch_fq_codel vboxsf(O) 
vboxguest(O) ip_tables x_tables hid_generic usbhid hid xfs libcrc32c 
sr_mod cdrom sd_mod ata_generic pata_acpi atkbd libps2 crc32c_intel 
ohci_pci ohci_hcd ata_piix ahci libahci i8042 serio usbcore usb_common 
libata scsi_mod
[  118.458409] CPU: 0 PID: 158 Comm: systemd-journal Tainted: G      D 
   O    4.4.1-2-ARCH #1
[  118.458409] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS 
VirtualBox 12/01/2006
[  118.458409] task: ffff880037efa940 ti: ffff88003d974000 task.ti: 
ffff88003d974000
[  118.458409] RIP: 0010:[<ffffffff811c0102>]  [<ffffffff811c0102>] 
kmem_cache_alloc+0x72/0x1e0
[  118.458409] RSP: 0000:ffff88003d977b98  EFLAGS: 00010206
[  118.458409] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
0000000000280f80
[  118.458409] RDX: 0000000000280f00 RSI: 0000000000280f00 RDI: 
0000000000018aa0
[  118.458409] RBP: ffff88003d977bc8 R08: ffffffffa019ebf1 R09: 
000000000000001d
[  118.458409] R10: 00000000211d4ade R11: 00003fffffe00000 R12: 
0000000002408240
[  118.458409] R13: 000000000000ff05 R14: ffff88003e001c00 R15: 
ffff88003e001c00
[  118.458409] FS:  00007f0d132c8780(0000) GS:ffff88003fc00000(0000) 
knlGS:0000000000000000
[  118.458409] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  118.458409] CR2: 000000000000ff05 CR3: 000000003da89000 CR4: 
00000000000406f0
[  118.458409] Stack:
[  118.458409]  ffff88003d977bd8 0000000000000000 0000000002408240 
0000000000000000
[  118.458409]  ffff88003e001c00 0000000051eb851f ffff88003d977c10 
ffffffffa019ebf1
[  118.458409]  ffff880037efaf30 ffff880037efa940 ffff880037944718 
ffff880037d03098
[  118.458409] Call Trace:
[  118.458409]  [<ffffffffa019ebf1>] kmem_zone_alloc+0x81/0x120 [xfs]
[  118.458409]  [<ffffffffa019dbfa>] xfs_trans_add_item+0x2a/0x60 [xfs]
[  118.458409]  [<ffffffffa01aed01>] xfs_trans_ijoin+0x31/0x60 [xfs]
[  118.458409]  [<ffffffffa018e8a0>] xfs_vn_update_time+0xe0/0x1a0 [xfs]
[  118.458409]  [<ffffffff811f8589>] file_update_time+0xb9/0x110
[  118.458409]  [<ffffffffa01846a3>] xfs_filemap_page_mkwrite+0x53/0x110 
[xfs]
[  118.458409]  [<ffffffff81190926>] do_page_mkwrite+0x56/0xb0
[  118.458409]  [<ffffffff812d31dd>] ? scnprintf+0x4d/0x90
[  118.458409]  [<ffffffff81192eb9>] do_wp_page+0x289/0x610
[  118.458409]  [<ffffffff810cb3aa>] ? devkmsg_read+0x15a/0x2a0
[  118.458409]  [<ffffffff81195a10>] handle_mm_fault+0xa20/0x1980
[  118.458409]  [<ffffffff811e3c71>] ? cp_new_stat+0x121/0x150
[  118.458409]  [<ffffffff810643e9>] __do_page_fault+0x189/0x450
[  118.458409]  [<ffffffff810646d2>] do_page_fault+0x22/0x30
[  118.458409]  [<ffffffff81593c88>] page_fault+0x28/0x30
[  118.458409] Code: 08 48 39 f2 75 e7 48 83 78 10 00 4c 8b 28 0f 84 34 
01 00 00 4d 85 ed 0f 84 2b 01 00 00 49 63 46 20 49 8b 3e 48 8d 8a 80 00 
00 00 <49> 8b 5c 05 00 4c 89 e8 65 48 0f c7 0f 0f 94 c0 84 c0 74 ab 49
[  118.458409] RIP  [<ffffffff811c0102>] kmem_cache_alloc+0x72/0x1e0
[  118.458409]  RSP <ffff88003d977b98>
[  118.458409] CR2: 000000000000ff05
[  132.172392] ---[ end trace fe8dea9fa86458e4 ]---
[  132.347011] BUG: unable to handle kernel paging request at 
000000000000ff05
[  132.349937] IP: [<ffffffff811bfe96>] kmem_cache_alloc_trace+0x76/0x1e0
[  132.349937] PGD 0
[  132.349937] Oops: 0000 [#3] PREEMPT SMP
[  132.349937] Modules linked in: hid_sony ff_memless cfg80211 rfkill 
psmouse input_leds ppdev pcspkr crct10dif_pclmul crc32_pclmul 
aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd 
led_class serio_raw parport_pc fjes joydev acpi_cpufreq parport battery 
intel_agp intel_gtt mousedev tpm_tis mac_hid tpm e1000 button evdev 
i2c_piix4 ac video vboxvideo(O) drm processor sch_fq_codel vboxsf(O) 
vboxguest(O) ip_tables x_tables hid_generic usbhid hid xfs libcrc32c 
sr_mod cdrom sd_mod ata_generic pata_acpi atkbd libps2 crc32c_intel 
ohci_pci ohci_hcd ata_piix ahci libahci i8042 serio usbcore usb_common 
libata scsi_mod
[  132.349937] CPU: 0 PID: 1 Comm: systemd Tainted: G      D    O 
4.4.1-2-ARCH #1
[  132.349937] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS 
VirtualBox 12/01/2006
[  132.349937] task: ffff88003e2c0000 ti: ffff88003e264000 task.ti: 
ffff88003e264000
[  132.349937] RIP: 0010:[<ffffffff811bfe96>]  [<ffffffff811bfe96>] 
kmem_cache_alloc_trace+0x76/0x1e0
[  132.349937] RSP: 0018:ffff88003e267c40  EFLAGS: 00010206
[  132.349937] RAX: 0000000000000000 RBX: ffff880037c83000 RCX: 
0000000000280f80
[  132.349937] RDX: 0000000000280f00 RSI: 0000000000280f00 RDI: 
0000000000018aa0
[  132.349937] RBP: ffff88003e267c78 R08: 0000000000000000 R09: 
ffffffff81201763
[  132.349937] R10: ffff88003d7d2a80 R11: 8080808080808080 R12: 
00000000024000c0
[  132.349937] R13: 000000000000ff05 R14: ffff88003e001c00 R15: 
ffff88003e001c00
[  132.349937] FS:  00007f3001b667c0(0000) GS:ffff88003fc00000(0000) 
knlGS:0000000000000000
[  132.349937] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  132.349937] CR2: 000000000000ff05 CR3: 0000000037ab2000 CR4: 
00000000000406f0
[  132.349937] Stack:
[  132.349937]  0000000000010000 0000000000000020 ffff880037c83000 
ffff880037c83000
[  132.349937]  ffffffff81248660 ffff88003c84a9f8 ffff880037c83010 
ffff88003e267cb0
[  132.349937]  ffffffff81201763 ffff88003c84a9f8 ffff880037c83000 
ffff88003cf13f00
[  132.349937] Call Trace:
[  132.349937]  [<ffffffff81248660>] ? proc_pid_schedstat+0x40/0x40
[  132.349937]  [<ffffffff81201763>] single_open+0x33/0xa0
[  132.349937]  [<ffffffff81249e5b>] comm_open+0x1b/0x20
[  132.349937]  [<ffffffff811dcbdf>] do_dentry_open+0x1ff/0x300
[  132.349937]  [<ffffffff81249e40>] ? proc_pid_cmdline_read+0x530/0x530
[  132.349937]  [<ffffffff811ddd46>] vfs_open+0x56/0x60
[  132.349937]  [<ffffffff811ec528>] path_openat+0x4d8/0x10c0
[  132.349937]  [<ffffffff8109f630>] ? wake_up_q+0x70/0x70
[  132.349937]  [<ffffffff811ee5e1>] do_filp_open+0x91/0x100
[  132.349937]  [<ffffffff811fb247>] ? __alloc_fd+0xc7/0x190
[  132.349937]  [<ffffffff811de116>] do_sys_open+0x146/0x230
[  132.349937]  [<ffffffff811de21e>] SyS_open+0x1e/0x20
[  132.349937]  [<ffffffff81591b2e>] entry_SYSCALL_64_fastpath+0x12/0x71
[  132.349937] Code: 08 48 39 f2 75 e7 48 83 78 10 00 4c 8b 28 0f 84 2c 
01 00 00 4d 85 ed 0f 84 23 01 00 00 49 63 47 20 49 8b 3f 48 8d 8a 80 00 
00 00 <49> 8b 5c 05 00 4c 89 e8 65 48 0f c7 0f 0f 94 c0 84 c0 74 ab 49
[  132.349937] RIP  [<ffffffff811bfe96>] kmem_cache_alloc_trace+0x76/0x1e0
[  132.349937]  RSP <ffff88003e267c40>
[  132.349937] CR2: 000000000000ff05
[  143.600415] BUG: unable to handle kernel paging request at 
ffffffffffffffd8
[  143.600415] IP: [<ffffffff81094500>] kthread_data+0x10/0x20
[  143.600415] PGD 180c067 PUD 180e067 PMD 0
[  143.600415] Oops: 0000 [#4] PREEMPT SMP
[  143.600415] Modules linked in: hid_sony ff_memless cfg80211 rfkill 
psmouse input_leds ppdev pcspkr crct10dif_pclmul crc32_pclmul 
aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd 
led_class serio_raw parport_pc fjes joydev acpi_cpufreq parport battery 
intel_agp intel_gtt mousedev tpm_tis mac_hid tpm e1000 button evdev 
i2c_piix4 ac video vboxvideo(O) drm processor sch_fq_codel vboxsf(O) 
vboxguest(O) ip_tables x_tables hid_generic usbhid hid xfs libcrc32c 
sr_mod cdrom sd_mod ata_generic pata_acpi atkbd libps2 crc32c_intel 
ohci_pci ohci_hcd ata_piix ahci libahci i8042 serio usbcore usb_common 
libata scsi_mod
[  143.600415] CPU: 0 PID: 170 Comm: kworker/0:10 Tainted: G      D    O 
    4.4.1-2-ARCH #1
[  143.600415] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS 
VirtualBox 12/01/2006
[  143.600415] task: ffff88003dab6e00 ti: ffff880037fe4000 task.ti: 
ffff880037fe4000
[  143.600415] RIP: 0010:[<ffffffff81094500>]  [<ffffffff81094500>] 
kthread_data+0x10/0x20
[  143.600415] RSP: 0018:ffff880037fe6fe8  EFLAGS: 00010002
[  143.600415] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
ffffffff81a61700
[  143.600415] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
ffff88003dab6e00
[  143.600415] RBP: ffff880037fe6fe8 R08: 00000000ffffffff R09: 
000000216f4072e2
[  143.600415] R10: ffff88003dab6e60 R11: ffff880037fc002f R12: 
0000000000000000
[  143.600415] R13: 0000000000015700 R14: ffff88003dab6e00 R15: 
ffff88003fc15700
[  143.600415] FS:  00007f0d132c8780(0000) GS:ffff88003fc00000(0000) 
knlGS:0000000000000000
[  143.600415] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  143.600415] CR2: 0000000000000028 CR3: 0000000037ab2000 CR4: 
00000000000406f0
[  143.600415] Stack:
[  143.600415]  ffff880037fe7000 ffffffff8108edf1 ffff88003fc15700 
ffff880037fe7050
[  143.600415]  ffffffff8158dbd0 ffff880037fe7040 ffffffff00000000 
ffff88003dab6e00
[  143.600415]  ffff880037fe8000 ffff88003dab74b8 ffff880037fe6c00 
000000000000ff05
[  143.600415] Call Trace:
[  143.600415]  [<ffffffff8108edf1>] wq_worker_sleeping+0x11/0x90
[  143.600415]  [<ffffffff8158dbd0>] __schedule+0x640/0xa70
[  143.600415]  [<ffffffff8158e03c>] schedule+0x3c/0x90
[  143.600415]  [<ffffffff810795c8>] do_exit+0x768/0xae0
[  143.600415]  [<ffffffff8101976a>] oops_end+0x9a/0xd0
[  143.600415]  [<ffffffff81063bbc>] no_context+0x15c/0x380
[  143.600415]  [<ffffffff812d1d0c>] ? number.isra.11+0x2cc/0x2f0
[  143.600415]  [<ffffffff81063f08>] __bad_area_nosemaphore+0x128/0x230
[  143.600415]  [<ffffffff812c93f9>] ? idr_get_empty_slot+0x199/0x3b0
[  143.600415]  [<ffffffff81064023>] bad_area_nosemaphore+0x13/0x20
[  143.600415]  [<ffffffff81064482>] __do_page_fault+0x222/0x450
[  143.600415]  [<ffffffff812c8722>] ? get_from_free_list+0x42/0x50
[  143.600415]  [<ffffffff810646d2>] do_page_fault+0x22/0x30
[  143.600415]  [<ffffffff81593c88>] page_fault+0x28/0x30
[  143.600415]  [<ffffffff811c2df1>] ? __kmalloc_track_caller+0x91/0x230
[  143.600415]  [<ffffffff811c2d92>] ? __kmalloc_track_caller+0x32/0x230
[  143.600415]  [<ffffffff81180d23>] ? kstrdup_const+0x23/0x30
[  143.600415]  [<ffffffff81180cd1>] kstrdup+0x31/0x60
[  143.600415]  [<ffffffff81180d23>] kstrdup_const+0x23/0x30
[  143.600415]  [<ffffffff81256d18>] __kernfs_new_node+0x28/0xc0
[  143.600415]  [<ffffffff81257dc6>] kernfs_new_node+0x26/0x50
[  143.600415]  [<ffffffff81259853>] kernfs_create_link+0x23/0x80
[  143.600415]  [<ffffffff8125a526>] 
sysfs_do_create_link_sd.isra.0+0x66/0xc0
[  143.600415]  [<ffffffff8125a5a5>] sysfs_create_link+0x25/0x40
[  143.600415]  [<ffffffff813e8057>] device_add+0x2f7/0x690
[  143.600415]  [<ffffffff813e85e0>] device_create_groups_vargs+0xe0/0xf0
[  143.600415]  [<ffffffff813e86c6>] device_create_with_groups+0x46/0x60
[  143.600415]  [<ffffffffa038a442>] led_classdev_register+0xc2/0x200 
[led_class]
[  143.600415]  [<ffffffffa035085b>] ? sony_probe+0xa0b/0xf30 [hid_sony]
[  143.600415]  [<ffffffffa0350816>] sony_probe+0x9c6/0xf30 [hid_sony]
[  143.600415]  [<ffffffffa023eaa3>] hid_device_probe+0xd3/0x140 [hid]
[  143.600415]  [<ffffffff813eb652>] driver_probe_device+0x222/0x4a0
[  143.600415]  [<ffffffff813eb9d1>] __device_attach_driver+0x71/0xa0
[  143.600415]  [<ffffffff813eb960>] ? __driver_attach+0x90/0x90
[  143.600415]  [<ffffffff813e9367>] bus_for_each_drv+0x67/0xb0
[  143.600415]  [<ffffffff813eb32c>] __device_attach+0xdc/0x170
[  143.600415]  [<ffffffff813eba43>] device_initial_probe+0x13/0x20
[  143.600415]  [<ffffffff813ea5f2>] bus_probe_device+0x92/0xa0
[  143.600415]  [<ffffffff813e816c>] device_add+0x40c/0x690
[  143.600415]  [<ffffffff812679a1>] ? debugfs_create_file+0xb1/0xe0
[  143.600415]  [<ffffffffa023fb9b>] hid_add_device+0xdb/0x2a0 [hid]
[  143.600415]  [<ffffffff81188a5e>] ? kmalloc_order_trace+0x2e/0xe0
[  143.600415]  [<ffffffffa020132f>] ? usbhid_probe+0x23f/0x410 [usbhid]
[  143.600415]  [<ffffffffa02013d2>] usbhid_probe+0x2e2/0x410 [usbhid]
[  143.600415]  [<ffffffffa009d20d>] usb_probe_interface+0x1bd/0x300 
[usbcore]
[  143.600415]  [<ffffffff813eb652>] driver_probe_device+0x222/0x4a0
[  143.600415]  [<ffffffff813eb9d1>] __device_attach_driver+0x71/0xa0
[  143.600415]  [<ffffffff813eb960>] ? __driver_attach+0x90/0x90
[  143.600415]  [<ffffffff813e9367>] bus_for_each_drv+0x67/0xb0
[  143.600415]  [<ffffffff813eb32c>] __device_attach+0xdc/0x170
[  143.600415]  [<ffffffff813eba43>] device_initial_probe+0x13/0x20
[  143.600415]  [<ffffffff813ea5f2>] bus_probe_device+0x92/0xa0
[  143.600415]  [<ffffffff813e816c>] device_add+0x40c/0x690
[  143.600415]  [<ffffffffa009b056>] usb_set_configuration+0x516/0x8f0 
[usbcore]
[  143.600415]  [<ffffffffa00a5a5e>] generic_probe+0x2e/0x80 [usbcore]
[  143.600415]  [<ffffffffa009d012>] usb_probe_device+0x32/0x70 [usbcore]
[  143.600415]  [<ffffffff813eb652>] driver_probe_device+0x222/0x4a0
[  143.600415]  [<ffffffff813eb9d1>] __device_attach_driver+0x71/0xa0
[  143.600415]  [<ffffffff813eb960>] ? __driver_attach+0x90/0x90
[  143.600415]  [<ffffffff813e9367>] bus_for_each_drv+0x67/0xb0
[  143.600415]  [<ffffffff813eb32c>] __device_attach+0xdc/0x170
[  143.600415]  [<ffffffff813eba43>] device_initial_probe+0x13/0x20
[  143.600415]  [<ffffffff813ea5f2>] bus_probe_device+0x92/0xa0
[  143.600415]  [<ffffffff813e816c>] device_add+0x40c/0x690
[  143.600415]  [<ffffffff813c4913>] ? add_device_randomness+0xd3/0x140
[  143.600415]  [<ffffffffa00906bb>] usb_new_device+0x1cb/0x400 [usbcore]
[  143.600415]  [<ffffffffa0092238>] hub_event+0x978/0x1550 [usbcore]
[  143.600415]  [<ffffffff8108e21b>] process_one_work+0x14b/0x440
[  143.600415]  [<ffffffff8108e558>] worker_thread+0x48/0x4a0
[  143.600415]  [<ffffffff8108e510>] ? process_one_work+0x440/0x440
[  143.600415]  [<ffffffff81093ff8>] kthread+0xd8/0xf0
[  143.600415]  [<ffffffff81093f20>] ? kthread_worker_fn+0x170/0x170
[  143.600415]  [<ffffffff81591e8f>] ret_from_fork+0x3f/0x70
[  143.600415]  [<ffffffff81093f20>] ? kthread_worker_fn+0x170/0x170
[  143.600415] Code: 41 5d 5d c3 e8 36 eb f6 ff e9 13 ff ff ff 0f 1f 00 
66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8b 87 10 05 00 00 55 48 
89 e5 <48> 8b 40 d8 5d c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
[  143.600415] RIP  [<ffffffff81094500>] kthread_data+0x10/0x20
[  143.600415]  RSP <ffff880037fe6fe8>
[  143.600415] CR2: ffffffffffffffd8
[  143.600415] ---[ end trace fe8dea9fa86458e5 ]---
[  143.600415] Fixing recursive fault but reboot is needed!
[  143.600415] BUG: scheduling while atomic: kworker/0:10/170/0x00000003
[  143.600415] Modules linked in: hid_sony ff_memless cfg80211 rfkill 
psmouse input_leds ppdev pcspkr crct10dif_pclmul crc32_pclmul 
aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd 
led_class serio_raw parport_pc fjes joydev acpi_cpufreq parport battery 
intel_agp intel_gtt mousedev tpm_tis mac_hid tpm e1000 button evdev 
i2c_piix4 ac video vboxvideo(O) drm processor sch_fq_codel vboxsf(O) 
vboxguest(O) ip_tables x_tables hid_generic usbhid hid xfs libcrc32c 
sr_mod cdrom sd_mod ata_generic pata_acpi atkbd libps2 crc32c_intel 
ohci_pci ohci_hcd ata_piix ahci libahci i8042 serio usbcore usb_common 
libata scsi_mod
[  143.600415] CPU: 0 PID: 170 Comm: kworker/0:10 Tainted: G      D    O 
    4.4.1-2-ARCH #1
[  143.600415] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS 
VirtualBox 12/01/2006
[  143.600415]  0000000000000000 000000007ecd1ad9 ffff880037fe6ce0 
ffffffff812c7f39
[  143.600415]  ffff88003fc15700 ffff880037fe6cf0 ffffffff8109b9ab 
ffff880037fe6d40
[  143.600415]  ffffffff8158de18 0000000000000008 ffff880000000000 
ffff88003dab6e00
[  143.600415] Call Trace:
[  143.600415]  [<ffffffff812c7f39>] dump_stack+0x4b/0x72
[  143.600415]  [<ffffffff8109b9ab>] __schedule_bug+0x4b/0x60
[  143.600415]  [<ffffffff8158de18>] __schedule+0x888/0xa70
[  143.600415]  [<ffffffff8158e03c>] schedule+0x3c/0x90
[  143.600415]  [<ffffffff8107973b>] do_exit+0x8db/0xae0
[  143.600415]  [<ffffffff8101976a>] oops_end+0x9a/0xd0
[  143.600415]  [<ffffffff81063bbc>] no_context+0x15c/0x380
[  143.600415]  [<ffffffff81220af4>] ? fsnotify_destroy_marks+0x74/0x80
[  143.600415]  [<ffffffff81063f08>] __bad_area_nosemaphore+0x128/0x230
[  143.600415]  [<ffffffff81064023>] bad_area_nosemaphore+0x13/0x20
[  143.600415]  [<ffffffff81064482>] __do_page_fault+0x222/0x450
[  143.600415]  [<ffffffff81256b57>] ? kernfs_path_locked+0x37/0x80
[  143.600415]  [<ffffffff810646d2>] do_page_fault+0x22/0x30
[  143.600415]  [<ffffffff81593c88>] page_fault+0x28/0x30
[  143.600415]  [<ffffffff81094500>] ? kthread_data+0x10/0x20
[  143.600415]  [<ffffffff8109e4e1>] ? deactivate_task+0x71/0xb0
[  143.600415]  [<ffffffff8108edf1>] wq_worker_sleeping+0x11/0x90
[  143.600415]  [<ffffffff8158dbd0>] __schedule+0x640/0xa70
[  143.600415]  [<ffffffff8158e03c>] schedule+0x3c/0x90
[  143.600415]  [<ffffffff810795c8>] do_exit+0x768/0xae0
[  143.600415]  [<ffffffff8101976a>] oops_end+0x9a/0xd0
[  143.600415]  [<ffffffff81063bbc>] no_context+0x15c/0x380
[  143.600415]  [<ffffffff812d1d0c>] ? number.isra.11+0x2cc/0x2f0
[  143.600415]  [<ffffffff81063f08>] __bad_area_nosemaphore+0x128/0x230
[  143.600415]  [<ffffffff812c93f9>] ? idr_get_empty_slot+0x199/0x3b0
[  143.600415]  [<ffffffff81064023>] bad_area_nosemaphore+0x13/0x20
[  143.600415]  [<ffffffff81064482>] __do_page_fault+0x222/0x450
[  143.600415]  [<ffffffff812c8722>] ? get_from_free_list+0x42/0x50
[  143.600415]  [<ffffffff810646d2>] do_page_fault+0x22/0x30
[  143.600415]  [<ffffffff81593c88>] page_fault+0x28/0x30
[  143.600415]  [<ffffffff811c2df1>] ? __kmalloc_track_caller+0x91/0x230
[  143.600415]  [<ffffffff811c2d92>] ? __kmalloc_track_caller+0x32/0x230
[  143.600415]  [<ffffffff81180d23>] ? kstrdup_const+0x23/0x30
[  143.600415]  [<ffffffff81180cd1>] kstrdup+0x31/0x60
[  143.600415]  [<ffffffff81180d23>] kstrdup_const+0x23/0x30
[  143.600415]  [<ffffffff81256d18>] __kernfs_new_node+0x28/0xc0
[  143.600415]  [<ffffffff81257dc6>] kernfs_new_node+0x26/0x50
[  143.600415]  [<ffffffff81259853>] kernfs_create_link+0x23/0x80
[  143.600415]  [<ffffffff8125a526>] 
sysfs_do_create_link_sd.isra.0+0x66/0xc0
[  143.600415]  [<ffffffff8125a5a5>] sysfs_create_link+0x25/0x40
[  143.600415]  [<ffffffff813e8057>] device_add+0x2f7/0x690
[  143.600415]  [<ffffffff813e85e0>] device_create_groups_vargs+0xe0/0xf0
[  143.600415]  [<ffffffff813e86c6>] device_create_with_groups+0x46/0x60
[  143.600415]  [<ffffffffa038a442>] led_classdev_register+0xc2/0x200 
[led_class]
[  143.600415]  [<ffffffffa035085b>] ? sony_probe+0xa0b/0xf30 [hid_sony]
[  143.600415]  [<ffffffffa0350816>] sony_probe+0x9c6/0xf30 [hid_sony]
[  143.600415]  [<ffffffffa023eaa3>] hid_device_probe+0xd3/0x140 [hid]
[  143.600415]  [<ffffffff813eb652>] driver_probe_device+0x222/0x4a0
[  143.600415]  [<ffffffff813eb9d1>] __device_attach_driver+0x71/0xa0
[  143.600415]  [<ffffffff813eb960>] ? __driver_attach+0x90/0x90
[  143.600415]  [<ffffffff813e9367>] bus_for_each_drv+0x67/0xb0
[  143.600415]  [<ffffffff813eb32c>] __device_attach+0xdc/0x170
[  143.600415]  [<ffffffff813eba43>] device_initial_probe+0x13/0x20
[  143.600415]  [<ffffffff813ea5f2>] bus_probe_device+0x92/0xa0
[  143.600415]  [<ffffffff813e816c>] device_add+0x40c/0x690
[  143.600415]  [<ffffffff812679a1>] ? debugfs_create_file+0xb1/0xe0
[  143.600415]  [<ffffffffa023fb9b>] hid_add_device+0xdb/0x2a0 [hid]
[  143.600415]  [<ffffffff81188a5e>] ? kmalloc_order_trace+0x2e/0xe0
[  143.600415]  [<ffffffffa020132f>] ? usbhid_probe+0x23f/0x410 [usbhid]
[  143.600415]  [<ffffffffa02013d2>] usbhid_probe+0x2e2/0x410 [usbhid]
[  143.600415]  [<ffffffffa009d20d>] usb_probe_interface+0x1bd/0x300 
[usbcore]
[  143.600415]  [<ffffffff813eb652>] driver_probe_device+0x222/0x4a0
[  143.600415]  [<ffffffff813eb9d1>] __device_attach_driver+0x71/0xa0
[  143.600415]  [<ffffffff813eb960>] ? __driver_attach+0x90/0x90
[  143.600415]  [<ffffffff813e9367>] bus_for_each_drv+0x67/0xb0
[  143.600415]  [<ffffffff813eb32c>] __device_attach+0xdc/0x170
[  143.600415]  [<ffffffff813eba43>] device_initial_probe+0x13/0x20
[  143.600415]  [<ffffffff813ea5f2>] bus_probe_device+0x92/0xa0
[  143.600415]  [<ffffffff813e816c>] device_add+0x40c/0x690
[  143.600415]  [<ffffffffa009b056>] usb_set_configuration+0x516/0x8f0 
[usbcore]
[  143.600415]  [<ffffffffa00a5a5e>] generic_probe+0x2e/0x80 [usbcore]
[  143.600415]  [<ffffffffa009d012>] usb_probe_device+0x32/0x70 [usbcore]
[  143.600415]  [<ffffffff813eb652>] driver_probe_device+0x222/0x4a0
[  143.600415]  [<ffffffff813eb9d1>] __device_attach_driver+0x71/0xa0
[  143.600415]  [<ffffffff813eb960>] ? __driver_attach+0x90/0x90
[  143.600415]  [<ffffffff813e9367>] bus_for_each_drv+0x67/0xb0
[  143.600415]  [<ffffffff813eb32c>] __device_attach+0xdc/0x170
[  143.600415]  [<ffffffff813eba43>] device_initial_probe+0x13/0x20
[  143.600415]  [<ffffffff813ea5f2>] bus_probe_device+0x92/0xa0
[  143.600415]  [<ffffffff813e816c>] device_add+0x40c/0x690
[  143.600415]  [<ffffffff813c4913>] ? add_device_randomness+0xd3/0x140
[  143.600415]  [<ffffffffa00906bb>] usb_new_device+0x1cb/0x400 [usbcore]
[  143.600415]  [<ffffffffa0092238>] hub_event+0x978/0x1550 [usbcore]
[  143.600415]  [<ffffffff8108e21b>] process_one_work+0x14b/0x440
[  143.600415]  [<ffffffff8108e558>] worker_thread+0x48/0x4a0
[  143.600415]  [<ffffffff8108e510>] ? process_one_work+0x440/0x440
[  143.600415]  [<ffffffff81093ff8>] kthread+0xd8/0xf0
[  143.600415]  [<ffffffff81093f20>] ? kthread_worker_fn+0x170/0x170
[  143.600415]  [<ffffffff81591e8f>] ret_from_fork+0x3f/0x70
[  143.600415]  [<ffffffff81093f20>] ? kthread_worker_fn+0x170/0x170

