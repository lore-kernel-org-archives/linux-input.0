Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A137C30F94D
	for <linux-input@vger.kernel.org>; Sun, 24 May 2026 19:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650905; cv=none; b=eQuxcWMe37v3AaNmRSIPupx9HT2CIP8nMLs/Kwfgv0Ea936lh/D90GTvzQgYQEHuuJEOB2mcneXxPcPyfEKj9K/s9neJB5tmm7J/aKX+t4IuZJGqDBovC6AU5KBx16trFadqiNSsqg4eX8zgsPXhs7X46FR0y2mj/SUoKJtaij0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650905; c=relaxed/simple;
	bh=9KBkBMShZ6Rk3MwkRfvkhK0E3NugzuNvlxRcXqS3jgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QC1E55HfKKCc+5X+baY31v1EigztyxC9+KzlPiHS8mHMmxOOPLEbNxgWdd0LC5o919Dx57QAMhERI0tKH4asJ4Mi6ZsWbyOeNWpSjwbq4d92FN+lAEplBujQnJWbF+3lk2GaiA+wCx3Gc8tZofPeBBdPFfPRXaVY8uMv2k/pdhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pCNRtleC; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCNRtleC"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b45cb89f7eso60130325ad.0
        for <linux-input@vger.kernel.org>; Sun, 24 May 2026 12:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650903; x=1780255703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=medmHDQJvV2FcWBC8j+zjvPNWaeMYtRjYLXymq8T+6s=;
        b=pCNRtleCl42ZeX4YCaV8EjqlIz3pK2CFM+PGeUcoNxVsIrz+SjVcXnvNM7WX5o6FtF
         tSKMSnZVVxX0TRRkrdYe2NtcsoMysTt7YABYb7s2Q8aoTu1flGUcf6Ex019jC8scsfRV
         iFQvrpI5PegVu3BBw9gZpWp4lmAm4cpbHbX1rgf9+7B/mSnpqecAiXtrLpbm2yJ8PlVZ
         IJAP166bXwto08SUGi8//sf2jTmi0pgE5HnUjcXBrRhr5YucPlaL24fxcoT+bnmxmhca
         gLw89UznUD5sJKq/3ZUBSVoWUYMpyFYlokY5EmoQFY7iF9pKgxgIsMDh8rGXJWXTjlKw
         5t5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650903; x=1780255703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=medmHDQJvV2FcWBC8j+zjvPNWaeMYtRjYLXymq8T+6s=;
        b=IV6mA8kCRoP6oM7c0crIqjQBaVqyO8pnxZdhzS3/+Qt68buutJXUIzJGM/7dhmuYpy
         NWSEfs4+v+kilnGpu49zBCK8a8jGHZ4Q2FueBDwWoWQNo8xXPqNbdEziOr4AiMszeKqy
         /pYSYk4/2Behi64toy4BnU3SxwgcgFF5i4UK4ayNnP04A2eWN3AsSuspStdd/HqM/swc
         4BQtfewH+aeGy88XDbZBVbW/enmb3gCJNDaCE3vfP3wF2ujwaw4Mq4xyhc6wkN8JXE1Q
         +/sHDHCMBSrsQ6ZEANRAPhi48e4yTHM4uKDKfKie2CpiUVvtEtScSXPh39IAt1QQhLdz
         Z22Q==
X-Forwarded-Encrypted: i=1; AFNElJ+L6vihcstiAa5eRbNj4RjqJ/SEIYMTNBjJoaCDEbbasX/D3f0z9AAS7uzAoaZPj8q3FPbEJSN3GyaBXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy155mbHpVYOZM1IhgMPOBVnQ4aAodm+FQfE152TAW4lDlln51H
	emOFz7aFERlmdxT8W92kmsew8Gu3P5XRpbiEqTT56XwYhipdv6rb2gRC
