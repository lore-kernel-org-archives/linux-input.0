Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAD047D468;
	Thu,  6 Aug 2026 12:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786019204; cv=none; b=mIwi801wH++o52IyGDjJyAPY8k1gIsav0OOEDeL13qpcARWq3+zTtBY5zRv+VvnuqBmyYAvW+66vtFwIaNeJyibabhHPRo2rUnNHDhazlMD1MAYqwUljbmY/fK2SAS6MfGuZgGX2DRRJ00CLOqwGEXQclvO6Rtxo2NY5vBNkuVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786019204; c=relaxed/simple;
	bh=XodsOen8Wvzg78o0lwyC8zvGmdjAid2TnVU+SOWZRpc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cg0BxJGHxnWDDabZ4K5NI+bAi6u9Z1nS9aB3kTtkS/fO8zs+f8kYTxqX4OlVSUIsjc/sP8SCyEVBls/kWZqsmqzd1gl54kBZys+coV+/D9+ROF1ekPPDb1NpcdUL/7b1PD76lbLqXm4+yGRptzZntTebI6HNPeOxZ0X1/RgoI7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7ViTu5T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7ViTu5T"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0318C2BCF7;
	Thu,  6 Aug 2026 12:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786019203;
	bh=XodsOen8Wvzg78o0lwyC8zvGmdjAid2TnVU+SOWZRpc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=d7ViTu5TUespo5kCkTWdLVDXPhE31f7bd5KV+viZj9Csp0KiR/yrHp1jC69K7pmdk
	 1wLfrl/HC43Z6nAC38r8KU4IGc+NliwY7x2Z4/9F+iemC5a5WjqnDPOsmMQEcpTGT7
	 7L+P32ciOxT6K8FYIoABucTk6OXbs7DctgZADSw8toggIftJ2neKjRL03rSvi1NCpI
	 MlWx8tRGuzgA2v0Tuk44m523MpiJyUFgIatVttLf/ZqlcYdQx+Q6P6D0hBQiKrfJhv
	 Rr2yQGkIyXLa9pqysc6vKY1BAlevK1wDKov96DGQFBU8RIAofl2Sy/wshgondZjm+K
	 B+d6GKECBIVtw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC799C5AC7A;
	Thu,  6 Aug 2026 12:26:43 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Thu, 06 Aug 2026 17:55:50 +0530
Subject: [PATCH v5 04/13] iio: gyro: hid-sensor-gyro-3d: convert probe and
 teardown to devm-managed resources
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-4-f1f92c1d830f@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786019201; l=3576;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=93lHICIbaqkhzBStetBiddfJA0a+d0oJo1BZpquDDZw=;
 b=nd3GPjtbCy3xPC/pFnqY3PhBohtwqr33T8ott9DtmgItLuVHqIKRtGjDC42zeI5Ctjk8OZlpE
 vzJ9G81aSxPBRy46QoEBR+rDDWTVmuXb/FzV7XH2NV7HNZIpv6sIHRr
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
 drivers/iio/gyro/hid-sensor-gyro-3d.c | 41 ++++++++---------------------------
 1 file changed, 9 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index cf049700d415..66778315e86d 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -264,7 +264,8 @@ static int gyro_3d_parse_report(struct platform_device *pdev,
 /* Function to initialize the processing for usage id */
 static int hid_gyro_3d_probe(struct platform_device *pdev)
 {
-	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(dev);
 	int ret = 0;
 	static const char *name = "gyro_3d";
 	struct iio_dev *indio_dev;
@@ -311,8 +312,8 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 
 	atomic_set(&gyro_state->common_attributes.data_ready, 0);
 
-	ret = hid_sensor_setup_trigger(indio_dev, name,
-				       &gyro_state->common_attributes);
+	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, name,
+					    &gyro_state->common_attributes);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "trigger setup failed\n");
 		return ret;
@@ -321,38 +322,15 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 	gyro_state->callbacks.send_event = gyro_3d_proc_event;
 	gyro_state->callbacks.capture_sample = gyro_3d_capture_sample;
 	gyro_state->callbacks.pdev = pdev;
-	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D,
-					   &gyro_state->callbacks);
+	ret = devm_sensor_hub_register_callback(dev, hsdev,
+						HID_USAGE_SENSOR_GYRO_3D,
+						&gyro_state->callbacks);
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
-	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);
-error_remove_trigger:
-	hid_sensor_remove_trigger(&gyro_state->common_attributes);
-	return ret;
-}
-
-/* Function to deinitialize the processing for usage id */
-static void hid_gyro_3d_remove(struct platform_device *pdev)
-{
-	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct gyro_3d_state *gyro_state = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);
-	hid_sensor_remove_trigger(&gyro_state->common_attributes);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct platform_device_id hid_gyro_3d_ids[] = {
@@ -371,7 +349,6 @@ static struct platform_driver hid_gyro_3d_platform_driver = {
 		.pm	= &hid_sensor_pm_ops,
 	},
 	.probe		= hid_gyro_3d_probe,
-	.remove		= hid_gyro_3d_remove,
 };
 module_platform_driver(hid_gyro_3d_platform_driver);
 

-- 
2.34.1


