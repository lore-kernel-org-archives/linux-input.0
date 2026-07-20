Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5027F3D6CC1;
	Mon, 20 Jul 2026 09:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540426; cv=none; b=ADGDCtm2RpxnJEHBq6v8nwJsgUll/oe7CoX7DtHBymBM1ufPuivdt99aITvE3/DmUEvoORMUmy5sMt/4c9gTIxAz4i5IUgf5aS/lqLYaW0oC91tXq06xYlKAXlJQ1oosXxfCIG+TPH/gOpSQVu2J8iS12Tvi0Yb21uszdGlMPP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540426; c=relaxed/simple;
	bh=MPeOdP4SkOcASrgCV4avFzAju0M+4lDARLhfqkXVOdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TLNrWFt5lA6J+pvbRb27QUh+rqssd8qAG8BNJlR1S+uHGVFavdpe9zDmNpud6ryw/cEcXFT+cAcPuqmEn60LmL1nKCleJExbQAq4FM1bVyloOAv85rJu3LFieefSR0ec1Zemt7uAaYgHhvfS/04ksJ/PiOREEYTlQeivu0oc54s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFHhimgw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFHhimgw"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 243B5C2BCFB;
	Mon, 20 Jul 2026 09:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784540426;
	bh=MPeOdP4SkOcASrgCV4avFzAju0M+4lDARLhfqkXVOdQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hFHhimgwAarhdRYALQH+BVBU7/udLOiZilYuJwZ5dzqSb2BG8OIcM0wCQj/QmEFkb
	 VNHYsQWA6XxLm1u+q4TZLUWZi/1iF9hgAi13s+l2TclCSNdtrocAIEgwJ4qjYRqGJI
	 ZVSOexi5aqbOb0PbFxwL5OIy7ELA3fF/7hQAdBKtewB28NZqx4Uv4GQKSnEE7xve2Q
	 ML1gVnDWSrhrwBjv8X4Uc4p2F1NXTNDmD6+jbgg+80gWPra4g50/rMD90RqmqXeOKf
	 yiQudReI1kOi7xT0tfVpJe+zuBgDvZzw0ubdLMwJ5zT+B5oT5lhtOJLhslo/eWfe2k
	 EbnMBA85QXArA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127E9C44515;
	Mon, 20 Jul 2026 09:40:26 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Mon, 20 Jul 2026 15:10:21 +0530
Subject: [PATCH 09/10] iio: position: hid-sensor-custom-intel-hinge: use
 local struct device
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-hid-iio-local-struct-device-v1-9-74496fee6327@gmail.com>
References: <20260720-hid-iio-local-struct-device-v1-0-74496fee6327@gmail.com>
In-Reply-To: <20260720-hid-iio-local-struct-device-v1-0-74496fee6327@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784540423; l=2998;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=335qLwG5/pzStAQdngH/Ah3Hgz4pPlTw4zyMjA4o7Lw=;
 b=hzPvTzO1/FjX0EBZLY4GGVtTYfYQAZZphUrit8Xxg7vVCznoema1xjSXTn6HInQVKy+Ul9FBA
 i3Xk8zOP1YfAptwnAWjUjV5pfC33VdYxPzAurA9BtbChAkDv7oC+f0Q
X-Developer-Key: i=sanjayembeddedse@gmail.com; a=ed25519;
 pk=PcneEFtkmY+Ldl+KmOTpB/Q/HDsqko6Fb0/Z/5cuycI=
X-Endpoint-Received: by B4 Relay for sanjayembeddedse@gmail.com/20260702
 with auth_id=848
X-Original-From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Reply-To: sanjayembeddedse@gmail.com

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Introduce a local struct device pointer derived from &pdev->dev.
This avoids repeated &pdev->dev usage and improves readability.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/position/hid-sensor-custom-intel-hinge.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/position/hid-sensor-custom-intel-hinge.c b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
index d275bc1413fe..febc32f5a332 100644
--- a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
+++ b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
@@ -263,13 +263,14 @@ static int hinge_parse_report(struct platform_device *pdev,
 /* Function to initialize the processing for usage id */
 static int hid_hinge_probe(struct platform_device *pdev)
 {
-	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(dev);
 	struct hinge_state *st;
 	struct iio_dev *indio_dev;
 	int ret;
 	int i;
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -287,12 +288,12 @@ static int hid_hinge_probe(struct platform_device *pdev)
 						 hinge_sensitivity_addresses,
 						 ARRAY_SIZE(hinge_sensitivity_addresses));
 	if (ret) {
-		dev_err(&pdev->dev, "failed to setup common attributes\n");
+		dev_err(dev, "failed to setup common attributes\n");
 		return ret;
 	}
 
 	indio_dev->num_channels = ARRAY_SIZE(hinge_channels);
-	indio_dev->channels = devm_kmemdup(&pdev->dev, hinge_channels,
+	indio_dev->channels = devm_kmemdup(dev, hinge_channels,
 					   sizeof(hinge_channels), GFP_KERNEL);
 	if (!indio_dev->channels)
 		return -ENOMEM;
@@ -301,7 +302,7 @@ static int hid_hinge_probe(struct platform_device *pdev)
 				 (struct iio_chan_spec *)indio_dev->channels,
 				 hsdev->usage, st);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to setup attributes\n");
+		dev_err(dev, "failed to setup attributes\n");
 		return ret;
 	}
 
@@ -313,7 +314,7 @@ static int hid_hinge_probe(struct platform_device *pdev)
 	ret = hid_sensor_setup_trigger(indio_dev, indio_dev->name,
 				       &st->common_attributes);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "trigger setup failed\n");
+		dev_err(dev, "trigger setup failed\n");
 		return ret;
 	}
 
@@ -322,13 +323,13 @@ static int hid_hinge_probe(struct platform_device *pdev)
 	st->callbacks.pdev = pdev;
 	ret = sensor_hub_register_callback(hsdev, hsdev->usage, &st->callbacks);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "callback reg failed\n");
+		dev_err(dev, "callback reg failed\n");
 		goto error_remove_trigger;
 	}
 
 	ret = iio_device_register(indio_dev);
 	if (ret) {
-		dev_err(&pdev->dev, "device register failed\n");
+		dev_err(dev, "device register failed\n");
 		goto error_remove_callback;
 	}
 

-- 
2.34.1


