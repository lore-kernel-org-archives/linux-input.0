Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795CE2BEC34
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 23:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783206667; cv=none; b=PTHj+va+n65efnxvQw4kpl/T3Uqk56SQebMLoOTokLyaMc9DEHvN9no3Pl42dfFGQEW8oVPd/SnHlZYPNQz9PA5Ny8+Qbs+rhnpEY7Oph5saRp4SvSfpBe/VwZa8cVKZiMc4Ymsw8lqCTr2WDmv4pmuRmx1dsIiJySCCcBHDwTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783206667; c=relaxed/simple;
	bh=dJ0A+IsoRSmppzKTnavwY02yQJJgrPIehp9a7/FdLkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hlYC7DWuSuIj47mS292Pbw/+dLk4tnmbNFdGSe5rZA75wGGe78TNQrhcUXvBIDAUQmZlsfLmGc5nlQ4fsT++jQu4WwlJYeTUJynHHS/SjW14E8dPN8JmzMvT5PhqWenJSMq7DQVEdDQcgyYddNVlhKcTyMjbrBD6J8xjwtRU2Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcrKwdEC; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcrKwdEC"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493b779003fso8269045e9.3
        for <linux-input@vger.kernel.org>; Sat, 04 Jul 2026 16:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783206664; x=1783811464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPhjyBXCJ/kyGapaXuu+g3BDgsUSt4IOEV0Lxn1rcxE=;
        b=HcrKwdECIsSL3i0P/7cBTxMmWC4DnFUfgL6/Sb2R109oGyKvianfsUNygodDN/UCY7
         KyYRnSKIO3hD7/UT0zzPBebPhh9Ome3iYPnQjIuMTxnRi/7XPW7Lr782aOQlAN+ma1YB
         zHq5irLMTtlYSLW0KbvHgLgk/w9HiNLgMFnUAx/EWkOj7M5qxRY8cC2Bii/06i9UrLcA
         3yWslczHIz4NThMSTEljyy+tw4Azt0Z2BNrYRURjbKCw9sH95i+LDIreqrlBuzOruEzx
         ahKKGkDbPCIjQRY0oy6HGzniyuI3o9ejDU6nweNMUtVEJddmX/XtEhx2N6EdaVdeL85W
         iV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783206664; x=1783811464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sPhjyBXCJ/kyGapaXuu+g3BDgsUSt4IOEV0Lxn1rcxE=;
        b=dg7Bn0TyqA9NGrtvbLM54kstTNR3TjUndvj3tAbjuYayqlbmBYLArND3/leCtLNQwR
         RJ33g1gPH91p7eDf4fH0qYXo4g77D/PVoPMfL3nY8sESOaS6FeKdrGFJX76S/+KGkSrv
         JsBmHjyi7+wVhTYuNYa26jq+W3KPekWqbcDg5JWKQAr8CjUr5WQA6/ybNEzUnpDSJxgA
         gI59C7m64hTzmkbGZmfpRPoNIqiKf28Sd2OzaGIxFmbA1HnXcLgcklnPOcW5guFF4vEA
         lt+5xt+eocQlvpC/mSsirilbCfWX5RjdfoMcDc3jcYfgQ2DvmnGvk72m9aHPh3MbrPIs
         fyZA==
X-Gm-Message-State: AOJu0YxMCIfL1ny/8Ulm9TC4Vozf/FnhARncxRWueZXVrWVJkvm51aJe
	V+BJ+FSnnNbInVXFCxF35Xj1snROdUn6tDrLAO2dzr8voOO3bfOgQo3H4TZBrVZx8qg=
