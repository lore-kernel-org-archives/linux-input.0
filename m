From: Johannes Ebke <johannes.ebke@physik.uni-muenchen.de>
Subject: Re: Linux Force Feedback for Saitek Cyborg Evo Force
Date: Sun, 20 Dec 2009 00:36:23 +0100
Message-ID: <4B2D6377.1020703@physik.uni-muenchen.de>
References: <4B26B824.8010403@physik.uni-muenchen.de> <alpine.LNX.2.00.0912151403440.3755@pobox.suse.cz> <4B2ABC62.2030600@physik.uni-muenchen.de> <alpine.LNX.2.00.0912181150240.3755@pobox.suse.cz> <20091218175046.GB23450@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030302060004070103020105"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.physik.uni-muenchen.de ([192.54.42.129]:60388 "EHLO
	mail.physik.uni-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754072AbZLSXg0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Dec 2009 18:36:26 -0500
In-Reply-To: <20091218175046.GB23450@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

This is a multi-part message in MIME format.
--------------030302060004070103020105
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

It seems that the force feedback works well, I have ported the force
feedback for my favorite game to linux now, and it works well.

What does not work is updating effects - there just nothing happens, and
the old event is played. I have circumvented this by
deleting/re-uploading the effect, but this should probably been made to
work. Does it work well with other hardware?

Thirdly, I have re-discovered one kernel oops that occurs if the
joystick is unplugged if some process still has the event device open.
Steps to reproduce:
* plug joystick in
* fftest /dev/input/eventXX
* unplug joystick

(kern.log extract attached)

Sometimes this just gives an oops, sometimes it escalates into a kernel
panic.

Finally, attached is the most recent patch (saitek-v2.patch):
* handling of 0x06 (saitek?) message format for axis/button data
* Saitek Cyborg Evo Force button+axis definitions and table entry
* Changes axis limits if hardware is from Saitek
* Added has_btndead to iforce_device + table entries
* Only add BTN_DEAD if iforce device has_btndead
(since my joystick does not have a physical dead switch)

The patch is against 2.6.32 from kernel.org.

Cheers,
Johannes

Dmitry Torokhov wrote:
> On Fri, Dec 18, 2009 at 11:52:32AM +0100, Jiri Kosina wrote:
>> On Fri, 18 Dec 2009, Johannes Ebke wrote:
>>
>>> I have looked into the problems some more, and have found that the cause 
>>> of the crash was a change I made because I misunderstood the code 
>>> (LO(cmd) is the number of bytes in in the message, and is not 
>>> transferred on USB - i had removed it from the message...)
>> Ah, good, thanks.
>>
>>> First, the changes in the normal input, the joystick axis+buttons message:
>>> * Prefix is 0x06 instead of 0x01 (joystick) or 0x03 (gamepad)
>>> * Throttle is not inverted (data[4] instead of 255-data[4])
>>> * Rudder is present and unsigned (not signed, as in iforce)
>>>
>>> I have attached a patch that I think fixes this (it works for me :) 
>>> Since saitek uses a different protocol byte, this can be done without 
>>> adding per-device flags to the driver.
>>>
>>> It also adds a button map btn_saitek_cyborg that switches button 1&2 to
>>> make the button number the same as printed on the device, and
>>> abs_saitek_cyborg for a joystick with rudder but only one hat.
>>>
>>> The fftest effects seem to work, but some are feeble and feel strange -
>>> I suspect there are some subtle changes, for example I am quite sure
>>> that the Saitek uses signed (twos complement) numbers for effect
>>> strength (this could perhaps explain the 'strange' behavior for 0x80
>>> byte values in the current code)...
>> The changes look really minimal to me, so I'd propose just to add a few 
>> special cases to the iforce driver itself (probably by setting/checking 
>> some per-device flag where needed), rather than copy/pasting the whole 
>> iforce driver.
>>
>> But the ultimate decision is on Dmitry (CCed) here.
>>
> 
> Right, so far I have not seen anythig that would warrant creating a
> separate driver, adjusting the current one is the way to go.
> 

