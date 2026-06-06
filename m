Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A350337AA86
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 12:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780748281; cv=none; b=WMfg+TRhat12OG3vuQncs3aisVBHXnF6I7Pt4BlbZb5X3hWoppVUTyA0NZgKiZw9VuDSFVAo5gVF3EB8tcnaE3skyDF0vODwPP41tqP2gVrXQwanbJVcPYrQaZ+/YuChhuoWERJfx3z2Z1wXkce0K9o2wZfrdTtsJzxqbjYIhak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780748281; c=relaxed/simple;
	bh=+me19Dlp04MD0yG/JoDnOwbJvtLRmc7KSkMgHI+WBhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nLdWDeN2lSzNIPyftzk82PiABlbhkxQpVzo+LjtLKvzD3RG3ASGxpSKvkZwmEG/A9uLo/m4UWBxx5Jiuazb9/N365IEwKloYnK1f/LKfHCeFvoDOPuouPQpaXlP0QIRLR7pSW616myn6IHTjez2x49CqmVo9TMSR26JvgWo/mkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gl+NjWDx; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gl+NjWDx"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-842848fd613so2293240b3a.3
        for <linux-input@vger.kernel.org>; Sat, 06 Jun 2026 05:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780748279; x=1781353079; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/6G77dJDd4Gc8IncQqcA/KWYZ2vF8mtXNJ4Pfq1nrgs=;
        b=Gl+NjWDxwArBaMZPEayaYuXF5wGFivCpi5d0Aejf3wcD7J1bbzSwmL6QOim4355WQc
         9VyzaAd2VDQEYsJm1LAND7Ov2mnPYG04bqDoWOHo6DB+SxuUAd4epF7/YnOcLB+kplCD
         6FObvueZrbDiTX/n8huxkzGRj3yvY47Fsqmx8Dbh6q98S8mshiBWpxoFB1fQ5b4uxu3L
         cT3fhlGe9a3TwvG99G9vGWWjVfDwMnE907IsxLveSUBGXK6iw3sbUZwaEDJRMN0hhHgZ
         O2zleUbG+p076f6wnNm0d7XiqgwcpCFVWcO3k4mNDGf5bIiKttdpH15moYd8ZT6FmPtX
         SJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780748279; x=1781353079;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/6G77dJDd4Gc8IncQqcA/KWYZ2vF8mtXNJ4Pfq1nrgs=;
        b=ioxGZ0iEFgi5Olx/R99G+WPdqaCwUg371LPtRUItwrw+pXBDfO2aZ8Z0yFAanMAdTd
         AADxC1hyS5yOdV+4+di6C36ApRVKaRkBUiAby8ZhI3E6Q+RzpmrWzWnXzGX2rzmShMpR
         qb4MvSDsCD2kIcW5HqY9g95+thoozsDwEozi1b/JaBZEKNfG2lTDLIbLdiu/bF9/6YNg
         2utVMQs3Jm9v1qNChV2GcD9O5/k52dFwB6h/JqUfm2hnv+dZuOClMHP5C78ECGPS7Zy3
         J5bdQrVQEv5kVVAOqq6eTg4xB/zqGmtyaxCG0XHV8I3Em3bIkk/e9T9y6ylFbA88/3al
         PA9A==
X-Gm-Message-State: AOJu0Yw3mMovx+ZPbgRxbUgUNXTkY0sqMS7hRcLyriHYGhR+dza9CiIt
	5mpOesFOVfMw1Tv/p/nVLK5gQTm3fBXdCuSHAxdmWfnKL8+xHB08y/GA
X-Gm-Gg: Acq92OEQL0yBn6nLw3UPDKdtjryk/vTFkB0rr3pVejFiQRxWbSLtsPNtd1TZLlFt9KR
	JyUaYQ4ksNneFoi2H2hCF5vPKQLEHcwSgUpdnZIxADVvPpSca2uqYoYGtvNKY5pTkiZlFJGAiSS
	oII0f5m2dyWLszwcC8UWHez/WuDR437vfF5lptzgL/3MtBj9KYCuiiHTlH4prybTRqyBwGstxat
	npOSokllHKbwW6/UNPBiupqXkHzFmT9DMmsq3kfAZ7xWmfpfUrU+MBDS9QoQKHOj2FdKG5gw4mE
	rzC//uEK0Qldhwb4tg5w6KOAeaP9iNPKb1kaAlkDF82frYuPLgnjv2y6ZeieMK1vfWyA6eWR+oJ
	voNzs+lz34IU1a1Dfh07OQ38mAhjDf2T0rtw+EFDht32hAipXqkeFsDV5KOnbI8RMn6i8keTa0J
	QFc9KbogNTC61ieEJ73G1AOXnBYGSC8PuR2TX1sq/6Qqzd3exdxiQy5xoRxnc=
X-Received: by 2002:a05:6a00:b483:b0:83e:3050:d0b with SMTP id d2e1a72fcca58-842b0eadfa4mr8204080b3a.1.1780748278841;
        Sat, 06 Jun 2026 05:17:58 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428291ed20sm15253532b3a.61.2026.06.06.05.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 05:17:58 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Sat, 06 Jun 2026 17:47:42 +0530
Subject: [PATCH 1/7] iio: gyro: hid-sensor-gyro-3d: use u32 instead of
 unsigned
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-6-june-hid-iio-correct-usage-id-v1-1-dd4a6820b674@gmail.com>
References: <20260606-6-june-hid-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com>
In-Reply-To: <20260606-6-june-hid-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Prefer 'u32' instead of bare 'unsigned' variable to improve code
clarity and consistency with kernel style.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
changes in v4:
- Use 'u32' instead of 'unsigned int' as driver is already uses that and respective prototype has same data type with input from David and Andy
- v3 link -> https://lore.kernel.org/all/20260509101040.791404-5-sanjayembedded@gmail.com/
---
 drivers/iio/gyro/hid-sensor-gyro-3d.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index e48c25c87b6d..bbca2111e79b 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -177,7 +177,7 @@ static const struct iio_info gyro_3d_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int gyro_3d_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
@@ -199,7 +199,7 @@ static int gyro_3d_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int gyro_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				size_t raw_len, char *raw_data,
 				void *priv)
 {
@@ -234,7 +234,7 @@ static int gyro_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
 static int gyro_3d_parse_report(struct platform_device *pdev,
 				struct hid_sensor_hub_device *hsdev,
 				struct iio_chan_spec *channels,
-				unsigned usage_id,
+				u32 usage_id,
 				struct gyro_3d_state *st)
 {
 	int ret;

-- 
2.34.1

