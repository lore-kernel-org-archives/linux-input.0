Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589C83242DD
	for <linux-input@vger.kernel.org>; Sun, 25 Jan 2026 13:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769348600; cv=none; b=B3gxWNJVfyRFulvJzu0n12+aUDqXymESl5bFXnog4HNLA7b9TrlQ7sfkffToa/u7BRqufp+ZES8GPxlymrUkMOCqFlqlNS1uzxbFd601V26kfoxHkUl01WUiXZK+yE8RzDvnGc4ENVgAnHRgDeTB1c14dmvJ/RdFDoTDBd9tno0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769348600; c=relaxed/simple;
	bh=DmGjedKkND/XSbjiuPXjmC36aaS/LlhmmKioOtF38hI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eS/Kyy2J004hhryJCpQAlRE21elcFovIZrE3l2Gt4aD/mPp6ihH8QyWd+N27HnFEcwCK9UOQokJ1RUM1mS8ct7D2GMD6i7oAQDJtSbJuqIvXvpjAEbkPg1nLddXYKHIFPDnN8CSk2f4u8mXTCjtLIDRMCINDPqZEy9Lnm3U/y0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQci+Dex; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQci+Dex"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-480142406b3so24546785e9.1
        for <linux-input@vger.kernel.org>; Sun, 25 Jan 2026 05:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769348596; x=1769953396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJR3t/I+dSBF7pxTKcEd0IpTH4h4FNjSSBlovFfwKo0=;
        b=CQci+Dex+S9w7gtUy3IvYfDMFYvAKmIoJPVEACFM6PZ+QPlDYtUCOTEpmcwTb8hXFw
         Ywre9l48mm4zMUqQ+zdcct6DwTFhOggKa+8EZopi3KmGUmv1gRK3RYwUzdEHYsS+3Jj8
         MCWtTL+P6ERRWixecUvPqIrK9LI8kkQVUBc9Wnq7Krd+IYkDmcgvMG7dlp19O1xe//Jl
         sRXKgGes5tl/9qm36Nucu5mtabsBMNqdhSAfopw+0MNl1KuW58DVsVJJeRP+koCbuM3A
         vJIMfdGRGPdaP7XysuBY84ofBh/gEtFHab+nTY3Vu/33gu/PoVPpEWXvO1tLvjgk2QJS
         8GPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769348596; x=1769953396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gJR3t/I+dSBF7pxTKcEd0IpTH4h4FNjSSBlovFfwKo0=;
        b=p4eVXd/5IIDSLaVPEFkFEWIQJx6IgBYmIRakuL3BaJZLUw3YIzcMKNRvTnI0bGRP2F
         /wY0TNlIxUqc7m75j+IppU+6zdBsY/T7LnJu77qzAvBrEvX/p194cTXGf/UTdSEmIBtE
         jGwfNSogmbOUjAuCwltyn59QrU82nPRxarjqlp+4ypyOdq/UuZY/t+P3MwnKsggiaRIo
         z+NFYLvEkcsJ7WSVxduSDSe6y4MzLUdZaC1/twb/roXtYQfmhz9uK1wl7Q8/GYOgUxMV
         KL1kM4fVEN9QOdIqXhP3toTn0DA7YnDXB4FWYs65LWSldjRJfKpgYOIl8RQUOLuG7cIx
         e1sQ==
X-Forwarded-Encrypted: i=1; AJvYcCXz02Bf+2cRTTGOnP3YIvNIPVdOG+bkswaNSx7W5sYk/ZFUfkwwNsj9PvqVZHhWlCc+zHB8JQXyaOGCHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUBnr75MOdiRh67I3L1IufUfQN+8nCQtr8pRiDqBZ42pE68Gkv
	EHtd0sJjbf3EY/xC9u7JquYU8OlAZIgs4zXilM2Xro2PGM1bvTLsKA1t
X-Gm-Gg: AZuq6aKcFXar2mfHtVj22baqW3b+4pq5KSJxTGdSyTmMyEWvCmTTBHeNReLKWmGTieP
	+fY4VuP5Xb3BolyF31Dv585RlWkxmfoDPEkac7gUUYWTy74DPd8KFNkDY18Cf4v16JeKJnttAJS
	KyLdcvDUtKVfb5uW8UnfZEwhTbLdL32YsBNCDyfuzhtBD1xaVsKcPoaT8QQFgWzxRrDbm4EhG4B
	LUq1V2PDggT0S9lKVJ9k+toprNjT+la4IkoJnNq1OO9aSfPzSf7tbtnCLptSswPE4K+2ghmb5ml
	ji5aERS75Nfsxvbf4aeTf5Cp43bCJHtDzGijZZVFeIG1dt3ip80bkeRmJdp2a47x9qkvCpDStak
	Fu4Um9zVdO0uuIEnhOIgVhHih9QKgH6mse/mngdhySr+2Cip2HVVzig1zj2AY3xE3i/EkIy6gZL
	hi
X-Received: by 2002:a05:600c:1f8f:b0:477:b642:9dc9 with SMTP id 5b1f17b1804b1-4805cf672c6mr27725115e9.28.1769348596249;
        Sun, 25 Jan 2026 05:43:16 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c246ecsm22459688f8f.10.2026.01.25.05.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 05:43:15 -0800 (PST)
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
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Tony Lindgren <tony@atomide.com>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH v1 04/10] iio: adc: cpcap-adc: add support for Mot ADC
Date: Sun, 25 Jan 2026 15:42:56 +0200
Message-ID: <20260125134302.45958-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260125134302.45958-1-clamor95@gmail.com>
References: <20260125134302.45958-1-clamor95@gmail.com>
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
 drivers/iio/adc/cpcap-adc.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/cpcap-adc.c b/drivers/iio/adc/cpcap-adc.c
index d9ee2ea116a7..c25c22a1c03a 100644
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
@@ -942,7 +953,11 @@ static const struct of_device_id cpcap_adc_id_table[] = {
 		.compatible = "motorola,mapphone-cpcap-adc",
 		.data = &mapphone_adc,
 	},
-	{ }
+	{
+		.compatible = "motorola,mot-cpcap-adc",
+		.data = &mot_adc,
+	},
+	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, cpcap_adc_id_table);
 
-- 
2.51.0

