Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E68837F011
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 17:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781373094; cv=none; b=gw+S9IFa6cCKzJ2ZgGLHkylRxSSUtjXDCwC0o0qJ+yxMxi0N/5VWcH57++Mfm3JiqN+HrQyfcW1FO+Ghrqx40khGppu8NbvfbOPZ6geGDFPo6YqVB7RDphgIie57q2xKFUvmUcTvMrOXyzPc2M1LfrgDgncOW3lQqRl/eo7VrTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781373094; c=relaxed/simple;
	bh=9fOEpCdtDPZj2/ByXdkYWFrdKspWVJGHief7s9/d0k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=roBAJ4MslhHUCGjqNx0qCQziuIrGBah8mublWfSLGw8qntVJcWR3awyRCT3XrRZuNc7OfgZj5xPaXUff395EykD21nR7STkVLv8ejljRaVUgwd/w8ccFcFXYJu/JRTbjilUJKlgraKb1qoNkMYl8cjghFSv+c0opnosV/iXRdiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekW7Z0RV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekW7Z0RV"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso25047295e9.2
        for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 10:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781373089; x=1781977889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AehxM0UNqEe5kZS7d7XUHl9pA6EObzolVsbGhBp0Kys=;
        b=ekW7Z0RVCH0BC5TZxyc6cULRuRKKXM0HPe87wdns91XjT5/Qz777+O6hwW7FRijcIB
         5MhFaZVBxVJE/HvZPvHw7mF4sq2qp/KQfr26zDrPRATMyHxoq9VFZHyIqA+b5pDtVqkz
         WclZsYTD/IlzL0+Gozv/A/m/sYymLzHM1K8JHG/3MZJLHMNtIla25HacepB45n0NLglf
         v68Q3S+Dmi+zO/VRnOxp38bCcdCcV37jilKPijlDZZxXWhK4wVSCBly9J+OpCLZLyg7j
         y17NGfVf4Xc/fF7btxqInMYrCgeiRpiEfxL6N6Fn812eE6A0PADqWWFcHMvm4Bs06cNm
         JvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781373089; x=1781977889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AehxM0UNqEe5kZS7d7XUHl9pA6EObzolVsbGhBp0Kys=;
        b=U7qYzWV2IYf7+i+xSWcRvZr9ZnuehvDiwegokBFXrCM3x+mL+hG15bq9VAW/xsKLLl
         VQqBl6uYxB5UjeFQSh7i6uaclasuYA2ZqrHfVe6+GoSWQJaT01/IEay09cIiqsHW6Gvb
         kid5kihmUgd1dg8rGShUhMxHN+WnTlEj0sJYMgSfUYAHFRUhrR23O+S7pXOR5PlZL/JL
         ubmP/mK2oVyGdgyBr2+mHjf3jENu5BhJJ9zKwbivA46hr9X8+H6gMeKXJzMO7aFXE4Go
         KNX43IKixb8XwAIpHUII2+5xYjeOMXPihWptuCthkpQL9l+DRZMdxuSwGaHKA3wbuuAt
         Xwiw==
X-Gm-Message-State: AOJu0YwC7sIVDrzG/hceM1tILz6F0pRTizGv8yrJj4qO5MQrPqYrg3LX
	IvMDWsZQIhX5t6DLZl9+r9Ydlxvqteb5c9lNjDouSG+phCYndEZdLb7KRzpA4QYWim4=
X-Gm-Gg: Acq92OGhzp8YcjLith87uOXuUm1M42mWGyx370JNnIh2Eoo+P0bihmzGgcuctEV0pOt
	NtXTRwudbx+aCsMnzXgoAdqIKlVZ4uw6jmWwvgLZQpbCUEnuhB6BM6XR2+hVxQh4okk7hqRWO27
	eWdZDFXgy9F/J4X0ePfZE1YfqWvueUTE86IwYoa3UV1xdih/nPXc5lDyx29MnTM/JKJmqjGYAxU
	MkUGn4yYHy1Np2VMx67GW7kkqfzvzwHQYSrj1Gjspze3v6ohZkAAOEGtJEk4JOCmguujYODE1MO
	nYMrdDPYybifqOIlzCjQv12RbYxXXjU3dGWNyuyUvaE+bF+MeYRx/68GjdC6APlOnMzEq1zod0w
	P2haA78cOic/ID1XV55hrzZUbFAEGc2zVSjWLFP45l2eL06F/OMyZ0MXOcMd2afJwMSkMB0KeuR
	Vaoua++13MaV/+h9VXpbnP37eppxrnCZxuCmZi
