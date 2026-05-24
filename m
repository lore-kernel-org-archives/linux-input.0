Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B30A30E821
	for <linux-input@vger.kernel.org>; Sun, 24 May 2026 19:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650913; cv=none; b=XAv9RENCXSUJasN+m1mHvSBLZ92kSKC9x3xWGZvwwzlUVK85GmIPlv0XVrotPHBrK/JsdvGsR9Y81dNZKbXynBvOS9dihgsKVDthk3uMxCgWyn67qBZFjitJau8gqpbDvq9pdvTy1EQNchgcqqtwwU+665Z0j1q/iESLAGR0FwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650913; c=relaxed/simple;
	bh=nw7SwQ1l1nFZsuBDD1Cx23RcHzPHJ8ppExun8H0RbYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e1NQJ10/V2pBgEFC1vzopjEsZM6QJlxFqVA6VZdn9rEFEzg/YIFQO81GQfMxNw7p5CvMWoRBPAZFz/X0fC/shnxzekqe0N8fSgr/jBmNj7pT4uwwyl2Btv/eRXPVjpQS7AqC82UMDBXA+3bZEjZRQquVCeGmi+2HmBoxs3xsNEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gdw3TpRV; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gdw3TpRV"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b458ca2296so65485825ad.0
        for <linux-input@vger.kernel.org>; Sun, 24 May 2026 12:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650911; x=1780255711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFSkdTSQypKHAxtx4UgSnAMWP1eHogWGV+jnb1N+RpI=;
        b=Gdw3TpRVOBI8CQuKfcyoJRagimAc6XfT0xz4kZ9+pCHvxxvQ7li1KGGk/qDCCNdUc9
         c83xJytnE/RWHWTvyzA/n/nk0t3SRlHuk0CzDfTcGSGC5BAJ4Sya3DMVAwhl3UD8jkln
         aeEK+ks3aSQGfSTmhJWHpnUpzheEJhSZc1PYaxx4N5UwaruvB61Uv7Qgvf+jDtD+KRsr
         RiB7+z4viohDu7oEpAndHpITFNeEKJnIULTBbsZUSMzKg/aE43+FwDq77tee5bzhZGxO
         loVAb8wq3jiz7M7SyYS38irLy8LGPW+aMkqRUZ/9fdd639zkFGibrKlNybQzL9d0FIsj
         oAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650911; x=1780255711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XFSkdTSQypKHAxtx4UgSnAMWP1eHogWGV+jnb1N+RpI=;
        b=XZVc/twY3EoXwQv/tVfY4L76hz6QiSr97X+s3aqFMxzibnqb+hLAChMpxgKaL9X6IS
         mNO+29ifXyt+TDv0DRXeO/Y6ISGkH5UA2WqVmgBgYvsb5DAlp5W9feiAsxVay80Hk1/s
         Z/RzPuGiiTOHc/zMV7u4Kf8h/93JaT6y9D6zF9UhClqJnZjFvsowxxJ3WT/kNlH265Vz
         HTeNaXtT0+9rozldJlpg+oUrv6LCyxEwu35Rx1rVnHVT65NMwHWCiXKsXbKDBgCGB5bd
         84yjECW3vwBy0JTKNXuZ1AP7ogG7a7qXGxGNBZRmFlJARPdlxF2/LmeeMcGdnjsgCJgo
         QuoA==
X-Forwarded-Encrypted: i=1; AFNElJ9NbjEZZkmtNrIp3uhp4za077ZPLSltgZaJj0rqGBiuenl1q8xMRZLuvD5hm/nz65uq0jmn8lELiD0Y5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPBurU1hgVnrDj1ah8QBjYKHoVzZyLG96OI4EbB2q/VhwPJj2F
	kWrvShVpHIXswViJfajSt3EuM8ZzI1qSTC+6JqP10w7g2RTPY2yRnXme
