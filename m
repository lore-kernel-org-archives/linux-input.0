Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795775677;
	b=W3p7aS/wHtnRA2JYyM5MnSq+VBM1tua7t6f+PFkHe52ZZ0jHgWuNJ4ZtpmHzy9wmav2w
	 cZUvgSemvvYV6GQ66cC+f+GKxxVszAFp7XybeJRBt847GZgRUQqNw2bN9VA7yFRbcM37y
	 zB+S15i6Yp7ZtXKqXAYBTI86o4wxO8C4b1fgDFwgva2z4TXkHJZg5MfBdOrb2MKVCjy8z
	 XRaIw6RcxKNLm97v24yCOL92M5f/nSymfuu2yfh/qJdQHrXOvUGMs5nCcXVr4+lxWl+Ds
	 QS2SbVx+5VP1A5KEpqolijzO8/FSh1wgSvpC+gYmcOtD7a+Gn185HG17YEzXz3Vc6CQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795775677;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=eLLMNywQ9EBe+pJtj99GVcSllXP5YQ0J+bgKpqOqpmM=;
	b=Y4Nx2uXCnes3kf6ndRXUlTCKR6ToCARlU9znmc8QY96y/HKFS0Y9P+yxeWtAoCvGYqps
	 rDqyfLg97uh7FhMvfJzq5ZxF73AQkpEg4pKDPwBam2EJpZ6E5Bg7c+4OojuRktic3sEyW
	 0L+kyepnL5GltGKkJm7WvnpIyV9/pHdJAUesSY8S+HmzEM/QpaCS2nltXiKMdtVmYJm88
	 IwV35VK20Y44ecMOmBv+TMvSzCl+XXAbmAV1EdCqMj4K/DfAtROKD41B+RHBiFQXbfd7j
	 GJ/L0BgorMW5Rmd0anfj+ewJTnBVHgUDhj6HVcfTmsTBbc3RueNHYosBPAtOk2wMRKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mqYVFjDk;
	arc=fail smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B767606A333;
	Fri, 27 Nov 2026 10:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mqYVFjDk
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795775676;
	b=ToVORhjJO4EtKcpJZahNQD6/Oq8q2BjuNzmQ5Tlje1LqAUUikps9evnelDJ3e6R5Dyze
	 FKXyM+ylGkiPwR8cWhfUrjQzrWPO1tKqdagZnlZY0EMSq7szmcL9zPsE/qZmwhRHdluSe
	 r1Ug7aBMFHri5rgGK+X379XH+zZKiJnKFRFun3c2e471yGJ0QyX7abpSLmW7MEjYVBy0u
	 kge54Svd6kje3R1EvVQoGHHH0zs8ERMgKChIZ5jI3nLoXtfwv73T4NQGQya0qFZLSUttr
	 piQeMs7F6H/D9PCk6uXpVsQiZibrtnDfuV+EOMiFOjsYJx/F25GazYVa3puA+tk5QrA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795775676;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=eLLMNywQ9EBe+pJtj99GVcSllXP5YQ0J+bgKpqOqpmM=;
	b=q4i3WnzrEDqVYqmUb+mH7xk6JT5dvTuCfmQ6SEYVm4pWUsUGjFwX2MeP4//BPmik1/1o
	 A1FtsvrJI7L5NmCIv94FSbe+NgX9xlDsJWVOJAUYDXNJgOFESK1iR1eTx0rl6qJlB1fin
	 A309Ej+hbQdfHgEmgmuOfsvG4llu4EWq3WPCjtxh+PaKBl5cp5/1cZtJlGgZ5/0s8BYNB
	 m3P1RP19bZTcXP8F5W8R79SMhYL064lV16uutuKuYVmPAUm2Bg1vj7GT4b2uSr5bz2ku0
	 wKS+0bbs8oM5FCovxFPdvkp+YIY19k6ww8UrfxaT12FkqM0wIBUlQ2P8S0vYrNWf/bQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DB6331F0089A;
	Fri, 27 Nov 2026 10:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795775676;
	bh=eLLMNywQ9EBe+pJtj99GVcSllXP5YQ0J+bgKpqOqpmM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=mqYVFjDkQ83KhoNIlTSH0IF98u798EscKc7hYikGTHoyJj8xKcIXub1LwXYV5bqtT
	 LxGDB/GP+9URYCTaSVy7tljN9j4ZAJqLpMW2QI7SC+oN4w+/oN3bQOB359Jxs45GHp
	 PGxlDSWcbdMijkYuep85+X6iDxibfC70sbG7CrgcHIiVVnVjdxphExMWHBhbcSUm0G
	 73Udd4qBb5ysvsXCXDY9PgaKSZk4TzGMjhQrEO/cMakGqe+/428x2F2VI0myS3vjoA
	 4XHfsjL5cxLF+IoELaYzXhs1NADa3BqhsbYbf1+CJi0mKNnpoHWc0wA7/0a2PfYY95
	 0RiF/KdqhquEw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BE2E14B743;
	Fri, 27 Nov 2026 10:34:17 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 16:04:02 +0530
