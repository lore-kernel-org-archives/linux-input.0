Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505A2233956
	for <linux-input@vger.kernel.org>; Mon, 22 Jun 2026 05:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782106255; cv=none; b=UjuFhE/vki/ONSOJhVvDGyddR43AWLUI8/7eIDt41pvfCQtJJERPRLPFaw23vfRoglDU3Ag3cOmkOnxuW/HYaRHh8CoK3edzHnDJsdOzhLlErdfcnMj41imihjTkab5hPvSGs3HpuM2HQ5jPQZZJXdBvHjSrVORQpNpmLj+QqFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782106255; c=relaxed/simple;
	bh=VFGoiXGki0bhoIsViuQH4DkrJinlVWY3FP89NJlAakg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oLkoMlp/v66w2PmLa+60LNTMUJXBr2bdgv4Nt70Yy5TTlubfeD89IMJ0LqhqD/MQeDISwmH0jM3K6BVgy73gCUE1NVZzExPozIVZuUx3BdMeXPsvyFccR7I8XqjSkQu33fTcdd0ahbbfPsfg32rj1EsX4Kj7KyOC9IyhuMZlKYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiMQFWn8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiMQFWn8"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2bf2247e38eso45796705ad.3
        for <linux-input@vger.kernel.org>; Sun, 21 Jun 2026 22:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782106252; x=1782711052; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3tVcLshRPaZRd65d/wCo/MveF/lKliRRr0tnZ1bcPS8=;
        b=UiMQFWn8QDWvt8EE+kE+ZMqvQSsVQBqiktFm3YoTdQgrFzyufU/T0qItVgbTKIYAp2
         noKifoi4XnCMUGjfii8sF20OVQr2HpmaYN6BV27I8Hp3dKm4P4+rYEXwyHe1f6uqGk4A
         XwwS9qUEW1AjNqaubr+FNq0R/ko8pGodrk53GZ/QIqF+3aqjjIVwmFtzRU2MIfof1Aep
         oT0oYaHI1/B+E2QXzetpH68MyMEJwlE+4lgZQlrFcn72EcqyuwudFTpjq99t0ipJDaHF
         jy5Dyf7sLc/PUdN3L6H1FfFvXpGE9UsXno99UxzjRUoe/BO590UwQk1xjVHTfpQtTxfk
         WEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782106252; x=1782711052;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3tVcLshRPaZRd65d/wCo/MveF/lKliRRr0tnZ1bcPS8=;
        b=DlMeZHsCaSa7p1DFplpQB0Tdw2NGPYtFWil1AW6Fj0ZbE2JOfCo6/DnfN70DIXr/+O
         LMJPKqh92fBh5StE1Ah+TkCvhqCVn6heAtemqrXzZXR3PFkUCbSwmG887JvlwZjwTEe2
         dL0ZJ0X275YjiAyuS/oTZsEdP8ReyZIEiSfzn1hJSMTBfXuLCoxhpyAMe4jTycl2AyS0
         Uu9KJLi6o84aUeU5mvqgHco+oVgc6n/1UVgoyW+y2WZCUr3fu9snrXeXrTawu8hj7nRi
         d0Knewrq8YWT5mSchfnjqPCKU4xOyYNAwXSeEOmTYxBLASWQ1+sTPBWe81zmLaB5Zenh
         Fj9A==
X-Gm-Message-State: AOJu0YxuRMs155IekBfJtv5xE/NKcIKiuF/FvnmfAwFn1zMwJ3rJU2PV
	1HdwbqGQLudPYez0I2HqlLV3zIfa9N3pjI22HDvrF12KC/Tm1OTQX0Fc
X-Gm-Gg: AfdE7cmM8Tc3AcZIMx7Ypj4e364bOcRpygas07tAjjpB7MMdtrLDq+yT5eiZUoXHZH0
	7z3Mrq+mAZBJMvrUg4LaDHx43lfYMQOPWlM9sP/rGuP7otgtIT+DxdiPiv9LVsG31BhjgHofqt0
	QtTYgs58WKH1w/ENt/CIZn5009Zg4PJvt6WlfReBy14Kl8FUtdbnjz2ksEhqltFf0/7d4tqXqFh
	aFfYWXxvWJmsrn+AfZmwLFsizUl867MGL+d8XbLMAnTbBnkwd7gzd2qKvp7MX2LlbrLvwYU9Px/
	CJ2moE/wvxnOjgYNfvWk5gS++IaRCRfNrnc6EbDmyTx0ytCbAT719RhmraNfm7ULuL/xK1n3Pen
	Y/rt0knbvT7m1nrzw0ihl2rTbkb3liqr5rSacCM3aaeKRQLx1Jcta9MHv9G/XYJmZOBROs0NjTk
	iaEY+1yJlDpHRnSlrBrJKNYXoX905i2w7ezpAMPA==
X-Received: by 2002:a17:903:3c4e:b0:2c0:af09:f3c7 with SMTP id d9443c01a7336-2c718f95888mr131872655ad.30.1782106252614;
        Sun, 21 Jun 2026 22:30:52 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c743fd6420sm63932315ad.70.2026.06.21.22.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 22:30:52 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Mon, 22 Jun 2026 11:00:04 +0530
Subject: [PATCH v2 8/8] iio: accel: hid-sensor-accel-3d: Avoid race between
 callback setup and device exposure
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-5-june-hid-iio-race-fixes-v2-8-1cfabcd1881e@gmail.com>
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
 drivers/iio/accel/hid-sensor-accel-3d.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 42c4259bf209..12481cfe9800 100644
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

