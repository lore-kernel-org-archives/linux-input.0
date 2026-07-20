Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A183C4546;
	Mon, 20 Jul 2026 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540426; cv=none; b=CYNVEcG+TY68AQOJnFgi06R/+x94mlp+IbYUI/LFpowI2hkRODcbTdihZhjOuMk0OTS2dGy4INvTczobiu/qGhWsZlFDuyABdFC02RToeu4qrgkxTyNiX/cT0SWmSrrkk8HolkxxAMUrWKy23aAV25Z1GRVNx/g/5ItJqUIXU9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540426; c=relaxed/simple;
	bh=+9v4q9BYAVKlGMelfBqiS4gsgM3yxHv0naNXqba2YMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ulplu2GkCc199/3yT5kZ4YhVRFcv2drY+vPX8htm/I2BFbmOAl8CTF0rMSHETtt9Rg0XmYzbw74xvl/ray3b97aO865fnRsCvyzqAW9PBkZ1wrjOWrRHkCzPY+jINVWADdCRGhAAxyethIPfm38OoyrwiGkDe7xmT0yUeNUDLwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGIDo39z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGIDo39z"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9751BC2BCF6;
	Mon, 20 Jul 2026 09:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784540425;
	bh=+9v4q9BYAVKlGMelfBqiS4gsgM3yxHv0naNXqba2YMg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LGIDo39zN/OZEY41q/dckexL9JYV5PxvYuzNmambh4raTOHsmvQSmVax/XgaUv2bG
	 bYzKFeRsn05tG8MxIO2foVj54PkdzOX41Wch3gb1hs033BktjBEDV7QJ0AtMka61Gz
	 zZ8A80L8BSAonmT1G94xNl8u6nXiXW4m7P83AntqgcPe15gRyaDL8pQ2y89BoUFijk
	 EAUZYzQnK0ixO7oxJVuBORPaSvsFysnlcsw71KC77Iv4XJ0LB8dcq9Yyl9rAk7OmOZ
	 OSxSaGYGpFOe/H2tPkyub0EfnSPiq2Ckjp3Rx/P5Yv4aDsjINq2h1vTgyF4noBqnT/
	 SRJRxm4gGERaw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A08EC44527;
	Mon, 20 Jul 2026 09:40:25 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Mon, 20 Jul 2026 15:10:14 +0530
Subject: [PATCH 02/10] iio: gyro: hid-sensor-gyro-3d: use local struct
 device
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-hid-iio-local-struct-device-v1-2-74496fee6327@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784540423; l=3130;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=sbocTFLcC7tO6VvGktZQw3Yf/IDevdn1SGxGLRUlz/g=;
 b=BJ+AWfejLnjSYVYfisGbfjSIB04eZhmotWpzs1BSZPGKg8MnCcQXd95YB0IZxLS1Hf0qpDyuq
 bpPhFUuPWngDOyxofIcldqJsIeFsxnrBAK9yzixovyd3JVdjVviLIno
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
 drivers/iio/gyro/hid-sensor-gyro-3d.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index 58250a972567..8ff3ceda6dab 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -264,13 +264,14 @@ static int gyro_3d_parse_report(struct platform_device *pdev,
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
@@ -285,14 +286,14 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
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
 
@@ -300,7 +301,7 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 				   (struct iio_chan_spec *)indio_dev->channels,
 				   HID_USAGE_SENSOR_GYRO_3D, gyro_state);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to setup attributes\n");
+		dev_err(dev, "failed to setup attributes\n");
 		return ret;
 	}
 
@@ -314,7 +315,7 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 	ret = hid_sensor_setup_trigger(indio_dev, name,
 				       &gyro_state->common_attributes);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "trigger setup failed\n");
+		dev_err(dev, "trigger setup failed\n");
 		return ret;
 	}
 
@@ -324,13 +325,13 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D,
 					   &gyro_state->callbacks);
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


