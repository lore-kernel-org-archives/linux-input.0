Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F67B13D8B1
	for <linux-input@vger.kernel.org>; Sun, 22 Feb 2026 00:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771720650; cv=none; b=QXNrSkCbJa2CG7NCew1mNwKzEip1/gx2/zTHWFEincAgr7Fo5yKSgwyue8BwLZo5tYMxthk/ui0EZKi+0WYV+3rrlgSF9l7ZJVpiramOeLN2cLt46+L4CLpLqw2dHGcx901wBiN8XEY3ZRR/x+MiWqvBYGj8/Q+lu+uKQVR2fAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771720650; c=relaxed/simple;
	bh=crb4b82rLxqKn4BkBwvmo2g9i5aBgpOAcm55i7WUJpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUA+o3x7lHpLNCkzxdakZc5OeM/J0WTofPd7QwUHJsPoMbWy7OfKzJp2aXwjM0Cvr1jfu5n/DRoE0UMEIoNhrWMQQBN8g13rIsZfWE7BtK8aJUIODd2Bm9rSlarboW8oPm6Y2q9JKkYlZbP5j1yTQjYChdvuabklv7GRGc8Tx5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fx33APAc; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fx33APAc"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2ba9d13f10eso5174761eec.0
        for <linux-input@vger.kernel.org>; Sat, 21 Feb 2026 16:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771720648; x=1772325448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9P6JIy/yCYueLx7kLL46JzwVZIY5NSAX+sYIu+42/o=;
        b=fx33APAcEYDNsJ2h1ZsDUnUsuQUHSNQ92sd0U7jSnox6+N/+QI4TkObHG7z1ySAmon
         Br3wDXWzk8yEoaIAYjWkDQlLowwoudi8OmNyptYkqFvFZwydUInl73Durnff01m24yKx
         5nFkIQRFs+XJBW7VYAjMCeiChegTNU022BzFJvog83Od+anJf5xiJVIxty09/NV7yoeP
         He1ypH7nkhyOEEBN8yz67+DI5IZGswUgLVR5bLZdCIUkhqNN+om9L1rBkkNzwPKxucgO
         kZtIWS9gVkLuGbz9S9PQPnLcrg0VJUIph5u8sJlcfe/r1xCSMQFPFtoI9FhAVvESQ/AI
         WDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771720648; x=1772325448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d9P6JIy/yCYueLx7kLL46JzwVZIY5NSAX+sYIu+42/o=;
        b=FK1dHs0Fa3S0uzBEhlJXCFK6EgLoNexk70OAN3adqx1dESEUr5t2Ci+9S4R+wS2mwc
         54r4rijAxUPpKWKiufvwWEJwcNYvPJWINtxLA2SaKKeyqgERpsaSC9Kp8xcLD6/P6spw
         5F/FnslEzKnKW+otKjLaTx58dCvugIut3oqkMZ6Fig3hFNZocdfsvguSMuqvYEZ3sAHW
         7pzPnzqkKylv1s8t6Bxy/QaQ4M2JX7ra2kArjxKF8BEvFoBm03cvMZSE47pEKR2YWF16
         J3YZMtSTdcSqEdOM/qdMD4igjfm0CdhaQdviTO3r1/i4ui+jxvXWuEIuONH74+XZK8PW
         SxNA==
X-Forwarded-Encrypted: i=1; AJvYcCU2L5ZCV+gh/U4ZdVbQH9l9rZIyQP5dRm8pQjxpNGXZEJ3GoS/2ticZsTUQfSBGSLYRuBONE4LwbRtJUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoHrkXv/Uh/xh1okcnSznct14WOmXtwHUpq1SOTAP73UqK3XM1
	OjWXeWn4GuS2wnOHny91IVROvqr8IrNyatvXRq9M3AVAjWfu8I57JrRN
X-Gm-Gg: AZuq6aK6hh50rPjuodezK0RPI9QGY0/74Ge6/7jA/6NKC2liu7m8Blma1FpE9hDRKi0
	Cn98uh1sl9Hf0sqXDqpZZhHh/jw/Um17GmHw53cwXhID8drPh80Pl1O5HS+qCCJxtsLv5o8ROx4
	+MEJR0MnmYceHLjApoWJR6ymeONJno03xMuIqMabwHTj9tQIBErO/wjBENuaCyWxcfQJkxekLWM
	vgF94Ti9mqbGtJIELCv9RTHcZZAlTDOGlp37YEAElBy3oLd5Qd5gTvgWJVUcjyJz0NM3O6duSvu
	ID4adWhMemp4vYmVeb9tdd+eX/D3RW205e69bNT9jgMx+sPSCmtk/ATCk2cQrqi5pqBoBjSyTUA
	+G80bNgj0ey0tOvUK4z0rp10HintTmUFv47inORbGstrhn25MEsQ7nYjDwBlXiPjrH9Eff4hhl0
	Dq3PMxjhTV/RrgrtDkmox2LFdb6u5griG44qDAk/F5MFBTITnXD4ks8Mp7J+RuZmTcm5wExPFOk
	/v2oyu/mGjoew==