X-Gm-Gg: Acq92OHpHouu+Ogy2tm844wDdYgOdrq16dUwAOMU01FL++zeBE1RA5OQ5VIdcuUEtYJ
	R8Ov8RQxgo6KIF+z3QFAObe9bCEsZPrUWg39Z5nHgJn/iUaldAikbQeIATWV0yr0c5MDx42qjQM
	HqF9rA6gCOKSsr7gXBGBj1R+Xq75kAgUvEcWOSeQBjAuhJxbf1EK5TB7jRaUoLmE3C8V76+pUmr
	iYxEyS5q3NC6S83L9ko6WROyb/1FXVrUCo1Y3D5Z0nSeV8jpq58mwChR2LRMxfmd2+aK7XNrqEf
	Kr3h4n8yZCwj2IR1gvntd1omfoQxwNg6sQHGccvxYIT3BkWqlLTtXg5xnnQhkxi8K6D1xGQyyyz
	H2N7kQM60vb4+cacfT2wYgj57ncE18Yl6ibIPVf1gNmBer/bhOQ5Ln9lLb169inmvTgeDh4aFdo
	Ns91k0wJcs50YfVOoaC+F1wD7fQ//NlWJ8jrMS0ZvXDgoKdDKN
X-Received: by 2002:a17:903:3b8c:b0:2be:1db0:f166 with SMTP id d9443c01a7336-2beb0346484mr129345405ad.10.1779650902872;
        Sun, 24 May 2026 12:28:22 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58d9fe9sm71489785ad.65.2026.05.24.12.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:28:22 -0700 (PDT)
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
Subject: [PATCH v4 21/36] iio: orientation: hid-sensor-incl-3d: use local struct device
Date: Mon, 25 May 2026 00:58:04 +0530
Message-Id: <20260524192812.1196549-2-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260524192812.1196549-1-sanjayembedded@gmail.com>
References: <20260524192812.1196549-1-sanjayembedded@gmail.com>
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
 drivers/iio/orientation/hid-sensor-incl-3d.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
index c7fbff498be7..93fce8510468 100644
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -299,14 +299,14 @@ static int incl_3d_parse_report(struct platform_device *pdev,
 /* Function to initialize the processing for usage id */
 static int hid_incl_3d_probe(struct platform_device *pdev)
 {
-	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(dev);
 	int ret;
 	static char *name = "incli_3d";
 	struct iio_dev *indio_dev;
 	struct incl_3d_state *incl_state;
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev,
-					  sizeof(struct incl_3d_state));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(struct incl_3d_state));
 	if (indio_dev == NULL)
 		return -ENOMEM;
 
@@ -322,14 +322,14 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
 				incl_3d_sensitivity_addresses,
 				ARRAY_SIZE(incl_3d_sensitivity_addresses));
 	if (ret) {
-		dev_err(&pdev->dev, "failed to setup common attributes\n");
+		dev_err(dev, "failed to setup common attributes\n");
 		return ret;
 	}
 
-	indio_dev->channels = devm_kmemdup(&pdev->dev, incl_3d_channels,
+	indio_dev->channels = devm_kmemdup(dev, incl_3d_channels,
 					   sizeof(incl_3d_channels), GFP_KERNEL);
 	if (!indio_dev->channels) {
-		dev_err(&pdev->dev, "failed to duplicate channels\n");
+		dev_err(dev, "failed to duplicate channels\n");
 		return -ENOMEM;
 	}
 
@@ -338,7 +338,7 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
 				   HID_USAGE_SENSOR_INCLINOMETER_3D,
 				   incl_state);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to setup attributes\n");
+		dev_err(dev, "failed to setup attributes\n");
 		return ret;
 	}
 
@@ -352,13 +352,13 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
 	ret = hid_sensor_setup_trigger(indio_dev, name,
 					&incl_state->common_attributes);
 	if (ret) {
-		dev_err(&pdev->dev, "trigger setup failed\n");
+		dev_err(dev, "trigger setup failed\n");
 		return ret;
 	}
 
 	ret = iio_device_register(indio_dev);
 	if (ret) {
-		dev_err(&pdev->dev, "device register failed\n");
+		dev_err(dev, "device register failed\n");
 		goto error_remove_trigger;
 	}
 
@@ -369,7 +369,7 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
 					HID_USAGE_SENSOR_INCLINOMETER_3D,
 					&incl_state->callbacks);
 	if (ret) {
-		dev_err(&pdev->dev, "callback reg failed\n");
+		dev_err(dev, "callback reg failed\n");
 		goto error_iio_unreg;
 	}
 
-- 
2.34.1

