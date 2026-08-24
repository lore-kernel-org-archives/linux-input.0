Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B4935E93B
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 13:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576961; cv=none; b=kkNSskZ7MV1Is8h9tnWFl/E+zhZa7NsuZs8I1qfT817n4y7LjX9SXIETBh5q8BLeSpwICAvfF0cBayqS7OeJStAww20OYcZqE1vUzVsd8lB144FZfnNgDcLbZMeNzn7yRxziFvGYYnDU5/sC7SmzIhp7GNuLbO/sSxFhbNdwZtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576961; c=relaxed/simple;
	bh=d/LcaQWFvRAJfq9ZpwMhLVweWmHaF+CZ6H2XzDmOUd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pp+Jz9iIQ4SGkjcJtvBUHi0sDSOoPbp70ZelFT8F7uv9aNPk/6FxIOKbQATAPIiMIJfUL1NUTmJbSPczqN7W+rzO5bg4xzh3vNdK+7fLDxzl6wt8TIh12YkGSJo9uH6gpOrBFo60vP3fmRwgAQK5HDKI5QAH+0BmF88gYDsPMGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSRMbkUb; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSRMbkUb"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a374bea882so6578821a12.1
        for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 06:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787576958; x=1788181758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tGqEZ63Zd0+rjh7vL6D4Li4k9j0O2OtcWVQC8D605i8=;
        b=mSRMbkUbdOrmnt2qfxLmLKz4+IxRdpWj2Fcov62wo1T0sEK2EiNAg//wzJATlZlo5R
         5u2/wFu2SxyQNiwM1ISwqkDm6oLAfdgLHtPPnmAt7cHB0kvU/1SVnddDTgKvju068hDh
         InVDcc+wY092T0OiuHDnKxUbJQ0tgOYocVrKvt5+q5eP0YFI8wkno1HRioEhmXeUXY5U
         VMKG4BGK8cbKAYnQRmxR24OrzbYT+3KAGDnVlxOKee+Ih6rVRYsNDd/HyjRFMrYQA2Sl
         eEOr5XTPJJ25mFok22NKr3nwoDcc8FyoUNFl6Rvm+3t08xqJiaZoNPSzgWkFIglkeS/F
         W/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787576958; x=1788181758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tGqEZ63Zd0+rjh7vL6D4Li4k9j0O2OtcWVQC8D605i8=;
        b=HmGbfdgfoWaI8dWdLPYOpJeP1OS8ODAwf49HIVXtTXxcAVPcHkINOCOrKzgFK0P0a+
         WGCggh/nrIRVINRnnVg7wSNePgSM5IRAbzzKRB+93HV/sM0bzQ1yUo5v+jAk+cZfDVYF
         3s7qegUZpSAhykl1U970yHvgFu+bLR0kn5xLnKzVtivoB9vmXFUv6JX6rJRNgaeZqIdX
         mAXWB6ZK6AMV41b5YXFhrVeazke+UzllGis80JPR4UlmzF4MSqWaF07kx/mWo6jtr+SW
         GtVPE4sICFiAQ0phQr4p+Z2HcQ9EOaR/ClVvQWXJuZmMgIurhwmuTQni4tK2IJD90Oy3
         sqTA==
X-Forwarded-Encrypted: i=1; AHgh+RqcXYV34xJpSss6QVNAj/dgp6ozfyp0MTrwzY6kQlh4SJ85AILpK4FNoVE9t64iuD5sABao5VQJBcuPcw==@vger.kernel.org
X-Gm-Message-State: AFuF++mEJJd9VfgyVz/UeaW6GkSZFvZ+en0mfnDWhS0rKtFhrWg19AJ9
	Kcl9YIJihpoCHEeCCx14TmkSbiXFYnV81azYhLdeqRWSxofCJTogejSyNRYm1kfa
