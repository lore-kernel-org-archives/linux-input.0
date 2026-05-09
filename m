Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2078539EF2A
	for <linux-input@vger.kernel.org>; Sat,  9 May 2026 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778321457; cv=none; b=B7MDFtWf3c8RV+BDcFF2obKs7otScXoIPVi2ZbFpodW+6MKyawmSUI27u7DO9PfXXrbUbxpjZb83Li4yI04aBbNE8/asJgma4aFqyod53KNvy18+UtoY/xcP02UJGAVWNK99Rr4IdhGX6WI/J78tor+dQkbc00e+8zrjNGfH8+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778321457; c=relaxed/simple;
	bh=tPWcv1jECZQQd9JlDny4sLxfDxzU2UCtd4V+vUCcfMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pJrMF1dV7Ctt80T4gvyIDqzKIDijQkWq9Imq9ajpadA2bkNOSLPAk1R2VJywISchC6a4VNZYiwp18eEbdFiBraXmlLHA40zm5KPL+qsxC6f21E1dHaHfCAuXupqkeIPzFn5jqMqeAIPj+kcpFHSPvuxMHVaQuEV3R7MqQ8kXB2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8+SXQpx; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8+SXQpx"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ba928852a5so19052255ad.1
        for <linux-input@vger.kernel.org>; Sat, 09 May 2026 03:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778321455; x=1778926255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JkFhHabJLImjsw5jAKHOTDz0VLKOY6FhmBrPls4dhd8=;
        b=i8+SXQpx1PKKFWK0+os+QQWDUi3jJ5RYXDE2fYqwC1lEo05WfTF23/yyXn+t/Lv5v3
         IQAa9be8g6velieS5mf/DgjiLo89UvH9AIE00+gQirsz7k8VGmfV8RBNlWRG17IN1EWj
         k8IFvz99LNtT9ZvdSGbk8XwJcs6QYAf5TUIrI+BcWIgfrraMPQmiz3NbNW8jl3HbFcKf
         l8LfvhrlkD8SBCU6h6qMETYI1cnm7MIRGqa2z5On8sy88dv9NW4WSeMLqAZpVFs+f8zo
         wl3+HGXXBjV71xVICP986VyI/7t5ioHJK9bOSfbtJFtH7Aioq+drpvavLvFZ88DF5dAW
         mScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778321455; x=1778926255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JkFhHabJLImjsw5jAKHOTDz0VLKOY6FhmBrPls4dhd8=;
        b=Dw6WBiiqB5NryrZqK2xW7FHR5FMY3fy12tTnxFKIYEHWnjP5gbK7ROM4M6a/fyUSWa
         Ju0T0Ft6tM5C6i/6MxqISqmc9ITOfDVxfmhmjfemuFhIdeczg9RzGHiNCtUI6xnMFKrs
         s1zCJ4uAT6/EpBmjdKB9NM/hwoMdOpfrItR+fd7bhGwSVl9+lm4MNFObixEBU1EuQp1E
         i8KIB6VW51UDl4eRr2VEo/DwbmZHgf43AadtzML97A+5hC7nSCmR+FoUteHV7Ktb3Gfj
         M7g8Wiutt3EmY5Sae2qhTT5tM0tUUmHPByDgt014/RN5qe8D0M7NlcnyD1EXKLGfWxXb
         jkDw==
X-Forwarded-Encrypted: i=1; AFNElJ9l1l7UAxEjUTFr0qF2MuzRp4Bgj2l2m5En9KG5pAebVzRK39RylsXfTgB5PmsvdrTbWyfTX+mbRxN6WQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0n8pWax+NqGDjFoiDNJgUwpCv9LWTcEq3b5t2CPupSVwCiITf
	L/2FzatrQHqS/8hKIQRJ4TkU2qhNpOMg0z6eTCGo+z/tNOSdamcGBiND
X-Gm-Gg: Acq92OGT/PZKE61U/ZIBvDC9bwVoHDlKKls/n6I4mbg8bs2apAyeLnyHe6Xr/m0wuJO
	1LKqUmDc8gtIE0BUokLm5UX1bIr9qhOvqab8lQgOucIm7bIWa1L7vlX6Fqgrh+s7cDUDASNGa4/
	7Pf10o0blO2SArFKcpN0jITAWoLL1PGkSSOJhx6dUIy7kjDKE764Iy35kJlEIsjWT4mhykMNvMj
	TKxBfAsLbbjxaRZDferWL6XlbmwuA7nKy63tr1v1QYROFc+Qlg0lDbVecd4KkOBj250NDYCYDsj
	cH0ZcjTnMBdjge7RJe7KDqHLjxnuzVukdT5/es4JNdFrl/87ipz6bcugLtkGBmXKey3mzYxa7sT
	jN3tpjKF+sjg2RiQ41gHPzfseMuw6cmE9keOoKm1dMd6WctlKim9/eyn7oBUpCBpJiuacO7PpWc
	V+xOQfgUp7WDb1BTJmsP0TFWPJOF4nK29dQaitJkayeORYBiQ+
X-Received: by 2002:a17:903:1ab0:b0:2b2:a267:784a with SMTP id d9443c01a7336-2bc7aa20417mr19618195ad.24.1778321455274;
        Sat, 09 May 2026 03:10:55 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e83084sm47335365ad.61.2026.05.09.03.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 03:10:54 -0700 (PDT)
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
Subject: [PATCH v3 2/9] iio: hid-sensors: cleanup codestyle warning
Date: Sat,  9 May 2026 15:40:33 +0530
Message-Id: <20260509101040.791404-3-sanjayembedded@gmail.com>
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
FILE: drivers/iio/common/hid-sensors/hid-sensor-trigger.c

WARNING: Missing a blank line after declarations

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 28d050b45c74..98fadc61a68a 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -313,7 +313,9 @@ static int __maybe_unused hid_sensor_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct hid_sensor_common *attrb = iio_device_get_drvdata(indio_dev);
+
 	schedule_work(&attrb->work);
+
 	return 0;
 }
 
@@ -321,6 +323,7 @@ static int __maybe_unused hid_sensor_runtime_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct hid_sensor_common *attrb = iio_device_get_drvdata(indio_dev);
+
 	return _hid_sensor_power_state(attrb, true);
 }
 
-- 
2.34.1

