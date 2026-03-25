Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0FC7DA66
	for <linux-input@vger.kernel.org>; Wed, 25 Mar 2026 22:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774476993; cv=none; b=RwKpJWU9Uk6QYm2zKg9VToxnZH/yEHfgY16KaQ/6gO2mu7Cd0Hf7sumhufh4vFBzgjNHjML36OxQXskjgGgCtaHBWkCyqMhe0QWdQGybxwSdMPxhTsDAt18OHdihWlc3mjZql/YF23XonQu+NSa2131dVuH9O3xIV1TBgmaRkik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774476993; c=relaxed/simple;
	bh=Y1XCFPL5s2x+Xef+u9K5BlSJ6CJiaBDOul7KtRlSIBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kNMwaA4zKHwGoBYuo2omguZSU+18zXJHAdywBUwLv5oVPJGmLzaJPTfiYoUWh7djtl9NbioGornoc/mU4hCAgW0qc8blE1lGqFdoEi60tHX1OOoJ3dpPrLnxAoXdqTuWgNnlJF+56yt0rZJOaDyb3b3bLS5pOeW46Fth0BWDOG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ygv0CGmL; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ygv0CGmL"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486fc4725f0so2339465e9.1
        for <linux-input@vger.kernel.org>; Wed, 25 Mar 2026 15:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774476990; x=1775081790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PHXdwSEwuD3uacC/KdQYkXDD02SxrBUM/snJS/8R8UA=;
        b=Ygv0CGmLc0+q5LLWx1/oJvCOLcFtsvcd1E5FizyJuKYu2LGNZAZodm/wipypyWXz5g
         E8uKeUhWJqpk/4fzaiQ3mHjAOigflqSBqhH4ZRotUfTFMKva2gS8bEYmLFA9ZjdfCy9o
         xmB4pXBhlBkwgKinOjfZWIewhGwzw9tcJWDQAQQYHXGFAzUtucw4wc+ScecN7poMwNTp
         76OTYRMVSVNPaRArhAZTkfUgQH3wvscuzf9ZhvIBL4vkyEyAYbzmoZeYkaeN2nPKeKp/
         G8knuPl5vqyc4jHNbB/8KTtH/Ck+Yp92Xb/SSauDH6JLIXHtnCMWpI7PeMgb65VxWuVs
         fWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774476990; x=1775081790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHXdwSEwuD3uacC/KdQYkXDD02SxrBUM/snJS/8R8UA=;
        b=KHIMoJzu1MjZ4/Wy/h2BNayEoMsTcHQgCGLvmSHibH+ao3BjmmiUQAJz6BImT0zhLG
         5r3TMHtpYvKcJ6543tequ6m1BYTsG0mHKgi0BVUD/lksCs2m633mZJwd1qoAZlwJPvL8
         Ga8bfuMJK/RZXAuZqTQKoTFHFdcUVU/0qRqxtnwErrY3pIZoCCdSV8bySTMmkKLbsjnq
         Tz3JrExdAKENM60xPZUyD4wLL8yVEwkPBhF1PCQgb9p9yLq/L+rtGGFUjhuONXkP65M5
         b995eqjpDXSjkFkhNGwA5vkTImMBk52JAwXh1uoPF0zfZYTIUwgSZYYqEAc13HjvK3P+
         JBsg==
X-Gm-Message-State: AOJu0YzlROGuovjdu5dtdkHw1Whthmcih2u7GgYrFbuynNcIJy6Pv1ua
	r3jzS580fPe/4WFeYGjcBetCBXKLCt7o1rdGP2SwXHn969SKloBq1TjM