X-Received: by 2002:a05:600c:2104:b0:490:4ee0:82ff with SMTP id 5b1f17b1804b1-49220105292mr37554045e9.27.1781373089417;
        Sat, 13 Jun 2026 10:51:29 -0700 (PDT)
Received: from localhost ([2602:61:7351:e600:a1d0:8426:3923:d48d])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4922033dd3esm91414545e9.8.2026.06.13.10.51.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2026 10:51:28 -0700 (PDT)
From: Elliot Douglas <edouglas7358@gmail.com>
To: linux-input@vger.kernel.org
Cc: lains@riseup.net,
	hadess@hadess.net,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-kernel@vger.kernel.org,
	edouglas7358@gmail.com
Subject: [PATCH 1/2] HID: logitech-hidpp: add HID++ 2.0 reprogrammable button support
Date: Sat, 13 Jun 2026 10:51:08 -0700
Message-ID: <20260613175109.44365-2-edouglas7358@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613175109.44365-1-edouglas7358@gmail.com>
References: <20260613175109.44365-1-edouglas7358@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Logitech HID++ 2.0 mice can report diverted reprogrammable
controls through HID++ feature 0x1b04, SpecialKeysMseButtons /
REPROG_CONTROLS_V4, instead of the normal HID mouse report.

Add a quirk-gated event path for those controls. The handler temporarily
diverts verified per-product controls, parses divertedButtonsEvent as the
current pressed-control list, and reports the corresponding evdev key state
for every mapped control.

Keep the control mappings in per-product profiles so adding support for
another mouse does not change the evdev capabilities advertised by
already-supported devices.

Documentation for feature 0x1b04 describes divertedButtonsEvent as a list
of currently pressed diverted buttons, which is the event format handled
here.

Link: https://lekensteyn.nl/files/logitech/x1b04_specialkeysmsebuttons.html

Signed-off-by: Elliot Douglas <edouglas7358@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 215 +++++++++++++++++++++++++++++++
 1 file changed, 215 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 70ba1a5e40d8..24c9cfaa4f37 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -76,6 +76,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
 #define HIDPP_QUIRK_HI_RES_SCROLL_1P0		BIT(28)
 #define HIDPP_QUIRK_WIRELESS_STATUS		BIT(29)
 #define HIDPP_QUIRK_RESET_HI_RES_SCROLL		BIT(30)
+#define HIDPP_QUIRK_HIDPP_REPROG_CONTROLS_BTNS	BIT(31)
 
 /* These are just aliases for now */
 #define HIDPP_QUIRK_KBD_SCROLL_WHEEL HIDPP_QUIRK_HIDPP_WHEELS
