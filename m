Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AD949B470
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 12:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792327706; cv=none; b=uoDuPphjsrpweJ0EDM1+n4B9IwobfXlnhoVDAIb2MJ22fAabZoXOzyJbVb8wFGnqOTX+GgDbNMHQdRYL9f5V7foAvssYpNCV3JXCeYjskLeD1PZV71dwGQmvufpvgKNQaxs59Hyy1OL8LFwp7VmsUEEPpJbh85YnYZDX+qrs3mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792327706; c=relaxed/simple;
	bh=lN41a61/nKGGG/YTHpOK/9MR+fMHvrEQ5y32R9jcciw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGPn7e71faO0Lez6n5K79UloeArMqQNKCW5mkKFr5oZ93ncywj+ampTlyCSL7tc6NqKqL8g3+Ym7k/oh5hpYNHoZtX1YMoAPzgjovtCh9xpBCsMrktucUjix2C8l9nvW7x5HJPeO1y9E55+/ixojIeZ+v9WI4STBYzKXlbEhmCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuNjyExD; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuNjyExD"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ab41538192so997022a91.0
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 05:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792327699; x=1792932499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+CsZ2iMRB1tUMxGPpgV7ei32dAx256Q8EZ78cw7J4Mk=;
        b=UuNjyExDUrlOn6vVkCs5mF5LqDTWLaUF0a6+XMJKICgfPVgdzyshJ+Hk0MCfZ7gk20
         77lHy92V2EdUiOp9H26/E3yTdfdh4cS8VvbRlcmZAMZEJWFmvKBreq3Deg8o1x0nfTGE
         AwoIHCBZZ4xiJnWC6F4mL1awElepMlIaog56Heg4Pn+bkObUVOa4UNiUCNKOZFXUw1Fn
         KLDfOL3PacI9tEBhHue4PC/VlgZr1JUORhrCbQTVVCwqc0bbMKbyIle/aLYKNsABiA2c
         y+fkmNSLzX/q7mkmN0yVyV2qbVrKi5nPYi1yoCvaLdB5bbjHwMrfaOMSVupXxtO/YgIK
         Mm5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792327699; x=1792932499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+CsZ2iMRB1tUMxGPpgV7ei32dAx256Q8EZ78cw7J4Mk=;
        b=2nT7iTJa5Lz8nGgkVJH1VO/mO1+h8Q67V4e49PzCnCa2+dLQOR5jUAtwt6seFPi2lH
         xb1M24y+7Gof8oV1JiwREbSAc5/C2+Z/2U7RdBkYLjsQaHtj/ENYVFjIGXmvuvEiHF3I
         cWu2umP4dExAKt8B5FydQqmAGPlf361hzPUFTQxkYQYxjD5vZSr7xwcj042qjr08Uoek
         yVY5pViF33UusVuCczcyEr1mO2nbGK7KE7rym8soNpBIqtZBWBOA4tiayQujblP//qY1
         9dTOmdIdhsoyIpTncsdkjtDxF1WD+vvnxrUjFyhQf0BTqtvyKfL0S9aeqEsL9f54Gj3a
         F0xA==
X-Forwarded-Encrypted: i=1; AKwUvBw3AOq4/20TsFxE8uVOrvMDQ8HFoB/DhMSftTYONh0f9IMsNnEqDvrSyO5ow2eP4zKej8kU8CCZI0fgvA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLEmyQjWTeOMiteAEaGWEhGelT2mtyBEKuMmbX/jj8NpJdXucb2
	AsD+9mG6zCWWc45vrKFvsjQ9ry0M6+Hr4+HDIoJbFdPOZNRCXsKV8xqH
