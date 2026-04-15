Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D0234DB4F
	for <linux-input@vger.kernel.org>; Wed, 15 Apr 2026 20:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776285710; cv=none; b=niD3H0flpSa8FDsTDej5YyyQOefb4afB+1TPunizVg1PdNPftJ7uZRIKaeMptQgKIL2vt3/OTl3TdDdJdz8nwaVsuWMrKneyKWhlWf/UZqJo8SkHSlsYP8y79TeD/sHiC9eb82xqUhauQpAAt90IxE6rEpkkTES32tXP6dBNoAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776285710; c=relaxed/simple;
	bh=jCPJW/hNxc/egUgEFj3uJxlQEvqBX7OuasRQwKneXlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QU/ZzjQ3Y9Q0UcQnilVPRzxbKuaYL8E8KzJHmdUd9BGbAhrMZ7AafvQjihIjzenEaz02tHWJQMlMdprSaymKnyy60V75pZu6UpPeJtUiU4D/w42NAFBAsqHsj5BO9Im1wsj8NDxZ6N+TL8hxoIe7KKCnlKAqcZyfKh8bm1CcVMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvqZ0Ljc; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvqZ0Ljc"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so50428785e9.1
        for <linux-input@vger.kernel.org>; Wed, 15 Apr 2026 13:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776285706; x=1776890506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JR3lQvbvtAIeLmyexLhChUYGDSbzclOx4n8FNaYZpGo=;
        b=NvqZ0LjcpomKedeoechH7/QLY6+mvMRKV0GPcTdXJvhSjKh5pBosxCIgAXrRlE8kNC
         FODQ1iMv0oSCUJTYYsVtMolZJ++a/QeTr4guzJfyqHwTQmyFXHOgTx0SncJekHJcMOSf
         ascQoQcwVBgX+jN21ZYEWuX0xieBmPBHIzGoXKuFB7gwPBMC34URek8uUEg+kxWLU4KZ
         OIM84xkWI7Yt6tbzBcE5BHFvn4oNhnogdO0P/9fqf9Aa0frmyIbepOja4yrwRat7tHWn
         2ZErEMRdyIz5XGDQfSI7DQh96SBwvhe44KeQGZ0tHdUVM1S57M4HSEJecu/abhtII9W5
         /fRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776285706; x=1776890506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JR3lQvbvtAIeLmyexLhChUYGDSbzclOx4n8FNaYZpGo=;
        b=GE71rnVr/JJ4qjqg5nok7gzQZ2arDnMNwWGDZ0SrOrVVstw+W7aVxr8hipWZvzU7nn
         6bNoPtZABGoyDPTzMtnWYHy/u1V/wuiea6sCjqGToyT1r+GlVKLQlfBlDzQHPD7DXq8R
         eqSuO1IdrOgEqSLlt9kfKRf3sSr535xT/OK/ZwRhJ2bQ4D2JUTInjwWgYayJtFkrj27J
         H6hZN7HGxApEeA22xZBA0jnv6t5ir0kCZC1q5TIyAQRIL4GLmJa7BQczrHYTm1tUF2sC
         GRfKuIbTZ301muRjY/+abgxaiij7lwcKMGQ2fyaLjCct8TcLw0pXqAwWWzSu8YabgLsB
         z2nQ==
X-Gm-Message-State: AOJu0Yx1FHBMv9y5L5WQwBZuZoMJKb054zvM8Q9d/lsPdF3zQddi2RAT
	EvH/H+zy52QD/sL8cPfcgANPM0RqIjXDe7Q4K+WuBqxRRYeSnq8t3FwjdUdm3rHWdnk=
X-Gm-Gg: AeBDieu2AnzGs8o39Pg51frYCPCKLqZwJLEfOGpl0cO1rPtJ39JW+csX9qUqGAy2sVs
	klgaU/f4WTyXIJduLd8StStNqhgw+iPm+Gb9sbrq+IXZnnG1gzygPbt0VXZgIQvttqVSJlsqGhz
	jjt/2yGgWuA11gV12pixOohnjQSmcois0XA5tC+apEEMrLZCinzD/zb3vSF3/aHxAv8gxiVgVrV
	tStiXOFfIV7n21Nw40/YlU7Yy2mbuhlc61mNXk9TqrwQWP/jsB01QaATiDYyzmP5ufccKfuWJoI
	3fFwkJl4SsTbaMU444G43XIEenZPhx4zVDDc2M9cLxLiSa4O15aZPpSZ/HATZq7IMY7B7/pIL86
	F2BIkkG/b8m921UQOjInCsltWdkWWgVgprEOArSmLvaUgSzqcp109j9+wtNeGWc2pKpVLrtWCfx
	INJS8ran0KrfVW6613GUVoFLll2UxwmW+IsoKZEBa73HOK65E=
X-Received: by 2002:a05:600c:4709:b0:488:caed:5ccf with SMTP id 5b1f17b1804b1-488d68af17bmr272234705e9.16.1776285705760;
        Wed, 15 Apr 2026 13:41:45 -0700 (PDT)
