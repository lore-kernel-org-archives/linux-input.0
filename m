Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2DA38E8D8
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 05:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144680; cv=none; b=c2SoB/kQoS7FAt0bP7Du3It/BKYeTsF/QiBWm99Vz5Dk/0yHIn3QSs/GVdroqIeWg0Cbna2MhCbABGtU+Zim/GU5XJ1+ocK6wUJsk7NVvFgtZay3qF0TceMrmmFLsY6SYY5u4zqfRdv1XsLL1kOZnDw/7J02galif3kMONcgae8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144680; c=relaxed/simple;
	bh=QOo0UQgUX/IOM3NWe+RQfCjB7ojkPhoknskSJGJzVqo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bfFT/o9FEfkEcOgTislUUkzDl8HBfKgUwtMiu9F/pZNGuwUlhwf2O7N1RqOddz094ZhVl8W31siO81WdPy+m+z/5HGl//p8U7pJtpCLomQKf+0MwIzOEaIwaTDx4juTQWo3dtj9UZnTl+VXlDmw9ocEfshZ6Z0HzOh3Rde88+RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=shDBuqZF; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="shDBuqZF"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso384750a91.3
        for <linux-input@vger.kernel.org>; Fri, 03 Jul 2026 22:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144678; x=1783749478; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mshEXDTZ0VEnwp2KN2nTQ9wDHI1nE7UH34EulSApwM8=;
        b=shDBuqZFQWZlRTJs1eE7cWb02YMjQvzompqmi71AcsJBme8DSNq19ilGV6jXGre+iC
         fHb8L+tGtMBngAg/b/ex7aGG5MP2/mQnvA+TLlrwSNRTPZ+Y/d38ViASl8ekNCo0pTHL
         N2ymjjpFNQZwQnnHnQ+GS/SH3/XK4iYYsGofOyTBsyTgM+K3brgCXr/g36mvyo3tAwq5
         z6aTeaOuQfhl0gd23pHvYILLbjyA9WUf51zHoxA+EQnhGF6j38DAwjUqB0lcjxKtoiPb
         VpUdrM9ENGnei8XkEMFuXHBXfXUXgYqW4XkhEfbXYdCMBvno9ruKXILQyExophlDB2GK
         UUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144678; x=1783749478;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mshEXDTZ0VEnwp2KN2nTQ9wDHI1nE7UH34EulSApwM8=;
        b=AtoVTL4caoiy2wAlGKhLpwBocD1l/Hu/zrsu3vNmULrPbZa0Sc90JFGlKR6SjH9NAA
         6KhgbBYK9OzNAP7bq2m9MbaGAAx+Hx253SWah+p4UMC7NX0cpK1VNiji9wgQQ1lDN/ha
         XsMCZc09jd+7M+wTplGlf/09vos8rFaiOkuthkc/4GMAeLkIIfoqGM0McYSx4zOHN4qB
         ZqrDe4CdAbqRyrFlgVpd3jLkEbixJ0E67Rs4EsEwm3JjjoJv1oIbL76IoDIEIjpRhYYS
         Ez44HqsheptLXz/OK7qIISxRgfYNDdKoeGZZUqKjOzY9fTsQEZafz4hc70EW8Mxmzm6l
         uarg==
X-Forwarded-Encrypted: i=1; AHgh+RqU/Ww4+Xf3o50uaRcJk79ifnRa5UjIMI0whOG98RQkCtT1ecgp55uXhlm1oHxzRYTUdEZs7yKXtryfcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYmre3xAeDybuo+A6rTbK5ruWxVvHKhgjO1VJwfIyvTB/jV99i
	NtMrlg9ZEZTKrT31woedGiRhn/MtgJOX4OXTlFBLMA+JjXIxqXrNEOxk
X-Gm-Gg: AfdE7cnNsUBKlbjVZa5cE05PQyJ9PKYtX7VLdnWFo9Fbb/sygeaJK9KIbEOdGgClkyw
	+bcw223evzjjzXTIt8HwIBR7F9PyFm8A+27eSYjUrnQUwnVG3VbRORbTdGn7WNV09qoaF/5JDrv
	zJIBAgl3KpihZcGChvm4hCKTcTlMMcQc9Jg32ux14CzkxopPwuTV137OhiL8Is2yMu2Xx6bMdld
	mI/7NhjL3VxHogHlVQv5EaOQQvop4/5eMIXJ/PLH8H1P2Xhc9S0g9/GP8MnIjIIXk9fnTMfUS7d
	tb68715oPqITtjVP1zeCvO9s1LxVUV3SWRMMRguFq7zRHC1Zb0BIiM6/J0cufQJ9vVpbEGDuopZ
	6D4cd5OnSSflm40bJ4ft6uBr3DgTF4oPorDQzqYaGdW/+/Li0P8OsP/XT1TWZQP2qw1AgCbj3xf
	W7ETPclYNUX26zA4dvqgq0nQUbM43oR9rNusyejlzfIy4htFKb7orrNnHbrYOt3BGraTr3V3Nmv
	c7JGoTnVLYnVg==
