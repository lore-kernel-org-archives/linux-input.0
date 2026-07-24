Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04313B5F63;
	Fri, 24 Jul 2026 17:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784913275; cv=none; b=DUlbiO7+cTy4c0NfXoeg8Xu/4zNvCVmKw3fcyCHq1SYYFb4U7AjRdMvb5waBjOokeeZahCTBCaiLZ3FFeK95lt7nV3pbQEPm/NhY6AHe7q4Kc4KU2H33qJW/qRatPMIyojDApu/jbLwN37lhffI4oBYWAjaxa9mqVbN/1w8X3zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784913275; c=relaxed/simple;
	bh=uX+aZDvIUgiYUwh1eMIJqsdnZOR2F1YQni+4Upcz2p0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aLpJildeoaSzWGntf03COCVmViirXiKA69C2uwhn7lS0hBLOECSekg336l+I76qDsFt2H8MAoBjsVrlQNxxOFOwxwpcE1QzD2lpkZ0/PluQrHLKvoSdYLc9qINGsMoQiUwijrbvEz9GivfHC+NpCXSM68cEY775ZuMKHszKpz7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFfbPAvf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFfbPAvf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4B69C2BCF7;
	Fri, 24 Jul 2026 17:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784913274;
	bh=uX+aZDvIUgiYUwh1eMIJqsdnZOR2F1YQni+4Upcz2p0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VFfbPAvfvvJNBLfNLy7kUMe/NNe5mkXeF6QxNMmP+LiZNnOO8bLCKkw4Bo4cMSYAH
	 f31flrn/SSoKkOAfpGgcp5azsNcwNM+mgcX5WYl6ziqR7r9+U4oLjvVig2ZAUF84/2
	 bRQRLlRHOk9FYMeFpUChYJxno3hY42QQhQgHJ7Vzl9qI7x+3goGmteUjXxgosPfFdt
	 4KTItX2y4uW4ifeG9+JNa7MbJa1GalbvDncxsx5Pzr5eoSkRshb690DYyJcwS4coHs
	 zwTBrlw/sVyn79+Fao+ou0TlalzlEoWiIvMBum4+qR2WTuuJZN/4nJy88HZU4si9w8
	 g9IFD77r5D1Ng==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CD0C53200;
	Fri, 24 Jul 2026 17:14:34 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Fri, 24 Jul 2026 22:44:31 +0530
Subject: [PATCH 2/2] iio: gyro: hid-sensor-gyro-3d: Use dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-24-july-hid-gyro-dev-log-clenaup-v1-2-0c932b77104a@gmail.com>
References: <20260724-24-july-hid-gyro-dev-log-clenaup-v1-0-0c932b77104a@gmail.com>
In-Reply-To: <20260724-24-july-hid-gyro-dev-log-clenaup-v1-0-0c932b77104a@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784913273; l=2434;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=5yZBBgZyBZR9a7OymuE8xZQvzU+g4J+sN/w2/1RfQjw=;
 b=yjP5+S0ol5SG+cq5Ibhsrrsr+m32KH3KQIKaPiJFseF2Gj7X2pt2yIK5uUdPi7Mh+FqpGo/OF
 zZKWAZQr6IYA8eqRJuEl7oxCyFgZqaaFFXfIcKMi9WU1RtTMe7NMuyZ
X-Developer-Key: i=sanjayembeddedse@gmail.com; a=ed25519;
 pk=PcneEFtkmY+Ldl+KmOTpB/Q/HDsqko6Fb0/Z/5cuycI=
X-Endpoint-Received: by B4 Relay for sanjayembeddedse@gmail.com/20260702
 with auth_id=848
X-Original-From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Reply-To: sanjayembeddedse@gmail.com

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Replace dev_err() calls with dev_err_probe() during probe.

dev_err_probe() makes error code handling simpler and handle
deferred probe nicely (avoid spamming logs).

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/gyro/hid-sensor-gyro-3d.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index bcf53e267701..48540c9a097c 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -264,13 +264,14 @@ static int gyro_3d_parse_report(struct platform_device *pdev,
 /* Function to initialize the processing for usage id */
 static int hid_gyro_3d_probe(struct platform_device *pdev)
 {
-	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(dev);
 	int ret = 0;
 	static const char *name = "gyro_3d";
 	struct iio_dev *indio_dev;
 	struct gyro_3d_state *gyro_state;
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*gyro_state));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*gyro_state));
 	if (!indio_dev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, indio_dev);
@@ -284,12 +285,10 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 						&gyro_state->common_attributes,
 						gyro_3d_sensitivity_addresses,
 						ARRAY_SIZE(gyro_3d_sensitivity_addresses));
-	if (ret) {
-		dev_err(&pdev->dev, "failed to setup common attributes\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to setup common attributes\n");
 
-	indio_dev->channels = devm_kmemdup(&pdev->dev, gyro_3d_channels,
+	indio_dev->channels = devm_kmemdup(dev, gyro_3d_channels,
 					   sizeof(gyro_3d_channels), GFP_KERNEL);
 	if (!indio_dev->channels)
 		return -ENOMEM;
@@ -297,10 +296,8 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 	ret = gyro_3d_parse_report(pdev, hsdev,
 				   (struct iio_chan_spec *)indio_dev->channels,
 				   HID_USAGE_SENSOR_GYRO_3D, gyro_state);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to setup attributes\n");
-		return ret;
-	}
+	if (ret)
+		dev_err_probe(dev, ret, "failed to setup attributes\n");
 
 	indio_dev->num_channels = ARRAY_SIZE(gyro_3d_channels);
 	indio_dev->info = &gyro_3d_info;

-- 
2.34.1


