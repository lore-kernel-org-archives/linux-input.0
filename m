Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095676;
	b=WUqM+u++COzXTwFyfii2IafFBEAEiigQT9t26573rlhGtWGPDYVfS4FrUsz6gYiHwsed
	 RbwOfsyUFKhEO5B7ZMLPbWELj8CzAddXpaIKsVEDgDeMqDV1KPReNja4696T9WHzuoQdJ
	 F2hOTHYEC4YIoriYE2wX9T0kX/E46lLADWTi3K3B40QeReSGu3A74rDWwCtJi904XFnFt
	 x5XWtloao3aN3zO7th/zYKvMxshwq5rJcmzYdiFQ3Xl+hzGxSqYBkXl2m8j1b26pNQw5Q
	 w5+RtDlxHBZte9jTLzM5Dp7d61RnILu6teR1IE5BaFu7LF4ui+R+cCRtDsfjELfB8JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095676;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4c0G4YZiEJEesEvJcSiHJ7KCJftI/dPzJGtmeIgLqHA=;
	b=gVcIQ5CD548MZef/okySYEzfMuTinuMLNwf2Ua8cC+NdBndRNcTz6VzPmpUcT7ZxnW1Z
	 w7QhQ/13yzxhjuXyoZQyjQJ5MTSvHnIbeu4+xjMSQza/651XLTBBrbNpOtQsDKmtGuSCI
	 thJ7jaXCLM4xqnEerxc8jFI9i9PwUiXQjZHMOi2DCZEnNKXMzOQKR+nLBy02vO5YAVoSu
	 4h8d5h4MaSu8Z9a3Bp7cQSBPDPhaMp3DwYqEDuF+Aa0QGzKY8NJPwhyfFCLfRz4nOgEKC
	 D8UeFcZjn1WT6yV9eTYFQ8fMRgdMVuAuaDyJoUMRjnDk6dg2QxdMsg95/VuymKYSKHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="v/yC5iIA";
	arc=none smtp.remote-ip=209.85.222.51
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7305C606A336
	for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 13:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7305C606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v/yC5iIA
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-980c4258105so1322148241.2
        for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 05:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795095674; x=1795700474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4c0G4YZiEJEesEvJcSiHJ7KCJftI/dPzJGtmeIgLqHA=;
        b=v/yC5iIAsBsXt6P8uqDo6Vw/I8BJUSoM+iQPmacHN3OpkKecdynFT0AOqVWvAj0fWG
         CgONLMHCODVbLC2X/D/Px301tyjUwTrcxO0lyK4ZYWLmTsa8RptS5R3e7AsG8W93Nqi+
         AT+ZcY5K1XcUdDTyaZ215eIrv3fW8xSda15x6EKIM1GPSkjKR7a+euy+HDsDXRvGLtld
         ELhdGC373dBSzyZJNeeQDBM+LIr09LHt2nanai7MXMNZHnf5dyD5KHxHN8/IG/LOkDY6
         iYKyKvoZ2xXU29LvvzVkEHM7GVNNt8cXEWfP+OqP1I0zuSI6lvpR7vlhq7VWttpyzFK9
         Pd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795095674; x=1795700474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4c0G4YZiEJEesEvJcSiHJ7KCJftI/dPzJGtmeIgLqHA=;
        b=Q7BubQzzvNdCFvaTdhODtfQBmHTQUNKXhyAmKJtQBOP3mpWUH0CiefM/eMXdZQ5fso
         POpQgyiyvnp95aJY4HwIOGaY1tCkqwDvcd5CAs35RY4J/dVvEt97H7G8RjU+BoV1rEHc
         IiCR6PCXRtFvYhCVQExNl1fa4E3Pd3bNM2DYSMM5P/KEhHa2YC0hWCEohFTtyre1n4uA
         e5zRBsqBGTwfXH4dzLk3lVrHtfPqcglenQMPCUnyTQWTermwK7+SEe6fSAhw3CxOuSRi
         9QEzoYDohakoRjgUHEoMOCx4HoYD0yiCNGjbzFUVsgnMkD4CKV0Lk9XwHhhrbh6OYlqg
         dPDA==
X-Forwarded-Encrypted: i=1; AL+hErFPHboEz5XlZa+DUzQ6X1PehON+i1FtC/166EqZ1oLq2273qySZpqfOIyoThnChHCDKR3KMxahoFnf4HA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9soH++xde8wz+26ziiIiCrFJlq0qJX69SaqVdxa+mspzGxvaWE
	aOQHkJCdRqEB2umEoVofCx12pw7RjAPbttYS+i92vPijH1LlgVq3pe1a
X-Gm-Gg: AYBFou0apr/DVYR4h3gcrtWzfl3o5vXuuo352yhydyyRBNimelCGd7djX7XljA8jPRd
	6JkxPa5DeMd3tBkrGjKLmWKsrAzc/ltEIm9RVBUQK3f+K4SalsEAHTeqayqywiGtKhF//UOP4xz
	lepg+YYFLDWUeMAmUL44ZGuTD7vJcf9J1aiAe49dXs6UTeINJZqo/e3jD/IGXYzOX3f4Np+klJL
	acsyvmrl6IWofFvfYpAzhWrvK81Sq2EJRb1stFJlsW5hgBqqhqIfAGzymRlzqCzAMC9bPOZ45Gk
	leKqsOydvdkKEbubtZowg4+o1y7GqAmjGj+81FO14qiQFFIF0950H2oZKh+19YuYzA1lDvLNDk/
	hbCsURwcmP3qo+XLWdDwgQ3fuLoxJ13I0LiYCHqjPt/Zx4SL5uBANoQDA8RdocVYk1Bj8ovVZcq
	tKwE314nR6XkCXRoQ5KjPf5puCkLjX1BhBRCU+nJfN/xkIkHU1HYYb7NMDk9xJhe4QyDAnZ40ze
	xPDj6glTzwVKaQQJ2ukttzzRm0wRGyNvV7VzSMnUev4gktrwTYyKY21lhEx3ykv1z/WTLx8HV+9
	vac+7Z+NxyDu6Qbo7YUZyjibHpjcnzY83IlHL8q0NNaGjJI2RkVWQmM1IWvPzDl2fZ6lWSOFRze
	+GIBLJJI9MA3JDVxn5hQ=
X-Received: by 2002:a05:6102:2c8d:b0:7d6:49a9:fa61 with SMTP id ada2fe7eead31-7d6ba435c6bmr2530171137.15.1795095673999;
        Thu, 19 Nov 2026 05:41:13 -0800 (PST)
Received: from fabio-X870-EAGLE-WIFI7.tail2bb604.ts.net ([2804:1b3:a803:a13e:f40:91:660f:4d51])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e4a240ac5sm4134862241.7.2026.11.19.05.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 05:41:13 -0800 (PST)
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
	crofts@kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	Fabio Estevam <festevam@gmail.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v5 4/4] mfd: mxs-lradc: Convert to devm_clk_get_enabled()
Date: Thu, 19 Nov 2026 10:40:41 -0300
Message-ID: <20261119134041.16611-4-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119134041.16611-1-festevam@gmail.com>
References: <20261119134041.16611-1-festevam@gmail.com>
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
Changes since v4:
- None.

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

