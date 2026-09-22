Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CAE576EAC
	for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 17:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790098846; cv=none; b=ZVOFb63jd2UTAWY+kb1alLN0s3Qp1vpOe5KQsMPgodtDy28YkzluEOx+c5U7uULWCtXM7cCe0nnbavrGAoNzslzm0i5Lzg1nywpZwkRpvz9VD4Zy5wCfqS1vQrnmyWfb3tncR2EWviwwJu16Uji04oVf3Ba+XmJwykUisfAuYiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790098846; c=relaxed/simple;
	bh=9pWsAPJMjYeb1fOw15u6xalyKmIivQfeiEo0bR0Nza8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ck+4e4B7OwsyyOwd9AtXCP/iJriUzE3p5xWdzlkxqVztfe/k2Xc4NIww4L9iDvt1V+Ujpx26IpEZGHvw0UUglTBriM0Ewr2wPD7wb9fv5QcAjhRk9DykMB7yxInwyBqfM7eBL82tUuXXrF5FhVdTqMIFVWKnT997gchCketrY48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OExfR68B; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OExfR68B"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29703cb470so9017266b.0
        for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 10:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790098843; x=1790703643; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r/bMORLOO0A6N2IaZslfOPlgoSE19zFgKkh7hU59kHw=;
        b=OExfR68BsgiwaY2YbuOUXDtRKjVk6WGZrF3h4xnT22JKu0aKJ6dTOx8+9SYsT2yBqv
         PLUktsUkbPjFfnqi3GNQhNzXtekBl3PBBsN+tVblhNxH488WKCAR+2RZfvR4qTBZJ4mG
         iMg4tUFvgkF2XWPnRaDlG1AFkD99ye2Bo835nHj+VG2tS0gHeVrWVBg9acGVsNK5SGX/
         m2JHN0d7ctJMGc37IC5sL6Qz5Qe+yWYrMokEjX26NujW6XxTunMsm1lgZf9nNknZejex
         6q0v1afK7vvPX1YXvrijcc++hRG6A7p7tBAUOAXs3SnTKdeVnsGweCWlK1n9aNuGrLc2
         ANTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790098843; x=1790703643;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r/bMORLOO0A6N2IaZslfOPlgoSE19zFgKkh7hU59kHw=;
        b=n0hX3wx9nJj2b8Rxl+TodCkA83o8LrUYcexdRFFskFkukpUF5uqbt2uhBLg30UC+iL
         B6rVpfjvDX+kfBz5kAYQLP3tLmo8yGbmUwnDnMmij+lfnS/vbuZFN6VyOl6ok75OyEd9
         4H3/2IKGbJfoQtvNvM+dnp37QzimZWhBte08t+06vv4Hs0g4TqfoiKnsDaXCHeVAehS2
         1tY+ujxDIB2BQgT5hsi8VpeqKmKeoEkQxhJSi4rYPjm5CJWyUfoV61jgvyjlUrzr34c5
         bTdX9rR/eSds7teKKbKSZ2Tki2DLoilFNLP5qkivLkyI5VbheXd9hYDSm0yUudQ9jZnz
         WVkQ==
X-Forwarded-Encrypted: i=1; AKwUvBzc98wO1uqf1eupCK2Zv+c5ueMjTbYEIf46oSyPil04Qgjct5goQqxdfpyQV/23ZpCX9AlcCvvv0EgXWg==@vger.kernel.org
X-Gm-Message-State: AFuF++llshvtYsQmug50ffUXG9KY8ftvTStTrlWVFmEyv1LNTDl0l7gJ
	iSO2kOFBaBvs048HIMyqtoASNLwz5i7ZfyC/nP526PVNKKUZQrEUxsZ7
