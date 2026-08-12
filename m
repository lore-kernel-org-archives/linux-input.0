Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AAD38C412
	for <linux-input@vger.kernel.org>; Wed, 12 Aug 2026 19:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564747; cv=none; b=qdiYi3WcRpaw99fTGKHcFxJXUrOnD1TVx8TerAa253WreOpwseOxIsUY3yModt9k7pDWrKELqiBog9WJMWR46NR8NW1b1wrzuJ+9SiIl2usZPlultEt94WMxNfmiOlReUmqpZ93x+DPR44LQMBRNpk4IwF4r714CBigF96SnWDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564747; c=relaxed/simple;
	bh=lFceJ4HBWSBMd+5nGP0i0IRBG9201F6rE2f9MGbnGXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=afTtKfPFZZdJA2dxotp9t8udSv1forejFQlDDDkpVfsbsaK76M3OuYgBcwbXUkBNfs1KftIM4+BFS1s96Vlod7s8x1jVoyvyZonom39/pEj2nwq9R4Wqr+eNz847frAKlaVO5WM3XSFQ/8Vdyxrv6h99emsQJZ1VLHrNneeASt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r12OhtIR; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r12OhtIR"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47fe89fb333so786945f8f.3
        for <linux-input@vger.kernel.org>; Wed, 12 Aug 2026 12:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786564742; x=1787169542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LhLxArGo2q7n/e6yuBeJc1CN2MnQp5unm5C/EjB9ZAc=;
        b=r12OhtIRijkxEhT71gHx7A3Q4DEr790GFNd5TPJv5dIQn6TWoajARacjL0QDwjV3t3
         0o9QqmhTraaxMBXIp7ce9AYsNZ6RsqLcSpeBDU1b4HT2IJIJ5wbLt/9au31WvQ+rWT4i
         LiARyZPd/f4oYUqYN9p8qdXSx0tJghc1aYuKdgsG6n89YbZns8vgTP8sxQI1sR/6wiq7
         0dLjY7Vtl4yhg8ItRVyzvPm+FiTQW0hVghTZR3FsQeESCLncuOHfFTPtHYOs8HQjGzT9
         KAi6QNobQo3yEcel1yguefWzAWx2U4AuWIB3jRfjZQpjMimRxDA881DMB4SleqqnJomq
         MsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786564742; x=1787169542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LhLxArGo2q7n/e6yuBeJc1CN2MnQp5unm5C/EjB9ZAc=;
        b=DBd3qDiFWUFA0rt4AAywuIX8359tPUnOXR/JVP6JHUtE1wIkOZ3b1tsK01nFrT3Phm
         V0su4K+T4Dr/eTIL2fRZNG+O54h6xwM4L6UJguTwPX/KsK3L9ZA1s1COaZKw0FkWd7gL
         UOFMw1bLGgTDCLSzo60JkiXY9d92iS20p7k2SE4QPSy3wDK7usGyNgTvpyZcV+/yTh9z
         lmb2D67TbZngbb7t4ou0FiKd29Icm8CM2gWwd7gIeQB361bOOfbW8y6ysts7OLFxcvMk
         NquAF3QHeHisl3N/P6msLR9yXyZsslKJOb8GsedTg3ZuezAUqjWjXft0W0VEXaKQ07Z+
         5UwA==
X-Gm-Message-State: AOJu0YxrYKE5K8hd/Er0BTtDW7wbRgtfg7voeu7IAH7WRbFZJS6Se55F
	03rB1nSkpv2M8nU0ayz87j/Uoyf3lXVtwKBtmEx9cAOKWRpLvsMEcQt1LcGZtGj4
X-Gm-Gg: AR+sD13lqLH8APiSAXHyOymJ9rk5cEw41RAO4nyDa5/8ZKT/2Vx4r5kngZcFwcPFYre
	pIenuToGvSMo8t1mu1aPWA7l8dqFPXbYuK7oCLIojQ9wBW7sxABl+rPaQhT6n/9NowxdBRKotPK
	gNeIwylM0OJ5vaka63wduLxc/0hpsbCrGRjkcsyEH0EdixsOQutYBnpVDGIgrARo4JAtMmq0GN3
	EHbpF2dkKwWutiHWgPRqJm1njytP3h4eoHpOvdcSm1y2gHAHCcEvgmd0eqSOz/ZTV0LWGlpviNp
	phvzbSW5tCvVBU+nJyTlpG+DacwG5KaxOfWhz4+Cj2mJhBnDiJLg7IOe/tlZmrSq9JFCWg6KnDM
	MxnMN/Pgw29JCcp9o20++lfTnx/NLp0HF6oqmnQx3k+Df3C1BP4GOL5tF10CqeYbvEyzzC9DzXE
	hn1nniLhQy0B898gk6iOQzTdMNlQzh6n3Tn2hu/XKU8H6vz4O+c7ot2Qa75FusvGASMTg07nvhP
	OUfbChGKPGUXjV9b+M3uykMkQ==
X-Received: by 2002:a05:6000:25e7:b0:47f:4919:d5b2 with SMTP id ffacd0b85a97d-48159ca615cmr898037f8f.1.1786564741760;
        Wed, 12 Aug 2026 12:59:01 -0700 (PDT)
Received: from localhost (97-115-90-76.ptld.qwest.net. [97.115.90.76])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4815a5c2837sm107792f8f.37.2026.08.12.12.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 12:59:01 -0700 (PDT)
From: Elliot Douglas <edouglas7358@gmail.com>
To: linux-input@vger.kernel.org
Cc: lains@riseup.net,
	hadess@hadess.net,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-kernel@vger.kernel.org,
	edouglas7358@gmail.com
Subject: [PATCH v3 1/2] HID: logitech-hidpp: add HID++ 2.0 reprogrammable button support
Date: Wed, 12 Aug 2026 12:58:41 -0700
Message-ID: <20260812195842.77724-2-edouglas7358@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812195842.77724-1-edouglas7358@gmail.com>
References: <20260812195842.77724-1-edouglas7358@gmail.com>
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
2.55.0