Subject: [PATCH v2 7/7] iio: Simplify callback registration error checks
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
Message-Id: <20261127-19-oct-hid-iio-unified-print-framework-v2-7-3f476fe1a940@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795775655; l=4750;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=mGLaKUDpq2xrxFyO4D1gwOJXhOtVXrnf8YKu9o1By3I=;
 b=JGK1JRUAMSKl0bz8dFdCKS6CwY6mNPNXmb74SMesd85P+fEuWcfvj3IYiSOyNOqfjC5HxJXMC
 4JVCEj+0rzZB1Y8ixrUjx+VrAUBnY1WNz2MnTSfGzulUyra3BQtsGsF
X-Developer-Key: i=sanjayembeddedse@gmail.com; a=ed25519;
 pk=PcneEFtkmY+Ldl+KmOTpB/Q/HDsqko6Fb0/Z/5cuycI=
X-Endpoint-Received: by B4 Relay for sanjayembeddedse@gmail.com/20260702
 with auth_id=848
X-Original-From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Reply-To: sanjayembeddedse@gmail.com
Content-Transfer-Encoding: 7bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

devm_sensor_hub_register_callback() returns 0 on success and a
negative error code on failure. Replace open-coded error checks
using:
	if (ret < 0)
with:
	if (ret)
across HID sensor drivers using the helper.

This simplifies the code and aligns it with common kernel
error-handling style without changing behavior.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/accel/hid-sensor-accel-3d.c              | 2 +-
 drivers/iio/gyro/hid-sensor-gyro-3d.c                | 2 +-
 drivers/iio/light/hid-sensor-als.c                   | 2 +-
 drivers/iio/light/hid-sensor-prox.c                  | 2 +-
 drivers/iio/magnetometer/hid-sensor-magn-3d.c        | 2 +-
 drivers/iio/position/hid-sensor-custom-intel-hinge.c | 2 +-
 drivers/iio/pressure/hid-sensor-press.c              | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index d75ee16b8f45..386dbbda57d4 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -380,7 +380,7 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 	accel_state->callbacks.pdev = pdev;
 	ret = devm_sensor_hub_register_callback(dev, hsdev, hsdev->usage,
 						&accel_state->callbacks);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	return devm_iio_device_register(dev, indio_dev);
diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index d5acb38268af..c89e5a7a3222 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -317,7 +317,7 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 	ret = devm_sensor_hub_register_callback(dev, hsdev,
 						HID_USAGE_SENSOR_GYRO_3D,
 						&gyro_state->callbacks);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	return devm_iio_device_register(dev, indio_dev);
diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 9b3c8d8345b9..a7783b947564 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -417,7 +417,7 @@ static int hid_als_probe(struct platform_device *pdev)
 	als_state->callbacks.pdev = pdev;
 	ret = devm_sensor_hub_register_callback(dev, hsdev, hsdev->usage,
 						&als_state->callbacks);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	return devm_iio_device_register(dev, indio_dev);
diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index 4d0c7dffc252..b793d7abc0f5 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -306,7 +306,7 @@ static int hid_prox_probe(struct platform_device *pdev)
 	prox_state->callbacks.pdev = pdev;
 	ret = devm_sensor_hub_register_callback(dev, hsdev, hsdev->usage,
 						&prox_state->callbacks);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	return devm_iio_device_register(dev, indio_dev);
diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index c179fcd364b9..742dc4130e66 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -493,7 +493,7 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 	ret = devm_sensor_hub_register_callback(dev, hsdev,
 						HID_USAGE_SENSOR_COMPASS_3D,
 						&magn_state->callbacks);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	return devm_iio_device_register(dev, indio_dev);
diff --git a/drivers/iio/position/hid-sensor-custom-intel-hinge.c b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
index 9bc0262b27c4..4773577dcd57 100644
--- a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
+++ b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
@@ -316,7 +316,7 @@ static int hid_hinge_probe(struct platform_device *pdev)
 	st->callbacks.capture_sample = hinge_capture_sample;
 	st->callbacks.pdev = pdev;
 	ret = devm_sensor_hub_register_callback(dev, hsdev, hsdev->usage, &st->callbacks);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	return devm_iio_device_register(dev, indio_dev);
diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index 2d098ed35ff6..8b41e1461993 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -284,7 +284,7 @@ static int hid_press_probe(struct platform_device *pdev)
 	ret = devm_sensor_hub_register_callback(dev, hsdev,
 						HID_USAGE_SENSOR_PRESSURE,
 						&press_state->callbacks);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	return devm_iio_device_register(dev, indio_dev);

-- 
2.34.1


