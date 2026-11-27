Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795775669;
	b=Zxyb+sBvzz0mPL4CCiIoxlsVwvGjJQMQ8D8xKHieDEbeFBjarYGGnZgClEvmGWIbMrbo
	 lyi3DPFz8tVMVcAmU+Pn+3mzR6zCXPW6oEjwwSYOAnvgDLQcdW0RSdGfCPlwB0PVZng3C
	 j5bk7j80KFP6c7zvjYyUbFiouogx/tG/Cs1vfTcZnGEZxJ8DCx80P0PeJJSojjDnUVTif
	 55l7nBgusnebZY5cX9Dtbpmn0Yw5Rmqgd2swVQO2FieGJ6cG+t2+wrAHTIIJ44sNHtzQ/
	 bFRWuW8geddYUeoTR4RYteKShQbbfkM8ph0w3uTW1v/NBot/rgVQDN6hZE2WOFmFTIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795775669;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=0GvYcXXGEE88cvZwm11N4yVZQ29vJaMSOi8XJ9/pkSQ=;
	b=2gkravas2mYEQ3YQgyc1Q5u/DYTncHHUw3vYnDxfGqZz7BKYnOz8Fppwmc2opyIJN0s/
	 MmrcKdUdLk/+He0rl/MHJ/LKKIH+G55Jb9tl4vlpsAGVRUtrYyCcOg+a64i7qRq1b14mR
	 r3xvT5U62a2pwF+nFvkA634V5FpSC/MR/OZNzyYl7XVw6Ox9onCR0pn6qH3/nUqvXAIbi
	 UOu5QjwfDB5/eQuomaXKDc2KtMP4Z09iF+xf5r4XLU34H/c019Mdh4eD/kHeitrxDG1X/
	 ciHbn1FVBRxw0mIoP10/XbYnV/5jYhOUkVcx+EAFCsBF+xuCdkkLwLapPvkOI6ZS8dQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gzvyXANO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB73606A31F;
	Fri, 27 Nov 2026 10:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gzvyXANO
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795775668;
	b=Ra+fb7yvl8Hhne6jd8gYZe+Yh5FyLPr/RMKPO7QyohUiZiXRewmzsveScq1YmYuQiJPi
	 rwEoeocCs/pxw/m6SNW1H5QCf68+OqIxcLhtKEfP/2qhDii0L9WxpjpYoYjqpZ7dX9rYK
	 MA6XlKINbLimJy3t3X3g2l3l7xXvDwC9wP89ylQgCqkWYFU7kmRVDzK1/G6LST7OWfJfi
	 3ovoc3mnCN9qkNsLWMCmLsmDywYsyug7ikGOUc2VQq699QAQwAKfJIfAoK2nfPm49pWyU
	 tiCARRdd0p7CeoiKgyuO/zZ6vjuhc20aoSXfL1HDhZzZntFry0W6JqdAtMY5VcFMaLA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795775668;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=0GvYcXXGEE88cvZwm11N4yVZQ29vJaMSOi8XJ9/pkSQ=;
	b=EkUjdEyacpnoDUUhrNwdIt2PNYH7l/IBChgcIqC3L6kOXy29pefdqVP3l/MZ/mL/y9IC
	 0TJ6LfGeoNQIlP4Ufz7wgo4zX3fJhqJ3xnzI7atTsjUvvsfyvol9XKEYgK92/ma5jRLY+
	 n1OzlMy4nH2flzXbyGAk6A6Nw9kwovBujR+jttiIAM1u+om8klsoj6MpdX+k8oK6fnHR3
	 fGN6elJeQJFlgE6yZZf+iWdrLroZBSEVtqUgLSFs0XkK86YPrHZZxUbqyADRI2Zf8CYmo
	 omenPTQXCk2MoPZeHnz1efEhpCd7rrSiAMmleCswn4mkwpUh8it7zJyq/kkBgWk5G/g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 64E5F1F00899;
	Fri, 27 Nov 2026 10:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795775668;
	bh=0GvYcXXGEE88cvZwm11N4yVZQ29vJaMSOi8XJ9/pkSQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=gzvyXANOt2MJSUnzFcLzsCBO9/fhmUkNl4XfSemo8EOrbAgZCmwCYFwQBmSfjEam0
	 BEZtu3nXKsj2RNxT61Ab//iSKoxGy7wcL4s1IU81eFlEUmebgIC5D0Ibh7zuhbDq37
	 njA2reujeqkLYA/bvG3dstLpc+3R9zsC2OI8aZDZevuAsAXOeGHTkypgsUFrYMxOi1
	 HPGt6ZrCUlYbyvbg7jnpxO7dt3+aNbHcw8Pmj9n4sb9F32VOtzDO9Z9bqkbVCxHj4t
	 YNL+Q5h9Y+XU3/a7Yd1+vil8F0pEWY33Ns2qYfheBvgSqqIZwZ4PCcMK6XDqO3UMYd
	 2IKOwPHlyX2gw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id ECCEA4B728;
	Fri, 27 Nov 2026 10:34:16 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 16:03:56 +0530
