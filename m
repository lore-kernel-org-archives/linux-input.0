Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BCA3955E4
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 05:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144698; cv=none; b=GvIGKamy95HxjduUZ7pQHphwz+FvFVg+UOEsOey9iuzV653junUw/bT9dSrehvMJsqdRgUgkSR5YUyhM1H1fuQQCA8PKpqqomPh5dI51wdXb/UnfzXfdu2Wz/dWzoEjQr+h+3eIpY6jEpPB1Dw6zCv/Eenhz8gZd29KUJ2UR0Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144698; c=relaxed/simple;
	bh=AxruopFb6RxNA8Yw2YyzbRC+TmLqrBdAl3Kg3xWhS44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z94kl+QYD1tRNSS6En8njkREB7R0zf4Jxga62MMUxODL1/eiMKj/oymCxa52P+HbKl69n4CogW9BONJ/ycpUOfhVkMjjJWIi+kLxrh2Qa2fd8PHAQe0HbO2UkurLwx0zn/WCWOZ86hSGdjJToJaSIcFT/SOL8LwErRuoA2tiQWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlQr5+Rs; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlQr5+Rs"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-380cda7f00cso1032570a91.0
        for <linux-input@vger.kernel.org>; Fri, 03 Jul 2026 22:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144696; x=1783749496; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tEG7tX5+i0yM5fGvf5APIP8u2V/3BZ/C2R2J5nBR/YM=;
        b=TlQr5+RssuuxnFg12iAtYTl1uvy1KaLgaNl8J34Lst3zifyTgI/1W+yvAAb73hEitM
         YXFMyjw7Hdsq6ONpuBc2hzth0M0RLWHmbD9hzHwVkcwBF3uIhyUTXPeFT3w1UB1DJ0Cg
         gX4DB2oMJUJ0k9wspJ90OClPg+T2PuTzKi9EUHBO5BN6vLz7MVthEL9GEMF7sJpvvO1r
         +leUG00eaVo5FDT/bFMO4x7Kf8Rb152vUXxnaaNhm5xYwxh+Q6ZfuP2iMSowU9FoxL+3
         LRSb3nwY0TTBSeLxaKsC1UlCWQmRQtqUvxVymSiM+aC+rl8tdw2IlZ2knnoAjkioDV4s
         MNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144696; x=1783749496;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tEG7tX5+i0yM5fGvf5APIP8u2V/3BZ/C2R2J5nBR/YM=;
        b=nD9mkSu5N3sRdSqe6a+1jktXJkRsaWRqxBFfJRc5G9qWp+tp1bQmcZ4n3ieqbF9o9r
         ppH9AweYd8Ss2gQ2S73pbl8c8z10skE4GUnS1YSkFc0e8ZLWfymsMVqIK83dT/8QODjC
         7fJJcTl9AjAxC/3Q9s5HZESmTvbjDe5v4O2wxcYrWgx6z5rh3s+UK2ywQxrYJCKfRHFU
         btzpGWqJ30f4nPgYh4R61Fb3kLTPtZPM7AY1CYutDhoAbV5McCoMf7LsIIVR2UGlLjyV
         FqX6X4oUHSGgqLlkUNykKXagbzdjvcmOn5RMipNf/75JZ7KQa+S42JXQcykG5xKkkqYT
         SMFA==
X-Forwarded-Encrypted: i=1; AHgh+RoNX36pwUER7Wjg4rxBxn8ESGXOPJPoLRfYlzcOto8KEqavnicl9NFqjIl8TnZWfYjKiAHFaH765/NThg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRoq19SaV0rA2AEcfO6GcSz9Jg/Uhqnw0sPN2ysrfIhu/kdU2c
	zd0wBC+ptrT0Urwx2evSN3vs6JnO2xbJDa8LW2eicdD0XTfm0stB7u7Q
X-Gm-Gg: AfdE7cmg8pOet6EaONvgvTriCVTjGXnnknLlsgM3vjbI1X1cu0U5w9i25oGon3yICcL
	iCtEPLPNxE25WOePqbupN6uvj+eVHEiSXPYtuSr/EFK6aODZ3MebvPOGluS5lUyBUEWUT4lCu0l
	FGomxx3Nanjx4iHwEAeearDaMz3N5LX5RDzzf/ItnTlb9ZofgFcY0nmgPe5G2CVRhIGizYmEZuN
	wHzvempQuzqG/XJX+Kh6D0747HUSUbTsKWZz5pfUPFHWWDEfxaJZETWfZ8c4G7OgJwHyVFHMNPZ
	orjyEm0il751ZlR2ykARkeyLez8DMQoKEpUGqf7VfXI0kuZVdQnHDgaS1s63kLKBiNDRdRtu0D0
	gSyL3jRdd9yYsSOAriuCMztVnNMUyVbrrOUtQ/a3xXK4CXBmOO+eUd9eNAj9KmlsKPHM/4bk8JD
	OZ5nkJMjdl84Vnlluv+rwh/AAxkbYZoqQ56Hhr+xZPyMlKqD3fpGw+unrcYkkCHSEUBYI/edbYN
	XA=
