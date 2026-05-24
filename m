Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299B531280C
	for <linux-input@vger.kernel.org>; Sun, 24 May 2026 19:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650917; cv=none; b=OsO0gMSevkKJWaUKlhDd0qpWKPw9tEVBl0RvEi9O2IvMkZeFHLlsxhFA9p92gM20BfS8b5B89fuJjNuLD9aqGtAVpymrKi6BDQgL8Y6+aeJW2hTpJpWhIzeymg/tEz6/xdPfVdqba+1UuHeBZTjU4R17fH6ws8kOG7azOErOXfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650917; c=relaxed/simple;
	bh=sCKArCFlJdTgoDj/THdDVSRnJ7d9WGBciYRprHiW8ts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=POkdXwNy2QbwFsYKjnRVWpwXf4elRmM2/R9Y2yb3Bhf7uPHbh22HThMsOr7+H1s3eMCWFgYKpd5qj8UWTDngngH9qfwnpci45i7ttbO1uq1oYsvv8+F/jkFThYH2UG8H2t1M6ABvFMNxKR+P5YFLTOwEnhKgiGNcNkWC2vRElzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMoYxSa5; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMoYxSa5"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-367cbac9cb1so8692540a91.3
        for <linux-input@vger.kernel.org>; Sun, 24 May 2026 12:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650916; x=1780255716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmh7nuqqDzZWQzwQxSyHX5qx8D9YLtwwQ7RZyBV04Z0=;
        b=VMoYxSa5i3H28EM0yZkF/GI2wLYPecbZQHDzGi0vK3KiaHWy5N25LpIMS+XX58kkE1
         FsZ1C5u4tgz3apQRCQe8ZuSeMjwTWw13qzajZ8Vgsu2E7SfPquXlYFrUtYnVa9IF8ytX
         Ghmjjs5wyQ3YktZMQEPNxy9vfVQgo/nTol8klJNTTiWyETl4AUMCnsEakTQxsm63ois2
         ei2p37gQWdRADMKKJmrDQnt8+/N6126lhI11YfhlJsNDJCSBcetjXpheCXBgj5EWvmti
         kHQiLW5BbVuS29+vKGaCypPUSQHYnhpqjMQ0Gi0e05U56lpamKdgJsWAZ6AMeDjBFWMz
         vh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650916; x=1780255716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dmh7nuqqDzZWQzwQxSyHX5qx8D9YLtwwQ7RZyBV04Z0=;
        b=WAZZluKEXX9pmMmKRj3rSRiDfZuV8rQ18FUR1pWtTGWBcEZCEu3ML48nfeS38JR5Hj
         gzMNKWu/3wN2ZL3lSdMPxF/ZkeszLI4raMx9f+4xBFPmCDu5hNrqH8OAODxk2Coy4/sQ
         ayGA2YGPBUqEaACRgl6yrIcBpm8TbqsKkLkaObufU14EKLzsCeRznnqUuLDNEU1nIVJo
         VRnufEp0HPuP0d/OFe/8E+fdqKmRM7h04TcPWRwd0INXAOxSoB9VyAsKDdo5Soimu4DK
         +IjetH+BYRsEDzV+qlBP6WiQ1BhzY7uj8cJq+1gQIcqNU1utmO0t+DDZkImvtZJGEZwF
         CF5g==
X-Forwarded-Encrypted: i=1; AFNElJ9+rp+s3mUoAq3IIHervq5yvqc4UwZjwgPZRmHcmkF+2x7qHM8UIjbRGSrLezO7vd6ZfZ/WblXcNfkTXw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/KR9DHeb1rjndlv9sJjUaKFb81x8qT4U1jMluMrGU6hPiizuH
	ZA64jG5tBORCp079S4jwQ9IgbOPPdelsNoxVrqaYbMeculRFTQxWqvmp
