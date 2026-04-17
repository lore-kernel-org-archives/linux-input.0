Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2897E33DEE1
	for <linux-input@vger.kernel.org>; Fri, 17 Apr 2026 07:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776409900; cv=none; b=Y+WCm6JRUreWH1lwSdxBmDuq/cMAwIWR0RcW+OV8QwV2B3X6YIz4x7SSQoQNMYhQH0INbrlRNpxY7b9/VNjmV7Ua4eCiewGMql393rNrkaz3QTOdpBDoL79rr3x7pGQLdk1+GbLgAJ+qG81CDjj9wApAsjU2kSCmRjcixUyJx+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776409900; c=relaxed/simple;
	bh=w1dOcGnTI59GCQNhwQP6xzsT4wAulf/UcemmHchCPqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UVoCh0kvheDd82lwD68EaTQ/me8NA5r+vl9CW+6JS3LNDB6IXlR8AAvAmMcSCvnTfuKeKiBlZpWsejqMFJh1GOC2ciSwFRrcmNrz+B/YaabHuq0ElY+kd/tkMezMpgKueDitqR/yRuHaWADbIT8ToBF0L7uu4cLQEHqv2X5xml4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nx59QLGq; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nx59QLGq"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59e4989dacdso440629e87.1
        for <linux-input@vger.kernel.org>; Fri, 17 Apr 2026 00:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776409897; x=1777014697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53/v+YSG+6GYj3ywOiaHOLUwr98tdqBSh9I2cLizLtg=;
        b=nx59QLGqRdFNthD1mnE3RNMKRvroHkt6LzXdRtQ66iep7MPMt9QRL/kLcjsoPUMEkb
         p0liOyiv6YBsNq2WbZ5AOflM+SjfsqUGmi04rGPTA1JjXir8a7IQgkHeSMQfpdAnvmTi
         3n1ODV3xNeraRTCDokN3JJ39Yrnn63PptsZlLYkRKrbIHIg4ij3VN3Zx4V4o+Cr3mHNH
         9KtojXD7hqu5HE3gtPABGu7j6r6K+oLuKPSqKCTVISJ4kQOmYh+Fu3DvQ4fh6Qz57znE
         qy1tJHku+njHmyrMo2u6bI7+seJUWnciaDHOuQMt831ElD8DdsLSL32V2jAqQiuep4ra
         Ek+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776409897; x=1777014697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=53/v+YSG+6GYj3ywOiaHOLUwr98tdqBSh9I2cLizLtg=;
        b=sgjKM3pGlQWahTWWl4Lhve326/HbQJ+xJAIVTRlGGwlNq/H2SSAL217l90gYmY5QnH
         2WW0erHh0/6heJ3CwZY6dxfiOA0m6T6pJPoXpyDCn6M1lAgz1Hx329mMLihV43k+OSP7
         6k2QPAqSDIbl64Dw26Xk/Tfu5Ur4uaLnkkYN+5m6S1dA3Z4xvkanvUAYlsJGompV972J
         cW3Zal0A7zu10aaLqoOLGpAo6HcbiR1ozeiolGGJ27z5BiCLHoVDOU4vrL6lQjIGxgz0
         VmriXCRPz3iPo8+pxwX6P0NIQtfyeo6x3mpE40QvjmnWsSYSb7O8GuBpezteyfl+74jt
         /9yg==
X-Gm-Message-State: AOJu0YwtXN57QARbYt2X7OpbHIwdjeuhveyjSovVX21iCq0liJ/UERum
	x23IQnrcA1JGplkE8KjA/aXyiRxyxzqWkyZcl13hZFFfGvRnVlNmGQpJ
X-Gm-Gg: AeBDieuhRnqsgQONerw2HpJWJp7WwsQpEg2Wo1I2fO2HRLk/pT49Qp0gFVyxl7JnetR
	h0SK0ywApIx872Cm62JJNcg5Hoes/vyKRiY+YPwOD6hDrGR/xsa/nPxFguU7V18WbTpbyTvEDXA
	vfLP8plP+c2tEe4RHKijbBmKVFM7fCAR8EJr13/SDcuShLH11IJlHEigndij9qrPk6LiLWMQX0T
	FVVA/YItZI7ehqIelA90hTnUsFG/WgM2ufEFcNZTk/u2aG2FlfEP+o/IeQsiW67sKMTklkBnTX3
	lkPv79XTN2a1D8N4D2AqrPWh7XFr4fB9qdM6je45yIV+2lB8xghw4FVc/ie9lwngAy9OzxU3nQ7
	ELEgIbiL7mLkbd5569LWQRA4HfnDxEM7Pt8GPTxMVo6IV3WhY1Ra8H7q0nHiwrhpcupCaa0KYMI
	yllY3ve5yz6yVxq8PU36KT7TYOb0Oil+5Rvg==
