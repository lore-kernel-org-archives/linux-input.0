Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795775663;
	b=OuEM2fXqGz/PLs0BZ7ioXUyeQQtX9xNt9KHoisOi5u1wjjD3YaF208yTdPBHW9kAuZnO
	 hcYvkkCXc/qfbCpKYJUcKxFK/aL74c59ENUFase9ZuucmH4rqygBnU/XsfId+qgf3HnY6
	 m1hd/hQ8Y9OTjBYvgY651FVU0UKMsyXqzY/bsSm1az0PwJW71vrENHrDe3beZfamACC8x
	 kqDkEpwOHYvfP8WYhRUj6XBuklzPi/E0slsCRI8V4o9kqXKjDL0cVTyzeVdlMWlnUkNPn
	 4sTeIgZ1Go9jKmesUm0eLGRRGpUmFbehkEEBiZVoV+yd7GlYPErLbiSbOR7awqK58cQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795775663;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ncXXXFEKjc/BcbHimc5MYEqIG5apTaCUodWRVSaeEAA=;
	b=eTCCY3eFuVoV9SwgLpPpxvkwEUEasDDc35F+m6rYgR8WeafUIev8TELwPXQAKbHJy9Zf
	 m9L5TD9cKE351u/vbPjFSsTayXWsow/BJ3UDF+lG4AbpoL4tJh0Zq2tp57hzF14b23DFX
	 pDSbuRMZ0/zvoyq8KPnjaaNb92RVv5eFkL4ZFhlfCJxZ9Gn4gvHnPCMYyH3E4VWfDswkM
	 RNHdnnZR3tclMnNlU4gbz5SzgRssd0Dt0MCyw1aYHQrLlGfMMSsEFPtUyNEzPO8CPFGEZ
	 9aD6/OL0eSjDIhT5qTK4pwd86y7xv3ZSQ1WqcjYJX4sB443gub1kc5a1kNCXE0V4JmQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KwyDrKSR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C1D606A31E;
	Fri, 27 Nov 2026 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KwyDrKSR
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795775663;
	b=YBkBH2a2rahGsVYO3mCdhuV1O59Tk3o6PD3J4O50C0iiZHxfL70HXbjbCJ1CQhmBR4Gt
	 7CbAqFHBnLuBqwOHIrabjnp+Q7W7o+rjJ1pOtqGlqe5v7M9oK8e58j3zZJqWVbuKXw4Da
	 J9JOaGVDeJaNva8tOGt6d9BWtvV96bLVvHvCyZhOKgasDMwuOjh/Laol1u6m/mYQeLcGy
	 Q7yL7qr5Gh4o4+IwI2mGQ9oj/jM25bYMLo0H3I9xHetl8HEwHnW9k2s1/8H4ZOx3b4HST
	 Y1rvTclHfplB7CQhC42R6913Aauel9c4pSnUV2cmUV2Bst9k/GVwjWlkxOvtXh2haXA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795775663;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ncXXXFEKjc/BcbHimc5MYEqIG5apTaCUodWRVSaeEAA=;
	b=JKhsBi4BCFXFRh3z74w4VR46HikHVDXtgivDrXJBDuoaFIvfHzSKAE5lviBqNSj6mrn1
	 +/jHzS6v+AqJAw6pzRBiVEEJSJoaujMlefk0EnzBQSyFZGhPg7x2J3eyEvHBCef3fHUoJ
	 XoRa/1DpRb7TUFBc8fYVp7vR95JRUvwYEalbu+pYh04OYeFWkryKUtRJn0QRsg6/y1hRz
	 0xuGm6o7AMGxJvxHZOu0V7ANjSHKmeqLD6fDAPoRvsZygPJsjsGLPrZweqUrEaXyY4FeK
	 0WDVzYavD81QYY0TNM2GxphpzD1ILVpDyHFNRIDqFBq/ak/sXM6/l8mbRPhgqtreBWA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 85A181F0089A;
	Fri, 27 Nov 2026 10:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795775663;
	bh=ncXXXFEKjc/BcbHimc5MYEqIG5apTaCUodWRVSaeEAA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=KwyDrKSR/YqzpUx3PE7q2Q69KUVvlHO4V7bJoWsR3N9iOO4jaH7+vgbl7149Ipl41
	 BiLko2lq6rxkWfyancORkW7OvKTaJvfCjOxRQhqCntKrBbm6tuuA+QqxsnKuN4LdiW
	 See0AopjJ2o2a/q0sArVjlSUC6C5kT8eA/orYEZlkjS4xt7wfpzFVvjwWMZEgsYf+m
	 E0bR33mGgrXVy4bqEo1EV1gASaoUyxTSjpcBig+9aGXY/C0fa/QJYP9IKjAkU6uAx3
	 SK8gB/XXWQQkhjfzmbDh2LrakyzwBStu3oEwhRfMUXIr23ZaLovcuBjNoMEE9LH94x
	 0J1qHY2VD7pfw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 180764B72F;
	Fri, 27 Nov 2026 10:34:17 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 16:03:57 +0530
