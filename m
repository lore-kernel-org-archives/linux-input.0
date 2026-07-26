Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD542F3621
	for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 11:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785064546; cv=none; b=p7fVbgmd7msgO0ZSGzt/zYAqmqrgC/75iY8ufycUEfJe+X8kry7qr8KhA1hCM3GY5T+lUGqpaRDQEFeUVYtsjbZYvEXkl0XJHU0DgtuL9RAur6wZ+X0ynNk//+KmUd5d6RGfBLLB27kc5FaRX7jo4mhvDAaa1vHUsYNMYmc5H2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785064546; c=relaxed/simple;
	bh=XhVXEKtqspLI441uWo3QuIRBqXLhGYrFvjuFf4r/qj0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dlk1b4Lfu1EbIzIykJeyqwh68JD/ZLMxSWtl/xS346HSemjq5C107zay9o84rmc/TqKMjoqjZJ7R1+xUwpXLEubvQUxwTh9UdvobFsfcSl6m75yO6V9TayeRl3no07LRcWAGp+8e/VOhkaNcSfjql4kdGB2vQu9y5kox7JHZtOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pu61xWw/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pu61xWw/"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cf52d15d88so16963635ad.2
        for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 04:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785064544; x=1785669344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=k9b9/6dXenhTUKOJCIHLIq7fadOmj44kmHH5pPyMEgE=;
        b=Pu61xWw/gcTWeL4Waw5O6OCK2yzwBBWqHBdNfUsKebEW+AlTwf4VXbttAzCwZLPt2m
         DxCnjeeODXwdl0Cm1VOBCsGxOOpcFkchMdYV7H9H0fk5z5hkCY4o6PIGeBYIOD3eAYAz
         kj+Sqi0lPjEK9c/c4p6m2Thf9W++3pdp+Sm1pzsRuFG4IO1iQF0tbYqKtMPDN4jZiRwR
         H+avA/MrHnUqjdNs8l4NPQwlTmH3i1eI+TUGntZeTjJVY1O8fd2bh8KTfh2hX4NLSl5/
         CGdjImmgFaeUBvsDEGUskr821KLaOqBC7W9H1MFA85YxS8G7QULmoIdwHYqI9EdHvOnG
         D23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785064544; x=1785669344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k9b9/6dXenhTUKOJCIHLIq7fadOmj44kmHH5pPyMEgE=;
        b=oES7QWRobgW7AePaF089G6T64sbuVfxhpVkdkM8408SApE3JcfNu9ct9ARkC0+fBbq
         313QvoZxxu21GYPYxJKBBFyc6VOwwn/YGQXBze7ste2WM0WPIFmJSERcWR5AKkqlcuSN
         240cXwaLb2K+qg1MEytmKF36ondz2PjFLgX7oeJpNhW3cNccwoDanQ1gq6n6ta8s4KYb
         asJSqC69/yq+d+9YIPth6Xqo2ql+qftFmPxql6/BSSMVbFZPIveN3bDZmanJXd59mUGV
         EFjtADCqarLYpAcVOIvOCJe6Nk3bo79fBHBFScmiOEmmZGWIy+fbQYgDSDvO9H5yS5io
         0uNw==
X-Gm-Message-State: AOJu0YxXhBcPVAQytbM/z9sk57O8RNwcX/+4Jbl4Q6s0PPgBSITTVTb/
	rxrhgserzNOiMApWQDvgyJokBVgeHvg5OOFzdlIS0wrFmjH1NJCQVjS1
X-Gm-Gg: AR+sD13toFwIGVop+N+U4GU6M3Et4+8VxCztel0axg076Po7JRQLXIV+MliiDH/sfcr
	ZJfeoJFSTQ3On1o++8bLmzyAPZ1LZn0woIoTulVwyAio9shi079VQoTbO3yBphcHwF5mweA5mcf
	eDHq+E5HL9PpmONXKTMa7mctFdg6KONkigd30xW1VkEM+ePKAmaOHgtrL3ErDeH5hyO02uL0lTJ
	e/q6qay6on3P6Zw/R2klsPiZU+xeX7rPCGtewZfw6GXmRTsjnE/rYVpfFDf+0WBM3UNObYeaHNV
	fWS2St9xafJ0FYozOaEWCwA2skrcMuKe23L67leg1ZJY8TuioRdlGMq6nq2xbKzptmNsLoOBNjJ
	o9czHjZGR9yuqyZmVn7KyaW3dyxaA9sDK5oMxHvpT8XIQBf2Ho+IpOTon7sY+S+lC3NcTq262Uo
	/vRfnXkAhGbqtq/+wgAtvwYlq/xg99kdsrXQH2Joi5ptn/DooM
