Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EB6156F45
	for <linux-input@vger.kernel.org>; Sun, 22 Feb 2026 00:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771720652; cv=none; b=ZEqC+03z5fM2X08daFyYWmwhTrj51suv0XQxoPgt3rx93veCdrpz+7V4NC5/PWZ8sDvwi5rxAdmaYaBrw0dRhqtiwLdLEVtzXXfYLALOHPbJjPAT2ylaN8bATTQ0ZUdlL2kGD5EbXTLej+SkUKvcW/Svmdbt1sMDZwMDnvwWXaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771720652; c=relaxed/simple;
	bh=/oWe9TBcbfGVgvA3YAwcI++qilYUs5G6I0MwqlEyTXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RU6sJoPFLWUCo5iCJwGRdV9D6anws3tNPcGlxfNyTr2JXaY7noaJjDIWUO5ch24xYzf9RP0cSQMntr7/ZtAYVGgIwusRQIyr1pBQvNGvw5+Yaj0uocUS0a2LzqMvjrLUzHC8/enirhkdkhWHgvSgLgqxFwLmDGFByYceqbpXKe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSlxUR6t; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSlxUR6t"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-124a635476fso3082070c88.0
        for <linux-input@vger.kernel.org>; Sat, 21 Feb 2026 16:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771720650; x=1772325450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCOB+xu4HpFhupd2ul95dO/R/350Wo1NOuKyLRfUoGY=;
        b=RSlxUR6t63YWJUImIV2pOsjQcfgwU5MROiABCoo+qd7JMdhBPfn3ZtbjJtP8CY5NPt
         VJNtibz9iy16s64kw1bR6FV82zsU5/whVKSsU5k/yV/0yxrFYs1ajS/nsuVTiuf54vSm
         h3hIQa3HnatX2ARrDbpJ8XGnAkk3q5CtD7DAUbi3QgpOiKPx5Ffa9voYCNCMPKTz0kMn
         Nve1xm2oQAu6PxXuddgOnjV2iVbwgZYxe0+tHN5CzNhvHQtpkrj5nvSXkekG6BIzQs7Q
         QWC6TTkYOlIj8A53X01F42EYpVnWcz6Y1qMNg8QSYsTtnKdlmqXJi6ZYUXEJaNN0SrOk
         9bBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771720650; x=1772325450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NCOB+xu4HpFhupd2ul95dO/R/350Wo1NOuKyLRfUoGY=;
        b=jJUmbU5iLEx7tLDYwsC7lI9SFR7OQXZha09JK79QDevf8jDKSTwsNVuaUr4owNUuVF
         y544kG6/6gxHpnZhdXIGlmgRYr0lUHiSsfyFO0UJ7/dJKit8GciKwcOTDw2c6JF3KOwh
         JxTCrf+ChMgd6sDyNaRi0r63Fy2Ozqfpm1lqZ0f2BCh6rg5E/QuOjNSDzoaS0BwJQc6N
         2Qy3KHYLZnEyyE+zxd82D/gnQUpyLuUmLySSDFINAR62uzHYBzOQ6rj2y1+v6L+C/CaU
         p8jWYIkrla0G4hU4MJRCTEY6hH5CieahMbXL7k1QTs4QK8lIhBGVrAiGZmlREt7pvkI7
         kYFw==
X-Forwarded-Encrypted: i=1; AJvYcCVu6Xb71LTBseVHRQRgSojcRMXD8c1g0/yPXjE7jlxutG4Pm2XjzTBhmpcLEmL07fx6qUUmKpBp6z1OCA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0o4fV44HJlvrwwJy8Y0cz7scKlKLpyralMiEUfJ2v2QE/y8t4
	nmz0CBrpZu5qaEktDhsMjNcyD588FkXav2pDDE73UE/RsMxDb8QNqsKD
X-Gm-Gg: AZuq6aK1QwOKa0ECivq+kKZBXPEzpxqBKhrKd/atycIvzOhZVMN3iNzeQyOwNWDj7FA
	EDAwn6fjYkdKYxzjJqLZlOUHF6cMA2y1x01L4iuydwL3YOa/KdCIydZFUGCUvxNgoXROlDQj1Hd
	SunA8Fnk3svHQE3zkQLc9y/Xa/6efNqu4HejGQKSUkYa3iLHWLb3e//y2szuYOIs2cyzq70EGNC
	URJ2TRU1Sc73FJpu8Zc5cA4tC3UsDFAZatjs0dCXdfj/syZfxhtOx5qq4anHC3xFPcVsBG4ErJp
	6mmgr6+YCVMV+X6m6mwWM8/18viE0cWTyzI2exEdnocuXWS2Wevqty733MPcqHDRBzgQMyspgj6
	iIkJueb0r2wEdhkACEWrlhqD3p6gzV16mx8+W0VAMkzpqLp0uCJcWck8N0qwjUEjRn/zZWf0jH9
	u/6Qjnjw5vAiz+kp49lZPsp7VDHttYhu46JdunfJTLB17eHFsYH74ro98C2wRAPEs0MElbBDFKf
	DdHo9LVrAh5NeuP0yiddbtv
