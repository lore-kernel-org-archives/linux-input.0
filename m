Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793233351;
	b=0GASgYWV/xtcMB/ovA4UTKsA+Qfehh600PCQNrH64AbsUPl9SbXQ2a77t7MFCuUxyB1l
	 l4Kxu6rSo1qpOMG8/3YF4Y7YYHKeiwt71g99OMgfpgM1d9a9MiwyLgFLj7ZWlKmbpueEc
	 7wnhYXIc+DzdFLjhBCGh2UVHua5QtFuRiPDUXU/f8zIv+vbfqUut4gG3xyjcd9LEX9bZo
	 9B4UpgDWBzglXB+OSTXKpCt+1gvgnCmlY///MiEMQNZUBCzGIBIx2Kq9Fq7Wm4y7VV9Es
	 8/5OHsjANL5A98rra3BKdSYmSLIHfK5b7u5qGtU5i4eVVPELgRsWtYf36fxGXzA+nhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793233351;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=dfPBfDLUwvq86AdWInBVQftIi/RMxzYxDIMnjvA3HSU=;
	b=N0lLc0KK0juylURiaA32a9/+mB5lBCX0XPNgG2IjHxQhud68JcDyzJ0fV+9UHvyhNfzt
	 QYCP/vV0yVWzRmh5++mStolTanRWnoU++JRFjgoZTJU5ac/z6hSWdkcd/JF2QYlwGBmhK
	 sP96lHk9pMlBj/Af/Zx81nN148Nzm41DLtQHIQ1zDMKExco4Gbeeyky7CqJUA9gZ/d7Gy
	 nExAIFj+mCPY8MHvVN24vuJQtWDsQgtWZVXh6f5Z0E7yX86w/9CMrSDB7dzmeDPTK5hz8
	 7afD4H7jLmLVWj1DES9rBGOy2Y+JxjFKWLUQGu+B28/d6/mgTd1sXV8jG852P9CUcpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E60gA0Fa;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AA7606A31C
	for <linux-input@vger.kernel.org>; Thu, 29 Oct 2026 00:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0AA7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E60gA0Fa
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so15650345e9.3
        for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 17:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793233349; x=1793838149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dfPBfDLUwvq86AdWInBVQftIi/RMxzYxDIMnjvA3HSU=;
        b=E60gA0FaHq71TzjUeWv1owrj0oRTiw01yC8Spwnc1J372yDy7q2ydrsBAQXSvzynlT
         kgXXXJ+RprS0ii9mxM4yXZbGnlocAFuyhGBwx72dk9MYgBD6O8KLLSyejs+pR6/saEjS
         +XiZl4QM17DIXROSwFOxY4Nlh8qGDWqngjQUC5h6urtKJt27ycL0ON9nIMxAuTt3Bcz8
         1gY4m6LKv8Y0eO2huShG8novUmrET+NKMKBPFF/5cydW6Te10cR5ALpmRWxnhiiACaAw
         knC4tXwKUMLxmA7wUgSTtbVgj1nvxC0gFu1yKeFcClnvcUcXfSQgrSR3vYeTDU3LWfPZ
         vDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793233349; x=1793838149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dfPBfDLUwvq86AdWInBVQftIi/RMxzYxDIMnjvA3HSU=;
        b=lXIUEGg9ERDMW41tgCLDZfaFQ+uMvsddTRZIXgRs/p8Wsyx5gZvYKumT7r9Exfc85B
         xt9rbaZ+4m5e4SCRY+RLhkG9q5LUtCOs4TrLm297YXIDJv60X+29wN3nW9Fi+nKogiss
         5iGcH2GrwYsIonDgFlO1Mj7NsNym1lEAzuaQaRZnzxmCzst8qYBNdrb8+Kt/REyp/HX6
         eEOzXS+Zzd6VjG2tLfLB0eUeEFERGZx2ANg3Bz0ivCI4iDJYQYh0i4x6j0BL3IZS17Tm
         lFfAeDR5V6Wqx34VQ2YS134Mx7evPoWBQG195sBloS7PJIxTGB+zoGPm+MVdMSavLZrm
         /s+A==
X-Gm-Message-State: AFq9FYK2UyCYZZ6xql3YwCm6TpTMmVShPcU8aNHsJeZD7V2rsfg8BfS4
	9BNy3LJQelVM/LDXx3lHQjk6uON7U8qDM69cRyQnKFHDZKS6LPjcE+s=
