Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E831F471CEA;
	Sat, 19 Sep 2026 10:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789814202; cv=none; b=mKMj8aichIRXBp0vjar30lOhRH3F67Up8NZwERIekSyoLd5hFqeqj+sKnHTjFpnME9GHuhH495UKwMvX3qdp5+Il7wyfi2sEK0QfUV80ZpMcTF2bQFu0mI5prZXAyKVOEmwZ1r8RwlvkASheA2t8QORJ2jAvKinSPV7mBATWBBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789814202; c=relaxed/simple;
	bh=AWnCnKefvG4UVNmB6J2v9FQ7IUmYciYkW+vBmT2hi64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tPL9kDUPSIY79MLf7Hih/LTH2ErieNWQSaaq/D2sG/Qo3mbdzMzhUjk3qyKQJkBGJlnDv0NO0pqDN6XjjNh/ClMaZF0f/Scsf3fL+ClrwxqXlVwBVvxJNTcUhl0uH2HmdfETgPRNA27NuUR9wsVE49LhT4ROStpiOvk1X8GO6bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCRMRYTm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCRMRYTm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C026AC2BD00;
	Sat, 19 Sep 2026 10:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789814201;
	bh=AWnCnKefvG4UVNmB6J2v9FQ7IUmYciYkW+vBmT2hi64=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DCRMRYTm/3AMUIw7m9hpe6wRMvlerTjmcoL0BjQr7ChjzOSvOiUkV/zVXMXCK2nki
	 z4intiUO1LzBxTQql8v8qhpmNZuXHPRfiFVaOXoq12oqQOhJi+6K4y6/NDkU/HACh8
	 VI4kAUpPCnO9m/5DAIr9FrkKTtayTqzMxxy1W0XivjqZD/qRHeXsR1dG21OeOdy76g
	 hnCa8IPmNnXXLdtk8oalG6ySqIFPtV0kEIg0tvCbgBjBpPTH0Qls2/CXl79bUCRuak
	 U9KHfr94+eT54P739oBxe9oRvcPuyZi87jqbK4i7Xg3rZPbIrw2RRgg0SQ7/lhREqe
	 94zIILMTvoRHQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEA4C982DA;
	Sat, 19 Sep 2026 10:36:41 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Sat, 19 Sep 2026 16:06:32 +0530
Subject: [PATCH v6 09/14] iio: magnetometer: hid-sensor-magn-3d: convert
 probe and teardown to devm-managed resources
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-28-apr-iio-redundant-argument-v5-temp-v6-9-d577b2371b3c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789814199; l=3629;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=psVvPChQvmnDeqq5c0sAzyCmhiEktLAbJoySPLiD/3g=;
 b=B4bfzPua1+LKqeLFKtgPlIbWdd2LKh/IsiOhzeELXi4+OYc3ftr6wY+VokQ46Flawi4ngaN9k
 ogFTEoxCM8wDoxzaleIIl6lvzU1K9MWjHnAUpzemjK2PTKjOIoDBM9m
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


