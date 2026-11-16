Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794869309;
	b=y8lGkieiC+rWOM9MO2je/k2CEdzpw53l/I7hiQln8L0zy3adKA0N0fXSeSoson305hZS
	 nceaBuEf4ZVXWz37v0IzlXNN1jfPqa+ePZhYO8FFSolO3jurjTD5i8/8jNBUHTExcvONR
	 brzq/ovAsAS0yrhHqFFeQXzWrSCPJX8AhEID+Z4xRmu0tLHq3Ex5oKL5Zl1yzghyw0nqR
	 xf4+lpCBBVPSh4lSgzba9SJwXj5N/gqBhrR9TjbbJ8oA5sMLiuowKpdhDFr8aLBxvSW9R
	 XZJISheJyi9WWN/dtN8mfMhYXY32yt5XXsdE84RUDWEd/Eec53D6EEpnRj8rPnMCbcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794869309;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bZKF6TYd/oNwfZR5R6RX8KffmVrf3Im0dZF68ZrZGqU=;
	b=4ThNsniNawLvS43cIXUPcFYYctASTHB44cNShMaih7WlINlqlG6/50o/J6sDqmehMDMM
	 QWYLu/oQ4QK6qpvu1bXI9mCOrLGMawKuMkjXB9uUvD7DXAK1BZw4RnYAa4rd1In0d8LT0
	 IkOAn2BsMnaX6I6GaD81AiggYITWsBWME26PgZXI5mGbuwwizPaNEtj+9h4+xCU+MJPOA
	 0QZFDLcYf8NCNDwqWlpUSu9WAphgsHvtuwmHZ7KN/m4jv6T9CIhr+lKCdTOzF/pK6ebjY
	 A27b8F15C1FbIJK5Gwvd/HYddTaG2YrSfrmFNk17HdYluDDYbjfI92poN+uho2r2AGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CqrdJtqq;
	arc=none smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B15606A332
	for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 22:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40B15606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CqrdJtqq
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b37c7d767aso26123317b3.3
        for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 14:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794869308; x=1795474108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bZKF6TYd/oNwfZR5R6RX8KffmVrf3Im0dZF68ZrZGqU=;
        b=CqrdJtqqlqqFTPvG21v5VfgDwdnkGw0lkRHkWExpiZRr2MveXfoFTXtiOss415VbDE
         u0dXEJCO3aQ8kiJmmBLtdTEt0VLMkD5XQLKI0wp28opEfbSXx+VFRomGLHOeREoxsdqd
         V0NljsHCmwqNU/130gTTA1L42Fs9uosV9qbGjsyB63I0/JnvJCHgOi0yBW8laDzORAuw
         Od6Oi0w0sFbjIbKgiwANjzFHkZxFODojpGcDwN9BeHhcyOX3RIXeXjT7daBwyKjiWK1K
         mAvd/JwJZyI8dM4OiD7TAznZ7Cob8zennS5HneSbMejsiYIAKr09WIqzhQrZmJ6CiTZe
         bKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794869308; x=1795474108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bZKF6TYd/oNwfZR5R6RX8KffmVrf3Im0dZF68ZrZGqU=;
        b=uJDB70hne83n1B1A768sMdYnIGC/fES1uTGUfPMnuwSaAeSr9wWDOW2vb/gplveTlZ
         Z3KfHkQGwWoGrM41zC4GGc+pIAmDhtUHKPsYabeNc8hb8Pke7pL6pBdZHQVQUpXliFtA
         9LOWeJle0tACruMqTGaIBk0vXqZeLByxo7Zj4IehlxCFDHHPhi6tXT9s3fC1U/9t7wvh
         iw110XGKaGWRox9vYw9T5V9hM4Vrmpzpf2hGcNujdRzunqAtBq1CMB8CT1WPn5AEBozT
         bRcUUNrPBI6vNO7jSU7y+9uTViMAgXw+/ArNi08htlQonQSy/InkHsYcOpFS5ug1+LKE
         0MQQ==
X-Forwarded-Encrypted: i=1; AL+hErGGQP638Dk+1q66ra0coISoiEMnICGWYvCUv7veEqBMZd+vr+RFDAbq5yy4qdm46UqRrkIjR1Hmr8vUDw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9dOJ3fp5nL0El414P4D25qINDioQKGx2zvfH6UCUvPl3gZw25q
	bLF4SE7EeEcAfBXhCrVYUH8DMdD4WQL3y80/C5x3CRZAzAPkV/KVvv/O
