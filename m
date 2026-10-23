Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792776737;
	b=aa0QhSPsAtJ54EvcYQ/UuIIwwtrCFzBbOMZ7JNTEQkiVspsx+w+ytqSsBOWKSJh1MHmL
	 gGCe4/TGJDvpzDCEPjPofblETJnC8G411OYxeR59PNtDv2g8/r1x2Yh1Aa0jAQRQEApnK
	 dkLJkh8WsLmf1xt52HT2TK7ppCvH8IvjeJ8qKI2cGUxu45aRCdL6RhBRtC6AWC2gMHdy1
	 ZXtJDNGQCdMTlwEhCVQDrUZh/EbaaXWohNYe3cwEisIwAldkaNFlUrtuzo3CIQA8a3nK2
	 ywKRD1CIq9joXPo1upoBOO5YVaDd9LoOoWKxH6w5qyRewRGDeyj7H9BuxYFDDoRZ3TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792776737;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kuyAyI0iTEbMx+EZYYm4BgPqQMtKZGNJXxiTBsdCdRs=;
	b=Sqdhnewbw6AUKttEsKpr9MK9M7JhRqLBxzs24aYARRBQCrHHyNJQbDilNrRwB8g+/SKX
	 B/1q9bG9ZF8mB9GW8BXtTfRcNKXVAJTQ2X4gvP4Ww7n04jycyKdF0NoUAvWnbJS+CR+I3
	 toMw0NQcFzc1/4AATadKym7H+dcsboNcWumeqHidxwO4Z6VjuRCq4fpNOsZX2fK8xWoCT
	 /I1smx4ccZxvwVeME3gFTd4eLN+PHQJAwVsK7gEGMuyZYtqA2WXJaj8iil6fFLuvMVxNa
	 1pHllrG/MEKux458Hoj3hNsdHRuf9A0zZn2tM3um3Q8rCg0Y2pJ7VUS1mFO/qdo8HSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CAzs6+pR;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF407606A31A
	for <linux-input@vger.kernel.org>; Fri, 23 Oct 2026 17:32:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF407606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CAzs6+pR
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a2084d62cdso8968095e9.1
        for <linux-input@vger.kernel.org>; Fri, 23 Oct 2026 10:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792776735; x=1793381535; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kuyAyI0iTEbMx+EZYYm4BgPqQMtKZGNJXxiTBsdCdRs=;
        b=CAzs6+pRdAKJbS+aQBqR6eb2vDHxJkCGBNpBnud6H6b7DP9eWtjD0kEhE5pjEJ9ou4
         0HDhfMohSfyg6R9t9th/QnK/812LQv0IQJ5hSvGd1zraIrXDOQwiugdK95XlhQKm2DRC
         6dguRYuo+wdVV3km7WeqIoUdFXaSIpUT/VI5NiTFaEEDoavN2O8XJH8DNhPXlfLLNKz+
         UQ7g2P+7vDH3LBiwnoWxX/EMiFBEQh3QGujlvN92+3Ss0kpaAVbHj7vf0d+RlWy9ztCo
         JdJCK+2LXrwtkDNhRAfsg3faimzMNet0MZgqsD3i5n9aqu9+KPlKcgJ3p7uDFKOdUeif
         dyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792776735; x=1793381535;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kuyAyI0iTEbMx+EZYYm4BgPqQMtKZGNJXxiTBsdCdRs=;
        b=rcdvWq//x2vq2ztRameWKiNmOcGMeG+mgnz8dAgT6/ykS40MY8FN+dnthcxnVQI7an
         ru4+Diu3UwW1lhZk5PUX8yMWWGAxtH4pRfoXdM8R/33u27dUZ3Afe1sCn1Iw0azDx8T6
         kZkGnXRhPrNMzGkpq2bCl1WADmZun89cGn5MnHeH5AfrpeeykwAHvKVUrDenJA3VfORs
         +25QlFR2oZROZ5VMAYstJB7Ykdw5zNgnQDlSH0Z67I9kPvq22e+/MOxPJvIY3OGd2Fx8
         17Lw/b7OUSGXjrGhXUGVsoeEgOp9aGoZ30cPuHBEkizSL519m/amwM+g3FSDJ9sI+6Eh
         M4NA==