X-Gm-Gg: Acq92OEBAfILq3tJoOgSVs38j6gD9nBzglrDzR8ukQK8MbD5lJwGWAwKNPIza1nNuIr
	VCnB2ThGxumIUYTI6j2CpnlLzIEAwdWetR56VJXigrY94ZbjdK05i6a2twSNbH0Hycpiy2Vr5ad
	LsxkV7ukfpQLE/MoEoGwlmOo7/4Px/7ZkcqVZVBKi4f/rc2Eoe1jSVJGqhr+ioONzJSolmAZHSs
	GE5QmL9TY+hegmkIPk+OKwvJHmA9wGLoaJ/AKK94hGbxmDaKKSjPUYNZ6hkO5yngroQqsuwzGHM
	j1wTB88RliC+ghzpWCn8MT6CATzCP7z54GJ8gT7nQogQVIqK1sQCnV3eiqZ7q5ZHeccu1Kb3Ljc
	CC2a90c3myj7oNlvoYw1uXgEIuZ0s3hI8mWCtP3IGokfZDDV3VH4E3KCVJtYdyeJWGBFNZG6fzU
	yllWTidAl1j++HE5Zg7Lh9vr4kmZ9sLaw008x8Vg0xH9TuuCo9
X-Received: by 2002:a17:902:d50c:b0:2bc:78ec:54cf with SMTP id d9443c01a7336-2beb035a83bmr136372105ad.9.1779650911417;
        Sun, 24 May 2026 12:28:31 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58d9fe9sm71489785ad.65.2026.05.24.12.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:28:30 -0700 (PDT)
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
Subject: [PATCH v4 23/36] iio: position: hid-sensor-custom-intel-hinge: use local struct device
Date: Mon, 25 May 2026 00:58:06 +0530
Message-Id: <20260524192812.1196549-4-sanjayembedded@gmail.com>
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
 .../position/hid-sensor-custom-intel-hinge.c    | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/position/hid-sensor-custom-intel-hinge.c b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
index 0ba9d2d43913..34c7cf734018 100644
--- a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
+++ b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
@@ -263,13 +263,14 @@ static int hinge_parse_report(struct platform_device *pdev,
 /* Function to initialize the processing for usage id */
 static int hid_hinge_probe(struct platform_device *pdev)
 {
-	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(dev);
 	struct hinge_state *st;
 	struct iio_dev *indio_dev;
 	int ret;
 	int i;
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -287,12 +288,12 @@ static int hid_hinge_probe(struct platform_device *pdev)
 						 hinge_sensitivity_addresses,
 						 ARRAY_SIZE(hinge_sensitivity_addresses));
 	if (ret) {
-		dev_err(&pdev->dev, "failed to setup common attributes\n");
+		dev_err(dev, "failed to setup common attributes\n");
 		return ret;
 	}
 
 	indio_dev->num_channels = ARRAY_SIZE(hinge_channels);
-	indio_dev->channels = devm_kmemdup(&pdev->dev, hinge_channels,
+	indio_dev->channels = devm_kmemdup(dev, hinge_channels,
 					   sizeof(hinge_channels), GFP_KERNEL);
 	if (!indio_dev->channels)
 		return -ENOMEM;
@@ -301,7 +302,7 @@ static int hid_hinge_probe(struct platform_device *pdev)
 				 (struct iio_chan_spec *)indio_dev->channels,
 				 hsdev->usage, st);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to setup attributes\n");
+		dev_err(dev, "failed to setup attributes\n");
 		return ret;
 	}
 
@@ -313,7 +314,7 @@ static int hid_hinge_probe(struct platform_device *pdev)
 	ret = hid_sensor_setup_trigger(indio_dev, indio_dev->name,
 				       &st->common_attributes);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "trigger setup failed\n");
+		dev_err(dev, "trigger setup failed\n");
 		return ret;
 	}
 
@@ -322,13 +323,13 @@ static int hid_hinge_probe(struct platform_device *pdev)
 	st->callbacks.pdev = pdev;
 	ret = sensor_hub_register_callback(hsdev, hsdev->usage, &st->callbacks);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "callback reg failed\n");
+		dev_err(dev, "callback reg failed\n");
 		goto error_remove_trigger;
 	}
 
 	ret = iio_device_register(indio_dev);
 	if (ret) {
-		dev_err(&pdev->dev, "device register failed\n");
+		dev_err(dev, "device register failed\n");
 		goto error_remove_callback;
 	}
 
-- 
2.34.1