X-Received: by 2002:a17:902:ef4f:b0:2cf:83bf:6b05 with SMTP id d9443c01a7336-2cfde86bac2mr42423935ad.41.1785064544371;
        Sun, 26 Jul 2026 04:15:44 -0700 (PDT)
Received: from lza-virtual-machine.localdomain ([120.236.174.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7bc585sm19192805ad.51.2026.07.26.04.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 04:15:44 -0700 (PDT)
From: Zhian Liang <liangzhan5dev@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhian Liang <liangzhan5dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] Input: tca8418_keypad - fix potential infinite loop and OOB access on invalid keycodes
Date: Sun, 26 Jul 2026 19:15:02 +0800
Message-Id: <20260726111502.2252-1-liangzhan5dev@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the hardware returns 0xFF (e.g., due to a stuck bus or device fault), the loop never terminates and
the extracted keycode causes an out-of-bounds access on keymap[].

Move the empty-FIFO check to operate on the extracted key code so that
the loop terminates correctly. Additionally, validate row/column indices
against the configured matrix dimensions before indexing into the
keymap array, skipping invalid events.

Cc: stable@vger.kernel.org
Signed-off-by: Zhian Liang <liangzhan5dev@gmail.com>
---
changes in v2:
- Moved empty-FIFO check to operate on extracted key code instead of
  raw register value.
- Added row/col validation against configured matrix dimensions.
- Dropped explicit 0xFF check as requested.
---
changes in v3:
-Fix mailer line-wrapping
-No code changes
Signed-off-by: Zhian Liang <liangzhan5dev@gmail.com>
---
 drivers/input/keyboard/tca8418_keypad.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
index b124e576feca..36d4a7c38bb1 100644
--- a/drivers/input/keyboard/tca8418_keypad.c
+++ b/drivers/input/keyboard/tca8418_keypad.c
@@ -114,6 +114,8 @@ struct tca8418_keypad {
 	struct input_dev *input;
 
 	unsigned int row_shift;
+	unsigned int rows;
+	unsigned int cols;
 };
 
 /*
@@ -171,19 +173,28 @@ static void tca8418_read_keypad(struct tca8418_keypad *keypad_data)
 			break;
 		}
 
-		/* Assume that key code 0 signifies empty FIFO */
-		if (reg <= 0)
-			break;
 
 		state = reg & KEY_EVENT_VALUE;
 		code  = reg & KEY_EVENT_CODE;
 
+		/* Key code 0 signifies empty FIFO */
+		if (!code)
+			break;
+
 		row = code / TCA8418_MAX_COLS;
 		col = code % TCA8418_MAX_COLS;
 
 		row = (col) ? row : row - 1;
 		col = (col) ? col - 1 : TCA8418_MAX_COLS - 1;
 
+		/* Validate against configured matrix size */
+		if (row >= keypad_data->rows || col >= keypad_data->cols) {
+			dev_err(&keypad_data->client->dev,
+				"invalid key code %d (row %d, col %d)\n",
+				code, row, col);
+			continue;
+		}
+
 		code = MATRIX_SCAN_CODE(row, col, keypad_data->row_shift);
 		input_event(input, EV_MSC, MSC_SCAN, code);
 		input_report_key(input, keymap[code], state);
@@ -298,6 +309,8 @@ static int tca8418_keypad_probe(struct i2c_client *client)
 
 	keypad_data->client = client;
 	keypad_data->row_shift = row_shift;
+	keypad_data->rows = rows;
+	keypad_data->cols = cols;
 
 	/* Read key lock register, if this fails assume device not present */
 	error = tca8418_read_byte(keypad_data, REG_KEY_LCK_EC, &reg);
-- 
2.34.1