@@ -205,6 +206,7 @@ struct hidpp_device {
 	struct hidpp_scroll_counter vertical_wheel_counter;
 
 	u8 wireless_feature_index;
+	u8 reprog_controls_feature_index;
 
 	int hires_wheel_multiplier;
 	u8 hires_wheel_feature_index;
@@ -3601,6 +3603,209 @@ static int hidpp10_extra_mouse_buttons_raw_event(struct hidpp_device *hidpp,
 	return 1;
 }
 
+/* -------------------------------------------------------------------------- */
+/* HID++2.0 reprogrammable controls                                           */
+/* -------------------------------------------------------------------------- */
+
+#define HIDPP_PAGE_REPROG_CONTROLS_V4			0x1b04
+
+#define HIDPP_REPROG_CONTROLS_GET_COUNT			0x00
+#define HIDPP_REPROG_CONTROLS_GET_CID_INFO		0x10
+#define HIDPP_REPROG_CONTROLS_SET_CONTROL_REPORTING	0x30
+
+#define HIDPP_REPROG_CONTROLS_FLAG_MOUSE		BIT(0)
+#define HIDPP_REPROG_CONTROLS_FLAG_DIVERT		BIT(5)
+
+#define HIDPP_REPROG_CONTROLS_TEMPORARY_DIVERTED	BIT(0)
+#define HIDPP_REPROG_CONTROLS_CHANGE_TEMPORARY_DIVERT	BIT(1)
+
+#define HIDPP_REPROG_CONTROLS_EVENT_DIVERTED		0x00
+
+struct hidpp_reprog_control_mapping {
+	u16 control;
+	u16 code;
+};
+
+struct hidpp_reprog_controls_profile {
+	const struct hidpp_reprog_control_mapping *mappings;
+	unsigned int mapping_count;
+};
+
+static const struct hidpp_reprog_controls_profile *
+hidpp20_reprog_controls_get_profile(struct hidpp_device *hidpp)
+{
+	return NULL;
+}
+
+static int hidpp20_reprog_controls_get_count(struct hidpp_device *hidpp)
+{
+	struct hidpp_report response;
+	u8 feature_index = hidpp->reprog_controls_feature_index;
+	u8 cmd = HIDPP_REPROG_CONTROLS_GET_COUNT;
+	int ret;
+
+	ret = hidpp_send_fap_command_sync(hidpp, feature_index, cmd, NULL, 0,
+					  &response);
+	if (ret > 0)
+		return -EPROTO;
+	if (ret)
+		return ret;
+
+	return response.fap.params[0];
+}
+
+static int hidpp20_reprog_controls_get_cid_info(struct hidpp_device *hidpp,
+						u8 index, u16 *control,
+						u8 *flags)
+{
+	struct hidpp_report response;
+	u8 feature_index = hidpp->reprog_controls_feature_index;
+	u8 cmd = HIDPP_REPROG_CONTROLS_GET_CID_INFO;
+	int ret;
+
+	ret = hidpp_send_fap_command_sync(hidpp, feature_index, cmd, &index,
+					  sizeof(index), &response);
+	if (ret > 0)
+		return -EPROTO;
+	if (ret)
+		return ret;
+
+	*control = get_unaligned_be16(&response.fap.params[0]);
+	*flags = response.fap.params[4];
+
+	return 0;
+}
+
+static bool hidpp20_reprog_controls_find_control(struct hidpp_device *hidpp,
+						 u16 control)
+{
+	int count, ret;
+	u16 cid;
+	u8 flags;
+	int i;
+
+	count = hidpp20_reprog_controls_get_count(hidpp);
+	if (count < 0)
+		return false;
+
+	for (i = 0; i < count; i++) {
+		ret = hidpp20_reprog_controls_get_cid_info(hidpp, i, &cid,
+							   &flags);
+		if (ret)
+			return false;
+
+		if (cid == control)
+			return (flags & HIDPP_REPROG_CONTROLS_FLAG_MOUSE) &&
+			       (flags & HIDPP_REPROG_CONTROLS_FLAG_DIVERT);
+	}
+
+	return false;
+}
+
+static int hidpp20_reprog_controls_set_control_reporting(struct hidpp_device *hidpp,
+							 u16 control, u8 flags)
+{
+	struct hidpp_report response;
+	u8 params[5];
+
+	put_unaligned_be16(control, &params[0]);
+	params[2] = flags;
+	put_unaligned_be16(control, &params[3]);
+
+	return hidpp_send_fap_command_sync(hidpp,
+					   hidpp->reprog_controls_feature_index,
+					   HIDPP_REPROG_CONTROLS_SET_CONTROL_REPORTING,
+					   params, sizeof(params), &response);
+}
+
+static void hidpp20_reprog_controls_connect(struct hidpp_device *hidpp)
+{
+	const struct hidpp_reprog_controls_profile *profile;
+	u8 flags = HIDPP_REPROG_CONTROLS_TEMPORARY_DIVERTED |
+		   HIDPP_REPROG_CONTROLS_CHANGE_TEMPORARY_DIVERT;
+	unsigned int i;
+
+	if (!(hidpp->quirks & HIDPP_QUIRK_HIDPP_REPROG_CONTROLS_BTNS))
+		return;
+
+	profile = hidpp20_reprog_controls_get_profile(hidpp);
+	if (!profile)
+		return;
+
+	if (hidpp_root_get_feature(hidpp, HIDPP_PAGE_REPROG_CONTROLS_V4,
+				   &hidpp->reprog_controls_feature_index))
+		return;
+
+	for (i = 0; i < profile->mapping_count; i++) {
+		u16 control = profile->mappings[i].control;
+
+		if (!hidpp20_reprog_controls_find_control(hidpp, control))
+			continue;
+
+		hidpp20_reprog_controls_set_control_reporting(hidpp, control, flags);
+	}
+}
+
+static int hidpp20_reprog_controls_raw_event(struct hidpp_device *hidpp,
+					     u8 *data, int size)
+{
+	const struct hidpp_reprog_controls_profile *profile;
+	const struct hidpp_reprog_control_mapping *mapping;
+	struct hidpp_report *report = (struct hidpp_report *)data;
+	u16 controls[4];
+	bool pressed;
+	unsigned int i, j;
+
+	if (!(hidpp->quirks & HIDPP_QUIRK_HIDPP_REPROG_CONTROLS_BTNS) ||
+	    !hidpp->input ||
+	    hidpp->reprog_controls_feature_index == 0xff)
+		return 0;
+
+	profile = hidpp20_reprog_controls_get_profile(hidpp);
+	if (!profile)
+		return 0;
+
+	if (size < HIDPP_REPORT_LONG_LENGTH ||
+	    report->fap.feature_index != hidpp->reprog_controls_feature_index ||
+	    report->fap.funcindex_clientid != HIDPP_REPROG_CONTROLS_EVENT_DIVERTED)
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(controls); i++)
+		controls[i] = get_unaligned_be16(&report->fap.params[i * 2]);
+
+	for (i = 0; i < profile->mapping_count; i++) {
+		mapping = &profile->mappings[i];
+		pressed = false;
+
+		for (j = 0; j < ARRAY_SIZE(controls); j++) {
+			if (controls[j] == mapping->control) {
+				pressed = true;
+				break;
+			}
+		}
+
+		input_report_key(hidpp->input, mapping->code, pressed);
+	}
+
+	input_sync(hidpp->input);
+
+	return 1;
+}
+
+static void hidpp20_reprog_controls_populate_input(struct hidpp_device *hidpp,
+						   struct input_dev *input_dev)
+{
+	const struct hidpp_reprog_controls_profile *profile;
+	unsigned int i;
+
+	profile = hidpp20_reprog_controls_get_profile(hidpp);
+	if (!profile)
+		return;
+
+	for (i = 0; i < profile->mapping_count; i++)
+		input_set_capability(input_dev, EV_KEY, profile->mappings[i].code);
+}
+
 static void hidpp10_extra_mouse_buttons_populate_input(
 			struct hidpp_device *hidpp, struct input_dev *input_dev)
 {
@@ -3859,6 +4064,9 @@ static void hidpp_populate_input(struct hidpp_device *hidpp,
 
 	if (hidpp->quirks & HIDPP_QUIRK_HIDPP_EXTRA_MOUSE_BTNS)
 		hidpp10_extra_mouse_buttons_populate_input(hidpp, input);
+
+	if (hidpp->quirks & HIDPP_QUIRK_HIDPP_REPROG_CONTROLS_BTNS)
+		hidpp20_reprog_controls_populate_input(hidpp, input);
 }
 
 static int hidpp_input_configured(struct hid_device *hdev,
@@ -3971,6 +4179,10 @@ static int hidpp_raw_hidpp_event(struct hidpp_device *hidpp, u8 *data,
 			return ret;
 	}
 
+	ret = hidpp20_reprog_controls_raw_event(hidpp, data, size);
+	if (ret != 0)
+		return ret;
+
 	if (hidpp->quirks & HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS) {
 		ret = hidpp10_consumer_keys_raw_event(hidpp, data, size);
 		if (ret != 0)
@@ -4264,6 +4476,8 @@ static void hidpp_connect_event(struct work_struct *work)
 			return;
 	}
 
+	hidpp20_reprog_controls_connect(hidpp);
+
 	if (hidpp->quirks & HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS) {
 		ret = hidpp10_consumer_keys_connect(hidpp);
 		if (ret)
@@ -4436,6 +4650,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	hidpp->hid_dev = hdev;
 	hidpp->name = hdev->name;
 	hidpp->quirks = id->driver_data;
+	hidpp->reprog_controls_feature_index = 0xff;
 	hid_set_drvdata(hdev, hidpp);
 
 	ret = hid_parse(hdev);
-- 
2.54.0

