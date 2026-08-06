Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E3347987B;
	Thu,  6 Aug 2026 12:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786019205; cv=none; b=CuFpjGf6vNJNYblrcmFzH2lKXAO6IhkSiZGZf7ZJBYrTtjWoMRj5jVKkMiUTD68/TCVBBDqor9B679g/aiQKHvmH1yk9KSjYXZRkb266qza23p4a4idxKa5T/DwxsrxQIDdJERv4sSAxDn8O4724mW1E2fxKMRduscmiaOMA96c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786019205; c=relaxed/simple;
	bh=txus2AJE/kVu+dxppUJupcIuWbp4gFKzp2cIZUvkXBc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HYTHlqgPzIE2iVRIO9lc176cvXd6CbuOHG7+zXE+j/Hz/asVSTH74Dqmd9zEqgcF+VdzbDUqGIVRydiYBxP5MSnk03sNxQjehxgF3hnibzeB3FfuUoVtQlH5fz06IB4Td6uyGs1E2GgjurI4GWOaZC8r4ISBLWBQW+fZZrdnB4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izvSidW2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izvSidW2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41973C2BD05;
	Thu,  6 Aug 2026 12:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786019204;
	bh=txus2AJE/kVu+dxppUJupcIuWbp4gFKzp2cIZUvkXBc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=izvSidW2Yuoxnf/6SOo3zXsgv6M+D9rNSH6WH8CgsO+SH0nk4edBNgYAfNXuULVkr
	 +h5THcZmt4McABAzTnIFkTz/S7aj3kOSy+860eQiKExPTOiH5sMeizN5wI2+GMv6Rw
	 gUOu+2cLkInHDwh2zB3Od8iyKKayvKFD7u+08UOOCSjrGHLyPC5aPM5vYCiEXY3cHL
	 YSGtGZ+gVe+U5KF/UauG2wkYwgGsyEuhM8u7IYsp3I6TsPIVyAPCVvSSHi5k2Kxx55
	 ozeh2634yTGcb2dJ7aju0MBODeFK5v0T3JvWZhrXMoj9o2RHv+jONqvayitd40bKW+
	 cJmCzpgNv/kzg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF50C56205;
	Thu,  6 Aug 2026 12:26:44 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Thu, 06 Aug 2026 17:55:54 +0530
Subject: [PATCH v5 08/13] iio: light: hid-sensor-als: convert probe and
 teardown to devm-managed resources
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-8-f1f92c1d830f@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786019201; l=3431;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=YJB29GHZCncYhwv+cTV1yg7AaHm7y9Zh7SdPyAgjnjg=;
 b=NikBq7UJpPp8X7NGx+AaCNQef0VI7JcmDeAJcpODreC6j6ehFwt/kKIhlN0dTKi8vvtC9embd
 rWXc92la3HRBrxjPuOgITnrS53EphDSHLoNvawwRbsFVavlw7F15igg
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
 drivers/iio/light/hid-sensor-als.c | 39 ++++++++------------------------------
 1 file changed, 8 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 10bf46ea4f47..633fd1569987 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -348,7 +348,8 @@ static int als_parse_report(struct platform_device *pdev,
 /* Function to initialize the processing for usage id */
 static int hid_als_probe(struct platform_device *pdev)
 {
-	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(dev);
 	int ret = 0;
 	static const char *name = "als";
 	struct iio_dev *indio_dev;
@@ -396,8 +397,8 @@ static int hid_als_probe(struct platform_device *pdev)
 
 	atomic_set(&als_state->common_attributes.data_ready, 0);
 
-	ret = hid_sensor_setup_trigger(indio_dev, name,
-				       &als_state->common_attributes);
+	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, name,
+					    &als_state->common_attributes);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "trigger setup failed\n");
 		return ret;
@@ -406,37 +407,14 @@ static int hid_als_probe(struct platform_device *pdev)
 	als_state->callbacks.send_event = als_proc_event;
 	als_state->callbacks.capture_sample = als_capture_sample;
 	als_state->callbacks.pdev = pdev;
-	ret = sensor_hub_register_callback(hsdev, hsdev->usage, &als_state->callbacks);
+	ret = devm_sensor_hub_register_callback(dev, hsdev, hsdev->usage,
+						&als_state->callbacks);
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
-	hid_sensor_remove_trigger(&als_state->common_attributes);
-	return ret;
-}
-
-/* Function to deinitialize the processing for usage id */
-static void hid_als_remove(struct platform_device *pdev)
-{
-	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct als_state *als_state = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	sensor_hub_remove_callback(hsdev, hsdev->usage);
-	hid_sensor_remove_trigger(&als_state->common_attributes);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct platform_device_id hid_als_ids[] = {
@@ -459,7 +437,6 @@ static struct platform_driver hid_als_platform_driver = {
 		.pm	= &hid_sensor_pm_ops,
 	},
 	.probe		= hid_als_probe,
-	.remove		= hid_als_remove,
 };
 module_platform_driver(hid_als_platform_driver);
 

-- 
2.34.1