Subject: [PATCH v2 1/7] iio: Remove redundant probe error messages for HID
 device drivers
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261127-19-oct-hid-iio-unified-print-framework-v2-1-3f476fe1a940@gmail.com>
References: <20261127-19-oct-hid-iio-unified-print-framework-v2-0-3f476fe1a940@gmail.com>
In-Reply-To: <20261127-19-oct-hid-iio-unified-print-framework-v2-0-3f476fe1a940@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795775655; l=10007;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=hLRybqqLhTLHMvSp2FxME1GWpO/LWPhzWnyve6U2utw=;
 b=uiqaCSKBGHqYp631mdbRlVggNzc1OZTrBQ/JcWArX/AG7/sXim7D8EVkZlu3pDeFbCFKIyghw
 IEWcM6Y9/PBCUEd8xtRJ0GwxXmdd4uXn1NZ3HuN5Ffn7W3pMZfSAph6
X-Developer-Key: i=sanjayembeddedse@gmail.com; a=ed25519;
 pk=PcneEFtkmY+Ldl+KmOTpB/Q/HDsqko6Fb0/Z/5cuycI=
X-Endpoint-Received: by B4 Relay for sanjayembeddedse@gmail.com/20260702
 with auth_id=848
X-Original-From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Reply-To: sanjayembeddedse@gmail.com
Content-Transfer-Encoding: 7bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

devm_hid_sensor_setup_trigger() already logs an error when the request
fails for trigger allocation or registration failure, making the
explicit dev_err() redundant.

Similarly, devm_sensor_hub_register_callback() returns -EINVAL, -ENOMEM
or 0 (success), making the dev_err() in the probe path redundant.

Remove both messages from HID-IIO device drivers.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/accel/hid-sensor-accel-3d.c              | 8 ++------
 drivers/iio/gyro/hid-sensor-gyro-3d.c                | 8 ++------
 drivers/iio/light/hid-sensor-als.c                   | 8 ++------
 drivers/iio/light/hid-sensor-prox.c                  | 8 ++------
 drivers/iio/magnetometer/hid-sensor-magn-3d.c        | 8 ++------
 drivers/iio/orientation/hid-sensor-incl-3d.c         | 8 ++------
 drivers/iio/orientation/hid-sensor-rotation.c        | 8 ++------
 drivers/iio/position/hid-sensor-custom-intel-hinge.c | 8 ++------
 drivers/iio/pressure/hid-sensor-press.c              | 8 ++------
 9 files changed, 18 insertions(+), 54 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 7ba0228f18b4..51f1ae6b222f 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -377,20 +377,16 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 
 	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, name,
 					    &accel_state->common_attributes);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "trigger setup failed\n");
+	if (ret < 0)
 		return ret;
-	}
 
 	accel_state->callbacks.send_event = accel_3d_proc_event;
 	accel_state->callbacks.capture_sample = accel_3d_capture_sample;
 	accel_state->callbacks.pdev = pdev;
 	ret = devm_sensor_hub_register_callback(dev, hsdev, hsdev->usage,
 						&accel_state->callbacks);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "callback reg failed\n");
+	if (ret < 0)
 		return ret;
-	}
 
 	return devm_iio_device_register(dev, indio_dev);
 }
diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index 66778315e86d..ebf34365819c 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -314,10 +314,8 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 
 	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, name,
 					    &gyro_state->common_attributes);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "trigger setup failed\n");
+	if (ret < 0)
 		return ret;
-	}
 
 	gyro_state->callbacks.send_event = gyro_3d_proc_event;
 	gyro_state->callbacks.capture_sample = gyro_3d_capture_sample;
@@ -325,10 +323,8 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 	ret = devm_sensor_hub_register_callback(dev, hsdev,
 						HID_USAGE_SENSOR_GYRO_3D,
 						&gyro_state->callbacks);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "callback reg failed\n");
+	if (ret < 0)
 		return ret;
-	}
 
 	return devm_iio_device_register(dev, indio_dev);
 }
diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index f531f25d1b63..452ac6a9651a 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -413,20 +413,16 @@ static int hid_als_probe(struct platform_device *pdev)
 
 	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, name,
 					    &als_state->common_attributes);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "trigger setup failed\n");
+	if (ret < 0)
 		return ret;
-	}
 
 	als_state->callbacks.send_event = als_proc_event;
 	als_state->callbacks.capture_sample = als_capture_sample;
 	als_state->callbacks.pdev = pdev;
 	ret = devm_sensor_hub_register_callback(dev, hsdev, hsdev->usage,
 						&als_state->callbacks);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "callback reg failed\n");
+	if (ret < 0)
 		return ret;
-	}
 
 	return devm_iio_device_register(dev, indio_dev);
 }
diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index 355b7b02868c..af4becb2e7dd 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -302,20 +302,16 @@ static int hid_prox_probe(struct platform_device *pdev)
 
 	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, name,
 					    &prox_state->common_attributes);
