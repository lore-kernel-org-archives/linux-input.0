Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8FD36E49F
	for <linux-input@vger.kernel.org>; Wed,  8 Apr 2026 03:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775618093; cv=none; b=ePCiNx0Vta4aCz6LpeFyNZTJ9VUIH/vEICRVLVvMBa/RKMM0m9rbH9pIXYQKBFbfKu6lKBtMq5O8EATKnw4DU1sX6GHnWJiNDnxzjpn605xQn5LoEOnrg9W8sZWt5t47w70ZzLRREaQNr1QaEWrqjJK/gBAjEL2n5wW61OQz6l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775618093; c=relaxed/simple;
	bh=L5J6/lBVVUbJIitRNipw7vQuk0sM3jo9lwubqdP0Mdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P1pzL50A1YnkWwUp2/aCt0TFc8lIo33SvfYLvlzZoMquxaTyWpGdUujc20dO7mCdcSLrCTxkQd5dXUk7H43v227vEa+8XNs/P7m/pBHHqVw51k6B7BRWTvH5fKKIG3KM3EUSH0bkDmWV8AH2mWTOHYtSgI/JUdad6ooaY/Y57oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYvyqC9u; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYvyqC9u"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c742b9b7727so174735a12.0
        for <linux-input@vger.kernel.org>; Tue, 07 Apr 2026 20:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775618091; x=1776222891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IpbH4+lkTk1MyWcrbv0IyQEd4jFHXAG0okd3inJYf94=;
        b=VYvyqC9uIHzoYcJRGDnZCt4Y8+AGyIPHAzg1d8CkcTn5TK9l2Hj8gEFuOR6q1qtnWO
         duIScwmfPa+JTj9ehDqKaifzpnyfS3HGr53LN6KcGab+opeEBf+iNqjkoSQ6kUYnl+Zb
         TgHCkhniiyhk5uhq35MaBjVVx0V3uGhVJgRecWo5WWnvBG81rYwizovijDEW9IdVODiU
         w3TuvH57IJ2ynC7y0IJpS01sXPMB0BGNTGkFuHCzkwEotiPoovgGFMeVbdyzxebtMsXF
         IWoJNAtvh/Wx/EwgHj5l5te8wgIXTTGKpnufybndCBJNmKWAB79fgXHirKAM6FVFpBIq
         fZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775618091; x=1776222891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpbH4+lkTk1MyWcrbv0IyQEd4jFHXAG0okd3inJYf94=;
        b=RcJ8r+UO8gkPFmChXVrTesg1g/yQuxCFW2xFDj/wpzJoXZp+z2iQQBHMTuHAs9fNYS
         muyYG9oxdk0oiu1ZmHmtJlNbQn37vNXwlog0WBn18Ep6gY9LMrAizY3YFlJGiYla5hlp
         7pDfpYh30pBM6NdEG+V/TpnFugH6iUWxtfbFoYx5SDq+bMexbVMbPnUg70I0SIunBfg2
         a4irOwpg1bwm0VsIGxB2DNn0M8dsLt6sdIVYhyHAWgHpA+/xHgzp8kJCtAHZ4+nEWoHb
         rTfU+ZLlVlFNpaQeNM7mPIuDOD+P/lA8erlA1gOVGKpmoGysvce3oigen644kaP3g+zo
         0Ldg==
X-Gm-Message-State: AOJu0Yxe5UjJwH69oBeA1jgScADK5oCgKvuPJ4q6DBINrBlZvovRsolm
	F7bEJu/qQ1fEpuXtJr9kUAH57DL4stSYsfeZjb3KWn1noVJIGdZ9vejBMNp+H6dBrVw=
