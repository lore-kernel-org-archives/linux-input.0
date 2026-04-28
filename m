Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DA43CCA02
	for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 07:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360605; cv=none; b=jznyxTSKtj6VAl9rZsgKkRoZPPsTpqMTMhG/QlqMoEbc07T6bU6E0p6KA/Wk2/MaWIZb4ntmttiImkU6qDP0lcAXOSsO/+THmLgv7umleO+Y1/cTcUDWQyOeEL5k2nMiFLjqr5RFNf56V0BUIxbN4jAgsmtuV/pVU8G9wuVt2w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360605; c=relaxed/simple;
	bh=cewLy2WqB68/tbc5qDfV4qId9cmPsWq1aneTgM01BlU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SGK5aoISEH7AOq5O4t+TxFIEAAbV+ZXsOjJT9/ya9ggJYoiCmqFPW/cDaYWL4iv8MSPXOe2GX0jFUwPx87KLojVoauG0rX8PyHNQQ72tv7BU1PNzFfFGSZ/CxbvBpLct6l6IWaMIJesBFZVby/kAYddxadXgsjcOas8dkWae92I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RChWxRqE; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RChWxRqE"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82f69adeecbso4539281b3a.2
        for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 00:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777360604; x=1777965404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JuVbh6hdR7S7K79ksdJ8FflVGwGwinNinRhTfjkwrM=;
        b=RChWxRqEe6WtEsC7nU/XWG8M7qUUeQWZojhmvxDgqN6+abSRrY3EimiivcvjMwjLLf
         vYW4hQukL5VRxMgUtvwzyysVcRgxIcCgHi/zX0QTFSxzhpVu8cnlWDQZYDQS7EaF/PXu
         bcQpmxQcunNTKHfb6r1fzHwTivP28xMHWCqmBwIwHQu9FNJuscm52lId7Cl13WIEVi9J
         rXLwOOX5st0RauDm1mq+fwkXpSfrJ39qFnx2hA6tFrqxinC0ekTZhtEFtRhc5UWszqTh
         UZrWcLkKkp/K/tAK/U8BnMPmKpOYzMj7DJLK9seiy4SrgVs+M3ZjalVE71ceWvZKtIJI
         3Q1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360604; x=1777965404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+JuVbh6hdR7S7K79ksdJ8FflVGwGwinNinRhTfjkwrM=;
        b=SqEO74B/sScSCk2VIokIjI7J6EYRoQ9zn8YQejsMv4rNwdV/BzZiMZOCkDmDzCTobh
         +1OyKRXKKZgqhSfIgx74Q/VGmVhpbp8b9C71YSWeb+CfOukT4nLbOEgDZ5+ZJsZZusc2
         R83skg2L8qj+TJt/yy4FUDQKuqdwTvxPtWI/5cweLJ+RRvcaBGZSAXCk6pLSWnGfi6HN
         u5864Tc63d2YrFR6hqE7af2N4Ks71S7at9y41t9dbNP4omuCgAE93hSi4Tv7N+OE+Zth
         5ALgf6CpukCRm2Meji48y+ZmqgfAQecAbMC5899tTiM/OKL8wm9lQQ/WSoNRTFAON3fU
         3xHQ==
X-Forwarded-Encrypted: i=1; AFNElJ/OYVrF3GrgLBP3cNdNuBva2oJkEQJEg0y7bAthZ88ZoQMENHCwYNbsjBo5JSJVzo03pLCWPH08Or81Uw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAXcywjsBjJMcq5zrirpO+J5KDtnAw4DVBGJAjewB+N9gbecbr
	Qp0KG0G2Z5bznguurUz6t+CRF5t1/4k+Q8kDhPjbJLtzfFpu7AtT1VHD
X-Gm-Gg: AeBDieuHp2vLAjT7Kd4DpRFoDH7EOcR0i1j6MInNqrTLGT2/V8BAHZgEXTfZaYOXhJQ
	MnF80Sejv0FdrIFs7qBfcYnL+DoIuEE6FYzmYhw91shbdt7hsCgtsvpnx8ORmGP6KSgBEuSz/x3
	u7YhDBT42m5tMf+xc0SQuCNorn2eGkwxtPmt6KOph2uSujXZbZC8l+qHrcr3AVO2EIuCo5Hqdvg
	MV9w+UcwEs3xIC2QUz3pppjRatwlAfnaZ64t2n7CqxECvL8ej4myGzbdfi20+KlgLcW86D3Q83+
	uXFzOtflD1peEjwT+iDPN9/E7pIh/MqvSxiAT2dgLbD90ZmJv0T34hBuUOooK/mZ1TIxpCAWrik
	f+WM0jsxYx+BHE4X32t2UMMzqpcV3DKmFugK4EKioVovCdaio281HqDsXFyVzL1fwJXw44QO/Gc
	f8u8HILcqxW7x2MvixYY5R19yWGZTjoNHP1gLmy+4HtHleWiZoIAsw8eekSuA=
X-Received: by 2002:a05:6a00:3403:b0:82f:4cc9:186d with SMTP id d2e1a72fcca58-834ddc8f656mr1872109b3a.46.1777360604220;
        Tue, 28 Apr 2026 00:16:44 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834daf5705fsm1987335b3a.42.2026.04.28.00.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 00:16:43 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sakari.ailus@linux.intel.com,
	sanjayembeddedse@gmail.com,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] iio: humidity: adapt to hid_sensor_remove_trigger() API change
Date: Tue, 28 Apr 2026 12:46:09 +0530
Message-Id: <20260428071613.1134053-7-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260428071613.1134053-1-sanjayembedded@gmail.com>
References: <20260428071613.1134053-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Update the driver to match the updated hid_sensor_remove_trigger()
prototype, which no longer requires struct iio_dev.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/humidity/hid-sensor-humidity.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index be2338d5f407..e580a2af9562 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -255,7 +255,7 @@ static int hid_humidity_probe(struct platform_device *pdev)
 error_remove_callback:
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY);
 error_remove_trigger:
-	hid_sensor_remove_trigger(indio_dev, &humid_st->common_attributes);
+	hid_sensor_remove_trigger(&humid_st->common_attributes);
 	return ret;
 }
 
@@ -268,7 +268,7 @@ static void hid_humidity_remove(struct platform_device *pdev)
 
 	iio_device_unregister(indio_dev);
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY);
-	hid_sensor_remove_trigger(indio_dev, &humid_st->common_attributes);
+	hid_sensor_remove_trigger(&humid_st->common_attributes);
 }
 
 static const struct platform_device_id hid_humidity_ids[] = {
-- 
2.34.1