X-Gm-Gg: AYBFou2Lekg164bkfmylMcWSgbYOYDSHOJjn3XOCSs0BMnLEtYYlV3w3JJ8TO1qGKKQ
	N8M2q/V7DqacYgyGZf6P1VI3ZUAhUnSi/JOQZYYBvl7cShitddN8TkPnuRbWHkHxUg1Gd1T84YI
	aQ7X2HZCLByDZ6JBdimvPWnxYwv/ze4SKM55fnBKDLdMkyB4SrT5Y8addTImCbPi3iN1lY0Pe7k
	gdtWPc2o0+Z4UmQlRhGCUQpAeaYOIfmbnA4QEoY1/y1AdpfV3Z8axePGCnWor1odfjtDwHYSLDK
	XbafcoWXMjG07YEiIbJFiTkY3niCBBN44PaRnOiptVjpS5paoJEaziWxSSrxCXS2RJzH2CbZeCY
	+PdqKM4CxABSOE5XLUBYt+rx3/mGkXQhRxUm0t/pxgblctPDIp6TlJRakWfMiBelnOOnczbeW6r
	HnJUU6KoNH+apas57yTq9ZWPOr6ec3JJ7vkzaftLNBvycVA3zxnWYK5Lk4LubEqX5a/3vVFe1Ro
	z8wHJH7vFTyLLatrEqzP2E=
X-Received: by 2002:a17:90b:2701:b0:3a7:3474:b1ee with SMTP id 98e67ed59e1d1-3acef11c1b5mr4055247a91.60.1792327698656;
        Sun, 18 Oct 2026 05:48:18 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6549ee946sm2804669a12.20.2026.10.18.05.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 05:48:16 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH v3 5/6] HID: wacom: add NULL input guards to Bamboo touch/button handlers
Date: Sun, 18 Oct 2026 21:47:54 +0900
Message-ID: <20261018124755.850888-6-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018124755.850888-1-jinmo44.yang@gmail.com>
References: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
 <20261018124755.850888-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_bpt_touch() dereferences both touch_input and pad_input.
wacom_bpt3_touch_msg() dereferences touch_input.
wacom_bpt3_button_msg() dereferences pad_input.

All three can be NULL when the corresponding
wacom_setup_{touch,pad}_input_capabilities() returns -ENODEV during a
successful probe. Add per-function guards.

Fixes: 2a6cdbdd4cc0 ("HID: wacom: Introduce new 'touch_input' device")
Fixes: 862cf5535c0c ("HID: wacom: Introduce a new WACOM_DEVICETYPE_PAD device_type")
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
---
 drivers/hid/wacom_wac.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index e0bf03123cf9..a34db1505625 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3151,6 +3151,12 @@ static int wacom_bpt_touch(struct wacom_wac *wacom)
 	if (data[0] != 0x02)
 	    return 0;
 
+	if (!input || !pad_input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: input is NULL\n", __func__);
+		return 0;
+	}
+
 	for (i = 0; i < 2; i++) {
 		int offset = (data[1] & 0x80) ? (8 * i) : (9 * i);
 		bool touch = report_touch_events(wacom)
@@ -3185,8 +3191,17 @@ static void wacom_bpt3_touch_msg(struct wacom_wac *wacom, unsigned char *data)
 {
 	struct wacom_features *features = &wacom->features;
 	struct input_dev *input = wacom->touch_input;
-	bool touch = data[1] & 0x80;
-	int slot = input_mt_get_slot_by_key(input, data[0]);
+	bool touch;
+	int slot;
+
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: touch_input is NULL\n", __func__);
+		return;
+	}
+
+	touch = data[1] & 0x80;
+	slot = input_mt_get_slot_by_key(input, data[0]);
 
 	if (slot < 0)
 		return;
@@ -3229,6 +3244,12 @@ static void wacom_bpt3_button_msg(struct wacom_wac *wacom, unsigned char *data)
 	struct input_dev *input = wacom->pad_input;
 	struct wacom_features *features = &wacom->features;
 
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: pad_input is NULL\n", __func__);
+		return;
+	}
+
 	if (features->type == INTUOSHT || features->type == INTUOSHT2) {
 		input_report_key(input, BTN_LEFT, (data[1] & 0x02) != 0);
 		input_report_key(input, BTN_BACK, (data[1] & 0x08) != 0);
-- 
2.53.0

