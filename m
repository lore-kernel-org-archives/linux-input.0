Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE31C1CD1E4
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 05:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144663; cv=none; b=H6jlJLIdGZYV10B7+tYOfvZt1Kw10j3PVAnkAvtOjJ+ExA/WuCzPPYTZt0ktMP5UxNh709OTKNW8X5M8UDlTQtGc2xDTNM4dmHjsStVDJKjcRzbGKT/IomWyiONJFj6yH3giiEbm/4yqKJ8wHprjxCiFbLmyqLaKEUfCiDhu2lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144663; c=relaxed/simple;
	bh=UZSM3eWv9Q5ewCC7Mf4OpTsyzSqpcOfv7jMvg20ynLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XKpSogZu1ljigtFWFexwhiwq2FDageXy+R1d01U6KAUSW6foGgdizlpFdztgHD1ZPEKcvhKzgrFJC5LhLQ5dqXshJTp7vw6FukncwBGXFbyTehqCwS00XUnP/OzBIKwNsL442yYHlbVsufbzHQwhnY90b4J9CawtISWAVlepYZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBQ660tP; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBQ660tP"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c9eefcf9175so1139265a12.3
        for <linux-input@vger.kernel.org>; Fri, 03 Jul 2026 22:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144661; x=1783749461; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=15hSQeEEYahDoHIjuKW6WN5DINg66LHxIgPA/aX6Wqk=;
        b=EBQ660tPO+qC77gimM2m6DI0qfLh0hXUUlNlAye+sAF6tbl2tTK22GlPT+Lk/VVZhx
         iLoTCplTHhttB1eDSn48C0nFpud98oIhFypd/bACqAhgyXaS2hqUvzmRyrf7i2iRvN2Z
         qExcMzx0H6FX+P2pon5LD90i7BS1277002N3udbKYpIVpvoJlbgVJUbyr7aEnnezW8rG
         tGijeP19gXhqkFmj3X8Z2B/WxAGJL6a9JnoozPWrjJ3IuzG+P3gxizO8AQh+KdNbihrI
         Cw2+XMVENZK3ij8lJzODRK9ytfZUuWYKi1M/qxiHu7ngfYlnGgO4JB1b0H3GaBF3NlRv
         4QvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144661; x=1783749461;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=15hSQeEEYahDoHIjuKW6WN5DINg66LHxIgPA/aX6Wqk=;
        b=tTsEdC/pXZjTbcajnPf+cOpuxVsg2fTXC8k7DLxhr9Bmba8zAbQs+WwnhFHDba1jml
         sxImU2poAFnrmdaIgL9SOSnC/GDyK1fM2rdyjLTmGTrgHRkDvrkPMpyj40qhRVPCc+KS
         cEW1zd9ro8P9wVQ1ztROKgxveZW6o3lYLO1k7XIg244gCdD4Igsh+JZuDTfdsjlEvbvG
         97gdvRCWRo1IM6vQHrNF/OqMzvXecgxXTDWFQjN0Pvci5osmQ3TAwNTYPD4Yg5huHCoh
         10xVwQRfVs8UF9aaEso9IAya4zyw4rMbEFUDJNpCQ/y60FfOE6c+XTIHvK4W2fHeSyKe
         eLEg==
X-Forwarded-Encrypted: i=1; AFNElJ+hw3agu/hCiu7UcF5XuVP4254V9HGeKO/YPQgNiOjBCkYgKbIdjdfOTEilThy6eHU82ROKlhM4SxmMcg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ/RYOJhGUj8MCBBna9p1b7y3r/IDIpIBQdbfMBsDi11xmF4SF
	oxqG75gb+ZXp9iN/YWoLJlv3LPdMWHjBi0qyxKcFdZW5UGaVseEPnKs+
X-Gm-Gg: AfdE7cnXGahNOad7VoPePLwiOzo4A1v8pY979J3yLnF6hxWZV5qC/HMeIph/OfT+lI+
	j7O8DJQQTgiEtd6FnBtwTK3MDY/ML/mfl62bhT3vjFond/CV3Mjuijx2U3yAO2NGJgRXsFSD2AF
	2JLzAbFX8wl5j+nroDtChzgL3u5PJoJfKFqRMBqq4pH5owvyWnPKzfPNInQ99oY2CF7khVfFQ5M
	xpamiJPpc/slXsa9fuecfRUxfhHE0VgForOwFtpkDPxjZBJ5qDrgBjGSrYh0dSUi17ueMhWI1+i
	ZDQXkfv51sq4xQ40WNM0hUXuvIWZxZ3vgNjPArslFIS+pc2YlasmNOIZZOGTHtxTkW/xao6UfVA
	jF0LZLx/0nsW0p90/hsQaAxguvEvoUKbSDcfPK2g199EuXd14HRkTkhOznanTGQe3KCiTgaF7XL
	aANTfhBKaa4ARzkARJ9Ob2ssP1mxQ/NJQD23rUXTO6mET/JILktxENdcyFK4CHIAALkSxJthRY2
	0Q=
X-Received: by 2002:a05:6a21:44c8:b0:3bf:6c08:2849 with SMTP id adf61e73a8af0-3c03e540d9dmr2322074637.56.1783144661119;
        Fri, 03 Jul 2026 22:57:41 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:57:40 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:28 -0700
Subject: [PATCH 05/26] Input: maplecontrol - stop polling and clear
 callback on close
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-5-41e424964da5@gmail.com>
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

In dc_pad_close(), pass NULL instead of dc_pad_callback to
maple_getcond_callback() to both stop polling and clear the callback
pointer when the input device is closed.

This makes the manual clearing of mdev->callback in
remove_maple_controller() redundant, as input_unregister_device()
automatically closes the device if it was open. Remove the redundant
assignment.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/maplecontrol.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/joystick/maplecontrol.c b/drivers/input/joystick/maplecontrol.c
index a498fc322c4d..c66b2614e298 100644
--- a/drivers/input/joystick/maplecontrol.c
+++ b/drivers/input/joystick/maplecontrol.c
@@ -74,8 +74,7 @@ static void dc_pad_close(struct input_dev *dev)
 {
 	struct dc_pad *pad = dev_get_platdata(&dev->dev);
 
-	maple_getcond_callback(pad->mdev, dc_pad_callback, 0,
-		MAPLE_FUNC_CONTROLLER);
+	maple_getcond_callback(pad->mdev, NULL, 0, MAPLE_FUNC_CONTROLLER);
 }
 
 /* allow the controller to be used */
@@ -156,7 +155,6 @@ static int remove_maple_controller(struct device *dev)
 	struct maple_device *mdev = to_maple_dev(dev);
 	struct dc_pad *pad = maple_get_drvdata(mdev);
 
-	mdev->callback = NULL;
 	input_unregister_device(pad->dev);
 	maple_set_drvdata(mdev, NULL);
 	kfree(pad);

-- 
2.55.0.rc0.799.gd6f94ed593-goog

