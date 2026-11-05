Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793882519;
	b=3z1JO2uwnY0d8wfiphRgfW7rvVDQ2zm4+QMyf36PlzAkKq6FeXl/GvpYJ//j8I8VXBJ6
	 dQFkf9YesihlE8EAciAPEIoDunf7RQSXSRAAYsht8qUHlYg8zIoI1SwFzZAIuSG4ETKJf
	 m6gZyYEsVyztgLnGt/XbIpvBz2WPI8yg6wgpUMawtETSbvskjmM6LRe8cG1PIDJFQH1Wr
	 iPrzVlKgYzTZCDUa1djERresDRbJDMwKMr1O0y0J2qLJ9eyNeG7DdmTnKMsGS1UlWS4m4
	 aTSmtCcVFPRwTuIWhjmYMcO0s3CmHOLMJdceIr1PNWd7ESu7jieu0PKyVvwCGw+q2hQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793882519;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=o137qnQc9jMrLUak4kY3TWGvH+R7MOc5t6w43f2yLHg=;
	b=uGFSRathIDnAnIdsCVSKR2SZEAKGENKMWjfayEn/u6F3Adrxjr3OoFj5lPKl3vlmpx8K
	 f3MPIXurYE/hgaFjq1NolOnwRTeBI4GQAnS6dXHDKwoNw0lFIDwbtVNGUJHK3L49eVFpz
	 paHif3bl8kPuyIqX+88wrm2gQl3cZn2+d3K6fIAdlpu60QfPIGMbO5P5XZsFWXf3dzaXt
	 Yj6jPly07HidmrJW5GsJcbDbp2yrZ+voI3WLyE4cxHDSKA6ZbxfOVYSywuGVUqO23DIg+
	 HK83C5CE2K9XBMskDs46L9FEMbPRxEfVdnCnnsol3G9uSL0UXR5HIYYV7HWt+yiGuRA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QJfrGT/y";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D38606A337;
	Thu,  5 Nov 2026 12:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QJfrGT/y
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793882518;
	b=cCvskZ/+1iJI7mPCB28nyT5W4mpn0P2iLDp9NtULLS7/HY9IITjhlJQRIr7heQrvrXOd
	 /XdVg9WgG+Qv8LPenJ308/eQrn8Px63iZMAUyVms1Fy4ZJk6obm/pwCAplvEamNkV6h2Y
	 i01uZxdcVK1JF02ULCHwKSpBtAD5RI+zqy01HbH17OpzLvudkVtL3OGtpDwXJ3Y3IBPhM
	 C85wl3YvCUVtpJC9/ReJT9Z6cdNxf0sLfPvkTUz1OfThlTcVWCzEabP4U9cyue4HsAlVv
	 Jn7+vObSXk+vj0hZVztSqayhCAtop5X7nLdhcne9qqQ4orLKKhb9s/4DwQ3TTdxJ1BQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793882518;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=o137qnQc9jMrLUak4kY3TWGvH+R7MOc5t6w43f2yLHg=;
	b=OE0ur7k2mZ0aKkxsu4oUZeexix8JXwvsDLww/mAny5Ld3rXWlAFsZRvC8ndUB+11FzZX
	 lpTr0h8AWivJ8E8NQzZ7NjwTN0hWTRdQYvnUN/RUmq4XBBg98kme/r2NNWjTl8enm+4nU
	 qrVFRIlMgkB2AAKwscRFE9cQXXoYmHq15tT3a46B+n5+obW6mAJwZFQNKv7qlenoyBJFE
	 wUnnl7aDCmhoPKe6CUWD5c+h14psdU+KM2A/vem8l/26mNWSqxoHcQHfNjQ1fDNIRPAT1
	 caY0yOhFnrwqvsYlLiRM1/zkueMwH2FphKCih+bnvnwByvu5On43lqS42jG0My2a4uQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3AD211F00A15;
	Thu,  5 Nov 2026 12:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793882517;
	bh=o137qnQc9jMrLUak4kY3TWGvH+R7MOc5t6w43f2yLHg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=QJfrGT/yTFWBSwzVM1NJ67ZyM5Ay2YfCwfZB1TJKymL+uzlOGfzOlGeL0S9KpN72M
	 B4NcRsdelUaxvZX2no/tFiIWHqW1wsDK5OAJ1NZjMXi4wOABjuLpIMCCknRwNpqcfD
	 qfWlSViiCHX44Ov0SPtRT//Nff8wrUplweUv9tAgP8UBH3D4r/LAxWLx+JuHTw4HCP
	 lF7u+QpVk5fah+Bpj9f/UZ10nurkvgEnvgSMxPGo4bs6m3n9VGnKAvclHQz3k+dLXs
	 UTqQfyaFKiieP4zgbsPjB6LCCtRLm5ZT+VliILU4LZKlOobGUhBZQ7PI8fnVI7PENM
	 6aKqx+i+wYHTg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B728E47256;
	Thu,  5 Nov 2026 12:41:55 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Thu, 05 Nov 2026 18:11:46 +0530
