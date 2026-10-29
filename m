Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268413;
	b=SIgUEarhdS++XTRgJFgB90HvV4/sZC4saDpqyDGBSvz++ih/RdRYLWkpxnrBgxUhYlCT
	 jDBNRkCNLjFvOyUBa5EbOx0KqOx5JyL5oi73kHgjVESiD/7VhvqfU0sqwzAUP8FTIEIkN
	 ttfaHRkZpiCOdCVFcnVRPLvNPKGkJP7EOY7mEfieDz+jK00Q/PWb7WS7LVGAeS8yad0B/
	 8tOTfCOyo8qjUocQF0l3mEvZHQaZaKGZh6dtfS7ycW17m8xk5lNSNKJyDbwBSFG2AJr7W
	 J240KPyakBDauTapR68TzjqaejKtJWN3r9Oasw6uGD3FCPpJhEhXNy2BhmNc1VOg57Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268413;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=2m6sqEdIShmvg7ASfXjbhI99Pw56OM60znpq44ByAfs=;
	b=4VWt0yeE8hNaT0fIc4Xlj63XzYflushNhlPwG+++kdCqPL4EeM1jFlAMm5m6BI9mMjqN
	 T5GzakxDt4E89wYymJvD/6moKs5UakUoe/ZaDRP2P0fYyKZefRl/m3+36GAM4eKx1idyn
	 dPHAKeL0e3lVr/xHWGaYym8lrzLzQILNoYIJV8E8sC/ZwGFP125uwMWR08XOoJU89uZwM
	 KjSKiI3QkF5eKYuw3mCT4XzknIeNDvJfO3FG9f99mxLtb5joo0caj67ikUWoc2gd1anbO
	 khtoJ4W/nNcnM7wSae50awCZzoDOQjJyomOFqpHUxIDX5plyJNgHcbMoUh6lc9r0/cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=arRjd7Ze;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AC6606A334
	for <linux-input@vger.kernel.org>; Thu, 29 Oct 2026 10:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4AC6606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=arRjd7Ze
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so19505405e9.3
        for <linux-input@vger.kernel.org>; Thu, 29 Oct 2026 03:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793268411; x=1793873211; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2m6sqEdIShmvg7ASfXjbhI99Pw56OM60znpq44ByAfs=;
        b=arRjd7ZeWsN1N43/M96yX5+7JUH53ssnab2jxNWq/+s1OFLYscIydei1Zwk6juHpqX
         2zYvFNLRKx9Cy+MUlvHmkcvcNHGKaUnA5mvv3HTnaMGfM7MwUIqSZlOlCrg6Mq2fKgUc
         XXuooIsFnTout7TtccNTVc5ysbDNdoaKGQgWF1oRrIKAJkSECyqyZ/xjT/13HbNr+u5A
         /FHbh30T8eBDD1negpLr41PavDGGOkR7D/63kM96Y3+QcPypGgBE1nsVEL1b4S7/uE51
         hMZWiAzXsPBZIZ/ZUdCmqpY0ibofSmLXC8u3qy6vCHH1f7lTzFfenVOIM3B70XvmcF0V
         6Rvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793268411; x=1793873211;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2m6sqEdIShmvg7ASfXjbhI99Pw56OM60znpq44ByAfs=;
        b=nN6+zg82WEeuwWtLPhF9MmvGwh6OVka3v/IYAPme26usOubzEscQzvw3qeIxpVwsfi
         TAZfYnWlUmC4+FcPXOmuFMZ7jOmMAF1WL6FP7+f7ns8cn9YT4L/0c+7Zrjt0f4mYQMNU
         6G1bdH4qH3L1SnZeFj4CuMDwOjS4rFTvvu/xd7jZwf3ce4ldwOGb8d0gC/AQJQrBxape
         2uEdW90fcAokSkddmwtduQ+VEW727hQpuupxKzhQnLWYrYIUnm5zrn47OVE4upQQSfX9
         fh71xU+BIMiFIqXnoFyHsv1vmX+RkqSZXq3CrsKE92oqCLd1ES1Ic4sHz4MRKCihyu1c
         I/eQ==
X-Forwarded-Encrypted: i=1; AKwUvByiJ+qSNpd5xe/rmajInuZhYPpdeUelAIEho2jm0ft1NxYB5IZMvyZvxHy/i+wXNZvUFA+5lO7Nsrt/eQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIhuuwxW88LXarcCBzy+117H8n3X+YVcR+UyrknWX5eJWu1VKXd
	txscz7XrxbiUST93TQYEAJaw+Il6cYxfg6M2eMAc4eeUJr2Op+bA0qCO
