From: Jonathan Beilharz <greenbigfrog@gmail.com>
Subject: X-Box one controller causes Xpad to crash
Date: Wed, 11 Nov 2015 18:47:40 +0100
Message-ID: <56437F3C.6070408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:33356 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414AbbKKRro (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Nov 2015 12:47:44 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org

X-Box one controller causes Xpad to crash

As soon as I plug in my original Xbox One controller the Xpad module 
crashes.

Originally found with 3.19.0-32 on Ubuntu 15.04 and confirmed with 
upstream (4.3).

Doesn't exist on a 14.04 system running 3.13.0-67.


Part of dmesg:

[   93.999873] usb 1-13: new full-speed USB device number 5 using xhci_hcd
[   94.129124] usb 1-13: New USB device found, idVendor=045e, idProduct=02dd
[   94.129132] usb 1-13: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   94.129136] usb 1-13: Product: Controller
[   94.129140] usb 1-13: Manufacturer: Microsoft
[   94.129143] usb 1-13: SerialNumber: 7EED8342D723
[   94.155148] input: Generic X-Box pad as /devices/pci0000:00/0000:00:14.0/usb1/1-13/1-13:1.0/input/input20
[   94.155314] BUG: unable to handle kernel NULL pointer dereference at 000000000000004e
[   94.155319] IP: [<ffffffffc070c41d>] xpad_probe+0x33d/0x9d0 [xpad]
[   94.155325] PGD 0
[   94.155328] Oops: 0000 [#1] SMP
[   94.155330] Modules linked in: xpad(+) ff_memless nfsv3 nfs_acl rpcsec_gss_krb5 auth_rpcgss nfsv4 nfs lockd grace fscache pci_stub vboxpci(OE) vboxnetadp(OE) vboxnetflt(OE) binfmt_misc vboxdrv(OE) cfg80211 nls_iso8859_1 snd_hda_codec_hdmi nvidia(POE) snd_hda_codec_realtek snd_hda_codec_generic intel_rapl joydev iosf_mbi eeepc_wmi asus_wmi x86_pkg_temp_thermal snd_hda_intel sparse_keymap intel_powerclamp snd_hda_controller snd_hda_codec coretemp snd_hwdep kvm_intel snd_pcm kvm snd_seq_midi snd_seq_midi_event dm_multipath crct10dif_pclmul scsi_dh snd_rawmidi crc32_pclmul ghash_clmulni_intel snd_seq aesni_intel snd_seq_device drm snd_timer aes_x86_64 lrw gf128mul glue_helper snd ablk_helper cryptd soundcore shpchp mei_me serio_raw mei lpc_ich 8250_fintek wmi video mac_hid sunrpc ppdev lp p
 arport autofs4
[   94.155372]  hid_generic uas usb_storage hid_cherry usbhid hid psmouse r8169 ahci libahci mii dm_mirror dm_region_hash dm_log [last unloaded: parport_pc]
[   94.155382] CPU: 0 PID: 4136 Comm: systemd-udevd Tainted: P           OE  3.19.0-32-generic #37-Ubuntu
[   94.155384] Hardware name: ASUS All Series/H87M-PRO, BIOS 2102 10/28/2014
[   94.155385] task: ffff8803e58975c0 ti: ffff8800bfd30000 task.ti: ffff8800bfd30000
[   94.155386] RIP: 0010:[<ffffffffc070c41d>]  [<ffffffffc070c41d>] xpad_probe+0x33d/0x9d0 [xpad]
[   94.155390] RSP: 0018:ffff8800bfd33b38  EFLAGS: 00010206
[   94.155391] RAX: ffff8803cde56480 RBX: ffff8803cbdd0100 RCX: 0000000000000000
[   94.155393] RDX: 0000000000000048 RSI: 0000000000000008 RDI: ffff8800d2d93000
[   94.155394] RBP: ffff8800bfd33b88 R08: ffff8800d2cac060 R09: ffffffff815bf5fe
[   94.155395] R10: ffff8803cde56480 R11: ffffea00101e3c00 R12: ffff8800d2d93090
[   94.155396] R13: 000000000000005e R14: 0000000000000001 R15: ffff88040a5ed800
[   94.155398] FS:  00007f05f22e8880(0000) GS:ffff88041dc00000(0000) knlGS:0000000000000000
[   94.155399] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   94.155400] CR2: 000000000000004e CR3: 00000000d264d000 CR4: 00000000001407f0
[   94.155401] Stack:
[   94.155402]  ffff8800bfd33b88 ffffffff815137ca ffff8800d2d93000 ffff8803d9aec000
[   94.155405]  ffffffffc070f0a8 ffff8800d2d93090 ffff8800d2d93000 ffffffffc070f0a8
[   94.155407]  ffff8803d9aec030 ffffffffc070f1e0 ffff8800bfd33bd8 ffffffff815c510b
[   94.155409] Call Trace:
[   94.155414]  [<ffffffff815137ca>] ? __pm_runtime_set_status+0x14a/0x250
[   94.155419]  [<ffffffff815c510b>] usb_probe_interface+0x1bb/0x300
[   94.155422]  [<ffffffff815084b5>] driver_probe_device+0xb5/0x430
[   94.155424]  [<ffffffff8150890b>] __driver_attach+0x9b/0xa0
[   94.155426]  [<ffffffff81508870>] ? __device_attach+0x40/0x40
[   94.155429]  [<ffffffff8150623b>] bus_for_each_dev+0x6b/0xb0
[   94.155431]  [<ffffffff81507eee>] driver_attach+0x1e/0x20
[   94.155433]  [<ffffffff81507ac0>] bus_add_driver+0x180/0x250
[   94.155435]  [<ffffffff81509104>] driver_register+0x64/0xf0
[   94.155437]  [<ffffffff815c38f2>] usb_register_driver+0x82/0x160
[   94.155440]  [<ffffffffc0400000>] ? 0xffffffffc0400000
[   94.155443]  [<ffffffffc040001e>] xpad_driver_init+0x1e/0x1000 [xpad]
[   94.155447]  [<ffffffff81002148>] do_one_initcall+0xd8/0x210
[   94.155452]  [<ffffffff811d7689>] ? kmem_cache_alloc_trace+0x189/0x200
[   94.155455]  [<ffffffff810faec8>] ? load_module+0x15b8/0x1d00
[   94.155458]  [<ffffffff810faf02>] load_module+0x15f2/0x1d00
[   94.155460]  [<ffffffff810f66c0>] ? store_uevent+0x40/0x40
[   94.155463]  [<ffffffff810fb786>] SyS_finit_module+0x86/0xb0
[   94.155467]  [<ffffffff817cc0cd>] system_call_fastpath+0x16/0x1b
[   94.155468] Code: 31 d2 83 bb d4 00 00 00 03 4c 8b 43 50 48 8b 4f 08 48 8b 7b 08 0f 95 c2 48 8d 34 d5 00 00 00 00 48 8b 49 18 48 01 f2 48 8d 14 d1 <0f> b6 72 06 0f b6 52 02 c1 e2 0f 89 d1 8b 17 48 89 78 48 81 c9
[   94.155490] RIP  [<ffffffffc070c41d>] xpad_probe+0x33d/0x9d0 [xpad]
[   94.155493]  RSP <ffff8800bfd33b38>
[   94.155494] CR2: 000000000000004e
[   94.155496] ---[ end trace cf1c328cbab6cdf4 ]---


Originally reported on launchpad: 
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1514505