X-Received: by 2002:a05:7022:2482:b0:127:35af:143c with SMTP id a92af1059eb24-1276ad39a83mr1667574c88.37.1771720650227;
        Sat, 21 Feb 2026 16:37:30 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:73d:b075:516c:4a69])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dc167d3sm2383191eec.24.2026.02.21.16.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 16:37:29 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Fabio Baltieri <fabiobaltieri@chromium.org>,
	Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>,
	Simon Glass <sjg@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	linux-input@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] Input: cros_ec_keyb - factor out column processing
Date: Sat, 21 Feb 2026 16:37:15 -0800
Message-ID: <20260222003717.471977-7-dmitry.torokhov@gmail.com>
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

Factor out column processing and eagerly skip processing columns that do
not have any changes in them.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/cros_ec_keyb.c | 47 +++++++++++++++------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index 02176aee0530..8cf9129f6198 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -254,6 +254,26 @@ static void cros_ec_keyb_process_key_fn_map(struct cros_ec_keyb *ckdev,
 	input_report_key(idev, code, state);
 }
 
+static void cros_ec_keyy_process_col(struct cros_ec_keyb *ckdev, int col,
+				     u8 col_state, u8 changed)
+{
+	for (int row = 0; row < ckdev->rows; row++) {
+		if (changed & BIT(row)) {
+			u8 key_state = col_state & BIT(row);
+
+			dev_dbg(ckdev->dev, "changed: [r%d c%d]: byte %02x\n",
+				row, col, key_state);
+
+			if (ckdev->has_fn_map)
+				cros_ec_keyb_process_key_fn_map(ckdev, row, col,
+								key_state);
+			else
+				cros_ec_keyb_process_key_plain(ckdev, row, col,
+							       key_state);
+		}
+	}
+}
+
 /*
  * Compares the new keyboard state to the old one and produces key
  * press/release events accordingly.  The keyboard state is one byte
@@ -261,10 +281,6 @@ static void cros_ec_keyb_process_key_fn_map(struct cros_ec_keyb *ckdev,
  */
 static void cros_ec_keyb_process(struct cros_ec_keyb *ckdev, u8 *kb_state, int len)
 {
-	int col, row;
-	int new_state;
-	int old_state;
-
 	if (ckdev->ghost_filter && cros_ec_keyb_has_ghosting(ckdev, kb_state)) {
 		/*
 		 * Simple-minded solution: ignore this state. The obvious
@@ -275,24 +291,15 @@ static void cros_ec_keyb_process(struct cros_ec_keyb *ckdev, u8 *kb_state, int l
 		return;
 	}
 
-	for (col = 0; col < ckdev->cols; col++) {
-		for (row = 0; row < ckdev->rows; row++) {
-			new_state = kb_state[col] & BIT(row);
-			old_state = ckdev->old_kb_state[col] & BIT(row);
-
-			if (new_state == old_state)
-				continue;
-
-			dev_dbg(ckdev->dev, "changed: [r%d c%d]: byte %02x\n",
-				row, col, new_state);
+	for (int col = 0; col < ckdev->cols; col++) {
+		u8 changed = kb_state[col] ^ ckdev->old_kb_state[col];
 
-			if (ckdev->has_fn_map)
-				cros_ec_keyb_process_key_fn_map(ckdev, row, col, new_state);
-			else
-				cros_ec_keyb_process_key_plain(ckdev, row, col, new_state);
-		}
-		ckdev->old_kb_state[col] = kb_state[col];
+		if (changed)
+			cros_ec_keyy_process_col(ckdev, col, kb_state[col],
+						 changed);
 	}
+
+	memcpy(ckdev->old_kb_state, kb_state, sizeof(ckdev->old_kb_state));
 	input_sync(ckdev->idev);
 }
 
-- 
2.53.0.345.g96ddfc5eaa-goog

