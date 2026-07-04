Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A7738422F
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 05:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144666; cv=none; b=lzUdT1Oi0rwSwUuXhHL6giciNIJWgrL+SvoldcWZXR4fPoK9EaD/PQzkGy4xSYmwBJeFv0/EVAJ7e4DwfKPjVh3iEOF4hdHhlnzRCjpeeqsCGe9/RKH57hKryDFJtykdr4f/GKtzcUr5LprhJrGR0RvaKYvDm7qY9xiG40gr3o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144666; c=relaxed/simple;
	bh=a8jRBRl/22LOCeRI2rwXY5+djprns8HyM7TedOnmb/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I9o3OKn+HDBBVnn3akMQYB4lnvf2nTsZODMkFIVyARAvrNLbCUM7boie5GHEp2X0adBionc/j4ZafVBIAecEmphOpiM1ot1UP2sgRjUmij8z2bgGOwsP4lK193TDqKREWUxFuYwZZUD3wBb0gyFgZED61FMwUfXgq6WDu20bxzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrfjbyaL; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrfjbyaL"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3812c718debso1086154a91.3
        for <linux-input@vger.kernel.org>; Fri, 03 Jul 2026 22:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144664; x=1783749464; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=As+a+oXMaauuXL6cjX0g2Fcb3J4Vh+vaEl8MbjsXlXU=;
        b=MrfjbyaLypr0OgKC96y6tkkbkvgex8ArGeWrWb7knEyL16mTLAoty9GJaruwImOQSD
         xZ7dtVHfnL9G4VphQP+JEAafyceCNyy0DL78rgsUlzECQKqheEqBWmMjXBvK9bjlIjkR
         ZWEAUz5rBQtyHuoRzOB1K7iwQ8tKdilfcxdp0A+i3sl97jnGssoe1Wixp5UzK/mUY9Qz
         hFAyNpPJ47hFSCBfCraonPkXZqUO9N7BCw52sBeN6l/gsfS/MK64zg08f9J8Td2Rmety
         jBe1emNmHAYT5n+aSuvNu8/xdL1EhCQYiDApuXChQ/q/u7kC39RHsDgA+ZMKK748K6Z/
         2yRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144664; x=1783749464;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=As+a+oXMaauuXL6cjX0g2Fcb3J4Vh+vaEl8MbjsXlXU=;
        b=RwkN2tEasWdLjE5NNyeZaYbXU/huOG/rzxutv3jj8Cq0PeDHCIlu5Ab8gvsylOe9oq
         5Hu9344rE4qloMm99kYjWCbWXsUG7+nAGR+LUd6sZcDCVaKFvcelx+Z9q5jIAvBuSRl9
         AyMayLC0oPek7sp9rtwS9NT0P9eSO6iwkMGg3ortzS0NWfrFxZ23kq4kgngRLNeNbICs
         vjifNYn/t8EiHkRDJ1XkLmTNXNKqKR3dC0L9AUVeGTRwXAT7pFpFZJvSLFSDPybDaXAv
         9mJfn/J70rOVEq0KcPfZ1VLg81dNH5fEue3wRuENS5K69BUl3s7EoAf9acEryVwViPwm
         Z7dg==
X-Forwarded-Encrypted: i=1; AHgh+RooYg7O4tJJImKsxrDG4QCoKCXMqu8gH8cHwpLEMNoGjjcOphkRvRK/jrcLRLZwfBZYWvr0rnGXsAhMCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxK3W+9KeYTTc/380ehWRka87ebRB7aTO7MzTi6cgu2P9KbZR8
	jb4knXbu5DDlaDyHztqkXgvYl5qStOGuZ8xNSBuDB7tSfNFXTO5A4N6z