Subject: [PATCH 4/5] iio: Use dev_err_probe() in HID IIO device drivers
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
Message-Id: <20261105-19-oct-hid-iio-unified-print-framework-v1-4-0b360d9552d9@gmail.com>
References: <20261105-19-oct-hid-iio-unified-print-framework-v1-0-0b360d9552d9@gmail.com>
In-Reply-To: <20261105-19-oct-hid-iio-unified-print-framework-v1-0-0b360d9552d9@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793882514; l=11269;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=rCumOrJWrJ0JIAoVaoKix1QmO2Ic3aRD6anaToQ5B9A=;
 b=ibyG4jTs+GjpQVs93XdTCWXgzrRlKSAYQkuPv0R/Q1cAK8JFYvqmn9jqEeeFAbCOM8bkOfKLj
 lCzrsoC9HCTD35/DBDEU8h/7mqASSlqV8S0DBzRMLa574yCOrxDtMVI
X-Developer-Key: i=sanjayembeddedse@gmail.com; a=ed25519;
 pk=PcneEFtkmY+Ldl+KmOTpB/Q/HDsqko6Fb0/Z/5cuycI=
X-Endpoint-Received: by B4 Relay for sanjayembeddedse@gmail.com/20260702
 with auth_id=848
X-Original-From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Reply-To: sanjayembeddedse@gmail.com
Content-Transfer-Encoding: 7bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Use dev_err_probe() in probe paths to simplify error handling and
properly handle deferred probe errors, avoiding unnecessary log
messages.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/accel/hid-sensor-accel-3d.c              | 12 ++++--------
 drivers/iio/gyro/hid-sensor-gyro-3d.c                | 12 ++++--------
 drivers/iio/light/hid-sensor-als.c                   | 12 ++++--------
 drivers/iio/light/hid-sensor-prox.c                  | 12 ++++--------
 drivers/iio/magnetometer/hid-sensor-magn-3d.c        | 13 +++++--------
 drivers/iio/orientation/hid-sensor-incl-3d.c         | 12 ++++--------
 drivers/iio/orientation/hid-sensor-rotation.c        | 12 ++++--------
 drivers/iio/position/hid-sensor-custom-intel-hinge.c | 12 ++++--------
 drivers/iio/pressure/hid-sensor-press.c              | 12 ++++--------
 9 files changed, 37 insertions(+), 72 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index f9e04ed2a7cd..414d62d2249f 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -350,10 +350,8 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 						 &accel_state->common_attributes,
 						 accel_3d_sensitivity_addresses,
 						 ARRAY_SIZE(accel_3d_sensitivity_addresses));
-	if (ret) {
-		dev_err(&pdev->dev, "failed to setup common attributes\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to setup common attributes\n");
 
 	indio_dev->channels = devm_kmemdup(&pdev->dev, channel_spec,
 					   channel_size, GFP_KERNEL);
@@ -363,10 +361,8 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 	ret = accel_3d_parse_report(pdev, hsdev,
 				    (struct iio_chan_spec *)indio_dev->channels,
 				    hsdev->usage, accel_state);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to setup attributes\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to setup attributes\n");
 
 	indio_dev->info = &accel_3d_info;
 	indio_dev->name = name;
diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index a785a9fc7f9d..cc81ac2ccdd1 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -285,10 +285,8 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 						&gyro_state->common_attributes,
 						gyro_3d_sensitivity_addresses,
 						ARRAY_SIZE(gyro_3d_sensitivity_addresses));
-	if (ret) {
-		dev_err(&pdev->dev, "failed to setup common attributes\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to setup common attributes\n");
 
 	indio_dev->channels = devm_kmemdup(&pdev->dev, gyro_3d_channels,
 					   sizeof(gyro_3d_channels), GFP_KERNEL);
@@ -298,10 +296,8 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 	ret = gyro_3d_parse_report(pdev, hsdev,
 				   (struct iio_chan_spec *)indio_dev->channels,
 				   HID_USAGE_SENSOR_GYRO_3D, gyro_state);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to setup attributes\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to setup attributes\n");
 
 	indio_dev->num_channels = ARRAY_SIZE(gyro_3d_channels);
 	indio_dev->info = &gyro_3d_info;
diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 88c7b1ce9a19..9c136f3f0859 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -369,18 +369,14 @@ static int hid_als_probe(struct platform_device *pdev)
 					&als_state->common_attributes,
 					als_sensitivity_addresses,
 					ARRAY_SIZE(als_sensitivity_addresses));
-	if (ret) {
-		dev_err(&pdev->dev, "failed to setup common attributes\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to setup common attributes\n");
 
 	ret = als_parse_report(pdev, hsdev,
 			       hsdev->usage,
 			       als_state);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to setup attributes\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to setup attributes\n");
 
 	/* Add timestamp channel */
 	als_state->channels[als_state->num_channels] = als_channels[CHANNEL_SCAN_INDEX_TIMESTAMP];
diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index af4becb2e7dd..4d0c7dffc252 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -280,16 +280,12 @@ static int hid_prox_probe(struct platform_device *pdev)
 					&prox_state->common_attributes,
 					prox_sensitivity_addresses,
 					ARRAY_SIZE(prox_sensitivity_addresses));
