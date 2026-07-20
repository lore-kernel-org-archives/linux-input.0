Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E757D3D45C3;
	Mon, 20 Jul 2026 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540426; cv=none; b=q9rtc566U389lMQFpMuSksL0aPpGFeFpf3Z1ACm2hLRTquvzuTEZ4DihuLAFNg6OaCevC3bi8MCGnqdwYvSfYddyrUtzZiNHvYk1jC6gf2A3bTvhjNsE9jR0Wwfxfa7A+5oz19CN4Vqal3W3y3BmNSnseMLGuW3MQG2Tze/6Lz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540426; c=relaxed/simple;
	bh=zaBr0PDxlFDjbKhNg4TNqfr5zCslyQt2+TdQ+qr5rqc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gUWNaY9UG5eI+3wfYghZIj/M6HI6ihcWQTaofCsEJW+eI8NBhUax+0zlGKH2sh9bq47N/x83URILK7jf4W4KDVteTaxUeqDOjWUgy+Sfo/uLS1ITA9OQwtLWXh9kntjiBPtZVR0EGmQYGuUx4eBPUp/lQlcEOwzpz0ZzSmeVDOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaAxnxVQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaAxnxVQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3B6FC2BCFB;
	Mon, 20 Jul 2026 09:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784540425;
	bh=zaBr0PDxlFDjbKhNg4TNqfr5zCslyQt2+TdQ+qr5rqc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UaAxnxVQ9asaSfmBmA6zjsMt6AY7KSLl4zXKURa6nxL+T39pBZ7OUynlGB6LV5u7W
	 nPh/H8x8rAphgrZN8iNTQIHlmgLbKOiDFzYekywixIxAiA6PLVBO5PY957SI3rej8s
	 LW64jXk0Ff1w42XxHgxMIuK/u9dyidZ4F0qXHaW/C4swi8SnWZmF+8cFUIuYrCnVjB
	 CmHcJVKfbeY+LnQsbhayY8cmUmmWpbkkVWyEJqOrbfcdYZ9yS/syjV8TvukhS+WUni
	 KbUVdv8mYh1FfeCK475Vxl4wT8wTbjLhTChztVrIkz5yfU28Z3qO8dEZaBhO3awrg3
	 Tc4CMWqA5ofvA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D628C44525;
	Mon, 20 Jul 2026 09:40:25 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Mon, 20 Jul 2026 15:10:16 +0530
Subject: [PATCH 04/10] iio: light: hid-sensor-als: use local struct device
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-hid-iio-local-struct-device-v1-4-74496fee6327@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784540423; l=2688;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=F+9XUfQNCvbfNIZ2ifuF+mpRN7/StD6NN5AhbF5V6Y8=;
 b=Y+oYtiAJLpfMR6CVD19JRUm0qQnntcGFjkjixGjdZlhJsIWR58mOnAbfnVXlfLRkMEGkrfRa1
 U+LUfTprABvBrXvlxJgt5Y1Ao20GAjzSB+4H0gC0QOmO7TlQ00NSfd9
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
 drivers/iio/light/hid-sensor-als.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 6fb6ace26834..44088f9dff81 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -346,13 +346,14 @@ static int als_parse_report(struct platform_device *pdev,
 /* Function to initialize the processing for usage id */
 static int hid_als_probe(struct platform_device *pdev)
 {
-	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(dev);
 	int ret = 0;
 	static const char *name = "als";
 	struct iio_dev *indio_dev;
 	struct als_state *als_state;
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(struct als_state));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(struct als_state));
 	if (!indio_dev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, indio_dev);
@@ -367,7 +368,7 @@ static int hid_als_probe(struct platform_device *pdev)
 					als_sensitivity_addresses,
 					ARRAY_SIZE(als_sensitivity_addresses));
 	if (ret) {
-		dev_err(&pdev->dev, "failed to setup common attributes\n");
+		dev_err(dev, "failed to setup common attributes\n");
 		return ret;
 	}
 
@@ -375,7 +376,7 @@ static int hid_als_probe(struct platform_device *pdev)
 			       hsdev->usage,
 			       als_state);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to setup attributes\n");
+		dev_err(dev, "failed to setup attributes\n");
 		return ret;
 	}
 
@@ -397,7 +398,7 @@ static int hid_als_probe(struct platform_device *pdev)
 	ret = hid_sensor_setup_trigger(indio_dev, name,
 				       &als_state->common_attributes);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "trigger setup failed\n");
+		dev_err(dev, "trigger setup failed\n");
 		return ret;
 	}
 
@@ -406,13 +407,13 @@ static int hid_als_probe(struct platform_device *pdev)
 	als_state->callbacks.pdev = pdev;
 	ret = sensor_hub_register_callback(hsdev, hsdev->usage, &als_state->callbacks);
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


