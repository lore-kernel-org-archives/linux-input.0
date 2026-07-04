Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EF23955E3
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 05:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144694; cv=none; b=Xm7bT1yVk/3jua3MddHgHtLWS2rX8wrdUoBGaIqN3iAQ4gyTOcUZRxDnk60LeHLuMeZ3KIZiOBlxLHmtPsARGFGT8O6MWgI6r7LdQjj+naJlznefvaCGk/8zjDpjekU3s4GvS0Jjq7Mol1Z/loZIcav1fgNm5J1LyhhpMSiaS/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144694; c=relaxed/simple;
	bh=bJdwpjh8bt5egacgW4GkSSVLDN/CuQe6AaNTKlGoUdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LfOxGWoI6DUSCHJSumpv0TG5WEw6c4jNnhGmqN//zkLSa3rLV718MqyYhvFUKcb/zKUxnrpZBfCUN6zsczZIOc2KMtsYSrA3agfW+ervvufg0v/m9IpnEN6KvmDt7U2sqsRe50uyBZJc1O2piMnaF+19ymBZwpVXpj5Cqn5ILEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfOpz4cy; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfOpz4cy"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c85b73ffb52so614813a12.3
        for <linux-input@vger.kernel.org>; Fri, 03 Jul 2026 22:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144691; x=1783749491; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cWjg7UC3W2OY/ypUpA0NQNYwI2Wk9GMT1X28efRSy2Q=;
        b=QfOpz4cyGxJpis6I4NEzMWQRgKptixEMXgb4+beT7NmMIOhlcYkTr0F7sNdo3Fvmlb
         fzdPpd2KAGGNmHD7qzTQhjJxqvZvrc5RaVCZq7ScQVvSBZ419/UqthVizQRtYNfwFqzn
         3w9nNWEfW/ueU497XsRgSTD3MmGGaCYUl6nK5AczgAjzOj3Dc5y46XpO9W1Kv9//g8s4
         nYTfRJiW8FppIlvlSgnwe55yhCfYD7ZpszJmgpys7f+pf05kKvgQhTgdGgspz5ah5Pl0
         1WNsdIJHWlSFBq47gwhZvdBCP4K5LEkeWD7uTtiLNWjHNYglU0h5L28a7VedgXAY60y4
         18rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144691; x=1783749491;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cWjg7UC3W2OY/ypUpA0NQNYwI2Wk9GMT1X28efRSy2Q=;
        b=BwtEKIl7eEIqZbBZl79ilqhDTlYz1e1iWfZj/KRGr5CQSQ9e2+Opxa1EmH00aoZbQX
         cEKF+4jhvlXNR/SOmi0TR5gIy7bc4Cq1hcEjVcbI0LqSa5j7xkxzhrwTG5J+xBduo0EF
         7nj1vIeJ1gLOGhSJawRCjnlLmRgOoYHE2rKyQ9QPnFV536TTtroBIItcef46pOIVZuBF
         rntP/EngvhfxAmiydBQnVqSPBA9rc+w3e7y/9T7NkDjG1tABgpbB5kD69+6MCP8Pw2K8
         Uq2Bv+w79GO30qzCWAGNx/nQbwzGmwBx/F/n6iEEKrJmqfe847lE1Q4+dBvOALOyWTNi
         fYGA==
X-Forwarded-Encrypted: i=1; AFNElJ8gMZ0gD2b31ddU5uis1RYoCFn2pc40HQMDnzbIdrUR/1TdSWiUigVTnpor+Q8vdI7S2gNdIbFZ4cLDmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YybwYIkpqmRKNj4LSXQ13kHpTi3vVtRKq0MBaJVEpozuK/IlTWe
	H2hb+eXDrD9DxtCBzEQoMB7lUHZW5Oon2CctzRHgBLH8T/tH2zQtj+ws
X-Gm-Gg: AfdE7ckAKAMCBS81yfrnsHcs6oPKzEmqMKZQqFmLH9O3WnE8qAlgl8Pgz3ydb8BejUD
	oBm21PPxJm0aw1vJ8/Ng4wA3cc2zKkrbCwZdBaDprwzoTxy102JQNDEOjf8bHZVldhmZQDFzB9W
	LTUAoN0CyvxxuMcX7hSI9fi99GpbadbWEydTL12dsC946jgtOFfo8qQdsU8X5b8bJIUlQHS0pv9
	u85IWCZlas1p+Pu6yWCQa5DzyarBQJJ+dM+QOyw4ZUgtr846jl8mnEGr1E2CcTD58JbdEjFFokP
	rGrJEo9Geyy/lUX+OY0MQgcIDJjBm2fXcaS7rZewa1BoXTNtsFjLxqSPdtKxbqZ2UCbrkjG6myi
	YlO6oXZjtfETT3PyBUYzLqlZb1sjfnMx0auNcYh4w2OMD9Yyz0L2QhzkVKDlxANOvYyOGoIW/jJ
	sP0r1JYjHrwqvSfPteLe7fd/Ho318k6v6pF72fW5U57lwPKyarI8YRA66xhCejA/mRP1t14kYuX
	kA=
