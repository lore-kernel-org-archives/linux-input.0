Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54C847A86C;
	Thu,  6 Aug 2026 12:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786019205; cv=none; b=uN+ByH0b6OjgjKKevXIuJU1o48Wz8jXqzApn0loo3L5yEY02KvMtHMeMyQi9SyokzdPTpQHqxy1xX5BcPWF/dzipO5hRTc4WniLv2iT8pTGYNpu5UNaKey2rtd5R+/fiBt7vD8Pu2kJ6BYZMmZDtDiiJAHbWUAEdmAOpdVL3agk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786019205; c=relaxed/simple;
	bh=d0a1H9PELbVmQhNglK5y5FtIcmnFR2yg9BW8d3/JhTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eP5Nbbop4d5ULJ+7ZDvgzLb19LKDHc6JCHO0I8DYfWCr3AVDKUvLHDv9ME/GmUcXj2XJppj0Ez5dXrDjNdJijOyU7EPy1w2VOstWR/ilSNrvQ/3fVGUt85bKEkDg/UgkSCTxXhhlMTMTdnwyW07tP6HLCDyoHEu5oko/0g/BkIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GP5AsiyJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GP5AsiyJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C976FC2BCC7;
	Thu,  6 Aug 2026 12:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786019204;
	bh=d0a1H9PELbVmQhNglK5y5FtIcmnFR2yg9BW8d3/JhTY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GP5AsiyJtxfXyd+36tOMhpKyOHictjJQtRSRU0RzjFlpCxgu0a9jTd58lT8pJR24/
	 /V43PKpQ4wVhH2VqrEr/lQpkxqLgFWtO5QYw4Doudwo8cNZY7pnMyPQS9h8UNVzxg+
	 lQ5xp55LygwFHIgJb5BmQWrOMryg0Gye9ZO9Cl1wF33bQsuDWYkXwuivn70rYOkzWv
	 +KmoRe9MTDcby7NuCuiV8tU1xIthI+oGzikNl38QoH6bZE4x2FP90ab85JRpSCmnjQ
	 TJevYO/NxP9fWmOo5KyuOZhE9PKZV3MMsfWeT8EMEULB0jJ+sHMq2G7+mjawcb6kOU
	 qJyebnsMqiJgg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F2EC56208;
	Thu,  6 Aug 2026 12:26:44 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Thu, 06 Aug 2026 17:55:58 +0530
Subject: [PATCH v5 12/13] iio: position: hid-sensor-custom-intel-hinge:
 convert probe and teardown to devm-managed resources
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-12-f1f92c1d830f@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786019201; l=3491;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=i4Tkmjvqq1X1HXfT1Ajunvn9KfzjkXAM5FZZp1If76U=;
 b=g9Qs3oAR/8y07kBUhgIdBKN8jyEfSALZp3YeMKjflozG38xbGe7blLrKmZsxHls9w8o7LxIui
 ZhXklD+Qdy8BwvaT+ZOt9nPlHksb7doMYNwPPVgDePCVJVUjWy/9TTG
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
 .../iio/position/hid-sensor-custom-intel-hinge.c   | 38 ++++------------------
 1 file changed, 7 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/position/hid-sensor-custom-intel-hinge.c b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
index 7f6186fea004..101d84b533c9 100644
--- a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
+++ b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
@@ -263,7 +263,8 @@ static int hinge_parse_report(struct platform_device *pdev,
 /* Function to initialize the processing for usage id */
 static int hid_hinge_probe(struct platform_device *pdev)
 {
-	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(dev);
 	struct hinge_state *st;
 	struct iio_dev *indio_dev;
 	int ret;
@@ -310,8 +311,8 @@ static int hid_hinge_probe(struct platform_device *pdev)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	atomic_set(&st->common_attributes.data_ready, 0);
-	ret = hid_sensor_setup_trigger(indio_dev, indio_dev->name,
-				       &st->common_attributes);
+	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, indio_dev->name,
+					    &st->common_attributes);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "trigger setup failed\n");
 		return ret;
@@ -320,37 +321,13 @@ static int hid_hinge_probe(struct platform_device *pdev)
 	st->callbacks.send_event = hinge_proc_event;
 	st->callbacks.capture_sample = hinge_capture_sample;
 	st->callbacks.pdev = pdev;
-	ret = sensor_hub_register_callback(hsdev, hsdev->usage, &st->callbacks);
+	ret = devm_sensor_hub_register_callback(dev, hsdev, hsdev->usage, &st->callbacks);
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
-	sensor_hub_remove_callback(hsdev, hsdev->usage);
-error_remove_trigger:
-	hid_sensor_remove_trigger(&st->common_attributes);
-	return ret;
-}
-
-/* Function to deinitialize the processing for usage id */
-static void hid_hinge_remove(struct platform_device *pdev)
-{
-	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct hinge_state *st = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	sensor_hub_remove_callback(hsdev, hsdev->usage);
-	hid_sensor_remove_trigger(&st->common_attributes);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct platform_device_id hid_hinge_ids[] = {
@@ -369,7 +346,6 @@ static struct platform_driver hid_hinge_platform_driver = {
 		.pm	= &hid_sensor_pm_ops,
 	},
 	.probe		= hid_hinge_probe,
-	.remove		= hid_hinge_remove,
 };
 module_platform_driver(hid_hinge_platform_driver);
 

-- 
2.34.1


