Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1980C47D93E;
	Thu,  6 Aug 2026 12:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786019205; cv=none; b=YaYaFGlpQfRZIacEz5r21TwLqRNqbH+PgVjOShuhFBSm/LAeleYtstyTsRfEfX2Iu5i40p9Z2v2wQN7zTLnG/8ISBD/zl3fILy98f9/jTJyJmSjjhyA5lLlKxysUQOEiPBrCxYsd68kg3wEYes7h599j/HXTecKnazOS96yujxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786019205; c=relaxed/simple;
	bh=tq/IbJVpEbqrjPtNTxWQz6KzoyoryI8jJvw3bm2ttI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=abbi/cbMJ9yGv8Z9wCs5rmuDmYh19rTyraSKl6IwY1d5Y8kB6b/fWr/d4b5Ec0/qgjaXz01a3jn7OvVpb/3qCBTqIN0k76QnzKLTijgcHUAgrizqNPNhUecLpvItNdXmlC0s1hnYm/o9RvPim0N3ulptFGG99iLBIZru/OqDMuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfmBTfiw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfmBTfiw"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3AAFC2BCF4;
	Thu,  6 Aug 2026 12:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786019204;
	bh=tq/IbJVpEbqrjPtNTxWQz6KzoyoryI8jJvw3bm2ttI4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NfmBTfiwLMVesuqAc0iPUN7WjuRz+tLQ8hqEqLsAn8bMrUbQIHkfugZztDclltliw
	 wFSHaI8ExfiqM2IvyK1LyFz+G9mIzuzueSchjdtuIIHYhxaWHFrx4PATuVtzGvVw+e
	 1bCPLYow3EECgIOFjlrEvqqym8c4htUkHkfsbeEWZjtyidyPwOCNhCIt++hFk4v9CR
	 IWmqA/AzT4K5uWhnSwtnudboMrr5TKoMPZHoAgA93Tce1YO/Ezy8G3tWVGu6b3/YqH
	 X0XRTW0NotItfo+667At6vvZdnlbB1wzh+JC+Ngo/T45frDhEnpQy+88fciAxz8KhZ
	 Mvcc6a+O+uM1w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD0CC56208;
	Thu,  6 Aug 2026 12:26:43 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Thu, 06 Aug 2026 17:55:51 +0530
Subject: [PATCH v5 05/13] iio: accel: hid-sensor-accel-3d: convert probe
 and teardown to devm-managed resources
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-5-f1f92c1d830f@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786019201; l=3533;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=8MWI/12hlI4M9yhRZDPc0n3MB0pcjTD/Emba1guoIhc=;
 b=MZal0cvwGDtehKVxt7L/TWs+AfT6QAVJEnhx70adYXeoGXjpnpCSjODYESYM5q1u1LzIqtCdT
 h+8IhyEJc9qCVMLEF6+IoRoNN9BQjKrD0Od2ZoEe8U0olL+8gueI86S
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
 drivers/iio/accel/hid-sensor-accel-3d.c | 40 +++++++--------------------------
 1 file changed, 8 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index a7cccbaa82f8..7ba0228f18b4 100644
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
@@ -374,8 +375,8 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 
 	atomic_set(&accel_state->common_attributes.data_ready, 0);
 
-	ret = hid_sensor_setup_trigger(indio_dev, name,
-				       &accel_state->common_attributes);
+	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, name,
+					    &accel_state->common_attributes);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "trigger setup failed\n");
 		return ret;
@@ -384,38 +385,14 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 	accel_state->callbacks.send_event = accel_3d_proc_event;
 	accel_state->callbacks.capture_sample = accel_3d_capture_sample;
 	accel_state->callbacks.pdev = pdev;
-	ret = sensor_hub_register_callback(hsdev, hsdev->usage,
-					   &accel_state->callbacks);
+	ret = devm_sensor_hub_register_callback(dev, hsdev, hsdev->usage,
+						&accel_state->callbacks);
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
-	hid_sensor_remove_trigger(&accel_state->common_attributes);
-	return ret;
-}
-
-/* Function to deinitialize the processing for usage id */
-static void hid_accel_3d_remove(struct platform_device *pdev)
-{
-	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct accel_3d_state *accel_state = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	sensor_hub_remove_callback(hsdev, hsdev->usage);
-	hid_sensor_remove_trigger(&accel_state->common_attributes);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct platform_device_id hid_accel_3d_ids[] = {
@@ -437,7 +414,6 @@ static struct platform_driver hid_accel_3d_platform_driver = {
 		.pm	= &hid_sensor_pm_ops,
 	},
 	.probe		= hid_accel_3d_probe,
-	.remove		= hid_accel_3d_remove,
 };
 module_platform_driver(hid_accel_3d_platform_driver);
 

-- 
2.34.1


