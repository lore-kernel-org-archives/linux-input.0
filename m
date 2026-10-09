Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DB636F415
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 19:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791572875; cv=none; b=YhuhmOpGQpNaJETAjOlbTzUhhkMSYL4NPEu3Vv6bscjAdrbbYUJcWO/xGU+R27Cdmkf/QFVbbosbfxiYlbnRuUCu1udn0OWHvCyH82gOhtGy+ZCmrUlVPo3Q/C3PhGN4Ptm2KUIoKoc/WVUXdGpJuDEXpmvmmdN+i83N52dxVF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791572875; c=relaxed/simple;
	bh=Xj3kRT6xPE7VXYWKueo0H5/7Ixh1C1w6dYyrpbTktjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHn9ZoEdkYAAf6ygFEJiaYQC1tFFgBScHw1yTdU+Cyz7REgV02+FCEZhn2Zgh/gOZoJ39Sx7ui5eOxKOXgRJxCh4cJHHNJINdJA0BW6dTmQrSKl70rQ+kb9xUEeq0YlSWjGq2OLDk49V8CEJhbDv61XRwUuHf4PQp1D9fAx/BMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYPtIJMy; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYPtIJMy"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-35829219da8so3291eec.0
        for <linux-input@vger.kernel.org>; Fri, 09 Oct 2026 12:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791572873; x=1792177673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sETPdBzi3R8Ul8/+76gfS5YN3ljZo4d+VndLRlKoLkI=;
        b=fYPtIJMyBKQXdyBl5ia96dTtGq4yz26bW9umJGf0EF13e4CYI8OddTpWtmykgQrE6D
         77eTHBNLessdWuOgc0zvsi3MIn7mayTvRmI9L13TVxjXe3DViC6QXbUVVZ9HAvvIYUka
         iLZjwoPnVlqIPJdCbP8HU2hFUvETniYu5BGgzyHKu6sS4FjrFRS4CUM/lVkVtfbWMt11
         8N6g8ShjEpHfqege8YRa0VRdgIlSAEKRg1lSgnew8nuJa19x6gG3+d8Dc2Snve3o6OcA
         yQOgO9erowWuR3PYS4pVQDxhBlElJ1qlOvdEUA5/wsmbzk2J7kCCSduV09ePjtdiC3Kc
         3QYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791572873; x=1792177673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sETPdBzi3R8Ul8/+76gfS5YN3ljZo4d+VndLRlKoLkI=;
        b=P9UP+PWljIKg7Q4zRqknJCofeSMWVcrfMWJBCnBjgtMgnP+3xbrQihjgWPbC1BAAPe
         MuPQkyp6RXP0nAhLbbv5vCKA4pSiebc7d42o4lOXJq7lUZDpDDDwLFP6DHeUH1ufdYJl
         pJB3hZQ7LXMZ9G29Sp9MRjgdh+xn1S3MLaY0ysjnA67j4FjmZbQcyCSOfyYS0V1ImyHP
         d29yxbOIDcU+0RgRjB0j4AHOaRraMKVHLp7fcv2+hE3aOTnfdNUClWQwTNd66foY8ZXm
         SmmKoyGO4NlQJWVhnDk02HfcOjFhxTMubEMM8MIzzoR8SyjFCO5TQYHBv0s1Z/x38fjU
         Dfzg==
X-Gm-Message-State: AFq9FYLM43VH5b4NE+tr1q6oyY/L9quszaMOWEI8z9w6xaRpmQOJkI5e
	OtOHdbs3p0tdL/xrG/gr0b+9zCiO38xw2UqOj0vA5WQQZI2LHv8QU7ElHPlqIrn8
X-Gm-Gg: AYBFou3H9/5eFP82mnB0DUuYkqnyatf7J5N2Qjhs5SgQx5Q5vXfC0KNuXETyZCoJCQo
	cTzRxPFNZp1MBTTEfCO7FybWRqWAUenIVNtL0ild4ul0c+f/7EOAZkjPpZywX/nbt4ldt792q7n
	/vMiGtT9+ZC+vFEvwEh0BM+VJtBWVVN0Ub78qKV/e2sw7i9/GYDomQSgg2qde3ovu+iHhy0yDms
	Kx95jVzLz7LSAs+bALwlhLwUh4hh7IOGKij17MB2n25DHx0WXkkmEJVWgYHYLnPB1BnXXylbn4b
	KIMFKtR6QEwnNLfLsZcxm5Sj6PvuYJIq/foWuDGMuawhi3M6y7FR/uiJJ3bSnZTbNa+Kt7mv8s2
	Gr5l+DNK7zkdZeEVAKGEQ8CXvCQ1qQnL8d8LOrdEqlsvjpMoops+4fz5mh9rop3D7i6f2e9irDN
	Jv7cPElOdlEIvlHHOOM1Mts6wl4NGvkW6Ue+ZwFR4Aqn6rJBdKiGmlVMbj5/AdQLaZyiUAD23Qp
	SYduPGCdu5/ugN9SQfFxSb8kRKyQe5aH0e0Q9Ah04NYT3aHUvRHB30i01+czA==
