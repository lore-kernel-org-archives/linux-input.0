Received: from mail.sntiq.com (mail.sntiq.com [45.149.154.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1537349CD6;
	Sun, 31 May 2026 22:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.149.154.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780266225; cv=none; b=SuVXRoV0OGzU+5ssY7qjzfZv2AFJ/q8Uz/KDIfX8KJ6kfEBm6lrDRMK9A/Eg+NdtxVDZlgcwbc7kRhKaAJRC0gY/rA7/nJmb56JRnzIRpeEFP/lywxpRU7vd4PcCRvqynI7x2GKF/Lfa43xMcObjeQq1KQ09r8gHPXrxupQ2Y8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780266225; c=relaxed/simple;
	bh=RwmCnL8+xOfynPNB7buQ7JnUZs7njafLDNTtXj5joEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=obKZjzOoomjF9rEulYfZpZbUfiqzm+rIoFb54XQHrl/YZ4tc8fAItGrueAYHxdVyZ6UEomuHR0jmMBbJhFoFZgiQQm8ehzy+hbAZDZwX+twrbTAZTIvIiIqr+Mi+oqPQ9irLhwjK0Y955Hgja+mf/jOjyNMkX3p740eEuT5pHq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntiq.com; spf=pass smtp.mailfrom=sntiq.com; dkim=pass (2048-bit key) header.d=sntiq.com header.i=@sntiq.com header.b=giDW9RVC; arc=none smtp.client-ip=45.149.154.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntiq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntiq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntiq.com header.i=@sntiq.com header.b="giDW9RVC"
Received: from node (unknown [209.198.153.231])
	by mail.sntiq.com (Postfix) with ESMTPSA id 4BB7E801E5;
	Sun, 31 May 2026 22:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sntiq.com; s=dkim;
	t=1780266220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=00kNbC8pQ7hbYK+m26zvoEhLaiSgvabo4hIl1C4SgC8=;
	b=giDW9RVCnkjaDA5JeRM48tO5zny4wHJm7Y7MDMtx6qI6gqmpj8ZIY+s3mi0iuA2aK4MtmS
	4SaPMKxxVR1Ph5D1AionLYdbBhtkJjGCSmfzEBXvDTIhBZYQUe30Gjbs3fDjFLPREL3daA
	gsdNWk0A1jUe+F5IcYR6SVDw+LhWutBf0VJIxRamxN4j9wwGQ/PaX8Ln0CW7iBfrmo856n
	Fcw2Q/sprDtdiqYiCGkzIQRowCpf0IKAG2AblNdnGR8UdNh/I46shXUdPnoMFYuMCMSwmE
	e0IvbRGoyJGoX5WLW6Fzy0etFzFzI4hyaiu2U44e9URO7tzkPfh8axmGY8PMLg==
From: David Glushkov <david.glushkov@sntiq.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] HID: steelseries: Add MSI Raider A18 HX A9WJG RGB support
Date: Mon,  1 Jun 2026 00:21:23 +0200
Message-ID: <20260531222123.179923-1-david.glushkov@sntiq.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260531215204.172030-1-david.glushkov@sntiq.com>
References: <20260531215204.172030-1-david.glushkov@sntiq.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
v2:
- Fixed unsafe to_usb_interface cast by checking hid_is_usb() first.
- Fixed uninitialized delayed_work warning by restricting cancel_delayed_work_sync to headset devices.
- Fixed error path leaks in probe (hid_hw_stop / hid_hw_close).
- Added hid_hw_power PM wrappers around direct usb_control_msg transfers.

 drivers/hid/hid-ids.h         |   2 +
 drivers/hid/hid-steelseries.c | 193 +++++++++++++++++++++++++++++++++-
 2 files changed, 192 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 4657d96fb..4af4397b8 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1367,6 +1367,8 @@
 #define USB_DEVICE_ID_STEELSERIES_SRWS1	0x1410
 #define USB_DEVICE_ID_STEELSERIES_ARCTIS_1  0x12b6
 #define USB_DEVICE_ID_STEELSERIES_ARCTIS_9  0x12c2
+#define USB_DEVICE_ID_STEELSERIES_MSI_KLC   0x1122
+#define USB_DEVICE_ID_STEELSERIES_MSI_ALC   0x1161
 
 #define USB_VENDOR_ID_SUN		0x0430
 #define USB_DEVICE_ID_RARITAN_KVM_DONGLE	0xcdab
diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
index f98435631..e8910b222 100644
--- a/drivers/hid/hid-steelseries.c
+++ b/drivers/hid/hid-steelseries.c
@@ -10,16 +10,23 @@
  */
 
 #include <linux/device.h>
+#include <linux/dmi.h>
 #include <linux/hid.h>
 #include <linux/module.h>
 #include <linux/usb.h>
 #include <linux/leds.h>
+#include <linux/led-class-multicolor.h>
 
 #include "hid-ids.h"
 
 #define STEELSERIES_SRWS1		BIT(0)
 #define STEELSERIES_ARCTIS_1		BIT(1)
 #define STEELSERIES_ARCTIS_9		BIT(2)
+#define STEELSERIES_MSI_RGB		BIT(3)
+
+#define STEELSERIES_HAS_LEDS_MULTICOLOR \
+	(IS_BUILTIN(CONFIG_LEDS_CLASS_MULTICOLOR) || \
+	 (IS_MODULE(CONFIG_LEDS_CLASS_MULTICOLOR) && IS_MODULE(CONFIG_HID_STEELSERIES)))
 
 struct steelseries_device {
 	struct hid_device *hdev;
@@ -34,6 +41,13 @@ struct steelseries_device {
 	uint8_t battery_capacity;
 	bool headset_connected;
 	bool battery_charging;
+
+#if STEELSERIES_HAS_LEDS_MULTICOLOR
+	struct led_classdev_mc mc_cdev;
+	struct mc_subled subled_info[3];
+	struct mutex rgb_lock; /* protects rgb_buf */
+	u8 *rgb_buf;
+#endif
 };
 
 #if IS_BUILTIN(CONFIG_LEDS_CLASS) || \
@@ -528,6 +542,150 @@ static bool steelseries_is_vendor_usage_page(struct hid_device *hdev, uint8_t us
 		hdev->rdesc[2] == 0xff;
 }
 
+static const struct dmi_system_id steelseries_msi_rgb_dmi_table[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Micro-Star International Co., Ltd."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Raider A18 HX A9WJG"),
+			DMI_MATCH(DMI_BOARD_NAME, "MS-182L"),
+		},
+	},
+	{ }
+};
+
+static struct usb_device *steelseries_hid_to_usb_dev(struct hid_device *hdev)
+{
+	return interface_to_usbdev(to_usb_interface(hdev->dev.parent));
+}
+
+static bool steelseries_msi_rgb_is_interface0(struct hid_device *hdev)
+{
+	if (!hid_is_usb(hdev))
+		return false;
+
+	return to_usb_interface(hdev->dev.parent) ==
+	       usb_ifnum_to_if(steelseries_hid_to_usb_dev(hdev), 0);
+}
+
+#if STEELSERIES_HAS_LEDS_MULTICOLOR
+
+static int steelseries_msi_rgb_set_blocking(struct led_classdev *led_cdev,
+					    enum led_brightness brightness)
+{
+	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(led_cdev);
+	struct steelseries_device *sd = container_of(mc_cdev, struct steelseries_device, mc_cdev);
+	struct hid_device *hdev = sd->hdev;
+	struct usb_device *udev = steelseries_hid_to_usb_dev(hdev);
+	int i, ret;
+	u8 r, g, b;
+
+	static const u8 keys[] = {
+		0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b,
+		0x0c, 0x0d, 0x0e, 0x0f, 0x10, 0x11, 0x12, 0x13,
+		0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1a, 0x1b,
+		0x1c, 0x1d, 0x1e, 0x1f, 0x20, 0x21, 0x22, 0x23,
+		0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2a, 0x2b,
+		0x2c, 0x2d, 0x2e, 0x2f, 0x30, 0x31, 0x33, 0x34,
+		0x35, 0x36, 0x37, 0x38, 0x39, 0x3a, 0x3b, 0x3c,
+		0x3d, 0x3e, 0x3f, 0x40, 0x41, 0x42, 0x43, 0x44,
+		0x45, 0x46, 0x47, 0x49, 0x4b, 0x4c, 0x4e, 0x4f,
+		0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57,
+		0x58, 0x59, 0x5a, 0x5b, 0x5c, 0x5d, 0x5e, 0x5f,
+		0x60, 0x61, 0x62, 0x63, 0x64, 0x66, 0xe0, 0xe1,
+		0xe2, 0xe3, 0xe4, 0xe5, 0xe6, 0xf0
+	};
+	static const u8 alc_zones[] = { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05 };
+
+	mutex_lock(&sd->rgb_lock);
+
+	led_mc_calc_color_components(mc_cdev, brightness);
+
+	r = mc_cdev->subled_info[0].brightness;
+	g = mc_cdev->subled_info[1].brightness;
+	b = mc_cdev->subled_info[2].brightness;
+
+	memset(sd->rgb_buf, 0, 524);
+	sd->rgb_buf[0] = 0x0c;
+	sd->rgb_buf[1] = 0x00;
+	sd->rgb_buf[3] = 0x00;
+
+	if (hdev->product == USB_DEVICE_ID_STEELSERIES_MSI_KLC) {
+		sd->rgb_buf[2] = 0x66;
+		for (i = 0; i < ARRAY_SIZE(keys); i++) {
+			sd->rgb_buf[4 + i * 4] = keys[i];
+			sd->rgb_buf[5 + i * 4] = r;
+			sd->rgb_buf[6 + i * 4] = g;
+			sd->rgb_buf[7 + i * 4] = b;
+		}
+	} else {
+		sd->rgb_buf[2] = 0x06;
+		for (i = 0; i < ARRAY_SIZE(alc_zones); i++) {
+			sd->rgb_buf[4 + i * 4] = alc_zones[i];
+			sd->rgb_buf[5 + i * 4] = r;
+			sd->rgb_buf[6 + i * 4] = g;
+			sd->rgb_buf[7 + i * 4] = b;
+		}
+	}
+
+	ret = hid_hw_power(hdev, PM_HINT_FULLON);
+	if (ret < 0)
+		goto out_unlock;
+
+	ret = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
+			      HID_REQ_SET_REPORT,
+			      USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
+			      0x0300, 0,
+			      sd->rgb_buf, 524, USB_CTRL_SET_TIMEOUT);
+
+	hid_hw_power(hdev, PM_HINT_NORMAL);
+
+out_unlock:
+	mutex_unlock(&sd->rgb_lock);
+	return ret < 0 ? ret : 0;
+}
+
+static int steelseries_msi_rgb_register(struct steelseries_device *sd)
+{
+	struct hid_device *hdev = sd->hdev;
+	struct led_classdev *led_cdev;
+
+	sd->rgb_buf = devm_kzalloc(&hdev->dev, 524, GFP_KERNEL);
+	if (!sd->rgb_buf)
+		return -ENOMEM;
+
+	mutex_init(&sd->rgb_lock);
+
+	sd->subled_info[0].color_index = LED_COLOR_ID_RED;
+	sd->subled_info[1].color_index = LED_COLOR_ID_GREEN;
+	sd->subled_info[2].color_index = LED_COLOR_ID_BLUE;
+	sd->subled_info[0].intensity = 255;
+	sd->subled_info[1].intensity = 255;
+	sd->subled_info[2].intensity = 255;
+	sd->subled_info[0].channel = 0;
+	sd->subled_info[1].channel = 1;
+	sd->subled_info[2].channel = 2;
+
+	sd->mc_cdev.subled_info = sd->subled_info;
+	sd->mc_cdev.num_colors = 3;
+
+	led_cdev = &sd->mc_cdev.led_cdev;
+	if (hdev->product == USB_DEVICE_ID_STEELSERIES_MSI_KLC)
+		led_cdev->name = "steelseries::kbd_backlight";
+	else
+		led_cdev->name = "steelseries::lightbar";
+
+	led_cdev->max_brightness = 255;
+	led_cdev->brightness_set_blocking = steelseries_msi_rgb_set_blocking;
+
+	return devm_led_classdev_multicolor_register(&hdev->dev, &sd->mc_cdev);
+}
+#else
+static int steelseries_msi_rgb_register(struct steelseries_device *sd)
+{
+	return -ENODEV;
+}
+#endif
+
 static int steelseries_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	struct steelseries_device *sd;
