Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76163D45CB;
	Mon, 20 Jul 2026 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540426; cv=none; b=U3O2XnrMmRoFZw0GOHVGOOEVDGwkRfi7jthGzy17d8TeFXOmi62UgaLWEd2QQ0+UplIW+DriVSY/5xWqSwhBUYtd7iHhiKw/rw10BRsN2VWqSLVeeQOVqf5gOIQLRfFvXKtx7hVlXg/VRt563DFYgtq2DrQVN6zAOqmuZYesDbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540426; c=relaxed/simple;
	bh=f/RNp5qcwybkfeN/HanUf56pHEeRgjyLnoKetz64Vhc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oCK8ZpvO9XuhbKjDOhhhy3NVWG1YApdMA6BHox9mJjK9SzFCFIDD1KrT1Mdr37I1HXFXNR1vEuSUq8dXReFw8YIqe2g+5kNb0ARkWNRr6xJmqn7S6BqvF8r/9Z5TZytc/0iQYm7joTFHwm+UaHkqwvB5hVUmFNZpr8Pl9P0DiyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSQ3PxQN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSQ3PxQN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4E37C2BCFD;
	Mon, 20 Jul 2026 09:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784540425;
	bh=f/RNp5qcwybkfeN/HanUf56pHEeRgjyLnoKetz64Vhc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fSQ3PxQNOP4nP9kkYE+JgZVWKqa3j0x6XzqvTcXyalWZ1RFgbQRTgjGEFdV+JInea
	 fI8toILJxnLuHBTaMzySOnbmF1XGcgfN/ol3YAmXwUcSvDO03ml4Y7/lzGBb5YwtU5
	 zrVB7DVcCB3Do7G03F+THvWu20rbyBRxZrBjEIVLOcqCCdtK2wwAuPxXMl5JcSY6il
	 LNXFGzCWmIKF7dgF+vQzLZanfo6VhtkU3JUgFtmaKcM0EsbDAvHLaZsvSOgOoj9Rvh
	 xTECvThXaXR+OONbLHLTyWOMb26U/9h6/+9Dmwe4bmjXbosgrD90vIYdAdPDRzm11W
	 ZnSFhvptY9t7g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C328C44528;
	Mon, 20 Jul 2026 09:40:25 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Mon, 20 Jul 2026 15:10:15 +0530
Subject: [PATCH 03/10] iio: accel: hid-sensor-accel-3d: use local struct
 device
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-hid-iio-local-struct-device-v1-3-74496fee6327@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784540423; l=3184;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=CHrL5pLuWoANqRnTUQhBxvjRxrsqGaR+mjcFFDbcdqU=;
 b=jvPykdZK1FZL5BRq/q/lUtRSM7gO1wAB8CWI2GuTQYgmVnGABIc0qmpbT/Zod8t+3/eDeIOxv
 TstVMjJkp46C+vNCunsNzJt0K/Y7cHTZ8MprvLUPE48EpKBd4bmLbfZ
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
 drivers/iio/accel/hid-sensor-accel-3d.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index eb521125f4eb..5467ecc86b58 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -314,7 +314,8 @@ static int accel_3d_parse_report(struct platform_device *pdev,
 /* Function to initialize the processing for usage id */
 static int hid_accel_3d_probe(struct platform_device *pdev)
 {
-	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(dev);
 	int ret = 0;
 	const char *name;
 	struct iio_dev *indio_dev;
@@ -322,8 +323,7 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 	const struct iio_chan_spec *channel_spec;
 	int channel_size;
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev,
-					  sizeof(struct accel_3d_state));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(struct accel_3d_state));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -350,21 +350,21 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 						 accel_3d_sensitivity_addresses,
 						 ARRAY_SIZE(accel_3d_sensitivity_addresses));
 	if (ret) {
-		dev_err(&pdev->dev, "failed to setup common attributes\n");
+		dev_err(dev, "failed to setup common attributes\n");
 		return ret;
 	}
-	indio_dev->channels = devm_kmemdup(&pdev->dev, channel_spec,
-					   channel_size, GFP_KERNEL);
 
+	indio_dev->channels = devm_kmemdup(dev, channel_spec, channel_size, GFP_KERNEL);
 	if (!indio_dev->channels) {
-		dev_err(&pdev->dev, "failed to duplicate channels\n");
+		dev_err(dev, "failed to duplicate channels\n");
 		return -ENOMEM;
 	}
+
 	ret = accel_3d_parse_report(pdev, hsdev,
 				    (struct iio_chan_spec *)indio_dev->channels,
 				    hsdev->usage, accel_state);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to setup attributes\n");
+		dev_err(dev, "failed to setup attributes\n");
 		return ret;
 	}
 
@@ -377,7 +377,7 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 	ret = hid_sensor_setup_trigger(indio_dev, name,
 				       &accel_state->common_attributes);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "trigger setup failed\n");
+		dev_err(dev, "trigger setup failed\n");
 		return ret;
 	}
 
@@ -387,13 +387,13 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 	ret = sensor_hub_register_callback(hsdev, hsdev->usage,
 					   &accel_state->callbacks);
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