X-Gm-Gg: AYBFou18jBCAGM7ahvvNYc5tiNCAud1vvnmJ/qnPHAsKHa5DQn1Z0l/Zqn6zlp18c/m
	sDcr8A0ZYlC0MiokH4Iy1daIsQNvlOArTvm9CAlgedg5rghAbH1CN7QaM8yCOEeCEQu1yUihJbd
	Up6r1WaOC1Dn1XCGto4e1vOIc7n/oq0pRyJxkAiSUSXssBQtNghhXa9XXDd+QBTthCDI0aOnk3m
	dcYwLm6hjZ7FQVLgyY3Yxry70CoylnJRuXlT3VtdXD1bWFc75UTIQsInlvIK4p83O3bpyjsqo2q
	cZslC8yxGduckVF9cRuLKsbxYvv5oFjdbeNsMnf0OAQQLShaDY+9H2qBnrvzMcQeHLPEVDW8qIJ
	JymKVUfPD3f3myF9ILVK94/gtFBSb4fCFhhktl3WqN55Aqsw+X/kQKg/qQSkVwL4pqfbv4f7Z4G
	+egmzdzBrldJIcggFlFzCVoZGxdw7YUKjii3BFJDbWFs3oda6YuCaZDzgMzxG2IYcRnaGYc3KNo
	xdMiEErE6TY4ZBHS80s8wtaTbUbwzJclqUz/BPCny8=
X-Received: by 2002:a17:907:6d27:b0:c25:4f7c:8ec5 with SMTP id a640c23a62f3a-c2a158032f4mr1331027166b.23.1790098843019;
        Tue, 22 Sep 2026 10:40:43 -0700 (PDT)
Received: from [192.168.86.89] (81-224-151-184-no600.tbcn.telia.com. [81.224.151.184])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aad5bed0asm2549666b.18.2026.09.22.10.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 10:40:41 -0700 (PDT)
From: =?utf-8?q?Erik_H=C3=A5kansson?= <erikhakan@gmail.com>
Date: Tue, 22 Sep 2026 19:40:28 +0200
Subject: [PATCH 2/2] HID: logitech-hidpp: fix Bolt wheel mode handling
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260922-feature-bolt-fix-v1-2-63b0fa8da0d3@gmail.com>
References: <20260922-feature-bolt-fix-v1-0-63b0fa8da0d3@gmail.com>
In-Reply-To: <20260922-feature-bolt-fix-v1-0-63b0fa8da0d3@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Rafael Passos <rafael@rcpassos.me>, 
 =?utf-8?q?Gr=C3=A9goire_Stein?= <greyxor@protonmail.com>, 
 Alexey Zagorodnikov <xglooom@gmail.com>, 
 Oleksandr Natalenko <oleksandr@natalenko.name>, 
 Roman Stingler <roman.stingler@gmail.com>, 
 Lovekesh Solanki <lovekeshsolanki00@gmail.com>, 
 =?utf-8?q?Kate=C5=99ina_Medv=C4=9Bdov=C3=A1?= <k8ie@mcld.eu>, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Erik_H=C3=A5kansson?= <erikhakan@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790098832; l=7252;
 i=erikhakan@gmail.com; s=20260922; h=from:subject:message-id;
 bh=9pWsAPJMjYeb1fOw15u6xalyKmIivQfeiEo0bR0Nza8=;
 b=BnwiHmSknS0M0fKihikYarUMcPJFxWCz2ygmPPg8GhulBRVA1i4YjvatA1KCilhps+acLIAgA
 DPgOU81BmMfAsk+SDoxPRDDLrOGxdVcUicqEX2KuVsGfnKY1/SP7++h
X-Developer-Key: i=erikhakan@gmail.com; a=ed25519;
 pk=brCZX79/H6Z7mPgiNX6TDY45ZjODPth0eXRDUgh1mNI=

Preserve the device's user-selected resolution and inversion settings
while enabling HID++ wheel notifications for Bolt devices. Track diverted
wheel events and apply the device multiplier to both high- and
low-resolution events.

Signed-off-by: Erik Håkansson <erikhakan@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 112 +++++++++++++++++++++++++++++++++------
 1 file changed, 97 insertions(+), 15 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 166980be57b7..55e9ac5e5ab7 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -213,6 +213,7 @@ struct hidpp_device {
 
 	int hires_wheel_multiplier;
 	u8 hires_wheel_feature_index;
+	bool hires_wheel_diverted; /* whether wheel events use HID++ notifications */
 
 	bool connected_once;
 };
