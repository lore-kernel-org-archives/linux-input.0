Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E870E47A87C;
	Thu,  6 Aug 2026 12:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786019205; cv=none; b=uwsszv7pw8E/7r2HHTq8N2AS2uqBST54p77LogfXK2G2rkE6dMSyJqd626NgncrHzsyxdUIsQIL9ipSAyPWJzPJuUYjW6pxh3Jo2NNmmbNN2LWwWN30w44mOluuMUfkYqxmPcunfM2hTuYQ1d/dwD5e6/L2U9OPhd11j59v5wBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786019205; c=relaxed/simple;
	bh=AWnCnKefvG4UVNmB6J2v9FQ7IUmYciYkW+vBmT2hi64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kEuRBeWNxLtb962oyYldVIfJ3l36iOuotIgVyeJsq6lH/7k2dCFfoPRntEGcAhrIut4A5Xu45ULb4pghvwCuWBeRaN+PP9fP7etrUFnP3P4Aqfd9kM1s3qctpqa61yNB0f3HAh/Otn9oqxBz5CmCJDY50ot5xgh1gUYUKfpzwgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VC+jdcej; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VC+jdcej"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54EEEC2BD01;
	Thu,  6 Aug 2026 12:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786019204;
	bh=AWnCnKefvG4UVNmB6J2v9FQ7IUmYciYkW+vBmT2hi64=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VC+jdcejkGeD2hBJBrytRCJFdIAksFu4v7bgc0G+jnnM8uEg0C3pK2HhHl8xjtqmL
	 x2+bWty9fJaGBebg0zeKBmJQ4/IKE/IsuOJ4XHYSPstUq2dwm5GiD//PgeYUbCpddu
	 YACD/01hEEWJeO5bL4fPTSFv2zBpjA/nkOduA/WCRJ3y78+rrzduYhKZF+F6ziIzxV
	 kuN6PKlJhqXJmlEmzEuTimiDjBVMJa17utuXgMKkX1TbwM96rtIf8PGIHIhvltynW0
	 OtdY/MjknOLsevd/5KSt1mRvMsj5eTUoPlfCLZa3KaTyALcldG5anzR8iceYDsFyUW
	 ZH1c7sHOE481w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429ACC56208;
	Thu,  6 Aug 2026 12:26:44 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Thu, 06 Aug 2026 17:55:55 +0530
Subject: [PATCH v5 09/13] iio: magnetometer: hid-sensor-magn-3d: convert
 probe and teardown to devm-managed resources
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-9-f1f92c1d830f@gmail.com>
References: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-0-f1f92c1d830f@gmail.com>
In-Reply-To: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-0-f1f92c1d830f@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786019201; l=3629;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=psVvPChQvmnDeqq5c0sAzyCmhiEktLAbJoySPLiD/3g=;
 b=JtmCBV4eRexLF3nQbqCZPGXDJ+m0LWy9uJ7HS+T109gjkI2MPjw4XbwnB3NtiCCKh3iPppLI7
 ithdY7N7IYHDiuNlj1utSJUSzElVk4zSPD4mNuT1AgTV1FaQV0o7I7w
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
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 41 ++++++---------------------
 1 file changed, 9 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index 5402cffa8326..c8b4fa7785c9 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -450,7 +450,8 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 /* Function to initialize the processing for usage id */
 static int hid_magn_3d_probe(struct platform_device *pdev)
 {
-	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(dev);
 	int ret = 0;
 	static char *name = "magn_3d";
 	struct iio_dev *indio_dev;
@@ -498,8 +499,8 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 
 	atomic_set(&magn_state->magn_flux_attributes.data_ready, 0);
 
-	ret = hid_sensor_setup_trigger(indio_dev, name,
-				       &magn_state->magn_flux_attributes);
+	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, name,
+					    &magn_state->magn_flux_attributes);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "trigger setup failed\n");
 		return ret;
@@ -508,38 +509,15 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 	magn_state->callbacks.send_event = magn_3d_proc_event;
 	magn_state->callbacks.capture_sample = magn_3d_capture_sample;
 	magn_state->callbacks.pdev = pdev;
-	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_COMPASS_3D,
-					   &magn_state->callbacks);
+	ret = devm_sensor_hub_register_callback(dev, hsdev,
+						HID_USAGE_SENSOR_COMPASS_3D,
+						&magn_state->callbacks);
 	if (ret < 0) {
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
 
-	return ret;
-
-error_remove_callback:
-	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_COMPASS_3D);
-error_remove_trigger:
-	hid_sensor_remove_trigger(&magn_state->magn_flux_attributes);
-	return ret;
-}
-
-/* Function to deinitialize the processing for usage id */
-static void hid_magn_3d_remove(struct platform_device *pdev)
-{
-	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct magn_3d_state *magn_state = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_COMPASS_3D);
-	hid_sensor_remove_trigger(&magn_state->magn_flux_attributes);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct platform_device_id hid_magn_3d_ids[] = {
@@ -558,7 +536,6 @@ static struct platform_driver hid_magn_3d_platform_driver = {
 		.pm	= &hid_sensor_pm_ops,
 	},
 	.probe		= hid_magn_3d_probe,
-	.remove		= hid_magn_3d_remove,
 };
 module_platform_driver(hid_magn_3d_platform_driver);
 

-- 
2.34.1


