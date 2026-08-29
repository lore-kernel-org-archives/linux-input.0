Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73232395AE3
	for <linux-input@vger.kernel.org>; Sat, 29 Aug 2026 12:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788006093; cv=none; b=af2cWIKjWzmOcYCrV63a4IOBI9GlETpLJ7N9izwTUFGEky9+Ijwj2WE/e7BZdxTvtX9F+KpKv91QQjaICzgVnwUif3qd/Ajo783Uhxxnm6KufpFahfn/M58GXXvC0NMQLCVqHJ0EETRsg43zfRlIEyvq0Df125Qfha2wdmCGAj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788006093; c=relaxed/simple;
	bh=VcyCGctu1g0xc0Z6WK6gwbU+4XuhAb+0zAuOkn6SwdY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iPAGKAhbtz6GwZgnv3cMek8NQL8/k37y11DlN4+07JChnxy4t3CIEOMQ3qk/Qfgyabl2bbRmf3g6GMMcx1NmrdKLjOGDrSNTQDT4dU7V/eD99nZ8QkQ9BDxIswZPZ+0kvWk38iWgD2c7zkxiOyJEDLPVoSbLbI2Vvaiam5wde04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPfMgSy8; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPfMgSy8"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d6f9e2f681so16852245ad.3
        for <linux-input@vger.kernel.org>; Sat, 29 Aug 2026 05:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788006092; x=1788610892; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FcrdV1chy8E5sLFVdinxAMnEwzUKSY0vgBRq1ljoevQ=;
        b=GPfMgSy8wbGkO3PpBbkYF+/p1vCz1uT0RG6OG+eM3/z1vASphskdgTi50KhAPW1x+v
         xB8KrKTCYqH+Uawne5i6bKf9z+Jev4y+w7sp/50LDrH8DRPRzpbe5ueJDQIgOs/4ROF/
         592H4m2SMJTy+HG2wpCPLsmpgbweV2kIxrzZ1f8K+w1CDWhGU6DgjnrAy7eXOQ7suAQ1
         nKtBvXG/HDTdiIxXSKdWechEVGUy13D26RcbfinejSn/m7m5DnsJZlLmgsjLoklvfmd4
         7TB72Q8rw6fGKIWWJvFQnzbNcaCcwsQpcLtPKjX4HcmrZne/q27UFXIGINRTMIcb0xg0
         C0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788006092; x=1788610892;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FcrdV1chy8E5sLFVdinxAMnEwzUKSY0vgBRq1ljoevQ=;
        b=YspDE2BV6npjFhU//DhYVhrRlgGLT8PSCCqLlpOvoPQT0cGfYiJdoJCbMkU3Ivx2gv
         pDV6XBQcofg9tcxw5t/Yh4B57TRwyWkBI82JtDBByYiKT51jXyZYaNeveZXpVqe3M9ly
         QhIS6YHmPj0IkZsbklAMjgAXTKVD2JP85vM2Bv8tvo2aZqIG2PUi1gqhCiYEREKHSkpz
         GrOZ++nCk63BYoXdkIYg1h6y0LUdyY0oyMrC50OfZR1l9UgxTDx1nz5c73haLeXbngPK
         cl8mLOnECzqX8FvzJAprt9myHqXYa/rshNAlGOWOZ709/VsHaSAibl6QUMcC9UhC7kfq
         Ui0w==
X-Gm-Message-State: AFuF++mPJCnkTFb7ERF2ED73tFAGhPo+jNaLd0kXQR9LhrdN6qFOGMRS
	EM/xs2cPYCOmv/vXdIkAk3IoQyfwj4+OfnogiqM3XC4CUnGhYrXlaUyhpYs982FT
X-Gm-Gg: AYBFou2TEZagdHLlmIlekiV65eF87Yy1qnIEr1ntrh5OGGizHXMAqkvemflk4Ok2+wC
	L2OUaS1g8qbWW56+Sg9XJL8hNTp+BgcRnY9sjQkdEl5ume5OqiwwsFfNe6E82oe/S735SaGu1Oq
	oTHVN8VZBPKcsU2eO7EsvtMZQcs9LBkaJ7UK0xjyn7HQJ0f/LzbS7KuX8Ey79vJeXLjqHaVh/N0
	AOjbvMUcvOpwxif/jPX6DmNx19QkXIgkGd9+ubMXBzxfrDGMfMqTjJOfEWFdBAQkR5xpEYkHe3i
	GG6ZXKT2SGch4VE3Is0BUJCkpXxQJegwd2i+RMS7rokThthohUd3KhdSGziTMw3Xa8zaqjemCSG
	LJ1zzRpWomWbQXBomJOmqe8goU6EnUTcAQ000nPRtB54le7LVnEIfyiDXvpG1qYfZ2irztnT51m
	6RaHr4pVNRodfZxmRDBXecfYsou7+GFFYXtRyN0l6Mw1mzMFOAKo3UEIVCZfpc/w+r1wyljZrGl
	Ln7aSC2R9YtDzFZq7v3nNZ3Mi26Uw==
X-Received: by 2002:a17:903:3884:b0:2d6:3c22:993a with SMTP id d9443c01a7336-2d74dbe96fdmr255095475ad.3.1788006091685;
        Sat, 29 Aug 2026 05:21:31 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:54de:b26f:8c97:cc89])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32874498f9esm12041393eec.20.2026.08.29.05.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 05:21:31 -0700 (PDT)
Date: Sat, 29 Aug 2026 05:21:28 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Maurizio Casciano <mauriziocasciano7@gmail.com>, 
	linux-kernel@vger.kernel.org
Subject: [PATCH] Input: drv260x - switch to using fsleep()
Message-ID: <apLOXaWFZ8ueIEAm@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Switch from udelay() to fsleep() in drv260x_worker() as it runs in a
sleepable workqueue context where busy-waiting is unnecessary.

Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/drv260x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index 6c5c4c53753b..477ec84ea09b 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -222,7 +222,7 @@ static void drv260x_worker(struct work_struct *work)
 
 	gpiod_set_value(haptics->enable_gpio, 1);
 	/* Data sheet says to wait 250us before trying to communicate */
-	udelay(250);
+	fsleep(250);
 
 	error = regmap_write(haptics->regmap,
 			     DRV260X_MODE, DRV260X_RT_PLAYBACK);
-- 
2.55.0.897.gb25b4bd76c-goog


-- 
Dmitry
