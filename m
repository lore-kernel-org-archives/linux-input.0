Received: from mail.sntiq.com (mail.sntiq.com [45.149.154.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361F132E126;
	Sun, 31 May 2026 23:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.149.154.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780270881; cv=none; b=JkTGrbR/7SJopgh3Ed251P8Bpc3SV1nHpfgkJo0a/DCGT+Bh6aSWJ2XrPWerXnCGTLQXJx7cEgmcxJD7DNo8YVVpFPgSQr8hdiC7VsPTRCr6fmWF7L4RxDyuyqopa5IX7L2/GVbWBwv6VTK6CiVtmuPQ+KnsBzIThX8Pob/6XY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780270881; c=relaxed/simple;
	bh=WhIEIBjnTjDhztpwcAtcswGjMA5UezFHtxNci4+VNIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r4Mw5taKlFMP0zQwa7rbcrusuMTbP+uWSeJFOvS+hw2W3QCsFkze7rv77W3PnPTwTUXpX06ZyqmsepmdU0QbZQnAdjFJker2+eSn4+j2YnIo7ogCk2SpC+whBwfABLgAMr4hNwLJIcmvFfjIcuaCRYR+/J+Xi7/Gt/DR+ENF5jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntiq.com; spf=pass smtp.mailfrom=sntiq.com; dkim=pass (2048-bit key) header.d=sntiq.com header.i=@sntiq.com header.b=BuNU6z+F; arc=none smtp.client-ip=45.149.154.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntiq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntiq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntiq.com header.i=@sntiq.com header.b="BuNU6z+F"
Received: from node (unknown [209.198.153.231])
	by mail.sntiq.com (Postfix) with ESMTPSA id 76764801E6;
	Sun, 31 May 2026 23:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sntiq.com; s=dkim;
	t=1780270875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0162qsYtzC+E5eqWXD1AlT/6gO69YpRtWvbQIUfO0yU=;
	b=BuNU6z+Fixkguy+Fc5KSuCdC1BNB4ykrg54ddrwQla9HFjdb8NXiqrk9txdyG5tuKKTxiL
	jg/UKxq8ftkRQUTzqijON+BPUq1A9GF6rbLAbvGG5KXPuKZwuueAUa04O+YdINfFNLnkzf
	ej3PA7Cl5bmSmwEJUzpS05EDfDrr1LjOa4uN0dCZPzkG5QAb1KcKO/5R0qI1ymDN6lAoz/
	QkHatU1g20AJmzIbSjESuJXt5MPXHsbJUDKsmObotRQwo4l5nrtnPjWtlTCoQJYFlSFJvb
	WjWICdgNCBRaq4f4Q7sUf1e0Pnhj26U+XpMec4jP3M6u3YAi/YvD3b9euJ1/tg==
From: David Glushkov <david.glushkov@sntiq.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5] HID: steelseries: Add MSI Raider A18 HX A9WJG RGB support
Date: Mon,  1 Jun 2026 01:39:03 +0200
Message-ID: <20260531233903.208321-1-david.glushkov@sntiq.com>
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

The MSI Raider A18 HX A9WJG exposes two internal SteelSeries USB HID
devices for RGB lighting: KLC (1038:1122) for the keyboard and ALC
(1038:1161) for the lightbar/logo zones.

Add DMI-gated support for these devices and expose them as multicolor
LED class devices. The driver sends the same HID class SET_REPORT
control transfer as the tested userspace implementation for this
machine and writes a uniform RGB value to all known keyboard keys or
ALC zones.

Limit RGB support to USB interface 0 and the tested DMI system because
the KLC product ID is shared across MSI laptop designs and the key
layout mapping is model-specific. If the DMI or interface check does
not match, keep the device bound as a regular HID device instead of
failing probe.

Tested on MSI Raider A18 HX A9WJG. Both internal SteelSeries ALC
(1038:1161) and KLC (1038:1122) HID devices bind on interface 0 and
create steelseries::lightbar and steelseries::kbd_backlight. Setting
multi_intensity and brightness changes the keyboard and lightbar
colors.

Signed-off-by: David Glushkov <david.glushkov@sntiq.com>
---
v5:
- Drop pm_ret handling and ignore PM_HINT_NORMAL cleanup errors.
- Fix LED registration error handling to clean up rgb_buf on failure.
- Fix trailing whitespaces and formatting style nits.
- Update commit message to accurately reflect the DMI fallback behavior.

v4:
- Fix literal \n typo in C code.
- Remove unused steelseries_msi_rgb_free_buf from #else block.
- Do not fail probe on unsupported DMI/interface; clear MSI RGB quirk and continue normal HID initialization.
- Do not fail probe when RGB LED registration fails; keep the HID device usable without RGB LED support.
- Add explicit linux/slab.h include for kzalloc/kfree.

v3:
- Fix build failure (added missing err_close label to steelseries_probe).
- Fix DMA API violation (use kzalloc instead of devm_kzalloc for usb transfer buffer).
- Fix C syntax declaration-after-statement warning.
- Fix type confusion for SRWS1 (add early check in raw_event before hid_get_drvdata).
- Fix delayed_work crash (add battery_registered flag).

v2:
- Fixed unsafe to_usb_interface cast by checking hid_is_usb() first.
- Fixed uninitialized delayed_work warning by restricting cancel_delayed_work_sync to headset devices.
- Fixed error path leaks in probe (hid_hw_stop / hid_hw_close).
- Added hid_hw_power PM wrappers around direct usb_control_msg transfers.

 drivers/hid/hid-ids.h         |   2 +
 drivers/hid/hid-steelseries.c | 277 ++++++++++++++++++++++++++++++++--
 2 files changed, 270 insertions(+), 9 deletions(-)

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
index f98435631..c269db06d 100644
--- a/drivers/hid/hid-steelseries.c
+++ b/drivers/hid/hid-steelseries.c
@@ -10,16 +10,26 @@
  */
 
 #include <linux/device.h>
+#include <linux/dmi.h>
 #include <linux/hid.h>
 #include <linux/module.h>
 #include <linux/usb.h>
 #include <linux/leds.h>
+#include <linux/led-class-multicolor.h>
+#include <linux/slab.h>
 
 #include "hid-ids.h"
 
 #define STEELSERIES_SRWS1		BIT(0)
 #define STEELSERIES_ARCTIS_1		BIT(1)
 #define STEELSERIES_ARCTIS_9		BIT(2)
+#define STEELSERIES_MSI_RGB		BIT(3)
+
+#define STEELSERIES_MSI_RGB_REPORT_LEN 524
+
+#define STEELSERIES_HAS_LEDS_MULTICOLOR \
+	(IS_BUILTIN(CONFIG_LEDS_CLASS_MULTICOLOR) || \
+	 (IS_MODULE(CONFIG_LEDS_CLASS_MULTICOLOR) && IS_MODULE(CONFIG_HID_STEELSERIES)))
 
 struct steelseries_device {
 	struct hid_device *hdev;
@@ -34,6 +44,14 @@ struct steelseries_device {
 	uint8_t battery_capacity;
 	bool headset_connected;
 	bool battery_charging;
+	bool battery_registered;
+
+#if STEELSERIES_HAS_LEDS_MULTICOLOR
+	struct led_classdev_mc mc_cdev;
+	struct mc_subled subled_info[3];
+	struct mutex rgb_lock; /* protects rgb_buf */
+	u8 *rgb_buf;
+#endif
 };
 
 #if IS_BUILTIN(CONFIG_LEDS_CLASS) || \
@@ -510,6 +528,7 @@ static int steelseries_headset_battery_register(struct steelseries_device *sd)
 	power_supply_powers(sd->battery, &sd->hdev->dev);
 
 	INIT_DELAYED_WORK(&sd->battery_work, steelseries_headset_battery_timer_tick);
+	sd->battery_registered = true;
 	steelseries_headset_fetch_battery(sd->hdev);
 
 	if (sd->quirks & STEELSERIES_ARCTIS_9) {
@@ -528,6 +547,196 @@ static bool steelseries_is_vendor_usage_page(struct hid_device *hdev, uint8_t us
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
+static struct usb_interface *steelseries_hid_to_usb_intf(struct hid_device *hdev)
+{
+	if (!hid_is_usb(hdev))
+		return NULL;
+
+	return to_usb_interface(hdev->dev.parent);
+}
+
+static struct usb_device *steelseries_hid_to_usb_dev(struct hid_device *hdev)
+{
+	struct usb_interface *intf = steelseries_hid_to_usb_intf(hdev);
+
+	if (!intf)
+		return NULL;
+
+	return interface_to_usbdev(intf);
+}
+
+static bool steelseries_msi_rgb_is_interface0(struct hid_device *hdev)
+{
+	struct usb_interface *intf = steelseries_hid_to_usb_intf(hdev);
+	struct usb_device *udev;
+
+	if (!intf)
+		return false;
+
+	udev = interface_to_usbdev(intf);
+
+	return intf == usb_ifnum_to_if(udev, 0);
+}
+
+#if STEELSERIES_HAS_LEDS_MULTICOLOR
+
+static int steelseries_msi_rgb_set_blocking(struct led_classdev *led_cdev,
+					    enum led_brightness brightness)
+{
+	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(led_cdev);
+	struct steelseries_device *sd = container_of(mc_cdev,
+						    struct steelseries_device,
+						    mc_cdev);
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
+	if (!udev)
+		return -ENODEV;
+
+	mutex_lock(&sd->rgb_lock);
+
+	led_mc_calc_color_components(mc_cdev, brightness);
+
+	r = mc_cdev->subled_info[0].brightness;
+	g = mc_cdev->subled_info[1].brightness;
+	b = mc_cdev->subled_info[2].brightness;
+
+	memset(sd->rgb_buf, 0, STEELSERIES_MSI_RGB_REPORT_LEN);
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
+			      sd->rgb_buf, STEELSERIES_MSI_RGB_REPORT_LEN,
+			      USB_CTRL_SET_TIMEOUT);
+
+	hid_hw_power(hdev, PM_HINT_NORMAL);
+
+out_unlock:
+	mutex_unlock(&sd->rgb_lock);
+	return ret < 0 ? ret : 0;
+}
+
+static void steelseries_msi_rgb_free_buf(void *data)
+{
+	kfree(data);
+}
+
+static int steelseries_msi_rgb_register(struct steelseries_device *sd)
+{
+	struct hid_device *hdev = sd->hdev;
+	struct led_classdev *led_cdev;
+	int ret;
+
+	sd->rgb_buf = kzalloc(STEELSERIES_MSI_RGB_REPORT_LEN, GFP_KERNEL);
+	if (!sd->rgb_buf)
+		return -ENOMEM;
+
+	ret = devm_add_action_or_reset(&hdev->dev,
+				       steelseries_msi_rgb_free_buf,
+				       sd->rgb_buf);
+	if (ret) {
+		sd->rgb_buf = NULL;
+		return ret;
+	}
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
+	ret = devm_led_classdev_multicolor_register(&hdev->dev, &sd->mc_cdev);
+	if (ret) {
+		devm_remove_action(&hdev->dev, steelseries_msi_rgb_free_buf,
+				   sd->rgb_buf);
+		kfree(sd->rgb_buf);
+		sd->rgb_buf = NULL;
+		return ret;
+	}
+
+	return 0;
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
@@ -549,6 +758,14 @@ static int steelseries_probe(struct hid_device *hdev, const struct hid_device_id
 	sd->hdev = hdev;
 	sd->quirks = id->driver_data;
 
+	if (sd->quirks & STEELSERIES_MSI_RGB) {
+		if (!dmi_check_system(steelseries_msi_rgb_dmi_table) ||
+		    !steelseries_msi_rgb_is_interface0(hdev)) {
+			hid_dbg(hdev, "MSI RGB quirk not applicable, using generic HID path\n");
+			sd->quirks &= ~STEELSERIES_MSI_RGB;
+		}
+	}
+
 	ret = hid_parse(hdev);
 	if (ret)
 		return ret;
@@ -565,12 +782,28 @@ static int steelseries_probe(struct hid_device *hdev, const struct hid_device_id
 
 	ret = hid_hw_open(hdev);
 	if (ret)
-		return ret;
+		goto err_stop;
+
+	if (sd->quirks & STEELSERIES_MSI_RGB) {
+		ret = steelseries_msi_rgb_register(sd);
+		if (ret) {
+			hid_warn(hdev,
+				 "Failed to register MSI RGB LEDs: %d, continuing without RGB support\n",
+				 ret);
+			sd->quirks &= ~STEELSERIES_MSI_RGB;
+		}
+		return 0;
+	}
 
-	if (steelseries_headset_battery_register(sd) < 0)
+	if (sd->quirks & (STEELSERIES_ARCTIS_1 | STEELSERIES_ARCTIS_9) &&
+	    steelseries_headset_battery_register(sd) < 0)
 		hid_err(sd->hdev,
 			"Failed to register battery for headset\n");
 
+	return 0;
+
+err_stop:
+	hid_hw_stop(hdev);
 	return ret;
 }
 
@@ -588,12 +821,15 @@ static void steelseries_remove(struct hid_device *hdev)
 	}
 
 	sd = hid_get_drvdata(hdev);
+	if (!sd)
+		return;
 
 	spin_lock_irqsave(&sd->lock, flags);
 	sd->removed = true;
 	spin_unlock_irqrestore(&sd->lock, flags);
 
-	cancel_delayed_work_sync(&sd->battery_work);
+	if (sd->battery_registered)
+		cancel_delayed_work_sync(&sd->battery_work);
 
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
@@ -624,20 +860,33 @@ static uint8_t steelseries_headset_map_capacity(uint8_t capacity, uint8_t min_in
 	return (capacity - min_in) * 100 / (max_in - min_in);
 }
 
+static bool steelseries_is_headset(struct hid_device *hdev)
+{
+	return hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_1 ||
+	       hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_9;
+}
+
 static int steelseries_headset_raw_event(struct hid_device *hdev,
 					struct hid_report *report, u8 *read_buf,
 					int size)
 {
-	struct steelseries_device *sd = hid_get_drvdata(hdev);
-	int capacity = sd->battery_capacity;
-	bool connected = sd->headset_connected;
-	bool charging = sd->battery_charging;
+	struct steelseries_device *sd;
+	int capacity;
+	bool connected;
+	bool charging;
 	unsigned long flags;
 
-	/* Not a headset */
-	if (hdev->product == USB_DEVICE_ID_STEELSERIES_SRWS1)
+	if (!steelseries_is_headset(hdev))
+		return 0;
+
+	sd = hid_get_drvdata(hdev);
+	if (!sd || !sd->battery_registered)
 		return 0;
 
+	capacity = sd->battery_capacity;
+	connected = sd->headset_connected;
+	charging = sd->battery_charging;
+
 	if (hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_1) {
 		hid_dbg(sd->hdev,
 			"Parsing raw event for Arctis 1 headset (%*ph)\n", size, read_buf);
@@ -732,6 +981,16 @@ static const struct hid_device_id steelseries_devices[] = {
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

