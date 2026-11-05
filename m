Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793882517;
	b=B1WHEXNxn7CV3+scOWDG3Zb/KNMALgqjcwuCbuPMm0IuvJTcQ3BYCfcvBprN8DQN++8N
	 uXGGhDrvmc2WbPdKM+2j/bCyJs9glCKfEkI1BPahr5CPO5ajrgzzF6z40wxlDffSt7CIn
	 JYLRQu+yQ2Pny02stSo7xVts44e7VvzjKJ7bbMRpp6ul876dP3ZqctvQHiV6u+GdW5TGC
	 jKP66GcPojFwpMwgiTRZeBEzkfvQQ/1YBe/6F7b4qM9QEdcsNRbDKmoTCOVlHVT0b7Xqp
	 z9DPR5EuzSr5l6jflZgEy1NUdB3T4XHwYaQuXrYjjhJDgMxkioYiLDH5HzcTsGx7CxQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793882517;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ncXXXFEKjc/BcbHimc5MYEqIG5apTaCUodWRVSaeEAA=;
	b=gx34A0/gex66MiElc6+GEZ2RFHJ9QWe/pa3f8/t3+dNuHsJ3Mu7Z6GvIm1SayAVtSg4Z
	 yMlGB/Qzh1gwehkrPNXY51ntDXnq2P9M1x4bY+KG2fKs+CA6/Pi80yUN5qlyclUJwF062
	 LtYAXAq6a+yWZTBLu7MgPhl7gESTnj7LIjYqn6tyi/tBxuzSYk8bJi0mNR1UAwc20Ll7O
	 JzK2gwR8ES649PWwD1Oq7Fb1nAzFx9+tnf5Fu9Ehl0FoQQGM366wjsnIMYTHPMrZZGAGs
	 812L0NXMc/fIzvBS+c9z2HsOmyMgwimmYX9SzB55hhkSntCxqHf+4NVg5xCaycAF4UA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j+L6UMQ1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A10E606A32D;
	Thu,  5 Nov 2026 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j+L6UMQ1
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793882517;
	b=DDvDrjUxLdx3G05qMXhPTHXB2nrMNSDoKIT+JXK76S7kcNrD8A3Tm+lpWkQxJGu6jEMh
	 PIFgLb/qcNlSB0dwD78jKCwwqHY3zrkq39CMvTRMC80nbTnVoKZT+lPekTCWTaHnbVoaF
	 WIm8550pt78bg5R9/ouy/hAPfkHoi7g2AZpwg+PRLzP53xF7Bg6vG0zTYpOvx1DS1OgCc
	 Flk1bZlI4YnQYaUpFXjdAiM+m9Nn//bp9AkUPqOK9gQ07qllQzvsYkE3Q8K7L4jH577xS
	 YQefbJRhLlL10DRsyrJTSYbLtt8einjXDq1z05BJgSDsxXZ9kpWkZG0HAgZM8/yg1ug==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793882517;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ncXXXFEKjc/BcbHimc5MYEqIG5apTaCUodWRVSaeEAA=;
	b=xlB/aWmT4jGHQu+HYZrPrAr530M+tMDaqJTESWsAkRlFyIZCR+TU5Ii9aI72pJafmaRA
	 RVquoG5UbMJbJuOUA7cyTNNnNACfjyBITWRrEo2kerfIkF3Y0m5wZzKb5pp6ompdTRobf
	 OeGYWE3Wie3WIq7dWF28JeVrOlX3Byqfyd729Trh9E/bWMFSAd+CxZ93xJG5ZfT2LmFPg
	 +6pCwQOceXTqZd6D0WWISr7AKCf0GPclQi9m+TFvo0r0Q7pJx2nd3skdR3VAdNIsBGvV/
	 hysWNo8k4zOYt0phy5KjWxdNZJJx/wpDfeUKfdVwE8qoV72tu4E2IZJE/mTdx+mWIgA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 269761F0093A;
	Thu,  5 Nov 2026 12:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793882517;
	bh=ncXXXFEKjc/BcbHimc5MYEqIG5apTaCUodWRVSaeEAA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=j+L6UMQ13mv7xN8areLTWee7ppXHe0XsSTDC2LWyuqjubNCIa9s/ouy/ZSYdx5E96
	 rtB8VYbR7B77grKS2hsiVW1UHrdcRjVs3ddS2ZyJ/WxyJ8YITpiB5GooOqKsWb2WiG
	 LdRIz5uibLoi6RUL8hCFzVA01d5ubEmuzebNeb2L+HgjLAloyU88ANcDNMAgSUmEVB
	 tXgUrxhSnOQ+oVQ3khTtLFdY/EPE4NfI7iOb4n7aQpY1A/6Ymz8c2Z2tJfvJSQQHDR
	 ceo5yXU59Puryi7jBlWuaN+Wj6MNtN8Dq1Z4FIsM5m+LhB45vhlxEgUARrGIdEJjiy
	 w0G+I3PpT6kbQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 98CFE4724E;
	Thu,  5 Nov 2026 12:41:55 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Thu, 05 Nov 2026 18:11:44 +0530
Subject: [PATCH 2/5] iio: Remove redundant devm_kmemdup() allocation
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
Message-Id: <20261105-19-oct-hid-iio-unified-print-framework-v1-2-0b360d9552d9@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793882514; l=3473;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=GYfroI7CBTuLtaumkcLBm2D6Hmur3RtVQHOcYJz2ogE=;
 b=wmNDhR8qIp8Ex97D7o1qZIaB5UBXiBRKVhj5TiQb3+NZT7L7IXg8HIPq+vbxbFhendIGpu6aJ
 pA1A5OpyzKmCEkgfjaYJbQlW9khIugJ1EXpgACzW9Kk/fOdxplA5xAz
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


