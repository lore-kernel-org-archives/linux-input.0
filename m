Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778D23A1688
	for <linux-input@vger.kernel.org>; Sat,  9 May 2026 10:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778321481; cv=none; b=WGwFZLlz9fdUqbndWpzxOfOvi8RFLLK3TN/MmxH7QBrFVwiR+X5GOXLGK6OkAFtkVsfrcleWNUS02U18iodj/lXNw9CkG7Re8Xv5xOwxMReF0bb4a3Yog0+oQw4RSjoHIjxBiAyEC4Xx+mhiZ+NoOZ2oH+7S9szMS1t6pYvntas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778321481; c=relaxed/simple;
	bh=VVbBRaPqNz0NXDuh6RaAIZv6l4EoKGyZf9pCIvkbudw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WaL3NsSX+oMMS5+OdlZl+xTElHlzjvJEgcQG/mZT/ibmLLlre4KcAKdfZeVItRL5+GzSrl3AkHx4hB5FYXidsyUP04gn2nfxxUZbhnq/aFlT/QtZEhDa0RgpvJW+wEFPWtLFcnMha5qgvsX+rYzFkJoy2DBoGnm2XMgFet1w1Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZapTjrsD; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZapTjrsD"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2baca4df358so16854185ad.2
        for <linux-input@vger.kernel.org>; Sat, 09 May 2026 03:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778321480; x=1778926280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOWOLL+hb+19Lzkxv0p25XQnGbbiGbdMhzO7Q7xEcw8=;
        b=ZapTjrsDMGpXsHK31XNdtv5alGguGU5KzHo7JS/hwrG251F4O1ZjZooTfFDUAy4ZDq
         lLDnD/cshUVa5IO3o17lmwnwbl1A1tu/QxrCcSeFXt8oLLVEEoLNhvjBZ0uvDnHN4BXo
         dlTv+i26Y3EUfn7RM5tFc+5GySQ/kW+/qMUiXJiOFOwqXGXPnljeGLjtHC1QK4cSDNs4
         MZLe0JEUznHzBtY3A50cHT4JyneD/S9+vo6D4MA0KZorumyi5qLV2/GW9DIwD24QZGyL
         JCYBraubpxjE68hxjg7araxEtI9lDq21gQ8EniUOvPsIaWPA6KX3fn5Y1aKgg1DTkO88
         AwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778321480; x=1778926280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gOWOLL+hb+19Lzkxv0p25XQnGbbiGbdMhzO7Q7xEcw8=;
        b=c5XqQmXATk0Jja6ZuUPGItu7ggGgqVaHVP5s20HnjDZIN7m6+4d9jyxkCQIWl9Ni4V
         ytzsILib2bWS/XzDKK4ISp0zZh5WJgk7tCKR6HCw07NMT2gESFRFJ/6EfATnk3LXT1mN
         je7n80vRoVjwtP8D10XZHHOASJu4b8l9rkj8ejqtqyiFZ5DokrcuCUvjKIhKjZtV5Ifb
         JtrmDO6BwEudNoSefkuCVM9RQi9B1yyYaOi6jrVASqs9E5DWHqQcXnWzeHRltgZGAEQU
         BuYlHkFvdzcDlXHzVaAfL9Im3NNJvySuFDxcd4PLrOPDMzWFlBAznbOv2qFXrVnbLYMX
         Jz7g==
X-Forwarded-Encrypted: i=1; AFNElJ94ioky/r6DZ5ndd93EvSZKlfPo1KVSV3vWInh3VvFAOJqHLLBjIZ1g5BYg5/n35odyDbbesY3n5peGlg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNWs8ykce6Q8/9N2ROqrEHcwzxN7WUUZKP9ggpU7u1pWzxbGax
	ZtWEGZ7sishoFv+WMynNiYuiheAJRBbJI4d7RLkrWfSSS4NOZ1lHRDvF
X-Gm-Gg: Acq92OGpWZl7dzPj2sFj6+IZaCyZrTktIj5do8ypSPsg1qQbHIM7r1LpO12d+UhW5HZ
	uXLJiDB0DPx1MBSZ8jgYmccECoYepgjM22oHKNXeQtTNzuOFl33apcA+8h6An99qdhEF1I73Nua
	bGVjghDAtQaWdsF7WAEqxIOZKv0r5PWnZ4loH0ZVITsny30kYXWd20h+dYtshK/x7DlEiOHWnxO
	WSRbk46eAHqQby406VLTKz50YlqtmN4AeT3H6wMTnfJhTNVU0b5FeJYMl3nqMYxPKi3VlKe3TvJ
	/SruNmSuO1rhJh5MM7fTcS4kGZlvG5EWogNUiFuL5KOxRHzlHceYdCS4FcF1Y/LCasDvEFKJx4V
	8AGIh1dDgehQVRohn0+HJMv7MtvZ7sdP4/9EECd2CGfIBk5UktgLdbW77blfv8DdoBDlnKk69RO
	Vilmqcf0MCESS4Le2u5t4TEvLAhzQsLewqUkOUal9jFQxMxYJM
X-Received: by 2002:a17:902:d2c7:b0:2ba:99a2:c44e with SMTP id d9443c01a7336-2ba99a2dcb2mr148253195ad.21.1778321479939;
        Sat, 09 May 2026 03:11:19 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e83084sm47335365ad.61.2026.05.09.03.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 03:11:19 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	sakari.ailus@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 8/9] iio: humidity: hid-sensor-humidity: use local struct device
Date: Sat,  9 May 2026 15:40:39 +0530
Message-Id: <20260509101040.791404-9-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260509101040.791404-1-sanjayembedded@gmail.com>
References: <20260509101040.791404-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Introduce a local struct device pointer derived from &pdev->dev.
This avoids repeated &pdev->dev usage and improves readability.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/humidity/hid-sensor-humidity.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index 18d4e376376d..d310ec43a118 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -196,10 +196,11 @@ static int hid_humidity_probe(struct platform_device *pdev)
 	struct iio_dev *indio_dev;
 	struct hid_humidity_state *humid_st;
 	struct iio_chan_spec *humid_chans;
-	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(dev);
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*humid_st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*humid_st));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -215,7 +216,7 @@ static int hid_humidity_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	humid_chans = devm_kmemdup(&pdev->dev, humidity_channels,
+	humid_chans = devm_kmemdup(dev, humidity_channels,
 				   sizeof(humidity_channels), GFP_KERNEL);
 	if (!humid_chans)
 		return -ENOMEM;
-- 
2.34.1

