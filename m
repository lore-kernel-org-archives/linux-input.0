Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5FE31A045
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 06:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783752884; cv=none; b=uHANX4ZzVOXYWkOoxEjV8uY3or6F7Ud3xna3GrPvpNv3cXTl8DQHXHlvzLN6p1mNT6LsrbiSKI1mp4cS9317ZCj3/3cCZvZMPm+TBt8WUgvACAmvFmqd1uMH2Eh7Bk5/Lo45gB94ZeHKU/DUw2x74ywj15hTsLwCpV70kFYh868=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783752884; c=relaxed/simple;
	bh=r8zVy/hy4V0/8I+I9cgXPbXLAFAu3TqXTM7jHRDzT5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mzS8tCRN/gBfN62BoyJ3lFjQ4f7stY1w1ju5ZNP90SIFHiCezB4XyqYSyl2BdGd4zj86YmlNHpGGvxL9HjAcq0kP2sFFxN6PQjcG91NKI4lzianXLbALk4/d228OEk9AiixihCUKVg8bPCAyyYETNOiKrkLtQIKh8z9SXRAjV6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cacf197759so23532105ad.2
        for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 23:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783752882; x=1784357682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LnDtSBfU0+MIPTjDEiJMV7jjCz5ET5nDw4xwWOKlpbE=;
        b=NLrUoKSi4EKuiAJJoKM7a388Z8SCbUz3TsnHOkF6U6FhREmTTVoZ4z5xoe36HucaS3
         BkHaNAcR1VjlTb8N9o1TMSZrXJ5+rZSajHnHT3KO95q9EwyG3znwB8hy1wI1fqJUAA/H
         dH7A6zZqsNBYP2SpTcQpNJucbE0YD8xkY/ue8EU65occQD7q8zZuc6tvXgMJjrfs5rkW
         cXpR14Iu+OBUm69w1riTZySOIhFVdvbhWDCghMxXweNVdVpj/G9dhrm5YEeHhYiZBODK
         r30VhZuE8Pa1VBEZkWQkTwI+wNM5LZQ/JWwdfR8v06t7Ptx+9AYYmo38TdD1b9+CxbcG
         lQ+g==
X-Gm-Message-State: AOJu0Yz5EuOdSkSEMYIlFZffhKlpwu7teRD14QwrIVXUjbasPhw+XjQR
	k++RAefi/ZsWzN4t1VI/Y79F4UuDdXC5aN0fIH1kvJpYzN1LMY4vHTh+GhgYaKwroFZ9
X-Gm-Gg: AfdE7clgRd38tAKOqWCZbp6QmZOGDJSM5vNdZj6B5ZaF4wQrEvqbcNh5vs0SRqDgDmy
	qYjgI5HKCesbd0bZKFovudoBv6d83vOzEsr3S0+fTZvkeN3LI8xOAhgP9Y2mU4T9kK3KmwMtAzI
	GBZP3B/Fz97F1rCDWuRSLx32ivHoC3FWTDkB7gf+kXETDRwXX6+/+VLLBXGvv6w3uw4DN5O4cVr
	OGkWwizGPk/CnXKOcsI+WraCHnpnfY0fNqtS3ejJWdKZozqAVAVQ8iA9FtWMQ3rkVcRUr0EmEUa
	MwadB5ZOMmfE6hYbtPXYzFHAhm1pQhqTMOxSMJ0Kb2pUcJsSvQq0CLfyRpBgxmXaelLkvregdl+
	PFNThGgg2nu0WgI/RSOg1+r9Lux59h7dwFqAEUKj7fU+JTv60hgU81Wgmk59CM8RbxfDp23mtQW
	zLR+h1jQRVCdzkFceIGkc6goSwDr1ry6k5oDYqB7F56k3/zv3ICco+hTFvP8VQH6IpeBpPob6yv
	v83TjLitPZX4zGtj05RhDv4ty0gdBRAtGUS
X-Received: by 2002:a17:903:2f90:b0:2ca:4cfd:a6ea with SMTP id d9443c01a7336-2ce9e7b0335mr19692175ad.16.1783752882319;
        Fri, 10 Jul 2026 23:54:42 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-52-13.dynamic-ip.hinet.net. [61.228.52.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ce8f5183b9sm18272535ad.5.2026.07.10.23.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 23:54:41 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v2 1/3] Input: applespi - force PIO mode on MacBook8,1
Date: Sat, 11 Jul 2026 14:54:13 +0800
Message-Id: <20260711065415.7396-2-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260711065415.7396-1-fourdollars@debian.org>
References: <20260711055247.5412-1-fourdollars@debian.org>
 <20260711065415.7396-1-fourdollars@debian.org>
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

Since we overwrite the shared host controller's can_dma callback, save
the original callback pointer during probe and restore it in the unbind
(remove) path to prevent an execute-after-free vulnerability when the
applespi driver is unloaded.

Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/input/keyboard/applespi.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index b5ff71cd5a70..07a910cb8459 100644
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
@@ -431,6 +432,10 @@ struct applespi_data {
 	int				tp_dim_max_x;
 	int				tp_dim_min_y;
 	int				tp_dim_max_y;
+
+	bool				(*original_can_dma)(struct spi_controller *controller,
+							    struct spi_device *spi,
+							    struct spi_transfer *xfer);
 };
 
 static const unsigned char applespi_scancodes[] = {
@@ -1605,6 +1610,13 @@ static void applespi_save_bl_level(struct applespi_data *applespi,
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
@@ -1788,6 +1800,19 @@ static int applespi_probe(struct spi_device *spi)
 	debugfs_create_file("tp_dim", 0400, applespi->debugfs_root, applespi,
 			    &applespi_tp_dim_fops);
 
+	/*
+	 * MacBook8,1's SPI host controller DMA is broken (timeout errors).
+	 * Force PIO mode by overriding the controller's can_dma callback.
+	 *
+	 * Since we modify the shared controller's callback, we save the
+	 * original pointer and restore it in applespi_remove().
+	 */
+	applespi->original_can_dma = spi->controller->can_dma;
+	if (dmi_match(DMI_PRODUCT_NAME, "MacBook8,1")) {
+		dev_info(&spi->dev, "Disabling DMA for MacBook8,1 SPI to force PIO mode\n");
+		spi->controller->can_dma = applespi_can_not_dma;
+	}
+
 	return 0;
 }
 
@@ -1822,6 +1847,9 @@ static void applespi_remove(struct spi_device *spi)
 
 	applespi_drain_reads(applespi);
 
+	if (applespi->original_can_dma)
+		spi->controller->can_dma = applespi->original_can_dma;
+
 	debugfs_remove_recursive(applespi->debugfs_root);
 }
 
-- 
2.39.5

