Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF0538D6A8
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 06:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144886; cv=none; b=NP6SODizMGO2KxEE1wQ5ub5CSqtT5Q/gOp2evqnsrBM0ppPMoGjUp8FacLKsevjvwA3hrjm5uHlFDXvV3UxCPRLTk8bJWnzcuxWis768mJAjIMRxoY5hefSLDoELPvLF9Kq4ak0+RNbRDBrAEUNezGN0l7Oo4TAOO7n6+WUrcGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144886; c=relaxed/simple;
	bh=IpUL4wrOEnu0xqQ6JcC1ajXAoUS6XoZgxW5kFuMPOaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKk6ZVMb6KNZwi4k4b0WBJ7jNwWIoGKFp/QSxSn89+73Hvr9aXhBPAc5fM2B9q+DGoMO3UPzDe3QZepdH0dNHSwml6VGDoBvzisglc0EL+KsSXXa1ThM1599IzyhvxARWFWOZk8e3CVr+nLzdewEXQPZg+RWIqcwYV99H886Gtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXT6SLsF; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXT6SLsF"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3817f800c8bso710110a91.1
        for <linux-input@vger.kernel.org>; Fri, 03 Jul 2026 23:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144884; x=1783749684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjigI2QMCNLqk6OpPU9sieyiKUEKCvOZPCBPdtvSMhk=;
        b=CXT6SLsFKRyGLO5bjnwVUGOJl4As8MK3XgvF+4fmfOOZuuPE/flA8sW3ac1NmIUIEr
         EsNO9MaSp2sTjkg8Rtjlust2jVZHton8xasyq17w7HA/EhquCqOmG6JIoPX1Y1vhy2ir
         x2roHTIsujZyFWH3cMkklaEaxOtC3481EJw27NuL+sDWj0+PlNzQWJgvZlRNqd4jM1V8
         5Pm4yumjZKsiYoqXopKgGyW9nxo6gtf5HBLhGXm2PC27frX32jkRmcR4AKgtIEcCYBRE
         LImx6nu5fr83gTpbrw/Ng26QSffZlwiJZNBgydTszqI6xF4ON1Jpn1j9FlVkWZbftS0E
         OZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144884; x=1783749684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hjigI2QMCNLqk6OpPU9sieyiKUEKCvOZPCBPdtvSMhk=;
        b=cf31zJ4133G0wqZMTnckNHusVzNzyVxmVrEOpX0fxkbck5UEpTe+Vg2bsUsAaXcrpq
         oqACngemarqoeogkPDQQWGh+aceGTq1dbUDMYGLMDttjssCY9DHiIN5tsUcfrY4S4loP
         2pBS4Z8Ym2OfjPe9YLvUQ4SzJLZZLjRmcAqLDNSkAlwiKDVCFZq1NTqwOQzjcBkuIF4H
         F4Cpj14uZLG/k+qE3s4ZF8vyv20YgqxFTaBvz0dbU5lvbDfPOsQ7pXYbLBF6MRItUJzk
         /sMj8ncoL1XaOK5IlpKK61xkdkKulrWzOW9P/CC+w6uTVyoRkg19Jicpf/E8HjcUVU8M
         9eww==
X-Gm-Message-State: AOJu0YwDDSZjQx6MvGyZARoJl2ueL4RpV97UiG0O1r0Ee/wTgfrMDMnw
	897S1nJiVkRKy3WEuhkiIFsAgnxeaHBLm31hCmfwxyfDRyInn6udbjS4wqNRAA==
X-Gm-Gg: AfdE7cmtiBwb888DFA7wiaXUFqTyHnoQX799IBE4rADRwFahwLEjSZbuHOcpCjd6ubD
	93OAiYEDgcADUskMkxTebOa7qO+xJtIYuxGMjtC5M2NYnMvXFPXHqP0BmfWgAKjq8ohKfWkxPjn
	oCG0LfVckXzam/kft9NgGJ/c0TzTkEmXvM66zPrdDidrBIvONfuNp1svTBfk0qhITjRIOywtbe9
	PbMHP1UcbKMinvz5BIP8GCC2+d8/oAHW4rIn6ssUmOfwuSabfIl4XX16m4XCYnM6GuWkbhqtAUX
	0vFIIeht8xXjGq9ZXsPKO0wYXzIpi58IVIAgJ1Iuc0BXj7tQs4aW2rUAQE/sntU7pLMvWCt6xvV
	U/KTk0YuAkbag6BtoPVvCleFeNGE/YiHKScXZOGf8jUJbS3TDClue5ozLpN5O41EXVm3/p378P+
	o/841gLBFzxnp6i4oGPNFm4jmkRmrVUQDBI4p64rqRl54aq9PeDKAoARWGqXN4iH1T0QfdSgAzW
	l8=
X-Received: by 2002:a17:90b:3b8a:b0:380:9d0d:7ade with SMTP id 98e67ed59e1d1-3825c50c9cbmr2517939a91.0.1783144884206;
        Fri, 03 Jul 2026 23:01:24 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f116065c5sm25081378eec.11.2026.07.03.23.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 23:01:21 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Linus Walleij <linusw@kernel.org>,
	linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: [PATCH 2/3] Input: mms114 - fix endianness portability in I2C packet layout
Date: Fri,  3 Jul 2026 23:01:13 -0700
Message-ID: <20260704060115.353049-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260704060115.353049-1-dmitry.torokhov@gmail.com>
References: <20260704060115.353049-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver defines the I2C packet layout using C bitfields in struct
mms114_touch. This is not portable as the layout of bitfields within a
byte is compiler-dependent and varies with endianness. On Big Endian
systems, the fields will be parsed incorrectly.