X-Gm-Gg: AfdE7ckFiwnDeMrFOPccCkXL/wqTrQ9rtQkFXSiPN7XrUFyEbQxqNTVAIsTojBnScIp
	+pKMhpEdglaZ+BpNo9Gk8rrRiXIAVsgrLBL+em+YGAJ6lyTNm/J1zzxeCSzIGURRqy/D7nHRNML
	fKsrfF/L6vQIDu/0d40bANH2WoUN9Z/4VQ5p1LXd/dZhQWo0qfFnA4BMfu0LXyzLVsjl7Aokvfg
	Ci97HaSbitMYBTowOLsoqGMW6XH51sfO3dqsXa7bMFNYrSFgq/KWp+Rd+HNLASXzcPjft+BXtOc
	qrRE1M+ivbgDHslmeDOW6O3/I64JtiThqn7yDyIwaBp0jyQc1i+OcB5S9p7CNTePP98jkwAVSge
	UFFBxc2gHFH/2ZYBYMQtBwuIk1Trk4cQCg5RJe0LeZCWVXHNSIkKhAZeqCDOuj9DARkS1K/SMfV
	2sCAcj2UJ65OohiUBx9dwtCtqHG9iYdoKDYURJRmDgqv3B/3dK+7xEHmm6yS7uUZyjOCvD8kTZ7
	LLdeVJxjdMO/Q==
X-Received: by 2002:a17:90b:58e8:b0:37f:b16a:cc23 with SMTP id 98e67ed59e1d1-3829f5ea622mr2048940a91.23.1783144664401;
        Fri, 03 Jul 2026 22:57:44 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:57:43 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:30 -0700
Subject: [PATCH 07/26] Input: maple_keyb - implement open and close methods
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-7-41e424964da5@gmail.com>
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

Instead of polling the keyboard constantly from probe, implement open
and close methods for the input device to only start polling when the
device is actually opened by userspace, and stop polling when it is
closed.

This matches the behavior of maplemouse and maplecontrol drivers.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/maple_keyb.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/maple_keyb.c b/drivers/input/keyboard/maple_keyb.c
index 623d7951405b..a245774acc55 100644
--- a/drivers/input/keyboard/maple_keyb.c
+++ b/drivers/input/keyboard/maple_keyb.c
@@ -140,6 +140,24 @@ static void dc_kbd_callback(struct mapleq *mq)
 	}
 }
 
+static int dc_kbd_open(struct input_dev *dev)
+{
+	struct maple_device *mdev = input_get_drvdata(dev);
+
+	/* Maple polling is locked to VBLANK - which may be just 50/s */
+	maple_getcond_callback(mdev, dc_kbd_callback, HZ / 50,
+			       MAPLE_FUNC_KEYBOARD);
+
+	return 0;
+}
+
+static void dc_kbd_close(struct input_dev *dev)
+{
+	struct maple_device *mdev = input_get_drvdata(dev);
+
+	maple_getcond_callback(mdev, NULL, 0, MAPLE_FUNC_KEYBOARD);
+}
+
 static int probe_maple_kbd(struct device *dev)
 {
 	struct maple_device *mdev;
@@ -167,6 +185,7 @@ static int probe_maple_kbd(struct device *dev)
 	memcpy(kbd->keycode, dc_kbd_keycode, sizeof(kbd->keycode));
 
 	maple_set_drvdata(mdev, kbd);
+	input_set_drvdata(idev, mdev);
 
 	idev->name = mdev->product_name;
 	idev->evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
@@ -175,6 +194,8 @@ static int probe_maple_kbd(struct device *dev)
 	idev->keycodemax = ARRAY_SIZE(kbd->keycode);
 	idev->id.bustype = BUS_HOST;
 	idev->dev.parent = &mdev->dev;
+	idev->open = dc_kbd_open;
+	idev->close = dc_kbd_close;
 
 	for (i = 0; i < NR_SCANCODES; i++)
 		__set_bit(dc_kbd_keycode[i], idev->keybit);
@@ -186,10 +207,6 @@ static int probe_maple_kbd(struct device *dev)
 	if (error)
 		goto fail_register;
 
-	/* Maple polling is locked to VBLANK - which may be just 50/s */
-	maple_getcond_callback(mdev, dc_kbd_callback, HZ/50,
-		MAPLE_FUNC_KEYBOARD);
-
 	mdev->driver = mdrv;
 
 	return error;

-- 
2.55.0.rc0.799.gd6f94ed593-goog

