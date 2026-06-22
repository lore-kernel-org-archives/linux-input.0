Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D77358D27
	for <linux-input@vger.kernel.org>; Mon, 22 Jun 2026 05:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782106231; cv=none; b=dslrlzNQVFImGeUziJWbI0GsGlhcIrj21vrRzsnAbjAIr7Bl0PXH0sLVttblhzLAXDX8Zx34bhg7TnNZhyV1ikp5KKxVbombV9nWcS3GpfoSDVFWaI99j7r9Y5BJpBSD8NjHTOjRePa5A27V5Iaqy78zDSLRUZRHiBp9G9dInS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782106231; c=relaxed/simple;
	bh=JmpLcUM7rN8qpNo8lTJixN9/D4VROhI12lz3miK6OZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OeD1WcxthS8YttkDdpBcS1t67Re/ka1m2LTx5axyRZxGOXCM+3YMEM8z53T9xib3CtvEKIN8QyLYn3WupFkw92GcHBnNkfu01Gecfwulk6QndF20Ei9MTt5GyiOEpAcgD7DsK4hHXwi4PoTo9spOmk5CzslYqENll/9yHsI8i+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=peEzpAGE; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="peEzpAGE"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c77d52bec4so4156545ad.1
        for <linux-input@vger.kernel.org>; Sun, 21 Jun 2026 22:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782106230; x=1782711030; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HYMrgv51BdhDLdV57PsKXM3IiQDcJ+i0zl5aaagJ+Tw=;
        b=peEzpAGEmacPvswuU90/F23XWqQsmnnO9GJhFsIrqiJHXJQWs+wtJpef5ZcxEr9MAz
         CmNZsR/BwDU76hAUl1nUmUZJKvR9qsKs2CtcQgM9h/hTGBqGl2nSD7er753FBRLQrawJ
         tFOPc4PaxgCuz2YEGUUvGbmUGLY6qM83dcB84e5r/8f7lWyC0PQXUmDFBLt73HZcoJv8
         8Nc46msAG9GdNdRXoQV3a3x8M+EBIcxIAAIFGVfuCe3M9TPyENSUPIvjjP+v390wSpig
         0VkGuwSHZI/mXvUAAx65mHYK/L3/EPelzlYRvlpJP2JBtl9ya4DRU1s7jLaoh+6n3GtV
         +esg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782106230; x=1782711030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HYMrgv51BdhDLdV57PsKXM3IiQDcJ+i0zl5aaagJ+Tw=;
        b=GDKu6Gl9ij1sHSj7AJIWLtTr2IKZT9re5hYBbGQ6FOiFU6CxVg8b7Awxa/m9VtCRIL
         PeVZq34x8dGDe1e8adx1GCBVv7HkX54yzU3KGKcZNLuMXlq/LvveVEPSuyiRK5nZ2EL6
         /UCVvo5XT79n3F89a6Zo3kqWv57Z2THQwrj1Ypr2d07BXDNPhp53KR3AZ6FrLCYYgOf/
         N8PWT4/5qLY7B1NNdhcHAUjV9FGpmhSdgWO+ULTpXrZkLwEO3G48bDQE3s1UZ1t3nrog
         eKsDFjnq6MlrQOkr4+Z+D/1kpXk7p4GpkDDZu32vAUsrHOq0lAs7V7GyXHSjy4IUED8B
         KrlQ==
X-Gm-Message-State: AOJu0Ywsp5BZul1CenLFAMUoK+AtYgGFZ+tXBS10o0HZz2TVvHHnUJam
	9rG/9IKGnUadOKR70ZSCjeP70QolbEJmd679brV3RAIF8lANg1/zjVEX
X-Gm-Gg: AfdE7cmoT4jR1wJxPiPw3/PFopXyvKlH+Kn3YKzPMC+DT57JlpBHr3gT3s7VNvrAGV/
	WXjImJC2JWXM0xo1jHmH0I6IlU6eYg8+Am06tJX2M31OAyjoENs3kly5RjukLf+mqBMKqY8AoP2
	C6AO4s6tH8LZPh9wfqvB9oDvcYvK4DDmfJ880UwXCFBkvNfspGVW5S84f2/lP5yhcEBpzXggOEo
	igA3JgkyZLYnJnlgXeztS6VrAH3KtjBHK+gSR2UcrvVN2pjKpykbT2kXCcDhM6Ggn/Y6f0Mr5Qa
	IGk1tkt4DzWyKRG/sBe5A6g1+NKQTM4rIjpL8eak1O+5ZrpRZLfhnMOiSa7DahSyrngH/UysL3R
	p6RYFGCFOMDTW0UzduD+dQwZJvwKMdF0r8DkSJycDuO5sA9PPE2tk2yavR25v7Q09TXR+zUf9wk
	kBnmCLIJ30OVlvnPri01exCEyimuf6L7Ruf0MzQA==
X-Received: by 2002:a17:902:f689:b0:2ba:6601:8e3d with SMTP id d9443c01a7336-2c71952b30fmr110405925ad.9.1782106229696;
        Sun, 21 Jun 2026 22:30:29 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c743fd6420sm63932315ad.70.2026.06.21.22.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 22:30:29 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Mon, 22 Jun 2026 10:59:59 +0530
Subject: [PATCH v2 3/8] iio: gyro: hid-sensor-gyro-3d: Avoid race between
 callback setup and device exposure
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-5-june-hid-iio-race-fixes-v2-3-1cfabcd1881e@gmail.com>
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
 drivers/iio/gyro/hid-sensor-gyro-3d.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index bbca2111e79b..c8130b488f10 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -324,12 +324,6 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "device register failed\n");
-		goto error_remove_trigger;
-	}
-
 	gyro_state->callbacks.send_event = gyro_3d_proc_event;
 	gyro_state->callbacks.capture_sample = gyro_3d_capture_sample;
 	gyro_state->callbacks.pdev = pdev;
@@ -337,13 +331,19 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 					&gyro_state->callbacks);
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
+	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);
 error_remove_trigger:
 	hid_sensor_remove_trigger(indio_dev, &gyro_state->common_attributes);
 	return ret;
@@ -356,8 +356,8 @@ static void hid_gyro_3d_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct gyro_3d_state *gyro_state = iio_priv(indio_dev);
 
-	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);
 	iio_device_unregister(indio_dev);
+	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);
 	hid_sensor_remove_trigger(indio_dev, &gyro_state->common_attributes);
 }
 

-- 
2.34.1

