Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3231833BBBD
	for <linux-input@vger.kernel.org>; Sun, 24 May 2026 19:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650789; cv=none; b=ki+qu/WSqi1bYcCFnUuvqnxBxT0VcbsD2uwHDCsJrH3ltiR5KgAol9sl5XlVZ9IZ6aG1FibBNMZ04CC2dq9v4W2d4jzXEwZkYf6eLz7tUJQJRol7KJV/AtC0mvfdbMTikLXTSUOWVUCmCo9L1QIsB7cKRmetKuPlKxLNqf8enEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650789; c=relaxed/simple;
	bh=MYeIYUM2KlH1XXxgzfpzPXXNHs0yocmW+9ZTkwyCkNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O/7/yH9G99HIymfCsWt/AluSM+KgRmtgQrT4smxckw42iT5EHkV/it1/l+zGcSaitm/Ni2xaFaIs77qwcCvIS02+VgSF3Bvs4TSTZ14w5k3pDyAN4Q18z/NW2ytaYrsFC450xky0WyAIS3Rt18NdUxEHcenjdKd8AQZjY21t3VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5CJPfp2; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5CJPfp2"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2bc763e2ba8so44765275ad.3
        for <linux-input@vger.kernel.org>; Sun, 24 May 2026 12:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650787; x=1780255587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BueeduEXr1LDnMvJYaRF+YqR/DBnuvSzvmSwN2I4KLw=;
        b=R5CJPfp2p2Rl2a6gPW7C3nvGBoxa7MOtXIUsLngsutq8Vap/JYUJVRf/pO7dHIek5U
         8x5TqeC0SOPOHdbmV0smFbTyn5h2QWacHxT+tc/tQkJyPxaPbDVs6uWI8ltO0RrsCwMS
         P3DiSbU94yDtLxX2klklhMQobt5ZHT682Ue9uhHD1qIXM+5mg2bTe8twXydq0ak/F9qj
         vctK4EOnWITqlNVxX5kVMW/FJdz3GvISULtdwkL9fNjNTfvigbvFUevJ0oEA/mPf7K+9
         cCv70J7PGvQQXnWBiNmJqgdUJaFWO8EwiDdgTApQk1gepoE89l7ESl5gBrAe0EQc5frf
         iyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650787; x=1780255587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BueeduEXr1LDnMvJYaRF+YqR/DBnuvSzvmSwN2I4KLw=;
        b=S6MHz0C/9yabwZXXEs3GxVVe+ujyV4lLf0Y8FmH2ouZCF2D3mX0XVh24JZ7eT0eq8W
         gtrHoB2WiP0bn77S6a9ReRnjRicr9D6vaI9IUlWG9MTOpavSim6dFsfW2N7Xl9LUCS9q
         bTzNsLxWJjksNzdHfiyboqyzaJc4vQij6QIXlMqVolg6PPOcypNg6C+CGYTA+IT+fMvX
         V1ZLyixEGW1Ib/VIdmdG5h8WE/XZVQYUgCRokIOYNfz+ram/3LCCNcrVDQ6pXHOZ/f/2
         Z9W8YMrz6/J0d3SBgXuCDWlCjsUQRn5fbFxUml7u14Y6XHve8CKaX/JEGTG/EYktY1KH
         tjLg==
X-Forwarded-Encrypted: i=1; AFNElJ9AnTNIPnmZD35PCxI6eNKScsfhNxF5/yiRotfM3pvSeS8AFBFxAzgOOkvvqIFp4yXOHE8rKX5uXlvgHw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwL7Vsh7apIFIowD3eb/us21PNRbyH34a2+ep9SxwTn/LUAu9yr
	qvCAXURi8TZc9IhspS7kcKTG9Its4gidxFzLeI47ZynF53y/MlR4VX+V
