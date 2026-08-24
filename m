Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7E117A314
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 17:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787592655; cv=none; b=LGkkY3KOW6G2MjdiFglgktD2EX8EZM/ZGwhy3Yuz4ClN6xsUx69jG6mXTfw3vZzUzJiba83prpMPo8ytxo5kSPZh0OLW1ChRLslLZFYQI1jtVEE+gMft1Z0W2E4lQ2sP5LUuLPrbReVlhfr4MW8FyaQQHp9veKZS8cb5oCL1ens=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787592655; c=relaxed/simple;
	bh=nWO1GSXaoyCuiuYh3DbruS0pH5uFMnzK+HoHF6NsaNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d7z4Sb7QGLFucB50YfjqraO99eOopHzq5SgiHDCx4Hp84Bvt90jOe3WGzisrMhHqgVkunIbWb7IeFdpN9/jnURsmWpfHTHHreVJhMl+4bR/de7cLjDTKaBIB0Odmrf2A7FUuln2PcLzkeUFxguFrJ5rxK+DM1vPrM+BJu0DXTRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKaVloCh; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKaVloCh"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a0a4aa99bdso6447276a12.1
        for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 10:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787592652; x=1788197452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hC/nUhsi2WuqYNeJnMvfkiOk4C6aiPZaDUS5CGieaXk=;
        b=NKaVloCh4Mljl9M+NSJmj+tMzHxVmDatd/CuYmcwrxOBc9+arqhJe1t/LaUGqqznJk
         nSYrKNgVApkB4/dD42UbUYxXxn0qtgnYsXZK/o31G0HWQ/I0bRO0a+g0VxojCQMQOxA8
         ebMp6LZU1a0NvCbG88iqB3tUTtuw3yulzEcyKwOJu45HAoA7TJ7eQTQjVf6v+gigo8kd
         vTnnszSnvkXMcWckHNLecpIH52O89odup7u1tPlz5rhnr2CC0D09zAKY1PK6ijmIvHZ4
         VuUlyHZec2O7gmb36fZrQplT/NKn2OfTqy2fKX9FjbxW+1sdlEvAicY2SnDs0ycOewBb
         7QuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787592652; x=1788197452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hC/nUhsi2WuqYNeJnMvfkiOk4C6aiPZaDUS5CGieaXk=;
        b=mBNxR47EgMH4a3Qfl6jLH7uGMGBn3Q6wSiu254vZbjVk2rmh/VUeDco5fFxv92qK1m
         /TEewBg/vOlH10ktsn3AN/VtPUcB5/C3oAdb5AuxYJ8kA92UjjCzGETpnIA/Gmrawoac
         tcXppObWHVlzzmTmhyWRLc9HEUbEZcQK0tX6/0utZnLGbX+nRM1Tnhh1wIrlcwxJx5yi
         PZhM2o/5mxbMmHmbmkWEfmAOmiGwYusDCANt6xhjQnPHiJ8Gkxvq/vWMXwoEUj5vCWgz
         XnZcfFd19ZTNRrehjFUTnCsnVO1xwry/LndBV96JSotXFXvcOw30bpwitXx57ZqLpNCM
         geMg==
X-Forwarded-Encrypted: i=1; AHgh+RoawCJILqdzbqtuULY1yGw8+eoYI61RuD4hGh1Mq9ZcuxMZGz1LKVs054gBY0nhUxFHTJ56Fl6HU6K2Tw==@vger.kernel.org
X-Gm-Message-State: AFuF++kYhtxAGfVV6Pnn4YwqPw+mmEs7ouFz2Ha9WFReknjASkZzn1lJ
	XBfQivImFm830XddSYkuogRNO6/HD0AWqshl2ECuqT2nOHQ5RYyQ5tFr
