Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF12847DD47;
	Thu,  6 Aug 2026 12:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786019206; cv=none; b=S47SadqiSC4CNIP0SNWDE9lSNOaS8unbIWBzxiAN0NaY6c3h6X9WGRpD8ymn+60Cb11GFdJ1ALzzFmF1QfhBkS9BSLoP/G4XeQsuLGDA5Ux5Tcob6MQ9itqQw7dbOPqeTsqYKeWsvZdTesnBOF+NVjV0otGxxNlhypfODr5ehLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786019206; c=relaxed/simple;
	bh=1+LATJmQfGnsPHSpLjng0/+Dl6/lw5qZw/neErfDwj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BfMXlDuCu1cQmO56hYqVVntR1mO1xSb/Vv+bvRtfMRkaoe21onRzoMwxZcuPDSBBsSOBG9RJebY6RZMyLcZU2GObUw4fCipM/sv64SvK9IOoEC0p+F4Y3fEzIcCuQFv/rfJ1wMMtJXq4MwVBMG6sRK/Sum6sQ/nMyTlVHzzC6BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrlemY6A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrlemY6A"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 989A1C2BCB9;
	Thu,  6 Aug 2026 12:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786019204;
	bh=1+LATJmQfGnsPHSpLjng0/+Dl6/lw5qZw/neErfDwj4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XrlemY6AtthOmGBHlo6lIF3rlxNv14xcG5wKybg554+vxKt92QLovpLSxxltO5YDq
	 4HCLD37jeiycg2T+hDP6MwtJr8ju+hz38JMvHuyIJG0PL3HflZKaTLaEV8CbzeqxGR
	 I3QYcS00d8aHX7UFYswJNkA5KmZus1SXjLZ9zIicfO4DRBkYEHK5oWxs4oPiZiJX4x
	 98mR4J+bHsu9LQDGGaSw+PUYOhbkgrJaDG3VwdeBN+H4xRVI2kuN9hmxfUWqcdXP0c
	 f4Ej8Q2aVUKr0Xq/y/2B8SFq57uJ+iACkYmEz3vFkY1OCKq4/2Hx374aHHQQqsyveC
	 BfxXsnjXfwgfg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83517C56205;
	Thu,  6 Aug 2026 12:26:44 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Thu, 06 Aug 2026 17:55:56 +0530
Subject: [PATCH v5 10/13] iio: orientation: hid-sensor-incl-3d: convert
 probe and teardown to devm-managed resources
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-10-f1f92c1d830f@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786019201; l=3627;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=Db8QZy6XNbEvWiQnvLmsz7HdMBrrBkrM5ikOGII6cRw=;
 b=u4vtChtzjG31PLfSYHpd7//v35p3JZfN0ANroW2BkOL5UmX7WXi0pjiTdMWZEFdT6Qxp1WkMV
 RCMBAqnWprzDEvqdqMHUSBUdRx2wm9pL943BHbZAZLI/qM6f+R5QEDC
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