X-Gm-Gg: AR+sD13jB7xT84OcjCmDPvS1W9hycGDyWrtBp3kDXc8rj8UKg0dIztm/40zrIWzlAvE
	x9g7KoHRJSCqTOZtCG/Np2h+g3VT9SXPjur1mH2hIRGQr2NAUt7+QNVsPpWAmUZ6pas5tkoqX/m
	RtAeaew64QSTW5m2WlNtsu7bhGRB8NvaRw5wqgBvQ7Oss3vd8jmKvTQjXboi3HIUhqd1S8MKtTB
	I1mhn3E0YYQ2ORcof0JUB4gW1tEAfCJmqyOpJpqVgkMYrY6MarJnaVG/HzazGCaEqNzHXaMMSd6
	C++eG7r3jqDzGdZUf6e/eIMrxvTmvdOeFj5KswsuYwMruYLyGcRBeStc4XZAHE/RDe9qC4QklWs
	nf6BqXCpQ7aRdI0ELMp1veqDpfRCJzPwU/u2D2a0qt0Lc9Hu0rTtFTil/xxDcq6BbW6aIm7zPP9
	A6PVj6BpZcgc8qh8xETlN4iibX/EdpUtywQgy/zygbZrcoG/CJxVQYBDyW2FfaGYg/NJ/PX5aOr
	c93jxBIDXzMv57VMjheSP9lH+YVJMjGVj1SF+LWlh4LKv8ibuz3j8c=
X-Received: by 2002:a05:6402:a0cd:b0:698:ac8a:9a21 with SMTP id 4fb4d7f45d1cf-6a42f185778mr27865535a12.8.1787576958105;
        Mon, 24 Aug 2026 06:09:18 -0700 (PDT)
