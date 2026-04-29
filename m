Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE3840FDA2
	for <linux-input@vger.kernel.org>; Wed, 29 Apr 2026 17:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777485583; cv=none; b=ZOwffQC+kMOi+5E2MAE3PI0i+TnzSVEd2woWHyz8U8AWpLyTkOLU4VRsgJlFpKqMwMHaHRAtqxmOiTqqP82pRSz03Bs9DUyeuNoxB7/s0orR3YJ54oJ/2o5ZUYWFQ9Ls8sZa7r2ezSUbK/YtDivLjR6b8BP+K7saukeEjrgUPc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777485583; c=relaxed/simple;
	bh=8/qcCYzSJnLBTmLbTEfDHsZdZW0SMDQHR6QOpsBp21A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ch6K2l9TpubI9wK96VUaYPabBrofp7w7M2ZZFIJSYxmuEWyhrK/+aWr7akrSzvo3OtkZgK0+1qOgQFuRKIjnQZ5uT8yojR64fq0I8SfELyM/p44rtTPHiYrHnwU1DUrJGZ+rKYP4NHRnG/EHuKa8qi8mWgxbxozCSzI2Mbs0O+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YD85aaFp; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YD85aaFp"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ad9516a653so468955ad.0
        for <linux-input@vger.kernel.org>; Wed, 29 Apr 2026 10:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777485581; x=1778090381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UeZsajTGzir0DsezoA/yBicvjNkqNZfG5BhpGutw1+U=;
        b=YD85aaFp3w0TzcutfWGwDFRDOVpi9vVqd33gPHfntHYCaGt7/k89mDKusYx+8z4JPq
         4RISz20+2Y0oSDmjeXNAji8pJEHbLEOAbdsuqgOhKyNthcyUTZbfLtMoeD/BnHdz1jZa
         2CfX40p8SJvfK6FUb1XozkAbmzNmIBZdvNdZtCCpFqRP4Q2m/nwEEk1uLGt+Rh88l7bl
         FlBk46kr2vS5JkenC5osiPD/wrW1K8DnhQMu+mQItVkFTHsgdIWL6AbNIOlqUHBRX+RR
         OQI8XmOux+QuchBrliOChlsaZ1WDqaK6sKi5Sd/BJUvBrrCZFo9zcnPYC1UuK6aSLLXa
         eoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777485581; x=1778090381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UeZsajTGzir0DsezoA/yBicvjNkqNZfG5BhpGutw1+U=;
        b=NYB5YQHeKys5D8oxuZkqorXQIiYdKywbxhn0vLNRdzvjTIOJZU+5btUoNdfUqN8fz4
         qDNV8unrHJgxE6KLpKXaKVVTJ5kT7V0Ix1q6/Ors0f5PmVL9hez41UCptbg5K7M0JaiE
         MwCfSpoDua+/2Zn1P/WRWLptYK9lGbeaVIPwl4fDNnTVAdw9Qfql4LKus9OlCMV9QIKu
         HmmQgPbtWZagEdq4tewPJdLpcEb1JyA2WkU2gY+A4c0eojW/MJTb7jPMUszGzK1pQ+Ly
         /LRQ6W7WzwGJnmfFo6zArnpVDEDpxoMLhWMnsDVVQKVw92xQFp8pVliXlYj7MbYReheX
         9S+Q==
X-Forwarded-Encrypted: i=1; AFNElJ/xBqKbpTGif94ftYh04jpFsk2/2IT7Kz96JDcsfG3WiZ9DR6BDL30VP4VWSqxALo5S1JnrwgwIHL+m8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcsFIS6XAsh1nn9nxZ0/VWzHeWWBlLssgxoE1wwbzc/uyDmlcr
	mws6SmUUHQze84v+uAMZBUrJhqSQLP1z/PSGZEJcx5vbca1Pc5jzXljb
X-Gm-Gg: AeBDietMuHhMRdzvmATAHy+q7NIADJbmT5ixm6a4hWWVJoEXR8SQ5d8fHQiYImJiGqi
	j78Cb2dPl28gdyl3Vn+SNfrluY6noOcIR5GUlgaX4cPkONSfbPH+phk4/fGlm0L+cPa00BImpbP
	O7fX6q0i+2vwkanaiUopPGs3AyfP/n35077uQAga8wSO77wLLqWqaJbjQa5e2BlU61s6p9llq3H
	EuW1gcZyGBX3pUBzYjTyWyzV9pmiGTLtcyYj5AcP73YHAKGSIo9X0Ux/fxCl2MWfIULfS8tpdbo
	moVV46o1n+bWCGN3bV/hXJGP1Q+uGTjZ/qKrE36LpLZNerHl60JuItT/D89G5tnZJUY8A30WBr8
	ncxJ1JNU4SoXME+dAaXm/R9n7FOhKSH5itf9TmKGU+v+HIXG8F9SY0pOws6MBLFT/ZIODP/bHTz
	n1JWCs64WFdQm+7j/KpokLT8BliepVbjqnY+JUD35WeTNtO4mdlnSAF7diZy9nih0lDhDrQw==
X-Received: by 2002:a17:903:3583:b0:2b0:59c4:e9dc with SMTP id d9443c01a7336-2b987407cfamr41849745ad.22.1777485580899;
        Wed, 29 Apr 2026 10:59:40 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98897edefsm27726805ad.74.2026.04.29.10.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 10:59:40 -0700 (PDT)
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
Subject: [PATCH v2 4/4] iio: humidity: drop hid_sensor_remove_trigger() using devm API
Date: Wed, 29 Apr 2026 23:29:18 +0530
Message-Id: <20260429175918.2541914-5-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260429175918.2541914-1-sanjayembedded@gmail.com>
References: <20260429175918.2541914-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Use devm_hid_sensor_setup_trigger() to automatically release resource
during fail, unbind or removal of driver using devres framework.

This simplify the setup, remove goto, avoid manual resource cleanup in
teardown path.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/humidity/hid-sensor-humidity.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index e580a2af9562..7ec8a8ba2b38 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -233,8 +233,8 @@ static int hid_humidity_probe(struct platform_device *pdev)
 
 	atomic_set(&humid_st->common_attributes.data_ready, 0);
 
-	ret = hid_sensor_setup_trigger(indio_dev, name,
-				&humid_st->common_attributes);
+	ret = devm_hid_sensor_setup_trigger(&indio_dev->dev, indio_dev, name,
+					    &humid_st->common_attributes);
 	if (ret)
 		return ret;
 
@@ -244,7 +244,7 @@ static int hid_humidity_probe(struct platform_device *pdev)
 	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY,
 					&humidity_callbacks);
 	if (ret)
-		goto error_remove_trigger;
+		return ret;
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
@@ -254,8 +254,6 @@ static int hid_humidity_probe(struct platform_device *pdev)
 
 error_remove_callback:
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY);
-error_remove_trigger:
-	hid_sensor_remove_trigger(&humid_st->common_attributes);
 	return ret;
 }
 
@@ -264,11 +262,9 @@ static void hid_humidity_remove(struct platform_device *pdev)
 {
 	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct hid_humidity_state *humid_st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY);
-	hid_sensor_remove_trigger(&humid_st->common_attributes);
 }
 
 static const struct platform_device_id hid_humidity_ids[] = {
-- 
2.34.1

