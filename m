Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DD3427A1F
	for <linux-input@vger.kernel.org>; Fri,  6 Feb 2026 17:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398967; cv=none; b=FpSaukL7xbk9zBKNuJ75OJSgbQGxMMYzAEOGNNPYg0cMn7TO+lZQNVfMehLHjz1f8ryWeGZW+geqWtqQzS/Ymg4suNSmaG+AGbL3nUnN11LkR5FVigMYFFs5KxRuEvWHSET+1vkrOaXsYNsTWSQzeput1RD+EfjbQYtyX6oopX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398967; c=relaxed/simple;
	bh=N4sfHKpleqMrWkE0BhhX+wodEn0xk4GfgnLKvXeA0GE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dlzkeAfbDf/JKVh6UF2Yb3d/4Rjjtnzq0EtIMnjTAWZy6PhszcHPlkgaHtKVsklTcea26ZD4XgDXKWxYWmuUVmzN6PSgUp4HqO4I/ltuJssamrMuKI6WJqTgXUArjZESkAl064MuL/i+/AtIl5/Uo+OwZKUwvOtmAb7wE2a4qRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/jkF7v0; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/jkF7v0"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4362507f0feso1029737f8f.0
        for <linux-input@vger.kernel.org>; Fri, 06 Feb 2026 09:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770398965; x=1771003765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38QOshg4B3/jkxvuLV9no2rb1uvRJQraCFfp6So5X0E=;
        b=S/jkF7v0GbCn6RLVuE/7WjPJLirr51CYwPHqb3ND+yMGndKzcmW0CJvHHd8WLjqNxn
         cse7gBYYXPRm1kGUf/emz9eL127UgXG7UE0r+eM5Des6PcRtDVhWZ5z4imlS35IO51bY
         eJXu0awcHZMSv3YbwyxxHjfpRIZYgyQLemLHj/ol6uJoVJF8LFy54zT7DCjd0/f8lr7A
         WK99muoGi/4GLge5wqZRaiQ00aKOTz8Vn2gWs6q81GmztoRxQJr+x6Ks/qdb6RO52VOs
         eg1qD/BXypUjgykHpiF3DeLuaISjcO5i3ZJ2rriiBBdUNjcdp1Hzys/xUrakGDAlewr8
         T9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770398965; x=1771003765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=38QOshg4B3/jkxvuLV9no2rb1uvRJQraCFfp6So5X0E=;
        b=oOkmpOnzQOwM5ztooGNuWUBn8a9CQ5y5tskxixVz5lsi/zCalLg1nEJB6tHhcAl5m2
         uqmy2ayen4E9/3ite7+8Sfil3xXZbZQUgP40d+4XHcFZ/6P9ddIFq+83UqEUDfZs/4Fr
         2MQzzqM7/R6z+s07D9Pi7+uK2jPt2TwZoivlcYe6foP5lVEguna02PahdQ+69Sv6wgD1
         CoVpeG5oD0M1u1piEJbSFo22TazqjSnaZtIlKzdKFJQzuHWNpXYIknMHiSDXS6qt5yCf
         jKuCyymRwwGXqTz9niCQeCkwdbjJCHQ014uJSgf204ZXOv4XgNpnrPelsdDOJUsCiDKD
         vOBw==
X-Forwarded-Encrypted: i=1; AJvYcCVMcEOLNwltUoG+jxpeLuWDlx2cSzh4RoEeNvU75UvVyChNdVEojqpfKXTCBdorE4LHSMt9W8gvSKpm2w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4F9Lgkg+udG83SOrGt39qY8dcy5hzbseF+Gkm5JzGfIqLoelf
	P7XquRXQOJDOWWaXBHlDn7GfAg/MAu9TEIMCrRpYQibFr0KLv9+BGj9c
X-Gm-Gg: AZuq6aIklIFpMndVumohOoAU/LP50tFYwP1gAYI4C2S+GSoVsyjyyVoA78DwBIrvCZX
	D1CsY+PRFpYkQSpfYy8V4etl7A0lTJCII1txoUlmnf+C6DCTrB8dD8OywOFkrlpQtzvFOYJ70B/
	wf7TfCGY7I2wcHVG1wx2HAoNOsXkZbsqXaiixewKo9u5MOXFUljaY+HoWy61od6/kvFGgJTa7eP
	btQ7HE35YI+JiZuuFP6cbgZenRfwImraYNTr6PYdDedWmFqAPdLA9lmel1vCS0/W6F/PkIv7suF
	HfKXU9O7TGoaQOKsrBZnBHy4/sPYG9jj0nL3IY9iFDQQrG8t9fynIiwWFjDfoULIeRakBlWfx7n
	kTUK7Wcl4dNpeaLYaZHeUVCvUoGpQqvgkREje9kNQc7Du9YFsDghn4nJrYJR8y8LJ0LzeKb6gzw
	Xr
X-Received: by 2002:adf:e3ca:0:b0:436:307c:b756 with SMTP id ffacd0b85a97d-436307cb85dmr1101460f8f.47.1770398965306;
        Fri, 06 Feb 2026 09:29:25 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43629734268sm6846033f8f.24.2026.02.06.09.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 09:29:24 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Tony Lindgren <tony@atomide.com>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v2 11/11] mfd: motorola-cpcap: add support for Mot CPCAP composition
Date: Fri,  6 Feb 2026 19:28:45 +0200
Message-ID: <20260206172845.145407-12-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260206172845.145407-1-clamor95@gmail.com>
References: <20260206172845.145407-1-clamor95@gmail.com>
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
index bea11868e823..d64c83614f12 100644
--- a/drivers/mfd/motorola-cpcap.c
+++ b/drivers/mfd/motorola-cpcap.c
@@ -206,6 +206,7 @@ static const struct spi_device_id cpcap_spi_ids[] = {
 	{ .name = "cpcap", },
 	{ .name = "6556002", },
 	{ .name = "mapphone-cpcap", },
+	{ .name = "mot-cpcap", },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, cpcap_spi_ids);
@@ -343,6 +344,54 @@ static const struct cpcap_chip_data cpcap_mapphone_data = {
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
@@ -398,6 +447,7 @@ static const struct of_device_id cpcap_of_match[] = {
 	{ .compatible = "motorola,cpcap", .data = &cpcap_default_data },
 	{ .compatible = "st,6556002", .data = &cpcap_default_data },
 	{ .compatible = "motorola,mapphone-cpcap", .data = &cpcap_mapphone_data	},
+	{ .compatible = "motorola,mot-cpcap", .data = &cpcap_mot_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, cpcap_of_match);
-- 
2.51.0

