From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH] Revert "HID: sony: Add force feedback support for Dualshock3 USB"
Date: Sun, 17 Nov 2013 11:08:00 +0100
Message-ID: <1384682880-5960-1-git-send-email-sven@narfation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from narfation.org ([79.140.41.39]:42076 "EHLO v3-1039.vlinux.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751799Ab3KQKIK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Nov 2013 05:08:10 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, simon@mungewell.org, Sven Eckelmann <sven@narfation.org>

The ff_memless has a timer running which gets run in an atomic context and
calls the play_effect callback. The callback function for sony uses the
hid_output_raw_report (overwritten by sixaxis_usb_output_raw_report) function
to handle differences in the control message format. It is not safe for an
atomic context because it may sleep later in usb_start_wait_urb.

[  619.529530] BUG: scheduling while atomic: swapper/5/0/0x00000100
[...]
[  619.529707] Call Trace:
[  619.529710]  <IRQ>  [<ffffffff81474a72>] ? dump_stack+0x41/0x51
[  619.529723]  [<ffffffff814723d8>] ? __schedule_bug+0x44/0x51
[  619.529731]  [<ffffffff814782fa>] ? __schedule+0x53a/0x720
[  619.529739]  [<ffffffff81476669>] ? schedule_timeout+0x1c9/0x2d0
[  619.529756]  [<ffffffffa00c0c6a>] ? ohci_urb_enqueue+0x1ea/0xa40 [ohci_hcd]
[  619.529763]  [<ffffffff810494ba>] ? gart_map_page+0x5a/0x80
[  619.529786]  [<ffffffffa000f7b5>] ? usb_hcd_map_urb_for_dma+0x425/0x4b0 [usbcore]
[  619.529794]  [<ffffffff81478c91>] ? wait_for_completion_timeout+0xa1/0x120
[  619.529801]  [<ffffffff81086090>] ? wake_up_state+0x10/0x10
[  619.529825]  [<ffffffffa0011d0d>] ? usb_start_wait_urb+0x6d/0xd0 [usbcore]
[  619.529848]  [<ffffffffa0011e2d>] ? usb_control_msg+0xbd/0x100 [usbcore]
[  619.529856]  [<ffffffffa1026620>] ? sony_play_effect+0x170/0x180 [hid_sony]
[  619.529864]  [<ffffffffa101c593>] ? ml_play_effects+0xf3/0x610 [ff_memless]
[  619.529872]  [<ffffffffa101cb90>] ? ml_ff_playback+0xa0/0xa0 [ff_memless]
[  619.529880]  [<ffffffffa101cbb9>] ? ml_effect_timer+0x29/0x470 [ff_memless]
[  619.529888]  [<ffffffff81063a51>] ? call_timer_fn+0x31/0x100
[  619.529895]  [<ffffffffa101cb90>] ? ml_ff_playback+0xa0/0xa0 [ff_memless]
[  619.529903]  [<ffffffff81064549>] ? run_timer_softirq+0x1c9/0x2b0
[  619.529910]  [<ffffffff8105d4e6>] ? __do_softirq+0xf6/0x240
[  619.529917]  [<ffffffff8148369c>] ? call_softirq+0x1c/0x30
[  619.529924]  [<ffffffff810143a5>] ? do_softirq+0x55/0x90
[  619.529930]  [<ffffffff8105d785>] ? irq_exit+0x95/0xa0
[  619.529937]  [<ffffffff81013ed9>] ? do_IRQ+0x49/0xb0
[  619.529944]  [<ffffffff8147a4ad>] ? common_interrupt+0x6d/0x6d
[  619.529947]  <EOI>  [<ffffffff810a2779>] ? ktime_get+0x39/0xc0
[  619.529959]  [<ffffffff810472a2>] ? native_safe_halt+0x2/0x10
[  619.529966]  [<ffffffff8101a349>] ? default_idle+0x19/0xa0
[  619.529973]  [<ffffffff8101a43b>] ? amd_e400_idle+0x6b/0xf0
[  619.529980]  [<ffffffff810a0ae8>] ? cpu_startup_entry+0xc8/0x270
[  619.529987]  [<ffffffff8103b962>] ? start_secondary+0x1d2/0x230

This reverts commit a08c22c0df0ad23d0df10ae1a9df26643589b3cc.

Reported-by: simon@mungewell.org
Signed-of-by: Sven Eckelmann <sven@narfation.org>
---
 drivers/hid/Kconfig    |  8 --------
 drivers/hid/hid-sony.c | 52 --------------------------------------------------
 2 files changed, 60 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 329fbb9..a27e531 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -618,14 +618,6 @@ config HID_SONY
 	  * Sony PS3 Blue-ray Disk Remote Control (Bluetooth)
 	  * Logitech Harmony adapter for Sony Playstation 3 (Bluetooth)
 
-config SONY_FF
-	bool "Sony PS2/3 accessories force feedback support"
-	depends on HID_SONY
-	select INPUT_FF_MEMLESS
-	---help---
-	Say Y here if you have a Sony PS2/3 accessory and want to enable force
-	feedback support for it.
-
 config HID_SPEEDLINK
 	tristate "Speedlink VAD Cezanne mouse support"
 	depends on HID
diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index da551d1..bc37a18 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -614,54 +614,6 @@ static void buzz_remove(struct hid_device *hdev)
 	drv_data->extra = NULL;
 }
 
-#ifdef CONFIG_SONY_FF
-static int sony_play_effect(struct input_dev *dev, void *data,
-			    struct ff_effect *effect)
-{
-	unsigned char buf[] = {
-		0x01,
-		0x00, 0xff, 0x00, 0xff, 0x00,
-		0x00, 0x00, 0x00, 0x00, 0x03,
-		0xff, 0x27, 0x10, 0x00, 0x32,
-		0xff, 0x27, 0x10, 0x00, 0x32,
-		0xff, 0x27, 0x10, 0x00, 0x32,
-		0xff, 0x27, 0x10, 0x00, 0x32,
-		0x00, 0x00, 0x00, 0x00, 0x00
-	};
-	__u8 left;
-	__u8 right;
-	struct hid_device *hid = input_get_drvdata(dev);
-
-	if (effect->type != FF_RUMBLE)
-		return 0;
-
-	left = effect->u.rumble.strong_magnitude / 256;
-	right = effect->u.rumble.weak_magnitude ? 1 : 0;
-
-	buf[3] = right;
-	buf[5] = left;
-
-	return hid->hid_output_raw_report(hid, buf, sizeof(buf),
-					  HID_OUTPUT_REPORT);
-}
-
-static int sony_init_ff(struct hid_device *hdev)
-{
-	struct hid_input *hidinput = list_entry(hdev->inputs.next,
-						struct hid_input, list);
-	struct input_dev *input_dev = hidinput->input;
-
-	input_set_capability(input_dev, EV_FF, FF_RUMBLE);
-	return input_ff_create_memless(input_dev, NULL, sony_play_effect);
-}
-
-#else
-static int sony_init_ff(struct hid_device *hdev)
-{
-	return 0;
-}
-#endif
-
 static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	int ret;
@@ -711,10 +663,6 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (ret < 0)
 		goto err_stop;
 
-	ret = sony_init_ff(hdev);
-	if (ret < 0)
-		goto err_stop;
-
 	return 0;
 err_stop:
 	hid_hw_stop(hdev);
-- 
1.8.4.3

