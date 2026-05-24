Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A393290BD
	for <linux-input@vger.kernel.org>; Sun, 24 May 2026 19:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650802; cv=none; b=j1Cw+Rg6+9ztTujcxcciE4rxzj49XHo3/flLEgEi/BRp2kggX3LElBml5DLiJC9oGrjnJm9xnsYXO64fLeltzMl70oYJWYZSWQyK4KHSmhiSbWfXp/Jym+LtbGssVbsqWOU4XOKUG9yiE67OD3HOPUwINNvFBgOibM6X2R+5/RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650802; c=relaxed/simple;
	bh=rwwj8kIUs5U4hXXdmczdq5loN5eahLFy/MFIpHjNRi8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AowZ2x4eZzdZczm5Z2BLpUmMD7C4B61NOnZzQ2w9daLlWW4CjJ3MePDNn/p6wYNGNL+H1clXeXrVfNXM/bRA/qFkgPAVD8dZmoMrJArpa3EE2GV9ueAPjmAHaRFLjB+gYp4foobYCWUXhXzX7caS7jj+ir7x/+/K6PZXLVgt2BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyVV31vs; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyVV31vs"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bd266f6fc0so44060195ad.2
        for <linux-input@vger.kernel.org>; Sun, 24 May 2026 12:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650800; x=1780255600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfsq2qmaqpO/Q8c6X+i6OJam7GzEO/qR4jyX30fJ+Wo=;
        b=DyVV31vsXjthMnep0MdlPLPp5dggrF45P/RgYYmoLiCCtTCjEZLRfh5+l4kt4EHeyu
         eQxqwIxxosUOauXHg5KFc6gWHJ2mVICnglu0xVvh2MGjBFnCml5zwNQlpHayeIPbxIAF
         4M4QgMYckPcLuvGkSYpKb94l0+ibE2KmIw6vsgK7AyOYGDNtdsnFngXb5Obe7Vhb/ylD
         xFmtlHvRL7l5giOu/X7vO9CgjWFR1v8tsXs+OVxNUkGbB7LIdaP5tYKlYRUvz8dAFVIF
         QlSj0LXz7dUJaKzb/n12cNjiaVSJ0/zpjL9pLfbsmfVIrSs2yo7LaapxU/m5LMc9Dowk
         EZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650800; x=1780255600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lfsq2qmaqpO/Q8c6X+i6OJam7GzEO/qR4jyX30fJ+Wo=;
        b=IxgKHnv+bmKeSmqjeyuNsgmpZ49+z78V4Tk4lQiMGw0i0baDo6WzTPPdBCP7jpkSx8
         Kuwwtu9QIrReC0eagh/A3Em+nqVK2+f0BUCVPy7ocl+hP9W070SH8O1mK0V+SFDIWcwQ
         7QP2FouhL4cSf5DiZZ3NorrBFX9FlSQSkOTiU6nr0GjuX4V4j8EVzfcgK7N/LNzwfOx1
         LyflTAWvwnNo66vKunVNCbmg6vy2Kowv8TnIFrbsUej8D9aaLPCqhuNqOH9h+TrEApZ3
         WQ5WVQtafKJsl77442idUyAjo3f+xFjIBDr+NVRCw1GkbwpeOSjtMg5pUy+52oYxgCi+
         4g+w==
X-Forwarded-Encrypted: i=1; AFNElJ8h+DCfE8DoTEqUmmq5K6N5PS+q7UKb3CZGXRfv9/s5zb3ZaJBlYXn0PexA5BFjQii37Ht2t+cVFYpG6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBtMCsV5PO3NDOJ0T65Ae9tNlMe1TpR7K4IPhvPtMdlazRqFUP
	8V1w8L1kMD3h+y/cr14wStkjP97NZ7tV7CY8jkpce86Dp/nAAKR2WFNJ
