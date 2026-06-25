Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FC73E0C46
	for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 12:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389780; cv=none; b=pFMz6iAK7o9mQssQCycdjuRsujOLuB1pGQnQtdsv66S5cmvGOMGC20jEETUxPc8M71On06mWPtBAkdthfntdOTDGC+eZa1d4VWsLq9M+5PanoVb8+IcNH8wJ0I86UFtUy/VEIWpwooKTmUXKAx0RuykGlk8gUtLAqGr7I0d6TQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389780; c=relaxed/simple;
	bh=Q51q3+1nzHcLtThfBK/sUij3M5TX+iKxB/+fLsKtBYA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bkd8IQCjvo8RJD9jX2/YSG7JvxKXpsfXT+pLO/uP53uzrO9M/ttA4g6rKIfSRbuJVqigIpe/YOSm11Yd+5oJgRHtbOrumbqUCBQA0giLKzLes7kS3Z8AczDNjq5JtHnlzsBmA2cFnw8265/MedpDpufwKBWGGHpLorJsX//RN3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ceJ3v2iT; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceJ3v2iT"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-30c23abc62eso2473604eec.1
        for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 05:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782389778; x=1782994578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nNLU1KKI42jsfktVLjE0+EK3UfxEpxYOmYgYAhnpLzg=;
        b=ceJ3v2iTRZWdFXPrB3IZMunwhLsMt1Xw4ptuMyRj0APtBFqrhdZWytTM/aQUqZI5TM
         cTtYGKDLdPDWdJxRtqE4SF25RvYD/rnV9XvCUjHpzlE+wFHem3KdXIBneinSfoaNLfHX
         yYoF2palrwhuz35scnbTJE3bk6GEXTFiOfBtQUmp7IETLyObNI5kiK7UyXAyNzpn5q4y
         +vGG0ssx8G6cUMhBqmtNWnBPhDodezSdly11AKBlTNrurnf+hc9wru61Z0+lT1hJpbq/
         sbtoy5vxpk4p+xMA9mzWf6D6aDNWFYqMosCfwqctRB+0XmjOmASPytU95GyIYX6sxa/O
         HHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782389778; x=1782994578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNLU1KKI42jsfktVLjE0+EK3UfxEpxYOmYgYAhnpLzg=;
        b=c6Gef0q0ylm8TO2uUOAvvTCwdaVZzWqoDzvYLiw3ZmGQ0MWZDtwLR368J+F632PUNo
         f9ScJiTsDMFxOCu9sCSUE/zYYz95CxZJSCQHrdPBQ5HRn1JDhvow0HRBFZiLPdEJDs7X
         5IJvtKNj16kvxtp9/4r8geB2zYiw/y2HMXILsXGgvUaW82eOeGk23exvuBESEd16WZXp
         wDqMw4CKh/OJzDzE8cmE7+LKqimkOH3YAdW93pD2Jp64NGeV/fWiqszdpNSTEvOCfikk
         RrwZmAyWKPd6AfnCnCwGDRlzsji1Uhmd/xFstMu5Czl2lWlHF/vyZS0YOwamN3oz0EHf
         3a8g==
X-Forwarded-Encrypted: i=1; AHgh+RqRMOprwmSsAd4GC24vj2gQqh/kln16rlUx2pDlxbNprlz/oGurpI7mKrb7mQIjZW2X9RzIjNqkwxgA0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYhE0WpUBW8lYvHqmaiqQogFKwd/UDRk/qJ7UppJgiMM0T5lp4
	ZlJK+O48QCwgRnpu+OYoKgpRLC8HJfpuWgTBj6txqmHoA4QWhoK58XVUv62E1g==
X-Gm-Gg: AfdE7ckJyuOKWlF+Vq7Nu36PjeN2iAzPnQ5zjGbPljufqYduNTPvYsRGObR7S4SzMUZ
	z7uXgAXuX5DqR2CA4IvYhe9lVZRBwUkfH3UIRy9/Imch/fldqsX3l/mNlVjpSF4/GS0rYor+iAZ
	UHRdDjGUltIpqmmvVkguTSx4rUUlZIczhqaliRrv/mi9lI5+r2OZhDIdgET5qVrPuoD0OodAdmG
	NQ6zsinZ45A3bwoH0aoZAUV/jMLKCZ8tks9mlnMy6a16iZLF+xPWH1tZndFlm1GB/R0IDeb8h/5
	w++DVp8siGcGkCXHSC0tqGFZWgt6xy13UXGOGL3UQYvvkm8kUHa7CsUiCGHuTnz3R4jKa+nsviB
	uLIndz8dB130Rj0zPxuT9lPcmRRJ0UbacFCRcNeSfbtO8Z1e3qpjYuO3U+HZ79wX274up6VP7cs
	Z7KkPSmk6RQcZADi3CQ5z6MToDtQXQI9JnOEdpNA==
X-Received: by 2002:a05:7301:2a08:b0:307:e4fa:894b with SMTP id 5a478bee46e88-30c84ba3223mr2902960eec.8.1782389778172;
        Thu, 25 Jun 2026 05:16:18 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c8afca8sm7995178eec.17.2026.06.25.05.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 05:16:17 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	hongyan.song@intel.com,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: temperature: hid-sensor-temperature: switch to non-devm iio_device_register()
Date: Thu, 25 Jun 2026 17:46:11 +0530
Message-Id: <20260625121611.2003780-1-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Avoid using devm_iio_device_register(), as this driver requires explicit
error handling and teardown ordering.

With devm_iio_device_register(), IIO device remains registered until the
devres cleanup phase. However, driver's remove() callback removes the
sensor hub callback and trigger support. This can create a race window
where IIO device is still visible and read_raw() requests are issued.
These requests might call sensor_hub_input_attr_get_raw_value(), which
waits up to 5 seconds for a response from the sensor hub callback that
has already been removed.

Add an explicit iio_device_unregister() call in the teardown path to
ensure deterministic cleanup, so that userspace can no longer access the
device once backend resources begin to be dismantled.

Fixes: 59d0f2da3569 ("iio: hid: Add temperature sensor support")
Cc: stable@vger.kernel.org
Reviewed-by: Maxwell Doose <m32285159@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>

---
Changes in v2:
- Added review tags of Maxwell and Andy along with stable Cc
- Based on input from Srinivas and investigation use-after-free
  explanation was not sufficiently justified so updated the commit
  message with appropriate information and kept Fixes tag
- Link to v1: https://lore.kernel.org/all/20260622052135.1804135-1-sanjayembedded@gmail.com
---
 drivers/iio/temperature/hid-sensor-temperature.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
index a8d3a15f9c53..ab6ec8f659b8 100644
--- a/drivers/iio/temperature/hid-sensor-temperature.c
+++ b/drivers/iio/temperature/hid-sensor-temperature.c
@@ -244,7 +244,7 @@ static int hid_temperature_probe(struct platform_device *pdev)
 	if (ret)
 		goto error_remove_trigger;
 
-	ret = devm_iio_device_register(indio_dev->dev.parent, indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_remove_callback;
 
@@ -264,6 +264,7 @@ static void hid_temperature_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct temperature_state *temp_st = iio_priv(indio_dev);
 
+	iio_device_unregister(indio_dev);
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_TEMPERATURE);
 	hid_sensor_remove_trigger(indio_dev, &temp_st->common_attributes);
 }
-- 
--

