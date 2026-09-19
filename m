Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABE1471CEB;
	Sat, 19 Sep 2026 10:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789814202; cv=none; b=ACFoISYTWHfkPGJ4Xq64LCbgUijc3qOnh7+IQGB49EDs7VBM7hesUoifvqK2+m2pgj3WosZahVMJ7CKDGMr5EvloKjQLzoAB+zloj9qSEG43q0Q8N7QrS+bMlcS9xCSGapx67y5U+Za1tTeJ60g+OJZGku9mjVTI/aK87R6uEDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789814202; c=relaxed/simple;
	bh=1+LATJmQfGnsPHSpLjng0/+Dl6/lw5qZw/neErfDwj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ta7gWhLer6uB5qX6W6qF28/A6ofJypyQ87m6DhHg0u2CiyYGDMH0qnC2ELPTw0zaF7BBOhfCNl47J7ypwAstboPz+tfIg9Mh2ZjyA1oTmeSyNEREcSzTszAK8OSz91SaRVRjP1KsnTIIjsPSqNVfa7Tz1YtHZQ1p+sDJTxsGf3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EACwITYB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EACwITYB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC86BC2BCFC;
	Sat, 19 Sep 2026 10:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789814201;
	bh=1+LATJmQfGnsPHSpLjng0/+Dl6/lw5qZw/neErfDwj4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EACwITYBCjekTo5/DP26jX7gRWqrWFgB2lWhTpT3AhQIDXblBN8CzOTJ3pCtneOMa
	 6W/ugYlDgUz12RKNxM3bsxX6lZ7OM/Mv2xdIlzHT3mFfk0xPXTAaz8GB+rOTa7WAEU
	 LCDYoYoJ1Vp3srQxXc3QRVr86KpSFBRfqPsi8tJ5/6GL01pCCYvLpNAY2c98RJQQOe
	 iueRrvwhC/zd44spJ7Gsx8lIgaCAWUOUy8+BRGYa0W9ifnAcswbxieEohSV2pDHLqU
	 Hzm9g+6uz+IXwWN8cSB/MJMvcDJ9LE2eWe1rrZX4RE/GfX03mBze2+VNUHOFa0Xz7u
	 t0oJD46uxHNqw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D6BC982D7;
	Sat, 19 Sep 2026 10:36:41 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Sat, 19 Sep 2026 16:06:33 +0530
Subject: [PATCH v6 10/14] iio: orientation: hid-sensor-incl-3d: convert
 probe and teardown to devm-managed resources
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-28-apr-iio-redundant-argument-v5-temp-v6-10-d577b2371b3c@gmail.com>
References: <20260919-28-apr-iio-redundant-argument-v5-temp-v6-0-d577b2371b3c@gmail.com>
In-Reply-To: <20260919-28-apr-iio-redundant-argument-v5-temp-v6-0-d577b2371b3c@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789814199; l=3627;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=Db8QZy6XNbEvWiQnvLmsz7HdMBrrBkrM5ikOGII6cRw=;
 b=CCMRrubCqlNjcIwmr43ocCUKAfUiLWWhud7I7i7WCw2utA4U2//EBGLCxdDmUE23BYXFstoDJ
 2O09aSiAiinCUtbWCOU9e8VQuXyyk5w0Z9m5irGw96j/2kiWvIcyxfy
X-Developer-Key: i=sanjayembeddedse@gmail.com; a=ed25519;
 pk=PcneEFtkmY+Ldl+KmOTpB/Q/HDsqko6Fb0/Z/5cuycI=
X-Endpoint-Received: by B4 Relay for sanjayembeddedse@gmail.com/20260702
 with auth_id=848
X-Original-From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Reply-To: sanjayembeddedse@gmail.com

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Convert HID IIO driver resource management to use devm-managed helpers,
tying the lifetime of all resources to the device.

HID trigger setup, IIO registration, and sensor hub callback resource
are now managed using devm APIs. Cleanup logic previously handled
explicitly in probe error and teardown paths.

This simplifies the probe path by removing goto-based error handling,
eliminates the remove callback entirely.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/orientation/hid-sensor-incl-3d.c | 42 ++++++----------------------
 1 file changed, 9 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
index 435e70557721..b5f70732d035 100644
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -293,7 +293,8 @@ static int incl_3d_parse_report(struct platform_device *pdev,
 /* Function to initialize the processing for usage id */
 static int hid_incl_3d_probe(struct platform_device *pdev)
 {
-	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(dev);
 	int ret;
 	static char *name = "incli_3d";
 	struct iio_dev *indio_dev;
@@ -343,8 +344,8 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
 
 	atomic_set(&incl_state->common_attributes.data_ready, 0);
 
-	ret = hid_sensor_setup_trigger(indio_dev, name,
-				       &incl_state->common_attributes);
+	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, name,
+					    &incl_state->common_attributes);
 	if (ret) {
 		dev_err(&pdev->dev, "trigger setup failed\n");
 		return ret;
@@ -353,39 +354,15 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
 	incl_state->callbacks.send_event = incl_3d_proc_event;
 	incl_state->callbacks.capture_sample = incl_3d_capture_sample;
 	incl_state->callbacks.pdev = pdev;
-	ret = sensor_hub_register_callback(hsdev,
-					   HID_USAGE_SENSOR_INCLINOMETER_3D,
-					   &incl_state->callbacks);
+	ret = devm_sensor_hub_register_callback(dev, hsdev,
+						HID_USAGE_SENSOR_INCLINOMETER_3D,
+						&incl_state->callbacks);
 	if (ret) {
 		dev_err(&pdev->dev, "callback reg failed\n");
-		goto error_remove_trigger;
-	}
-
-	ret = iio_device_register(indio_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "device register failed\n");
-		goto error_remove_callback;
+		return ret;
 	}
 
-	return 0;
-
-error_remove_callback:
-	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_INCLINOMETER_3D);
-error_remove_trigger:
-	hid_sensor_remove_trigger(&incl_state->common_attributes);
-	return ret;
-}
-
-/* Function to deinitialize the processing for usage id */
-static void hid_incl_3d_remove(struct platform_device *pdev)
-{
-	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct incl_3d_state *incl_state = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_INCLINOMETER_3D);
-	hid_sensor_remove_trigger(&incl_state->common_attributes);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct platform_device_id hid_incl_3d_ids[] = {
@@ -404,7 +381,6 @@ static struct platform_driver hid_incl_3d_platform_driver = {
 		.pm	= &hid_sensor_pm_ops,
 	},
 	.probe		= hid_incl_3d_probe,
-	.remove		= hid_incl_3d_remove,
 };
 module_platform_driver(hid_incl_3d_platform_driver);
 

-- 
2.34.1