X-Gm-Gg: AYBFou0WYaIWTbgKOYUkObTGg/sYTtc75U2kpeKZ2p5A/Aqsr4zfPL8eoWAnfMPiXVP
	uNQfef/y0okU4SvKbv8+JaZC/r4uFiRO81LEb4DJbVKljH3RFtjyRhZOP1Tmf7HyjTOz1SIfE4G
	llVRBzwcxVPLHkM3aqLlbUZRmA6bhhrlPBVGz3X98HIDXIpzVTsFJUDWImvmOuAzXdC7vcnBc5L
	xIV/8gbUK7bgcfzITztIBXilriulgVCE+/TS/gQRVbaxudKjdc/WZZpb7ybOzYS6V2HzbPRBUhD
	lI+nDIaaIfSHIi6gOM0XzxBBnwe1JOCebGttiZy8ZmPjqfGC3gIa6ct84rFsNGQ2kC7VPYx54L6
	dZAivkOO2WXTMMBVgWbVoeLewGAqr7kd+HNWKeKmtxG4bgjMv6ajaz42uXk2CGfrv5fw1tmATdi
	XsxromP+XL9iRPXzI/SvVn3g4TZoIUi/fOKSPx4zBHMKdm4870cmE9aSq5/rb+BN6mQseQ3orr2
	M1sBHJ5U/V+0cLeCaP/fpikp6EQZ5iW+Ei4ubjE8Y12fs+wdBTCSkjwBWp9ZlXwrtXtx8w5snYH
	U2PV8A+m4LbnnR6NTXDkHRjXovadfWT8+H3b2Y/jxzL2gFY1lGdFXPyhmN7Ql4rEjR+fUAreAyZ
	VDjm1gpAHVg==
X-Received: by 2002:a05:600c:848c:b0:4a2:397:73f6 with SMTP id 5b1f17b1804b1-4a966490754mr125374865e9.8.1793268411167;
        Thu, 29 Oct 2026 03:06:51 -0700 (PDT)
Received: from [127.0.1.1] (ip092042140082.rev.nessus.at. [92.42.140.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7fdb7691sm53082825e9.11.2026.10.29.03.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:06:50 -0700 (PDT)
From: Jakob Unterwurzacher <jakobunt@gmail.com>
Date: Thu, 29 Oct 2026 11:06:25 +0100
Subject: [PATCH 3/4] mfd: rk8xx-spi: add system sleep PM ops
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-dev-tiger-v7-4-pre-20261028-tiger-suspend-b4-v1-3-cb12621c1fb4@cherry.de>
References: <20261029-dev-tiger-v7-4-pre-20261028-tiger-suspend-b4-v1-0-cb12621c1fb4@cherry.de>
In-Reply-To: <20261029-dev-tiger-v7-4-pre-20261028-tiger-suspend-b4-v1-0-cb12621c1fb4@cherry.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Joseph Chen <chenjh@rock-chips.com>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, mfd@lists.linux.dev, 
 devicetree@vger.kernel.org, 
 Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793268406; l=1163;
 i=jakob.unterwurzacher@cherry.de; s=20261029; h=from:subject:message-id;
 bh=1zvikwnDADGbJGUr+2C96ExmTpaaJdX4ozWbby5F6T0=;
 b=TCcmm2uv0Oq0jbsQFif9J3wiQ6uFZZOT6azcU9/u4jfR7utKpgVScfiFRlrkXexfBrw4RHf/7
 9Bb1HPxhFwfA2EYYzIpbfsEiuGXaDUD7LUMrp23QF3huhIpCcXvZ3KQ
X-Developer-Key: i=jakob.unterwurzacher@cherry.de; a=ed25519;
 pk=0v1L7pjG4d7PcaYPMOmzP4SjaRtnB+8bMzZLZCRzB8I=

From: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>

Unlike rk8xx-i2c, the SPI driver does not hook up rk8xx_suspend() and
rk8xx_resume(), so the RK806 never gets its system sleep handling, e.g.
keeping its interrupt disabled while the SPI controller is suspended.

Add the same PM ops as rk8xx-i2c.

Fixes: 210f418f8ace ("mfd: rk8xx: Add rk806 support")
---
 drivers/mfd/rk8xx-spi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/rk8xx-spi.c b/drivers/mfd/rk8xx-spi.c
index bb85fe60518f6..a0b7d7a058108 100644
--- a/drivers/mfd/rk8xx-spi.c
+++ b/drivers/mfd/rk8xx-spi.c
@@ -97,6 +97,8 @@ static int rk8xx_spi_probe(struct spi_device *spi)
 	return rk8xx_probe(&spi->dev, RK806_ID, spi->irq, regmap);
 }
 
+static DEFINE_SIMPLE_DEV_PM_OPS(rk8xx_spi_pm_ops, rk8xx_suspend, rk8xx_resume);
+
 static const struct of_device_id rk8xx_spi_of_match[] = {
 	{ .compatible = "rockchip,rk806", },
 	{ }
@@ -113,6 +115,7 @@ static struct spi_driver rk8xx_spi_driver = {
 	.driver		= {
 		.name	= "rk8xx-spi",
 		.of_match_table = rk8xx_spi_of_match,
+		.pm = pm_sleep_ptr(&rk8xx_spi_pm_ops),
 	},
 	.probe		= rk8xx_spi_probe,
 	.id_table	= rk8xx_spi_id_table,

-- 
2.47.3

