From: Manuel Reimer <mail+linux-input@m-reimer.de>
Subject: Re: [PATCH] hid-sony: Prevent crash when rumble effects are still
 loaded at USB disconnect
Date: Mon, 30 May 2016 21:15:46 +0200
Message-ID: <d9be52d5-7aed-4852-a339-18eea3d346ed@m-reimer.de>
References: <a9a2689b-5af7-9676-67fd-5d911fcc9501@m-reimer.de>
 <856C5FBA-EA87-4D24-BB29-433FF5437518@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:34105 "EHLO mx2.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161663AbcE3TP7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 30 May 2016 15:15:59 -0400
In-Reply-To: <856C5FBA-EA87-4D24-BB29-433FF5437518@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Cameron Gutman <aicommander@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, jikos@kernel.org

On 05/29/2016 07:11 PM, Cameron Gutman wrote:
> What prevents one of the send_output_report() functions from accessin=
g sc->output_report_dmabuf after it=E2=80=99s been passed to kfree() bu=
t before you=E2=80=99ve set it to NULL? Why not simply wait to free out=
put_report_dmabuf until after hid_hw_stop returns?

Just moving the kfree to the end doesn't seem to be a good idea.

I did the following:

--- a/drivers/hid/hid-sony.c	2016-05-13 16:13:00.339346161 +0200
+++ b/drivers/hid/hid-sony.c	2016-05-30 20:28:39.897849164 +0200
@@ -2423,15 +2423,15 @@ static void sony_remove(struct hid_devic
  		sony_battery_remove(sc);
  	}

-	sony_cancel_work_sync(sc);
-
-	kfree(sc->output_report_dmabuf);
-
  	sony_remove_dev_list(sc);

  	sony_release_device_id(sc);

  	hid_hw_stop(hdev);
+
+	sony_cancel_work_sync(sc);
+
+	kfree(sc->output_report_dmabuf);
  }

Idea was: We know that hid_hw_stop will schedule work into our queue. S=
o=20
it seems to be a good idea to move sony_cancel_work_sync below that, to=
o=20
and kfree after that.

But now I have:

