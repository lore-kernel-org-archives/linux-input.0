Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B213D3D01;
	Mon, 20 Jul 2026 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540426; cv=none; b=MKiKozQI3d2bNulaGoGXrhDp4g7uv0ltiHe4cMysbF8zOHvtEneOZRdOI0E+6/tyHU/HbAPTvNCAbn43gulVn1p2/vB9+RH8GZy016AGkqQWk9B1mH70KWuNlpwui+YprKCBK+rs9f6t1p2wWU65p1ns9PKvvZFjXCDO4rC97oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540426; c=relaxed/simple;
	bh=m8yQ6Rt1BmfoSca8nbLNUGHQrRGO6KhHvj/M48iE0QA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qSgcdhi5n9LuPXREy0imumLXqFH0g2xu4loYpwP8U5a+3h92G+IU3Mlmeyddk5TFmu7U1naw7YA70LSd6tFxm1trchdIEsoyxqdKf08xFCixD3MoPXoPAcgiUnPHcbj3reAyPv8tR/TwvQQuwipFSJ8mgnQ5yJlRpruKPlRzhQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6I8d+sQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6I8d+sQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84CD8C2BCFA;
	Mon, 20 Jul 2026 09:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784540425;
	bh=m8yQ6Rt1BmfoSca8nbLNUGHQrRGO6KhHvj/M48iE0QA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=g6I8d+sQINcwD+N3vTTsJWxM7xbLUCD5gt9Fk3Wkog57zU9Ya34F1G7/7lzrYvwME
	 eGrGcwZQPrNZFoIQ1pOsfKWpbsqeg3njfpXKJM41YSPj22Y+/OlYPN6khSaN/D5YWI
	 4LdgIeaWkrCpL0VeD6rBs8NtWNfYKHtjleXc4IUAqBvMyvDxIJunFoReMUcWAIIx5K
	 /tvBpS3s/ImwM8/tMWpwff2O33ltqMdJUFNxsL4gNOYOEwTCBQ+8vTxwKHZqzWRM7R
	 CDRIZuhZgObuaiBmk2JRV2jQ2DBTq5DyeEo+dIqwxChT2drEbaAFww5Px00XONnalG
	 t0G1sRQrxSWfw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674CEC44515;
	Mon, 20 Jul 2026 09:40:25 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Mon, 20 Jul 2026 15:10:13 +0530
Subject: [PATCH 01/10] iio: humidity: hid-sensor-humidity: use local struct
 device
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-hid-iio-local-struct-device-v1-1-74496fee6327@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784540423; l=1433;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=LsnrdNMs3dMUtTK3CAAIvAss81SC1EE8A5C3AYP1tnY=;
 b=A8l/C4PtdauXUHADBaRxAw3cHyKxhem+dupRUirYRB+89tMZOq09jwan1Lkb8dBEps0LngH+b
 ruzXFQxQ3A/C0CjUBYA4pdZzLK4bgtU8NOA61dFIQutOF83b2oMUMGD
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
 drivers/iio/humidity/hid-sensor-humidity.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index 7cec81ff5685..1b254d3aeee9 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -196,10 +196,11 @@ static int hid_humidity_probe(struct platform_device *pdev)
 	struct iio_dev *indio_dev;
 	struct hid_humidity_state *humid_st;
 	struct iio_chan_spec *humid_chans;
-	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(dev);
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*humid_st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*humid_st));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -215,7 +216,7 @@ static int hid_humidity_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	humid_chans = devm_kmemdup(&pdev->dev, humidity_channels,
+	humid_chans = devm_kmemdup(dev, humidity_channels,
 				   sizeof(humidity_channels), GFP_KERNEL);
 	if (!humid_chans)
 		return -ENOMEM;

-- 
2.34.1