X-Gm-Gg: Acq92OGqKrQvROuf4IGuOtihT52RSrPUeCSBkcyDI845ZKectg13OiQupdGuAXGBDKA
	XJ+12/jTQODpynR4GYyoNikzECFacOLM07f374zlq5MyUi0UKvsjrecfNs4h6jL0Ol+CdQWsQpl
	A5vZ4crOFew3Oww0OP18aHSBQwiUGSjCNl689Q3axcr0SKLOaGS/TaLXISzIyF+7Amb5FW0rBqu
	wTULwiWHn8IKsik8NsiJrh45C4J+LAE5f52Qg8FGCMsY6TLXBopuiDXdvTbi+fOX6rEa3f1He4C
	kjgmnFQ3PXEsbP14IAwFXriABPfW8BdeK8a5ygGsfPWtSm+hDOKQ9imgxIjI2c8lICEESwVrEC5
	rogsyyZmiNBnDROBMI0kH5/GJDg4SsPNCeWiViHMlsvax5EyCzT4uscchuUqOzJYnwpjHON3GMP
	q/ogHaMhIfJUCupg5U6R3/fGKdeG8NRvU8oer3MrCizTl/N1Xu
X-Received: by 2002:a17:903:3808:b0:2ba:5f24:cae2 with SMTP id d9443c01a7336-2beb07bb69dmr128631365ad.35.1779650787577;
        Sun, 24 May 2026 12:26:27 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bed2061c59sm16394465ad.2.2026.05.24.12.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:26:27 -0700 (PDT)
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
Subject: [PATCH v4 16/36] iio: gyro: hid-sensor-gyro-3d: use local struct device
Date: Mon, 25 May 2026 00:55:53 +0530
Message-Id: <20260524192556.1195042-7-sanjayembedded@gmail.com>
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
 drivers/iio/gyro/hid-sensor-gyro-3d.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index 4d56bd5b9f21..c891b1bb09dd 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -280,13 +280,14 @@ static int gyro_3d_parse_report(struct platform_device *pdev,
 /* Function to initialize the processing for usage id */
 static int hid_gyro_3d_probe(struct platform_device *pdev)
 {
-	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(dev);
 	int ret = 0;
 	static const char *name = "gyro_3d";
 	struct iio_dev *indio_dev;
 	struct gyro_3d_state *gyro_state;
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*gyro_state));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*gyro_state));
 	if (!indio_dev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, indio_dev);
@@ -301,14 +302,14 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 						 gyro_3d_sensitivity_addresses,
 						 ARRAY_SIZE(gyro_3d_sensitivity_addresses));
 	if (ret) {
-		dev_err(&pdev->dev, "failed to setup common attributes\n");
+		dev_err(dev, "failed to setup common attributes\n");
 		return ret;
 	}
 
-	indio_dev->channels = devm_kmemdup(&pdev->dev, gyro_3d_channels,
+	indio_dev->channels = devm_kmemdup(dev, gyro_3d_channels,
 					   sizeof(gyro_3d_channels), GFP_KERNEL);
 	if (!indio_dev->channels) {
-		dev_err(&pdev->dev, "failed to duplicate channels\n");
+		dev_err(dev, "failed to duplicate channels\n");
 		return -ENOMEM;
 	}
 
@@ -316,7 +317,7 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 				   (struct iio_chan_spec *)indio_dev->channels,
 				   HID_USAGE_SENSOR_GYRO_3D, gyro_state);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to setup attributes\n");
+		dev_err(dev, "failed to setup attributes\n");
 		return ret;
 	}
 
@@ -330,13 +331,13 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 	ret = hid_sensor_setup_trigger(indio_dev, name,
 				       &gyro_state->common_attributes);
 	if (ret < 0) {
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
 
@@ -346,7 +347,7 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D,
 					   &gyro_state->callbacks);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "callback reg failed\n");
+		dev_err(dev, "callback reg failed\n");
 		goto error_iio_unreg;
 	}
 
-- 
2.34.1

