Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05574483A2;
	Fri, 24 Jul 2026 17:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784913275; cv=none; b=Ip4L3/9bAqJkNnPzgXc6foDGMALN3VidiQ2L+u3ydLsPd4ASXr6CcEczhuv0UYywhl8lRDmkFEbUPwSCswbVgOv0vAA0J/VxzanWG1sMX12H7NHRejhZ08E7Hr+p/jiTv5cZgm/1MFfaX46wycjbkISQdMzJ/ehTOZChc9jLdRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784913275; c=relaxed/simple;
	bh=6Sz2TNn5Fm2jH5hN5O393rqL3ELIe9HYZv5EDmHdF5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aTxW+KEweqo4cg6LHjPLsjQxoADfm6SQ5wlX6M6IWlmC+lmkpYZxg6Dd1cw8IAtmJxVkxBlAOI13gojTiVkjGFxQuLnCNpvGLmuFTCL5FEGmPYrgbOLNr2NG17c7eLg5jAIasaf7l8vB+7dEsW8wrs8UjrqADTikYBXTzMHUvb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbujzISk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbujzISk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A5E2C2BCC6;
	Fri, 24 Jul 2026 17:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784913274;
	bh=6Sz2TNn5Fm2jH5hN5O393rqL3ELIe9HYZv5EDmHdF5k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FbujzISkiUj8/hCs7ekCtJx/4PhkgrfE6UgKuUk+eDFAwBsplVTopUIhUbRQLzz4f
	 SZIqOrod3TSrjjGUQF6OnfXU1LwYYc1gLtaL0O9o9MPJAD3ioDuuG3KHFiOqY6Zc9w
	 Igox8c6xKRjua2dyNv4+hWOS+It2B8iyMk6KuyHhRIOXR/HkQmmC74T+l9ojwXUNJ9
	 hzITUkRxVdnHLEIdIIEKgWh+d57kayS+7FzjFItd2gkLp9TG9RHfHXsBRiI76dvrkW
	 ISFVWiBoq0YR6+hqnpXi4IzDUR/q5Vv22V551eCJQHT8Rlz1TD4oLcxbIk8/mMWVC9
	 +xZOqAmfA703A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787B9C531C9;
	Fri, 24 Jul 2026 17:14:34 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Fri, 24 Jul 2026 22:44:30 +0530
Subject: [PATCH 1/2] iio: gyro: hid-sensor-gyro-3d: Remove redundant
 dev_err()
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-24-july-hid-gyro-dev-log-clenaup-v1-1-0c932b77104a@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784913273; l=1958;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=zMheGuuc4vF/gP/k9/MKUw8lThFAAyDdy4zzifP2AP8=;
 b=ivOd+yNZ9AFoKse8Muhv49b1pDBz0c4KekVlJcmhqydOryAaUmGJaBKyxqHzn9acVkK9XtC7j
 fsLruF/8K28DgpA16Dt+OrofakH5N5yObfu7GiHFnjahVoJ4D4Pp70/
X-Developer-Key: i=sanjayembeddedse@gmail.com; a=ed25519;
 pk=PcneEFtkmY+Ldl+KmOTpB/Q/HDsqko6Fb0/Z/5cuycI=
X-Endpoint-Received: by B4 Relay for sanjayembeddedse@gmail.com/20260702
 with auth_id=848
X-Original-From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Reply-To: sanjayembeddedse@gmail.com

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Respective APIs used during probe setup already emit detailed error
messages or return appropriate standard error codes on failure.

Remove the redundant/dead driver-specific dev_err() calls to avoid
duplicate error reporting.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/gyro/hid-sensor-gyro-3d.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index 58250a972567..bcf53e267701 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -291,10 +291,8 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 
 	indio_dev->channels = devm_kmemdup(&pdev->dev, gyro_3d_channels,
 					   sizeof(gyro_3d_channels), GFP_KERNEL);
-	if (!indio_dev->channels) {
-		dev_err(&pdev->dev, "failed to duplicate channels\n");
+	if (!indio_dev->channels)
 		return -ENOMEM;
-	}
 
 	ret = gyro_3d_parse_report(pdev, hsdev,
 				   (struct iio_chan_spec *)indio_dev->channels,
@@ -313,26 +311,20 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 
 	ret = hid_sensor_setup_trigger(indio_dev, name,
 				       &gyro_state->common_attributes);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "trigger setup failed\n");
+	if (ret < 0)
 		return ret;
-	}
 
 	gyro_state->callbacks.send_event = gyro_3d_proc_event;
 	gyro_state->callbacks.capture_sample = gyro_3d_capture_sample;
 	gyro_state->callbacks.pdev = pdev;
 	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D,
 					   &gyro_state->callbacks);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "callback reg failed\n");
+	if (ret < 0)
 		goto error_remove_trigger;
-	}
 
 	ret = iio_device_register(indio_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "device register failed\n");
+	if (ret)
 		goto error_remove_callback;
-	}
 
 	return ret;
 

-- 
2.34.1