@@ -549,6 +707,12 @@ static int steelseries_probe(struct hid_device *hdev, const struct hid_device_id
 	sd->hdev = hdev;
 	sd->quirks = id->driver_data;
 
+	if (sd->quirks & STEELSERIES_MSI_RGB) {
+		if (!dmi_check_system(steelseries_msi_rgb_dmi_table) ||
+		    !steelseries_msi_rgb_is_interface0(hdev))
+			return -ENODEV;
+	}
+
 	ret = hid_parse(hdev);
 	if (ret)
 		return ret;
@@ -567,7 +731,17 @@ static int steelseries_probe(struct hid_device *hdev, const struct hid_device_id
 	if (ret)
 		return ret;
 
-	if (steelseries_headset_battery_register(sd) < 0)
+	if (sd->quirks & STEELSERIES_MSI_RGB) {
+		ret = steelseries_msi_rgb_register(sd);
+		if (ret) {
+			hid_err(hdev, "Failed to register MSI RGB LEDs: %d\n", ret);
+			goto err_close;
+		}
+		return 0;
+	}
+
+	if (sd->quirks & (STEELSERIES_ARCTIS_1 | STEELSERIES_ARCTIS_9) &&
+	    steelseries_headset_battery_register(sd) < 0)
 		hid_err(sd->hdev,
 			"Failed to register battery for headset\n");
 
@@ -593,7 +767,10 @@ static void steelseries_remove(struct hid_device *hdev)
 	sd->removed = true;
 	spin_unlock_irqrestore(&sd->lock, flags);
 
-	cancel_delayed_work_sync(&sd->battery_work);
+	if (sd) {
+		if (sd->quirks & (STEELSERIES_ARCTIS_1 | STEELSERIES_ARCTIS_9))
+			cancel_delayed_work_sync(&sd->battery_work);
+	}
 
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
@@ -635,7 +812,7 @@ static int steelseries_headset_raw_event(struct hid_device *hdev,
 	unsigned long flags;
 
 	/* Not a headset */
-	if (hdev->product == USB_DEVICE_ID_STEELSERIES_SRWS1)
+	if (!(sd->quirks & (STEELSERIES_ARCTIS_1 | STEELSERIES_ARCTIS_9)))
 		return 0;
 
 	if (hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_1) {
@@ -732,6 +909,16 @@ static const struct hid_device_id steelseries_devices[] = {
 	  HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_9),
 	  .driver_data = STEELSERIES_ARCTIS_9 },
 
+#if STEELSERIES_HAS_LEDS_MULTICOLOR
+	{ /* MSI Raider A18 KLC */
+	  HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_MSI_KLC),
+	  .driver_data = STEELSERIES_MSI_RGB },
+
+	{ /* MSI Raider A18 ALC */
+	  HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_MSI_ALC),
+	  .driver_data = STEELSERIES_MSI_RGB },
+#endif
+
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, steelseries_devices);
-- 
2.54.0

