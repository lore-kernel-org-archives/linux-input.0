Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0942391E5F
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 11:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780745900; cv=none; b=G+t7cTYTDdCbbk3kvxTf0qwx2dLGooBITVnKZHOc0LLwoodPHgUq9AchOZcwHJROVpeBPI2mzdWazGWS/rjxzf+fdqDyiNZ0YfJKKJWH4Uzp59Bqbc0FHiieo/Vawqq3qsuY494Rb3CIVydSKVmEA2mUPclJ9a2rZv+TIjtADIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780745900; c=relaxed/simple;
	bh=tdQv9XeP1nHQ7Q2g9P5Io42IT+SkPtnTaQNAZxqkqp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PchH6FT1NgiaQElquj3RP3iI+L0Bex7Sn6D6ek1pyG58Arcr+3XsqvGQ7y+kFjYoLQysP31BKcNqil3voo1MrCK+FEov7Jyfh3te+y7q+1wdnAYqwzci1dtsbrwNk+A9prO8ejvjWOc01FDwoV4lCkv5rmJ9lllE2oPHdDYeFEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMxaeRZ0; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMxaeRZ0"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36c68964315so1425354a91.2
        for <linux-input@vger.kernel.org>; Sat, 06 Jun 2026 04:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780745899; x=1781350699; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MEHHw98dpwCFQIjo5hdkWP0eBsP9ued+vfNrFXHgBKU=;
        b=TMxaeRZ0DMS4YisfkNrsfTLIDVgAwkGVQmyEuRNJd8W1jtkIkk5nWBcBeW+uznD1rV
         iqtLWqSqFdQFtVZ0TFil10ZaVbj9EUy6C5PmEA1sfS2EQMX4HR7WGPzRpfjNJZlgHUsq
         +n0aFGjwvmXw8Hk2gwGk2R4pfn6qv4Bks83bQWALY7o6OsKbKF/PibxkkBa4nrisLY5G
         reHgsCGOl1q8Mi7AFfUXPVQU+x4pknv259g/8MayFVc62X4z9EYRL/8iTma26gfLrRFn
         4RZBoLaXq/JSS4pr7ySpKzOBzIfBy+ZIweX/tduIF5TayjGozn6frGG74/XinJGZWCoH
         /beg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780745899; x=1781350699;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MEHHw98dpwCFQIjo5hdkWP0eBsP9ued+vfNrFXHgBKU=;
        b=Nz8UOUjQtnUrl4LNrwqV744vueR/cLoXtPXSdfYTZT9b10qhZSH7ewQKJYRkVy8XNP
         LpSZqG6DZS1NLHA85G3vz2uX1DWyy+qtMvzROkjuqBOeIwc54HLJp/PBezLj+z6rp95m
         SEgJpg3Ac3XhODiou322mFf6usLc9/jUSUvL79IbIUqxKU7eCFjix0q1xtADJ+JNVlgy
         jmhh99pri+dmYvKC1IXSrPU1M6pNenKQwAv5eT3F4QHoCo3ChW0Q1uP5x3jY3R6k+agF
         8dZ44GMOWlgKKN0zrKPmOF8AJ1HIRkbmERhKmK3qMPnv2p9aYnl8XO3qq4nPq8du5lHH
         nlIQ==
X-Gm-Message-State: AOJu0Yz6SoCLR8zN1ojs3DUhdU3/L/NxUSWmO4pCZRtidOSmTuIKExWO
	S4S/JPjTrVf0wDFj+AKvqphZkQPZr1FlRmjGrTjufZtV3vdY1eMyacaR
X-Gm-Gg: Acq92OFGpqeQFiwNtpCXwdzNKfCwIXMlr7LLP/EDQK5iY7KjPI/EW/DKeVZ5KiywB2T
	M4fNS9xfmjiDCWhzNnPh+GqODIPZ1PM7Rc5kR1qfgEqaB9HRreuAhdKoMsPhzJxpvI16A0mtusG
	YUJDZpHd2lX+IwaI/qtiFFwnOk4MYW6XWa0RIT9cZdt2Fa22bnfIQRnuJJdSJimO5D67/T1ZAOQ
	W1wDlLfIs+P6dglHOjXLlSFQVzcFsuEZcD6wb73D1Bu3qtY/yF9SpUHAWaEJnxN9zt+qh58uPF6
	KFXmrz0ARmFZ738MrCYvPi1Kjo54+K2gCDbLX9xScw24x6V4UN4H/JKFrYAekR0z8NrrB886JPP
	h7cZKBpO1+rgzhsNRbeVFQ0rxwpjSYwyEcoJFM4yp04TMnJlUmKKoQRpBx80S+KHF0bBlCssgsY
	aY2UFOqhS5uRCmM2Cyeu80G/aK9ujDeprujTc1FVIOXTG7N2cHo1fSIJdOSwc=
X-Received: by 2002:a17:90b:1fc3:b0:36a:fcf5:64d2 with SMTP id 98e67ed59e1d1-370f0b554b4mr9229712a91.16.1780745899160;
        Sat, 06 Jun 2026 04:38:19 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-371358615aesm3220830a91.2.2026.06.06.04.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 04:38:18 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Sat, 06 Jun 2026 17:07:18 +0530
Subject: [PATCH 9/9] iio: accel: hid-sensor-accel-3d: Fix race between
 callback registration and device exposure
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-5-june-hid-iio-race-fixes-v1-9-27a848c5758f@gmail.com>
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

Fixes: 45fe6f7d002c ("iio: hid-sensors: Added accelerometer 3D")
Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/accel/hid-sensor-accel-3d.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 2bf05ab5235e..c000e001c001 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -386,12 +386,6 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "device register failed\n");
-		goto error_remove_trigger;
-	}
-
 	accel_state->callbacks.send_event = accel_3d_proc_event;
 	accel_state->callbacks.capture_sample = accel_3d_capture_sample;
 	accel_state->callbacks.pdev = pdev;
@@ -399,13 +393,19 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 					&accel_state->callbacks);
 	if (ret < 0) {
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
 
 	return ret;
 
-error_iio_unreg:
-	iio_device_unregister(indio_dev);
+error_remove_callback:
+	sensor_hub_remove_callback(hsdev, hsdev->usage);
 error_remove_trigger:
 	hid_sensor_remove_trigger(indio_dev, &accel_state->common_attributes);
 	return ret;
@@ -418,8 +418,8 @@ static void hid_accel_3d_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct accel_3d_state *accel_state = iio_priv(indio_dev);
 
-	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	iio_device_unregister(indio_dev);
+	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	hid_sensor_remove_trigger(indio_dev, &accel_state->common_attributes);
 }
 

-- 
2.34.1