X-Gm-Message-State: AFq9FYJojLofL3AQP5L0LJN/uESNQudGh5yWRhypiqy/G19KcsIm1MWK
	0IVI+Jek04ftlYsUsJaUvB3S8FZsOGfiEnOT3OvnoRJuB0xa4sPe8G0n
X-Gm-Gg: AYBFou1Ab075NFPowTSfiPWYxrk/7WPECJ5at3aPtlbusoX5e3WEMDWQjrCxetIcHVv
	p5t9w4MBsf0v5d5GjVBXNMpvFcKMX/jcVRQNw0Vvz9zTJIwMj0qikqUB3jglIV4aZEIhZNa+AB6
	1PpIz+NVyQ43DSGOz35lZdALam8kuAG1gWnfOmIdDZ4ktehRkMQW408Hzy3ni/x6/EG6Mt1bP0z
	JvpqMBoAdc3yLujOWnbRDJ+xR0xurJGjofGcnHsu6qpAeSMwhtqQqMz/CXG5ChdFDlZZuAWQPtN
	Tv7a/kfHQiHFQOa7vp9xOrMzzXju5ygPaEIF+z5k/2rl2FeTv4LYlQmd6FS45ngOFh+N8wvc+6m
	pV44xPNrj7l1bi7GfYkAYP7yG6TK+CtrOVPvw91jKQX0vXEVcDCTD8YR/nBoH3uNm+uVQltUiiU
	pzLLWiC9u/vOfmVQiRrH95glHb3eRls9SOPdv+OocMRIjm7Cp8Km0vi6IB5hhP0fApcDVpybryD
	jfxEbS24uZ5MY13qGwHNBrEK3q1drCr2A4PAMuzNI8DdWlG9PBlCOes+ZryTcPIWjXl6ifgvEhV
	Qa3Wd8fhf4f4j3m1NkVD8RRGG2EfpYRmMxQHvV6CRXnDwXffcnmikB23yF73JPmPcoKJ
X-Received: by 2002:a05:600c:1c08:b0:4a2:16c0:f4f with SMTP id 5b1f17b1804b1-4a216c010e4mr37454055e9.30.1792776735113;
        Fri, 23 Oct 2026 10:32:15 -0700 (PDT)