X-Received: by 2002:a05:6a20:3c90:b0:3bf:6c04:a817 with SMTP id adf61e73a8af0-3c03e4dee8fmr2742445637.56.1783144691289;
        Fri, 03 Jul 2026 22:58:11 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:58:10 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:46 -0700
Subject: [PATCH 23/26] Input: maple_keyb - fix style issues
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-23-41e424964da5@gmail.com>
References: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
In-Reply-To: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Florian Fuchs <fuchsfl@gmail.com>, 
 Adrian McMenamin <adrianmcmenamin@gmail.com>, linux-kernel@vger.kernel.org, 
 Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org, 
 linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org
X-Mailer: b4 0.16-dev-6911d

Fix coding style and formatting issues reported by checkpatch.pl.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/maple_keyb.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/input/keyboard/maple_keyb.c b/drivers/input/keyboard/maple_keyb.c
index bd4ce803a13e..1d99ed5bad1e 100644
--- a/drivers/input/keyboard/maple_keyb.c
+++ b/drivers/input/keyboard/maple_keyb.c
@@ -48,7 +48,7 @@ static const unsigned short dc_kbd_keycode[NR_SCANCODES] = {
 	KEY_F23, KEY_F24, KEY_OPEN, KEY_HELP, KEY_PROPS, KEY_FRONT, KEY_STOP,
 	KEY_AGAIN, KEY_UNDO, KEY_CUT, KEY_COPY, KEY_PASTE, KEY_FIND, KEY_MUTE,
 	KEY_VOLUMEUP, KEY_VOLUMEDOWN, KEY_RESERVED, KEY_RESERVED, KEY_RESERVED,
-	KEY_KPCOMMA, KEY_RESERVED, KEY_RO, KEY_KATAKANAHIRAGANA , KEY_YEN,
+	KEY_KPCOMMA, KEY_RESERVED, KEY_RO, KEY_KATAKANAHIRAGANA, KEY_YEN,
 	KEY_HENKAN, KEY_MUHENKAN, KEY_KPJPCOMMA, KEY_RESERVED, KEY_RESERVED,
 	KEY_RESERVED, KEY_HANGEUL, KEY_HANJA, KEY_KATAKANA, KEY_HIRAGANA,
 	KEY_ZENKAKUHANKAKU, KEY_RESERVED, KEY_RESERVED, KEY_RESERVED,
@@ -92,15 +92,16 @@ static void dc_scan_kbd(struct dc_kbd *kbd)
 	for (i = 2; i < 8; i++) {
 		ptr = memchr(kbd->new + 2, kbd->old[i], 6);
 		code = kbd->old[i];
-		if (code > 3 && ptr == NULL) {
+		if (code > 3 && !ptr) {
 			keycode = kbd->keycode[code];
 			if (keycode) {
 				input_event(dev, EV_MSC, MSC_SCAN, code);
 				input_report_key(dev, keycode, 0);
-			} else
+			} else {
 				dev_dbg(&dev->dev,
 					"Unknown key (scancode %#x) released.",
 					code);
+			}
 		}
 		ptr = memchr(kbd->old + 2, kbd->new[i], 6);
 		code = kbd->new[i];
@@ -109,10 +110,11 @@ static void dc_scan_kbd(struct dc_kbd *kbd)
 			if (keycode) {
 				input_event(dev, EV_MSC, MSC_SCAN, code);
 				input_report_key(dev, keycode, 1);
-			} else
+			} else {
 				dev_dbg(&dev->dev,
 					"Unknown key (scancode %#x) pressed.",
 					code);
+			}
 		}
 	}
 	input_sync(dev);
@@ -191,9 +193,6 @@ static int probe_maple_kbd(struct maple_device *mdev)
 	return 0;
 }
 
-
-
-
 static struct maple_driver dc_kbd_driver = {
 	.function = MAPLE_FUNC_KEYBOARD,
 	.probe =	probe_maple_kbd,

-- 
2.55.0.rc0.799.gd6f94ed593-goog