--------------030302060004070103020105
Content-Type: text/plain;
 name="iforce-oops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="iforce-oops.txt"

Dec 19 23:42:17 localhost kernel: [  154.444093] usb 6-1: new full speed USB device using uhci_hcd and address 2
Dec 19 23:42:17 localhost kernel: [  154.600375] usb 6-1: New USB device found, idVendor=06a3, idProduct=ffb5
Dec 19 23:42:17 localhost kernel: [  154.600384] usb 6-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
Dec 19 23:42:17 localhost kernel: [  154.600390] usb 6-1: Product: Cyborg Evo Force
Dec 19 23:42:17 localhost kernel: [  154.600394] usb 6-1: Manufacturer: Saitek
Dec 19 23:42:17 localhost kernel: [  154.600737] usb 6-1: configuration #1 chosen from 1 choice
Dec 19 23:42:17 localhost kernel: [  154.714158] drivers/input/joystick/iforce/iforce-packets.c: info cmd = ff01, data = 43 
Dec 19 23:42:17 localhost kernel: [  154.716162] drivers/input/joystick/iforce/iforce-packets.c: info cmd = ff03, data = 45 00 01 
Dec 19 23:42:17 localhost kernel: [  154.718368] drivers/input/joystick/iforce/iforce-packets.c: info cmd = ff01, data = 4f 
Dec 19 23:42:17 localhost kernel: [  154.720155] drivers/input/joystick/iforce/iforce-packets.c: info cmd = ff04, data = 56 02 05 00 
Dec 19 23:42:17 localhost kernel: [  154.721032] input: Saitek Cyborg Evo Force as /devices/pci0000:00/0000:00:1d.0/usb6/6-1/input/input10
Dec 19 23:42:17 localhost kernel: [  154.721642] usbcore: registered new interface driver iforce
Dec 19 23:42:17 localhost kernel: [  154.805812] usbcore: registered new interface driver hiddev
Dec 19 23:42:17 localhost kernel: [  154.805930] usbcore: registered new interface driver usbhid
Dec 19 23:42:17 localhost kernel: [  154.805934] usbhid: v2.6:USB HID core driver
Dec 19 23:42:26 localhost kernel: [  162.928977] drivers/input/joystick/iforce/iforce-packets.c: magnitude:  cmd = 0303, data = 1a 00 20 
Dec 19 23:42:26 localhost kernel: [  162.928993] drivers/input/joystick/iforce/iforce-packets.c: condition cmd = 050a, data = 2a 00 19 19 00 00 00 00 31 31 
Dec 19 23:42:26 localhost kernel: [  162.929009] drivers/input/joystick/iforce/iforce-packets.c: condition cmd = 050a, data = 32 00 19 19 00 00 00 00 31 31 
Dec 19 23:42:26 localhost kernel: [  162.929028] drivers/input/joystick/iforce/iforce-packets.c: condition cmd = 050a, data = 3a 00 19 19 00 00 00 00 31 31 
Dec 19 23:42:26 localhost kernel: [  162.929044] drivers/input/joystick/iforce/iforce-packets.c: condition cmd = 050a, data = 42 00 19 19 00 00 00 00 31 31 
Dec 19 23:42:49 localhost kernel: [  185.954214] usb 6-1: USB disconnect, address 2
Dec 19 23:42:49 localhost kernel: [  185.960338] BUG: unable to handle kernel paging request at 000032002a0000e7
Dec 19 23:42:49 localhost kernel: [  185.960627] IP: [<ffffffff8128949b>] unlink1+0x3b/0x130
Dec 19 23:42:49 localhost kernel: [  185.960810] PGD 0 
Dec 19 23:42:49 localhost kernel: [  185.960973] Oops: 0000 [#1] PREEMPT SMP 
Dec 19 23:42:49 localhost kernel: [  185.961131] last sysfs file: /sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq
Dec 19 23:42:49 localhost kernel: [  185.961131] CPU 1 
Dec 19 23:42:49 localhost kernel: [  185.961131] Modules linked in: usbhid hid iforce fglrx(P) ipv6 openafs(P) cpufreq_stats kvm_intel kvm binfmt_misc uinput fuse radeonfb fb_ddc i2c_algo_bit i2c_core snd_hda_codec_atihdmi snd_hda_codec_analog arc4 snd_hda_intel ide_cs joydev ecb snd_hda_codec iwlagn iwlcore snd_pcm_oss pcmcia snd_mixer_oss uvcvideo yenta_socket psmouse video snd_pcm rsrc_nonstatic mac80211 serio_raw pcspkr wmi pcmcia_core snd_page_alloc output cfg80211 rfkill ext3 jbd mbcache sha256_generic cryptd aes_x86_64 aes_generic sg ricoh_mmc sdhci_pci sdhci led_class uhci_hcd intel_agp [last unloaded: scsi_wait_scan]
Dec 19 23:42:49 localhost kernel: [  185.964097] Pid: 336, comm: khubd Tainted: P           2.6.32-je3 #5 HP EliteBook 8530p
Dec 19 23:42:49 localhost kernel: [  185.964097] RIP: 0010:[<ffffffff8128949b>]  [<ffffffff8128949b>] unlink1+0x3b/0x130
Dec 19 23:42:49 localhost kernel: [  185.964097] RSP: 0018:ffff88007e087b60  EFLAGS: 00010202
Dec 19 23:42:49 localhost kernel: [  185.964097] RAX: 000032002a00007f RBX: 0000000000000286 RCX: ffffffff8117aa43
Dec 19 23:42:49 localhost kernel: [  185.964097] RDX: 00000000fffffffe RSI: ffff880061766000 RDI: ffff88006e10e000
Dec 19 23:42:49 localhost kernel: [  185.964097] RBP: ffff88006e10e000 R08: ffff88000188f0e0 R09: 0000000000000000
Dec 19 23:42:49 localhost kernel: [  185.964097] R10: 8000000000000000 R11: ffffffff81152eb0 R12: 00000000fffffffe
Dec 19 23:42:49 localhost kernel: [  185.964097] R13: ffffffffa00c4408 R14: ffff88006fe57800 R15: 0000000000000000
Dec 19 23:42:49 localhost kernel: [  185.964097] FS:  0000000000000000(0000) GS:ffff880001880000(0000) knlGS:0000000000000000
Dec 19 23:42:49 localhost kernel: [  185.964097] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
Dec 19 23:42:49 localhost kernel: [  185.964097] CR2: 000032002a0000e7 CR3: 000000005e823000 CR4: 00000000000026e0
Dec 19 23:42:49 localhost kernel: [  185.964097] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Dec 19 23:42:49 localhost kernel: [  185.964097] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Dec 19 23:42:49 localhost kernel: [  185.964097] Process khubd (pid: 336, threadinfo ffff88007e086000, task ffff88007e1c9ea0)
Dec 19 23:42:49 localhost kernel: [  185.964097] Stack:
Dec 19 23:42:49 localhost kernel: [  185.964097]  0000000000000286 ffff880061766000 00000000fffffffe ffffffffa00c4408
Dec 19 23:42:49 localhost kernel: [  185.964097] <0> ffff88006fe57800 ffffffff812896f9 ffff880061766000 ffff88006e10e000
Dec 19 23:42:49 localhost kernel: [  185.964097] <0> ffff880061766014 ffffffff8128ac2c ffff88005e98d808 ffffffff81179963
Dec 19 23:42:49 localhost kernel: [  185.964097] Call Trace:
Dec 19 23:42:49 localhost kernel: [  185.964097]  [<ffffffff812896f9>] ? usb_hcd_unlink_urb+0x59/0xa0
Dec 19 23:42:49 localhost kernel: [  185.964097]  [<ffffffff8128ac2c>] ? usb_kill_urb+0x3c/0xc0
Dec 19 23:42:49 localhost kernel: [  185.964097]  [<ffffffff81179963>] ? kobject_del+0x23/0x30
Dec 19 23:42:49 localhost kernel: [  185.964097]  [<ffffffff8120ce3d>] ? device_del+0x17d/0x1d0
Dec 19 23:42:49 localhost kernel: [  185.964097]  [<ffffffffa00c35bd>] ? iforce_usb_delete+0xd/0x40 [iforce]
Dec 19 23:42:49 localhost kernel: [  185.964097]  [<ffffffffa00c3248>] ? iforce_usb_disconnect+0x48/0x70 [iforce]
Dec 19 23:42:49 localhost kernel: [  185.964097]  [<ffffffff8128ee54>] ? usb_unbind_interface+0x134/0x180
Dec 19 23:42:49 localhost kernel: [  185.964097]  [<ffffffff8120f5f2>] ? __device_release_driver+0x72/0xe0
Dec 19 23:42:49 localhost kernel: [  185.964097]  [<ffffffff8120f745>] ? device_release_driver+0x25/0x40
Dec 19 23:42:49 localhost kernel: [  185.964097]  [<ffffffff8120eae5>] ? bus_remove_device+0x95/0xd0
Dec 19 23:42:49 localhost kernel: [  185.964097]  [<ffffffff8120cdea>] ? device_del+0x12a/0x1d0
Dec 19 23:42:49 localhost kernel: [  185.964097]  [<ffffffff8128b955>] ? usb_disable_device+0x95/0x120
Dec 19 23:42:49 localhost kernel: [  185.964097]  [<ffffffff8128644b>] ? usb_disconnect+0xbb/0x150
Dec 19 23:42:49 localhost kernel: [  185.964097]  [<ffffffff81287291>] ? hub_thread+0x371/0x13a0
Dec 19 23:42:49 localhost kernel: [  185.964097]  [<ffffffff81037d90>] ? select_task_rq_fair+0x4b0/0x760
Dec 19 23:42:49 localhost kernel: [  185.964097]  [<ffffffff81036d25>] ? set_next_entity+0x35/0x70
Dec 19 23:42:49 localhost kernel: [  185.964097]  [<ffffffff81280100>] ? mmc_ioctl_dvd_read_struct+0x390/0x5c0
Dec 19 23:42:49 localhost kernel: [  185.964097]  [<ffffffff8139b849>] ? thread_return+0x243/0x65a
Dec 19 23:42:49 localhost kernel: [  185.964097]  [<ffffffff81059c80>] ? autoremove_wake_function+0x0/0x30
Dec 19 23:42:49 localhost kernel: [  185.964097]  [<ffffffff81286f20>] ? hub_thread+0x0/0x13a0
Dec 19 23:42:49 localhost kernel: [  185.964097]  [<ffffffff81286f20>] ? hub_thread+0x0/0x13a0
Dec 19 23:42:49 localhost kernel: [  185.964097]  [<ffffffff81059976>] ? kthread+0x96/0xa0
Dec 19 23:42:49 localhost kernel: [  185.964097]  [<ffffffff8100ce0a>] ? child_rip+0xa/0x20
Dec 19 23:42:49 localhost kernel: [  185.964097]  [<ffffffff810598e0>] ? kthread+0x0/0xa0
Dec 19 23:42:49 localhost kernel: [  185.964097]  [<ffffffff8100ce00>] ? child_rip+0x0/0x20
Dec 19 23:42:49 localhost kernel: [  185.964097] Code: 24 10 4c 89 6c 24 18 4c 89 74 24 20 48 89 fd 48 8b 46 48 48 89 f3 41 89 d4 48 83 78 38 00 74 30 48 8b 87 f0 00 00 00 48 8b 1c 24 <4c> 8b 58 68 48 8b 6c 24 08 4c 8b 64 24 10 4c 8b 6c 24 18 4c 8b 
Dec 19 23:42:49 localhost kernel: [  185.964097] RIP  [<ffffffff8128949b>] unlink1+0x3b/0x130
Dec 19 23:42:49 localhost kernel: [  185.964097]  RSP <ffff88007e087b60>
Dec 19 23:42:49 localhost kernel: [  185.964097] CR2: 000032002a0000e7
Dec 19 23:42:49 localhost kernel: [  185.977920] ---[ end trace fc8dfb59ff1c03b8 ]---

--------------030302060004070103020105
Content-Type: text/x-patch;
 name="saitek-v2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="saitek-v2.patch"

diff -ru iforce_orig/iforce.h iforce/iforce.h
--- iforce_orig/iforce.h	2009-12-03 04:51:21.000000000 +0100
+++ iforce/iforce.h	2009-12-20 00:18:55.000000000 +0100
@@ -96,6 +96,7 @@
 	signed short *btn;
 	signed short *abs;
 	signed short *ff;
+	bool has_btndead;
 };
 
 struct iforce {
diff -ru iforce_orig/iforce-main.c iforce/iforce-main.c
--- iforce_orig/iforce-main.c	2009-12-03 04:51:21.000000000 +0100
+++ iforce/iforce-main.c	2009-12-20 00:22:36.000000000 +0100
@@ -35,6 +35,10 @@
 { BTN_TRIGGER, BTN_TOP, BTN_THUMB, BTN_TOP2, BTN_BASE,
   BTN_BASE2, BTN_BASE3, BTN_BASE4, BTN_BASE5, BTN_A, BTN_B, BTN_C, -1 };
 
+static signed short btn_saitek_cyborg[] =
+{ BTN_TRIGGER, BTN_THUMB, BTN_TOP, BTN_TOP2, BTN_BASE,
+  BTN_BASE2, BTN_BASE3, BTN_BASE4, BTN_BASE5, BTN_A, BTN_B, BTN_C, -1 };
+
 static signed short btn_avb_pegasus[] =
 { BTN_TRIGGER, BTN_TOP, BTN_THUMB, BTN_TOP2, BTN_BASE,
   BTN_BASE2, BTN_BASE3, BTN_BASE4, -1 };
@@ -54,6 +58,9 @@
 static signed short abs_joystick[] =
 { ABS_X, ABS_Y, ABS_THROTTLE, ABS_HAT0X, ABS_HAT0Y, -1 };
 
+static signed short abs_saitek_joystick[] =
+{ ABS_X, ABS_Y, ABS_THROTTLE, ABS_RUDDER, ABS_HAT0X, ABS_HAT0Y, -1 };
+
 static signed short abs_avb_pegasus[] =
 { ABS_X, ABS_Y, ABS_THROTTLE, ABS_RUDDER, ABS_HAT0X, ABS_HAT0Y,
   ABS_HAT1X, ABS_HAT1Y, -1 };
@@ -67,19 +74,20 @@
   FF_AUTOCENTER, -1 };
 
 static struct iforce_device iforce_device[] = {
-	{ 0x044f, 0xa01c, "Thrustmaster Motor Sport GT",		btn_wheel, abs_wheel, ff_iforce },
-	{ 0x046d, 0xc281, "Logitech WingMan Force",			btn_joystick, abs_joystick, ff_iforce },
-	{ 0x046d, 0xc291, "Logitech WingMan Formula Force",		btn_wheel, abs_wheel, ff_iforce },
-	{ 0x05ef, 0x020a, "AVB Top Shot Pegasus",			btn_avb_pegasus, abs_avb_pegasus, ff_iforce },
-	{ 0x05ef, 0x8884, "AVB Mag Turbo Force",			btn_avb_wheel, abs_wheel, ff_iforce },
-	{ 0x05ef, 0x8888, "AVB Top Shot Force Feedback Racing Wheel",	btn_avb_tw, abs_wheel, ff_iforce }, //?
-	{ 0x061c, 0xc0a4, "ACT LABS Force RS",                          btn_wheel, abs_wheel, ff_iforce }, //?
-	{ 0x061c, 0xc084, "ACT LABS Force RS",				btn_wheel, abs_wheel, ff_iforce },
-	{ 0x06f8, 0x0001, "Guillemot Race Leader Force Feedback",	btn_wheel, abs_wheel, ff_iforce }, //?
-	{ 0x06f8, 0x0004, "Guillemot Force Feedback Racing Wheel",	btn_wheel, abs_wheel, ff_iforce }, //?
-	{ 0x06f8, 0x0004, "Gullemot Jet Leader 3D",			btn_joystick, abs_joystick, ff_iforce }, //?
-	{ 0x06d6, 0x29bc, "Trust Force Feedback Race Master",		btn_wheel, abs_wheel, ff_iforce },
-	{ 0x0000, 0x0000, "Unknown I-Force Device [%04x:%04x]",		btn_joystick, abs_joystick, ff_iforce }
+	{ 0x044f, 0xa01c, "Thrustmaster Motor Sport GT",		btn_wheel, abs_wheel, ff_iforce, true },
+	{ 0x046d, 0xc281, "Logitech WingMan Force",			btn_joystick, abs_joystick, ff_iforce, true },
+	{ 0x046d, 0xc291, "Logitech WingMan Formula Force",		btn_wheel, abs_wheel, ff_iforce, true },
+	{ 0x05ef, 0x020a, "AVB Top Shot Pegasus",			btn_avb_pegasus, abs_avb_pegasus, ff_iforce, true },
+	{ 0x05ef, 0x8884, "AVB Mag Turbo Force",			btn_avb_wheel, abs_wheel, ff_iforce, true },
+	{ 0x05ef, 0x8888, "AVB Top Shot Force Feedback Racing Wheel",	btn_avb_tw, abs_wheel, ff_iforce, true }, //?
+	{ 0x061c, 0xc0a4, "ACT LABS Force RS",                          btn_wheel, abs_wheel, ff_iforce, true }, //?
+	{ 0x061c, 0xc084, "ACT LABS Force RS",				btn_wheel, abs_wheel, ff_iforce, true },
+	{ 0x06f8, 0x0001, "Guillemot Race Leader Force Feedback",	btn_wheel, abs_wheel, ff_iforce, true }, //?
+	{ 0x06f8, 0x0004, "Guillemot Force Feedback Racing Wheel",	btn_wheel, abs_wheel, ff_iforce, true }, //?
+	{ 0x06f8, 0x0004, "Gullemot Jet Leader 3D",			btn_joystick, abs_joystick, ff_iforce, true }, //?
+	{ 0x06d6, 0x29bc, "Trust Force Feedback Race Master",		btn_wheel, abs_wheel, ff_iforce, true },
+	{ 0x06a3, 0xffb5, "Saitek Cyborg Evo Force",			btn_saitek_cyborg, abs_saitek_joystick, ff_iforce, false }, //?
+	{ 0x0000, 0x0000, "Unknown I-Force Device [%04x:%04x]",		btn_joystick, abs_joystick, ff_iforce, true }
 };
 
 static int iforce_playback(struct input_dev *dev, int effect_id, int value)