X-Received: by 2002:a17:90a:d44f:b0:37c:8628:f79e with SMTP id 98e67ed59e1d1-382934ec0bemr2222411a91.16.1783144696090;
        Fri, 03 Jul 2026 22:58:16 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:58:15 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:49 -0700
Subject: [PATCH 26/26] Input: maple_keyb - remove redundant 'new' buffer
 from struct dc_kbd
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-26-41e424964da5@gmail.com>
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

The 'new' buffer in struct dc_kbd is only ever used as a temporary
staging area during dc_kbd_callback() to pass the received hardware
packet to dc_scan_kbd().

Remove 'new' from struct dc_kbd entirely and pass the received buffer
pointer directly to dc_scan_kbd(). This saves 8 bytes in struct dc_kbd
and avoids an unnecessary 8-byte memcpy on every keyboard poll cycle.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/maple_keyb.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/input/keyboard/maple_keyb.c b/drivers/input/keyboard/maple_keyb.c
index 1d99ed5bad1e..5b10c6ba7bd5 100644
--- a/drivers/input/keyboard/maple_keyb.c
+++ b/drivers/input/keyboard/maple_keyb.c
@@ -23,8 +23,7 @@ MODULE_LICENSE("GPL");
 struct dc_kbd {
 	struct input_dev *dev;
 	unsigned short keycode[NR_SCANCODES];
-	unsigned char new[8];
-	unsigned char old[8];
+	u8 old[8];
 };
 
 static const unsigned short dc_kbd_keycode[NR_SCANCODES] = {
@@ -75,7 +74,7 @@ static const unsigned short dc_kbd_keycode[NR_SCANCODES] = {
 	KEY_CALC, KEY_RESERVED, KEY_RESERVED, KEY_RESERVED, KEY_RESERVED
 };
 
-static void dc_scan_kbd(struct dc_kbd *kbd)
+static void dc_scan_kbd(struct dc_kbd *kbd, const u8 *new)
 {
 	struct input_dev *dev = kbd->dev;
 	void *ptr;
@@ -86,11 +85,11 @@ static void dc_scan_kbd(struct dc_kbd *kbd)
 		code = i + 224;
 		keycode = kbd->keycode[code];
 		input_event(dev, EV_MSC, MSC_SCAN, code);
-		input_report_key(dev, keycode, (kbd->new[0] >> i) & 1);
+		input_report_key(dev, keycode, (new[0] >> i) & 1);
 	}
 
 	for (i = 2; i < 8; i++) {
-		ptr = memchr(kbd->new + 2, kbd->old[i], 6);
+		ptr = memchr(new + 2, kbd->old[i], 6);
 		code = kbd->old[i];
 		if (code > 3 && !ptr) {
 			keycode = kbd->keycode[code];
@@ -103,8 +102,8 @@ static void dc_scan_kbd(struct dc_kbd *kbd)
 					code);
 			}
 		}
-		ptr = memchr(kbd->old + 2, kbd->new[i], 6);
-		code = kbd->new[i];
+		ptr = memchr(kbd->old + 2, new[i], 6);
+		code = new[i];
 		if (code > 3 && !ptr) {
 			keycode = kbd->keycode[code];
 			if (keycode) {
@@ -118,19 +117,17 @@ static void dc_scan_kbd(struct dc_kbd *kbd)
 		}
 	}
 	input_sync(dev);
-	memcpy(kbd->old, kbd->new, 8);
+	memcpy(kbd->old, new, 8);
 }
 
 static void dc_kbd_callback(struct mapleq *mq)
 {
 	struct maple_device *mapledev = mq->dev;
 	struct dc_kbd *kbd = maple_get_drvdata(mapledev);
-	unsigned long *buf = (unsigned long *)(mq->recvbuf->buf);
+	unsigned long *buf = mq->recvbuf->buf;
 
-	if (buf[1] == mapledev->function) {
-		memcpy(kbd->new, buf + 2, 8);
-		dc_scan_kbd(kbd);
-	}
+	if (buf[1] == mapledev->function)
+		dc_scan_kbd(kbd, mq->recvbuf->buf + 8);
 }
 
 static int dc_kbd_open(struct input_dev *dev)

-- 
2.55.0.rc0.799.gd6f94ed593-goog

