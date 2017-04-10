From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Crash caused by hid-rmi and no longer working touchscreen
Date: Mon, 10 Apr 2017 15:14:06 +0200
Message-ID: <b79b88c8-770a-13f6-5668-c3a94254e5e0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: aduggan@synaptics.com, jkosina@suse.cz, benjamin.tissoires@redhat.com
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

I'm having troubles with hid-rmi using 4.11-rc6. I'm getting some
"rmi_hid_read_block: timeout elapsed" errors and ultimately the
crash you can see at the end of this mail. I will reply to this
mail with a full log that shows all the errors.

The problem seems to be caused by commit 279967a65b320d174a507498ae
("HID: rmi: Handle all Synaptics touchpads using hid-rmi").

My laptop has a Synaptics touchpad and a Synaptics touchscreen.
Because of that commit, hid-rmi is used for both the devices, while
it has always been used only for the touchpad. Needless to say that
the touchscreen no longer works.

If I revert that commit, everything goes back to normal.

Regards,
Gabriele


[   21.980525] BUG: unable to handle kernel NULL pointer dereference at           (null)
[   21.983595] IP: rmi_driver_suspend+0x1a/0xb0
[   21.986607] PGD 0 

[   21.992538] Oops: 0000 [#1] SMP
[   21.995502] Modules linked in: iptable_nat nf_nat_ipv4 nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp tun bridge stp llc ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter bnep uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_core videodev media usbhid btusb btintel bluetooth lz4 lz4_compress zram binfmt_misc nls_utf8 nls_cp437 joydev dell_wmi sparse_keymap hid_rmi x86_pkg_temp_thermal intel_powerclamp coretemp iTCO_wdt iTCO_vendor_support kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel arc4 dell_laptop dell_smbios dcdbas iwlmvm aesni_intel mac80211 aes_x86_64 crypto_simd cryptd glue_helper sg psmouse serio_raw iwlwifi i2c_i801 cfg80211 rfkill snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_
 codec_generic
[   22.009157]  i2c_hid hid thermal wmi battery acpi_als kfifo_buf industrialio snd_hda_intel snd_hda_codec snd_hwdep snd_hda_core snd_pcm ehci_pci snd_timer sdhci_acpi ehci_hcd sdhci xhci_pci mmc_core i2c_designware_platform xhci_hcd i2c_designware_core evdev snd usbcore ac intel_rst soundcore usb_common lpc_ich mfd_core shpchp nf_nat_pptp nf_nat_proto_gre nf_conntrack_pptp nf_conntrack_proto_gre nf_nat nf_conntrack libcrc32c crc32c_intel parport_pc ppdev sunrpc lp parport ip_tables x_tables
[   22.020949] CPU: 2 PID: 235 Comm: kworker/2:2 Not tainted 4.11.0-rc6 #3
[   22.024941] Hardware name: Dell Inc. XPS13 9333/0HP75V, BIOS A07 03/27/2015
[   22.028979] Workqueue: pm pm_runtime_work
[   22.032935] task: ffff88021290c100 task.stack: ffffc900014b8000
[   22.036896] RIP: 0010:rmi_driver_suspend+0x1a/0xb0
[   22.040821] RSP: 0018:ffffc900014bbcb8 EFLAGS: 00010296
[   22.044726] RAX: 0000000000000000 RBX: ffff880200128000 RCX: 0000000000000004
[   22.048634] RDX: ffff880208a20018 RSI: 0000000000000000 RDI: ffff8802086c1400
[   22.052525] RBP: ffff8802086c1400 R08: ffff88020c674f70 R09: ffff88020c674f00
[   22.056400] R10: ffff88020e098020 R11: ffff88020e098020 R12: 0000000000000000
[   22.060273] R13: 0000000000000000 R14: 0000000000000402 R15: ffff8802128ffc00
[   22.064151] FS:  0000000000000000(0000) GS:ffff88021f300000(0000) knlGS:0000000000000000
[   22.068055] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   22.071963] CR2: 0000000000000000 CR3: 0000000002409000 CR4: 00000000001406e0
[   22.075887] Call Trace:
[   22.079750]  ? rmi_suspend+0x2b/0x60 [hid_rmi]
[   22.083571]  ? hid_suspend+0x16f/0x220 [usbhid]
[   22.087387]  ? usb_suspend_both+0x93/0x1c0 [usbcore]
[   22.091177]  ? usb_probe_interface+0x260/0x260 [usbcore]
[   22.094971]  ? usb_runtime_suspend+0x31/0x70 [usbcore]
[   22.098748]  ? __rpm_callback+0xc1/0x200
[   22.102513]  ? dequeue_entity+0xd9/0x210
[   22.106273]  ? rpm_callback+0x1f/0x70
[   22.110029]  ? usb_probe_interface+0x260/0x260 [usbcore]
[   22.113795]  ? rpm_suspend+0x119/0x620
[   22.117544]  ? __switch_to+0x20f/0x3e0
[   22.121280]  ? pm_runtime_work+0x6e/0x90
[   22.124989]  ? process_one_work+0x1f6/0x490
[   22.128674]  ? worker_thread+0x4a/0x4e0
[   22.132328]  ? kthread+0xf4/0x130
[   22.135931]  ? process_one_work+0x490/0x490
[   22.139562]  ? kthread_create_on_node+0x40/0x40
[   22.143197]  ? do_group_exit+0x3a/0xa0
[   22.146828]  ? ret_from_fork+0x26/0x40
[   22.150403] Code: 48 c7 c6 68 9a c1 81 48 89 ef e8 c2 fd f8 ff eb 9f 0f 1f 44 00 00 41 56 41 55 41 54 55 41 89 f4 53 4c 8b af 98 00 00 00 48 89 fd <49> 8b 45 00 49 39 c5 48 8d 98 08 fd ff ff 75 15 eb 78 48 8b 83 
[   22.154261] RIP: rmi_driver_suspend+0x1a/0xb0 RSP: ffffc900014bbcb8
[   22.158101] CR2: 0000000000000000
[   22.161893] ---[ end trace 574ac4af92a078af ]---
