Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E0847DD4B;
	Thu,  6 Aug 2026 12:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786019206; cv=none; b=n65pBFA+0CibRO/dkC9luAwwHEHCwIfv+zMAjsI/FlD9KD2MKBGfml53s2N8l47GurUHIxGcuaj5k3ImE/oSOKGXn49mZPXWclO6WAzzhrb32Pv0DiVENMwDh2ZxpdXrl3gGHbp0YvPdp0fKs0n6aTJB1c7KW0OVBmzoYydNFWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786019206; c=relaxed/simple;
	bh=HIza9tj31a3mKUDaV4RrpZ7yKRed7YCVQhRCqLix2bc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YetiNYPHffRdxZn7DF3+UKycNHYiac2K3fL6Nj07+sPsRaBzprOs7DQH0z+4pMaKWs1argEXP8cD6FMoBmnL1nJhbHCqvJZHmVz3cVTUef4AENQroHPArXLAXEg7AUwGmrhDkU1jf87SRE6TBfGMT5B4OxrAL+a3tF1v4OBpINQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2Cid4Cy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2Cid4Cy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0C7CC2BCF7;
	Thu,  6 Aug 2026 12:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786019204;
	bh=HIza9tj31a3mKUDaV4RrpZ7yKRed7YCVQhRCqLix2bc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=r2Cid4CyhP4Ua9WPLmHig5zSE9rTaJ6tSBf8TlobYmSNQlswC6ZK8JRce428/f1F6
	 B7qujg7ZMhV2ui8DDrDNkK59qgj9ihmKCti2dVBDh/Vrrc4Zk1M5ZchDQP5JCFHIIB
	 USXEq7/aGymAO2PgpcwW9p6/ozYwcBuWsWVo6jNreEnSJwOfIMIRRXA5un/1WbcESi
	 gSVW+Gv0LlZAliRwgUh+erewxLCc7L3wJ5rSobbUG4RePB742rdN1x6++nv3yFivxb
	 C3yW+jXmtod6jjIhS0dKMVdwnf0fFZdtXSRtE3meCJKlHtoAt+AFyZDB/y/jNr47W0
	 YpMBUoYuAKUfA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6BEC5AC7A;
	Thu,  6 Aug 2026 12:26:44 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Thu, 06 Aug 2026 17:55:59 +0530
Subject: [PATCH v5 13/13] iio: pressure: hid-sensor-press: convert probe
 and teardown to devm-managed resources
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-13-f1f92c1d830f@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786019201; l=3567;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=7y381boWRDonXbz69DqfU+M5uO8NaOORx2X9lVUSvzQ=;
 b=VbJXO2qfYqwuadYA/xMfWfNI/w8vbPxCxiUlguopP/lJvDSsVzsXyCP/0jU+8Lr0kYKUr7wA1
 PwbpgjMSEIaDd5RE7dMwP6dd4fnZMDH5B5nygzhxcaaYvSXLTyhF/OZ
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
 drivers/iio/pressure/hid-sensor-press.c | 41 ++++++++-------------------------
 1 file changed, 9 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index 4e0f42fefd6b..8ebb8f54a0cb 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -230,7 +230,8 @@ static int press_parse_report(struct platform_device *pdev,
 /* Function to initialize the processing for usage id */
 static int hid_press_probe(struct platform_device *pdev)
 {
-	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(dev);
 	int ret = 0;
 	static const char *name = "press";
 	struct iio_dev *indio_dev;
@@ -278,8 +279,8 @@ static int hid_press_probe(struct platform_device *pdev)
 
 	atomic_set(&press_state->common_attributes.data_ready, 0);
 
-	ret = hid_sensor_setup_trigger(indio_dev, name,
-				       &press_state->common_attributes);
+	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, name,
+					    &press_state->common_attributes);
 	if (ret) {
 		dev_err(&pdev->dev, "trigger setup failed\n");
 		return ret;
@@ -288,38 +289,15 @@ static int hid_press_probe(struct platform_device *pdev)
 	press_state->callbacks.send_event = press_proc_event;
 	press_state->callbacks.capture_sample = press_capture_sample;
 	press_state->callbacks.pdev = pdev;
-	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_PRESSURE,
-					   &press_state->callbacks);
+	ret = devm_sensor_hub_register_callback(dev, hsdev,
+						HID_USAGE_SENSOR_PRESSURE,
+						&press_state->callbacks);
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
-	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_PRESSURE);
-error_remove_trigger:
-	hid_sensor_remove_trigger(&press_state->common_attributes);
-	return ret;
-}
-
-/* Function to deinitialize the processing for usage id */
-static void hid_press_remove(struct platform_device *pdev)
-{
-	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct press_state *press_state = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_PRESSURE);
-	hid_sensor_remove_trigger(&press_state->common_attributes);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct platform_device_id hid_press_ids[] = {
@@ -338,7 +316,6 @@ static struct platform_driver hid_press_platform_driver = {
 		.pm	= &hid_sensor_pm_ops,
 	},
 	.probe		= hid_press_probe,
-	.remove		= hid_press_remove,
 };
 module_platform_driver(hid_press_platform_driver);
 

-- 
2.34.1