X-Gm-Gg: AR+sD12B8thzOppbbUW1F6OZQ09+T4wZVOpDODFB4qxNMeVyPAJawRcxKuzxebr+Ljw
	P/NrKmL/bzpPSKsFjOfQOpYiMFHobwsd4f7a8oe2e7GyxmXbs3iagyMHnTYcWULib64ftSBKm+m
	JlJ1lhdlPeNuGPQWkVEIfceC6Mu9K0mK28liz5M/fxXXfamo4x9Du4HjUOboWWpwf/Sgr5RW4Il
	SblGmId03qJAxQNltwLn6aGMT0MCVpFvBmk5oqREpdMsixEw37HKaw64P91A4D0i72sS3FCBp3+
	zWbzDWYczq8d/LDRJDJjTw9vWPyxRhBNgiquR2fLX9sfvPAlwlBjh2Fsj+P1RKavflWlPiETj1+
	UlMt7BXIOCT5TSp9b15BPpW8kyd8ovZZMnkF+du0hrKJaDUzhDrSBwBFedtPudQL68hNB/tl/pl
	PIYstDbqeWPAhQcuDW4bswCYVqgn1WOMBgIYVc4bGRjCHvJRcDFKvL9EeN5Pc8xZDBKl7VvcsnZ
	6wD7PKWPkkDPrhZoHxPA5+k9otzYwvB+HJ74ILXHt/c6GGijV5ha+8=
X-Received: by 2002:a05:6402:27ce:b0:69f:4c65:86c2 with SMTP id 4fb4d7f45d1cf-6a582af91a5mr18360494a12.2.1787592651326;
        Mon, 24 Aug 2026 10:30:51 -0700 (PDT)