-	if (ret) {
-		dev_err(&pdev->dev, "failed to setup common attributes\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to setup common attributes\n");
 
 	ret = prox_parse_report(pdev, hsdev, prox_state);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to setup attributes\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to setup attributes\n");
 
 	indio_dev->num_channels = prox_state->num_channels;
 	indio_dev->channels = prox_state->channels;
diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index fb9a561706a8..3ea479f19c79 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -463,10 +463,9 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 				&magn_state->magn_flux_attributes,
 				magn_3d_sensitivity_addresses,
 				ARRAY_SIZE(magn_3d_sensitivity_addresses));
-	if (ret) {
-		dev_err(&pdev->dev, "failed to setup common attributes\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to setup common attributes\n");
+
 	magn_state->rot_attributes = magn_state->magn_flux_attributes;
 	/* sensitivity of rot_attribute is not the same as magn_flux_attributes */
 	magn_state->rot_attributes.sensitivity.index = -1;
@@ -474,10 +473,8 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 	ret = magn_3d_parse_report(pdev, hsdev,
 				   &channels, &chan_count,
 				   HID_USAGE_SENSOR_COMPASS_3D, magn_state);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to parse report\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to setup attributes\n");
 
 	indio_dev->channels = channels;
 	indio_dev->num_channels = chan_count;
diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
index 2aed92c3526d..8ef3645d9b18 100644
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -316,10 +316,8 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
 				&incl_state->common_attributes,
 				incl_3d_sensitivity_addresses,
 				ARRAY_SIZE(incl_3d_sensitivity_addresses));
-	if (ret) {
-		dev_err(&pdev->dev, "failed to setup common attributes\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to setup common attributes\n");
 
 	indio_dev->channels = devm_kmemdup(&pdev->dev, incl_3d_channels,
 					   sizeof(incl_3d_channels), GFP_KERNEL);
@@ -330,10 +328,8 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
 				   (struct iio_chan_spec *)indio_dev->channels,
 				   HID_USAGE_SENSOR_INCLINOMETER_3D,
 				   incl_state);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to setup attributes\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to setup attributes\n");
 
 	indio_dev->num_channels = ARRAY_SIZE(incl_3d_channels);
 	indio_dev->info = &incl_3d_info;
diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index d74fee4b56c8..269ae2e6c095 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -338,16 +338,12 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
 						 &rot_state->common_attributes,
 						 rotation_sensitivity_addresses,
 						 ARRAY_SIZE(rotation_sensitivity_addresses));
-	if (ret) {
-		dev_err(&pdev->dev, "failed to setup common attributes\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to setup common attributes\n");
 
 	ret = dev_rot_parse_report(pdev, hsdev, hsdev->usage, rot_state);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to setup attributes\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to setup attributes\n");
 
 	indio_dev->channels = dev_rot_channels;
 	indio_dev->num_channels = ARRAY_SIZE(dev_rot_channels);
diff --git a/drivers/iio/position/hid-sensor-custom-intel-hinge.c b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
index 0b5e3f71e962..4c59d8a0e7cd 100644
--- a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
+++ b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
@@ -287,10 +287,8 @@ static int hid_hinge_probe(struct platform_device *pdev)
 						 &st->common_attributes,
 						 hinge_sensitivity_addresses,
 						 ARRAY_SIZE(hinge_sensitivity_addresses));
-	if (ret) {
-		dev_err(&pdev->dev, "failed to setup common attributes\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to setup common attributes\n");
 
 	indio_dev->num_channels = ARRAY_SIZE(hinge_channels);
 	indio_dev->channels = devm_kmemdup(&pdev->dev, hinge_channels,
@@ -301,10 +299,8 @@ static int hid_hinge_probe(struct platform_device *pdev)
 	ret = hinge_parse_report(pdev, hsdev,
 				 (struct iio_chan_spec *)indio_dev->channels,
 				 hsdev->usage, st);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to setup attributes\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to setup attributes\n");
 
 	indio_dev->info = &hinge_info;
 	indio_dev->name = "hinge";
diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index 9506284bb798..2d098ed35ff6 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -251,10 +251,8 @@ static int hid_press_probe(struct platform_device *pdev)
 					&press_state->common_attributes,
 					press_sensitivity_addresses,
 					ARRAY_SIZE(press_sensitivity_addresses));
-	if (ret) {
-		dev_err(&pdev->dev, "failed to setup common attributes\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to setup common attributes\n");
 
 	indio_dev->channels = devm_kmemdup(&pdev->dev, press_channels,
 					   sizeof(press_channels), GFP_KERNEL);
@@ -264,10 +262,8 @@ static int hid_press_probe(struct platform_device *pdev)
 	ret = press_parse_report(pdev, hsdev,
 				 (struct iio_chan_spec *)indio_dev->channels,
 				 HID_USAGE_SENSOR_PRESSURE, press_state);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to setup attributes\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to setup attributes\n");
 
 	indio_dev->num_channels =
 				ARRAY_SIZE(press_channels);

-- 
2.34.1


