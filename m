Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F063D6662;
	Mon, 20 Jul 2026 09:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540426; cv=none; b=qL4Ju63F01eyyB2C/q9krSFugQ3uVcqJsllHqskIYyQf0ToPwDfsblzOS8firE/4Om31QYBWWKnTmMW9YpMr75VdFD9q4rfi3Qe7cW/FfyW0k9me+v+Xj+22X/eT/AX8TK6b+fA6zcT+/ZEN9mcb6X/nSqECT46IcADP8nurapU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540426; c=relaxed/simple;
	bh=NCOfztZyq77uNFx8wStBag95ysryTVtpTDs/tH+si8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DktgxqEWF+PGzUw9uyzW9oZnSjXgSyPc7Qhm+R3U15s9wzzPMLqTAHKvawSaGfiCeo5CWPodUO1FKu9OwHyttQcVw5gdz24Yo3/NituAmHLkM4xRkkQwf5EgbmDtBXaTOWtoGEaCiTh0ZZEFQjYIkSZFjM7l9Acc746FjgGUQYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLpZxfA3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLpZxfA3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8390C32781;
	Mon, 20 Jul 2026 09:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784540425;
	bh=NCOfztZyq77uNFx8wStBag95ysryTVtpTDs/tH+si8E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GLpZxfA3N3KoQH5siDoBugS72xxXVME6mg/9BkS2SbCDESEwlYMCNPIQgLcbtEnL0
	 /Yc9T8xtRtNBK0G9uiGaFcQ9fPYBhq6rvKufN9ZIExuM2eJ/sXU6rWrIfFuYJzHhHU
	 n0Slgj7grudoH0cIxqxC55TwBBlai5FNJgmYyFoh/ZUFU379pQa5HAK1BcI141WjJH
	 eu70gbwaUBgPAv2XVwU2zio/Cp8Qkk7czi/ktiV75YX3dw0vF+F/bpZ8bRUwciUD8e
	 mkXVOw2znxNhgwq7ER01R4Ko5CC56shAHd7iQdEUg0I40GLRujVNwBKFKBaEG0rzOf
	 crC5lMD3kJd0g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EE6C44515;
	Mon, 20 Jul 2026 09:40:25 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Mon, 20 Jul 2026 15:10:17 +0530
Subject: [PATCH 05/10] iio: light: hid-sensor-prox: use local struct device
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-hid-iio-local-struct-device-v1-5-74496fee6327@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784540423; l=2605;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=7IEUJ7GehDEbevcdEbVmc72XuPyYDVyBe9W1Pn/2AZo=;
 b=eMfxO4F4HaKBiIyMvMz1CG87O8xv8otT0Q3/62nTcgy+LhSBaMi+dEjmc9z+AfzoXQoQEgXqR
 4KqV0GuNPb+AfYhiFg9TujzlVCoa4SWT3vl3SAs5ZNRhVnZijtAObdG
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
 drivers/iio/light/hid-sensor-prox.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index 63fd3eff171c..e7fe40726385 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -260,13 +260,14 @@ static int prox_parse_report(struct platform_device *pdev,
 /* Function to initialize the processing for usage id */
 static int hid_prox_probe(struct platform_device *pdev)
 {
-	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(dev);
 	int ret = 0;
 	static const char *name = "prox";
 	struct iio_dev *indio_dev;
 	struct prox_state *prox_state;
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(struct prox_state));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(struct prox_state));
 	if (!indio_dev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, indio_dev);
@@ -280,13 +281,13 @@ static int hid_prox_probe(struct platform_device *pdev)
 					prox_sensitivity_addresses,
 					ARRAY_SIZE(prox_sensitivity_addresses));
 	if (ret) {
-		dev_err(&pdev->dev, "failed to setup common attributes\n");
+		dev_err(dev, "failed to setup common attributes\n");
 		return ret;
 	}
 
 	ret = prox_parse_report(pdev, hsdev, prox_state);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to setup attributes\n");
+		dev_err(dev, "failed to setup attributes\n");
 		return ret;
 	}
 
@@ -302,7 +303,7 @@ static int hid_prox_probe(struct platform_device *pdev)
 	ret = hid_sensor_setup_trigger(indio_dev, name,
 				       &prox_state->common_attributes);
 	if (ret) {
-		dev_err(&pdev->dev, "trigger setup failed\n");
+		dev_err(dev, "trigger setup failed\n");
 		return ret;
 	}
 
@@ -312,13 +313,13 @@ static int hid_prox_probe(struct platform_device *pdev)
 	ret = sensor_hub_register_callback(hsdev, hsdev->usage,
 					   &prox_state->callbacks);
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