@@ -396,7 +404,8 @@
 
 	for (i = 0; iforce->type->btn[i] >= 0; i++)
 		set_bit(iforce->type->btn[i], input_dev->keybit);
-	set_bit(BTN_DEAD, input_dev->keybit);
+	if (iforce->type->has_btndead)
+		set_bit(BTN_DEAD, input_dev->keybit);
 
 	for (i = 0; iforce->type->abs[i] >= 0; i++) {
 
@@ -408,7 +417,10 @@
 			case ABS_Y:
 			case ABS_WHEEL:
 
-				input_set_abs_params(input_dev, t, -1920, 1920, 16, 128);
+				if (iforce->type->idvendor == 0x06a3) /* Saitek axis */
+					input_set_abs_params(input_dev, t, 0, 4096, 16, 128);
+				else
+					input_set_abs_params(input_dev, t, -1920, 1920, 16, 128);
 				set_bit(t, input_dev->ffbit);
 				break;
 
@@ -421,7 +433,10 @@
 
 			case ABS_RUDDER:
 
-				input_set_abs_params(input_dev, t, -128, 127, 0, 0);
+				if (iforce->type->idvendor == 0x06a3) /* Saitek axis */
+					input_set_abs_params(input_dev, t, 0, 255, 0, 0);
+				else
+					input_set_abs_params(input_dev, t, -128, 127, 0, 0);
 				break;
 
 			case ABS_HAT0X:
diff -ru iforce_orig/iforce-packets.c iforce/iforce-packets.c
--- iforce_orig/iforce-packets.c	2009-12-03 04:51:21.000000000 +0100
+++ iforce/iforce-packets.c	2009-12-20 00:19:18.000000000 +0100
@@ -182,16 +182,24 @@
 
 		case 0x01:	/* joystick position data */
 		case 0x03:	/* wheel position data */
-			if (HI(cmd) == 1) {
-				input_report_abs(dev, ABS_X, (__s16) (((__s16)data[1] << 8) | data[0]));
-				input_report_abs(dev, ABS_Y, (__s16) (((__s16)data[3] << 8) | data[2]));
-				input_report_abs(dev, ABS_THROTTLE, 255 - data[4]);
-				if (LO(cmd) >= 8 && test_bit(ABS_RUDDER ,dev->absbit))
-					input_report_abs(dev, ABS_RUDDER, (__s8)data[7]);
-			} else {
+		case 0x06:	/* saitek position data */
+			if (HI(cmd) == 3) {
 				input_report_abs(dev, ABS_WHEEL, (__s16) (((__s16)data[1] << 8) | data[0]));
 				input_report_abs(dev, ABS_GAS,   255 - data[2]);
 				input_report_abs(dev, ABS_BRAKE, 255 - data[3]);
+			} else {
+				input_report_abs(dev, ABS_X, (__s16) (((__s16)data[1] << 8) | data[0]));
+				input_report_abs(dev, ABS_Y, (__s16) (((__s16)data[3] << 8) | data[2]));
+				if (HI(cmd) == 6) {
+					input_report_abs(dev, ABS_THROTTLE, data[4]);
+					if (LO(cmd) >= 8 && test_bit(ABS_RUDDER ,dev->absbit))
+						input_report_abs(dev, ABS_RUDDER, data[7]);
+				} else {
+					input_report_abs(dev, ABS_THROTTLE, 255 - data[4]);
+					if (LO(cmd) >= 8 && test_bit(ABS_RUDDER ,dev->absbit))
+						input_report_abs(dev, ABS_RUDDER, (__s8)data[7]);
+				}
+
 			}
 
 			input_report_abs(dev, ABS_HAT0X, iforce_hat_to_axis[data[6] >> 4].x);
@@ -220,8 +228,10 @@
 			break;
 
 		case 0x02:	/* status report */
-			input_report_key(dev, BTN_DEAD, data[0] & 0x02);
-			input_sync(dev);
+			if (iforce->type->has_btndead) {
+				input_report_key(dev, BTN_DEAD, data[0] & 0x02);
+				input_sync(dev);
+			}
 
 			/* Check if an effect was just started or stopped */
 			i = data[1] & 0x7f;
diff -ru iforce_orig/iforce-usb.c iforce/iforce-usb.c
--- iforce_orig/iforce-usb.c	2009-12-03 04:51:21.000000000 +0100
+++ iforce/iforce-usb.c	2009-12-15 22:46:11.000000000 +0100
@@ -227,6 +227,7 @@
 	{ USB_DEVICE(0x06f8, 0x0001) },		/* Guillemot Race Leader Force Feedback */
 	{ USB_DEVICE(0x06f8, 0x0004) },		/* Guillemot Force Feedback Racing Wheel */
 	{ USB_DEVICE(0x06f8, 0xa302) },		/* Guillemot Jet Leader 3D */
+	{ USB_DEVICE(0x06a3, 0xffb5) },		/* Saitek Cyborg Evo Force */
 	{ }					/* Terminating entry */
 };
 

--------------030302060004070103020105--