Fix this by redefining struct mms114_touch with plain u8 fields and
introducing bitwise macros to extract the values portably.

Reported-by: sashiko-bot@kernel.org
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/mms114.c | 52 +++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index 23e0283bc6b8..84afdadb3bcc 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -4,6 +4,8 @@
 // Copyright (c) 2012 Samsung Electronics Co., Ltd.
 // Author: Joonyoung Shim <jy0922.shim@samsung.com>
 
+#include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/of.h>
@@ -76,9 +78,16 @@ struct mms_chip {
 	int (*get_version)(struct mms114_data *data);
 };
 
+#define MMS114_FLAGS_ID_MASK		GENMASK(3, 0)
+#define MMS114_FLAGS_TYPE_MASK		GENMASK(6, 5)
+#define MMS114_FLAGS_PRESSED_MASK	BIT(7)
+
+#define MMS114_XY_HI_X_MASK		GENMASK(3, 0)
+#define MMS114_XY_HI_Y_MASK		GENMASK(7, 4)
+
 struct mms114_touch {
-	u8 id:4, reserved_bit4:1, type:2, pressed:1;
-	u8 x_hi:4, y_hi:4;
+	u8 flags;
+	u8 xy_hi;
 	u8 x_lo;
 	u8 y_lo;
 	u8 width;
@@ -244,28 +253,30 @@ static void mms114_process_mt(struct mms114_data *data, struct mms114_touch *tou
 {
 	struct i2c_client *client = data->client;
 	struct input_dev *input_dev = data->input_dev;
-	unsigned int id;
+	unsigned int id = FIELD_GET(MMS114_FLAGS_ID_MASK, touch->flags);
+	unsigned int type = FIELD_GET(MMS114_FLAGS_TYPE_MASK, touch->flags);
+	bool pressed = FIELD_GET(MMS114_FLAGS_PRESSED_MASK, touch->flags);
 	unsigned int x;
 	unsigned int y;
 
-	if (touch->id == 0 || touch->id > MMS114_MAX_TOUCH) {
-		dev_err(&client->dev, "Wrong touch id (%d)\n", touch->id);
+	if (id == 0 || id > MMS114_MAX_TOUCH) {
+		dev_err(&client->dev, "Wrong touch id (%d)\n", id);
 		return;
 	}
 
-	id = touch->id - 1;
-	x = touch->x_lo | touch->x_hi << 8;
-	y = touch->y_lo | touch->y_hi << 8;
+	id--;
+	x = touch->x_lo | FIELD_GET(MMS114_XY_HI_X_MASK, touch->xy_hi) << 8;
+	y = touch->y_lo | FIELD_GET(MMS114_XY_HI_Y_MASK, touch->xy_hi) << 8;
 
 	dev_dbg(&client->dev,
 		"id: %d, type: %d, pressed: %d, x: %d, y: %d, width: %d, strength: %d\n",
-		id, touch->type, touch->pressed,
+		id, type, pressed,
 		x, y, touch->width, touch->strength);
 
 	input_mt_slot(input_dev, id);
-	input_mt_report_slot_state(input_dev, MT_TOOL_FINGER, touch->pressed);
+	input_mt_report_slot_state(input_dev, MT_TOOL_FINGER, pressed);
 
-	if (touch->pressed) {
+	if (pressed) {
 		touchscreen_report_pos(input_dev, &data->props, x, y, true);
 		input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR, touch->width);
 		input_report_abs(input_dev, ABS_MT_PRESSURE, touch->strength);
@@ -278,21 +289,23 @@ static void mms114_process_touchkey(struct mms114_data *data,
 	struct i2c_client *client = data->client;
 	struct input_dev *input_dev = data->input_dev;
 	unsigned int keycode_id;
+	unsigned int id = FIELD_GET(MMS114_FLAGS_ID_MASK, touch->flags);
+	bool pressed = FIELD_GET(MMS114_FLAGS_PRESSED_MASK, touch->flags);
 
-	if (touch->id == 0)
+	if (id == 0)
 		return;
 
-	if (touch->id > data->num_keycodes) {
+	if (id > data->num_keycodes) {
 		dev_err(&client->dev, "Wrong touch id for touchkey (%d)\n",
-			touch->id);
+			id);
 		return;
 	}
 
-	keycode_id = touch->id - 1;
+	keycode_id = id - 1;
 	dev_dbg(&client->dev, "keycode id: %d, pressed: %d\n", keycode_id,
-		touch->pressed);
+		pressed);
 
-	input_report_key(input_dev, data->keycodes[keycode_id], touch->pressed);
+	input_report_key(input_dev, data->keycodes[keycode_id], pressed);
 }
 
 static irqreturn_t mms114_interrupt(int irq, void *dev_id)
@@ -325,8 +338,9 @@ static irqreturn_t mms114_interrupt(int irq, void *dev_id)
 
 	for (index = 0; index < touch_size; index++) {
 		t = (struct mms114_touch *)((u8 *)touch + index * event_size);
+		unsigned int type = FIELD_GET(MMS114_FLAGS_TYPE_MASK, t->flags);
 
-		switch (t->type) {
+		switch (type) {
 		case MMS114_TYPE_TOUCHSCREEN:
 			mms114_process_mt(data, t);
 			break;
@@ -337,7 +351,7 @@ static irqreturn_t mms114_interrupt(int irq, void *dev_id)
 
 		default:
 			dev_err(&client->dev, "Wrong touch type (%d)\n",
-				t->type);
+				type);
 			break;
 		}
 	}
-- 
2.55.0.rc0.799.gd6f94ed593-goog