X-Received: by 2002:a05:7301:6487:b0:351:695d:c942 with SMTP id 5a478bee46e88-3537e01235fmr3494159eec.11.1791572873001;
        Fri, 09 Oct 2026 12:07:53 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:8725:99de:769c:1fe])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c61eaa0sm10191598eec.0.2026.10.09.12.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 12:07:52 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] Input: wacom_w8001 - assign distinct phys paths to pen and touch devices
Date: Fri,  9 Oct 2026 12:07:43 -0700
Message-ID: <20261009190746.803607-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261009190746.803607-1-dmitry.torokhov@gmail.com>
References: <20261009190746.803607-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, both pen and touch input devices used the same phys path
"%s/input0", which made it impossible for userspace or udev rules to
distinguish the devices by physical topology.

Assign distinct phys paths by introducing separate buffers pen_phys
("%s/input0") and touch_phys ("%s/input1") in struct w8001. Pass the
corresponding phys path to w8001_allocate_device() during pen and touch
setup, and drop the shared phys buffer from struct w8001.

Fixes: e0361b70175f ("Input: wacom_w8001 - split the touch and pen devices into two devices")
Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/wacom_w8001.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
index 1c48e2775214..e967f2413706 100644
--- a/drivers/input/touchscreen/wacom_w8001.c
+++ b/drivers/input/touchscreen/wacom_w8001.c
@@ -91,7 +91,8 @@ struct w8001 {
 	unsigned char response_type;
 	unsigned char response[W8001_MAX_LENGTH];
 	unsigned char data[W8001_MAX_LENGTH];
-	char phys[W8001_MAX_PHYS];
+	char pen_phys[W8001_MAX_PHYS];
+	char touch_phys[W8001_MAX_PHYS];
 	int type;
 	unsigned int pktlen;
 	u16 max_touch_x;
@@ -495,7 +496,8 @@ static bool w8001_detect_touch(struct w8001 *w8001,
 }
 
 static struct input_dev *w8001_allocate_device(struct w8001 *w8001,
-					       const char *name)
+					       const char *name,
+					       const char *phys)
 {
 	struct input_dev *dev;
 
@@ -504,7 +506,7 @@ static struct input_dev *w8001_allocate_device(struct w8001 *w8001,
 		return NULL;
 
 	dev->name = name;
-	dev->phys = w8001->phys;
+	dev->phys = phys;
 	dev->id.bustype = BUS_RS232;
 	dev->id.product = w8001->id;
 	dev->id.vendor = 0x056a;
@@ -529,8 +531,10 @@ static int w8001_setup_pen(struct w8001 *w8001, const char *basename,
 	int error;
 
 	snprintf(w8001->pen_name, sizeof(w8001->pen_name), "%s Pen", basename);
+	snprintf(w8001->pen_phys, sizeof(w8001->pen_phys), "%s/input0",
+		 w8001->serio->phys);
 
-	dev = w8001_allocate_device(w8001, w8001->pen_name);
+	dev = w8001_allocate_device(w8001, w8001->pen_name, w8001->pen_phys);
 	if (!dev)
 		return -ENOMEM;
 
@@ -572,8 +576,10 @@ static int w8001_setup_touch(struct w8001 *w8001, const char *basename,
 	int error;
 
 	snprintf(w8001->touch_name, sizeof(w8001->touch_name), "%s Finger", basename);
+	snprintf(w8001->touch_phys, sizeof(w8001->touch_phys), "%s/input1",
+		 w8001->serio->phys);
 
-	dev = w8001_allocate_device(w8001, w8001->touch_name);
+	dev = w8001_allocate_device(w8001, w8001->touch_name, w8001->touch_phys);
 	if (!dev)
 		return -ENOMEM;
 
@@ -669,7 +675,6 @@ static int w8001_connect(struct serio *serio, struct serio_driver *drv)
 	w8001->serio = serio;
 	mutex_init(&w8001->mutex);
 	init_completion(&w8001->cmd_done);
-	snprintf(w8001->phys, sizeof(w8001->phys), "%s/input0", serio->phys);
 
 	serio_set_drvdata(serio, w8001);
 	err = serio_open(serio, drv);
-- 
2.56.0.385.gd3acb90ef8-goog

