Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24252E62AC
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 02:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787365238; cv=none; b=h9lAfaaG91Jg5MfHWePgUBw40ie75+y/NM7yrI3DcDrVeEgoBbdOxGpglzA2MHVpl979hyw6T43AynHcEXwZfVCSeevWW06BycjZjeKJsZcN/b33xIBFReSiea1ZPVMIkRT8LybnXy0kPEubH91XQLfh9F1Uwf1fkwVntaLzTqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787365238; c=relaxed/simple;
	bh=xRf+BO8LI7Arw/616rTAmwmNaWtbWTV5p02hzQNsqOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i75xFmn5nfGGfi5tKpu5MjSiBf9zAVuiYotpegw4npJd2W5o62iVYNLPBXYrWv8yC35C02Ju3dFJbLS8aNF+BDo+eA1U6ErOkU5qxaqfqrEJiKJapVVK3pNNvge9RPfzswLel62t09gVKzgO0bFC4cwlK1J1MaUJKF7mhZVxIPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=z3Os9gCk; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="z3Os9gCk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1787364799; bh=xRf+BO8LI7Arw/616rTAmwmNaWtbWTV5p02hzQNsqOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=z3Os9gCkhgAu94SlfdUcCq3gMLMAiOxsiKnoAMenTUpnTg3+eyDqRHwVfwQ7TQ0rH
	 QHtbIv8sxy9f7KjViJh+CJ5edp/YisGf7vwVzEAoCmjfhH/qc98nF5P89XL3mHcg6n
	 8RN+exMkgt3obZ8bIQ4fzEPG7xKmJOJaCaWDWVKxxGyqVLPCqSHoxtOlkKBBnTO2aQ
	 PeatjOzkFLwWMuPjWfp6DA7jGm8fuxj6AyCG00Mi4LPTcAPItq/jzKhIU1ICaXMlNZ
	 XJDfdsuZUKKgScZfwLFMpih3ljejcP/YzgU3c/EIEpDRqvPL5w+j6vw66A0wRzx2s8
	 Y53cWaJW2EQTQ==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 042AB132033;
	Fri, 21 Aug 2026 19:13:18 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v4 03/12] Input: xbox_gip - Add controllable LED support
Date: Fri, 21 Aug 2026 19:11:27 -0700
Message-ID: <20260822021140.1149546-4-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260822021140.1149546-1-vi@endrift.com>
References: <20260822021140.1149546-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Xbox One controllers have two different types of controllable LED support:

- Monochrome white, which most controllers have.
- RGBW addressible, which the Elite 2 controllers have.

This exposes both types as led cdevs.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/input/joystick/gip/Kconfig    |   2 +-
 drivers/input/joystick/gip/gip-core.c | 111 ++++++++++++++++++++++++++
 drivers/input/joystick/gip/gip.h      |   6 +-
 3 files changed, 117 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joystick/gip/Kconfig b/drivers/input/joystick/gip/Kconfig
index 2ce789d23178..3422bf84cb89 100644
--- a/drivers/input/joystick/gip/Kconfig
+++ b/drivers/input/joystick/gip/Kconfig
@@ -4,7 +4,7 @@
 #
 config JOYSTICK_XBOX_GIP
 	tristate "Xbox One/Series controller support"
-	depends on USB && USB_ARCH_HAS_HCD
+	depends on USB && USB_ARCH_HAS_HCD && LEDS_CLASS_MULTICOLOR
 	help
 	  Say Y here if you want to use Xbox One and Series controllers with your
 	  computer. Make sure to say Y to "Joystick support" (CONFIG_INPUT_JOYDEV)
diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joystick/gip/gip-core.c
index 12a1fb285bfc..15f8ed210711 100644
--- a/drivers/input/joystick/gip/gip-core.c
+++ b/drivers/input/joystick/gip/gip-core.c
@@ -1038,9 +1038,116 @@ static int gip_send_guide_button_led(struct gip_attachment *attachment,
 	if (!gip_supports_system_message(attachment, GIP_CMD_LED, false))
 		return 0;
 
+	if (!(attachment->features & GIP_FEATURE_GUIDE_COLOR))
+		attachment->guide_led.standard.brightness = intensity;
+
 	return gip_send_system_message(attachment, GIP_CMD_LED, 0, buffer, sizeof(buffer));
 }
 
