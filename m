Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4153803D3
	for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 08:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782375513; cv=none; b=F+VrJIC5m8X2qTm4MZ//qp1enka3985iqxZlYJ1nHM5B4Qosf16Rg5NiaMfEtxhulOn/S1Jx4TC4KL+m1CjGAo9MvMFj1iDzoFq59eKFXoTMmyezoa4rBaZeGJwclKFsAP7ata/iL6TBoBGSYP5X2S9G4qP9SJgu9Nw904P39z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782375513; c=relaxed/simple;
	bh=OyZE0FTSId5Xw2BLHh/qgzyUvjlvhM+aMzq4+ikPxSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJaTgVHKptYgRPYheLbHWLbpXS3SSvNNZcAO93PhocE5J3n1Ha3PSyAQlBomx/kBl1puaKgiv3jfIepFb+0KKcdMnowfgU/jSRx7rbevbCXa6WJKttMRtB8Fpg5Vz9jSq6BGeXk8W/9Qga9c15scZ0O7s1kGsYl7YqXqjGVJqbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6rRndYC; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6rRndYC"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aea1f4dc7fso405930e87.0
        for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 01:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782375509; x=1782980309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vaU/m8RkZFKacQOirk2OKWVZO3CMn2gzTIkZTYwhda4=;
        b=V6rRndYCXyW5mqpGV2zcIkMMiwML0ud0oGJ2yxIecM/2E5LAVya2VMz57fjTtJKDnp
         xCmI2l/Zb//TrG2ltyqdRw1wZQnKswFsrUw3eqUKLT4f0MAH7POD/K/5a7RVz3Wg4gV0
         UhtPpyU3s4LNYTAalIU2W8aUZPwKknWAreSQidDLzPlwHnwduopFDyDIz8CIVMA5iIgN
         A10AFWYvXORZU23wQY9hlspotSiB6AGCckDf76TwcUtbe+nK/w9XjpJXUEkfXI3s0kXY
         bG+5gM7Db+D6wTsUirJmfkWBxn1Y6q1kUH/ddenrNzRn8bRZmspQbQVeMUMOH9sYKkbE
         1q4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782375509; x=1782980309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vaU/m8RkZFKacQOirk2OKWVZO3CMn2gzTIkZTYwhda4=;
        b=CmumqBrCgMnKri/cYfnHqAAgh2W20CXWIYJ1U0HiGoE40/R3KmxvqcWkXttuTHDd55
         +X694i7DrAqzlQoH9EoAdDzvxZ6ZOzBJsAxwgAK8cB+h2875JJr9nJTb64eKW0qf8Pek
         liNlB3oEPhXLwqzWFTJfWCgy+V/04L+vTcjk2DGkq8n4YFRNHYr28kuBcr7eCi+6oe93
         NjVuSFTQrVBOSjJLTHVyden71A4baTrqrRVtQ8H3LVcat3R7pygf3H34kErk2b/Z7n3p
         G4SzIz924whl4UT/3xkgg4EVfWTTxmAxCyr2mEufzECH71k0EB9GabuuZg2sLvhOlGB0
         JG4A==
X-Gm-Message-State: AOJu0Yy/Gx6tjndwWFXX4EBR2uwZAVlTPRTZh9k6aPjSm6i/n/pEvGlm
	q8Iwox3QSnBGwaNjyF8+gNPTula1QjmJph1jteswb8bdWeug34h2G17s
X-Gm-Gg: AfdE7clvrriDxtesQD5F5N6YrEVKSr47f4LLl8j0SApGd/6qyArH0G+YLsgzukkeC85
	UEbH+YpKuoOSbwh7hT+bfQW9lq8X4tQIi8jhhiNWQTwNFFq+fn26PIQxwx1FrSY8vwpjbc9IhVQ
	OJApbfwBciHiEOgf/jZoXwoC1MZV+RWKUnpNa88MfvaNWRNJzYtpw2ElxFjDdqkq+79KdUvLghf
	vMEMFG6h0M51ZcZkXjEVhSiFmTX55llFn2aRBKjKYgmQZ4nXgOwNj9di1gqZVjZb+8xabSUt5AT
	jK0cyaC0XXvqcoBBPXQpTy2HutdjiNdMNGOASt635lJ9ev06IBBnkg6uxhHkYw22Qk15Dl4JcXC
	JW27PbqpQxs2MGXgB0ujg6WL1lRdIX210ZpouTbGYfMl0Fi1xMJtaXTY9fqmpW/rIAxyvrFyfm0
	sLnQ5PX+3ns7EiXJHtFpWqk/35fM/pwt6/Jg==
X-Received: by 2002:a05:6512:2c04:b0:5ad:5c4a:81f5 with SMTP id 2adb3069b0e04-5ad695973bamr2920421e87.10.1782375509296;
        Thu, 25 Jun 2026 01:18:29 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad6957a268sm2464601e87.38.2026.06.25.01.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 01:18:28 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v6 6/6 RESEND] mfd: motorola-cpcap: add support for Mot CPCAP composition
