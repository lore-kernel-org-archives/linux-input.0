From: Laura Abbott <labbott@redhat.com>
Subject: [REGRESSION] panic with Wacom One Tablet on 4.4.x kernel
Date: Wed, 16 Mar 2016 15:07:37 -0700
Message-ID: <56E9D929.70101@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:33967 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578AbcCPWHm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2016 18:07:42 -0400
Received: by mail-qg0-f53.google.com with SMTP id w104so56291547qge.1
        for <linux-input@vger.kernel.org>; Wed, 16 Mar 2016 15:07:41 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pingc@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

Hi,

Fedora received a bug report (https://bugzilla.redhat.com/show_bug.cgi?id=1317116)
of a panic when plugging in a Wacom One Tablet on a 4.4.4 based kernel. This is
new behavior from the 4.3 based kernel:

[  142.144016] usb 2-2: new full-speed USB device number 2 using uhci_hcd
[  142.502041] usb 2-2: New USB device found, idVendor=056a, idProduct=0300
[  142.502047] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[  142.502051] usb 2-2: Product: CTL-471
[  142.502054] usb 2-2: Manufacturer: Wacom Co.,Ltd.
[  142.584064] input: Wacom Bamboo One S Pen as /devices/pci0000:00/0000:00:1d.0/usb2/2-2/2-2:1.0/0003:056A:0300.0002/input/input9
[  142.584426] wacom 0003:056A:0300.0002: hidraw1: USB HID v1.10 Mouse [Wacom Co.,Ltd. CTL-471] on usb-0000:00:1d.0-2/input0
[  142.587219] wacom 0003:056A:0300.0003: Unknown device_type for 'Wacom Co.,Ltd. CTL-471'. Assuming pen.
[  142.587277] input: Wacom Bamboo One S Pen as /devices/pci0000:00/0000:00:1d.0/usb2/2-2/2-2:1.1/0003:056A:0300.0003/input/input12
[  142.587465] wacom 0003:056A:0300.0003: hidraw2: USB HID v1.10 Device [Wacom Co.,Ltd. CTL-471] on usb-0000:00:1d.0-2/input1
[  142.588040] wacom 0003:056A:0300.0003: wacom_set_report: ran out of retries (last error = -32)
[  144.279058] BUG: unable to handle kernel NULL pointer dereference at 0000000000000030
[  144.279127] IP: [<ffffffff815d7b0d>] input_event+0xd/0x80
[  144.279171] PGD 7998e067 PUD 7990e067 PMD 0
[  144.279210] Oops: 0000 [#1] SMP
[  144.279240] Modules linked in: wacom fuse nf_conntrack_netbios_ns nf_conntrack_broadcast ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 xt_conntrack ebtable_nat ebtable_broute bridge ebtable_filter ebtables ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle ip6table_security ip6table_raw ip6table_filter ip6_tables iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_mangle iptable_security iptable_raw coretemp kvm_intel kvm ppdev snd_hda_codec_realtek irqbypass snd_hda_codec_generic snd_hda_intel snd_hda_codec iTCO_wdt gpio_ich iTCO_vendor_support snd_hda_core snd_hwdep parport_pc shpchp snd_seq snd_seq_device lpc_ich parport snd_pcm i2c_i801 ite_cir rc_core snd_timer snd tpm_infineon soundcore acpi_cpufreq tpm_tis tpm nfsd auth_rpcgss nf
 s_acl lockd
[  144.279870]  grace sunrpc i915 video i2c_algo_bit drm_kms_helper drm 8021q serio_raw garp stp ata_generic llc pata_acpi mrp r8169 mii fjes
[  144.279992] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.4.4-200.fc22.x86_64 #1
[  144.280024] Hardware name: Acer Veriton Series/G41MXE/G41MXE-K, BIOS 080015  01/14/2011
[  144.280024] task: ffff88007a8f0000 ti: ffff88007a8f8000 task.ti: ffff88007a8f8000
[  144.280024] RIP: 0010:[<ffffffff815d7b0d>]  [<ffffffff815d7b0d>] input_event+0xd/0x80
[  144.280024] RSP: 0018:ffff88007da83bc8  EFLAGS: 00010097
[  144.280024] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000000
[  144.280024] RDX: 0000000000000116 RSI: 0000000000000001 RDI: 0000000000000000
[  144.280024] RBP: ffff88007da83c10 R08: 0000000000000002 R09: 0000000180490017
[  144.280024] R10: ffff88005c958ab8 R11: 0000000037f88e94 R12: ffff8800463d7010
[  144.280024] R13: 0000000000000001 R14: 0000000000000000 R15: ffff8800463d7152
[  144.280024] FS:  0000000000000000(0000) GS:ffff88007da80000(0000) knlGS:0000000000000000
[  144.280024] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  144.280024] CR2: 0000000000000030 CR3: 0000000069d09000 CR4: 00000000000406e0
[  144.280024] Stack:
[  144.280024]  ffffffffa05c98ad 0000000000000400 0000000000000000 ffff8800463d7150
[  144.280024]  0000000000000040 0000000000000022 ffff88006a864000 ffff8800463d7010
[  144.280024]  ffff88006a8658d0 ffff88007da83c88 ffffffffa05cd9e2 0000000000000001
[  144.280024] Call Trace:
[  144.280024]  <IRQ>
[  144.280024]  [<ffffffffa05c98ad>] ? wacom_bpt3_touch+0x23d/0x330 [wacom]
[  144.280024]  [<ffffffffa05cd9e2>] wacom_wac_irq+0x13d2/0x2360 [wacom]
[  144.280024]  [<ffffffff8120db2b>] ? __slab_free+0xcb/0x250
[  144.280024]  [<ffffffffa05cfb43>] wacom_raw_event+0x93/0xc0 [wacom]
[  144.280024]  [<ffffffff81646223>] hid_input_report+0x143/0x170
[  144.280024]  [<ffffffff8165156c>] hid_irq_in+0xbc/0x220
[  144.280024]  [<ffffffff815829f5>] __usb_hcd_giveback_urb+0x85/0x130
[  144.280024]  [<ffffffff81582bcb>] usb_hcd_giveback_urb+0x3b/0xd0
[  144.280024]  [<ffffffff815af1fe>] uhci_giveback_urb+0x9e/0x270
[  144.280024]  [<ffffffff810d352f>] ? sched_clock_cpu+0x7f/0xa0
[  144.280024]  [<ffffffff815b1304>] uhci_scan_schedule.part.33+0x6b4/0xbe0
[  144.280024]  [<ffffffff815b1ed6>] uhci_irq+0xc6/0x170
[  144.280024]  [<ffffffff81581d16>] usb_hcd_irq+0x26/0x40
[  144.280024]  [<ffffffff810fc6da>] handle_irq_event_percpu+0x8a/0x1d0
[  144.280024]  [<ffffffff810fc84c>] handle_irq_event+0x2c/0x50
[  144.280024]  [<ffffffff810ffae4>] handle_fasteoi_irq+0x84/0x150
[  144.280024]  [<ffffffff81019dc3>] handle_irq+0x73/0x120
[  144.280024]  [<ffffffff810c35ea>] ? atomic_notifier_call_chain+0x1a/0x20
[  144.280024]  [<ffffffff817a2b7b>] do_IRQ+0x4b/0xd0
[  144.280024]  [<ffffffff817a0bc7>] common_interrupt+0x87/0x87
[  144.280024]  <EOI>
[  144.280024]  [<ffffffff81021e66>] ? mwait_idle+0x76/0x180
[  144.280024]  [<ffffffff8102243f>] arch_cpu_idle+0xf/0x20
[  144.280024]  [<ffffffff810e656a>] default_idle_call+0x2a/0x40
[  144.280024]  [<ffffffff810e68d1>] cpu_startup_entry+0x2f1/0x350
[  144.280024]  [<ffffffff81050307>] start_secondary+0x157/0x190
[  144.280024] Code: e2 41 c1 fc 02 e9 c9 fd ff ff 31 c0 e9 fa fd ff ff b9 05 00 00 00 e9 60 fc ff ff 0f 1f 00 66 66 66 66 90 83 fe 1f 76 01 c3 89 f0 <48> 0f a3 47 30 19 c0 85 c0 74 f2 55 48 89 e5 41 57 4c 8d bf 18
[  144.280024] RIP  [<ffffffff815d7b0d>] input_event+0xd/0x80
[  144.280024]  RSP <ffff88007da83bc8>
[  144.280024] CR2: 0000000000000030

Any ideas before I ask the reporter to do a bisect?

Thanks,
Laura