+static int gip_send_guide_button_color_led(struct gip_attachment *attachment,
+	uint8_t r, uint8_t g, uint8_t b, uint8_t w)
+{
+	uint8_t buffer[] = { 0x00, w, r, g, b };
+
+	if (!(attachment->features & GIP_FEATURE_GUIDE_COLOR))
+		return -EINVAL;
+
+	attachment->guide_led.color.subled_info[0].brightness = r;
+	attachment->guide_led.color.subled_info[1].brightness = g;
+	attachment->guide_led.color.subled_info[2].brightness = b;
+	attachment->guide_led.color.subled_info[3].brightness = w;
+
+	return gip_send_vendor_message(attachment, GIP_CMD_GUIDE_COLOR, 0, buffer, sizeof(buffer));
+}
+
+static int gip_guide_led_set(struct led_classdev *led,
+	enum led_brightness value)
+{
+	struct gip_attachment *attachment = container_of(led,
+		struct gip_attachment, guide_led.standard);
+
+	guard(mutex)(&attachment->lock);
+	return gip_send_guide_button_led(attachment, GIP_LED_GUIDE_ON, value);
+}
+
+static int gip_guide_color_led_set(struct led_classdev *led,
+	enum led_brightness value)
+{
+	struct led_classdev_mc *mc_cdev = container_of(led,
+		struct led_classdev_mc, led_cdev);
+	struct gip_attachment *attachment = container_of(mc_cdev,
+		struct gip_attachment, guide_led.color);
+
+	led_mc_calc_color_components(mc_cdev, value);
+	guard(mutex)(&attachment->lock);
+	return gip_send_guide_button_color_led(attachment,
+		mc_cdev->subled_info[0].brightness,
+		mc_cdev->subled_info[1].brightness,
+		mc_cdev->subled_info[2].brightness,
+		mc_cdev->subled_info[3].brightness);
+}
+
+static int gip_guide_led_probe(struct gip_attachment *attachment, struct device *dev)
+{
+	int rc = 0;
+
+	if (!gip_supports_system_message(attachment, GIP_CMD_LED, false))
+		return 0;
+
+	if (attachment->features & GIP_FEATURE_GUIDE_COLOR) {
+		struct mc_subled *mc_led_info;
+		struct led_classdev_mc *mc_cdev = &attachment->guide_led.color;
+		struct led_classdev *cdev = &mc_cdev->led_cdev;
+
+		mc_led_info = devm_kcalloc(dev, 4,
+			sizeof(*mc_led_info), GFP_KERNEL);
+		if (!mc_led_info)
+			return -ENOMEM;
+
+		mc_led_info[0].color_index = LED_COLOR_ID_RED;
+		mc_led_info[1].color_index = LED_COLOR_ID_GREEN;
+		mc_led_info[2].color_index = LED_COLOR_ID_BLUE;
+		mc_led_info[3].color_index = LED_COLOR_ID_WHITE;
+
+		mc_cdev->subled_info = mc_led_info;
+		mc_cdev->num_colors = 4;
+
+		cdev->brightness = 51;
+		cdev->max_brightness = 255;
+		cdev->flags = LED_CORE_SUSPENDRESUME | LED_RETAIN_AT_SHUTDOWN;
+		cdev->brightness_set_blocking = gip_guide_color_led_set;
+		cdev->name = devm_kasprintf(dev, GFP_KERNEL,
+			"%s:rgb:power", dev_name(dev));
+		if (!cdev->name)
+			rc = -ENOMEM;
+
+		if (!rc)
+			rc = devm_led_classdev_multicolor_register(dev,
+				mc_cdev);
+
+		if (rc)
+			devm_kfree(dev, mc_led_info);
+	} else {
+		struct led_classdev *cdev = &attachment->guide_led.standard;
+
+		cdev->max_brightness = GIP_LED_GUIDE_MAX_BRIGHTNESS;
+		cdev->brightness = GIP_LED_GUIDE_INIT_BRIGHTNESS;
+		cdev->flags = LED_CORE_SUSPENDRESUME | LED_RETAIN_AT_SHUTDOWN;
+		cdev->brightness_set_blocking = gip_guide_led_set;
+		cdev->name = devm_kasprintf(dev, GFP_KERNEL,
+			"%s:white:power", dev_name(dev));
+		if (!cdev->name)
+			return -ENOMEM;
+
+		rc = devm_led_classdev_register(dev, cdev);
+
+		if (rc)
+			devm_kfree(dev, cdev->name);
+	}
+
+	return rc;
+}
+
 static bool gip_send_set_device_state(struct gip_attachment *attachment, uint8_t state)
 {
 	uint8_t buffer[] = { state };
@@ -1150,6 +1257,10 @@ static int gip_setup_input_device(struct gip_attachment *attachment)
 	if (rc)
 		goto err_free_device;
 
+	rc = gip_guide_led_probe(attachment, &input->dev);
+	if (rc)
+		gip_err(attachment, "Failed to register LEDs: %d\n", rc);
+
 	return 0;
 
 err_free_device:
diff --git a/drivers/input/joystick/gip/gip.h b/drivers/input/joystick/gip/gip.h
index d48ab64ab2eb..2e78aad508c3 100644
--- a/drivers/input/joystick/gip/gip.h
+++ b/drivers/input/joystick/gip/gip.h
@@ -12,6 +12,7 @@
 #ifndef _GIP_H
 #define _GIP_H
 
+#include <linux/led-class-multicolor.h>
 #include <linux/rcupdate.h>
 #include <linux/usb/input.h>
 
@@ -234,6 +235,10 @@ struct gip_attachment {
 	uint8_t seq_vendor;
 
 	uint8_t device_state;
+	union {
+		struct led_classdev standard;
+		struct led_classdev_mc color;
+	} guide_led;
 
 	struct gip_extended_status status;
 
@@ -245,7 +250,6 @@ struct gip_attachment {
 	int extra_axes;
 
 	bool dpad_as_buttons;
-	struct hid_device __rcu *hdev;
 };
 
 struct gip_urb {
-- 
2.54.0