Received: from dmig-l13.lan ([94.139.29.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e1aeab9sm9891492a12.22.2026.08.24.06.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 06:09:17 -0700 (PDT)
From: Dmitriy Geels <dmitriy.geels@gmail.com>
To: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>,
	linux-input@vger.kernel.org,
	Dmitriy Geels <dmitriy.geels@gmail.com>
Subject: [PATCH] HID: logitech-hidpp: add native touchpad support for K400 Plus
Date: Mon, 24 Aug 2026 15:09:01 +0200
Message-ID: <20260824130901.84600-1-dmitriy.geels@gmail.com>
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

Tested with Logitech K400 Plus, WPID 0x404d, connected through a
Unifying receiver.

Tested:
- single-finger pointer motion
- two-finger gestures
- physical buttons
- device power cycle
- suspend/resume

 drivers/hid/hid-logitech-hidpp.c | 133 +++++++++++++++++++++++--------
 1 file changed, 100 insertions(+), 33 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 1504de32b1c8..3cb239d81888 100644
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
@@ -2953,6 +2956,8 @@ static void wtp_populate_input(struct hidpp_device *hidpp,
 {
 	struct wtp_data *wd = hidpp->private_data;
 
+	wd->input = input_dev;
+
 	__set_bit(EV_ABS, input_dev->evbit);
 	__set_bit(EV_KEY, input_dev->evbit);
 	__clear_bit(EV_REL, input_dev->evbit);
@@ -2963,8 +2968,13 @@ static void wtp_populate_input(struct hidpp_device *hidpp,
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
 
@@ -2987,25 +2997,28 @@ static void wtp_touch_event(struct hidpp_device *hidpp,
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
@@ -3013,11 +3026,11 @@ static void wtp_send_raw_xy_event(struct hidpp_device *hidpp,
 
 	if (raw->end_of_frame &&
 	    !(hidpp->quirks & HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS))
-		input_event(hidpp->input, EV_KEY, BTN_LEFT, raw->button);
+		input_event(wd->input, EV_KEY, BTN_LEFT, raw->button);
 
 	if (raw->end_of_frame || raw->finger_count <= 2) {
-		input_mt_sync_frame(hidpp->input);
-		input_sync(hidpp->input);
+		input_mt_sync_frame(wd->input);
+		input_sync(wd->input);
 	}
 }
 
@@ -3067,7 +3080,7 @@ static int wtp_raw_event(struct hid_device *hdev, u8 *data, int size)
 	struct hidpp_report *report = (struct hidpp_report *)data;
 	struct hidpp_touchpad_raw_xy raw;
 
-	if (!wd || !hidpp->input)
+	if (!wd || !wd->input)
 		return 1;
 
 	switch (data[0]) {
@@ -3078,11 +3091,11 @@ static int wtp_raw_event(struct hid_device *hdev, u8 *data, int size)
 			return 1;
 		}
 		if (hidpp->quirks & HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS) {
-			input_event(hidpp->input, EV_KEY, BTN_LEFT,
-					!!(data[1] & 0x01));
-			input_event(hidpp->input, EV_KEY, BTN_RIGHT,
-					!!(data[1] & 0x02));
-			input_sync(hidpp->input);
+			input_event(wd->input, EV_KEY, BTN_LEFT,
+				    !!(data[1] & 0x01));
+			input_event(wd->input, EV_KEY, BTN_RIGHT,
+				    !!(data[1] & 0x02));
+			input_sync(wd->input);
 			return 0;
 		} else {
 			if (size < 21)
@@ -3109,6 +3122,9 @@ static int wtp_get_config(struct hidpp_device *hidpp)
 	struct hidpp_touchpad_raw_info raw_info = {0};
 	int ret;
 
+	if (wd->x_size)
+		return 0;
+
 	ret = hidpp_root_get_feature(hidpp, HIDPP_PAGE_TOUCHPAD_RAW_XY,
 		&wd->mt_feature_index);
 	if (ret)
@@ -3123,6 +3139,7 @@ static int wtp_get_config(struct hidpp_device *hidpp)
 	wd->x_size = raw_info.x_size;
 	wd->y_size = raw_info.y_size;
 	wd->maxcontacts = raw_info.maxcontacts;
+	wd->area_range = raw_info.area_range;
 	wd->flip_y = raw_info.origin == TOUCHPAD_RAW_XY_ORIGIN_LOWER_LEFT;
 	wd->resolution = raw_info.res;
 	if (!wd->resolution)
@@ -3146,22 +3163,27 @@ static int wtp_allocate(struct hid_device *hdev, const struct hid_device_id *id)
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
@@ -4274,6 +4296,9 @@ static int hidpp_raw_event(struct hid_device *hdev, struct hid_report *report,
 
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)
 		return wtp_raw_event(hdev, data, size);
+	else if ((hidpp->quirks & HIDPP_QUIRK_CLASS_KBD_WTP) &&
+		 data[0] == REPORT_ID_HIDPP_LONG)
+		return wtp_raw_event(hdev, data, size);
 	else if (hidpp->quirks & HIDPP_QUIRK_CLASS_M560)
 		return m560_raw_event(hdev, data, size);
 
@@ -4524,7 +4549,45 @@ static void hidpp_connect_event(struct work_struct *work)
 		return;
 	}
 
-	if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP) {
+	if (hidpp->quirks & HIDPP_QUIRK_CLASS_KBD_WTP) {
+		struct wtp_data *wd = hidpp->private_data;
+
+		ret = wtp_get_config(hidpp);
+		if (ret) {
+			hid_err(hdev, "cannot get WTP config: %d\n", ret);
+			return;
+		}
+
+		if (!wd->input) {
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
+			wtp_populate_input(hidpp, input);
+
+			ret = input_register_device(input);
+			if (ret) {
+				hid_err(hdev,
+					"cannot register touchpad input device: %d\n",
+					ret);
+				wd->input = NULL;
+				return;
+			}
+		}
+
+		ret = wtp_enable_raw_mode(hidpp);
+		if (ret)
+			return;
+	} else if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP) {
 		ret = wtp_connect(hdev);
 		if (ret)
 			return;
@@ -4755,7 +4818,8 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	    hidpp_application_equals(hdev, HID_GD_KEYBOARD))
 		hidpp->quirks |= HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS;
 
-	if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP) {
+	if (hidpp->quirks &
+	    (HIDPP_QUIRK_CLASS_WTP | HIDPP_QUIRK_CLASS_KBD_WTP)) {
 		ret = wtp_allocate(hdev, id);
 		if (ret)
 			return ret;
@@ -4885,6 +4949,9 @@ static const struct hid_device_id hidpp_devices[] = {
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