X-Gm-Gg: ATEYQzwJJYJ3Qkcm1EN/MQkw1JZZGJsVuiR67ym8ZJhPRbU0NZp55OMBoj/e98y+tg5
	AobzM1a7AOgZWUKb4LksfPThMioylFDfOzgYrPxHHseUtvHFTrKrj+/ce6QQ8PD4Y/AN9aOG4kp
	ixDjPuFfBedEFVCc1iY9ZG9BK07lUI9bo65etSalivkU2cvUK6feYpNBrm+j4+IzVuRusiNie4F
	acbf4GbPKSONH4lUeM6Xw+vignobOAA+XHMDKxDiYZm/fh9rg9KLY5v70EwZzg9Qu2MiF35MbB4
	jkTzJm95DY8sevUvaelfd/uz8ElAc0U/RJ0WwCSbHDJeZpelWXoLEpFgWatd29HvQOXJtM6lc2s
	26aPaX3fiYvcpQsYSNa95VD8L6bXMeVcUnKeu+vDiQl1dgKPjfZ4BaDuqdB9YN0cUPb1bC6G4b8
	4KmPXE7omZ2AUZt/5R6aZHIqROVKaGu5GXnfMEqY7SEdgzj22hAeyCkrocpS363wc=
X-Received: by 2002:a05:600c:524f:b0:485:fbd2:f72 with SMTP id 5b1f17b1804b1-48715fc76bdmr69246555e9.1.1774476990288;
        Wed, 25 Mar 2026 15:16:30 -0700 (PDT)
Received: from localhost.localdomain (i59F7ABFB.versanet.de. [89.247.171.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871fb3fc8esm12113645e9.11.2026.03.25.15.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 15:16:29 -0700 (PDT)
From: Elliot Tester <elliotctester1@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Elliot Tester <elliotctester@gmail.com>,
	Elliot Tester <elliotctester1@gmail.com>
Subject: [PATCH] xpad: remove stale TODO and changelog header
Date: Wed, 25 Mar 2026 23:16:17 +0100
Message-ID: <20260325221618.135833-1-elliotctester1@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Elliot Tester <elliotctester@gmail.com>

All items in the TODO block have since been addressed: axis tuning,
analog button handling, rumble support, and dance pad USB IDs are all
implemented. The manual changelog is also removed as history is tracked
in git.

Signed-off-by: Elliot Tester <elliotctester1@gmail.com>
---
 drivers/input/joystick/xpad.c | 34 ----------------------------------
 1 file changed, 34 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index bf4accf3f..ce0f0b7e8 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -25,40 +25,6 @@
  *  - Greg Kroah-Hartman - usb-skeleton driver
  *  - Xbox Linux project - extra USB IDs
  *  - Pekka Pöyry (quantus) - Xbox One controller reverse-engineering
- *
- * TODO:
- *  - fine tune axes (especially trigger axes)
- *  - fix "analog" buttons (reported as digital now)
- *  - get rumble working
- *  - need USB IDs for other dance pads
- *
- * History:
- *
- * 2002-06-27 - 0.0.1 : first version, just said "XBOX HID controller"
- *
- * 2002-07-02 - 0.0.2 : basic working version
- *  - all axes and 9 of the 10 buttons work (german InterAct device)
- *  - the black button does not work
- *
- * 2002-07-14 - 0.0.3 : rework by Vojtech Pavlik
- *  - indentation fixes
- *  - usb + input init sequence fixes
- *
- * 2002-07-16 - 0.0.4 : minor changes, merge with Vojtech's v0.0.3
- *  - verified the lack of HID and report descriptors
- *  - verified that ALL buttons WORK
- *  - fixed d-pad to axes mapping
- *
- * 2002-07-17 - 0.0.5 : simplified d-pad handling
- *
- * 2004-10-02 - 0.0.6 : DDR pad support
- *  - borrowed from the Xbox Linux kernel
- *  - USB id's for commonly used dance pads are present
- *  - dance pads will map D-PAD to buttons, not axes
- *  - pass the module paramater 'dpad_to_buttons' to force
- *    the D-PAD to map to buttons if your pad is not detected
- *
- * Later changes can be tracked in SCM.
  */
 
 #include <linux/bits.h>
-- 
2.53.0