@@ -2043,8 +2044,14 @@ static int hidpp_hrs_set_highres_scrolling_mode(struct hidpp_device *hidpp,
 
 #define HIDPP_PAGE_HIRES_WHEEL		0x2121
 
+#define EVENT_HIRES_WHEEL_MOVEMENT		0x00
 #define CMD_HIRES_WHEEL_GET_WHEEL_CAPABILITY	0x00
+#define CMD_HIRES_WHEEL_GET_WHEEL_MODE		0x10
 #define CMD_HIRES_WHEEL_SET_WHEEL_MODE		0x20
+#define HIRES_WHEEL_MODE_USE_HIDPP		BIT(0)
+#define HIRES_WHEEL_MODE_HIGH_RESOLUTION	BIT(1)
+#define HIRES_WHEEL_MODE_INVERT			BIT(2)
+#define HIRES_WHEEL_EVENT_HIGH_RESOLUTION	BIT(4)
 
 static int hidpp_hrw_get_wheel_capability(struct hidpp_device *hidpp,
 	u8 *multiplier)
@@ -2072,6 +2079,26 @@ static int hidpp_hrw_get_wheel_capability(struct hidpp_device *hidpp,
 	return ret;
 }
 
+static int hidpp_hrw_get_wheel_mode(struct hidpp_device *hidpp, u8 *mode)
+{
+	u8 feature_index;
+	struct hidpp_report response;
+
+	int ret = hidpp_root_get_feature(hidpp, HIDPP_PAGE_HIRES_WHEEL,
+					 &feature_index);
+	if (ret)
+		return ret;
+
+	ret = hidpp_send_fap_command_sync(hidpp, feature_index,
+					  CMD_HIRES_WHEEL_GET_WHEEL_MODE,
+					  NULL, 0, &response);
+	if (ret)
+		return ret;
+
+	*mode = response.fap.params[0];
+	return 0;
+}
+
 static int hidpp_hrw_set_wheel_mode(struct hidpp_device *hidpp, bool invert,
 	bool high_resolution, bool use_hidpp)
 {
@@ -2085,9 +2112,9 @@ static int hidpp_hrw_set_wheel_mode(struct hidpp_device *hidpp, bool invert,
 	if (ret)
 		return ret;
 
-	params[0] = (invert          ? BIT(2) : 0) |
-		    (high_resolution ? BIT(1) : 0) |
-		    (use_hidpp       ? BIT(0) : 0);
+	params[0] = (invert          ? HIRES_WHEEL_MODE_INVERT : 0) |
+		    (high_resolution ? HIRES_WHEEL_MODE_HIGH_RESOLUTION : 0) |
+		    (use_hidpp       ? HIRES_WHEEL_MODE_USE_HIDPP : 0);
 
 	return hidpp_send_fap_command_sync(hidpp, feature_index,
 					   CMD_HIRES_WHEEL_SET_WHEEL_MODE,
@@ -3912,16 +3939,43 @@ static int hi_res_scroll_enable(struct hidpp_device *hidpp)
 {
 	int ret;
 	u8 multiplier = 1;
+	bool high_resolution = true;
+	const bool is_bolt = hidpp_is_bolt_child(hidpp->hid_dev);
+
+	if (is_bolt)
+		hidpp->hires_wheel_diverted = false;
 
 	if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_HI_RES_WHEEL) {
-		bool use_hidpp = hidpp_is_bolt_child(hidpp->hid_dev);
+		u8 mode;
+
+		/* Preserve the persistent mode, except for Bolt event routing. */
+		ret = hidpp_hrw_get_wheel_mode(hidpp, &mode);
+		if (ret == 0) {
+			bool invert = mode & HIRES_WHEEL_MODE_INVERT;
+			bool use_hidpp = mode & HIRES_WHEEL_MODE_USE_HIDPP;
+
+			high_resolution = mode & HIRES_WHEEL_MODE_HIGH_RESOLUTION;
+
+			/* Preserve user-set resolution and inversion; enable HID++ for Bolt. */
+			if (is_bolt && high_resolution && !use_hidpp) {
+				ret = hidpp_hrw_set_wheel_mode(hidpp, invert,
+							       high_resolution, true);
+				if (ret == 0)
+					use_hidpp = true;
+			}
 
-		ret = hidpp_hrw_set_wheel_mode(hidpp, false, true, use_hidpp);
-		if (ret == 0)
-			ret = hidpp_hrw_get_wheel_capability(hidpp, &multiplier);
+			if (ret == 0)
+				ret = hidpp_hrw_get_wheel_capability(hidpp, &multiplier);
+			if (ret == 0)
+				hidpp->hires_wheel_diverted = use_hidpp;
+		}
 	} else if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_HI_RES_SCROLL) {
-		ret = hidpp_hrs_set_highres_scrolling_mode(hidpp, true,
+		/* Bolt reports for this feature also bypass hid-logitech-hidpp. */
+		high_resolution = !is_bolt;
+		ret = hidpp_hrs_set_highres_scrolling_mode(hidpp, !is_bolt,
 							   &multiplier);
+		if (!ret && is_bolt)
+			multiplier = 1;
 	} else /* if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP10_FAST_SCROLL) */ {
 		ret = hidpp10_enable_scrolling_acceleration(hidpp);
 		multiplier = 8;
@@ -3938,8 +3992,12 @@ static int hi_res_scroll_enable(struct hidpp_device *hidpp)
 		multiplier = 1;
 	}
 
+	/* Keep the device-reported multiplier for HID++ event conversion. */
 	hidpp->hires_wheel_multiplier = multiplier;
-	hidpp->vertical_wheel_counter.wheel_multiplier = multiplier;
+	/* Apply the multiplier only while high-resolution mode or HID++ diversion is active. */
+	hidpp->vertical_wheel_counter.wheel_multiplier =
+	(high_resolution || hidpp->hires_wheel_diverted) ?
+		multiplier : 1;
 	hid_dbg(hidpp->hid_dev, "wheel multiplier = %d\n", multiplier);
 	return 0;
 }
@@ -3997,17 +4055,41 @@ static int hidpp20_hires_wheel_raw_event(struct hidpp_device *hidpp,
 
 	if ((data[3] & 0xf0) == CMD_HIRES_WHEEL_SET_WHEEL_MODE) {
 		u8 mode = data[4];
-		bool hires = (mode & 0x02) != 0;
-		int new_multiplier = (hires && hidpp->hires_wheel_multiplier > 0)
+		bool hires = mode & HIRES_WHEEL_MODE_HIGH_RESOLUTION;
+		bool use_hidpp = mode & HIRES_WHEEL_MODE_USE_HIDPP;
+		int new_multiplier = ((hires || use_hidpp) &&
+				      hidpp->hires_wheel_multiplier > 0)
 			? hidpp->hires_wheel_multiplier : 1;
+
+		hidpp->hires_wheel_diverted = use_hidpp;
 		hidpp->vertical_wheel_counter.wheel_multiplier = new_multiplier;
 		return 1;
 	}
 
-	/* wheel movement event: 16-bit signed delta in HID++ ticks */
-	if ((data[3] & 0xf0) == 0x00 && size >= 7 && hidpp->input &&
-	    hidpp->vertical_wheel_counter.wheel_multiplier) {
-		s16 delta = get_unaligned_be16(&data[5]);
+	/*
+	 * HID++ 0x2121 wheelMovement event:
+	 *   data[3]    = event/function index in the upper nibble (0x0),
+	 *                client ID in the lower nibble
+	 *   data[4]    = event flags; bit 4 indicates high-resolution units
+	 *   data[5:6]  = signed 16-bit big-endian vertical wheel delta
+	 *
+	 * The outer HID++ path normally validates long reports as 20 bytes, but
+	 * keep the size check below before reading data[5:6] from the buffer.
+	 * Low-resolution deltas are converted using the device's multiplier
+	 * before being passed to the scroll counter.
+	 */
+	if (data[3] == EVENT_HIRES_WHEEL_MOVEMENT && hidpp->hires_wheel_diverted) {
+		int delta;
+
+		if (size < 7 || !hidpp->input ||
+		    !hidpp->vertical_wheel_counter.wheel_multiplier ||
+		    !hidpp->hires_wheel_multiplier)
+			return 1;
+
+		delta = (s16)get_unaligned_be16(&data[5]);
+		if (!(data[4] & HIRES_WHEEL_EVENT_HIGH_RESOLUTION))
+			/* low-resolution delta: convert to hi-res units */
+			delta *= hidpp->hires_wheel_multiplier;
 
 		if (delta) {
 			hidpp_scroll_counter_handle_scroll(hidpp->input,

-- 
2.55.0