X-Gm-Gg: Acq92OHH3xpBvAxqsLiwDkZf0KQYsIy0gl+WrO+6ORnjuFApno9Bj5/MYBMlOWlELeO
	yWXmQc6yN50/Cl68ZUbEjkNUT0GTNw55LCJnmeXQSmmYkx3J5C2P9zj9YO31zLyICDZvG65Edx+
	EQzev5G6w4n+zh97WaLa6NEQBFY1SuzaFBWmJqvd4zISOidHhOgKkr4x3KorBeCiQxqzCevbXG0
	64FKlnsd0c5pFNWfmJuFTqKT+8mFr3UFlI+iHfRBEyJHNIvhktGK+d3/xW8ZB2ORTC8whWz9hf2
	t0MyzwV6QTjk9TfEsFqF9iIEYoaCKJLT0sDscIgvqVnytKlStKdLpBaTxYLm8uJ+u6+UYeQ1R/8
	yIlBv7N5oef3YQxXS1yJ9w1Uf5kbTGWwyrlBEN9FGvXvNj8ywb2GjcG2BY+y4kwr8x9DkG52Dv8
	9fwGbZ/wP+loi9lpz8FLSp6Ca3E5qFrSSeopncZyB945nsQtko
X-Received: by 2002:a17:902:d482:b0:2bd:6e1c:3ce with SMTP id d9443c01a7336-2beb065a670mr133250745ad.20.1779650915622;
        Sun, 24 May 2026 12:28:35 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58d9fe9sm71489785ad.65.2026.05.24.12.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:28:35 -0700 (PDT)
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
Subject: [PATCH v4 24/36] iio: pressure: hid-sensor-press: use local struct device
Date: Mon, 25 May 2026 00:58:07 +0530
Message-Id: <20260524192812.1196549-5-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260524192812.1196549-1-sanjayembedded@gmail.com>
References: <20260524192812.1196549-1-sanjayembedded@gmail.com>
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
 drivers/iio/pressure/hid-sensor-press.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index a5db5220d3d5..d85f6247d8ab 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -242,14 +242,14 @@ static int press_parse_report(struct platform_device *pdev,
 /* Function to initialize the processing for usage id */
 static int hid_press_probe(struct platform_device *pdev)
 {
-	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(dev);
 	int ret = 0;
 	static const char *name = "press";
 	struct iio_dev *indio_dev;
 	struct press_state *press_state;
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev,
-				sizeof(struct press_state));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(struct press_state));
 	if (!indio_dev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, indio_dev);
@@ -264,14 +264,14 @@ static int hid_press_probe(struct platform_device *pdev)
 					press_sensitivity_addresses,
 					ARRAY_SIZE(press_sensitivity_addresses));
 	if (ret) {
-		dev_err(&pdev->dev, "failed to setup common attributes\n");
+		dev_err(dev, "failed to setup common attributes\n");
 		return ret;
 	}
 
-	indio_dev->channels = devm_kmemdup(&pdev->dev, press_channels,
+	indio_dev->channels = devm_kmemdup(dev, press_channels,
 					   sizeof(press_channels), GFP_KERNEL);
 	if (!indio_dev->channels) {
-		dev_err(&pdev->dev, "failed to duplicate channels\n");
+		dev_err(dev, "failed to duplicate channels\n");
 		return -ENOMEM;
 	}
 
@@ -279,7 +279,7 @@ static int hid_press_probe(struct platform_device *pdev)
 				 (struct iio_chan_spec *)indio_dev->channels,
 				 HID_USAGE_SENSOR_PRESSURE, press_state);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to setup attributes\n");
+		dev_err(dev, "failed to setup attributes\n");
 		return ret;
 	}
 
@@ -294,13 +294,13 @@ static int hid_press_probe(struct platform_device *pdev)
 	ret = hid_sensor_setup_trigger(indio_dev, name,
 				&press_state->common_attributes);
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
 
@@ -310,7 +310,7 @@ static int hid_press_probe(struct platform_device *pdev)
 	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_PRESSURE,
 					&press_state->callbacks);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "callback reg failed\n");
+		dev_err(dev, "callback reg failed\n");
 		goto error_iio_unreg;
 	}
 
-- 
2.34.1

