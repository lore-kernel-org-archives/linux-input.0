Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E92B3859D7
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 11:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780745863; cv=none; b=LigV9Emg6byhU+elpiPeiwtxQrcvReK/UBfyWsUq3Su+sg7SgsdG84kfY7fM3v+KdhgU1p7V9yMy2T+z9M6/LfuqgLLm6NY/QpaPt3D2u0UwLQIjYJ9Vu2tocjgfz2bswGYcnrt7iDEqJh9O5BY8MNJakc5S31SjLhSZhTdTWH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780745863; c=relaxed/simple;
	bh=iFoixcaubAgWtOmNYa8MGEmxxGpRfN83yA18/55OJQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ittueeWl0RN6+vuSNg9OPWNu8W0MCDzChiMpq/rZE03vLuw6E6+A0ow5oQRzi+J7EkaFlleUVXgRPF04xSCVLWc/x9T11j6f7bKPEIQZFORomBikPRfJwE4aBzly0ro45xUdMrs+zvZxpDOHBwuRdw766I0uqpSN17j51OkU2x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PupG7zj+; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PupG7zj+"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36baeec21dcso1758920a91.3
        for <linux-input@vger.kernel.org>; Sat, 06 Jun 2026 04:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780745861; x=1781350661; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UWLRt5Ufc5uZrv1CDuPUHEEt/aIkJjHgw4R+DItFMcI=;
        b=PupG7zj+hNk++e1Hn74iZvuqOf+rLKTQja42HZmAdXHQrgTcIcooQZqsUIccuYMUhG
         oKCMh/vLG/jjIw+sCxVMUfAS651qdY3rcFxQBz+7b/0Vc1yQ15YTt7Uu7BDtUVSvpfdB
         cfhmWeJYqiSPUx1cMqJXnKD3cilSTly0UbiO7tsARkryGMRWWOk2PqjNPACsXOZ4nO+0
         0qGSZOMFHyDK5TSdEldDiFStDJ4ybZb5zp4Wd4JDpUgGT7JVRSaFp0KjRSiOgnY+KAMO
         o9gUVcntY26S02L4Qbp2Ko0NJuwttqPBsVSR7GoFIMix21tTUTRXbuDs+2C3G/RnCTEt
         UeKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780745861; x=1781350661;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UWLRt5Ufc5uZrv1CDuPUHEEt/aIkJjHgw4R+DItFMcI=;
        b=MUQraWbHvQ5wFEmlxOi8047lnHgD6Wwm67YJjAVjiNt+VMRoQHG+gRIBLAh9dph42x
         VHDebyUMmu4Z8/r/5gFCCzYC15dXwG8JRiEWCxHHb0HB/Q0sTFN824tur2RhWAf/ndLA
         IrlMRszWr5gqLypI1Fup9C6r23fAvmSNt4RSgK1Wy2A2lSBK4SMwoMVW+mJ8IGgd8Q6j
         IOpALXzs4jC3Q7rT1UGSm6OJ+Nua9patgUkrHABeCSaPPNgvOw0uUYqqmUD3MP1+FaSp
         704MrZ+9f1syvASlOn65RgcibM0FkLhWg1X8rZkRJoS8DEO2cybyedioVvVWFHN840mL
         jW2g==
X-Gm-Message-State: AOJu0YwH++hRTNopUI50Kk4aW4Bq/BO3l8Dovljp0HMwGojnngYtVM6C
	bWriWF95KP1bFmIoj8SuuVvMkd85bUEQRW+SVD543SqmRFrktaCQAnGcBWptdw==
X-Gm-Gg: Acq92OHfndqEEvcTWhqUdAuCLoEtRPS6WPEaQiC1B6wXvDd74P9KTA9nyXYT7maFFUB
	w33RhvnvQrI6BNmRhOEzdrlUcTjoa9XRmr+1ehIxHs6CrEFEaIiYlQwxQ/amclZ4lCiiFv4+1fY
	b8HwCTA1lLZffeldKcuCYbsxFd3si4MoCmtMN1N6F/j4ml3+0BYeWHisLPBLoK0xEwCjFRJWp3g
	xxhYi8zmBPJiu2dea3AR8JZrVjf8n5nATNCMTjNd7qM6EOTXTJZaCIqrA7ej3qONqIQ+yqHn+2A
	Wk2JaWvG1lV1k2B/Wh+xtlhH6l5Zcbw3jwtpwoCN8RXx1CIPwQS4ESpbefYiPCydVHY79xg4/Yh
	DOOpFDlFS6U7u/2Jfge8laHKCmOT/0nIHek220y01LJtQBqji8eT7qU9djkgMVdYqAZ+xyNdo/I
	99LsKh8ZYFrjxSmpp7BOfQdVGZlCZ3BbXGiBHIirj9GkU1/U5cx3UxqSMz5Gs=
X-Received: by 2002:a17:90b:580e:b0:369:932a:2b8a with SMTP id 98e67ed59e1d1-370ee643fd2mr9471017a91.1.1780745861135;
        Sat, 06 Jun 2026 04:37:41 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-371358615aesm3220830a91.2.2026.06.06.04.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 04:37:40 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Sat, 06 Jun 2026 17:07:10 +0530
Subject: [PATCH 1/9] iio: orientation: hid-sensor-rotation: Fix race
 between callback registration and device exposure
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-5-june-hid-iio-race-fixes-v1-1-27a848c5758f@gmail.com>
References: <20260606-5-june-hid-iio-race-fixes-v1-0-27a848c5758f@gmail.com>
In-Reply-To: <20260606-5-june-hid-iio-race-fixes-v1-0-27a848c5758f@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Archana Patni <archana.patni@linux.intel.com>, 
 Song Hongyan <hongyan.song@intel.com>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 srinivas pandruvada <srinivas.pandruvada@intel.com>, 
 Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

The driver registers the IIO device before completing sensor hub
callback registration and unregisters callbacks while the IIO device
is still exposed during teardown.

This creates race windows in both probe and remove paths, which can
lead to NULL pointer dereferences or use-after-free.

Fix this by correct ordering of callback registration and
IIO device registration in probe and remove paths.

Fixes: fc18dddc0625 ("iio: hid-sensors: Added device rotation support")
Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/orientation/hid-sensor-rotation.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index 4a11e4555099..fd9beb93cefb 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -332,12 +332,6 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "device register failed\n");
-		goto error_remove_trigger;
-	}
-
 	rot_state->callbacks.send_event = dev_rot_proc_event;
 	rot_state->callbacks.capture_sample = dev_rot_capture_sample;
 	rot_state->callbacks.pdev = pdev;
@@ -345,13 +339,19 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
 					&rot_state->callbacks);
 	if (ret) {
 		dev_err(&pdev->dev, "callback reg failed\n");
-		goto error_iio_unreg;
+		goto error_remove_trigger;
+	}
+
+	ret = iio_device_register(indio_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "device register failed\n");
+		goto error_remove_callback;
 	}
 
 	return 0;
 
-error_iio_unreg:
-	iio_device_unregister(indio_dev);
+error_remove_callback:
+	sensor_hub_remove_callback(hsdev, hsdev->usage);
 error_remove_trigger:
 	hid_sensor_remove_trigger(indio_dev, &rot_state->common_attributes);
 	return ret;
@@ -364,8 +364,8 @@ static void hid_dev_rot_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct dev_rot_state *rot_state = iio_priv(indio_dev);
 
-	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	iio_device_unregister(indio_dev);
+	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	hid_sensor_remove_trigger(indio_dev, &rot_state->common_attributes);
 }
 

-- 
2.34.1

