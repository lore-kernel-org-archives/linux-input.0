Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AC535A3B8
	for <linux-input@vger.kernel.org>; Mon, 22 Jun 2026 05:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782106245; cv=none; b=KeQSBcCyj5J3iv39fEmQJdiieUTbobUAfDLaZDJwLyPIodIyWaU27REPyaKBdZuvNoIIM09EKycu2jWz48k77bJHVo7C4eR0rRcPLzC3Ou0Ff9YM3KIqxNg+xwclVfYTd4I0JZuJLq01GyC8Lj4zNAlEj0OSHZERbfRTuqI9QLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782106245; c=relaxed/simple;
	bh=NdRzCGsmD2gA9WT/hiU6asZ/sU2daMgn0fUIABhbW/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KJ6/C1WgUcKcyzfaNzNf2jTbVKaFNmzVtbikV9F1tUNORuLaDnRvNA2Zv8B1SSRgRoYKgDYbcci1vwkbS0kWEbhrxiK1fA5jACk8qRujYFLs+EDZ+yHlP3PMN0KinRP4n+w05PPzbGeEe+0JUQ4IG2k0yfJBmmIgN5+jELkNaKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBOWfvEc; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBOWfvEc"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c0b9328c4aso27359785ad.0
        for <linux-input@vger.kernel.org>; Sun, 21 Jun 2026 22:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782106243; x=1782711043; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wXIfNj+td1g2UGFAa2Fx1dBFxQFwQ+k/ADjSsFv/Ulg=;
        b=OBOWfvEcPDcNqDTExmAqqTeJDwySxuspJ1vYgIxwM5WuQncaNIcHMbMtF7EcDlY3F2
         I2O9oguDW5OJBJy6lOH2IHZAP4+Dh1SRcK4l+DJYfQEzZZ+zWc0y7Ocvt841lbGgLJGn
         4VumPTCjSDE/CB16zVlYMauz7m13grT5UXPJshCIDtELikHROnyyhGVBmgal2Nx7iPyI
         6GSIPlC9u7qOK9ogF8f+jDUm8XdpZDStzuzh+R6fXPOOY1hIrT9EnPz/YgcvuMet/9JV
         TL+3NNzwuP9EtbOZMchMQRZTjVkky5UmK42BtKtgptcAhdhnB49R1Ns+mPIEPfgXcP4F
         NisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782106243; x=1782711043;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wXIfNj+td1g2UGFAa2Fx1dBFxQFwQ+k/ADjSsFv/Ulg=;
        b=gi2KLJvpBPH+VcaZc+X2DUb/capWaCSN3yLwYWhmNU7XLrG80d5mPgnsOHWdn1nfPp
         8u7Mib2vr3Fck9FUApZOArXgEzPEWqvNq241BMY8QuG+ao7oJbxpaWVG7aqykcHLHiI8
         tdYQ21d0pM3d6J66/tifSEWLOBIGMRfoAZqEfYam+IAAWmWd4tH7DUonpLHlPWe7flod
         HgERV04EODreUujj5gDdnI/NzAKTaPRQVsOmdE/ifYgpWNCb2JNnfvTcj2PCnZkwzKj0
         XYY9isSuwovbzsZ8Clq4FBZLSru6FN3GalOsGLTNTLFUehY4NE48iP8ohvjB2EorZIpv
         x69g==
X-Gm-Message-State: AOJu0YyZBUeLiDscTHVOv08YbFhRsqvjXljsqDuKxBuRLDIDwYjPJw04
	Xiubi8ouAwBc0h1Jf4mjpC/jJ0pW5H5kA6o+iY3M6kptlAc5CV9a3kbm
X-Gm-Gg: AfdE7clZ5dipVx0WZDCWRmMbzAQ2DpgGT//dCDJLXNwkAfgm3mf3aKn8pdFZE5m0xGI
	sYV5e1TSTmFEdQ7BRb/lMUdvkD3AlQmhRv27LRXY+D31nYh/PnKOoQAzVNEhywZlkitnZJbxXTQ
	P6Txk/8t9awhlYveuBSa3nTwmNxcZd+TSkxtYdmYTFehv5kVr/zkfd1iERzbSoQgBnIsFH+gB6a
	YFp3AUzhmt1iVMEiUns1hJ1C12T+2ycjkrlpcZd5/clOaGsg+CTOjaMDW0Fw1LQkvsp2M2avNW+
	vxLm0JkXoCLNOcJkOJlBSWy+pX7jZJuj4ihiAYKNeDZOz0o3Q++uXU4OdTULjzg4H7UtbCTP8jX
	hiXLQbi5XCOHy6tt05KB+tF+jyutch6dsIwcG6qnNVvdqcDCnZWBjR+00DeZ1QMSyMfjz48GsBH
	9Bt7qOV7DTEuUY8qWKWrgVC1Oa6eUyfiN2yZEB6w==
X-Received: by 2002:a17:903:906:b0:2be:3434:4e28 with SMTP id d9443c01a7336-2c742b1ce87mr85206335ad.19.1782106243367;
        Sun, 21 Jun 2026 22:30:43 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c743fd6420sm63932315ad.70.2026.06.21.22.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 22:30:43 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Mon, 22 Jun 2026 11:00:02 +0530
Subject: [PATCH v2 6/8] iio: light: hid-sensor-als: Avoid race between
 callback setup and device exposure
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-5-june-hid-iio-race-fixes-v2-6-1cfabcd1881e@gmail.com>
References: <20260622-5-june-hid-iio-race-fixes-v2-0-1cfabcd1881e@gmail.com>
In-Reply-To: <20260622-5-june-hid-iio-race-fixes-v2-0-1cfabcd1881e@gmail.com>
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

The driver currently exposes the IIO device to userspace before
completing sensor hub callback registration, and similarly removes
callbacks while the device can still be accessed during teardown.

This creates a timing window where userspace may enable the buffer
before callbacks are available. In such cases:
- samples can be dropped,
- buffered reads may observe stale or no data.

Reorder probe and remove paths to ensure callbacks are active before
device exposure and are removed after device is no longer accessible.

This avoids a race window leading to data loss.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/light/hid-sensor-als.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index ae2fda8dc500..823bb56b9873 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -406,25 +406,25 @@ static int hid_als_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "device register failed\n");
-		goto error_remove_trigger;
-	}
-
 	als_state->callbacks.send_event = als_proc_event;
 	als_state->callbacks.capture_sample = als_capture_sample;
 	als_state->callbacks.pdev = pdev;
 	ret = sensor_hub_register_callback(hsdev, hsdev->usage, &als_state->callbacks);
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
 	hid_sensor_remove_trigger(indio_dev, &als_state->common_attributes);
 	return ret;
@@ -437,8 +437,8 @@ static void hid_als_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct als_state *als_state = iio_priv(indio_dev);
 
-	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	iio_device_unregister(indio_dev);
+	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	hid_sensor_remove_trigger(indio_dev, &als_state->common_attributes);
 }
 

-- 
2.34.1

