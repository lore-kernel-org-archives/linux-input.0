Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357133019D9
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 05:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783749181; cv=none; b=REnc2WQ6+ql2VXDaZUkY+frscreBgWqda1cswObvwe6E8il60lpYYEiNnFXqHAF4igpasQ22RhUD2uLe9SjkLjRft2ILjyNnkNk6sQsgFv1S5X53/OdmOoxK/0/0jxPLoG+7NV3PkVF7xkFE6ENpyBHH6fK08q837YhlLb96h0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783749181; c=relaxed/simple;
	bh=Aa8KFCxdXBWMQUbn68y6G2KRIT+gUSN1LDah6Ckw9LI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TpPemt5Y3yyhnEATczURCwBW0MzeiSzML+FWXbC9tb7C+9fy7fCaNAkYKms2lqZgSicgA1sIqJ2x7o892hBS2iMabJY9BMj/lAAZAcwr7/em9rYu7ofN8cIcGf79KFLajGyTHi3LU7lYKh1/GO42eo1sU0c119K6ZFDuGxx+Kjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-848643382fcso1608930b3a.1
        for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 22:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783749179; x=1784353979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WqMDDgVvs8rEZ8j+IjLB6O1vXNqeXixwW35hhGBVOZk=;
        b=c4UGo0iv3yh9EQLCS2/cUkzn6Axn0v6phQ11qGlbsXVrfbOCmGFAjyNzvKBtQ1ylKV
         ShC0aWKJTv+WmFxZYFeNQYkfxZmRXNOfJOyj20bfsmUZiSSZ9h/iTY+O3dhHg4bz6ivl
         ewN8+uRLtrMKJFazon/jI4DR6xOS+Unccl5NlRox+OrGh0Z1j0pcsEK+0jsF1qM6k03B
         KzhLCPk8bS3asDpV5Z3nMfvBDWreDvvI6nyZuvqoBW2mugWSoTr1ei7xUw3CWGGkppjc
         7VllBpKVPwf4GcmfszrVP9++m4U4D2iIfZ7KRMHBHY5th4DHs3L3QQ3GrM+YQmmbduQ9
         c4Lg==
X-Gm-Message-State: AOJu0YyjmEbyzLp5QbqDbj62eYVJtjZ5C0qy2qVz0MjitT+MfoyJHJfx
	Lu2IZ+V1lsUffEg8Bv25K0QLCHqQ3O9Af2afn9+pXo2xBOQw9LJdRzQAnzcLutN1EVNR
X-Gm-Gg: AfdE7cmEPW0eqg7DNV7vSciz7x2s/ORL9kkAHR8pmdiuYggWn8qZ11Q8z9mrT6Rsozb
	LmpL+MwWkjjQJIrdOvmWJNPKXSCs4EsdNjASwpLdVOBNL5SKPSuIHlqodlY+cPXwNmXuqEKcrMe
	lVB/ibCpjNCJtTVtLVxAyhOg9f0cPHsF1FP0obRnri1x+xZS6qVm3OBH3m7J2AlG0NipGPtXhQe
	XxivXiqDQgeUOPwTJsRLA/K2XNwhjns+b5nULyVFD71Axo8joQVsosMP/DXH+4koZt1Yu0T4vry
	fS/0zcFD/j+Wx+udsQVTXgwfxtlgQuNQr3LU/PIC/x6yDK5cJGPIdXcBdtIeLAvuQS/XymQjuQF
	PA9E2JyjODLJUdg1zgPXWGlagemMCRh66/i71iloed/iyDTibZ2JUttkL1D+GTRv91/K5zHqEpR
	TYS0VXyBKCTijfqL6LtJOOIRN0iYoSIH75Y2DNoEP35HqPVvdmASANFeCoxvqu7ZVovHmv72rpc
	Ci/1/QyXb6qg3Se8YNw80EEQA==
X-Received: by 2002:a05:6a00:1406:b0:848:30fe:da3b with SMTP id d2e1a72fcca58-8488972215bmr1768883b3a.40.1783749179489;
        Fri, 10 Jul 2026 22:52:59 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-52-13.dynamic-ip.hinet.net. [61.228.52.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8484123ce87sm5360084b3a.58.2026.07.10.22.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 22:52:59 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH 1/1] Input: applespi - force PIO mode on MacBook8,1
Date: Sat, 11 Jul 2026 13:52:47 +0800
Message-Id: <20260711055247.5412-2-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260711055247.5412-1-fourdollars@debian.org>
References: <20260711055247.5412-1-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On MacBook8,1 (early 2015 12" MacBook), the LPSS SPI controller's DMA
handshake and interrupt routing frequently fail or time out after warm
reboots, causing the keyboard and trackpad to become unresponsive and
spamming "SPI transfer timed out" (-110) errors to dmesg.

Address this by introducing a DMI quirk inside the probe function that
detects the MacBook8,1 model and overrides the controller's can_dma
callback to a custom helper that always returns false. This forces the
host controller to fall back to the rock-solid PIO mode.

This is a self-contained device quirk that completely solves the DMA
race condition on MacBook8,1 systems without impacting other MacBooks or
generic Intel platforms.

Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/input/keyboard/applespi.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index b5ff71cd5a70..edf81e383612 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -45,6 +45,7 @@
 #include <linux/crc16.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
+#include <linux/dmi.h>
 #include <linux/efi.h>
 #include <linux/input.h>
 #include <linux/input/mt.h>
@@ -1605,6 +1606,13 @@ static void applespi_save_bl_level(struct applespi_data *applespi,
 			 "Error saving backlight level to EFI vars: 0x%lx\n", sts);
 }
 
+static bool applespi_can_not_dma(struct spi_controller *controller,
+				 struct spi_device *spi,
+				 struct spi_transfer *xfer)
+{
+	return false;
+}
+
 static int applespi_probe(struct spi_device *spi)
 {
 	struct applespi_data *applespi;
@@ -1613,6 +1621,15 @@ static int applespi_probe(struct spi_device *spi)
 	int sts, i;
 	unsigned long long gpe, usb_status;
 
+	/*
+	 * MacBook8,1's SPI host controller DMA is broken (timeout errors).
+	 * Force PIO mode by overriding the controller's can_dma callback.
+	 */
+	if (dmi_match(DMI_PRODUCT_NAME, "MacBook8,1")) {
+		dev_info(&spi->dev, "Disabling DMA for MacBook8,1 SPI to force PIO mode\n");
+		spi->controller->can_dma = applespi_can_not_dma;
+	}
+
 	/* check if the USB interface is present and enabled already */
 	acpi_sts = acpi_evaluate_integer(spi_handle, "UIST", NULL, &usb_status);
 	if (ACPI_SUCCESS(acpi_sts) && usb_status) {
-- 
2.39.5