Received: from dmig-l13.lan ([94.139.29.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e0126edsm10485250a12.7.2026.08.24.10.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 10:30:49 -0700 (PDT)
From: Dmitriy Geels <dmitriy.geels@gmail.com>
To: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>,
	linux-input@vger.kernel.org,
	Dmitriy Geels <dmitriy.geels@gmail.com>
Subject: [PATCH v2] HID: logitech-hidpp: add native touchpad support for K400 Plus
Date: Mon, 24 Aug 2026 19:30:42 +0200
Message-ID: <20260824173042.13679-1-dmitriy.geels@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Logitech K400 Plus (WPID 0x404d) exposes its touchpad through the
HID++ TouchpadRawXY feature, but currently operates as an emulated mouse.

Add support for the native raw touchpad reports by creating a separate
multitouch input device while leaving the keyboard and physical button
reports on the existing HID input device.

The K400 Plus reports an area range of zero. Do not expose
ABS_MT_PRESSURE when the TouchpadRawXY feature reports no contact area,
as a permanently zero pressure value causes userspace to treat contacts
as hovering rather than touching.

This enables native touchpad handling, including multitouch gestures and
two-finger scrolling.

This is an AI-assisted patch.

Signed-off-by: Dmitriy Geels <dmitriy.geels@gmail.com>
---
Addressed Sashiko AI review issues.
Changes in v2:
- Publish the touchpad input device only after successful registration.
- Free the input device on initialization and registration failures.
- Propagate errors from input_mt_init_slots().
- Do not expose clickpad buttons on the native touchpad input; the K400
  Plus reports its physical buttons through the existing HID input.

Tested with Logitech K400 Plus (WPID 0x404d):
- single-finger pointer motion
- two-finger scrolling
- physical left/right buttons
- keyboard power off/on
- suspend/resume

v1: https://lore.kernel.org/linux-input/20260824132445.C64EE1F000E9@smtp.kernel.org/

 drivers/hid/hid-logitech-hidpp.c | 186 +++++++++++++++++++++++--------
 1 file changed, 140 insertions(+), 46 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 1504de32b1c8..9a6b04283130 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -64,6 +64,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
 #define HIDPP_QUIRK_CLASS_K400			BIT(2)
 #define HIDPP_QUIRK_CLASS_G920			BIT(3)
 #define HIDPP_QUIRK_CLASS_K750			BIT(4)
+#define HIDPP_QUIRK_CLASS_KBD_WTP		BIT(5)
 
 /* bits 2..20 are reserved for classes */
 /* #define HIDPP_QUIRK_CONNECT_EVENTS		BIT(21) disabled */
@@ -2932,11 +2933,13 @@ static int hidpp_ff_init(struct hidpp_device *hidpp,
 #define WTP_MANUAL_RESOLUTION				39
 
 struct wtp_data {
+	struct input_dev *input;
 	u16 x_size, y_size;
 	u8 finger_count;
 	u8 mt_feature_index;
 	u8 button_feature_index;
 	u8 maxcontacts;
+	u8 area_range;
 	bool flip_y;
 	unsigned int resolution;
 };
@@ -2948,8 +2951,8 @@ static int wtp_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	return -1;
 }
 
-static void wtp_populate_input(struct hidpp_device *hidpp,
-			       struct input_dev *input_dev)
+static int wtp_populate_input(struct hidpp_device *hidpp,
+			      struct input_dev *input_dev)
 {
 	struct wtp_data *wd = hidpp->private_data;
 
@@ -2963,8 +2966,13 @@ static void wtp_populate_input(struct hidpp_device *hidpp,
 	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0, wd->y_size, 0, 0);
 	input_abs_set_res(input_dev, ABS_MT_POSITION_Y, wd->resolution);
 
-	/* Max pressure is not given by the devices, pick one */
-	input_set_abs_params(input_dev, ABS_MT_PRESSURE, 0, 50, 0, 0);
+	/*
+	 * The driver exposes contact area as pressure.  Do not advertise a
+	 * pressure axis when the device does not report contact area; userspace
+	 * may otherwise interpret a permanently-zero pressure value as hover.
+	 */
+	if (wd->area_range)
+		input_set_abs_params(input_dev, ABS_MT_PRESSURE, 0, 50, 0, 0);
 
 	input_set_capability(input_dev, EV_KEY, BTN_LEFT);
 
@@ -2973,8 +2981,8 @@ static void wtp_populate_input(struct hidpp_device *hidpp,
 	else
 		__set_bit(INPUT_PROP_BUTTONPAD, input_dev->propbit);
 
-	input_mt_init_slots(input_dev, wd->maxcontacts, INPUT_MT_POINTER |
-		INPUT_MT_DROP_UNUSED);
+	return input_mt_init_slots(input_dev, wd->maxcontacts, INPUT_MT_POINTER |
+				   INPUT_MT_DROP_UNUSED);
 }
 
 static void wtp_touch_event(struct hidpp_device *hidpp,
@@ -2987,37 +2995,42 @@ static void wtp_touch_event(struct hidpp_device *hidpp,
 		/* no actual data */
 		return;
 
-	slot = input_mt_get_slot_by_key(hidpp->input, touch_report->finger_id);
+	slot = input_mt_get_slot_by_key(wd->input, touch_report->finger_id);
 
-	input_mt_slot(hidpp->input, slot);
-	input_mt_report_slot_state(hidpp->input, MT_TOOL_FINGER,
-					touch_report->contact_status);
+	input_mt_slot(wd->input, slot);
+	input_mt_report_slot_state(wd->input, MT_TOOL_FINGER,
+				   touch_report->contact_status);
 	if (touch_report->contact_status) {
-		input_event(hidpp->input, EV_ABS, ABS_MT_POSITION_X,
-				touch_report->x);
-		input_event(hidpp->input, EV_ABS, ABS_MT_POSITION_Y,
-				wd->flip_y ? wd->y_size - touch_report->y :
-					     touch_report->y);
-		input_event(hidpp->input, EV_ABS, ABS_MT_PRESSURE,
-				touch_report->area);
+		input_event(wd->input, EV_ABS, ABS_MT_POSITION_X,
+			    touch_report->x);
+		input_event(wd->input, EV_ABS, ABS_MT_POSITION_Y,
+			    wd->flip_y ? wd->y_size - touch_report->y :
+			    touch_report->y);
+
+		if (wd->area_range)
+			input_event(wd->input, EV_ABS, ABS_MT_PRESSURE,
+				    touch_report->area);
 	}
 }
 
 static void wtp_send_raw_xy_event(struct hidpp_device *hidpp,
 		struct hidpp_touchpad_raw_xy *raw)
 {
+	struct wtp_data *wd = hidpp->private_data;
 	int i;
 
 	for (i = 0; i < 2; i++)
 		wtp_touch_event(hidpp, &(raw->fingers[i]));
 
 	if (raw->end_of_frame &&
-	    !(hidpp->quirks & HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS))
-		input_event(hidpp->input, EV_KEY, BTN_LEFT, raw->button);
+	    !(hidpp->quirks &
+	      (HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS |
+	       HIDPP_QUIRK_CLASS_KBD_WTP)))
+		input_event(wd->input, EV_KEY, BTN_LEFT, raw->button);
 
 	if (raw->end_of_frame || raw->finger_count <= 2) {
-		input_mt_sync_frame(hidpp->input);
-		input_sync(hidpp->input);
+		input_mt_sync_frame(wd->input);
+		input_sync(wd->input);
 	}
 }
 
@@ -3066,8 +3079,13 @@ static int wtp_raw_event(struct hid_device *hdev, u8 *data, int size)
 	struct wtp_data *wd = hidpp->private_data;
 	struct hidpp_report *report = (struct hidpp_report *)data;
 	struct hidpp_touchpad_raw_xy raw;
+	struct input_dev *input;
 
-	if (!wd || !hidpp->input)
+	if (!wd)
+		return 1;
+
+	input = wd->input;
+	if (!input)
 		return 1;
 
 	switch (data[0]) {
@@ -3078,11 +3096,11 @@ static int wtp_raw_event(struct hid_device *hdev, u8 *data, int size)
 			return 1;
 		}
 		if (hidpp->quirks & HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS) {
-			input_event(hidpp->input, EV_KEY, BTN_LEFT,
-					!!(data[1] & 0x01));
-			input_event(hidpp->input, EV_KEY, BTN_RIGHT,
-					!!(data[1] & 0x02));
-			input_sync(hidpp->input);
+			input_event(input, EV_KEY, BTN_LEFT,
+				    !!(data[1] & 0x01));
+			input_event(input, EV_KEY, BTN_RIGHT,
+				    !!(data[1] & 0x02));
+			input_sync(input);
 			return 0;
 		} else {
 			if (size < 21)
@@ -3109,6 +3127,9 @@ static int wtp_get_config(struct hidpp_device *hidpp)
 	struct hidpp_touchpad_raw_info raw_info = {0};
 	int ret;
 
+	if (wd->x_size)
+		return 0;
+
 	ret = hidpp_root_get_feature(hidpp, HIDPP_PAGE_TOUCHPAD_RAW_XY,
 		&wd->mt_feature_index);
 	if (ret)
@@ -3123,6 +3144,7 @@ static int wtp_get_config(struct hidpp_device *hidpp)
 	wd->x_size = raw_info.x_size;
 	wd->y_size = raw_info.y_size;
 	wd->maxcontacts = raw_info.maxcontacts;
+	wd->area_range = raw_info.area_range;
 	wd->flip_y = raw_info.origin == TOUCHPAD_RAW_XY_ORIGIN_LOWER_LEFT;
 	wd->resolution = raw_info.res;
 	if (!wd->resolution)
@@ -3146,22 +3168,27 @@ static int wtp_allocate(struct hid_device *hdev, const struct hid_device_id *id)
 	return 0;
 };
 
+static int wtp_enable_raw_mode(struct hidpp_device *hidpp)
+{
+	struct wtp_data *wd = hidpp->private_data;
+
+	return hidpp_touchpad_set_raw_report_state(hidpp,
+						  wd->mt_feature_index,
+						  true, true);
+}
+
 static int wtp_connect(struct hid_device *hdev)
 {
 	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
-	struct wtp_data *wd = hidpp->private_data;
 	int ret;
 
-	if (!wd->x_size) {
-		ret = wtp_get_config(hidpp);
-		if (ret) {
-			hid_err(hdev, "Can not get wtp config: %d\n", ret);
-			return ret;
-		}
+	ret = wtp_get_config(hidpp);
+	if (ret) {
+		hid_err(hdev, "cannot get WTP config: %d\n", ret);
+		return ret;
 	}
 
-	return hidpp_touchpad_set_raw_report_state(hidpp, wd->mt_feature_index,
-			true, true);
+	return wtp_enable_raw_mode(hidpp);
 }
 
 /* ------------------------------------------------------------------------- */
@@ -4064,14 +4091,22 @@ static int hidpp_input_mapped(struct hid_device *hdev, struct hid_input *hi,
 }
 
 
-static void hidpp_populate_input(struct hidpp_device *hidpp,
+static int hidpp_populate_input(struct hidpp_device *hidpp,
 				 struct input_dev *input)
 {
+	int ret;
+
 	hidpp->input = input;
 
-	if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)
-		wtp_populate_input(hidpp, input);
-	else if (hidpp->quirks & HIDPP_QUIRK_CLASS_M560)
+	if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP) {
+		struct wtp_data *wd = hidpp->private_data;
+
+		ret = wtp_populate_input(hidpp, input);
+		if (ret)
+			return ret;
+
+		wd->input = input;
+	} else if (hidpp->quirks & HIDPP_QUIRK_CLASS_M560)
 		m560_populate_input(hidpp, input);
 
 	if (hidpp->quirks & HIDPP_QUIRK_HIDPP_WHEELS)
@@ -4082,6 +4117,8 @@ static void hidpp_populate_input(struct hidpp_device *hidpp,
 
 	if (hidpp->quirks & HIDPP_QUIRK_HIDPP_REPROG_CONTROLS_BTNS)
 		hidpp20_reprog_controls_populate_input(hidpp, input);
+
+	return 0;
 }
 
 static int hidpp_input_configured(struct hid_device *hdev, struct hid_input *hidinput)
@@ -4110,9 +4147,7 @@ static int hidpp_input_configured(struct hid_device *hdev, struct hid_input *hid
 		}
 	}
 
-	hidpp_populate_input(hidpp, input);
-
-	return 0;
+	return hidpp_populate_input(hidpp, input);
 }
 
 static int hidpp_raw_hidpp_event(struct hidpp_device *hidpp, u8 *data,
@@ -4274,6 +4309,9 @@ static int hidpp_raw_event(struct hid_device *hdev, struct hid_report *report,
 
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)
 		return wtp_raw_event(hdev, data, size);
+	else if ((hidpp->quirks & HIDPP_QUIRK_CLASS_KBD_WTP) &&
+		 data[0] == REPORT_ID_HIDPP_LONG)
+		return wtp_raw_event(hdev, data, size);
 	else if (hidpp->quirks & HIDPP_QUIRK_CLASS_M560)
 		return m560_raw_event(hdev, data, size);
 
@@ -4524,7 +4562,54 @@ static void hidpp_connect_event(struct work_struct *work)
 		return;
 	}
 
-	if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP) {
+	if (hidpp->quirks & HIDPP_QUIRK_CLASS_KBD_WTP) {
+		if (!wd->input) {
+			struct wtp_data *wd = hidpp->private_data;
+
+			ret = wtp_get_config(hidpp);
+			if (ret) {
+				hid_err(hdev, "cannot get WTP config: %d\n", ret);
+				return;
+			}
+
+			input = hidpp_allocate_input(hdev);
+			if (!input) {
+				hid_err(hdev, "cannot allocate touchpad input device\n");
+				return;
+			}
+
+			devm_name = devm_kasprintf(&hdev->dev, GFP_KERNEL,
+						   "%s Touchpad", hidpp->name);
+			if (!devm_name)
+				return;
+
+			input->name = devm_name;
+
+			ret = wtp_populate_input(hidpp, input);
+			if (ret) {
+				hid_err(hdev,
+					"cannot initialize touchpad input device: %d\n",
+					ret);
+				input_free_device(input);
+				return;
+			}
+
+			ret = input_register_device(input);
+			if (ret) {
+				hid_err(hdev,
+					"cannot register touchpad input device: %d\n",
+					ret);
+				input_free_device(input);
+				return;
+			}
+
+			WRITE_ONCE(wd->input, input);
+		}
+
+		ret = wtp_enable_raw_mode(hidpp);
+		if (ret)
+			return;
+	} else if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP) {
 		ret = wtp_connect(hdev);
 		if (ret)
 			return;
@@ -4615,7 +4700,12 @@ static void hidpp_connect_event(struct work_struct *work)
 		return;
 	}
 
-	hidpp_populate_input(hidpp, input);
+	ret = hidpp_populate_input(hidpp, input);
+	if (ret) {
+		hidpp->input = NULL;
+		input_free_device(input);
+		return;
+	}
 
 	ret = input_register_device(input);
 	if (ret) {
@@ -4755,7 +4845,8 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	    hidpp_application_equals(hdev, HID_GD_KEYBOARD))
 		hidpp->quirks |= HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS;
 
-	if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP) {
+	if (hidpp->quirks &
+	    (HIDPP_QUIRK_CLASS_WTP | HIDPP_QUIRK_CLASS_KBD_WTP)) {
 		ret = wtp_allocate(hdev, id);
 		if (ret)
 			return ret;
@@ -4885,6 +4976,9 @@ static const struct hid_device_id hidpp_devices[] = {
 	{ /* Keyboard logitech K400 */
 	  LDJ_DEVICE(0x4024),
 	  .driver_data = HIDPP_QUIRK_CLASS_K400 },
+	{ /* Wireless Touch Keyboard Logitech K400 Plus */
+	  LDJ_DEVICE(0x404d),
+	  .driver_data = HIDPP_QUIRK_CLASS_KBD_WTP },
 	{ /* Solar Keyboard Logitech K750 */
 	  LDJ_DEVICE(0x4002),
 	  .driver_data = HIDPP_QUIRK_CLASS_K750 },

base-commit: a8fcb3dbf9024da44f1614c42ea16001f4b860b0
-- 
2.55.0