Date: Thu, 25 Jun 2026 11:18:12 +0300
Message-ID: <20260625081812.33474-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625081812.33474-1-clamor95@gmail.com>
References: <20260625081812.33474-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a MFD subdevice composition used in Tegra20 based Mot board
(Motorola Atrix 4G and Droid X2).

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/motorola-cpcap.c       | 20 +++++++++++++++++++-
 include/linux/mfd/motorola-cpcap.h |  1 +
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
index 5b6ca6b81c23..f6198276d266 100644
--- a/drivers/mfd/motorola-cpcap.c
+++ b/drivers/mfd/motorola-cpcap.c
@@ -237,7 +237,6 @@ static const struct mfd_cell cpcap_common_devices[] = {
 	MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 1, "motorola,cpcap-led-green"),
 	MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 2, "motorola,cpcap-led-blue"),
 	MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 3, "motorola,cpcap-led-adl"),
-	MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 4, "motorola,cpcap-led-cp"),
 	MFD_CELL_NAME("cpcap-codec"),
 };
 
@@ -245,6 +244,7 @@ static const struct mfd_cell cpcap_default_devices[] = {
 	MFD_CELL_OF("cpcap_adc", NULL, NULL, 0, 0, "motorola,cpcap-adc"),
 	MFD_CELL_OF("cpcap-regulator", NULL, NULL, 0, 0, "motorola,cpcap-regulator"),
 	MFD_CELL_OF("cpcap-usb-phy", NULL, NULL, 0, 0, "motorola,cpcap-usb-phy"),
+	MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 4, "motorola,cpcap-led-cp"),
 };
 
 static const struct mfd_cell cpcap_mapphone_devices[] = {
@@ -252,6 +252,18 @@ static const struct mfd_cell cpcap_mapphone_devices[] = {
 	MFD_CELL_OF("cpcap-charger", NULL, NULL, 0, 0, "motorola,mapphone-cpcap-charger"),
 	MFD_CELL_OF("cpcap-regulator", NULL, NULL, 0, 0, "motorola,mapphone-cpcap-regulator"),
 	MFD_CELL_OF("cpcap-usb-phy", NULL, NULL, 0, 0, "motorola,mapphone-cpcap-usb-phy"),
+	MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 4, "motorola,cpcap-led-cp"),
+};
+
+/*
+ * The Mot board features a USB-PHY and charger similar to the ones in
+ * Mapphone; however, because Mot is based on Tegra20, it is incompatible
+ * with the existing implementation, which is tightly interconnected with
+ * the OMAP USB PHY.
+ */
+static const struct mfd_cell cpcap_mot_devices[] = {
+	MFD_CELL_OF("cpcap_adc", NULL, NULL, 0, 0, "motorola,mot-cpcap-adc"),
+	MFD_CELL_OF("cpcap-regulator", NULL, NULL, 0, 0, "motorola,mot-cpcap-regulator"),
 };
 
 static int cpcap_probe(struct spi_device *spi)
@@ -276,6 +288,10 @@ static int cpcap_probe(struct spi_device *spi)
 		cells = cpcap_mapphone_devices;
 		num_cells = ARRAY_SIZE(cpcap_mapphone_devices);
 		break;
+	case CPCAP_MOT:
+		cells = cpcap_mot_devices;
+		num_cells = ARRAY_SIZE(cpcap_mot_devices);
+		break;
 	default:
 		return dev_err_probe(&spi->dev, -ENODEV,
 				     "Unknown device %d\n", cpcap->variant);
@@ -327,6 +343,7 @@ static int cpcap_probe(struct spi_device *spi)
 static const struct of_device_id cpcap_of_match[] = {
 	{ .compatible = "motorola,cpcap", .data = (void *)CPCAP_DEFAULT },
 	{ .compatible = "motorola,mapphone-cpcap", .data = (void *)CPCAP_MAPPHONE },
+	{ .compatible = "motorola,mot-cpcap", .data = (void *)CPCAP_MOT },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, cpcap_of_match);
@@ -334,6 +351,7 @@ MODULE_DEVICE_TABLE(of, cpcap_of_match);
 static const struct spi_device_id cpcap_spi_ids[] = {
 	{ "cpcap", CPCAP_DEFAULT },
 	{ "mapphone-cpcap", CPCAP_MAPPHONE },
+	{ "mot-cpcap", CPCAP_MOT },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(spi, cpcap_spi_ids);
diff --git a/include/linux/mfd/motorola-cpcap.h b/include/linux/mfd/motorola-cpcap.h
index 1a85b06272c8..bb23363eeccd 100644
--- a/include/linux/mfd/motorola-cpcap.h
+++ b/include/linux/mfd/motorola-cpcap.h
@@ -28,6 +28,7 @@
 enum cpcap_variant {
 	CPCAP_DEFAULT = 1,
 	CPCAP_MAPPHONE,
+	CPCAP_MOT,
 	CPCAP_MAX
 };
 
-- 
2.51.0

