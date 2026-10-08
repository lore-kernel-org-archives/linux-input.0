Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87D03C10A0
	for <linux-input@vger.kernel.org>; Thu,  8 Oct 2026 07:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791446103; cv=none; b=j0O8P7Hahnr0vnGspXUgX/R2YX36Pqz2WYqOqVk6Q+STOpTTCHBTX0Q2xN0tBu9vyBXmqYnN+6op4BCea75BhEuPAfW2JOhhCF101aYESDE0Ra1YSmgTtHlHLPPsS3RSqT3ZKowkTCFrmWBywqNYhQgqKeD5+ds3iKbyaN4TNTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791446103; c=relaxed/simple;
	bh=0sdnIgsW/7O1yxiEVd1NMidwd+7MWbZHjpGHHLdtTqA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ei1aT7mwDBYdk8bexVboB1szP6Ow00nMiJWVq3tTifEkW/7TgOCKiXaGfcoFSr3/waDxf84gpL/wAhunn6vDPSJ0LaJMryNh1GzGhPkZ3RkJDUiJNPvOMIv7mpyO3buX2V8jymOsQnoFvpBDUKc0mF2QUeNkHAkU3mN3yaxMOqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rU7WxcG9; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rU7WxcG9"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a168355946so24437065e9.0
        for <linux-input@vger.kernel.org>; Thu, 08 Oct 2026 00:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791446100; x=1792050900; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ee/nOmTXlnTKv+9t3QjlgWh7DWnVNJTswfF5DULCt7Y=;
        b=rU7WxcG9FQ0WfjIRwN1QBSLd274UzEmREVCwG86VNZzOQmO8RPn9nEwshv1ingB29r
         0PYo8nHouyZqKjpxwUniaw0Q1frLN44A4iCnB0GSPmqUU26Y9g1p4V388xwZZ5lKNxlM
         +28usrukC8nX4XDcLGN5p9H040pWwYFazZyi7R7pRVeRsKyTvFQk+bG3wbgw6rHoEBgr
         V8+EfHtLjTzet6Hlf2iricUGa+06RiMPap1ksxPcMF4kYjE8+YLf6PbcXEyBFsK9E0Hu
         Lb9X8JuE1DJgofXm1V1jcyouRR7iHGnMEjox1ekaezJRPn1vcS0dnwfLAKS36t7C5Jzj
         6ThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791446100; x=1792050900;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ee/nOmTXlnTKv+9t3QjlgWh7DWnVNJTswfF5DULCt7Y=;
        b=f0ToayejAIJ92ndE8+WUtdB9Cc9R83wdIYcLy4eP0ON14zlPsG2Ol/oVeaYijLzAWc
         fMR8U0OQTsHHR8RyHDf9bhPwre758FYm2w7Cf7EJNqlPNKvZ6L3EWH9qp4iLZC9R7Dgg
         KFrVRzzjDICcZvqEAkkagh01sXGQqBWcgCdNRgdQK9EXiCdhjBfRJwIru8dZNuK3myAG
         GoF7dabdhjTts2fW59rl5vvfd0tESx8zwnb63lCRoge1IFmkZxvj5FwLbFDCelxhbM2z
         pC5vKPDGLqx+tMFHYJwR7Lzh2DRVYrfK6mnreG91mTJmKYn+a6351aBn9ZrmG+awWeaF
         eNfg==
X-Forwarded-Encrypted: i=1; AKwUvBz0fKzlBoiqjqKoL2WIoyR4RBAMEXAKewHS2mnYsnZFogrqN209rDs5ZT8NyPasqdeX2yuADt30BrOO/g==@vger.kernel.org
X-Gm-Message-State: AFuF++lqmKQ6/H6SnvjUMGx2pxOFZcOW1OMwmfJj8LjJE3MFhEaRZI3c
	Pc03nXMXsiX97YSa/7/hMi/qjoYaXney2TOrsSuV9F9L4g4C/PWr77cZ
