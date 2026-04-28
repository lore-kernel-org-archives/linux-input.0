Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CD935A384
	for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 15:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777390605; cv=none; b=grIe9GRiNaCm+6xpYmMlCWTjMXFaeGd/QwHqcKq3Uob1ZFsPffuiF1v0+LnfhVvCwU8chqs9bfzxBPdwIkiVVK+v2Mo1EgCTVW35gknIR8Keer8mc/fFZaYc7iA2WXARw9ZEl0mcGfquUO7Vf444XIylfjgiHS8rdlon7duqwCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777390605; c=relaxed/simple;
	bh=w1dOcGnTI59GCQNhwQP6xzsT4wAulf/UcemmHchCPqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Di0uMZ1wy2N9Zze/xLtSwn0sjT/SbVdotUWPVWHs88qwDNDC0LnYKDL+JyHdOg/MiNFTtKxU7AaaSKsqKGyA2Q6nPmZXVSRKbZKXhPiB+Y4/89HbcEKdlpVo2v+rXg2IqxqMGee37jNRNR31H2ISNLPqbAqa3U/BPTbbURyRezs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3Q0+Ha3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3Q0+Ha3"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso120999405e9.1
        for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 08:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777390601; x=1777995401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53/v+YSG+6GYj3ywOiaHOLUwr98tdqBSh9I2cLizLtg=;
        b=C3Q0+Ha3niA+phA2/JO6CfVgc1Z+kbW/DmXN3FUc5Qch7M5fzGHyJ+DwXZf7qo6zcU
         Xudbu/FyVlr8RqaQYfJQpBtchVqDKSerH8tthnh/4qi1qN+CBE3/8yOZeUrEU0qVQSgS
         bu0N9t1a60RgDhr+Fh0MpaL3aMskjuq/bG4VUv5QHv0RwyeSIgDpFiNPRjwworGND5RT
         ixBEacwrdMKArQTg2ioFkkarciD/vyozMPjSF6QFw38Iz2HUmq0eyXXo14+oCy15qZXi
         9QMEPjlifBACQe1tXZitXLIX4Z6/aLhYg1vBpQ+lutnm1vhZvFQiu88pfDjamEQ2G/9Z
         KIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777390601; x=1777995401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=53/v+YSG+6GYj3ywOiaHOLUwr98tdqBSh9I2cLizLtg=;
        b=ePGGkoiPuh6c9EobnqX51J7oDGL7/VvWDSInBAQQHre+T03AObgTffdBf7Q7hZ/BpY
         8xY6l/qekUjSJiq6Mqlx/Rs15DIjd9Ld9qk5EcDApzF6J8fBWFfbmY/I5iAHHuMkuzFu
         TsuAU8K3WggJdFLPjSoiznr2Iit0hGq9jMUVG1UKg82PcaSCAtV+nqi2FZ/sgKigUhWL
         9gxOhlofb0Oi7KXfbHCoyxXebxSG7eQy93NRKwjl/YAVLrKTNKzmgRTImSQyi+dL9cJ0
         LD6CjvR7QPW4Lu+4N12XKCJueIGIoojo/IRVP5/63haptLs7A2M5544ltDhjfk5CmrWq
         4Czw==
X-Gm-Message-State: AOJu0YzdKbdRlhsJ0be9G9H1F3UldXPZYk/AXXHIgBX0RpWZ1/FiOzAJ
	3qHhSukEtZxKmoeFVdj+avfbrjK4fJae4MxJOetXiUw3uhTlZqGTO6gp
X-Gm-Gg: AeBDieu+C58Um1+ACF9Jya+UpTdHgtwFOB3y1SPy7oqJ2Cvx5BA5uLrt6NvV5WoXKdl
	/X4vaAFVFHSSVKffgKkSMfeE+27Iok2MeIivBuecbbwPNIVNotYN3zLm9JKkZpfCGxcs+jedfYX
	eufWXQTCsyArJc+ytbCghlwaSxr7CaHoVmQieHpz+zwLQ9YFVEvXcdehPuE07tIPU99ctIEVk6/
	5Hq032X7NFNK+4sqsuMUz5MocEJlWnu0c9VSuK5EHpx9NOqAIoXrDm8pmqz9vhVh6hX390gL8WJ
	8XUvXq6DKSOduHMy2cpBsdR5dtU9zUx7m/ymXd3WnMI8p/Xf+te9IVaHE6m938bc9LwhJwXtkn7
	nz8jssl+SCNo3gQZcYT6+f3jTzXm1sHd8fkSa29K0NBNiXnkj9VAJkCSAjEAYEDLDhiM1G/OzyI
	tpeHANeDsH3VFE53KDhnLbeNo=
X-Received: by 2002:a05:600c:c08f:b0:489:1b10:d896 with SMTP id 5b1f17b1804b1-48a7b4d165cmr3095065e9.0.1777390601346;
        Tue, 28 Apr 2026 08:36:41 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7b56c2d0sm1358875e9.11.2026.04.28.08.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 08:36:40 -0700 (PDT)
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
Subject: [PATCH v4 6/6 RESEND] mfd: motorola-cpcap: add support for Mot CPCAP composition
Date: Tue, 28 Apr 2026 18:36:11 +0300
Message-ID: <20260428153611.142816-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428153611.142816-1-clamor95@gmail.com>
References: <20260428153611.142816-1-clamor95@gmail.com>
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

