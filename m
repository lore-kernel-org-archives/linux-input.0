Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1361D472077;
	Sat, 19 Sep 2026 10:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789814202; cv=none; b=TIc8JW7jT+DDl4iDSy5c7WrwCr5Iu7HBFHKNsyu3mfsyc7WZBb6J/dXGHpOiCLHrYoa0Qu+jAMYfoURngCGsqFpIDb8ziIRYSuthTAdQhQwfp9N9h/nI/Vbxfn1ns/JEBi8mvP5DyHQIck1huEVNUAyDuOAxfXGSJJHtuv1VDkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789814202; c=relaxed/simple;
	bh=d0a1H9PELbVmQhNglK5y5FtIcmnFR2yg9BW8d3/JhTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=es9NQfAUJOLrTFVKMKcilD/HKRwmitKSzYEk8aKIbC5Ls+F7qhYz7vGu3meGosetGMG5+T6UIEkSs++1lwwZYjwuqW5Ge6eeFNpjE01Ym36WZbd0H0nxOxU3fLiDuPYA6uUGeUhndNVEdQE/Z+cfi5XISasy/nI0YmcQ1dDMi+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oh04Rm+H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oh04Rm+H"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EAEDBC2BCFF;
	Sat, 19 Sep 2026 10:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789814202;
	bh=d0a1H9PELbVmQhNglK5y5FtIcmnFR2yg9BW8d3/JhTY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oh04Rm+HQ0YywrUUgzTnBVXkeFATIk1Zgx5emYNm3XVGAH/l3Gm0KdogiAU6kl/RI
	 faVS2vFoVlo/f/YnaqUcAIqzVt+pdaYf4koueEZpuFnsHYGhr7NqRSnjU07jnMEymq
	 1/g+i7n+EM5UFXA6TRKDX3H7W4x5JgJuvvrYISmlcVm3ZOdIi/jZESBLb6yDL1QtVU
	 3CzZX2xdg5E1rm+lqYjmeQnkRzEi2ogkmrHUQPd63hFFq2ROlSgeW444/peblcSojB
	 DzxMxvAimX7iNywHIfNUrXxbEFAgdBNFkrVLo0U9JBTqTHP17ZGGgGmZ+VHKcE44Yc
	 yoFTHHvK96cSQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D709EC982E6;
	Sat, 19 Sep 2026 10:36:41 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Sat, 19 Sep 2026 16:06:35 +0530
Subject: [PATCH v6 12/14] iio: position: hid-sensor-custom-intel-hinge:
 convert probe and teardown to devm-managed resources
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-28-apr-iio-redundant-argument-v5-temp-v6-12-d577b2371b3c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789814199; l=3491;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=i4Tkmjvqq1X1HXfT1Ajunvn9KfzjkXAM5FZZp1If76U=;
 b=gS8Fb4zew70a/H4h6ClsvQwLV6CFRhIwrtHdzx8LyoAPVjCvG7a1KqKnNsuaLwJBcutMAy1XD
 pi4YJ8YT+FxBcnhD35ZUO43589rMJRzd0jWFTJiHFU+97KOKQT+WPls
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