-	if (ret) {
-		dev_err(&pdev->dev, "trigger setup failed\n");
+	if (ret)
 		return ret;
-	}
 
 	prox_state->callbacks.send_event = prox_proc_event;
 	prox_state->callbacks.capture_sample = prox_capture_sample;
 	prox_state->callbacks.pdev = pdev;
 	ret = devm_sensor_hub_register_callback(dev, hsdev, hsdev->usage,
 						&prox_state->callbacks);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "callback reg failed\n");
+	if (ret < 0)
 		return ret;
-	}
 
 	return devm_iio_device_register(dev, indio_dev);
 }
diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index 4f4cc441770c..5dd36cfd0ca7 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -499,10 +499,8 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 
 	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, name,
 					    &magn_state->magn_flux_attributes);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "trigger setup failed\n");
+	if (ret < 0)
 		return ret;
-	}
 
 	magn_state->callbacks.send_event = magn_3d_proc_event;
 	magn_state->callbacks.capture_sample = magn_3d_capture_sample;
@@ -510,10 +508,8 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 	ret = devm_sensor_hub_register_callback(dev, hsdev,
 						HID_USAGE_SENSOR_COMPASS_3D,
 						&magn_state->callbacks);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "callback reg failed\n");
+	if (ret < 0)
 		return ret;
-	}
 
 	return devm_iio_device_register(dev, indio_dev);
 }
diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
index b5f70732d035..4570a698cf0e 100644
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -346,10 +346,8 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
 
 	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, name,
 					    &incl_state->common_attributes);
-	if (ret) {
-		dev_err(&pdev->dev, "trigger setup failed\n");
+	if (ret)
 		return ret;
-	}
 
 	incl_state->callbacks.send_event = incl_3d_proc_event;
 	incl_state->callbacks.capture_sample = incl_3d_capture_sample;
@@ -357,10 +355,8 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
 	ret = devm_sensor_hub_register_callback(dev, hsdev,
 						HID_USAGE_SENSOR_INCLINOMETER_3D,
 						&incl_state->callbacks);
-	if (ret) {
-		dev_err(&pdev->dev, "callback reg failed\n");
+	if (ret)
 		return ret;
-	}
 
 	return devm_iio_device_register(dev, indio_dev);
 }
diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index f97c278f16cb..d74fee4b56c8 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -359,20 +359,16 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
 
 	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, name,
 					    &rot_state->common_attributes);
-	if (ret) {
-		dev_err(&pdev->dev, "trigger setup failed\n");
+	if (ret)
 		return ret;
-	}
 
 	rot_state->callbacks.send_event = dev_rot_proc_event;
 	rot_state->callbacks.capture_sample = dev_rot_capture_sample;
 	rot_state->callbacks.pdev = pdev;
 	ret = devm_sensor_hub_register_callback(dev, hsdev, hsdev->usage,
 						&rot_state->callbacks);
-	if (ret) {
-		dev_err(&pdev->dev, "callback reg failed\n");
+	if (ret)
 		return ret;
-	}
 
 	return devm_iio_device_register(dev, indio_dev);
 }
diff --git a/drivers/iio/position/hid-sensor-custom-intel-hinge.c b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
index 101d84b533c9..0b5e3f71e962 100644
--- a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
+++ b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
@@ -313,19 +313,15 @@ static int hid_hinge_probe(struct platform_device *pdev)
 	atomic_set(&st->common_attributes.data_ready, 0);
 	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, indio_dev->name,
 					    &st->common_attributes);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "trigger setup failed\n");
+	if (ret < 0)
 		return ret;
-	}
 
 	st->callbacks.send_event = hinge_proc_event;
 	st->callbacks.capture_sample = hinge_capture_sample;
 	st->callbacks.pdev = pdev;
 	ret = devm_sensor_hub_register_callback(dev, hsdev, hsdev->usage, &st->callbacks);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "callback reg failed\n");
+	if (ret < 0)
 		return ret;
-	}
 
 	return devm_iio_device_register(dev, indio_dev);
 }
diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index 8ebb8f54a0cb..b081990ffc03 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -281,10 +281,8 @@ static int hid_press_probe(struct platform_device *pdev)
 
 	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, name,
 					    &press_state->common_attributes);
-	if (ret) {
-		dev_err(&pdev->dev, "trigger setup failed\n");
+	if (ret)
 		return ret;
-	}
 
 	press_state->callbacks.send_event = press_proc_event;
 	press_state->callbacks.capture_sample = press_capture_sample;
@@ -292,10 +290,8 @@ static int hid_press_probe(struct platform_device *pdev)
 	ret = devm_sensor_hub_register_callback(dev, hsdev,
 						HID_USAGE_SENSOR_PRESSURE,
 						&press_state->callbacks);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "callback reg failed\n");
+	if (ret < 0)
 		return ret;
-	}
 
 	return devm_iio_device_register(dev, indio_dev);
 }

-- 
2.34.1