X-Received: by 2002:a05:7300:a949:b0:2ba:73db:3e81 with SMTP id 5a478bee46e88-2bd7bd6a424mr1781407eec.33.1771720648229;
        Sat, 21 Feb 2026 16:37:28 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:73d:b075:516c:4a69])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dc167d3sm2383191eec.24.2026.02.21.16.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 16:37:27 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Fabio Baltieri <fabiobaltieri@chromium.org>,
	Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>,
	Simon Glass <sjg@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	linux-input@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] Input: cros_ec_keyb - simplify cros_ec_keyb_work()
Date: Sat, 21 Feb 2026 16:37:13 -0800
Message-ID: <20260222003717.471977-5-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
In-Reply-To: <20260222003717.471977-1-dmitry.torokhov@gmail.com>
References: <20260222003717.471977-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce temporaries for event_data pointer and event_size to simplify
the code a bit.

In cros_ec_keyb_compute_valid_keys() explicitly compare with
KEY_RESERVED to make the intent of the comparison more clear.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/cros_ec_keyb.c | 28 +++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index fabbdbc22785..1b4ee30e1998 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -330,8 +330,10 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
 {
 	struct cros_ec_keyb *ckdev = container_of(nb, struct cros_ec_keyb,
 						  notifier);
-	u32 val;
+	struct ec_response_get_next_event_v3 *event_data;
+	unsigned int event_size;
 	unsigned int ev_type;
+	u32 val;
 
 	/*
 	 * If not wake enabled, discard key state changes during
@@ -341,32 +343,32 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
 	if (queued_during_suspend && !device_may_wakeup(ckdev->dev))
 		return NOTIFY_OK;
 
-	switch (ckdev->ec->event_data.event_type) {
+	event_data = &ckdev->ec->event_data;
+	event_size = ckdev->ec->event_size;
+
+	switch (event_data->event_type) {
 	case EC_MKBP_EVENT_KEY_MATRIX:
 		pm_wakeup_event(ckdev->dev, 0);
 
 		if (!ckdev->idev) {
-			dev_warn_once(ckdev->dev,
-				      "Unexpected key matrix event\n");
+			dev_warn_once(ckdev->dev, "Unexpected key matrix event\n");
 			return NOTIFY_OK;
 		}
 
-		if (ckdev->ec->event_size != ckdev->cols) {
+		if (event_size != ckdev->cols) {
 			dev_err(ckdev->dev,
 				"Discarded key matrix event, unexpected length: %d != %d\n",
 				ckdev->ec->event_size, ckdev->cols);
 			return NOTIFY_OK;
 		}
 
-		cros_ec_keyb_process(ckdev,
-				     ckdev->ec->event_data.data.key_matrix,
-				     ckdev->ec->event_size);
+		cros_ec_keyb_process(ckdev, event_data->data.key_matrix, event_size);
 		break;
 
 	case EC_MKBP_EVENT_SYSRQ:
 		pm_wakeup_event(ckdev->dev, 0);
 
-		val = get_unaligned_le32(&ckdev->ec->event_data.data.sysrq);
+		val = get_unaligned_le32(&event_data->data.sysrq);
 		dev_dbg(ckdev->dev, "sysrq code from EC: %#x\n", val);
 		handle_sysrq(val);
 		break;
@@ -376,12 +378,10 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
 		pm_wakeup_event(ckdev->dev, 0);
 
 		if (ckdev->ec->event_data.event_type == EC_MKBP_EVENT_BUTTON) {
-			val = get_unaligned_le32(
-					&ckdev->ec->event_data.data.buttons);
+			val = get_unaligned_le32(&event_data->data.buttons);
 			ev_type = EV_KEY;
 		} else {
-			val = get_unaligned_le32(
-					&ckdev->ec->event_data.data.switches);
+			val = get_unaligned_le32(&event_data->data.switches);
 			ev_type = EV_SW;
 		}
 		cros_ec_keyb_report_bs(ckdev, ev_type, val);
@@ -410,7 +410,7 @@ static void cros_ec_keyb_compute_valid_keys(struct cros_ec_keyb *ckdev)
 	for (col = 0; col < ckdev->cols; col++) {
 		for (row = 0; row < ckdev->rows; row++) {
 			code = keymap[MATRIX_SCAN_CODE(row, col, row_shift)];
-			if (code && (code != KEY_BATTERY))
+			if (code != KEY_RESERVED && code != KEY_BATTERY)
 				ckdev->valid_keys[col] |= BIT(row);
 		}
 		dev_dbg(ckdev->dev, "valid_keys[%02d] = 0x%02x\n",
-- 
2.53.0.345.g96ddfc5eaa-goog