X-Gm-Gg: AfdE7cn5piHwzuVLRWaSmb2/bdRTvA2wN7ZszZCFsSp9ho0ThLv0qS54eSoHKiBWr6H
	BdEorsrV10c3w2WWx1L5E9AvR2izDCaTRTQv3TDkoSs+329pArtcA5P8UPg1FXJp8iD+BsUB5dY
	h7ifEribL+RoTIgZDgfPkeME288LZ5wbR9Jo32QGJbhzZvtR+FoxWXzc76ZzDO1y49Ym7fDJNYt
	c6no2Pf6I5LOTsa6hFB4YfSBkQkk39a/IqsDk/nJKmCYinFNdExW1kgcS6ZDfpenaw5/wxLXFeL
	oJ7odPNGguos2YhDWzBWLkpgBGVXu0pN/Kl4aiLxe/AKLP1lcz3n0ymOdpRLifToq4cRQzORnh2
	7G2SrAzP2wERqn/8okjiADphY5uhFDAqBlRuY+Eo8uJ5haq6hYKN+n2WsKi96C1D7XkQlzXhH83
	QSaAwqDxMGa+IXNq+6pq2xJ5H3ZEwIjGvMeG2d0CbWNQ==
X-Received: by 2002:a05:600c:6387:b0:493:b6e2:1b10 with SMTP id 5b1f17b1804b1-493d2c5693dmr38849315e9.31.1783206663831;
        Sat, 04 Jul 2026 16:11:03 -0700 (PDT)
Received: from localhost (97-115-81-230.ptld.qwest.net. [97.115.81.230])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493ccdab27dsm151349535e9.4.2026.07.04.16.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jul 2026 16:11:02 -0700 (PDT)
From: Elliot Douglas <edouglas7358@gmail.com>
To: linux-input@vger.kernel.org
Cc: lains@riseup.net,
	hadess@hadess.net,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-kernel@vger.kernel.org,
	edouglas7358@gmail.com
Subject: [PATCH v2 1/2] HID: logitech-hidpp: add HID++ 2.0 reprogrammable button support
Date: Sat,  4 Jul 2026 16:10:34 -0700
Message-ID: <d4c48a9d36c738abd02a0430a6ca8a5a792fb3ea.1783094954.git.edouglas7358@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783094954.git.edouglas7358@gmail.com>
References: <cover.1783094954.git.edouglas7358@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Logitech HID++ 2.0 mice can report diverted reprogrammable controls
through HID++ feature 0x1b04, SpecialKeysMseButtons / REPROG_CONTROLS_V4,
instead of the normal HID mouse report.

Add a quirk-gated event path for those controls. The handler temporarily
diverts verified per-product controls, parses divertedButtonsEvent as the
current pressed-control list, and reports the corresponding evdev key state
for every mapped control.

Keep the control mappings in per-product arrays so adding support for
another mouse does not change the evdev capabilities advertised by
already-supported devices.

Documentation for feature 0x1b04 describes divertedButtonsEvent as a list
of currently pressed diverted buttons, which is the event format handled
here.

Link: https://lekensteyn.nl/files/logitech/x1b04_specialkeysmsebuttons.html
Signed-off-by: Elliot Douglas <edouglas7358@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 205 +++++++++++++++++++++++++++++++
 1 file changed, 205 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 70ba1a5e40d8..f9189e14fb78 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -76,6 +76,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
 #define HIDPP_QUIRK_HI_RES_SCROLL_1P0		BIT(28)
 #define HIDPP_QUIRK_WIRELESS_STATUS		BIT(29)
 #define HIDPP_QUIRK_RESET_HI_RES_SCROLL		BIT(30)
+#define HIDPP_QUIRK_HIDPP_REPROG_CONTROLS_BTNS	BIT(31)
 
 /* These are just aliases for now */
 #define HIDPP_QUIRK_KBD_SCROLL_WHEEL HIDPP_QUIRK_HIDPP_WHEELS
@@ -178,6 +179,8 @@ struct hidpp_scroll_counter {
 	unsigned long long last_time;
 };
 
