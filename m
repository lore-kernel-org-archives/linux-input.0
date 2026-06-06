Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC57B3859D7
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 11:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780745882; cv=none; b=IGlXufmbY0QTCj/8LCCx/pIf47Xx6fS5xGXsaTBGzPg/VGZ9J67lhWgoKFhwGpUv8z1j3HR4fp9FW8i+GfGxKd2osNzQpb3aeJS7AJPsUQvaVc3m8zM0ey/h2QzmVSL6E6pXLOvzY9DYMe/+vMtXWR0yHp2WmneirVm5MvKcaXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780745882; c=relaxed/simple;
	bh=PdUKDn3SU2eJys++eOMc7I+5A6p9MCo6ZvhZceIqZWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ifdm1rK0XSHWyGyBsqWZUxYkDW49kmzqPgTdE1v6tFMQoccJjxTH+C3sF+ASofT9YVEfZ6SFxOt8vAjJPp1to617QQXLVXVPqXnGKKnDUANrNNwB+cf2dif2SbFEekeubXNjKTrOsLb7B8h5Lpv7TYyBQnOouW7ouZHDOuxFGd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqjJR3/j; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqjJR3/j"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36bcf3d2565so2028286a91.3
        for <linux-input@vger.kernel.org>; Sat, 06 Jun 2026 04:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780745880; x=1781350680; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HWSBV5t7vgvzy5zfpTiogfYypqNTbSS/3Dq6vr9fHyg=;
        b=VqjJR3/j2Tfrd6YUdIrUSHIG5wkOORUZYKJQUlj4mEYiiHx9O0SJ/J1dRGnlJpTbw7
         VWcIUipedQFTp8znqFIXGXgw6GlB8BGcCymZyvEW5g4m6UpPrs6PD5pEI3D/y+nsDpyv
         Rzt1EzOtf7JDBxUyRHkJOvwnS2jbsv2ZHW8QywFqfqlemvEoqacgt9gSDS8zALr0UNIv
         ozHNu+eI8Qd3HVgDrhgwiT7tLXHelwqB6BSj/+1ZKXE4SUU29sKfNe1Lu1yioMTDNeFd
         XJozQ2ooSsSoT64nJPVFXPr6tuRBwDopBFDFBY4P/XatrCgbiXMuadCf6uqdZg/Diyrj
         kYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780745880; x=1781350680;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HWSBV5t7vgvzy5zfpTiogfYypqNTbSS/3Dq6vr9fHyg=;
        b=ReVTmV34DLv7cJdk0Er8UDhEVGdlAcr6te4yVIivWpN1E20qE98cFRpVgL5sOS6sO5
         O1QT+TMvEuNHP1XBMYVIg86bTudo15mPk7so52O7QIqZ99Pczk7S+aelRGOi1h/0n16Z
         mS5/RSHZYAjzQEgX3tih9PuRn41fL7t4KVYyXHCdRtTNDrQMafFHKNYpJRaPNo71SL6f
         UnWOxSrbhxY1Vuta4e5DpllqLFdsgUfW9n5KBH3xsm7A3CZr1aZRyOE91VtX2/4vrE+d
         0SiaMHgGhfX3IX32IlE8WAXxAaJXkBX/DxX95OdKrShN6iTe5/1Vq5rS+HRFPwLhitrm
         oMbw==
X-Gm-Message-State: AOJu0YxgG9oT8EHYWreC+yBKIKa03Wb14MmH8aU9AQSPWJ6t8+fbZbeR
	IvehuuG1568VTLLbf8Oa54mHrxW+rp+Lf9ToD0sc7T0YHo1/+l3nM53G
X-Gm-Gg: Acq92OHJF7hP4qDXUifIoC6Ty3iQzCbcqCsq/0aTn19mVpukmTksv6v3BHr/KYVpsOE
	bGeJtufJYxesVU3JDgxWGV6vssgYv6f839Hb2FQ5xZDC6eNJ+4aEjrXkXlwIXxs06pU6JvxX+b9
	P6jh4LmAZ93u2LMrxBwK/kugzBjLcNZsFgjJQlXKS0FPqYKRTKRqNkj8YWC4VZi1gFEHdDMdM4S
	6f2n24DSgzRuvCkijiNqcKFalDMBBBTXduBz4AEwUzJqn8m0p3gFt8UOrtGxyl/ZBjYrarluCGR
	WUP9YrBmuLvWVBO4qSQCNyPESbTkIkF56mzMqwQFZh4u2QdDVqtxe6zXl88F9yJgVhMpMccrCK2
	mIUh1aNCZg4E9Q0E47g+OeSTEIcYH3ZeLsXwCFqn562hMz09SqvN0QAo1HqAu+9VZE8usrQJcQ6
	VZgXiI6C2XvzdKEV3HvOvHLFRrRY+FrlPK5xQ1FWb27s8SXfj5BgvVb+v3/bA=
X-Received: by 2002:a17:90b:380a:b0:36b:b06c:30a1 with SMTP id 98e67ed59e1d1-370ee447ddemr8402142a91.1.1780745880167;
        Sat, 06 Jun 2026 04:38:00 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-371358615aesm3220830a91.2.2026.06.06.04.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 04:37:59 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Sat, 06 Jun 2026 17:07:14 +0530
Subject: [PATCH 5/9] iio: temperature: hid-sensor-temperature: switch to
 non-devm iio_device_register()
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-5-june-hid-iio-race-fixes-v1-5-27a848c5758f@gmail.com>
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

Avoid using devm_iio_device_register() as this driver requires explicit
error handling paths. Mixing devm_* APIs with goto-based unwinding
breaks the expected LIFO resource release model and may introduce race
windows during teardown, potentially leading to use-after-free issues.

Add explicit iio_device_unregister() call in the teardown path to ensure
deterministic cleanup and follow kernel resource management conventions.

Fixes: 59d0f2da3569 ("iio: hid: Add temperature sensor support")
Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/temperature/hid-sensor-temperature.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
index 9f628a8e5cfb..34bff7e9f3a3 100644
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
2.34.1