X-Gm-Gg: Acq92OG+K9WrbkhjMVet+2MLCmVCzxqHtwvOUCSb39YBVFHmDghggvorZqP56lBjDX9
	gXSAlz/xm3uxnzvgfTImXnyNFERwnrWRRl1yBw5zkDDVA16ZXSCGcPwTt5i55d6ugXI1Rq6ynyF
	/5v25/Kz3IvmxXd5AkXt8ZN3X4/uGIXB2JYoAzlagwNwdXG2X0/G7dhPyXmQ6a/yQnAsF+/3KvU
	jK/7/dU67LgGIOE1zZZyVUHedFDFe9jFq14ITk99dVSP53PW1mR20xlA6WWzN3kph1wPVGoKCJO
	FP1JtfDo0HSRB1vyEYhqJUQy5A1R9utHc2Dp1DbXOATxXdsApx7AWhYI3vW9/Rli8P7rwfwXjZb
	oiQ8TmXXzPIcFFsVGbfCZOx6wHxfohjftGVXjSC9wWd0WV3zXI57nDcc5hTcTeI9PJxLrsxFi0s
	HjT5A6VZgz2Ut+2BD/3rMNH/KWDeUaDdsidV7Z+2JuqH06MNtz4y4vzD+HTr4=
X-Received: by 2002:a17:903:19e8:b0:2b2:539b:d2b1 with SMTP id d9443c01a7336-2beb0628a12mr126739455ad.16.1779650799838;
        Sun, 24 May 2026 12:26:39 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bed2061c59sm16394465ad.2.2026.05.24.12.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:26:39 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	sakari.ailus@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 19/36] iio: light: hid-sensor-prox: use local struct device
Date: Mon, 25 May 2026 00:55:56 +0530
Message-Id: <20260524192556.1195042-10-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260524192556.1195042-1-sanjayembedded@gmail.com>
References: <20260524192556.1195042-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Introduce a local struct device pointer derived from &pdev->dev.
This avoids repeated &pdev->dev usage and improves readability.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/light/hid-sensor-prox.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index ac55808f161b..033dace06681 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -272,14 +272,14 @@ static int prox_parse_report(struct platform_device *pdev,
 /* Function to initialize the processing for usage id */
 static int hid_prox_probe(struct platform_device *pdev)
 {
-	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(dev);
 	int ret = 0;
 	static const char *name = "prox";
 	struct iio_dev *indio_dev;
 	struct prox_state *prox_state;
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev,
-				sizeof(struct prox_state));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(struct prox_state));
 	if (!indio_dev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, indio_dev);
@@ -293,13 +293,13 @@ static int hid_prox_probe(struct platform_device *pdev)
 					prox_sensitivity_addresses,
 					ARRAY_SIZE(prox_sensitivity_addresses));
 	if (ret) {
-		dev_err(&pdev->dev, "failed to setup common attributes\n");
+		dev_err(dev, "failed to setup common attributes\n");
 		return ret;
 	}
 
 	ret = prox_parse_report(pdev, hsdev, prox_state);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to setup attributes\n");
+		dev_err(dev, "failed to setup attributes\n");
 		return ret;
 	}
 
@@ -315,13 +315,13 @@ static int hid_prox_probe(struct platform_device *pdev)
 	ret = hid_sensor_setup_trigger(indio_dev, name,
 				&prox_state->common_attributes);
 	if (ret) {
-		dev_err(&pdev->dev, "trigger setup failed\n");
+		dev_err(dev, "trigger setup failed\n");
 		return ret;
 	}
 
 	ret = iio_device_register(indio_dev);
 	if (ret) {
-		dev_err(&pdev->dev, "device register failed\n");
+		dev_err(dev, "device register failed\n");
 		goto error_remove_trigger;
 	}
 
@@ -331,7 +331,7 @@ static int hid_prox_probe(struct platform_device *pdev)
 	ret = sensor_hub_register_callback(hsdev, hsdev->usage,
 					   &prox_state->callbacks);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "callback reg failed\n");
+		dev_err(dev, "callback reg failed\n");
 		goto error_iio_unreg;
 	}
 
-- 
2.34.1