+struct hidpp_reprog_control_mapping;
+
 struct hidpp_device {
 	struct hid_device *hid_dev;
 	struct input_dev *input;
@@ -205,6 +208,8 @@ struct hidpp_device {
 	struct hidpp_scroll_counter vertical_wheel_counter;
 
 	u8 wireless_feature_index;
+	u8 reprog_controls_feature_index;
+	const struct hidpp_reprog_control_mapping *reprog_controls;
 
 	int hires_wheel_multiplier;
 	u8 hires_wheel_feature_index;
@@ -3601,6 +3606,195 @@ static int hidpp10_extra_mouse_buttons_raw_event(struct hidpp_device *hidpp,
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
+static const struct hidpp_reprog_control_mapping *
+hidpp20_reprog_controls_get_mappings(struct hidpp_device *hidpp)
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
+	const struct hidpp_reprog_control_mapping *mapping;
+	u8 flags = HIDPP_REPROG_CONTROLS_TEMPORARY_DIVERTED |
+		   HIDPP_REPROG_CONTROLS_CHANGE_TEMPORARY_DIVERT;
+
+	if (!(hidpp->quirks & HIDPP_QUIRK_HIDPP_REPROG_CONTROLS_BTNS))
+		return;
+
+	if (!hidpp->reprog_controls)
+		return;
+
+	if (hidpp_root_get_feature(hidpp, HIDPP_PAGE_REPROG_CONTROLS_V4,
+				   &hidpp->reprog_controls_feature_index))
+		return;
+
+	for (mapping = hidpp->reprog_controls; mapping->control; mapping++) {
+		if (!hidpp20_reprog_controls_find_control(hidpp, mapping->control))
+			continue;
+
+		hidpp20_reprog_controls_set_control_reporting(hidpp,
+							      mapping->control,
+							      flags);
+	}
+}
+
+static int hidpp20_reprog_controls_raw_event(struct hidpp_device *hidpp,
+					     u8 *data, int size)
+{
+	const struct hidpp_reprog_control_mapping *mapping;
+	struct hidpp_report *report = (struct hidpp_report *)data;
+	u16 controls[4];
+	bool pressed;
+	unsigned int i, j;
+
+	if (!(hidpp->quirks & HIDPP_QUIRK_HIDPP_REPROG_CONTROLS_BTNS) ||
+	    !hidpp->input ||
+	    !hidpp->reprog_controls ||
+	    hidpp->reprog_controls_feature_index == 0xff)
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
+	for (mapping = hidpp->reprog_controls; mapping->control; mapping++) {
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
+	const struct hidpp_reprog_control_mapping *mapping;
+
+	if (!hidpp->reprog_controls)
+		return;
+
+	for (mapping = hidpp->reprog_controls; mapping->control; mapping++)
+		input_set_capability(input_dev, EV_KEY, mapping->code);
+}
+
 static void hidpp10_extra_mouse_buttons_populate_input(
 			struct hidpp_device *hidpp, struct input_dev *input_dev)
 {
@@ -3859,6 +4053,9 @@ static void hidpp_populate_input(struct hidpp_device *hidpp,
 
 	if (hidpp->quirks & HIDPP_QUIRK_HIDPP_EXTRA_MOUSE_BTNS)
 		hidpp10_extra_mouse_buttons_populate_input(hidpp, input);
+
+	if (hidpp->quirks & HIDPP_QUIRK_HIDPP_REPROG_CONTROLS_BTNS)
+		hidpp20_reprog_controls_populate_input(hidpp, input);
 }
 
 static int hidpp_input_configured(struct hid_device *hdev,
@@ -3971,6 +4168,10 @@ static int hidpp_raw_hidpp_event(struct hidpp_device *hidpp, u8 *data,
 			return ret;
 	}
 
+	ret = hidpp20_reprog_controls_raw_event(hidpp, data, size);
+	if (ret != 0)
+		return ret;
+
 	if (hidpp->quirks & HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS) {
 		ret = hidpp10_consumer_keys_raw_event(hidpp, data, size);
 		if (ret != 0)
@@ -4264,6 +4465,8 @@ static void hidpp_connect_event(struct work_struct *work)
 			return;
 	}
 
+	hidpp20_reprog_controls_connect(hidpp);
+
 	if (hidpp->quirks & HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS) {
 		ret = hidpp10_consumer_keys_connect(hidpp);
 		if (ret)
@@ -4436,6 +4639,8 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	hidpp->hid_dev = hdev;
 	hidpp->name = hdev->name;
 	hidpp->quirks = id->driver_data;
+	hidpp->reprog_controls_feature_index = 0xff;
+	hidpp->reprog_controls = hidpp20_reprog_controls_get_mappings(hidpp);
 	hid_set_drvdata(hdev, hidpp);
 
 	ret = hid_parse(hdev);
-- 
2.54.0

