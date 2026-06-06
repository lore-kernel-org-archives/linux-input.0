Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3646E317163
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 11:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780745891; cv=none; b=Anr6tCWwiGQ17juaq/KitWIKBaqpWWabeSNsYQWNsVWg3bZe8iDpdz/hM01sxGjR4dqcRb47fCxkqXlE37d8n7DkWragL/rD1SYvr4Du4dcqmmZiz48qgVFqEqo8T4OOmiuVQD6Q1hzJSk4Q0yBMJjsMZE+ZbB3W/gPfkJE9GE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780745891; c=relaxed/simple;
	bh=YdwH8OoKSk44T5rJd3P/7+DNbTCSOxu8TkOwBfLzI0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qz1pZmGTz7Ixv22GHSwVaMQMV6ZIFA68O5V2SBYzZ8nt7/wsVlaWi6QhrdKw5GwHIIjp7gtxmYl8S/5r8KATaI0DJQdo5xV/mgAS/UqaoZkVgDHaTwBP3Z/GuO/Oic6Ui9oXhKAV25iMXu7tIGLlEis9K+xVpx5pxnxv6ECnrB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7X+Edf0; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7X+Edf0"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36dac5d5d05so1455304a91.2
        for <linux-input@vger.kernel.org>; Sat, 06 Jun 2026 04:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780745890; x=1781350690; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fhNwJ+gs7E9ihqXUs2Y3jA0VKn3cDSzTwU3DSDgrU6I=;
        b=L7X+Edf0/zRCy97vV0EugYAZ4OpNAiLT4DoiVjahD8nmovrJ4vcKS9hcylzvotH/7q
         JCW2QCOvpyLahW76tajZaVYpKlZEppv9PlrIYGudPiHcrdX/ONA43xw76AW7dPzmfCby
         kvsRjYa384eAX6oHp2qfkud6VieVH35bL25Szu3njG/0KPeSaGP+cXDOOkRmv+eU7gxV
         tvF5oduZ7XAcTr9NdZFROXF1lNz0k79uCH4nOFGc4QGlXrQh0Sx6Aojxac8SrjTY+5EC
         8vNFNpJtXJB6Du+Yv5vlOV2qTWeUkmBLnLg+oxgvU9z93SfxvSXinVaUPHX6XpNpXas3
         +8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780745890; x=1781350690;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fhNwJ+gs7E9ihqXUs2Y3jA0VKn3cDSzTwU3DSDgrU6I=;
        b=Q8qTtmQfhSVxAo2e2t6ZJsORmDFp75Z8sqhUMcBIb7VxyuSO6JZ0QJ99ZpC1mGVf5U
         JkbZVvkMIY4ei/4qptrKIkvwwEr9K4lXLNhOzEyLID3G+ggkBLko0xfo6wNxiaoq74Zg
         JpIzqMbi1Cr/jZx0eTgrQC9qCVbNF+twRs+z+Gq0kyh7r4KHcUa7k6qSGN/RRbcNvikS
         53+M1MnoQcFfKgUUCZbaIpa/WmvidBhp1XBRNMOagijIb9gSUkfOIrXGsEVB0iUJFPWt
         cfwLX3ETDZyQMs7wuB6J5UgEJ7eCLfXKtZs92/lsKwpj4AnGKE7s+hy1vJW0jnXCEt0u
         dArw==
X-Gm-Message-State: AOJu0Yw5VmZ7Ngfe5INIrCvF3/TXjmVRy4eSuUykaD4qBAoOm19B1/Oy
	fxVBzFqL+5C9NeuLwKnnAoOdFxJm3Mn3P3OK9E8TsP3mQpoP8GctXOJRdFtQlw==
X-Gm-Gg: Acq92OEiy/UP7Y/VxfRMV+SqXXwRyCpW0MFWSMwdHes7W/BhHzkSjZ13JC1+TMhkUB6
	p8BaZc35uudjR/bpUkkivKn2A5brdHNlOXMQzPFDOqUAFJuTGUaPVRZCty8wuRor7OTIynIQtYF
	QsqM5tL+c/hjh/xTQioxZ/Ppgu/H6qYb/yrC2DDKKWG02JmmQmxl/up15xYqy5i3oPcVCZoF58P
	lWewtcgcVgP4WBJNb84g4+q18WuIkBwRkJLEutD0yfmxJruIDqZDpqpEptXAWDrUcDh4AyJq0/h
	gABQpo621EeMHMXE61eGTBhWEP0kyH1KgtZH+30VY1GSlOrqNP6TyOcXP/mGHnZfP1v/lhq+ncF
	BIvyKuxjBGmQG8Xv7ZeDGvHoSpBMZ33Yxau6pQuDtvAjUzO04Nf69jX5SdpvHWM9Kca55K5epMD
	4SPlBcVg26OvtMrkw8fRHVuhTsos344OGYLFz22gb9II6xc9AHN4g9Lf+/G90=
X-Received: by 2002:a17:90b:350e:b0:36d:79c6:1562 with SMTP id 98e67ed59e1d1-370f14305fcmr9575910a91.25.1780745889652;
        Sat, 06 Jun 2026 04:38:09 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-371358615aesm3220830a91.2.2026.06.06.04.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 04:38:09 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Sat, 06 Jun 2026 17:07:16 +0530
Subject: [PATCH 7/9] iio: light: hid-sensor-als: Fix race between callback
 registration and device exposure
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-5-june-hid-iio-race-fixes-v1-7-27a848c5758f@gmail.com>
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

Fixes: ed5514c925a0 ("iio: hid-sensors: Added ALS")
Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/light/hid-sensor-als.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index d72e260b8266..93d603848690 100644
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

