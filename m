Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C2E471D0D;
	Sat, 19 Sep 2026 10:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789814202; cv=none; b=Wo0nRwrdsIFAMuLBUokl6oJY6o0ab91BwuzRA5y6Md79/LOGXKv1HCBKdCMMRqeJjI+MMYui+REJUnR3JUVMRks1k4xLryl7rDEW4sWydSBmapkdxDFyc4rUETptdaY9Oy+oeDpdvSewQIthvWe6tgKJr4VLlU4QQcPk8gIRXrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789814202; c=relaxed/simple;
	bh=uC9HTsM+zLwIu+UmBHfWWd7X0n+u8+mFuo1hAIT5/Bs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F/CvODCE767YaqTmMNNxs7RQi4l9E5B77Aqz9izE+W+wuyxrRUMGau9JV3OR21TM+Zq4t4h4hbJ6cxvbyk9TOmDt+7JJQQYqgDBKc2qLZA7Ih4e7K2UKWZYk10iWRANgcTYDCrLALMn2/w3xslfkKJJy8pjkdIuF9xe0VgbxFSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMnARND4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMnARND4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9F81C2BCFB;
	Sat, 19 Sep 2026 10:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789814201;
	bh=uC9HTsM+zLwIu+UmBHfWWd7X0n+u8+mFuo1hAIT5/Bs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gMnARND4knGuPhWDQGku7sucArgNX8n6ZDYJqkAGdckKWeqJlyZTUYD3mUIKLPJdW
	 5g0zv0cAssMNRBkWc2GcC1C6tSqRj8UqDS8zhhhT7KZjgddZ7ROHUPSUnuBX2UukWF
	 ieUQ0eVX07y9omAuAZO2KteYvo7AXdc9zrhk5SiQ++XDtrzl8NLE4Ro3z4+OL8ubuy
	 XSvRAU1dN3e5haE76gOOq4qUwI41T2sFup6XyIg8tpcUqg+71nb3zpx9VmSVjQ7wx0
	 2UQ/Z92DGOuK3cjRtWGg0BFUDmsrIv/d8AGzm0wqtBsYcbyanYkX0+f+DNLbUAOtDZ
	 +AGZy6JN9fRzQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A59C982CC;
	Sat, 19 Sep 2026 10:36:41 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Sat, 19 Sep 2026 16:06:34 +0530
Subject: [PATCH v6 11/14] iio: orientation: hid-sensor-rotation: convert
 probe and teardown to devm-managed resources
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-28-apr-iio-redundant-argument-v5-temp-v6-11-d577b2371b3c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789814199; l=3506;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=TLV6V3PWBu6QuptSuYx3HwS02UbXDq6dcq/bnuc0xPo=;
 b=0z8FIMYiJiXoHY0Ebwou1EMKNtVnZ7DUPAPyjVnKSaqWmduafvWBhTBJ5X+jvdwoBf5oMOuL7
 OmvlmOrTfxwCPqr1PMyb+KpmexltWPB6NHhy3cOkI4JkcBsG8whmASM
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
 drivers/iio/orientation/hid-sensor-rotation.c | 40 ++++++---------------------
 1 file changed, 8 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index 061d76310fed..f97c278f16cb 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -301,7 +301,8 @@ static int dev_rot_parse_report(struct platform_device *pdev,
 /* Function to initialize the processing for usage id */
 static int hid_dev_rot_probe(struct platform_device *pdev)
 {
-	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(dev);
 	int ret;
 	char *name;
 	struct iio_dev *indio_dev;
@@ -356,8 +357,8 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
 
 	atomic_set(&rot_state->common_attributes.data_ready, 0);
 
-	ret = hid_sensor_setup_trigger(indio_dev, name,
-				       &rot_state->common_attributes);
+	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, name,
+					    &rot_state->common_attributes);
 	if (ret) {
 		dev_err(&pdev->dev, "trigger setup failed\n");
 		return ret;
@@ -366,38 +367,14 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
 	rot_state->callbacks.send_event = dev_rot_proc_event;
 	rot_state->callbacks.capture_sample = dev_rot_capture_sample;
 	rot_state->callbacks.pdev = pdev;
-	ret = sensor_hub_register_callback(hsdev, hsdev->usage,
-					   &rot_state->callbacks);
+	ret = devm_sensor_hub_register_callback(dev, hsdev, hsdev->usage,
+						&rot_state->callbacks);
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
-	sensor_hub_remove_callback(hsdev, hsdev->usage);
-error_remove_trigger:
-	hid_sensor_remove_trigger(&rot_state->common_attributes);
-	return ret;
-}
-
-/* Function to deinitialize the processing for usage id */
-static void hid_dev_rot_remove(struct platform_device *pdev)
-{
-	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct dev_rot_state *rot_state = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	sensor_hub_remove_callback(hsdev, hsdev->usage);
-	hid_sensor_remove_trigger(&rot_state->common_attributes);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct platform_device_id hid_dev_rot_ids[] = {
@@ -424,7 +401,6 @@ static struct platform_driver hid_dev_rot_platform_driver = {
 		.pm     = &hid_sensor_pm_ops,
 	},
 	.probe		= hid_dev_rot_probe,
-	.remove		= hid_dev_rot_remove,
 };
 module_platform_driver(hid_dev_rot_platform_driver);
 

-- 
2.34.1


