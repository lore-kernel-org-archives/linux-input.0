Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AE947045C;
	Sat, 19 Sep 2026 10:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789814201; cv=none; b=BFYIHMONKd+JKJkMX2c5u/oyUCi+Ntp1aqBtqOjawBknwssol2uhmiSXWK0iV+92Kp89/f/DxgNUYwb3g80Kpe+dyMcShpjouCCFc8os1hTr0DqydnnalegMMJIjwS/+dEXj62T92JU9iO9zRscIj0CZMUl2D/FCaDwaMNSPzjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789814201; c=relaxed/simple;
	bh=QpjVvJ9+DS2Q2uKPLWC5fqkfnG8PzhLU5vAJoczIpNU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nRorDEhxSeG/YiQVaWh0YYQnB1GCuRgrximukZj9WXFa1y7KzUXmn7ULK+65RTNIujsTr5O8SBDuE0Rp1l/oJlguVn+/2l2ZFSTZtTVW4d5uziJiBECMGkKAYG9WuzbF9DKZ3Y5EyOuFueJRKYun2+1XD4FcF9b/LnV4FWma2/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwZWi0ca; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwZWi0ca"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8EA65C4AF10;
	Sat, 19 Sep 2026 10:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789814201;
	bh=QpjVvJ9+DS2Q2uKPLWC5fqkfnG8PzhLU5vAJoczIpNU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NwZWi0cak1vUhTC/ITMt2je3qssuKKLj9BVeM6pUorjQTSyBE2Ca353IkOrc0Gtb/
	 2VkmqLhljB15ulxbKZSRz+NGOTaBbSU742xrnGcfpYIu5+Vxy89NzMnv7ducVyBz1W
	 grdUxar5XC+emXF5wm2e8HBQrBPVujg6Q8s7WW6VkGRdn/ZdTtVoWa8EODthvINoG2
	 r5JVaMnWFgPmTlQozFZeSN+w+YYPOlk49E+N85cj1eBGO1T/eKpSucB89ebTMWixEA
	 CK6QQIiTSth2bY5klAvH+YzEkJ0UFrBtnMqK1qc1kZCDxIZYjYC6czOLRa3bGrXuGb
	 rFOK3H68X39fA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A59AC982E7;
	Sat, 19 Sep 2026 10:36:41 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Sat, 19 Sep 2026 16:06:29 +0530
Subject: [PATCH v6 06/14] iio: humidity: hid-sensor-humidity: convert probe
 and teardown to devm-managed resources
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-28-apr-iio-redundant-argument-v5-temp-v6-6-d577b2371b3c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789814199; l=3821;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=HqyYHVuWmDcuCY2uw/mZntv1xCDdrJhZceeQRiOBrc0=;
 b=kb31R6OvQWljNavbbvxbMCpy1KDyonoEqJehLOhz4EpOOnvRO9WqmrpVLiwpLYA1IvJbrjTQV
 GhDVokh2s5nBGvlirRdQUoe7ysCtFXRq1he6E0vOLEJ9BzZG6YijpWO
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
changes in v5:
- Fully convert driver to devm usage, dropped Tested-by tag
changes in v4:
- No update in change, added Tested-by tag
changes in v3:
- Update commit message based on review comment from Andy
- Based on discussion using parent device of HID platform driver used
  with devres framework for this driver
- v2 link -> https://lore.kernel.org/all/20260429175918.2541914-5-sanjayembedded@gmail.com/
---
 drivers/iio/humidity/hid-sensor-humidity.c | 38 +++++++-----------------------
 1 file changed, 8 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index 89daf9d534d1..12c88efe66be 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -192,11 +192,12 @@ static struct hid_sensor_hub_callbacks humidity_callbacks = {
 /* Function to initialize the processing for usage id */
 static int hid_humidity_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(dev);
 	static const char *name = "humidity";
 	struct iio_dev *indio_dev;
 	struct hid_humidity_state *humid_st;
 	struct iio_chan_spec *humid_chans;
-	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*humid_st));
@@ -233,42 +234,20 @@ static int hid_humidity_probe(struct platform_device *pdev)
 
 	atomic_set(&humid_st->common_attributes.data_ready, 0);
 
-	ret = hid_sensor_setup_trigger(indio_dev, name,
-				       &humid_st->common_attributes);
+	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, name,
+					    &humid_st->common_attributes);
 	if (ret)
 		return ret;
 
 	platform_set_drvdata(pdev, indio_dev);
 
 	humidity_callbacks.pdev = pdev;
-	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY,
-					   &humidity_callbacks);
+	ret = devm_sensor_hub_register_callback(dev, hsdev, HID_USAGE_SENSOR_HUMIDITY,
+						&humidity_callbacks);
 	if (ret)
-		goto error_remove_trigger;
-
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_remove_callback;
-
-	return ret;
-
-error_remove_callback:
-	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY);
-error_remove_trigger:
-	hid_sensor_remove_trigger(&humid_st->common_attributes);
-	return ret;
-}
-
-/* Function to deinitialize the processing for usage id */
-static void hid_humidity_remove(struct platform_device *pdev)
-{
-	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct hid_humidity_state *humid_st = iio_priv(indio_dev);
+		return ret;
 
-	iio_device_unregister(indio_dev);
-	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY);
-	hid_sensor_remove_trigger(&humid_st->common_attributes);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct platform_device_id hid_humidity_ids[] = {
@@ -287,7 +266,6 @@ static struct platform_driver hid_humidity_platform_driver = {
 		.pm	= &hid_sensor_pm_ops,
 	},
 	.probe		= hid_humidity_probe,
-	.remove		= hid_humidity_remove,
 };
 module_platform_driver(hid_humidity_platform_driver);
 

-- 
2.34.1


