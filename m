Received: from mail-ed2-f31.google.com (mail-ed2-f31.google.com [74.125.228.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8521D48EC93
	for <linux-input@vger.kernel.org>; Thu,  1 Oct 2026 22:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790893436; cv=none; b=ubuwp3futl1EjIt47BvW2Hm8+CjASm6nIRpOgv/iuQ1U5/A9XLDxNw79ZQpQnG+THzDRUCo0EKJEvEua0O/f7srWkyr3VTAIzyv1n9DjlBm9nqSQefAv4wbw0dPyhDvbjxne/vMq7Ot45+/4aLRseejK8s+HVMayJTu9NQPbF2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790893436; c=relaxed/simple;
	bh=JA7vkBppUwscfTRo/QQ62oNb3TUhQTenDc1L2khp4PY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sOFWL67Ht4S2/h5bgZlW3Q6a1c7VgjJSTmFHTu7BV7pzfNmzxfbQF+vehC8KWWzSEhpV6R+jp/RyAt9CXbCkQ8mrNJGREWP2JrpA2v1sVF4HtA/1LdWhiTOrF5Oa3mn8jWpcwKCAcFRqKutQC4rNP775DapWBOgVlo0LpvxkvKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyxTLsCD; arc=none smtp.client-ip=74.125.228.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyxTLsCD"
Received: by mail-ed2-f31.google.com with SMTP id 4fb4d7f45d1cf-6ae19319854so3553689a12.3
        for <linux-input@vger.kernel.org>; Thu, 01 Oct 2026 15:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790893432; x=1791498232; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=43gLglJ5iL7F+FcRPp3HfvnSSGf0/yIIWyejmxa6MyQ=;
        b=GyxTLsCDd6RhWwUIEOJIGtROZDrxDB/fkZAW1bxUu/BNHTMS/rCa3yTK5y7U/XxdZa
         wMbvmiPHGx3ylsm88YVpS1d5gjclfM3NrIMXW/N0URLIhHdBLsgTJfTdqAmatJNLYQHz
         wsIG0AgNGkVtvz8eWm55NA8NvPlFk8weiUCGxcXKBLfoH8gzoLDS2eHM4EsURhPJ+JNt
         syyyxj5RI/xJM/tgqdtC6DYxj+wJbEShmkl4nUzW+KXkUnEkFBmOVAViFlyezXZ/IOTr
         ABb9CEnfV2uHUzl3SftuRWoQuvLsoDjurB3QoZnIzwWzPY9Sohiltmkl2uAsgD/jf7U9
         0fug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790893432; x=1791498232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=43gLglJ5iL7F+FcRPp3HfvnSSGf0/yIIWyejmxa6MyQ=;
        b=oq7PYsaTwAlT7prUten5uOQNLg6HzSxEx2l7Fs93Tb8+MTw8X9nSrP85bhVrSvhO9m
         H9RILD52ktQ/ijpkpv+eAjDOVcrodgSbwICJnSz338OaEVvLzszOYOApIFt/SuJv7gnI
         Ir7ZesDjiv2Ccokh+PRE/FllJNCULSqK5CSy7kqMG37Addr3RoUh8xMyTQP89A/0quBC
         3BNnh0lZbS1z7WnkjIECGYbG1KSqlgxpBdHhje22xbuwWrgP8PV1oQwxqHY8qk8+B8lq
         IGTYr3BNDtlIWcMhSX20JHKG9dafE2F0RTq1DUGlWlEa7K/P1NfYi5XZbQwAdUuMznn0
         GTeg==
X-Forwarded-Encrypted: i=1; AKwUvBwphQL/aS8pURUpuiLU7ztN9kHPA2mkJJd4rxyx9G5/aNL/8td7eNAW2Flpf6N1+MiMa79mdAt8yVN2fA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJfvMMZ2Idb4Qql3FZUSiIP52PEClFhEXyutu+RY+2MuX/tP0LQ
	po4x/MUy7G3DCPLi8/iAsRV9bnHXLBPSd2KtqpB8d8o5wxBW3R1+4Yh5
X-Gm-Gg: AYBFou0Z45ZhC3rILQiQwZgUMqpDvtL2l0wrhPOAntRywS95L8FQOwptH6eEQUTOrnu
	l62dVqB5mh3Gy9kNkJqC1Cy/JqPnLCpsDmBDgZkyrzmP/qC4I8kB4XwY3XUwreWfoJzjfJhOu+p
	nenJNCx40TF/1rux/H7bKIO4MVG2L+/3LpFj48y/COB6DBYd9EBCn5m5rnggFAMhwpwgllU7cLd
	tAYJpP5PjBSu7CrCqkmCoL/xZaRSFVFRJ052oP2PO3lGXkUg7Dxx+7rvh3i3RZFaOGG9tj6CUWB
	5ruLsWdxTEBPEeYNTnI8hEqtn6HB3VUKdNc1+O6dkIT/aGe361qjgEFSztKiwduGVwG6qe2Vert
	yRkI635ySa124XtunJ1Uq+O0nPyZXfu9C4dHHEh9xRlgxFlMUHTWzyIx/FoRLmrq0/8+fWSy2TW
	yZoxL8VVMXW89Qw2e/rC6yqlW3gTDHtzPKUKgKvawerIb6RA1fSauf6PbNaaZ6CWZoO4wT0WQii
	jHEIDXL4tce80UYADcce6HUMET92opqrGKNDpgxfrqH14BxR7/Czg==
X-Received: by 2002:a05:6402:13cd:b0:6ae:2e06:ab2b with SMTP id 4fb4d7f45d1cf-6af9e31de2bmr350850a12.40.1790893432378;
        Thu, 01 Oct 2026 15:23:52 -0700 (PDT)
Received: from [192.168.86.89] (81-224-151-184-no600.tbcn.telia.com. [81.224.151.184])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6af9d87399esm238935a12.9.2026.10.01.15.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 15:23:51 -0700 (PDT)
From: =?utf-8?q?Erik_H=C3=A5kansson?= <erikhakan@gmail.com>
Date: Fri, 02 Oct 2026 00:23:38 +0200
Subject: [PATCH RFC 4/4] HID: logitech-hidpp: support ratchet wheel
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261002-bolt-input-rfc-v1-4-333e1f350586@gmail.com>
References: <20261002-bolt-input-rfc-v1-0-333e1f350586@gmail.com>
In-Reply-To: <20261002-bolt-input-rfc-v1-0-333e1f350586@gmail.com>
To: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Bastien Nocera <hadess@hadess.net>
Cc: Rafael Passos <rafael@rcpassos.me>, 
 =?utf-8?q?Gr=C3=A9goire_Stein?= <greyxor@protonmail.com>, 
 Alexey Zagorodnikov <xglooom@gmail.com>, 
 Oleksandr Natalenko <oleksandr@natalenko.name>, 
 Roman Stingler <roman.stingler@gmail.com>, 
 Lovekesh Solanki <lovekeshsolanki00@gmail.com>, 
 =?utf-8?q?Kate=C5=99ina_Medv=C4=9Bdov=C3=A1?= <k8ie@mcld.eu>, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Erik_H=C3=A5kansson?= <erikhakan@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790893419; l=5655;
 i=erikhakan@gmail.com; s=20260922; h=from:subject:message-id;
 bh=JA7vkBppUwscfTRo/QQ62oNb3TUhQTenDc1L2khp4PY=;
 b=Vq1xavsggosWzXv0VfsE25iNuKC7l1Stvw+mEl+Iru6F65eu8r+nMJoklOKugVRhtyxE0CxJ7
 10ymF8zbQlfDXn7zyK2mTTB58662zD8fgR9XnlNbxM6b8d1+U9ausiZ
X-Developer-Key: i=erikhakan@gmail.com; a=ed25519;
 pk=brCZX79/H6Z7mPgiNX6TDY45ZjODPth0eXRDUgh1mNI=

Detect the 0x2130 Ratchet wheel feature and handle its HID++ scroll events.
Enable HID++ wheel diversion by default for Bolt-connected devices, but
leave other devices unchanged.

Signed-off-by: Erik Håkansson <erikhakan@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 101 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 9217ad4a97f4..6195080505cb 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -101,6 +101,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
 #define HIDPP_CAPABILITY_HIDPP10_FAST_SCROLL	BIT(9)
 #define HIDPP_CAPABILITY_ADC_MEASUREMENT	BIT(10)
 #define HIDPP_CAPABILITY_HIDPP20_THUMBWHEEL	BIT(11)
+#define HIDPP_CAPABILITY_HIDPP20_RATCHET_WHEEL	BIT(12)
 
 #define lg_map_key_clear(c)  hid_map_usage_clear(hi, usage, bit, max, EV_KEY, (c))
 
@@ -225,6 +226,9 @@ struct hidpp_device {
 	u8 hires_wheel_feature_index;
 	bool hires_wheel_has_invert;
 	bool hires_wheel_invert;
+
+	u8 ratchet_wheel_feature_index;
+
 	u8 thumbwheel_feature_index;
 	bool thumbwheel_positive_right;
 
@@ -2131,6 +2135,27 @@ static int hidpp_hrw_set_wheel_mode(struct hidpp_device *hidpp, bool invert,
 					   params, sizeof(params), &response);
 }
 
+/* -------------------------------------------------------------------------- */
+/* 0x2130: Ratchet Wheel                                                      */
+/* -------------------------------------------------------------------------- */
+
+#define HIDPP_PAGE_RATCHET_WHEEL		0x2130
+#define CMD_RATCHET_WHEEL_SET_WHEEL_MODE	0x10
+#define EVENT_RATCHET_WHEEL_MOVEMENT		0x00
+#define RATCHET_WHEEL_MODE_USE_HIDPP		BIT(0)
+
+static int hidpp_ratchet_wheel_set_mode(struct hidpp_device *hidpp,
+					bool use_hidpp)
+{
+	struct hidpp_report response;
+	u8 mode = use_hidpp ? RATCHET_WHEEL_MODE_USE_HIDPP : 0;
+
+	return hidpp_send_fap_command_sync(hidpp,
+					   hidpp->ratchet_wheel_feature_index,
+					   CMD_RATCHET_WHEEL_SET_WHEEL_MODE,
+					   &mode, sizeof(mode), &response);
+}
+
 /* -------------------------------------------------------------------------- */
 /* 0x2150: Thumbwheel                                                         */
 /* -------------------------------------------------------------------------- */
@@ -4105,6 +4130,35 @@ static int hidpp_initialize_hires_scroll(struct hidpp_device *hidpp)
 	return 0;
 }
 
+static void ratchet_wheel_scroll_enable(struct hidpp_device *hidpp)
+{
+	int ret;
+
+	if (!hidpp_is_bolt_child(hidpp->hid_dev))
+		return;
+
+	ret = hidpp_ratchet_wheel_set_mode(hidpp, true);
+	if (ret)
+		hid_dbg(hidpp->hid_dev,
+			"Could not divert ratchet wheel reports: %d\n", ret);
+}
+
+static void hidpp_initialize_ratchet_wheel(struct hidpp_device *hidpp)
+{
+	int ret;
+
+	hidpp->capabilities &= ~HIDPP_CAPABILITY_HIDPP20_RATCHET_WHEEL;
+	hidpp->ratchet_wheel_feature_index = 0xff;
+	if (hidpp->protocol_major < 2)
+		return;
+
+	ret = hidpp_root_get_feature(hidpp, HIDPP_PAGE_RATCHET_WHEEL,
+				     &hidpp->ratchet_wheel_feature_index);
+	if (ret)
+		return;
+	hidpp->capabilities |= HIDPP_CAPABILITY_HIDPP20_RATCHET_WHEEL;
+}
+
 static void thumbwheel_scroll_enable(struct hidpp_device *hidpp)
 {
 	bool divert;
@@ -4213,6 +4267,44 @@ static int hidpp20_hires_wheel_raw_event(struct hidpp_device *hidpp,
 	return 0;
 }
 
+static int hidpp20_ratchet_wheel_raw_event(struct hidpp_device *hidpp,
+					   u8 *data, int size)
+{
+	int delta_v, delta_h;
+
+	if (hidpp->ratchet_wheel_feature_index == 0xff)
+		return 0;
+
+	if (size < 6)
+		return 0;
+
+	if (data[0] != REPORT_ID_HIDPP_LONG ||
+	    data[2] != hidpp->ratchet_wheel_feature_index)
+		return 0;
+
+	if (data[3] != EVENT_RATCHET_WHEEL_MOVEMENT)
+		return 0;
+
+	if (!hidpp->input)
+		return 1;
+
+	delta_v = (s8)data[4];
+	delta_h = (s8)data[5];
+	if (delta_v) {
+		input_report_rel(hidpp->input, REL_WHEEL_HI_RES, delta_v * 120);
+		input_report_rel(hidpp->input, REL_WHEEL, delta_v);
+	}
+	if (delta_h) {
+		input_report_rel(hidpp->input, REL_HWHEEL_HI_RES,
+				 delta_h * 120);
+		input_report_rel(hidpp->input, REL_HWHEEL, delta_h);
+	}
+	if (delta_v || delta_h)
+		input_sync(hidpp->input);
+
+	return 1;
+}
+
 static int hidpp20_thumbwheel_raw_event(struct hidpp_device *hidpp,
 					       u8 *data, int size)
 {
@@ -4480,6 +4572,12 @@ static int hidpp_raw_hidpp_event(struct hidpp_device *hidpp, u8 *data,
 			return ret;
 	}
 
+	if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_RATCHET_WHEEL) {
+		ret = hidpp20_ratchet_wheel_raw_event(hidpp, data, size);
+		if (ret != 0)
+			return ret;
+	}
+
 	if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_THUMBWHEEL) {
 		ret = hidpp20_thumbwheel_raw_event(hidpp, data, size);
 		if (ret != 0)
@@ -4828,6 +4926,7 @@ static void hidpp_connect_event(struct work_struct *work)
 	hidpp_initialize_battery(hidpp);
 	if (!hid_is_usb(hidpp->hid_dev))
 		hidpp_initialize_hires_scroll(hidpp);
+	hidpp_initialize_ratchet_wheel(hidpp);
 	hidpp_initialize_thumbwheel_scroll(hidpp);
 
 	/* forward current battery state */
@@ -4852,6 +4951,8 @@ static void hidpp_connect_event(struct work_struct *work)
 
 	if (hidpp->capabilities & HIDPP_CAPABILITY_HI_RES_SCROLL)
 		hi_res_scroll_enable(hidpp);
+	if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_RATCHET_WHEEL)
+		ratchet_wheel_scroll_enable(hidpp);
 	if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_THUMBWHEEL)
 		thumbwheel_scroll_enable(hidpp);
 

-- 
2.55.0

