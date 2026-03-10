Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981822749D5
	for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 05:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773120034; cv=none; b=PbgyEWZWZzDEfFL5Ay0xYo7BB4CBmYWueKIDtUH2lrxBzUv8w0BQ/zvEzHOgyP0u6R5S9jNw7BglmfWQwcLZ+NC56MxR2GlM3adM8j7LRBxyeuI4MihFfk6dCxx+BGomeDlJlmsid0TjM+ERxo8srPeouV8752wdddnwX/eGbJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773120034; c=relaxed/simple;
	bh=HA96ECpiREpapD4NwRYZaF/XxH5ytPnwlH777izwP6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p+Hda9cHNFLe8rMScp8881h+CBiYAttqn92HdNTDhslZcY4yh+njAbn1GBccFcJAmf6otHeBA1QIgqVS1DPBhogoJ4vO2eps1BdBsKeLyRUyCZ5z6TzOuXWaBf+kXXGBqHRO83kjwU79eMyB+q1iSWYQSiBUasjR23PYDMYtv5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=GuNr2t7z; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="GuNr2t7z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1773120033; bh=HA96ECpiREpapD4NwRYZaF/XxH5ytPnwlH777izwP6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GuNr2t7zPDso9xQHjzulXRbqAKePRNHgHnQzS4r8NXO6PzSZjvDagYG+7z7x8q5g+
	 j926dq0Nil0T+6dSxWEy49zIoXTZYr+UzbO2lmz4N8oICoH1OdHJZ+DCE3NBcfaH2D
	 B3yzrbWyQnePDfiQ7z7xfZxN8mevR1iXrYmVm2Hx6lwJBv/L0H/mln3YYwIXErfKfK
	 qVoA6G4lFNDHnyBtwYlZpwK2VFcagkfGg2Vuv+79emzN1x5qhDFnpPcJDsN6haPHab
	 rAXoSJGm7zDNqbFIYv4FUdKfMMuIWESvtAwjFoYI/mOVVV63riBQIynHvO1AzWWSpQ
	 7vjrbM7l5KzcA==
Received: from microtis.vulpes.eutheria.net (71-212-14-89.tukw.qwest.net [71.212.14.89])
	by endrift.com (Postfix) with ESMTPSA id 007AAA0B5;
	Mon, 09 Mar 2026 22:20:32 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v3 03/10] Input: xbox_gip - Add controllable LED support
Date: Mon,  9 Mar 2026 22:19:57 -0700
Message-ID: <20260310052017.1289494-4-vi@endrift.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310052017.1289494-1-vi@endrift.com>
References: <20260310052017.1289494-1-vi@endrift.com>
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
 drivers/input/joystick/gip/gip-core.c | 115 ++++++++++++++++++++++++++
 drivers/input/joystick/gip/gip.h      |  10 ++-
 2 files changed, 124 insertions(+), 1 deletion(-)

diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joystick/gip/gip-core.c
index 0881797592fea..223668ca2b2a9 100644
--- a/drivers/input/joystick/gip/gip-core.c
+++ b/drivers/input/joystick/gip/gip-core.c
@@ -1045,9 +1045,118 @@ static int gip_send_guide_button_led(struct gip_attachment *attachment,
 	if (!gip_supports_system_message(attachment, GIP_CMD_LED, false))
 		return 0;
 
+#ifdef CONFIG_JOYSTICK_XBOX_GIP_LEDS
+	if (!(attachment->features & GIP_FEATURE_GUIDE_COLOR))
+		attachment->guide_led.standard.brightness = intensity;
+#endif
+
 	return gip_send_system_message(attachment, GIP_CMD_LED, 0, buffer, sizeof(buffer));
 }
 
+#ifdef CONFIG_JOYSTICK_XBOX_GIP_LEDS
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
+				&attachment->guide_led.color);
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
+		rc = devm_led_classdev_register(dev,
+			&attachment->guide_led.standard);
+	}
+
+	return rc;
+}
+#endif
+
 static bool gip_send_set_device_state(struct gip_attachment *attachment, uint8_t state)
 {
 	uint8_t buffer[] = { state };
@@ -1154,6 +1263,12 @@ static int gip_setup_input_device(struct gip_attachment *attachment)
 	if (rc)
 		goto err_free_device;
 
+#ifdef CONFIG_JOYSTICK_XBOX_GIP_LEDS
+	rc = gip_guide_led_probe(attachment, &input->dev);
+	if (rc)
+		dev_err(GIP_DEV(attachment), "Failed to register LEDs: %d\n", rc);
+#endif
+
 	return 0;
 
 err_free_device:
diff --git a/drivers/input/joystick/gip/gip.h b/drivers/input/joystick/gip/gip.h
index 2c60430c81590..63b4929b14e7f 100644
--- a/drivers/input/joystick/gip/gip.h
+++ b/drivers/input/joystick/gip/gip.h
@@ -12,6 +12,9 @@
 #ifndef _GIP_H
 #define _GIP_H
 
+#ifdef CONFIG_JOYSTICK_XBOX_GIP_LEDS
+#include <linux/led-class-multicolor.h>
+#endif
 #include <linux/rcupdate.h>
 #include <linux/usb/input.h>
 
@@ -201,6 +204,12 @@ struct gip_attachment {
 	uint8_t seq_vendor;
 
 	int device_state;
+#ifdef CONFIG_JOYSTICK_XBOX_GIP_LEDS
+	union {
+		struct led_classdev standard;
+		struct led_classdev_mc color;
+	} guide_led;
+#endif
 
 	struct gip_extended_status status;
 
@@ -212,7 +221,6 @@ struct gip_attachment {
 	int extra_axes;
 
 	bool dpad_as_buttons;
-	struct hid_device __rcu *hdev;
 };
 
 struct gip_urb {
-- 
2.53.0