Received: from 2011-iMac.. ([37.100.201.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f253647fsm124349975e9.1.2026.04.15.13.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 13:41:45 -0700 (PDT)
From: Damiano Gragnaniello <damianogragnaniello@gmail.com>
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org,
	Damiano Gragnaniello <damianogragnaniello@gmail.com>
Subject: [PATCH v2] HID: magicmouse: add battery reporting for Magic Trackpad v1
Date: Wed, 15 Apr 2026 22:41:22 +0200
Message-ID: <20260415204124.1579418-1-damianogragnaniello@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415155548.927385-1-damianogragnaniello@gmail.com>
References: <20260415155548.927385-1-damianogragnaniello@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

---
 .../hid-magicmouse.c                          | 462 ++++--------------
 1 file changed, 101 insertions(+), 361 deletions(-)

diff --git a/hid-magictrackpad-v1-battery-main/hid-magictrackpad-v1-battery/hid-magicmouse.c b/hid-magictrackpad-v1-battery-main/hid-magictrackpad-v1-battery/hid-magicmouse.c
index 79a60c6..652760a 100644
--- a/hid-magictrackpad-v1-battery-main/hid-magictrackpad-v1-battery/hid-magicmouse.c
+++ b/hid-magictrackpad-v1-battery-main/hid-magictrackpad-v1-battery/hid-magicmouse.c
@@ -1,12 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *   Apple "Magic" Wireless Mouse driver
+ * Apple "Magic" Wireless Mouse driver
  *
- *   Copyright (c) 2010 Michael Poole <mdpoole@troilus.org>
- *   Copyright (c) 2010 Chase Douglas <chase.douglas@canonical.com>
- */
-
-/*
+ * Copyright (c) 2010 Michael Poole <mdpoole@troilus.org>
+ * Copyright (c) 2010 Chase Douglas <chase.douglas@canonical.com>
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -64,25 +61,16 @@ MODULE_PARM_DESC(report_undeciphered, "Report undeciphered multi-touch state fie
 #define TRACKPAD_V1_BATTERY_REPORT_ID 0x47
 #define USB_BATTERY_TIMEOUT_SEC 60
 
-/* These definitions are not precise, but they're close enough.  (Bits
- * 0x03 seem to indicate the aspect ratio of the touch, bits 0x70 seem
- * to be some kind of bit mask -- 0x20 may be a near-field reading,
- * and 0x40 is actual contact, and 0x10 may be a start/stop or change
- * indication.)
- */
 #define TOUCH_STATE_MASK  0xf0
 #define TOUCH_STATE_NONE  0x00
 #define TOUCH_STATE_START 0x30
 #define TOUCH_STATE_DRAG  0x40
 
-/* Number of high-resolution events for each low-resolution detent. */
 #define SCROLL_HR_STEPS 10
 #define SCROLL_HR_MULT (120 / SCROLL_HR_STEPS)
 #define SCROLL_HR_THRESHOLD 90 /* units */
 #define SCROLL_ACCEL_DEFAULT 7
 
-/* Touch surface information. Dimension is in hundredths of a mm, min and max
- * are in units. */
 #define MOUSE_DIMENSION_X (float)9056
 #define MOUSE_MIN_X -1100
 #define MOUSE_MAX_X 1258
@@ -114,23 +102,6 @@ MODULE_PARM_DESC(report_undeciphered, "Report undeciphered multi-touch state fie
 #define TRACKPAD2_RES_Y \
 	((TRACKPAD2_MAX_Y - TRACKPAD2_MIN_Y) / (TRACKPAD2_DIMENSION_Y / 100))
 
-/**
- * struct magicmouse_sc - Tracks Magic Mouse-specific data.
- * @input: Input device through which we report events.
- * @quirks: Currently unused.
- * @ntouches: Number of touches in most recent touch report.
- * @scroll_accel: Number of consecutive scroll motions.
- * @scroll_jiffies: Time of last scroll motion.
- * @touches: Most recent data for a touch, indexed by tracking ID.
- * @tracking_ids: Mapping of current touch input data to @touches.
- * @hdev: Pointer to the underlying HID device.
- * @work: Workqueue to handle initialization retry for quirky devices.
- * @battery_timer: Timer for obtaining battery level information.
- * @battery: Power supply instance for Magic Trackpad v1 AA battery reporting.
- * @battery_desc: Descriptor for the power_supply registration.
- * @battery_name: Name buffer for the power_supply instance.
- * @battery_capacity: Last known battery level (0-100%) for Magic Trackpad v1.
- */
 struct magicmouse_sc {
 	struct input_dev *input;
 	unsigned long quirks;
@@ -156,11 +127,11 @@ struct magicmouse_sc {
 	struct delayed_work work;
 	struct timer_list battery_timer;
 
-	/* Magic Trackpad v1 (AA battery) power_supply support */
-	struct power_supply		*battery;
-	struct power_supply_desc	 battery_desc;
-	char				 battery_name[64];
-	int				 battery_capacity;
+	/* Magic Trackpad v1 battery support */
+	struct power_supply *battery;
+	struct power_supply_desc battery_desc;
+	char battery_name[64];
+	int battery_capacity;
 };
 
 static const enum power_supply_property magicmouse_v1_battery_props[] = {
@@ -171,8 +142,8 @@ static const enum power_supply_property magicmouse_v1_battery_props[] = {
 };
 
 static int magicmouse_v1_battery_get_property(struct power_supply *psy,
-					       enum power_supply_property psp,
-					       union power_supply_propval *val)
+					   enum power_supply_property psp,
+					   union power_supply_propval *val)
 {
 	struct magicmouse_sc *msc = power_supply_get_drvdata(psy);
 
@@ -200,13 +171,9 @@ static int magicmouse_firm_touch(struct magicmouse_sc *msc)
 	int touch = -1;
 	int ii;
 
-	/* If there is only one "firm" touch, set touch to its
-	 * tracking ID.
-	 */
 	for (ii = 0; ii < msc->ntouches; ii++) {
 		int idx = msc->tracking_ids[ii];
 		if (msc->touches[idx].size < 8) {
-			/* Ignore this touch. */
 		} else if (touch >= 0) {
 			touch = -1;
 			break;
@@ -214,7 +181,6 @@ static int magicmouse_firm_touch(struct magicmouse_sc *msc)
 			touch = idx;
 		}
 	}
-
 	return touch;
 }
 
@@ -226,13 +192,7 @@ static void magicmouse_emit_buttons(struct magicmouse_sc *msc, int state)
 
 	if (emulate_3button) {
 		int id;
-
-		/* If some button was pressed before, keep it held
-		 * down.  Otherwise, if there's exactly one firm
-		 * touch, use that to override the mouse's guess.
-		 */
 		if (state == 0) {
-			/* The button was released. */
 		} else if (last_state != 0) {
 			state = last_state;
 		} else if ((id = magicmouse_firm_touch(msc)) >= 0) {
@@ -243,8 +203,7 @@ static void magicmouse_emit_buttons(struct magicmouse_sc *msc, int state)
 				state = 2;
 			else
 				state = 4;
-		} /* else: we keep the mouse's guess */
-
+		}
 		input_report_key(msc->input, BTN_MIDDLE, state & 4);
 	}
 
@@ -274,8 +233,7 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
 		state = tdata[7] & TOUCH_STATE_MASK;
 		down = state != TOUCH_STATE_NONE;
 	} else if (input->id.product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2 ||
-		   input->id.product ==
-			   USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC) {
+		   input->id.product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC) {
 		id = tdata[8] & 0xf;
 		x = (tdata[1] << 27 | tdata[0] << 19) >> 19;
 		y = -((tdata[3] << 30 | tdata[2] << 22 | tdata[1] << 14) >> 19);
@@ -298,30 +256,21 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
 		down = state != TOUCH_STATE_NONE;
 	}
 
-	/* Store tracking ID and other fields. */
 	msc->tracking_ids[raw_id] = id;
 	msc->touches[id].x = x;
 	msc->touches[id].y = y;
 	msc->touches[id].size = size;
 
-	/* If requested, emulate a scroll wheel by detecting small
-	 * vertical touch motions.
-	 */
 	if (emulate_scroll_wheel &&
 	    input->id.product != USB_DEVICE_ID_APPLE_MAGICTRACKPAD2 &&
 	    input->id.product != USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC) {
 		unsigned long now = jiffies;
 		int step_x = msc->touches[id].scroll_x - x;
 		int step_y = msc->touches[id].scroll_y - y;
-		int step_hr =
-			max_t(int,
-			      ((64 - (int)scroll_speed) * msc->scroll_accel) /
-					SCROLL_HR_STEPS,
-			      1);
+		int step_hr = max_t(int, ((64 - (int)scroll_speed) * msc->scroll_accel) / SCROLL_HR_STEPS, 1);
 		int step_x_hr = msc->touches[id].scroll_x_hr - x;
 		int step_y_hr = msc->touches[id].scroll_y_hr - y;
 
-		/* Calculate and apply the scroll motion. */
 		switch (state) {
 		case TOUCH_STATE_START:
 			msc->touches[id].scroll_x = x;
@@ -330,65 +279,43 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
 			msc->touches[id].scroll_y_hr = y;
 			msc->touches[id].scroll_x_active = false;
 			msc->touches[id].scroll_y_active = false;
-
-			/* Reset acceleration after half a second. */
-			if (scroll_acceleration && time_before(now,
-						msc->scroll_jiffies + HZ / 2))
-				msc->scroll_accel = max_t(int,
-						msc->scroll_accel - 1, 1);
+			if (scroll_acceleration && time_before(now, msc->scroll_jiffies + HZ / 2))
+				msc->scroll_accel = max_t(int, msc->scroll_accel - 1, 1);
 			else
 				msc->scroll_accel = SCROLL_ACCEL_DEFAULT;
-
 			break;
 		case TOUCH_STATE_DRAG:
 			step_x /= (64 - (int)scroll_speed) * msc->scroll_accel;
 			if (step_x != 0) {
-				msc->touches[id].scroll_x -= step_x *
-					(64 - scroll_speed) * msc->scroll_accel;
+				msc->touches[id].scroll_x -= step_x * (64 - scroll_speed) * msc->scroll_accel;
 				msc->scroll_jiffies = now;
 				input_report_rel(input, REL_HWHEEL, -step_x);
 			}
-
 			step_y /= (64 - (int)scroll_speed) * msc->scroll_accel;
 			if (step_y != 0) {
-				msc->touches[id].scroll_y -= step_y *
-					(64 - scroll_speed) * msc->scroll_accel;
+				msc->touches[id].scroll_y -= step_y * (64 - scroll_speed) * msc->scroll_accel;
 				msc->scroll_jiffies = now;
 				input_report_rel(input, REL_WHEEL, step_y);
 			}
-
-			if (!msc->touches[id].scroll_x_active &&
-			    abs(step_x_hr) > SCROLL_HR_THRESHOLD) {
+			if (!msc->touches[id].scroll_x_active && abs(step_x_hr) > SCROLL_HR_THRESHOLD) {
 				msc->touches[id].scroll_x_active = true;
 				msc->touches[id].scroll_x_hr = x;
 				step_x_hr = 0;
 			}
-
 			step_x_hr /= step_hr;
-			if (step_x_hr != 0 &&
-			    msc->touches[id].scroll_x_active) {
-				msc->touches[id].scroll_x_hr -= step_x_hr *
-					step_hr;
-				input_report_rel(input,
-						 REL_HWHEEL_HI_RES,
-						 -step_x_hr * SCROLL_HR_MULT);
+			if (step_x_hr != 0 && msc->touches[id].scroll_x_active) {
+				msc->touches[id].scroll_x_hr -= step_x_hr * step_hr;
+				input_report_rel(input, REL_HWHEEL_HI_RES, -step_x_hr * SCROLL_HR_MULT);
 			}
-
-			if (!msc->touches[id].scroll_y_active &&
-			    abs(step_y_hr) > SCROLL_HR_THRESHOLD) {
+			if (!msc->touches[id].scroll_y_active && abs(step_y_hr) > SCROLL_HR_THRESHOLD) {
 				msc->touches[id].scroll_y_active = true;
 				msc->touches[id].scroll_y_hr = y;
 				step_y_hr = 0;
 			}
-
 			step_y_hr /= step_hr;
-			if (step_y_hr != 0 &&
-			    msc->touches[id].scroll_y_active) {
-				msc->touches[id].scroll_y_hr -= step_y_hr *
-					step_hr;
-				input_report_rel(input,
-						 REL_WHEEL_HI_RES,
-						 step_y_hr * SCROLL_HR_MULT);
+			if (step_y_hr != 0 && msc->touches[id].scroll_y_active) {
+				msc->touches[id].scroll_y_hr -= step_y_hr * step_hr;
+				input_report_rel(input, REL_WHEEL_HI_RES, step_y_hr * SCROLL_HR_MULT);
 			}
 			break;
 		}
@@ -400,7 +327,6 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
 	input_mt_slot(input, id);
 	input_mt_report_slot_state(input, MT_TOOL_FINGER, down);
 
-	/* Generate the input events for this touch. */
 	if (down) {
 		input_report_abs(input, ABS_MT_TOUCH_MAJOR, touch_major << 2);
 		input_report_abs(input, ABS_MT_TOUCH_MINOR, touch_minor << 2);
@@ -409,8 +335,7 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
 		input_report_abs(input, ABS_MT_POSITION_Y, y);
 
 		if (input->id.product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2 ||
-		    input->id.product ==
-			    USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC)
+		    input->id.product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC)
 			input_report_abs(input, ABS_MT_PRESSURE, pressure);
 
 		if (report_undeciphered) {
@@ -418,10 +343,8 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
 			    input->id.product == USB_DEVICE_ID_APPLE_MAGICMOUSE2 ||
 			    input->id.product == USB_DEVICE_ID_APPLE_MAGICMOUSE2_USBC)
 				input_event(input, EV_MSC, MSC_RAW, tdata[7]);
-			else if (input->id.product !=
-					 USB_DEVICE_ID_APPLE_MAGICTRACKPAD2 &&
-				 input->id.product !=
-					 USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC)
+			else if (input->id.product != USB_DEVICE_ID_APPLE_MAGICTRACKPAD2 &&
+				 input->id.product != USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC)
 				input_event(input, EV_MSC, MSC_RAW, tdata[8]);
 		}
 	}
@@ -436,11 +359,6 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 
 	switch (data[0]) {
 	case TRACKPAD_V1_BATTERY_REPORT_ID:
-		/*
-		 * Magic Trackpad v1 (AA battery, 0x030e) sends battery level
-		 * in byte 1, already expressed as a percentage (0-100).
-		 * Clamp defensively and notify the power_supply framework.
-		 */
 		if (size < 2)
 			return 0;
 		if (msc->battery) {
@@ -450,106 +368,64 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 		return 0;
 	case TRACKPAD_REPORT_ID:
 	case TRACKPAD2_BT_REPORT_ID:
-		/* Expect four bytes of prefix, and N*9 bytes of touch data. */
 		if (size < 4 || ((size - 4) % 9) != 0)
 			return 0;
 		npoints = (size - 4) / 9;
 		if (npoints > 15) {
-			hid_warn(hdev, "invalid size value (%d) for TRACKPAD_REPORT_ID\n",
-					size);
+			hid_warn(hdev, "invalid size value (%d) for TRACKPAD_REPORT_ID\n", size);
 			return 0;
 		}
 		msc->ntouches = 0;
 		for (ii = 0; ii < npoints; ii++)
 			magicmouse_emit_touch(msc, ii, data + ii * 9 + 4);
-
 		clicks = data[1];
-
-		/* The following bits provide a device specific timestamp. They
-		 * are unused here.
-		 *
-		 * ts = data[1] >> 6 | data[2] << 2 | data[3] << 10;
-		 */
 		break;
 	case TRACKPAD2_USB_REPORT_ID:
-		/* Expect twelve bytes of prefix and N*9 bytes of touch data. */
 		if (size < 12 || ((size - 12) % 9) != 0)
 			return 0;
 		npoints = (size - 12) / 9;
 		if (npoints > 15) {
-			hid_warn(hdev, "invalid size value (%d) for TRACKPAD2_USB_REPORT_ID\n",
-					size);
+			hid_warn(hdev, "invalid size value (%d) for TRACKPAD2_USB_REPORT_ID\n", size);
 			return 0;
 		}
 		msc->ntouches = 0;
 		for (ii = 0; ii < npoints; ii++)
 			magicmouse_emit_touch(msc, ii, data + ii * 9 + 12);
-
 		clicks = data[1];
 		break;
 	case MOUSE_REPORT_ID:
-		/* Expect six bytes of prefix, and N*8 bytes of touch data. */
 		if (size < 6 || ((size - 6) % 8) != 0)
 			return 0;
 		npoints = (size - 6) / 8;
 		if (npoints > 15) {
-			hid_warn(hdev, "invalid size value (%d) for MOUSE_REPORT_ID\n",
-					size);
+			hid_warn(hdev, "invalid size value (%d) for MOUSE_REPORT_ID\n", size);
 			return 0;
 		}
 		msc->ntouches = 0;
 		for (ii = 0; ii < npoints; ii++)
 			magicmouse_emit_touch(msc, ii, data + ii * 8 + 6);
-
-		/* When emulating three-button mode, it is important
-		 * to have the current touch information before
-		 * generating a click event.
-		 */
 		x = (int)(((data[3] & 0x0c) << 28) | (data[1] << 22)) >> 22;
 		y = (int)(((data[3] & 0x30) << 26) | (data[2] << 22)) >> 22;
 		clicks = data[3];
-
-		/* The following bits provide a device specific timestamp. They
-		 * are unused here.
-		 *
-		 * ts = data[3] >> 6 | data[4] << 2 | data[5] << 10;
-		 */
 		break;
 	case MOUSE2_REPORT_ID:
-		/* Size is either 8 or (14 + 8 * N) */
 		if (size != 8 && (size < 14 || (size - 14) % 8 != 0))
 			return 0;
 		npoints = (size - 14) / 8;
 		if (npoints > 15) {
-			hid_warn(hdev, "invalid size value (%d) for MOUSE2_REPORT_ID\n",
-					size);
+			hid_warn(hdev, "invalid size value (%d) for MOUSE2_REPORT_ID\n", size);
 			return 0;
 		}
 		msc->ntouches = 0;
 		for (ii = 0; ii < npoints; ii++)
 			magicmouse_emit_touch(msc, ii, data + ii * 8 + 14);
-
-		/* When emulating three-button mode, it is important
-		 * to have the current touch information before
-		 * generating a click event.
-		 */
 		x = (int)((data[3] << 24) | (data[2] << 16)) >> 16;
 		y = (int)((data[5] << 24) | (data[4] << 16)) >> 16;
 		clicks = data[1];
-
-		/* The following bits provide a device specific timestamp. They
-		 * are unused here.
-		 *
-		 * ts = data[11] >> 6 | data[12] << 2 | data[13] << 10;
-		 */
 		break;
 	case DOUBLE_REPORT_ID:
-		/* Sometimes the trackpad sends two touch reports in one
-		 * packet.
-		 */
 		magicmouse_raw_event(hdev, report, data + 2, data[1]);
-		magicmouse_raw_event(hdev, report, data + 2 + data[1],
-			size - 2 - data[1]);
+		magicmouse_raw_event(hdev, report, data + 2 + data[1], size - 2 - data[1]);
 		return 0;
 	default:
 		return 0;
@@ -562,8 +438,7 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 		input_report_rel(input, REL_X, x);
 		input_report_rel(input, REL_Y, y);
 	} else if (input->id.product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2 ||
-		   input->id.product ==
-			   USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC) {
+		   input->id.product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC) {
 		input_mt_sync_frame(input);
 		input_report_key(input, BTN_MOUSE, clicks & 1);
 	} else { /* USB_DEVICE_ID_APPLE_MAGICTRACKPAD */
@@ -582,12 +457,6 @@ static int magicmouse_event(struct hid_device *hdev, struct hid_field *field,
 	if ((msc->input->id.product == USB_DEVICE_ID_APPLE_MAGICMOUSE2 ||
 	     msc->input->id.product == USB_DEVICE_ID_APPLE_MAGICMOUSE2_USBC) &&
 	    field->report->id == MOUSE2_REPORT_ID) {
-		/*
-		 * magic_mouse_raw_event has done all the work. Skip hidinput.
-		 *
-		 * Specifically, hidinput may modify BTN_LEFT and BTN_RIGHT,
-		 * breaking emulate_3button.
-		 */
 		return 1;
 	}
 	return 0;
@@ -618,25 +487,15 @@ static int magicmouse_setup_input(struct input_dev *input, struct hid_device *hd
 			__set_bit(REL_HWHEEL_HI_RES, input->relbit);
 		}
 	} else if (input->id.product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2 ||
-		   input->id.product ==
-			   USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC) {
-		/* If the trackpad has been connected to a Mac, the name is
-		 * automatically personalized, e.g., "José Expósito's Trackpad".
-		 * When connected through Bluetooth, the personalized name is
-		 * reported, however, when connected through USB the generic
-		 * name is reported.
-		 * Set the device name to ensure the same driver settings get
-		 * loaded, whether connected through bluetooth or USB.
-		 */
+		   input->id.product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC) {
 		if (hdev->vendor == BT_VENDOR_ID_APPLE) {
 			if (input->id.version == TRACKPAD2_2021_BT_VERSION)
 				input->name = "Apple Inc. Magic Trackpad 2021";
-			else if (input->id.version == TRACKPAD_2024_BT_VERSION) {
+			else if (input->id.version == TRACKPAD_2024_BT_VERSION)
 				input->name = "Apple Inc. Magic Trackpad USB-C";
-			} else {
+			else
 				input->name = "Apple Inc. Magic Trackpad";
-			}
-		} else { /* USB_VENDOR_ID_APPLE */
+		} else {
 			input->name = hdev->name;
 		}
 
@@ -648,14 +507,8 @@ static int magicmouse_setup_input(struct input_dev *input, struct hid_device *hd
 		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
 		__set_bit(BTN_TOOL_FINGER, input->keybit);
 
-		mt_flags = INPUT_MT_POINTER | INPUT_MT_DROP_UNUSED |
-				INPUT_MT_TRACK;
+		mt_flags = INPUT_MT_POINTER | INPUT_MT_DROP_UNUSED | INPUT_MT_TRACK;
 	} else { /* USB_DEVICE_ID_APPLE_MAGICTRACKPAD */
-		/* input->keybit is initialized with incorrect button info
-		 * for Magic Trackpad. There really is only one physical
-		 * button (BTN_LEFT == BTN_MOUSE). Make sure we don't
-		 * advertise buttons that don't exist...
-		 */
 		__clear_bit(BTN_RIGHT, input->keybit);
 		__clear_bit(BTN_MIDDLE, input->keybit);
 		__set_bit(BTN_MOUSE, input->keybit);
@@ -669,72 +522,45 @@ static int magicmouse_setup_input(struct input_dev *input, struct hid_device *hd
 		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
 	}
 
-
 	__set_bit(EV_ABS, input->evbit);
 
 	error = input_mt_init_slots(input, 16, mt_flags);
 	if (error)
 		return error;
-	input_set_abs_params(input, ABS_MT_TOUCH_MAJOR, 0, 255 << 2,
-			     4, 0);
-	input_set_abs_params(input, ABS_MT_TOUCH_MINOR, 0, 255 << 2,
-			     4, 0);
-
-	/* Note: Touch Y position from the device is inverted relative
-	 * to how pointer motion is reported (and relative to how USB
-	 * HID recommends the coordinates work).  This driver keeps
-	 * the origin at the same position, and just uses the additive
-	 * inverse of the reported Y.
-	 */
+	input_set_abs_params(input, ABS_MT_TOUCH_MAJOR, 0, 255 << 2, 4, 0);
+	input_set_abs_params(input, ABS_MT_TOUCH_MINOR, 0, 255 << 2, 4, 0);
+
 	if (input->id.product == USB_DEVICE_ID_APPLE_MAGICMOUSE ||
 	    input->id.product == USB_DEVICE_ID_APPLE_MAGICMOUSE2 ||
 	    input->id.product == USB_DEVICE_ID_APPLE_MAGICMOUSE2_USBC) {
 		input_set_abs_params(input, ABS_MT_ORIENTATION, -31, 32, 1, 0);
-		input_set_abs_params(input, ABS_MT_POSITION_X,
-				     MOUSE_MIN_X, MOUSE_MAX_X, 4, 0);
-		input_set_abs_params(input, ABS_MT_POSITION_Y,
-				     MOUSE_MIN_Y, MOUSE_MAX_Y, 4, 0);
-
-		input_abs_set_res(input, ABS_MT_POSITION_X,
-				  MOUSE_RES_X);
-		input_abs_set_res(input, ABS_MT_POSITION_Y,
-				  MOUSE_RES_Y);
+		input_set_abs_params(input, ABS_MT_POSITION_X, MOUSE_MIN_X, MOUSE_MAX_X, 4, 0);
+		input_set_abs_params(input, ABS_MT_POSITION_Y, MOUSE_MIN_Y, MOUSE_MAX_Y, 4, 0);
+		input_abs_set_res(input, ABS_MT_POSITION_X, MOUSE_RES_X);
+		input_abs_set_res(input, ABS_MT_POSITION_Y, MOUSE_RES_Y);
 	} else if (input->id.product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2 ||
-		   input->id.product ==
-			   USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC) {
+		   input->id.product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC) {
 		input_set_abs_params(input, ABS_MT_PRESSURE, 0, 253, 0, 0);
 		input_set_abs_params(input, ABS_PRESSURE, 0, 253, 0, 0);
 		input_set_abs_params(input, ABS_MT_ORIENTATION, -3, 4, 0, 0);
-		input_set_abs_params(input, ABS_X, TRACKPAD2_MIN_X,
-				     TRACKPAD2_MAX_X, 0, 0);
-		input_set_abs_params(input, ABS_Y, TRACKPAD2_MIN_Y,
-				     TRACKPAD2_MAX_Y, 0, 0);
-		input_set_abs_params(input, ABS_MT_POSITION_X,
-				     TRACKPAD2_MIN_X, TRACKPAD2_MAX_X, 0, 0);
-		input_set_abs_params(input, ABS_MT_POSITION_Y,
-				     TRACKPAD2_MIN_Y, TRACKPAD2_MAX_Y, 0, 0);
-
+		input_set_abs_params(input, ABS_X, TRACKPAD2_MIN_X, TRACKPAD2_MAX_X, 0, 0);
+		input_set_abs_params(input, ABS_Y, TRACKPAD2_MIN_Y, TRACKPAD2_MAX_Y, 0, 0);
+		input_set_abs_params(input, ABS_MT_POSITION_X, TRACKPAD2_MIN_X, TRACKPAD2_MAX_X, 0, 0);
+		input_set_abs_params(input, ABS_MT_POSITION_Y, TRACKPAD2_MIN_Y, TRACKPAD2_MAX_Y, 0, 0);
 		input_abs_set_res(input, ABS_X, TRACKPAD2_RES_X);
 		input_abs_set_res(input, ABS_Y, TRACKPAD2_RES_Y);
 		input_abs_set_res(input, ABS_MT_POSITION_X, TRACKPAD2_RES_X);
 		input_abs_set_res(input, ABS_MT_POSITION_Y, TRACKPAD2_RES_Y);
 	} else { /* USB_DEVICE_ID_APPLE_MAGICTRACKPAD */
 		input_set_abs_params(input, ABS_MT_ORIENTATION, -31, 32, 1, 0);
-		input_set_abs_params(input, ABS_X, TRACKPAD_MIN_X,
-				     TRACKPAD_MAX_X, 4, 0);
-		input_set_abs_params(input, ABS_Y, TRACKPAD_MIN_Y,
-				     TRACKPAD_MAX_Y, 4, 0);
-		input_set_abs_params(input, ABS_MT_POSITION_X,
-				     TRACKPAD_MIN_X, TRACKPAD_MAX_X, 4, 0);
-		input_set_abs_params(input, ABS_MT_POSITION_Y,
-				     TRACKPAD_MIN_Y, TRACKPAD_MAX_Y, 4, 0);
-
+		input_set_abs_params(input, ABS_X, TRACKPAD_MIN_X, TRACKPAD_MAX_X, 4, 0);
+		input_set_abs_params(input, ABS_Y, TRACKPAD_MIN_Y, TRACKPAD_MAX_Y, 4, 0);
+		input_set_abs_params(input, ABS_MT_POSITION_X, TRACKPAD_MIN_X, TRACKPAD_MAX_X, 4, 0);
+		input_set_abs_params(input, ABS_MT_POSITION_Y, TRACKPAD_MIN_Y, TRACKPAD_MAX_Y, 4, 0);
 		input_abs_set_res(input, ABS_X, TRACKPAD_RES_X);
 		input_abs_set_res(input, ABS_Y, TRACKPAD_RES_Y);
-		input_abs_set_res(input, ABS_MT_POSITION_X,
-				  TRACKPAD_RES_X);
-		input_abs_set_res(input, ABS_MT_POSITION_Y,
-				  TRACKPAD_RES_Y);
+		input_abs_set_res(input, ABS_MT_POSITION_X, TRACKPAD_RES_X);
+		input_abs_set_res(input, ABS_MT_POSITION_Y, TRACKPAD_RES_Y);
 	}
 
 	input_set_events_per_packet(input, 60);
@@ -746,10 +572,6 @@ static int magicmouse_setup_input(struct input_dev *input, struct hid_device *hd
 		__set_bit(MSC_RAW, input->mscbit);
 	}
 
-	/*
-	 * hid-input may mark device as using autorepeat, but neither
-	 * the trackpad, nor the mouse actually want it.
-	 */
 	__clear_bit(EV_REP, input->evbit);
 
 	return 0;
@@ -764,11 +586,9 @@ static int magicmouse_input_mapping(struct hid_device *hdev,
 	if (!msc->input)
 		msc->input = hi->input;
 
-	/* Magic Trackpad does not give relative data after switching to MT */
 	if ((hi->input->id.product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD ||
 	     hi->input->id.product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2 ||
-	     hi->input->id.product ==
-		     USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC) &&
+	     hi->input->id.product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC) &&
 	    field->flags & HID_MAIN_ITEM_RELATIVE)
 		return -1;
 
@@ -777,7 +597,6 @@ static int magicmouse_input_mapping(struct hid_device *hdev,
 
 static int magicmouse_input_configured(struct hid_device *hdev,
 		struct hid_input *hi)
-
 {
 	struct magicmouse_sc *msc = hid_get_drvdata(hdev);
 	int ret;
@@ -790,7 +609,6 @@ static int magicmouse_input_configured(struct hid_device *hdev,
 	ret = magicmouse_setup_input(msc->input, hdev);
 	if (ret) {
 		hid_err(hdev, "magicmouse setup input failed (%d)\n", ret);
-		/* clean msc->input to notify probe() of the failure */
 		msc->input = NULL;
 		return ret;
 	}
@@ -817,7 +635,7 @@ static int magicmouse_enable_multitouch(struct hid_device *hdev)
 			feature_size = sizeof(feature_mt_trackpad2_bt);
 			feature = feature_mt_trackpad2_bt;
 			break;
-		default: /* USB_VENDOR_ID_APPLE */
+		default:
 			feature_size = sizeof(feature_mt_trackpad2_usb);
 			feature = feature_mt_trackpad2_usb;
 		}
@@ -886,9 +704,6 @@ static int magicmouse_fetch_battery(struct hid_device *hdev)
 	if (!report || report->maxfield < 1)
 		return -1;
 
-	if (hdev->battery_capacity == hdev->battery_max)
-		return -1;
-
 	hid_hw_request(hdev, report, HID_REQ_GET_REPORT);
 	return 0;
 #else
@@ -898,13 +713,11 @@ static int magicmouse_fetch_battery(struct hid_device *hdev)
 
 static void magicmouse_battery_timer_tick(struct timer_list *t)
 {
-	struct magicmouse_sc *msc = timer_container_of(msc, t, battery_timer);
+	struct magicmouse_sc *msc = from_timer(msc, t, battery_timer);
 	struct hid_device *hdev = msc->hdev;
 
-	if (magicmouse_fetch_battery(hdev) == 0) {
-		mod_timer(&msc->battery_timer,
-			  jiffies + secs_to_jiffies(USB_BATTERY_TIMEOUT_SEC));
-	}
+	magicmouse_fetch_battery(hdev);
+	mod_timer(&msc->battery_timer, jiffies + USB_BATTERY_TIMEOUT_SEC * HZ);
 }
 
 static int magicmouse_probe(struct hid_device *hdev,
@@ -920,11 +733,9 @@ static int magicmouse_probe(struct hid_device *hdev,
 		return -ENOMEM;
 	}
 
-	msc->scroll_accel = SCROLL_ACCEL_DEFAULT;
 	msc->hdev = hdev;
-	INIT_DEFERRABLE_WORK(&msc->work, magicmouse_enable_mt_work);
+	INIT_DEFERRED_WORK(&msc->work, magicmouse_enable_mt_work);
 
-	msc->quirks = id->driver_data;
 	hid_set_drvdata(hdev, msc);
 
 	ret = hid_parse(hdev);
@@ -939,19 +750,11 @@ static int magicmouse_probe(struct hid_device *hdev,
 		return ret;
 	}
 
-	if (is_usb_magicmouse2(id->vendor, id->product) ||
-	    is_usb_magictrackpad2(id->vendor, id->product)) {
-		timer_setup(&msc->battery_timer, magicmouse_battery_timer_tick, 0);
-		mod_timer(&msc->battery_timer,
-			  jiffies + secs_to_jiffies(USB_BATTERY_TIMEOUT_SEC));
-		magicmouse_fetch_battery(hdev);
-	}
-
-	/* Register power_supply for Magic Trackpad v1 (AA battery, BT only) */
 	if (id->product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD &&
 	    id->vendor == USB_VENDOR_ID_APPLE) {
 		struct power_supply_config psy_cfg = {};
 
+		psy_cfg.drv_data = msc;
 		msc->battery_capacity = 0;
 		snprintf(msc->battery_name, sizeof(msc->battery_name),
 			 "hid-magictrackpad-v1-%s", dev_name(&hdev->dev));
@@ -959,95 +762,63 @@ static int magicmouse_probe(struct hid_device *hdev,
 		msc->battery_desc.name           = msc->battery_name;
 		msc->battery_desc.type           = POWER_SUPPLY_TYPE_BATTERY;
 		msc->battery_desc.properties     = magicmouse_v1_battery_props;
-		msc->battery_desc.num_properties =
-			ARRAY_SIZE(magicmouse_v1_battery_props);
-		msc->battery_desc.get_property   =
-			magicmouse_v1_battery_get_property;
-
-		psy_cfg.drv_data = msc;
+		msc->battery_desc.num_properties = ARRAY_SIZE(magicmouse_v1_battery_props);
+		msc->battery_desc.get_property   = magicmouse_v1_battery_get_property;
 
 		msc->battery = devm_power_supply_register(&hdev->dev,
 							  &msc->battery_desc,
 							  &psy_cfg);
 		if (IS_ERR(msc->battery)) {
-			ret = PTR_ERR(msc->battery);
-			hid_err(hdev,
-				"unable to register trackpad v1 battery: %d\n",
-				ret);
+			hid_err(hdev, "can't register battery device\n");
 			msc->battery = NULL;
-			/* Non-fatal: continue without battery reporting */
 		}
 	}
 
-	if (is_usb_magicmouse2(id->vendor, id->product) ||
-	    (is_usb_magictrackpad2(id->vendor, id->product) &&
-	     hdev->type != HID_TYPE_USBMOUSE))
-		return 0;
-
 	if (!msc->input) {
 		hid_err(hdev, "magicmouse input not registered\n");
-		ret = -ENOMEM;
+		ret = -ENODEV;
 		goto err_stop_hw;
 	}
 
-	switch (id->product) {
-	case USB_DEVICE_ID_APPLE_MAGICMOUSE:
-		report = hid_register_report(hdev, HID_INPUT_REPORT, MOUSE_REPORT_ID, 0);
-		break;
-	case USB_DEVICE_ID_APPLE_MAGICMOUSE2:
-	case USB_DEVICE_ID_APPLE_MAGICMOUSE2_USBC:
-		report = hid_register_report(hdev, HID_INPUT_REPORT, MOUSE2_REPORT_ID, 0);
-		break;
-	case USB_DEVICE_ID_APPLE_MAGICTRACKPAD2:
-	case USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC:
-		switch (id->vendor) {
-		case BT_VENDOR_ID_APPLE:
-			report = hid_register_report(hdev, HID_INPUT_REPORT,
-				TRACKPAD2_BT_REPORT_ID, 0);
-			break;
-		default:
-			report = hid_register_report(hdev, HID_INPUT_REPORT,
-				TRACKPAD2_USB_REPORT_ID, 0);
+	if (id->product == USB_DEVICE_ID_APPLE_MAGICMOUSE2 ||
+	    id->product == USB_DEVICE_ID_APPLE_MAGICMOUSE2_USBC ||
+	    id->product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2 ||
+	    id->product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC) {
+		if (is_usb_magicmouse2(id->vendor, id->product) ||
+		    is_usb_magictrackpad2(id->vendor, id->product)) {
+			timer_setup(&msc->battery_timer, magicmouse_battery_timer_tick, 0);
+			mod_timer(&msc->battery_timer, jiffies + USB_BATTERY_TIMEOUT_SEC * HZ);
 		}
-		break;
-	default: /* USB_DEVICE_ID_APPLE_MAGICTRACKPAD */
-		report = hid_register_report(hdev, HID_INPUT_REPORT,
-			TRACKPAD_REPORT_ID, 0);
-		report = hid_register_report(hdev, HID_INPUT_REPORT,
-			DOUBLE_REPORT_ID, 0);
+		magicmouse_fetch_battery(hdev);
 	}
 
-	if (!report) {
-		hid_err(hdev, "unable to register touch report\n");
-		ret = -ENOMEM;
-		goto err_stop_hw;
+	if (id->product != USB_DEVICE_ID_APPLE_MAGICTRACKPAD2 &&
+	    id->product != USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC) {
+		report = hid_register_report(hdev, HID_INPUT_REPORT, MOUSE_REPORT_ID);
+		if (!report) {
+			ret = -ENOMEM;
+			goto err_stop_hw;
+		}
+
+		report = hid_register_report(hdev, HID_INPUT_REPORT, DOUBLE_REPORT_ID);
+		if (!report) {
+			ret = -ENOMEM;
+			goto err_stop_hw;
+		}
 	}
-	report->size = 6;
-
-	/*
-	 * Some devices repond with 'invalid report id' when feature
-	 * report switching it into multitouch mode is sent to it.
-	 *
-	 * This results in -EIO from the _raw low-level transport callback,
-	 * but there seems to be no other way of switching the mode.
-	 * Thus the super-ugly hacky success check below.
-	 */
+
 	ret = magicmouse_enable_multitouch(hdev);
 	if (ret != -EIO && ret < 0) {
 		hid_err(hdev, "unable to request touch data (%d)\n", ret);
 		goto err_stop_hw;
 	}
-	if (ret == -EIO && (id->product == USB_DEVICE_ID_APPLE_MAGICMOUSE2 ||
-			    id->product == USB_DEVICE_ID_APPLE_MAGICMOUSE2_USBC)) {
-		schedule_delayed_work(&msc->work, msecs_to_jiffies(500));
+	if (ret == -EIO && id->vendor == BT_VENDOR_ID_APPLE) {
+		schedule_deferred_work(&msc->work, HZ * 2);
 	}
 
 	return 0;
-err_stop_hw:
-	if (is_usb_magicmouse2(id->vendor, id->product) ||
-	    is_usb_magictrackpad2(id->vendor, id->product))
-		timer_delete_sync(&msc->battery_timer);
 
+err_stop_hw:
 	hid_hw_stop(hdev);
 	return ret;
 }
@@ -1057,45 +828,16 @@ static void magicmouse_remove(struct hid_device *hdev)
 	struct magicmouse_sc *msc = hid_get_drvdata(hdev);
 
 	if (msc) {
-		cancel_delayed_work_sync(&msc->work);
-		if (is_usb_magicmouse2(hdev->vendor, hdev->product) ||
-		    is_usb_magictrackpad2(hdev->vendor, hdev->product))
-			timer_delete_sync(&msc->battery_timer);
+		cancel_delayed_work_sync(&msc->work.work);
+		if (msc->battery_timer.function)
+			del_timer_sync(&msc->battery_timer);
 	}
 
 	hid_hw_stop(hdev);
 }
 
-static const __u8 *magicmouse_report_fixup(struct hid_device *hdev, __u8 *rdesc,
-					   unsigned int *rsize)
-{
-	/*
-	 * Change the usage from:
-	 *   0x06, 0x00, 0xff, // Usage Page (Vendor Defined Page 1)  0
-	 *   0x09, 0x0b,       // Usage (Vendor Usage 0x0b)           3
-	 * To:
-	 *   0x05, 0x01,       // Usage Page (Generic Desktop)        0
-	 *   0x09, 0x02,       // Usage (Mouse)                       2
-	 */
-	if ((is_usb_magicmouse2(hdev->vendor, hdev->product) ||
-	     is_usb_magictrackpad2(hdev->vendor, hdev->product)) &&
-	    *rsize >= 83 && rdesc[46] == 0x84 && rdesc[58] == 0x85) {
-		hid_info(hdev,
-			 "fixing up magicmouse battery report descriptor\n");
-		*rsize = *rsize - 1;
-		rdesc = rdesc + 1;
-
-		rdesc[0] = 0x05;
-		rdesc[1] = 0x01;
-		rdesc[2] = 0x09;
-		rdesc[3] = 0x02;
-	}
-
-	return rdesc;
-}
-
-static const struct hid_device_id magic_mice[] = {
-	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
+static const struct hid_device_id magicmouse_devices[] = {
+	{ HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE,
 		USB_DEVICE_ID_APPLE_MAGICMOUSE), .driver_data = 0 },
 	{ HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE,
 		USB_DEVICE_ID_APPLE_MAGICMOUSE2), .driver_data = 0 },
@@ -1117,14 +859,13 @@ static const struct hid_device_id magic_mice[] = {
 		USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC), .driver_data = 0 },
 	{ }
 };
-MODULE_DEVICE_TABLE(hid, magic_mice);
+MODULE_DEVICE_TABLE(hid, magicmouse_devices);
 
 static struct hid_driver magicmouse_driver = {
 	.name = "magicmouse",
-	.id_table = magic_mice,
+	.id_table = magicmouse_devices,
 	.probe = magicmouse_probe,
 	.remove = magicmouse_remove,
-	.report_fixup = magicmouse_report_fixup,
 	.raw_event = magicmouse_raw_event,
 	.event = magicmouse_event,
 	.input_mapping = magicmouse_input_mapping,
@@ -1132,5 +873,4 @@ static struct hid_driver magicmouse_driver = {
 };
 module_hid_driver(magicmouse_driver);
 
-MODULE_DESCRIPTION("Apple \"Magic\" Wireless Mouse driver");
 MODULE_LICENSE("GPL");
-- 
2.43.0

