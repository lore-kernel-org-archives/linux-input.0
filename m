Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365903932E4
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 11:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780745877; cv=none; b=em1BaciS387I4Eel2AWqgUTHWcLlsWVYh1Kezlal9It9DOT9dHZLOz4c6TyXm2Nw38EW7vzp/PCyna9s7zs8kmFk27mYRvv5xkKblUjdqVPi0M/TnJTb0b7cX1iuxATlq7yEHjO/sePDhBosIAKfYdhjMPNDi4BOeQBDeZeh9cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780745877; c=relaxed/simple;
	bh=IxWtMSSkG0uT8kHr8d5CirqJrItHTinUyyfdBs3LVrs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cxR/lfUN0QFinhP9UnU2DEWjoagW3X+ASMSXVL5Cpz5kToMgo+dbk3rnwBUvuoVYDgywc0ULWZP9LaXxG19p9dhCSybUXLFsmUz40xudr5r+YyFZCdKmwRpwljSXNtSwEsh0iKOEH6R2jRYpclZkCXHpSAmIWcRkRlDd5iLUKEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuVAmD1a; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuVAmD1a"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36d98c9b596so1802158a91.3
        for <linux-input@vger.kernel.org>; Sat, 06 Jun 2026 04:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780745875; x=1781350675; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HXKkPy5oWLhHBJkcovnBZBOpEfG4u+8zoMOu1q8eWRE=;
        b=UuVAmD1aSqxryLdDAb0S6jfoHPekOnDYjRzT3rE1lyXNYcl5J8tGf+JhVnI3P3BYi9
         WhEWUb4vqo1/OyIyWAgBcDggivYdz7XlyqOiXiKEYHxRdnfMjs5b4+oYpG59TNnvz0DF
         6/9QzDmept2mR3czvw6MpyZXU5c407GGQ++jvKtMGXIoX1+PxobQJma++pV3r/8YnHzT
         VBatl0z8gFmck3pfn99DckdkvW4B7PJYF+GgSEz4q892JJZEDNag7OffBUBQENHqTSMg
         yUYrAwDqScvRy+QmWOyGUuwdb3262C1BjX5ZQYmMKT6f/os/Pi2VB8lzQaOxbbDCBUHK
         uWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780745875; x=1781350675;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HXKkPy5oWLhHBJkcovnBZBOpEfG4u+8zoMOu1q8eWRE=;
        b=rAqcZuGajPyOkkTlWzmqhlc2ZrI4KC2FYXxN7kM8M8StQASYFpwhcAK3vYQbCKhUkN
         cEQwHgINy9sVvLn0zYIktqr2mtihKgJE9Z9GS3EsqS/XRuVKvLwnOAjIRKqS1gqpYj5D
         L1Wp4dm0Xl7jOe5dFOR89CKbLPYaheM/agbY1Y7mAb16FSjwJM3afzeFDmgj4QEIxlCb
         16mDgkREy6CrFch+oUrTDq4yy2qL4F8FDNiZ+dIdwTeEBojOsYk4cvGyil65YN1dAdQk
         IyeLHx1BcVCP49nMcmBveSnrBV8CYdpxtVnX3EQt/3CQjBmE+B9H5vchPYvX2ugZwPfZ
         9FYQ==
X-Gm-Message-State: AOJu0YxEKKCNeyivpCNPIXHZHteLu7K/bznj7eQF4XvHsZAqeUVD/XJA
	9Mm1pkwyNTz29fObr9FLChryEsv+xuPVa2TvvVk9wy9fzv+6Ae6p/09p
X-Gm-Gg: Acq92OGN34Sob7gztmO9zi5l6kqdJRpd/l5qST7+UG9XZBu+oS8U356TyX8AzGxycDv
	CpvwuaII9gqnn6Ey36n08RreHYwsqq5rOXzV2JNnb8MRYlz/KyOXPKBHC+nvmQ5jUS9MYyfauA4
	mHV5/h74mR96qL05laa4336nwLVetoFnqUaBIWXWnIpCHIf2Mu9TQZzRX4rgnUWgfdv0BJu/8qC
	nFWJWMBRbebpQ1Wq924nD/JGW5UkZSGWcK6LHIbwLeob7Tsmh5TlGU5TpPKW9YrlgcsduW/Wlvl
	uL50i1uHNVqFwk9surmdQrQq/rts7H+C22QoT4X1zZZj+i9njH0TzGWZXS1bUmstcYMMJMc90dO
	3WJnK4628KZYvHYQwWUbMATlUuCDMzBb4Q8WiLPPXbGKGkcwBhYdfWyHVzCrKmkWc7AgmsytJxX
	XjUNnvXdyiS9RZwW+NgdXdoiNTl/zSZijh+NSMbZTLAFzRFlEvG/GGq7qD0Ms=
X-Received: by 2002:a17:90b:53cf:b0:36d:b818:f848 with SMTP id 98e67ed59e1d1-370ee82fa47mr8855216a91.5.1780745875380;
        Sat, 06 Jun 2026 04:37:55 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-371358615aesm3220830a91.2.2026.06.06.04.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 04:37:54 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Sat, 06 Jun 2026 17:07:13 +0530
Subject: [PATCH 4/9] iio: pressure: hid-sensor-press: Fix race between
 callback registration and device exposure
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-5-june-hid-iio-race-fixes-v1-4-27a848c5758f@gmail.com>
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

Fixes: f64a799b8a49 ("iio: hid-sensors: Added Pressure Sensor driver")
Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/pressure/hid-sensor-press.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index a039b99d9851..09795473948a 100644
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