X-Gm-Gg: AeBDiesXt+bVQk/DY3XAeBTW+ploDWnHpwLrFLaiHhH1wClcjK39zjvpqD0VasQWyfE
	/UuHZWszOh+41bDxMAcQ2UGf8dt2RrUVVqoGZNeX4J+7XP5RrnOrIc2Bqo9HpDikFzYvrwfr6Fw
	Q8m/w76hMWhcDRIC4ZQFQu+tJ0Cyi8Bb6gcX+BuGfPNdY036upaOHk0qGqt6OBMew6+anf9isUB
	poZuujkw+IgauF2XWd5rWBaxfSkdbjanNJnsNLe0SXJpeGPWyn6k2isvQXQYk26+Z+ES5pvBtjg
	C7zKagbO2/RCTHkyCAo5T7zHJ1nwO6gcXTZqUNChRY4xeH75QuX3q6rs3MdGOJTxVwQ85pKKW8r
	u3/xoWJauLt3AZbc2mVVe2DS/kYX6d1oqUjB04Ra7QMvqtDix4ruilQUFT8I7D9fiMd+QdcjyVN
	y0YHq4RnLS9PQctCy0JY5lJFnwkQ7nhDf8HJquFbjXzVzWRGg=
X-Received: by 2002:a05:6a20:a122:b0:398:7daf:6d7e with SMTP id adf61e73a8af0-39f2d9e755dmr17523612637.17.1775618091015;
        Tue, 07 Apr 2026 20:14:51 -0700 (PDT)
Received: from LAPTOP-3SN9PV9T ([42.112.110.201])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82d11cd2ce2sm18365467b3a.6.2026.04.07.20.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 20:14:50 -0700 (PDT)
From: Thanh Nguyen <thanhnguyxn07@gmail.com>
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	Thanh Nguyen <thanhnguyxn07@gmail.com>
Subject: [PATCH] Input: zinitix: don't use finger_mask as bitmask when reporting contacts
Date: Tue,  7 Apr 2026 22:14:40 -0500
Message-ID: <20260408031440.955-1-thanhnguyxn07@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.2
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The zinitix touchscreen driver was treating touch_event.finger_mask as a

bitmask to iterate through finger slots. However, on some devices (e.g.,

Samsung Galaxy A3 2015), finger_mask behaves as a finger count rather than

a bitmask, causing multitouch to malfunction.

Instead of relying on finger_mask as a bitmask, iterate through all

possible finger slots and check if SUB_BIT_EXIST is set for each slot.

This restores proper multitouch functionality on affected devices.

Fixes: e941dc13fd (")

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221278

Signed-off-by: Thanh Nguyen <thanhnguyxn07@gmail.com>
---
 drivers/input/touchscreen/zinitix.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/zinitix.c b/drivers/input/touchscreen/zinitix.c
index 716d6fa60..b80525443 100644
--- a/drivers/input/touchscreen/zinitix.c
+++ b/drivers/input/touchscreen/zinitix.c
@@ -445,7 +445,6 @@ static irqreturn_t zinitix_ts_irq_handler(int irq, void *bt541_handler)
 	struct bt541_ts_data *bt541 = bt541_handler;
 	struct i2c_client *client = bt541->client;
 	struct touch_event touch_event;
-	unsigned long finger_mask;
 	__le16 icon_events;
 	int error;
 	int i;
@@ -470,11 +469,12 @@ static irqreturn_t zinitix_ts_irq_handler(int irq, void *bt541_handler)
 		zinitix_report_keys(bt541, le16_to_cpu(icon_events));
 	}
 
-	finger_mask = touch_event.finger_mask;
-	for_each_set_bit(i, &finger_mask, MAX_SUPPORTED_FINGER_NUM) {
+	/* Process all finger slots and check if they exist, rather than relying on finger_mask as a bitmask.
+	 * On some devices (e.g., Samsung A3 2015), finger_mask behaves as finger count rather than bitmask.
+	 * Only process contacts that are actually reported as existing. */
+	for (i = 0; i < MAX_SUPPORTED_FINGER_NUM; i++) {
 		const struct point_coord *p = &touch_event.point_coord[i];
 
-		/* Only process contacts that are actually reported */
 		if (p->sub_status & SUB_BIT_EXIST)
 			zinitix_report_finger(bt541, i, p);
 	}
-- 
2.51.0.windows.2

