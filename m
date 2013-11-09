From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH] HID: sony: Add force feedback support for Dualshock3 USB
Date: Sat,  9 Nov 2013 19:25:57 +0100
Message-ID: <1384021557-24106-1-git-send-email-sven@narfation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from narfation.org ([79.140.41.39]:41789 "EHLO v3-1039.vlinux.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756290Ab3KISgr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 9 Nov 2013 13:36:47 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Colin Leitner <colin.leitner@gmail.com>, Sven Eckelmann <sven@narfation.org>

Sony Dualshock 3 controllers have two motors which can be used to provide
simple force feedback rumble effects. The right motor is can be used to create
a weak rumble effect but does not allow to set the force. The left motor is
used to create a strong rumble effect with adjustable intensity.

The state of both motors can be changed using HID_OUTPUT_REPORT packets and
have no timing information. FF memless is used to keep track of the timing and
the sony driver just generates the necessary URBs.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 drivers/hid/Kconfig    |  8 ++++++++
 drivers/hid/hid-sony.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

The device will not have any reports. Thus the payload is generated on the fly
as it is already done in different other places in the driver.

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index a27e531..329fbb9 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -618,6 +618,14 @@ config HID_SONY
 	  * Sony PS3 Blue-ray Disk Remote Control (Bluetooth)
 	  * Logitech Harmony adapter for Sony Playstation 3 (Bluetooth)
 
+config SONY_FF
+	bool "Sony PS2/3 accessories force feedback support"
+	depends on HID_SONY
+	select INPUT_FF_MEMLESS
+	---help---
+	Say Y here if you have a Sony PS2/3 accessory and want to enable force
+	feedback support for it.
+
 config HID_SPEEDLINK
 	tristate "Speedlink VAD Cezanne mouse support"
 	depends on HID
diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index bc37a18..da551d1 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -614,6 +614,54 @@ static void buzz_remove(struct hid_device *hdev)
 	drv_data->extra = NULL;
 }
 
+#ifdef CONFIG_SONY_FF
+static int sony_play_effect(struct input_dev *dev, void *data,
+			    struct ff_effect *effect)
+{
+	unsigned char buf[] = {
+		0x01,
+		0x00, 0xff, 0x00, 0xff, 0x00,
+		0x00, 0x00, 0x00, 0x00, 0x03,
+		0xff, 0x27, 0x10, 0x00, 0x32,
+		0xff, 0x27, 0x10, 0x00, 0x32,
+		0xff, 0x27, 0x10, 0x00, 0x32,
+		0xff, 0x27, 0x10, 0x00, 0x32,
+		0x00, 0x00, 0x00, 0x00, 0x00
+	};
+	__u8 left;
+	__u8 right;
+	struct hid_device *hid = input_get_drvdata(dev);
+
+	if (effect->type != FF_RUMBLE)
+		return 0;
+
+	left = effect->u.rumble.strong_magnitude / 256;
+	right = effect->u.rumble.weak_magnitude ? 1 : 0;
+
+	buf[3] = right;
+	buf[5] = left;
+
+	return hid->hid_output_raw_report(hid, buf, sizeof(buf),
+					  HID_OUTPUT_REPORT);
+}
+
+static int sony_init_ff(struct hid_device *hdev)
+{
+	struct hid_input *hidinput = list_entry(hdev->inputs.next,
+						struct hid_input, list);
+	struct input_dev *input_dev = hidinput->input;
+
+	input_set_capability(input_dev, EV_FF, FF_RUMBLE);
+	return input_ff_create_memless(input_dev, NULL, sony_play_effect);
+}
+
+#else
+static int sony_init_ff(struct hid_device *hdev)
+{
+	return 0;
+}
+#endif
+
 static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	int ret;
@@ -663,6 +711,10 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (ret < 0)
 		goto err_stop;
 
+	ret = sony_init_ff(hdev);
+	if (ret < 0)
+		goto err_stop;
+
 	return 0;
 err_stop:
 	hid_hw_stop(hdev);
-- 
1.8.4.2

