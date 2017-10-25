From: Marc Di Luzio <mdiluzio@feralinteractive.com>
Subject: PROBLEM: Driver crash when unplugging G920 wheel
Date: Wed, 25 Oct 2017 16:28:41 +0100
Message-ID: <CA+X5c0_w2SrKgsfNQDxKpyLtfXGA_Vr-p2=Bv6Y8EUDt6Nr0iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:56347 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932204AbdJYP3D (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 25 Oct 2017 11:29:03 -0400
Received: by mail-io0-f180.google.com with SMTP id m81so1388967ioi.13
        for <linux-input@vger.kernel.org>; Wed, 25 Oct 2017 08:29:03 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: e.velds@gmail.com, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Ahsan Fayaz <afayaz@feralinteractive.com>

[ 2nd attempt at sending, caught for HTML usage in the first ]

We've found a crash in the hid-logitech-hidpp driver when unplugging
the Logitech G920 wheel while using force feedback events.

The rough order of events looks like:
1. An FF effect is sent to the device
2. The effect is played on the device
3. The wheel is unplugged, simulating an accidental disconnect
4. The driver crashes
5. The wheel is now unusable until the next reboot

After speaking with Benjamin this appears to be a code issue in
current HEAD caused by a lack of guards for the device being removed
in the effect handling code.

Below is dmesg output of the crash, I can also separately provide an
example code file to reproduce the issue as I believe it would be too
long for the mailing list.

Cheers,

dmesg output:
[ 1674.982462] usb 3-11: USB disconnect, device number 6
[ 1674.982607] logitech-hidpp-device 0003:046D:C262.0003: Unloading
HID++ force feedback.
[ 1686.599924] usb 3-11: new full-speed USB device number 7 using xhci_hcd
[ 1686.769719] usb 3-11: New USB device found, idVendor=046d, idProduct=c261
[ 1686.769721] usb 3-11: New USB device strings: Mfr=1, Product=2,
SerialNumber=3
[ 1686.769723] usb 3-11: Product: G920 Driving Force Racing Wheel for Xbox One
[ 1686.769725] usb 3-11: Manufacturer: Logitech
[ 1686.769726] usb 3-11: SerialNumber: 00006676888f8554
[ 1687.782552] usb 3-11: USB disconnect, device number 7
[ 1688.360828] usb 3-11: new full-speed USB device number 8 using xhci_hcd
[ 1688.530457] usb 3-11: New USB device found, idVendor=046d, idProduct=c262
[ 1688.530459] usb 3-11: New USB device strings: Mfr=1, Product=2,
SerialNumber=3
[ 1688.530461] usb 3-11: Product: G920 Driving Force Racing Wheel for Xbox One
[ 1688.530462] usb 3-11: Manufacturer: Logitech
[ 1688.530463] usb 3-11: SerialNumber: 00006676888f8554
[ 1688.533045] input: Logitech G920 Driving Force Racing Wheel for
Xbox One as /devices/pci0000:00/0000:00:14.0/usb3/3-11/3-11:1.0/0003:046D:C262.0004/input/input16
[ 1688.533343] logitech-hidpp-device 0003:046D:C262.0004:
input,hiddev97,hidraw2: USB HID v1.11 Joystick [Logitech G920 Driving
Force Racing Wheel for Xbox One] on usb-0000:00:14.0-11/input0
[ 1688.587605] logitech-hidpp-device 0003:046D:C262.0004: HID++ 4.2
device connected.
[ 1688.604105] logitech-hidpp-device 0003:046D:C262.0004: Force
feeback support loaded (firmware release 3).
[ 3009.708686] usb 3-11: USB disconnect, device number 8
[ 3009.708854] logitech-hidpp-device 0003:046D:C262.0004: Unloading
HID++ force feedback.
[ 3009.710221] BUG: unable to handle kernel NULL pointer dereference
at           (null)
[ 3009.710239] IP: __queue_work+0x1a9/0x3f0
[ 3009.710243] PGD 0
[ 3009.710245] P4D 0
[ 3009.710253] Oops: 0000 [#1] SMP
[ 3009.710257] Modules linked in: hid_logitech_hidpp dm_crypt rfcomm
fuse xt_CHECKSUM ipt_MASQUERADE nf_nat_masquerade_ipv4 tun
nf_conntrack_netbios_ns nf_conntrack_broadcast xt_CT ip6t_rpfilter
ip6t_REJECT nf_reject_ipv6 xt_conntrack ip_set nfnetlink ebtable_nat
ebtable_broute bridge stp llc ip6table_nat nf_conntrack_ipv6
nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle ip6table_raw
ip6table_security iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4
nf_nat_ipv4 nf_nat nf_conntrack libcrc32c iptable_mangle iptable_raw
iptable_security ebtable_filter ebtables ip6table_filter ip6_tables
bnep sunrpc vfat fat intel_rapl x86_pkg_temp_thermal intel_powerclamp
coretemp kvm_intel kvm irqbypass nvidia_drm(POE) nvidia_modeset(POE)
crct10dif_pclmul nvidia(POE) crc32_pclmul ghash_clmulni_intel arc4
intel_cstate intel_uncore
[ 3009.710339]  joydev intel_rapl_perf snd_hda_codec_realtek
drm_kms_helper iwlmvm snd_hda_codec_generic btusb snd_hda_codec_hdmi
snd_hda_intel snd_hda_codec snd_hda_core btrtl mac80211 drm btbcm
dcdbas iTCO_wdt iTCO_vendor_support btintel iwlwifi cfg80211 bluetooth
snd_seq snd_hwdep snd_seq_device ecdh_generic snd_pcm snd_timer rfkill
snd lpc_ich soundcore mei_me mei i2c_i801 shpchp uas usb_storage
crc32c_intel r8169 mii video
[ 3009.710413] CPU: 0 PID: 343 Comm: kworker/0:3 Tainted: P
OE   4.13.5-200.fc26.x86_64 #1
[ 3009.710418] Hardware name: Dell Inc. XPS 8700/0KWVT8, BIOS A08 04/16/2014
[ 3009.710430] Workqueue: usb_hub_wq hub_event
[ 3009.710437] task: ffff8fe9b6668000 task.stack: ffffbabe83b18000
[ 3009.710446] RIP: 0010:__queue_work+0x1a9/0x3f0
[ 3009.710451] RSP: 0018:ffffbabe83b1b808 EFLAGS: 00010046
[ 3009.710458] RAX: 0000000000000000 RBX: ffff8fe95476dc00 RCX: ffffffff86d3e3e0
[ 3009.710464] RDX: ffff8fe8da7ebe40 RSI: 000000007fffffff RDI: ffff8fe8da7ebe40
[ 3009.710470] RBP: ffffbabe83b1b848 R08: 0000000000000002 R09: ffff8fe9be003680
[ 3009.710474] R10: ffffbabe83b1b910 R11: 0000000000000001 R12: 0000000000000000
[ 3009.710478] R13: 0000000000014720 R14: ffff8fe8da7ebe40 R15: 0000000000000000
[ 3009.710482] FS:  0000000000000000(0000) GS:ffff8fe9dec00000(0000)
knlGS:0000000000000000
[ 3009.710486] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3009.710489] CR2: 0000000000000000 CR3: 00000007f931a000 CR4: 00000000001406f0
[ 3009.710492] Call Trace:
[ 3009.710502]  queue_work_on+0x38/0x40
[ 3009.710513]  hidpp_ff_queue_work+0xbf/0x1b0 [hid_logitech_hidpp]
[ 3009.710520]  hidpp_ff_playback+0x57/0xb0 [hid_logitech_hidpp]
[ 3009.710528]  erase_effect+0x79/0xf0
[ 3009.710533]  flush_effects+0x49/0x90
[ 3009.710541]  input_flush_device+0x40/0x60
[ 3009.710547]  evdev_cleanup+0xa6/0xc0
[ 3009.710552]  evdev_disconnect+0x32/0x60
[ 3009.710557]  __input_unregister_device+0xb3/0x180
[ 3009.710562]  input_unregister_device+0x47/0x60
[ 3009.710571]  hidinput_disconnect+0x85/0xf0
[ 3009.710577]  hid_disconnect+0x5e/0x70
[ 3009.710581]  hid_hw_stop+0x12/0x30
[ 3009.710587]  hidpp_remove+0x40/0xd0 [hid_logitech_hidpp]
[ 3009.710593]  hid_device_remove+0x68/0xd0
[ 3009.710602]  device_release_driver_internal+0x158/0x210
[ 3009.710607]  device_release_driver+0x12/0x20
[ 3009.710612]  bus_remove_device+0xe9/0x160
[ 3009.710617]  device_del+0x1d2/0x350
[ 3009.710623]  hid_destroy_device+0x27/0x60
[ 3009.710629]  usbhid_disconnect+0x4a/0x60
[ 3009.710635]  usb_unbind_interface+0x72/0x280
[ 3009.710642]  device_release_driver_internal+0x158/0x210
[ 3009.710647]  device_release_driver+0x12/0x20
[ 3009.710652]  bus_remove_device+0xe9/0x160
[ 3009.710656]  device_del+0x1d2/0x350
[ 3009.710661]  usb_disable_device+0x9f/0x270
[ 3009.710667]  usb_disconnect+0xc6/0x260
[ 3009.710673]  hub_event+0x586/0x15e0
[ 3009.710680]  process_one_work+0x193/0x3c0
[ 3009.710685]  worker_thread+0x4a/0x3a0
[ 3009.710694]  kthread+0x125/0x140
[ 3009.710699]  ? process_one_work+0x3c0/0x3c0
[ 3009.710705]  ? kthread_park+0x60/0x60
[ 3009.710713]  ? do_syscall_64+0x67/0x140
[ 3009.710724]  ret_from_fork+0x25/0x30
[ 3009.710729] Code: ff 49 63 44 05 00 83 f8 ff 0f 84 75 01 00 00 48
8d 84 c3 10 01 00 00 4c 89 f7 4c 8b 38 e8 b0 f8 ff ff 48 85 c0 0f 85
fb fe ff ff <49> 8b 07 e9 fc fe ff ff 65 8b 15 a0 ad f4 79 89 d2 48 0f
a3 15
[ 3009.710834] RIP: __queue_work+0x1a9/0x3f0 RSP: ffffbabe83b1b808
[ 3009.710837] CR2: 0000000000000000
[ 3009.710842] ---[ end trace 58b4c185356eb7f7 ]---

-----
Marc Di Luzio
Linux Group Lead @ Feral Interactive Ltd.
