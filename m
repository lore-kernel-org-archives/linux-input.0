Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765DA42315D
	for <linux-input@vger.kernel.org>; Fri,  6 Feb 2026 17:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398957; cv=none; b=khUpzZbAoCyO3tGCIz2vxIBJrhM9mDQTwHpPuzGymtqQsZsdWHF0iD213qB0wtV+J/fcLlS6AKfLipy35UcWwDAw0TO0oqbzmIxfI5g4CRLM5LmqpnQ1nwvOk3P8247x7qSAAcry8qB7NJ90gZv16vMrn/NLveIb6oKGutC57oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398957; c=relaxed/simple;
	bh=zDdA6Z/8E3qzcgVxUJG9XgVMg2hV9AEwM6u4bLx3TbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/3M7fKFIqsOTDfqO84+7ajEcP+YZth7EXEtYJaM5ueJ9YcqYio3UAVVBT/5WpnA79G2zg0TOY836b82nlgqpymE0qFmDhOQr4ajF8zvLdGYZXQf3pi0krthUQIGYAr00xzhXzvV/uU4IROg24s9i+DWRC6WGTIZTd2DcPJuw3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdN5I5wj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdN5I5wj"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so24341685e9.1
        for <linux-input@vger.kernel.org>; Fri, 06 Feb 2026 09:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770398956; x=1771003756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3NXIB170Miy5U8AUdI7je1qnmIqOJUqz+7CF8NtEdwM=;
        b=fdN5I5wjE2WPpeZmJrs2RKKds7Z8CciRyzg9TQKKINNc3TbY51b3CHbwd5CRsO8Fdl
         D/bRgw6zij3btttKrnf4ku31E5FKVm0Olu1OOtQFA6NnD+I0IXleCXTQQ1L3ACuAN/mX
         uVCvxs64sBHXq7EGyt2RgD05BkCNHJp+DqZPfXsdJDqkC4B9swNLgRrV04XKxqcbvVNA
         6ukFI3yJRxYkS5U/jAvINak46f1XVQZ/COOqhUv3JaDCSpAk0W6PQBSvx7zpbvQGtWMU
         iKhcKY7LUEi8QWvbr/lq+Pwh0OgnmrwSfpI9cKAgz3rBKqA3BHWaGupA3jzdXhiT6l4/
         RDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770398956; x=1771003756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3NXIB170Miy5U8AUdI7je1qnmIqOJUqz+7CF8NtEdwM=;
        b=l5JXwR+8GenAFMfSJ4XHPV7bVLCLVNEMDQcrjl4Mz6tELvLZYafyoLsr7OpETP/0Ka
         q7QXUtUdjrPNq7sDNs/ilJ/9FwXShk9ooHZEX8tFHsB2Nk+bc6UrdTeKLpZBsG0V7gN4
         FnWhLBMRylOrO9sfxCEvnMLtcj94vXzZMHK8za69mnQZWGsuC8wR5Prhv6mqVicAcXMf
         +yVf4vy8lwn/JOIAM9zCDrUkazdzWH/r/n9FubDmty3GmsN+JCBwm6CoAaJRE9rFQ1ur
         u3JLAm7Pyq1ECKFVQ0Eoe18zZypQj5Si8wD8cgHfMQO9TUEO+eOAq431n7PlY73U2k3a
         j1GA==
X-Forwarded-Encrypted: i=1; AJvYcCWbzFdvtWEkxoS30KGaBwg6V+qvcDIGP/H2dynukZQQv6BGQ8Gd+14FVvq2kJz/Ey3lyOpj9HNnnt+4FA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwL5+gWio+9uWJk8b3r2KrU6yyvNGCzOj24jMmV7X+0UhfRz5q3
	cnr5ev5ucOwgeAfpY9IfA0hV3NzET+EDNvBvxMenNdKlHjq9jfhEqKEf
X-Gm-Gg: AZuq6aK/BVpoH3LsHUuyuSnXmviz9UFAhsLiG/Hvj24YgVKxZTK9d6/gH/M/PnvoGc3
	u/OUdaq/dYIUUIQGB+i/52uxnODmZNcp8vpRT6ToMoRP0yyZlVAs2o3jmILPP8u7b+We+F/ZhDc
	kmqje6MQPFTP4YlwIs5BOCFGj0PoeCd9zdqC6PawPKDUeAfuYn49f3aSjw4jCjbIf6AHkXWgh8u
	EGWAmxIL2OfNR9Slj27jaMEiisXtIg4l/FzULTON/ay4yfLNq7P/V2kQzoqoTrbgZW/lYZUe7Ps
	p95/V807jHf+7O7U9cJPwH/owAEZ2I2c0zgxGZu4+woQYyLHUeE1Mc+qKCSgY42RCv4rqKm/3UU
	5pkoWJQDQWJF7jGhEfwXm1vvbkCp/KC960mE72+KnaCw9UxJLtqTiD80RYR/tjrUlZ8IzX9Uwa7
	aH
X-Received: by 2002:a05:6000:603:b0:435:dbe3:c6b1 with SMTP id ffacd0b85a97d-436293413e2mr5847642f8f.25.1770398955843;
        Fri, 06 Feb 2026 09:29:15 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43629734268sm6846033f8f.24.2026.02.06.09.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 09:29:15 -0800 (PST)
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
Subject: [PATCH v2 05/11] iio: adc: cpcap-adc: add support for Mot ADC
Date: Fri,  6 Feb 2026 19:28:39 +0200
Message-ID: <20260206172845.145407-6-clamor95@gmail.com>
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

Add support for ADC found in Motorola Mot board, used as a base for
Atrix 4G and Droid X2 smartphones.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/iio/adc/cpcap-adc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iio/adc/cpcap-adc.c b/drivers/iio/adc/cpcap-adc.c
index d9ee2ea116a7..f6f72efcc6ed 100644
--- a/drivers/iio/adc/cpcap-adc.c
+++ b/drivers/iio/adc/cpcap-adc.c
@@ -934,6 +934,17 @@ static const struct cpcap_adc_ato mapphone_adc = {
 	.atox_ps_factor_out = 0,
 };
 
+static const struct cpcap_adc_ato mot_adc = {
+	.ato_in = 0x0300,
+	.atox_in = 0,
+	.adc_ps_factor_in = 0x0200,
+	.atox_ps_factor_in = 0,
+	.ato_out = 0x0780,
+	.atox_out = 0,
+	.adc_ps_factor_out = 0x0600,
+	.atox_ps_factor_out = 0,
+};
+
 static const struct of_device_id cpcap_adc_id_table[] = {
 	{
 		.compatible = "motorola,cpcap-adc",
@@ -942,6 +953,10 @@ static const struct of_device_id cpcap_adc_id_table[] = {
 		.compatible = "motorola,mapphone-cpcap-adc",
 		.data = &mapphone_adc,
 	},
+	{
+		.compatible = "motorola,mot-cpcap-adc",
+		.data = &mot_adc,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, cpcap_adc_id_table);
-- 
2.51.0