X-Received: by 2002:a05:6512:1242:b0:5a4:640:9f07 with SMTP id 2adb3069b0e04-5a4172e7b8bmr511770e87.31.1776409897215;
        Fri, 17 Apr 2026 00:11:37 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4185bc240sm162772e87.23.2026.04.17.00.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 00:11:36 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Tony Lindgren <tony@atomide.com>
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v4 6/6] mfd: motorola-cpcap: add support for Mot CPCAP composition
Date: Fri, 17 Apr 2026 10:11:06 +0300
Message-ID: <20260417071106.21984-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260417071106.21984-1-clamor95@gmail.com>
References: <20260417071106.21984-1-clamor95@gmail.com>
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
 drivers/mfd/motorola-cpcap.c | 50 ++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
index 516d1e33affa..fdec92f5c6b0 100644
--- a/drivers/mfd/motorola-cpcap.c
+++ b/drivers/mfd/motorola-cpcap.c
@@ -335,6 +335,54 @@ static const struct cpcap_chip_data cpcap_mapphone_data = {
 	.num_devices = ARRAY_SIZE(cpcap_mapphone_mfd_devices),
 };
 
+/*
+ * The Mot board features a USB-PHY and charger similar to the ones in
+ * Mapphone; however, because Mot is based on Tegra20, it is incompatible
+ * with the existing implementation, which is tightly interconnected with
+ * the OMAP USB PHY.
+ */
+static const struct mfd_cell cpcap_mot_mfd_devices[] = {
+	{
+		.name          = "cpcap_adc",
+		.of_compatible = "motorola,mot-cpcap-adc",
+	}, {
+		.name          = "cpcap_battery",
+		.of_compatible = "motorola,cpcap-battery",
+	}, {
+		.name          = "cpcap-regulator",
+		.of_compatible = "motorola,mot-cpcap-regulator",
+	}, {
+		.name          = "cpcap-rtc",
+		.of_compatible = "motorola,cpcap-rtc",
+	}, {
+		.name          = "cpcap-pwrbutton",
+		.of_compatible = "motorola,cpcap-pwrbutton",
+	}, {
+		.name          = "cpcap-led",
+		.id            = 0,
+		.of_compatible = "motorola,cpcap-led-red",
+	}, {
+		.name          = "cpcap-led",
+		.id            = 1,
+		.of_compatible = "motorola,cpcap-led-green",
+	}, {
+		.name          = "cpcap-led",
+		.id            = 2,
+		.of_compatible = "motorola,cpcap-led-blue",
+	}, {
+		.name          = "cpcap-led",
+		.id            = 3,
+		.of_compatible = "motorola,cpcap-led-adl",
+	}, {
+		.name          = "cpcap-codec",
+	},
+};
+
+static const struct cpcap_chip_data cpcap_mot_data = {
+	.mfd_devices = cpcap_mot_mfd_devices,
+	.num_devices = ARRAY_SIZE(cpcap_mot_mfd_devices),
+};
+
 static int cpcap_probe(struct spi_device *spi)
 {
 	struct cpcap_ddata *cpcap;
@@ -389,6 +437,7 @@ static int cpcap_probe(struct spi_device *spi)
 static const struct of_device_id cpcap_of_match[] = {
 	{ .compatible = "motorola,cpcap", .data = &cpcap_default_data },
 	{ .compatible = "motorola,mapphone-cpcap", .data = &cpcap_mapphone_data	},
+	{ .compatible = "motorola,mot-cpcap", .data = &cpcap_mot_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, cpcap_of_match);
@@ -396,6 +445,7 @@ MODULE_DEVICE_TABLE(of, cpcap_of_match);
 static const struct spi_device_id cpcap_spi_ids[] = {
 	{ .name = "cpcap", .driver_data = (kernel_ulong_t)&cpcap_default_data },
 	{ .name = "mapphone-cpcap", .driver_data = (kernel_ulong_t)&cpcap_mapphone_data },
+	{ .name = "mot-cpcap", .driver_data = (kernel_ulong_t)&cpcap_mot_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(spi, cpcap_spi_ids);
-- 
2.51.0