X-Gm-Gg: AZFdTZcf8DcPbYgjKd5WnvCxkhPdRXX0BLwGKOmNyiv1H8GNjJ/tu4pU0Z4bCGLEI2e
	LQ0XfjSoSfX7u1JJ6k9097eHvt2LzRW6zx/Mn6lkoKXfaKcIGuM58ptfMutW1KJOInE0xzUXeQz
	ADURyvL/C3l487TACe1sxnxWV8jRVOgOsh7dcKT/u6UuLN4+toLwd0Iy/Pdx8V85RfKLHyF40zc
	GhsNocwqZKm94u6FUn64QghdJ5QnZ15aTOQEHp+xKuNhM4gJjA/0KRM8h44Zzr95eWcfV3AsGMh
	WPOR4xQb1/aitHhYQiuRGmvlUcDIVkvmYQhJeSkz4BAVtoVI0Z/W5liibYlZSmYx+OjfeAR/R5n
	fArZuXdVE+XBeSM7dwDH8WwSmhLyrvLwMUJFy8ZEdGnVniAAcpEfkJSKuHEJEgNMMfY/PYqU1xw
	Ir5ssonsXyLXVxzSTHoD9tgIOfT1IcNp0mxkiJCBvnzegLGf92vmeiQ7HYxjZAuW8wcnK+tjl+F
	ZTsRY72S43+TqOUz21le0e0KxXdGnzq4Bcbz6zoBgNYQWpX7jDQJ5w3a819Or56J17Y1phPRdB5
	CgNcmnz5v44nZM2cfpv+TeD7ib8SP7phDf1xjr9hSadAnxO+E9yqP9CbEYt419b8HLDH8Oo7o1H
	U8PUi9boqv7I9tiY682sdD/A=
X-Received: by 2002:a05:690e:d42:b0:67b:e822:6ccc with SMTP id 956f58d0204a3-67d895e5aacmr4455238d50.33.1794869308071;
        Mon, 16 Nov 2026 14:48:28 -0800 (PST)
Received: from fabio-X870-EAGLE-WIFI7.tail2bb604.ts.net ([2804:1b3:a803:1afe:e1c3:da60:db44:d0c8])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67db0361f39sm5259534d50.19.2026.11.16.14.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:48:27 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: lee@kernel.org
Cc: maz@kernel.org,
	andy@kernel.org,
	jic23@kernel.org,
	dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-iio@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	Fabio Estevam <festevam@gmail.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v4 4/4] mfd: mxs-lradc: Convert to devm_clk_get_enabled()
Date: Mon, 16 Nov 2026 19:48:03 -0300
Message-ID: <20261116224803.61154-4-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116224803.61154-1-festevam@gmail.com>
References: <20261116224803.61154-1-festevam@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LRADC clock is acquired with a managed helper but enabled and
disabled manually.

Acquire the LRADC clock with devm_clk_get_enabled() instead of a bare
devm_clk_get() followed by a manual clk_prepare_enable(), so it is
prepared/enabled for the device lifetime and released on unbind.

This conversion makes the code simpler.

Suggested-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v3:
- Newly introduced.

 drivers/mfd/mxs-lradc.c | 35 +++++++----------------------------
 1 file changed, 7 insertions(+), 28 deletions(-)

diff --git a/drivers/mfd/mxs-lradc.c b/drivers/mfd/mxs-lradc.c
index aa55f88399ef..c3dd2d80e7f1 100644
--- a/drivers/mfd/mxs-lradc.c
+++ b/drivers/mfd/mxs-lradc.c
@@ -160,17 +160,10 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 	if (IS_ERR(lradc->base))
 		return PTR_ERR(lradc->base);
 
-	lradc->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(lradc->clk)) {
-		dev_err(dev, "Failed to get the delay unit clock\n");
-		return PTR_ERR(lradc->clk);
-	}
-
-	ret = clk_prepare_enable(lradc->clk);
-	if (ret) {
-		dev_err(dev, "Failed to enable the delay unit clock\n");
-		return ret;
-	}
+	lradc->clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(lradc->clk))
+		return dev_err_probe(dev, PTR_ERR(lradc->clk),
+				     "Failed to get and enable the delay unit clock\n");
 
 	ret = of_property_read_u32(node, "fsl,lradc-touchscreen-wires",
 					 &ts_wires);
@@ -193,8 +186,7 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"Unsupported number of touchscreen wires (%d)\n"
 				, ts_wires);
-			ret = -EINVAL;
-			goto err_clk;
+			return -EINVAL;
 		}
 	} else {
 		lradc->buffer_vchans = BUFFER_VCHANS_ALL;
@@ -204,29 +196,17 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 
 	ret = mxs_lradc_get_irqs(pdev, lradc, data);
 	if (ret)
-		goto err_clk;
+		return ret;
 
 	num_cells = lradc->touchscreen_wire ? ARRAY_SIZE(mxs_lradc_cells) : 1;
 	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
 				   mxs_lradc_cells, num_cells, NULL, 0, NULL);
 	if (ret) {
 		dev_err(dev, "Failed to add subdevices\n");
-		goto err_clk;
+		return ret;
 	}
 
 	return 0;
-
-err_clk:
-	clk_disable_unprepare(lradc->clk);
-
-	return ret;
-}
-
-static void mxs_lradc_remove(struct platform_device *pdev)
-{
-	struct mxs_lradc *lradc = platform_get_drvdata(pdev);
-
-	clk_disable_unprepare(lradc->clk);
 }
 
 static struct platform_driver mxs_lradc_driver = {
@@ -235,7 +215,6 @@ static struct platform_driver mxs_lradc_driver = {
 		.of_match_table = mxs_lradc_dt_ids,
 	},
 	.probe = mxs_lradc_probe,
-	.remove = mxs_lradc_remove,
 };
 module_platform_driver(mxs_lradc_driver);
 
-- 
2.43.0