Received: from hermes-agent.lan (228.red-80-29-82.staticip.rima-tde.net. [80.29.82.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d400365sm1145420f8f.25.2026.10.23.10.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 10:32:14 -0700 (PDT)
From: =?UTF-8?q?Ram=C3=B3n=20Jes=C3=BAs=20Miranda?= <ramonjesusmiranda@gmail.com>
To: Maximilian Luz <luzmaximilian@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ram=C3=B3n=20Jes=C3=BAs=20Miranda?= <ramonjesusmiranda@gmail.com>
Subject: [PATCH] HID: surface-hid: support keyboard backlight on Surface Pro Keyboard (045E:09AE)
Date: Fri, 23 Oct 2026 17:32:13 +0000
Message-ID: <20261023173213.6219-1-ramonjesusmiranda@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Surface Pro Keyboard / Flex Keyboard (VID 045E, PID 09AE) attached to
the Microsoft Surface Pro 11 (Snapdragon X Elite / X1E80100) exposes its
keyboard backlight through the HID Consumer Control collection (Usage Page
0x0c, Usage 0x07) rather than through the legacy Surface Aggregator Module
(SAM) TC/KBD category:

- Feature Report 0xd5 (Usage 0x0517, unit Candela) advertises the 4
  supported discrete brightness levels: [0x00, 0x03, 0x06, 0x0c].
- Feature Report 0xd6 (Usage 0x007b) returns the current brightness level
  (0, 3, 6, or 12).
- Output Report 0xd5 ([0xd5, level]) sets the brightness level.
- Input Report 0xd5 (Usage 0x0515, Keyboard Brightness Next) fires
  [0xd5, 0x01] whenever the hardware backlight key (F5) is pressed and the
  embedded controller cycles the brightness in hardware.

Register a LED class device named "surface::kbd_backlight" (max_brightness
= 3, flags = LED_BRIGHT_HW_CHANGED) when the HID device matches VID 045E /
PID 09AE, mapping steps 0..3 to hardware values {0, 3, 6, 12}. Also hook
raw_event to read back Feature Report 0xd6 and notify userspace via
led_classdev_notify_brightness_hw_changed() when Input Report 0xd5 arrives
from the F5 key, and restore the saved brightness level on resume.

Tested on a Microsoft Surface Pro 11 OLED (X1E80100) with UPower and KDE
PowerDevil.

Assisted-by: Antigravity:gemini-2.5-pro
Signed-off-by: Ramón Jesús Miranda <ramonjesusmiranda@gmail.com>
---
 drivers/hid/surface-hid/surface_hid.c      |   4 +
 drivers/hid/surface-hid/surface_hid_core.c | 104 ++++++++++++++++++++-
 drivers/hid/surface-hid/surface_hid_core.h |   8 ++
 3 files changed, 114 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/surface-hid/surface_hid.c b/drivers/hid/surface-hid/surface_hid.c
index eae47e0..0f81732 100644
--- a/drivers/hid/surface-hid/surface_hid.c
+++ b/drivers/hid/surface-hid/surface_hid.c
@@ -161,6 +161,10 @@ static u32 ssam_hid_event_fn(struct ssam_event_notifier *nf, const struct ssam_e
 	if (event->command_id != 0x00)
 		return 0;
 
+	if (shid->has_kbd_bl && event->length >= 2 &&
+	    event->data[0] == 0xd5 && (event->data[1] & 0x01))
+		schedule_work(&shid->kbd_bl_work);
+
 	hid_input_report(shid->hid, HID_INPUT_REPORT, (u8 *)&event->data[0], event->length, 0);
 	return SSAM_NOTIF_HANDLED;
 }
diff --git a/drivers/hid/surface-hid/surface_hid_core.c b/drivers/hid/surface-hid/surface_hid_core.c
index 6690c24..afee61f 100644
--- a/drivers/hid/surface-hid/surface_hid_core.c
+++ b/drivers/hid/surface-hid/surface_hid_core.c
@@ -184,6 +184,98 @@ static const struct hid_ll_driver surface_hid_ll_driver = {
 };
 
 
+/* -- Keyboard backlight (Surface Pro Flex / Type Cover 045E:09AE). --------- */
+
+static u8 surface_kbd_bl_raw_to_idx(struct surface_hid_device *shid, u8 raw)
+{
+	u8 i;
+
+	for (i = 0; i < 4; i++) {
+		if (shid->kbd_bl_levels[i] >= raw)
+			return i;
+	}
+	return 3;
+}
+
+static enum led_brightness surface_kbd_bl_get(struct led_classdev *cdev)
+{
+	struct surface_hid_device *shid =
+		container_of(cdev, struct surface_hid_device, kbd_bl_led);
+	u8 buf[2] = { 0xd6, 0 };
+
+	if (surface_hid_is_hot_removed(shid))
+		return shid->kbd_bl_cur;
+
+	if (shid->ops.get_feature_report(shid, 0xd6, buf, sizeof(buf)) < 0)
+		return shid->kbd_bl_cur;
+
+	shid->kbd_bl_cur = surface_kbd_bl_raw_to_idx(shid, buf[1]);
+	return shid->kbd_bl_cur;
+}
+
+static int surface_kbd_bl_set(struct led_classdev *cdev, enum led_brightness value)
+{
+	struct surface_hid_device *shid =
+		container_of(cdev, struct surface_hid_device, kbd_bl_led);
+	u8 idx = clamp_t(u8, value, 0, 3);
+	u8 buf[2] = { 0xd5, shid->kbd_bl_levels[idx] };
+	int ret;
+
+	if (surface_hid_is_hot_removed(shid))
+		return -ENODEV;
+
+	ret = shid->ops.output_report(shid, 0xd5, buf, sizeof(buf));
+	if (ret < 0)
+		return ret;
+
+	shid->kbd_bl_cur = idx;
+	return 0;
+}
+
+static void surface_kbd_bl_work_fn(struct work_struct *work)
+{
+	struct surface_hid_device *shid =
+		container_of(work, struct surface_hid_device, kbd_bl_work);
+	u8 prev = shid->kbd_bl_cur;
+	u8 hw_idx = surface_kbd_bl_get(&shid->kbd_bl_led);
+
+	if (hw_idx == prev) {
+		u8 next = (prev + 1) % 4;
+
+		surface_kbd_bl_set(&shid->kbd_bl_led, next);
+	}
+
+	led_classdev_notify_brightness_hw_changed(&shid->kbd_bl_led, shid->kbd_bl_cur);
+}
+
+static void surface_hid_kbd_bl_init(struct surface_hid_device *shid)
+{
+	u8 feat[5] = { 0xd5, 0 };
+	u8 cur[2] = { 0xd6, 0 };
+
+	if (shid->hid->vendor != 0x045e || shid->hid->product != 0x09ae)
+		return;
+
+	if (shid->ops.get_feature_report(shid, 0xd5, feat, sizeof(feat)) < 0 ||
+	    feat[4] == 0)
+		return;
+
+	memcpy(shid->kbd_bl_levels, &feat[1], 4);
+	if (shid->ops.get_feature_report(shid, 0xd6, cur, sizeof(cur)) >= 0)
+		shid->kbd_bl_cur = surface_kbd_bl_raw_to_idx(shid, cur[1]);
+
+	INIT_WORK(&shid->kbd_bl_work, surface_kbd_bl_work_fn);
+	shid->kbd_bl_led.name = "surface::kbd_backlight";
+	shid->kbd_bl_led.max_brightness = 3;
+	shid->kbd_bl_led.flags = LED_BRIGHT_HW_CHANGED;
+	shid->kbd_bl_led.brightness_set_blocking = surface_kbd_bl_set;
+	shid->kbd_bl_led.brightness_get = surface_kbd_bl_get;
+	shid->kbd_bl_led.brightness = shid->kbd_bl_cur;
+
+	if (led_classdev_register(shid->dev, &shid->kbd_bl_led) == 0)
+		shid->has_kbd_bl = true;
+}
+
 /* -- Common device setup. -------------------------------------------------- */
 
 int surface_hid_device_add(struct surface_hid_device *shid)
@@ -218,15 +310,23 @@ int surface_hid_device_add(struct surface_hid_device *shid)
 	shid->hid->ll_driver = &surface_hid_ll_driver;
 
 	status = hid_add_device(shid->hid);
-	if (status)
+	if (status) {
 		hid_destroy_device(shid->hid);
+		return status;
+	}
 
-	return status;
+	surface_hid_kbd_bl_init(shid);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(surface_hid_device_add);
 
 void surface_hid_device_destroy(struct surface_hid_device *shid)
 {
+	if (shid->has_kbd_bl) {
+		cancel_work_sync(&shid->kbd_bl_work);
+		led_classdev_unregister(&shid->kbd_bl_led);
+		shid->has_kbd_bl = false;
+	}
 	hid_destroy_device(shid->hid);
 }
 EXPORT_SYMBOL_GPL(surface_hid_device_destroy);
diff --git a/drivers/hid/surface-hid/surface_hid_core.h b/drivers/hid/surface-hid/surface_hid_core.h
index 4b1a7b5..c874489 100644
--- a/drivers/hid/surface-hid/surface_hid_core.h
+++ b/drivers/hid/surface-hid/surface_hid_core.h
@@ -11,8 +11,10 @@
 #define SURFACE_HID_CORE_H
 
 #include <linux/hid.h>
+#include <linux/leds.h>
 #include <linux/pm.h>
 #include <linux/types.h>
+#include <linux/workqueue.h>
 
 #include <linux/surface_aggregator/controller.h>
 #include <linux/surface_aggregator/device.h>
@@ -67,6 +69,12 @@ struct surface_hid_device {
 	struct hid_device *hid;
 
 	struct surface_hid_device_ops ops;
+
+	struct led_classdev kbd_bl_led;
+	struct work_struct kbd_bl_work;
+	u8 kbd_bl_levels[4];
+	u8 kbd_bl_cur;
+	bool has_kbd_bl;
 };
 
 int surface_hid_device_add(struct surface_hid_device *shid);
-- 
2.56.0