X-Gm-Gg: AYBFou12PAAgfZrMuseJZe00+a3QA1nSd5rPPGQWWA9ATR/+leNGxIVnWwE7gCYoqOa
	VOr72UrBxsPorggtb8v07O0Ovr8KpeLLL9is6C5y/FxkmbtuHr42M4WSVSFJm1c8ZmbUVNUrUzl
	dTeXkYIWwcyFWftkAYRpP3/otY/L6FCdECfLIMCi5jJleDmjoJBLkShZiaVWobfCa9Z0pQKx08o
	Swrpo8pXH1BQVL2U7GWFZQQS7z6xRrmN8sqy3n2FIn1Ol+/OZ5xNrL38Y2YAWiUg06Nb8BVSUQZ
	GyKnZeNZjsaQAjW0KzFdaQ2Ok33R4jm5xEKH+1X22M++cp45ruBW3Txonc4a8fjHiWK8bu00xCK
	VIy4H3umP4t8cewddwePFaz88djYl/S4bg+FPwJadp5/z+x/IJ8/9G7z1i2ODh8Xf7YYAxYNTkh
	4JOAg3UGqUgRhI2TQarQRaOGKPkcgQSu1N4GVrIamdy42Y66yb79yzFld41ZD/Z24S2BFpeMWPT
	653Z9xxOAZ6oUG7yvFoPKK+kePV7MIUfuRhL6JllB87LRKovBPhdz1/HUHbm+KqatMxnkRr+SC/
	5JDI4daWdWUM/NS0XIVlBs57r/TfvdMtOwZ8ONGtFifKn8WJ5jyDT+NHi8aU0RC+Yh5nkamUdGc
	6WSyyJbv5ad2fQ0ifFg2NeYm9GUyy1hLQEjsT8wdrGypmLAZCozxUXXm4hJFtpzglycsNgKGbAA
	BjqynD
X-Received: by 2002:a05:600c:4594:b0:4a0:1cfd:321 with SMTP id 5b1f17b1804b1-4a180313bbcmr78950685e9.12.1791446100084;
        Thu, 08 Oct 2026 00:55:00 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d1245bsm9635929f8f.26.2026.10.08.00.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 00:54:59 -0700 (PDT)
Date: Thu, 8 Oct 2026 09:54:59 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Christopher Hoover <ch@murgatroid.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, David Lechner
 <dlechner@baylibre.com>, nuno.sa@analog.com, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] iio: hid-sensors: fix shared callbacks in
 temperature and humidity
Message-ID: <20261008095459.000023f9@gmail.com>
In-Reply-To: <20261007184423.622445-1-ch@murgatroid.com>
References: <20261007072329.27806-1-ch@murgatroid.com>
	<20261007184423.622445-1-ch@murgatroid.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Oct 2026 11:44:20 -0700
Christopher Hoover <ch@murgatroid.com> wrote:

> hid-sensor-temperature and hid-sensor-humidity share one static
> struct hid_sensor_hub_callbacks across instances and overwrite its pdev
> on every probe.  With two temperature sensors, reports for one go to
> the other's pdev; once that device is removed,
> temperature_capture_sample() dereferences NULL.  I hit this on 7.0
> with two uhid-created sensors.
> 
> Patches 2-3 make the callbacks per instance, as the other HID sensor
> drivers do.  Patch 1 makes sensor_hub_remove_callback() take
> pdata->lock, as sensor_hub_raw_event() does, so a report racing an
> unbind cannot call through the freed callbacks.
> 
> Changes in v2:
> - New patch 1, for the use-after-free on unbind found by the Sashiko
>   review of v1.
> 
> Christopher Hoover (3):
>   HID: hid-sensor-hub: Synchronize callback removal with raw events
>   iio: temperature: hid-sensor-temperature: Use per-instance callbacks
>   iio: humidity: hid-sensor-humidity: Use per-instance callbacks
> 
>  drivers/hid/hid-sensor-hub.c                     | 12 ++++++++++--
>  drivers/iio/humidity/hid-sensor-humidity.c       | 12 +++++-------
>  drivers/iio/temperature/hid-sensor-temperature.c | 12 +++++-------
>  3 files changed, 20 insertions(+), 16 deletions(-)
> 
> 
> base-commit: 9ee8306121495d2a25aa5d1bfd519f2748786b83

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