X-Gm-Gg: AYBFou39nj3cVUBy54dilrP59128cq489s1K3ks8svdH6TtvzbJZKTe9eWHCKhukkjg
	1KsvkTK+P9nKpBLT1/t50Gx04fht+M/OmuvlrGquttCXKn4tB4LIv2SW+t1unorNmoGrPK6bXWM
	57cRWurEgax64MT1Lee8cw7KHiYxkJ95LjecWAwCGYsqrmULgf6Nxv3769WHc5PCXshdxhg5HKs
	mofbhjvPLqLT4o/a6+fBgFI5CHGYxt2+wqYneiWM3C/gbgWeSyx5Uwa+foaTpp2BuqlnMNyt12T
	4pXbO7wb1wqQJk/Lq0wATleRwh7ZRYiT6pZ4uO4w3isq2cvQwLdktxl2SO4moxFCTLLHwY2Hsdx
	vUXWFNg6Fh22gwmXyDpzvBn566XL18ejSC3hSsAzTusGlTKbc/oDPE+uD2RT6Slnvrur5CW+4JY
	sIf3lRiMLBrFPP6aZKLfukYSWzlZ1eu7DCyuYpBYRE9N+4H7261qOeKMoegqoSGj7UzqHjFO3kH
	xAV9eEsA+1imX0XD2R70Df5huZs27mm3JM5u4YCrIJHGi5EDpiocEkYnVk5Ap9Tvv4M2ocsQA==
X-Received: by 2002:a05:600c:198e:b0:4a0:4a8:d444 with SMTP id 5b1f17b1804b1-4a967ba8856mr82938905e9.33.1793233348875;
        Wed, 28 Oct 2026 17:22:28 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a92e103d91sm43014535e9.0.2026.10.28.17.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 17:22:28 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3] Input: applespi - validate ACPI property buffer length
Date: Thu, 29 Oct 2026 00:22:27 +0000
Message-ID: <20261029002227.2002174-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

applespi_get_spi_settings() reads three ACPI _DSD properties
(spiCSDelay, resetA2RUsec, resetRecUsec) as u64 values from their
buffer pointers without verifying that the buffer is at least 8
bytes long.  If a firmware implementation provides a shorter buffer,
the u64 dereference reads beyond the allocated object.

Add buffer length checks before each u64 dereference.

Fixes: 038b1a05eae6 ("Input: add Apple SPI keyboard and trackpad driver")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v3:
- Drop Cc: stable since this is hardening rather than a fix for a
  specific regression, per Dmitry Torokhov

Changes in v2:
- Fix alignment of continued condition lines

 drivers/input/keyboard/applespi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index cf25177b48301..db8947b5cf11c 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -642,19 +642,22 @@ static int applespi_get_spi_settings(struct applespi_data *applespi)
 	const union acpi_object *o;
 	struct spi_settings *settings = &applespi->spi_settings;
 
-	if (!acpi_dev_get_property(adev, "spiCSDelay", ACPI_TYPE_BUFFER, &o))
+	if (!acpi_dev_get_property(adev, "spiCSDelay", ACPI_TYPE_BUFFER, &o) &&
+	    o->buffer.length >= sizeof(u64))
 		settings->spi_cs_delay = *(u64 *)o->buffer.pointer;
 	else
 		dev_warn(&applespi->spi->dev,
 			 "Property spiCSDelay not found\n");
 
-	if (!acpi_dev_get_property(adev, "resetA2RUsec", ACPI_TYPE_BUFFER, &o))
+	if (!acpi_dev_get_property(adev, "resetA2RUsec", ACPI_TYPE_BUFFER, &o) &&
+	    o->buffer.length >= sizeof(u64))
 		settings->reset_a2r_usec = *(u64 *)o->buffer.pointer;
 	else
 		dev_warn(&applespi->spi->dev,
 			 "Property resetA2RUsec not found\n");
 
-	if (!acpi_dev_get_property(adev, "resetRecUsec", ACPI_TYPE_BUFFER, &o))
+	if (!acpi_dev_get_property(adev, "resetRecUsec", ACPI_TYPE_BUFFER, &o) &&
+	    o->buffer.length >= sizeof(u64))
 		settings->reset_rec_usec = *(u64 *)o->buffer.pointer;
 	else
 		dev_warn(&applespi->spi->dev,
-- 
2.47.3

