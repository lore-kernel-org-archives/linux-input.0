Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C0F34CFC8
	for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 06:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771828762; cv=none; b=vGE3EbmTKt1hDd0Q0Jo30fKfN/GPQAKpjyWKPoxRl2ClxZqjlyoPmSJKNDIDSO7KZSNJgVzasYYGNj9isQWLR0UE3fNhwnY08cnNNQShFoLvnL2/iIxrLCz5RBzYA/6P9cxhX+P4tTFNLBRs1l7d6VPetxHloafmKUYyrBwUCgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771828762; c=relaxed/simple;
	bh=w1dOcGnTI59GCQNhwQP6xzsT4wAulf/UcemmHchCPqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nb3rF6Ofoy3lbgZ9wg0bma4R/V2mwtcpjaSArBeMy6EE8pyHI1vr+klfnorlYCFwNGumDUaURaympG3GnDgfkHDkANsRU/ezSmALEIgmNRADJAC9IaO2+2G4a4YuxuRXxxAXj3/b2rLlal9V7XCgE9Ky3XakehUGXN/ZRT4syzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0ibKSP0; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0ibKSP0"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59e57973dbfso3915172e87.1
        for <linux-input@vger.kernel.org>; Sun, 22 Feb 2026 22:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771828759; x=1772433559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53/v+YSG+6GYj3ywOiaHOLUwr98tdqBSh9I2cLizLtg=;
        b=f0ibKSP0dwzXK+4RfhsT8IpnMocD9TxUq6oA+aGb1zhapqZ6janqOw6DQ9JSWCtAGn
         q5nVGDfpwa8FefRE+L1/yzP6L9WF9AEhibRLwQOsYjfA9ADLi4s9MxNk+4i+hRikZzsw
         AP02+DJTOjIDI6CrZkAptFidveeusuj3hkVK+XzKHg7BIYnemYZCEvN+EPHm8m7nVp9I
         UUONbwGQM9qiSbCxPwfUF1IQwylO2kX4Hc3KaNM7AVgTBVEAIybsTYkvmCOxLjCz96QM
         RiBhcmvW1swEvOrhKCInRzB0mo8L07RD2vmnjLHC83fs5HaAy7RWATQnknKy/8fpIP7v
         ef/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771828759; x=1772433559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=53/v+YSG+6GYj3ywOiaHOLUwr98tdqBSh9I2cLizLtg=;
        b=cwsILssuz0DxVc+UoDy69V8DsokG0gNoWyyyR+ofc28pF6AmHY1hJcs3WFatl3NpkE
         2M0VD8salE8V7punD55lrFOJ/UjKumDWkF/GgrGRuuYD7AdNZleviLZpM9SZnsQlzsvU
         XH/T6+ngQenEvXqmot2YXwriJM5QhLdxCnwiCi3ksMdGi8iaBEIu+3KbGl0XzKoI8Q6Z
         v1rOclZr3ZxzRTGFu0bzg/EzrqKPIHie45xCKWvqNz3JKGVu1Uii2G6hwcO3lVNdAV3i
         Bq9QAsEN5gtmyCO009NQqc6OhJAUTL0cKlFPAVoBnGHTlZCJ6tnnAmwjFE04XWwxa4Eu
         aTSw==
X-Gm-Message-State: AOJu0YxksE1ljU9u74qh2ctWyfz4loR/1BZyEOF21QQF3z9LW/GZINjS
	9n6+JvOr6gUslVMVTwALvz6FSdsG4TwdQbkaweg7kEOz0kyo6/nyTFrd
X-Gm-Gg: AZuq6aKBjEY+IVNm8ba1mEIQutLHX/iQmLtYNGebv4aPKqtkNJ+N/6jBp8JZusFmYp5
	74qFyIe4snKE+X8aJ8jKiHBZ0oqfEJ7iYPocsZAIojw4p4ZEOwH0W+ZKTWv0oW6tGUK/alVrq9G
	drx7aYGuh0EYpeQcKS+roXm8XKHCaKzz+Y7sUfOQEx64ksmB+qOYDanImYaAHoBNbVUx/J+vKH7
	uSpzKOGuP4kqYjBWDrHhMtNt+92o22uhiRrlgrJO6nHWR1GEJPrNi4lxKLq93w1UcySRDu9E+4r
	Mn8vyo/uSzZlDtNRo6Io6niIea9M3jFHNPCUXFeydlhEaAJXTWGdszhwGCU+QyrjO4WdvvaMyXj
	ni/HZFVUvO4xiD/8ooD0g693VPzC+vAeCTpm9tf/KLCCbeS1qoY8klK2y88Yi6qsGcDyeryzrkN
	jSuuUM1ewP4lii
X-Received: by 2002:ac2:5bc3:0:b0:59f:6efc:2846 with SMTP id 2adb3069b0e04-59f8abe42admr3218285e87.7.1771828759209;
        Sun, 22 Feb 2026 22:39:19 -0800 (PST)
Received: from xeon ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a0eeb13abbsm1369626e87.23.2026.02.22.22.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 22:39:18 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Tony Lindgren <tony@atomide.com>
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v3 9/9] mfd: motorola-cpcap: add support for Mot CPCAP composition
Date: Mon, 23 Feb 2026 08:38:58 +0200
Message-ID: <20260223063858.12208-10-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260223063858.12208-1-clamor95@gmail.com>
References: <20260223063858.12208-1-clamor95@gmail.com>
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

