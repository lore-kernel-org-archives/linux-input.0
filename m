Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF1E314B9D
	for <linux-input@vger.kernel.org>; Sun, 24 May 2026 19:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650785; cv=none; b=kuZa8Yk45GEIoO3RVQ4FD6Rj2G21AjeaFuVxjZ8UOX7oXXOkq9O4/TbWyrIL1M2DWXLN97OVpWkEVyALVOH/wSR4L+O+wO29IcvuyuDpdudr1AWGSeJ7UY0g1Au/MNehAyaTwUJ3EFddFzCMvFImnRnTiDt/MHi++iSw3mpOd0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650785; c=relaxed/simple;
	bh=7PRMoD9vJAzFPnPVnt/PERV904czcBPZxnZNYRHlRD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jc5foN/UZmMZ3QF/clI6UXsw5SwKyR+aYdq4uGAaJ+GCszhktMYINCbnN/lSvdetPi9jR6CqQsfX+naVBccjJiTJQKQRK40haCwIKUejJOuPOD4RrbiOPY3AqhzX3MLjBA1q5pcmpZUrNeTkdtGSjWCZ2LFLs1fxJ1XVouCDU1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REgxADMl; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REgxADMl"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2bcd3ac3307so52576715ad.0
        for <linux-input@vger.kernel.org>; Sun, 24 May 2026 12:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650783; x=1780255583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZpNiHPFeF8hK/y/e/W3MqlZSN9qWkMyFvMyP/Ycuns=;
        b=REgxADMlRIXFy9jk+STjbztQz701KXl9nkDkeQSgMU0iAx3t/fTH8gyq1tjA9hHOMq
         uz2Uv29hhAHRIpVTohM5fwqeoVur+u8j/X3b+4qtPsxWUtIcwaUXQesK6EZrUNAx82Uz
         1Cnz5wLgFhxpfDXAtoJ0I9Czhe+/fCDemvTzniOqNJZ1OL1j8a9kX/A7oCSxNpxGFBSG
         w5vJ6ItIB9gDH2VhUmjnqlylpjySJONMzYNTRLfuKmgMP9lRN2siCvBwRiHQ0o8HDtcx
         6cLLTxQ5U0L5b6fc5gBcmk/NN9btz6tehREq2EGjmeuCQS9/5t41fvo8MdZXlDfAAECW
         AyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650783; x=1780255583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AZpNiHPFeF8hK/y/e/W3MqlZSN9qWkMyFvMyP/Ycuns=;
        b=Adv8du+SDS67pqi9ogMlDVPXGpipBgXHQS6lLJ50qyltNJPAXBzAU2ZAXVd+ExtC/u
         nCel5OVY9CA6rvSoIEoPIPnW+64zVn+0i5T4N91dOC867vw8O3veb02wvxlFqcJxjn7a
         caDOdIo8u26AGQyiIl03DlQCwGG8QjeTxT+gb3VZCdGzcu4ROJnSAgvwnyrKxpmNZs/c
         Qd7tzijnNqePtreZ6M0wT2GYzVgJXwklOWD2Khht5EfyvDalNa5MUk7EgWKg3ctTaD5f
         9UyIR33XZ3St3ZVdPa8Z6TKeIYNE25zAgkKt7TnHRD7Uzp596uJk7/VrSH4BrWTItozE
         E2Ww==
X-Forwarded-Encrypted: i=1; AFNElJ9rXHa86K9/iqYq2npPRI8uBzIlCI/ZOOEu3DnlhmF7D4LYS2J0pIYf6C538FrRr0yg6w4p1Ftr2CUiSg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6hYR6Af2pK2XDJ/UAtG5aIcIVGg9sFaTDtWhKnxdbdb3v4w6l
	gssM+JWb9uu8bSKjiOsfizdcfZay7MEurJnNpXvCLIr3ZcJv0XjzhJu8
X-Gm-Gg: Acq92OH55aYrrjHLcYiWtj+qXgY4aj9z9Cd/gw3BIkfUKLTSq039i8WBouRAOFDSQyB
	uUolQNzTEgQe2qKUJraY01qobsa/owVPejQsGp6Wl6Zo1Xk5Y2h2+mw9dAiXU0Lze6maILr4J4A
	F7nQL3wurpRzG8uxZm6LGTtcd6JfcOy2L8C9ShgVc0zMkkG+MbE0J/95womKzF2U7a6i/9kGKJG
	uSJ4ye1FjHGxzDX55ykmmNFk6rIVvANmFUWgNbuPoMH655a845Ctu4BOImIOD3UYRRpkJRyVBcy
	8K2WM5YvTWAvjp/4XiQ6wGiMIp2XJkCSI/DrA+p1cWg/u9ABQA6izFKw+LGXszL8Cf4bHXuLvAZ
	dC5EJI6RVnwv/7yN/bbuxWSyghhaDWmJIcoLqh/6CVDgHnLEAXHi5i3SePG0tGhv/PqIt/48jaX
	EZqzxORMHic4hGmG/0bAhfwLN9Xze85dkadTcgBp2rf5I0GKaU
X-Received: by 2002:a17:902:d482:b0:2bd:2de3:519f with SMTP id d9443c01a7336-2beb074f92cmr130040995ad.19.1779650783475;
        Sun, 24 May 2026 12:26:23 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bed2061c59sm16394465ad.2.2026.05.24.12.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:26:23 -0700 (PDT)
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
Subject: [PATCH v4 15/36] iio: humidity: hid-sensor-humidity: use local struct device
Date: Mon, 25 May 2026 00:55:52 +0530
Message-Id: <20260524192556.1195042-6-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260524192556.1195042-1-sanjayembedded@gmail.com>
References: <20260524192556.1195042-1-sanjayembedded@gmail.com>
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
index 73120b87d641..ea6f66ce0f8e 100644
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

