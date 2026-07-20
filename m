Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E5E3D6CCA;
	Mon, 20 Jul 2026 09:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540426; cv=none; b=Wcehz0Z52cnt3wXdg9h438GNH5eZMBFIzX39C6i2lLn3tiC8Uec+6jF/LGjRh5XD6v4Y09pw4a/xIhupT7s/XOW5f6npyV6/S9/Hkkzet57fMGwstFXopEg3DDnVMdqvWDR2F3fWZZ6SVN/693JX3VvMNpTIMUF91dnkxVQ62XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540426; c=relaxed/simple;
	bh=DWsr9PTPwYYSUNvHLOJuCWKBPTXPLLa+QAvB/+nc7I4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DaSMSBMHlR6IKOQxKZg1KRn9Si7hRJ9voQ7I1MPoXVtkuDYugTkEB4EbY81B5MaWkgfKW03iWhcVZ+21XmYbXcdQh4jGjrEQXnAE8WTGM2tRarE/S1RQ+wMk71TyArP9zwjqDK2MBMjeBv923mjMLGI5RfxvpvFhrlc+wAFyDg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRuGjJjx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRuGjJjx"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 389F6C2BCFD;
	Mon, 20 Jul 2026 09:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784540426;
	bh=DWsr9PTPwYYSUNvHLOJuCWKBPTXPLLa+QAvB/+nc7I4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cRuGjJjxA4JZxz0MGRso1bY/PKFbj0EUSFF9IzmgWBigdpd/LGY2KPq4E8Zf3v7w9
	 UVeDev9kjsjbbZGSnAbhK7oTQY1RUOULynZa00twUMWMXdFZq48IEZRjqP36Q3Vzfm
	 4l+QJu8kQg3M7YfeiHLp+O8lb0Kg/BX9NY+HRtD5cBHcRVg77QvAzqCpTnvIp7YED8
	 O9qiPEYb8h64j8e8Te3V8uzoXQ1ABSZLB/iYk7T9cBeMZx3OAWmBUuUnit8IzYfd9D
	 7C7rWGBbH2anfsHw4tEOegVX+jAW6DFnMuyj22nIFs9mELvbcyjKv5Zp2VAwJ4Yxca
	 oYUITcBX0Crxg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CEFC44527;
	Mon, 20 Jul 2026 09:40:26 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Mon, 20 Jul 2026 15:10:22 +0530
Subject: [PATCH 10/10] iio: pressure: hid-sensor-press: use local struct
 device
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-hid-iio-local-struct-device-v1-10-74496fee6327@gmail.com>
References: <20260720-hid-iio-local-struct-device-v1-0-74496fee6327@gmail.com>
In-Reply-To: <20260720-hid-iio-local-struct-device-v1-0-74496fee6327@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784540423; l=3124;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=KprakpDFPiwIPtA12YpCnWpXHOfCF0716+NW98RCOhE=;
 b=mbh6hvgT9+rdmxJAM7i6ZzhwW0uWhPEsY2qlpJRuZk5H5A2g9/mwOrgF4jjVli0KhtGFMDejv
 rnm20xClbDSCLTLM6gNtNHecByJDjUsgamb2JohWEbDuU2CfRcaUwOU
X-Developer-Key: i=sanjayembeddedse@gmail.com; a=ed25519;
 pk=PcneEFtkmY+Ldl+KmOTpB/Q/HDsqko6Fb0/Z/5cuycI=
X-Endpoint-Received: by B4 Relay for sanjayembeddedse@gmail.com/20260702
 with auth_id=848
X-Original-From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Reply-To: sanjayembeddedse@gmail.com

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Introduce a local struct device pointer derived from &pdev->dev.
This avoids repeated &pdev->dev usage and improves readability.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/pressure/hid-sensor-press.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index e688b0776547..fee170aa4379 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -230,13 +230,14 @@ static int press_parse_report(struct platform_device *pdev,
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
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(struct press_state));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(struct press_state));
 	if (!indio_dev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, indio_dev);
@@ -251,14 +252,14 @@ static int hid_press_probe(struct platform_device *pdev)
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
 
@@ -266,7 +267,7 @@ static int hid_press_probe(struct platform_device *pdev)
 				 (struct iio_chan_spec *)indio_dev->channels,
 				 HID_USAGE_SENSOR_PRESSURE, press_state);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to setup attributes\n");
+		dev_err(dev, "failed to setup attributes\n");
 		return ret;
 	}
 
@@ -281,7 +282,7 @@ static int hid_press_probe(struct platform_device *pdev)
 	ret = hid_sensor_setup_trigger(indio_dev, name,
 				       &press_state->common_attributes);
 	if (ret) {
-		dev_err(&pdev->dev, "trigger setup failed\n");
+		dev_err(dev, "trigger setup failed\n");
 		return ret;
 	}
 
@@ -291,13 +292,13 @@ static int hid_press_probe(struct platform_device *pdev)
 	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_PRESSURE,
 					   &press_state->callbacks);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "callback reg failed\n");
+		dev_err(dev, "callback reg failed\n");
 		goto error_remove_trigger;
 	}
 
 	ret = iio_device_register(indio_dev);
 	if (ret) {
-		dev_err(&pdev->dev, "device register failed\n");
+		dev_err(dev, "device register failed\n");
 		goto error_remove_callback;
 	}
 

-- 
2.34.1