[  391.170091] BUG: unable to handle kernel NULL pointer dereference at=
=20
0000000000000030
[  391.303404] IP: [<ffffffffa0387eaf>] ml_effect_timer+0x1f/0x170=20
[ff_memless]
[  391.303404] PGD 3d3a5067 PUD 3d3a4067 PMD 0
[  391.303404] Oops: 0000 [#1] PREEMPT SMP
[  391.303404] Modules linked in: hid_sony ff_memless cfg80211 rfkill=20
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_6=
4=20
lrw gf128mul glue_helper ablk_helper cryptd input_leds psmouse ppdev=20
acpi_cpufreq pcspkr led_class joydev serio_raw mousedev tpm_tis tpm=20
parport_pc mac_hid fjes parport intel_agp intel_gtt e1000 battery video=
=20
evdev button processor i2c_piix4 ac sch_fq_codel vboxvideo(O) ttm=20
drm_kms_helper drm syscopyarea sysfillrect sysimgblt fb_sys_fops=20
vboxsf(O) vboxguest(O) ip_tables x_tables xfs libcrc32c hid_generic=20
usbhid hid sr_mod cdrom sd_mod ata_generic pata_acpi atkbd libps2=20
crc32c_intel ahci libahci ohci_pci ohci_hcd ata_piix usbcore usb_common=
=20
libata scsi_mod i8042 serio
[  391.303404] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G           O=20
4.5.4-1-ARCH #1
[  391.303404] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS=20
VirtualBox 12/01/2006
[  391.303404] task: ffffffff81811500 ti: ffffffff81800000 task.ti:=20
ffffffff81800000
[  391.303404] RIP: 0010:[<ffffffffa0387eaf>]  [<ffffffffa0387eaf>]=20
ml_effect_timer+0x1f/0x170 [ff_memless]
[  391.303404] RSP: 0018:ffff88003fc03e60  EFLAGS: 00010246
[  421.393551] ata2: lost interrupt (Status 0x58)
[  421.393601] ata2: drained 8 bytes to clear DRQ
[  421.393611] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x=
6=20
frozen
[  421.393623] ata2.00: cmd a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0=20
pio 16392 in
[  421.393623]          opcode=3D0x4a 4a 01 00 00 10 00 00 00 08 00res=20
40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
[  421.393627] ata2.00: status: { DRDY }
[  421.393789] ata2: soft resetting link
[  421.550864] ata2.00: configured for UDMA/33
[  426.550330] ata2.00: qc timeout (cmd 0xa0)
[  426.550342] ata2.00: TEST_UNIT_READY failed (err_mask=3D0x5)
[  426.550519] ata2: soft resetting link
[  426.705035] ata2.00: configured for UDMA/33
[  431.703725] ata2.00: qc timeout (cmd 0xa0)
[  431.703736] ata2.00: TEST_UNIT_READY failed (err_mask=3D0x5)
[  431.703744] ata2.00: limiting speed to UDMA/33:PIO3
[  431.703994] ata2: soft resetting link
[  431.858270] ata2.00: configured for UDMA/33
[  436.856832] ata2.00: qc timeout (cmd 0xa0)
[  436.856840] ata2.00: TEST_UNIT_READY failed (err_mask=3D0x5)
[  436.856846] ata2.00: disabled
[  436.857022] ata2: soft resetting link
[  437.010167] ata2: EH complete
[  421.547203] RAX: 0000000000000000 RBX: ffff88003d08f000 RCX:=20
ffff88003fc03ed8
[  421.547203] RDX: ffff88003d08f000 RSI: ffffffffa0387e90 RDI:=20
ffff88003d08f000
[  421.547203] RBP: ffff88003fc03e78 R08: ffff88003ceaee00 R09:=20
0000000000000000
[  421.547203] R10: 0000000000000020 R11: 0000000000000000 R12:=20
ffff880037a47710
[  421.547203] R13: 0000000000000101 R14: ffffffffa0387e90 R15:=20
ffff88003d08f000
[  421.547203] FS:  00007fba4be63700(0000) GS:ffff88003fc00000(0000)=20
knlGS:0000000000000000
[  421.547203] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  421.547203] CR2: 0000000000000030 CR3: 000000003d3a2000 CR4:=20
00000000000406f0
[  421.547203] Stack:
[  421.547203]  ffff88003fc0dbc0 ffff880037a47710 0000000000000101=20
ffff88003fc03eb0
[  421.547203]  ffffffff810e3cc5 ffff88003fc0dbc0 ffff880037a47710=20
ffffffffa0387e90
[  421.547203]  0000000000000000 0000000000000001 ffff88003fc03f10=20
ffffffff810e4016
[  421.547203] Call Trace:
[  421.547203]  <IRQ>
[  421.547203]  [<ffffffff810e3cc5>] call_timer_fn+0x35/0x150
[  421.547203]  [<ffffffffa0387e90>] ? ml_ff_playback+0x100/0x100=20
[ff_memless]
[  421.547203]  [<ffffffff810e4016>] run_timer_softirq+0x236/0x2e0
[  421.547203]  [<ffffffff8107d3e6>] __do_softirq+0xe6/0x2f0
[  421.547203]  [<ffffffff8107d763>] irq_exit+0xa3/0xb0
[  421.547203]  [<ffffffff815b8112>] smp_apic_timer_interrupt+0x42/0x50
[  421.547203]  [<ffffffff815b63f2>] apic_timer_interrupt+0x82/0x90
[  421.547203]  <EOI>
[  421.547203]  [<ffffffff8105f896>] ? native_safe_halt+0x6/0x10
[  421.547203]  [<ffffffff81021c30>] default_idle+0x20/0x110
[  421.547203]  [<ffffffff8102246f>] arch_cpu_idle+0xf/0x20
[  421.547203]  [<ffffffff810baf0a>] default_idle_call+0x2a/0x40
[  421.547203]  [<ffffffff810bb264>] cpu_startup_entry+0x344/0x3b0
[  421.547203]  [<ffffffff815a8c19>] rest_init+0x89/0x90
[  421.547203]  [<ffffffff8190c012>] start_kernel+0x46a/0x48b
[  421.547203]  [<ffffffff8190b120>] ? early_idt_handler_array+0x120/0x=
120
[  421.547203]  [<ffffffff8190b332>] x86_64_start_reservations+0x2a/0x2=
c
[  421.547203]  [<ffffffff8190b480>] x86_64_start_kernel+0x14c/0x16f
[  421.547203] Code: a0 e8 06 fa f7 e0 eb a3 0f 1f 40 00 0f 1f 44 00 00=
=20
55 f6 05 d5 11 00 00 04 48 89 e5 41 55 41 54 53 48 8b 87 f8 00 00 00 48=
=20
89 fb <4c> 8b 68 30 75 2c 48 81 c3 10 02 00 00 48 89 df e8 bc d1 22 e1
[  421.547203] RIP  [<ffffffffa0387eaf>] ml_effect_timer+0x1f/0x170=20
[ff_memless]
[  421.547203]  RSP <ffff88003fc03e60>
[  421.547203] CR2: 0000000000000030
[  421.547203] ---[ end trace 7a664affc45468fa ]---
[  421.547203] Kernel panic - not syncing: Fatal exception in interrupt
[  421.547203] Kernel Offset: disabled
[  421.547203] ---[ end Kernel panic - not syncing: Fatal exception in=20
interrupt

This was some kind of "brute force attempt" to check the stability.

I opened fftest, then I started effect "4" over and over again to get=20
the queue in ff_memless filled up. Then I pulled the USB plug.

It may now actually be possible that the memory has been freed again an=
d=20
some event in the queue kicked in after that. It may also be possible=20
that the hid driver subsystem doesn't really like this case, that the=20
device is stopped, but someone still sends to it.

Same with xpad driver:
[   64.957349] xpad 1-2:1.0: xpad_try_sending_next_out_packet -=20
usb_submit_urb failed with result -19
[   66.148685] xpad 1-2:1.0: xpad_try_sending_next_out_packet -=20
usb_submit_urb failed with result -19
[   66.292505] xpad 1-2:1.0: xpad_try_sending_next_out_packet -=20
usb_submit_urb failed with result -19
[   66.336855] xpad 1-2:1.0: xpad_try_sending_next_out_packet -=20
usb_submit_urb failed with result -19



Manuel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