X-Received: by 2002:a17:90b:1c8c:b0:37f:9ce1:cda7 with SMTP id 98e67ed59e1d1-3829f9e9bb1mr2379238a91.29.1783144677755;
        Fri, 03 Jul 2026 22:57:57 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:57:57 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:38 -0700
Subject: [PATCH 15/26] sh: maple: remove not needed
 maple_unsupported_device driver
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-15-41e424964da5@gmail.com>
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

The maple_unsupported_device driver was used as a fallback driver
when no matching driver was found for a device, or for ports with no
devices. However, this is not needed as the driver core handles
devices without drivers.

Remove the no longer needed maple_unsupported_device driver and its
registration and update the shared interrupts (HW_EVENT_MAPLE_DMA and
HW_EVENT_VSYNC) to use &maple_bus as their dev_id instead of
&maple_unsupported_device.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/sh/maple/maple.c | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
index 5585f220e495..35aff2e57d2c 100644
--- a/drivers/sh/maple/maple.c
+++ b/drivers/sh/maple/maple.c
@@ -43,7 +43,6 @@ static LIST_HEAD(maple_sentq);
 /* mutex to protect queue of waiting packets */
 static DEFINE_MUTEX(maple_wlist_lock);
 
-static struct maple_driver maple_unsupported_device;
 static struct device maple_bus;
 static int subdevice_map[MAPLE_PORTS];
 static unsigned long *maple_sendbuf, *maple_sendptr, *maple_lastptr;
@@ -368,7 +367,6 @@ static void maple_attach_driver(struct maple_device *mdev)
 	if (function > 0x200) {
 		/* Do this silently - as not a real device */
 		function = 0;
-		mdev->driver = &maple_unsupported_device;
 		dev_set_name(&mdev->dev, "%d:0.port", mdev->port);
 	} else {
 		matched =
@@ -378,7 +376,6 @@ static void maple_attach_driver(struct maple_device *mdev)
 		if (matched == 0) {
 			/* Driver does not exist yet */
 			dev_info(&mdev->dev, "no driver found\n");
-			mdev->driver = &maple_unsupported_device;
 		}
 		dev_set_name(&mdev->dev, "%d:0%d.%lX", mdev->port,
 			     mdev->unit, function);
@@ -727,13 +724,13 @@ static irqreturn_t maple_vblank_interrupt(int irq, void *dev_id)
 static int maple_set_dma_interrupt_handler(void)
 {
 	return request_irq(HW_EVENT_MAPLE_DMA, maple_dma_interrupt,
-		IRQF_SHARED, "maple bus DMA", &maple_unsupported_device);
+		IRQF_SHARED, "maple bus DMA", &maple_bus);
 }
 
 static int maple_set_vblank_interrupt_handler(void)
 {
 	return request_irq(HW_EVENT_VSYNC, maple_vblank_interrupt,
-		IRQF_SHARED, "maple bus VBLANK", &maple_unsupported_device);
+		IRQF_SHARED, "maple bus VBLANK", &maple_bus);
 }
 
 static int maple_get_dma_buffer(void)
@@ -765,12 +762,6 @@ static void maple_bus_release(struct device *dev)
 {
 }
 
-static struct maple_driver maple_unsupported_device = {
-	.drv = {
-		.name = "maple_unsupported_device",
-		.bus = &maple_bus_type,
-	},
-};
 /*
  * maple_bus_type - core maple bus structure
  */
@@ -799,15 +790,12 @@ static int __init maple_bus_init(void)
 	if (retval)
 		goto cleanup_device;
 
-	retval = driver_register(&maple_unsupported_device.drv);
-	if (retval)
-		goto cleanup_bus;
 
 	/* allocate memory for maple bus dma */
 	retval = maple_get_dma_buffer();
 	if (retval) {
 		dev_err(&maple_bus, "failed to allocate DMA buffers\n");
-		goto cleanup_basic;
+		goto cleanup_bus;
 	}
 
 	/* set up DMA interrupt handler */
@@ -863,17 +851,14 @@ static int __init maple_bus_init(void)
 	kmem_cache_destroy(maple_queue_cache);
 
 cleanup_bothirqs:
-	free_irq(HW_EVENT_VSYNC, 0);
+	free_irq(HW_EVENT_VSYNC, &maple_bus);
 
 cleanup_irq:
-	free_irq(HW_EVENT_MAPLE_DMA, 0);
+	free_irq(HW_EVENT_MAPLE_DMA, &maple_bus);
 
 cleanup_dma:
 	free_pages((unsigned long) maple_sendbuf, MAPLE_DMA_PAGES);
 
-cleanup_basic:
-	driver_unregister(&maple_unsupported_device.drv);
-
 cleanup_bus:
 	bus_unregister(&maple_bus_type);
 

-- 
2.55.0.rc0.799.gd6f94ed593-goog

