Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163A376025
	for <linux-input@vger.kernel.org>; Mon, 22 Jun 2026 05:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782106236; cv=none; b=WMWytt28YE6F3owmGiCuLt3KqTqQ/mSJs3uJwQaq7REEQwk659c7V6bzC6HO3cXDlif+jLybi7Io0AgCxnfnzyFSfjXmysxRR8fwZE2eR+h6i6P23E3SiWFjcIfEWlsqzcIthVgc9/+PKvGEfVtIyuqggzlnGJ/7ernnE6GXFgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782106236; c=relaxed/simple;
	bh=KPGsAc0xHkCSffaHYbNkB0P2MrqYG3ZskIcF9usyp04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=okCggFDJcW8TNOyQ61LBQaQrgsJheAr1Ej5+KdBqzJiFgBk71DBeDpVhv255rUp/iId2p7yVvnxFj1Ql/Y9vAbK1hHWmqcrU3zfkwATBWMzpBNAQpVbpUdSlXgf9KKpK4TbXDW5MPOnSa1SyYugtx7iTMuRalIeCClEa/OhfNow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGqkFYBy; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGqkFYBy"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c6b67d5fa1so28339865ad.2
        for <linux-input@vger.kernel.org>; Sun, 21 Jun 2026 22:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782106234; x=1782711034; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w2/mdmwgKQOPCBV5u2PomuE4r/P33TYPyI5ZUv87qNA=;
        b=VGqkFYByRbwOQtwccIaG/GHtHCxLXtDkS6PimPRZZcPokOZGM4+xr6RZJR91t+T2rb
         CyoiO08se2YAjM5AH6y89nR3YEANAJYUJER1Gbd1O3SKH4z3e/fSKN7fR9Haz4nlR4XO
         S5zxiHbXdATVdY6ZJloowDOt3oiwGS3FynYqFyiYoqoArYJkwpdWKwrBDbyo6+zv7yxz
         IMDMxK3AmNnEI1H1F8KELUZImj1Vr2lbQWjFIAjFtXh5V/9heRb0sdaOrL6HasMcpXjG
         K/wyYH7RrVzdjXygN3Vl1DYmx1lIVGGXcz3dmfRwE3btStsYgsIG3A3UXjmfCBCzRgWH
         Cn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782106234; x=1782711034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w2/mdmwgKQOPCBV5u2PomuE4r/P33TYPyI5ZUv87qNA=;
        b=revFtxq4SR7cvvaoOZJT7p5EfTmdEmL7T3GOaZxG+IwFlkBrvw4CaM1jXTpTCmj+m0
         9ob/eKmlzIgfKoXVwmVZTz7mANzTJndHzhHUb4GDqC+ybwAsmm0CgT6wwcIgVKDZRRP2
         ZqcNbp66cc6euN9IRSCrLS7gXK3L6+Eltdcj4voabJOmcmzUlMFsnvy1fOEXUeMvDQ4u
         1TNLIYhudqo7pWJVdySTzcSg2HRD9e1T9aLyrlzDTNwQhilDvuNgM7vkks3f1nyjOcdO
         WnbFytw7tcjIdoZ5gNXzICvVR+mtaP2a1qDbNX21rQcE/lFDbTKKeonCk8Oma1JVwGng
         Ivaw==
X-Gm-Message-State: AOJu0YxlWR36ueB6TRWN1LMkpL4c5pKiXO6XtUKX+vc0D3PA5Xwtq79u
	XS9YNesNxvlM/iBc2G4Vsfbl80WoUGgxLG5M5xV536mJA+Qghn8Lc6l0
X-Gm-Gg: AfdE7cmxSKsSYj7VBkqJ+Zx51he1yMkQoNl/+X2jTkStdqIHG8IHMVsMYwNk3gl4WwY
	MnHjY+vdDeqUeVqQPhkxFinnPWDkmqZDumf+xwp3S+hONkPw7217IEt+VW+5jJVbYO4pJFtRFXC
	OxH9I69XH/J6jUSKgMjf+LOD5WzL1UU0Q/YKe7txC/NLCxiZjFcjtVax5hlk03tXOZY5KYmrO5x
	6fsb0g5G26Qcn9O4swptqEbxJwytoXen7wMlQczttKQDWdK+trRxeFGPfaVGIqn7NaqkjQXCnEG
	4JX2w/zt4x+J/G63Wx3+YWjF3CFmu9KKAj3pWwFz2Ip4KdXnwbvqIrIH9JzqTa0RoJT+0M9T+zb
	+0QrnJe/m7asIZ7mV4Ybgo6VfpeOwSmrt4mw+BH2pgV6i9XE/tbYGujryRFmcCEUR7njctPHccA
	L6OS5kxWtIKO9f9wioXII1gNrg26gtxn24VzxPQQ==
X-Received: by 2002:a17:903:3b8e:b0:2c0:ca99:3d73 with SMTP id d9443c01a7336-2c725a659edmr127848605ad.8.1782106234304;
        Sun, 21 Jun 2026 22:30:34 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c743fd6420sm63932315ad.70.2026.06.21.22.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 22:30:34 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Mon, 22 Jun 2026 11:00:00 +0530
Subject: [PATCH v2 4/8] iio: pressure: hid-sensor-press: Avoid race between
 callback setup and device exposure
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-5-june-hid-iio-race-fixes-v2-4-1cfabcd1881e@gmail.com>
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
 drivers/iio/pressure/hid-sensor-press.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index 3e47a10d72a8..8f81a6d65b9f 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -291,12 +291,6 @@ static int hid_press_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "device register failed\n");
-		goto error_remove_trigger;
-	}
-
 	press_state->callbacks.send_event = press_proc_event;
 	press_state->callbacks.capture_sample = press_capture_sample;
 	press_state->callbacks.pdev = pdev;
@@ -304,13 +298,19 @@ static int hid_press_probe(struct platform_device *pdev)
 					&press_state->callbacks);
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
+	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_PRESSURE);
 error_remove_trigger:
 	hid_sensor_remove_trigger(indio_dev, &press_state->common_attributes);
 	return ret;
@@ -323,8 +323,8 @@ static void hid_press_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct press_state *press_state = iio_priv(indio_dev);
 
-	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_PRESSURE);
 	iio_device_unregister(indio_dev);
+	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_PRESSURE);
 	hid_sensor_remove_trigger(indio_dev, &press_state->common_attributes);
 }
 

-- 
2.34.1

