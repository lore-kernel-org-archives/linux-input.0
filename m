Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D6C38A706
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 05:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144657; cv=none; b=WHxIshlH9xnN7x0xKo4Zu/Mkirdl/UA+AM/+MhFFz7Nfu6daLCcCXtDZiZb+FqWPCDVvusbnb+gzMYI+UC6kOgZ2K3uJr3R7Py2PK8hNA5oDAuF+lqekJMJMq36khsKEZ6OQQqqVse4uQtiuNRNfjAfNC02XlNKchU2lk7iZGo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144657; c=relaxed/simple;
	bh=nj/892zcwHqKY6k98/X1ebXGE0Sl7j7eE0rbpi7D+Lo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FQj4Fu0AU0408z8JOLOLtjdK49aWe0Lkh0aP/1mRBfEq487HgRgUwdMTrU21SxzUlmY6A2quMW7c8YUZAvbtCNppQwwqwjUOLLl6BDB91tXhrem0rVt5mJYGj1WFITnR1/BU9RY3iVEDDW4V8lswLMqjCZa615jlaSX1wwX6bQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFGh4T35; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFGh4T35"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c9d1fc053e0so967469a12.1
        for <linux-input@vger.kernel.org>; Fri, 03 Jul 2026 22:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144654; x=1783749454; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DUBmbNocxonyJ3lOrR4g5OiG/+KsVvhX2DrdQTMHh3Q=;
        b=kFGh4T35jRq5eK5D7u7WTJrTUzUHCVRlEiRsQU9lX7Lqr3BoJANZWIHy6FpReZqC6m
         KXd2nynpVtx8YHQFnDpE9NcrACmGbVfsLmB+dOVhh6l9K3ZI9BN6CrWTdUee08/Y66lC
         yr1ko9FPzWS191W4txKH5mWwz3D7qA/NPcMfPQ5nqAkYLPEG2KyJQYQ3oRH+eZHM6N4a
         wEZ0KW/nNkV5saCNAVfEREx8D2q1A3bug7nFuNwHBliQS/P9gDuKQvHv5wNeCeSXICrA
         mOeiR0icgOiJnpuvKNub0QbI9Dt2ewQ0hvMc41nL20/xPbZr5V6Q2xGIn2rOVyju/nwP
         b2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144654; x=1783749454;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DUBmbNocxonyJ3lOrR4g5OiG/+KsVvhX2DrdQTMHh3Q=;
        b=icPv20Z+BCjOu8CtvXCjLsqwa0j1yD4NmWxwHssLT4tFb0y5mxBUo3vjXpnsBhs14s
         fmIFNcT5QhHarJpwJFPcNk5ME+jsX4IlmgTHOU18MmFHZVLbFpCrZVn8qBHgydsWSh8b
         35CiSwN0O+48MXvGyAo9SvocwyMHIrNob/mIQEWjeiANgg/b0NKcYnuMBopYWvNn3PFL
         L94MJ2ELecsQsEwzCEN7RqzpBtcASQpdHPvbn3wJge2CYtGtJVF0L4rBwNX3iD4JWyRf
         ZYXxhCeWWIjc6uJ7ftG07TOWppSWePhz7LJld5r9B1YPUyUiMJtq+N+MeiuuF4YeU0nN
         6tPw==
X-Forwarded-Encrypted: i=1; AFNElJ9U6Qx+pxqPGsBzqsCN0Zqnn5PqE1q0TJ0P1SVp/uan9b1usCdBr/NWlH8vJNI1lS8ifsiTS0Css1hIaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqDvF+bqEXQ3veAOboNOu7FdIJnaSex/l/2OM8Utix0OlWlXw4
	ht2cKlVYOLFt9+rYsfZ3EDbOyubHBqG/fPELAj0Ry0yroxfwZ4NcEGqzOVhMgg==
X-Gm-Gg: AfdE7cnovS5OPiMPu9Fkqm7FThUdzS/isdvlmkft3wNoPRmxW0Zr68OGmK7BaVUcLqd
	g5YHFmey56PCqTJ87pY/l/qSbh9c9iXn+4uhb1MpHS+cZ/oasUs+GqFysyo2fOO8TB/Sm0K0cs1
	jQJUFN5/RBbnM4aaXJRYhgY/b+C3aCN/fJBhVpNBvAV0rHlm8vvVf9i3pH7oAU69axq9N3gaV2P
	Bg5bRftPmOqgbibZsm0JemmlvAEivqmJPMVg5J/QxER6UuxLIE/FYPerTCRLp6uF3Akt8VFJlTc
	2vJgB+2I1wMsmZUKhllh42FjFqfl4osw7OKOBfUMxgb5j3CxxVFGmfwLPnkT1teTvJ86EINRR3i
	lDMTVtwfwYa8Sqi+8ZLboZ3sBgrLU8lkRn7djL39qYGhV0xJpbgJ9UnYcEW1wd7eM0vyVGCpZ3r
	pE0fcyuw577GAEknS+8j7h8d/nNd8XswzJbTw2g3Mes8JWfScOzeIkWzlOHIQAmS/mrmpUIJdAJ
	Kc=
X-Received: by 2002:a05:6a20:d805:b0:3b4:65d3:17b1 with SMTP id adf61e73a8af0-3c03e4bb67dmr2019218637.43.1783144654392;
        Fri, 03 Jul 2026 22:57:34 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:57:33 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:24 -0700
Subject: [PATCH 01/26] sh: maple: include linux/device.h in linux/maple.h
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-1-41e424964da5@gmail.com>
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

struct maple_device embeds struct device and struct maple_driver
embeds struct device_driver. Therefore, linux/maple.h must include
linux/device.h to have their full definitions, rather than just
forward declaring struct device.

This fixes compilation of vmu-flash.c which includes linux/maple.h
without previously including linux/device.h (or headers that include
it).

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 include/linux/maple.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/maple.h b/include/linux/maple.h
index 3be4e567473c..22f2930251ed 100644
--- a/include/linux/maple.h
+++ b/include/linux/maple.h
@@ -2,10 +2,9 @@
 #ifndef __LINUX_MAPLE_H
 #define __LINUX_MAPLE_H
 
+#include <linux/device.h>
 #include <mach/maple.h>
 
-struct device;
-
 /* Maple Bus command and response codes */
 enum maple_code {
 	MAPLE_RESPONSE_FILEERR =	-5,

-- 
2.55.0.rc0.799.gd6f94ed593-goog

