Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B7639EF0A
	for <linux-input@vger.kernel.org>; Sat,  9 May 2026 10:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778321465; cv=none; b=o6UtvtbWJX4ZCytrQofouCZJKm9gtkfu5HmOSAIJo1r3FPix04YHcW2ODvhhb0WLAP4lLxrCQi3/XK7zYVEtitTqQz53dhf8HFE/5Rs4jCVlB6HctTn60hx63eQqlDhpO/D9SP+0KjYg2Sa7rXSTsQKUXCbx3vzEF0iOhuzXTKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778321465; c=relaxed/simple;
	bh=fePoKQCdmGQ5iCsHGCBYd3YJit6qtCw4gWlQYUfsjL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ryL/TboVRCaGFbtGpx1ZZCXfi0NW/OFYWeIHFow18EuRxM2bxAHFgEgFMqEgHB+zXg+lV06ZxAxuPasFPSAZD0zXEhIAEK2y9NaewSZHqyOCmMseVKZ26A44unYFVZpE3kul6k23KM4yEPCac0L1+4Cj+a+tEhSFAOQwbV4dkDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJmqrtHU; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJmqrtHU"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36643b96b99so1532557a91.0
        for <linux-input@vger.kernel.org>; Sat, 09 May 2026 03:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778321463; x=1778926263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOHJqaTcF1+fILni7WOWN2idwKhjTJof5YlmSEOsQy0=;
        b=HJmqrtHUT98sbXStBPPsJRo+/iuIgJRV+dV7ta3ywwzsORubxNeGsOooEU3Ad+dmDn
         /05+i/rCkhYzxu9P40O7iyjXN2q++/ZfN5uWkSHOh0TJhY+NKJ6K0KWYpzhbok03QWgc
         ks4fFaOozG2vkxoB27FXOKqT+hlhSKCLsxXkxcNaeyfBpJcz6b+FAW9HMnBVsOMTFH2C
         0SD4OOzX4qg6jiKUeAHpwid4BhtrLXBzKzO+bwjh219E5OG0W6yzcbUiEh4YiFRGFzlB
         WIwVcJD5xb1+D96dgPKx9ooKTzRnQyu9tbkAKOngpeKo8aR0aY6ywV8nScaA3McGnEAw
         g1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778321463; x=1778926263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cOHJqaTcF1+fILni7WOWN2idwKhjTJof5YlmSEOsQy0=;
        b=EvB8GoLg95ymNrGf62z/o4V5404JuFLJU42xoFoMZQUGAXwnCfXUhLq1Wt0vhkTcix
         FW21zCziphY3iao8/Yx4lZCiFS2o0jZOkNyAx+rN0CyvuopPbQUpGB5sJHAvk4Zjd0I2
         p9axhXRL17VK0DXndaydCVfdqe260KZB5T59BqKH7oH+DqoL0xizbkUMTQrMHcFX/l72
         m3ra8KAkx4V8TMCfhZm/JDhTVG8BuUykE3RHzn1DvqTz2jbgSajF2vLxZ6yrDFwHLrJ4
         IvonXiW/ylNzFGWqZil2KEK/4+OT4D4TErRNWaElE5vyz8nz5hjLMrdEKIXbsrl7HV1O
         hP8A==
X-Forwarded-Encrypted: i=1; AFNElJ9d4m6kum36WaQhK7sd6Ib6g/ph7+u2qTmCB9S/gSa0PThxW3PbaVWrieelOmMirLwhD7d0kHqLAO8N9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPRIYfIkNoiupmJKZnSddVRdqY5dL/mh8DygtPA5oGKsBmfNtQ
	Ht/24HAOZBn/+ddcGY5jjT9i6IOuUd/6LBTuiAxPIjfDlwwIr7BqOk8p
X-Gm-Gg: Acq92OHOS9PotonImGe6+65vLBAWQA/ajaKOvhtnTA5tMh7jexZr3ehryRkl2CZ9mSc
	q2p4vzeuqwkbyfOW13qKkTrR6u3hF0crzrbHayMGhiTRyMeLBcTmm7tnbZsWTtWGoyPRGfBhCvi
	1zhkb+n5RL3kISERb8598p5OG4EzDp9bPg2EIVhHJ4jFmsK9Fgwoof+cHpjo0meXVu3hD7AjgRv
	6KGzMVhs/MyW2X72O8B+CrOvkac9Fz2vs1BK+lhUgTyu4r0zSAgsuX/IflQy9BfjK4yXNQLk6fu
	/49Mt0uK/ggerKBWdKCZ56ogRvpARAwnVjWiZ4QwBoL/MrJgq9tptXCt7yD/MuELulXgiCwZp1N
	mMgooC4dzWRKdhytMWByAyXhBa8XsAHbPY+plWjJQ5cPDsOaAPYH7NNbkN2M5TVFfoUgnZjBIhx
	A3WqF/4vFb1htjencwDobNwb1kbuc+DYUf1vo8Vil2uuEUHU8B326+UyIhhQk=
X-Received: by 2002:a17:903:1b50:b0:2b2:42da:25c4 with SMTP id d9443c01a7336-2ba794bf96emr162194595ad.14.1778321463470;
        Sat, 09 May 2026 03:11:03 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e83084sm47335365ad.61.2026.05.09.03.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 03:11:03 -0700 (PDT)
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
Subject: [PATCH v3 4/9] iio: gyro: hid-sensor-gyro-3d: cleanup codestyle warning
Date: Sat,  9 May 2026 15:40:35 +0530
Message-Id: <20260509101040.791404-5-sanjayembedded@gmail.com>
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

Reported by checkpatch:
FILE: drivers/iio/gyro/hid-sensor-gyro-3d.c

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
+                               unsigned usage_id,

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/gyro/hid-sensor-gyro-3d.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index fe663b19e902..87537f9c58fb 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -187,7 +187,7 @@ static const struct iio_info gyro_3d_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int gyro_3d_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				unsigned int usage_id,
 				void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
@@ -209,7 +209,7 @@ static int gyro_3d_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int gyro_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				unsigned int usage_id,
 				size_t raw_len, char *raw_data,
 				void *priv)
 {
@@ -244,7 +244,7 @@ static int gyro_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
 static int gyro_3d_parse_report(struct platform_device *pdev,
 				struct hid_sensor_hub_device *hsdev,
 				struct iio_chan_spec *channels,
-				unsigned usage_id,
+				unsigned int usage_id,
 				struct gyro_3d_state *st)
 {
 	int ret;
-- 
2.34.1