Subject: [PATCH v2 2/7] iio: Remove redundant devm_kmemdup() allocation
 failure messages
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
Message-Id: <20261127-19-oct-hid-iio-unified-print-framework-v2-2-3f476fe1a940@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795775655; l=3473;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=GYfroI7CBTuLtaumkcLBm2D6Hmur3RtVQHOcYJz2ogE=;
 b=BGDTzPKzN/BeVJrvdEJkhbhtL5lLClYiMMVIkVsiPohuTfBfcbT7Fj0oHA2ufzJFFz5jnXQgH
 x649m2cIl75Ay1oeU4wlAPkTzGYznCwsCXtebU20/iIchkshEe5rX6B
X-Developer-Key: i=sanjayembeddedse@gmail.com; a=ed25519;
 pk=PcneEFtkmY+Ldl+KmOTpB/Q/HDsqko6Fb0/Z/5cuycI=
X-Endpoint-Received: by B4 Relay for sanjayembeddedse@gmail.com/20260702
 with auth_id=848
X-Original-From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Reply-To: sanjayembeddedse@gmail.com
Content-Transfer-Encoding: 7bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Several HID IIO drivers print a dev_err() message before returning
-ENOMEM when devm_kmemdup() fails.

The failure is already conveyed by the returned error code and the log
messages do not provide additional debugging information. Remove the
redundant messages to reduce log noise.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/accel/hid-sensor-accel-3d.c      | 7 +++----
 drivers/iio/gyro/hid-sensor-gyro-3d.c        | 4 +---
 drivers/iio/orientation/hid-sensor-incl-3d.c | 4 +---
 drivers/iio/pressure/hid-sensor-press.c      | 4 +---
 4 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 51f1ae6b222f..f9e04ed2a7cd 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -354,13 +354,12 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to setup common attributes\n");
 		return ret;
 	}
+
 	indio_dev->channels = devm_kmemdup(&pdev->dev, channel_spec,
 					   channel_size, GFP_KERNEL);
-
-	if (!indio_dev->channels) {
-		dev_err(&pdev->dev, "failed to duplicate channels\n");
+	if (!indio_dev->channels)
 		return -ENOMEM;
-	}
+
 	ret = accel_3d_parse_report(pdev, hsdev,
 				    (struct iio_chan_spec *)indio_dev->channels,
 				    hsdev->usage, accel_state);
diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index ebf34365819c..a785a9fc7f9d 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -292,10 +292,8 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 
 	indio_dev->channels = devm_kmemdup(&pdev->dev, gyro_3d_channels,
 					   sizeof(gyro_3d_channels), GFP_KERNEL);
-	if (!indio_dev->channels) {
-		dev_err(&pdev->dev, "failed to duplicate channels\n");
+	if (!indio_dev->channels)
 		return -ENOMEM;
-	}
 
 	ret = gyro_3d_parse_report(pdev, hsdev,
 				   (struct iio_chan_spec *)indio_dev->channels,
diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
index 4570a698cf0e..2aed92c3526d 100644
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -323,10 +323,8 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
 
 	indio_dev->channels = devm_kmemdup(&pdev->dev, incl_3d_channels,
 					   sizeof(incl_3d_channels), GFP_KERNEL);
-	if (!indio_dev->channels) {
-		dev_err(&pdev->dev, "failed to duplicate channels\n");
+	if (!indio_dev->channels)
 		return -ENOMEM;
-	}
 
 	ret = incl_3d_parse_report(pdev, hsdev,
 				   (struct iio_chan_spec *)indio_dev->channels,
diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index b081990ffc03..9506284bb798 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -258,10 +258,8 @@ static int hid_press_probe(struct platform_device *pdev)
 
 	indio_dev->channels = devm_kmemdup(&pdev->dev, press_channels,
 					   sizeof(press_channels), GFP_KERNEL);
-	if (!indio_dev->channels) {
-		dev_err(&pdev->dev, "failed to duplicate channels\n");
+	if (!indio_dev->channels)
 		return -ENOMEM;
-	}
 
 	ret = press_parse_report(pdev, hsdev,
 				 (struct iio_chan_spec *)indio_dev->channels,

-- 
2.34.1


