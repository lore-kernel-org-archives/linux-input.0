Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83E73BC687
	for <linux-input@vger.kernel.org>; Sat,  9 May 2026 21:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778363058; cv=none; b=gj6UC79Wsrvq37QOOTCy1aSF7W0T6B7WvWJJYIBpe4HxQoTjCTMk8QnypZ0DDfJVYXq0Qgg9ouxSbw0qeulblrPryQxcHA3aG/QWzmGfk1nTdjo1F12mViqF5HzaCb7ec3Tj45F5swNARiRL80sZXm7C6RGgnMXMkvQIywEK9qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778363058; c=relaxed/simple;
	bh=vB44uZWT3qqtK5DaYAUGs8e/snWfIMx26bui7J+MJA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hqc/JG1LYMnv5LSAnxjYwVq7bPeZCedfmctNDIFqp2ozeV51nul/rR6wZtK4JRdpgX9wRa9Sfc+/08TS5RmG22l5xSdlTdmoerQsebc2i5aqL2LLDQhFAiYC4iuz/ry1vw3L+9YJ3kRXWuyc5UIw+2zjz+4JLRBa1vOKCGbCF+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=ChujKKJc; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="ChujKKJc"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-434d9df81a5so1781800fac.1
        for <linux-input@vger.kernel.org>; Sat, 09 May 2026 14:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778363048; x=1778967848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TXZzTHF7fezizkavi8Uzwn3xe2IHuKW42J4Xgyiga18=;
        b=ChujKKJcaOPlJ2lTAaQCPlqqynTNg6GL0d77Hj8MhUD1Gw2bylO+MtvXXxIew0t0bm
         daVZb7iFoHtVt6te+O8rsfvgx8ELH2GlmXEDkgZKIv9ttX1mjd7bn4ROpAklReJ5sZCd
         KECLl1eJ6H+yMylcGkMxU+rrhHBlrXgTU/1S4qUceTzJqbuww4WsfNIa/A7EZnMNG7Tm
         kex32RzC/YwAV3M0uPQxOVDg7AuLNEQI2qKEAeNXfAExw8f7HPQbvs5o9fL2ItxeIW2M
         /nKKWK7uL0MHjQAJzEhD0G9HmlZ1+0S6XMfoXt2aM7EYjAaqR9Mnv0c6we8pcnxNSOAb
         jxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778363048; x=1778967848;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TXZzTHF7fezizkavi8Uzwn3xe2IHuKW42J4Xgyiga18=;
        b=E+njEMb583qDqTkHo3/FpDRW1mxAk0eGwdCADcc1T7fmXu19EwGWGvyUzwNhDLpxjS
         uUCjfjdedDuj/4dqhMpo/QBV9cDNJ9yZ3JkmQCACnWzDa/VRHMGDtWeMlu4w3Sb5qQ3P
         ohwKp32xxTaIL4lbSW0kAyfC1u2hCpLSNyXcPJFlOdRMbquysDomSs9obK/0pfMVzn9o
         nKwYMoI7cL1U8O+UTTE6nhvCsL6dpm3XlpUE4JWshblBmVMVPlgWrMNzYrWSZfnAqJsH
         YbuqfKX7VBiKr2YSgSgzX4tYX3om11wlod7AsA7iVRqFn6JWvAezM3JbG5stc6eLUbKH
         jUgw==
X-Forwarded-Encrypted: i=1; AFNElJ+Ek7mKMGjSsuoBo/Ga90ImaYeU2JDs+wuqIziYXaFSqFdm7Xcmmv820bbEfCK3/P9IbIyHZMqBNFfIvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFh8PxnAxIBLUAQBoN0eUV7d5zxNELFiS5uwuJ///NDr7Si13n
	XbGeIHcS8LJSu4aLF19BZRP7p2yfzMmy9TMMttJJ987XLj3YdTSIiqQgG5iO2PxtEUA=
X-Gm-Gg: Acq92OEDisYNgW/ZqLi5gUTn3SapfXOxR3z0pc4EuC+LLEWUEtciEwynxeGVqsQbFT9
	UlQMHBR98Y70SUNiC5k1vYX/nuzhOnYj2c3VNqOm/PHIq/2lGzAhycKdjg/QSVpxYSKl9oOID4b
	d8hkKZl/bbZVItdXGw0sNpnDoj1yikvbqQwZpRDTFyZM/DXQN4FSYt70SafCOtza0kXKxC6hoHY
	nkFdDXMz49JkVKd0415O4ueUe9SFMlVOh98Dlu9TaCjuiZXi29GkwHj4fIfgAlz9fCiEL9JN+9u
	2/5t5xJdeIOG++A3WdvAVApgE2pjZj/hkMg42uJxq5ABR/AJ6sPYE/QuI+k5a8BhxLCRJGv/1h6
	8LUH8xbZ7Ld7aTJ9/Z6JzQiDmVHn2BkdkisC6GZBpAc6aQzjFxDenosHS3caVZTyXr4odu0cnUY
	rYD/DGCt7T2mbhetWzTF0yqts0u+UuFqP43F1WE5xjxojvAlsJ4Zg8Z/U9rg9Cy1N2d8PN2QSYg
	w==
X-Received: by 2002:a05:6871:582b:b0:430:3ddf:9712 with SMTP id 586e51a60fabf-434f68b5252mr12449477fac.5.1778363048264;
        Sat, 09 May 2026 14:44:08 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3548:c22e:ea52:dbc7? ([2600:8803:e7e4:500:3548:c22e:ea52:dbc7])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4355710cfccsm5715160fac.8.2026.05.09.14.44.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2026 14:44:06 -0700 (PDT)
Message-ID: <d16fc10c-c9d0-4e2f-9e1f-bddf0a955fc6@baylibre.com>
Date: Sat, 9 May 2026 16:44:06 -0500
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] iio: introduce devm_ API for hid sensro setup and
 cleanup
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>, jikos@kernel.org,
 jic23@kernel.org, srinivas.pandruvada@linux.intel.com
Cc: nuno.sa@analog.com, andy@kernel.org, sakari.ailus@linux.intel.com,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260509101040.791404-1-sanjayembedded@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260509101040.791404-1-sanjayembedded@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/26 5:10 AM, Sanjay Chitroda wrote:
> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Key highlights:
> - Prepare change as pre-requisite for devm conversion for HID IIO
>   drivers by removing redundant argument
> - Add devm API to setup trigger and clenaup resource using
>   devm_add_action_or_reset()
> - few cleanup and prepratory changes before updating driver for devm_
> - few sample driver update using devm conversion to auto release resource
> 
> changes in v3:
> - Added cleanup and prepratory changes before adding devm_ API
>   conversion based on self review: 0002, 0004, 0006, 0007 and 0008
> - Address andy's review comment on commit message and coding style
> - v2 series -> https://lore.kernel.org/all/20260429175918.2541914-1-sanjayembedded@gmail.com/
> changes in v2:
> - Following input from Jonathan and Andy, squash initial patch v1
>   series in single change as individual change should not break anything
> - Add devm API support and two driver using the same
> - v1 series -> https://lore.kernel.org/all/20260428071613.1134053-1-sanjayembedded@gmail.com/
> 
> Testing:
>   - Compiled with W=1
>   - Build-tested on QEMU x86_64
> 
> Based on further feedback and reviews, I would extend this series to convert all HID IIO driver to use devm_* API.
> 
> Thanks,
> Sanjay Chitroda
> 
> 
> Sanjay Chitroda (9):
>   iio: hid-sensors: drop redundant iio_dev argument
>   iio: hid-sensors: cleanup codestyle warning
>   iio: hid-sensors: introduce device managed API
>   iio: gyro: hid-sensor-gyro-3d: cleanup codestyle warning
>   iio: gyro: hid-sensor-gyro-3d: drop hid_sensor_remove_trigger() using
>     devm API
>   iio: humidity: hid-sensor-humidity: cleanup codestyle check
>   iio: humidity: hid-sensor-humidity: use common device for devres
>   iio: humidity: hid-sensor-humidity: use local struct device
>   iio: humidity: hid-sensor-humidity: drop hid_sensor_remove_trigger()
>     using devm API

The series would be easier to follow if all of the cleanups
were first and then all of the new code was the last 3
patches.

> 
>  drivers/iio/accel/hid-sensor-accel-3d.c       |  4 +-
>  .../common/hid-sensors/hid-sensor-trigger.c   | 24 +++++++-
>  .../common/hid-sensors/hid-sensor-trigger.h   |  5 +-
>  drivers/iio/gyro/hid-sensor-gyro-3d.c         | 16 ++---
>  drivers/iio/humidity/hid-sensor-humidity.c    | 61 +++++++++----------
>  drivers/iio/light/hid-sensor-als.c            |  4 +-
>  drivers/iio/light/hid-sensor-prox.c           |  4 +-
>  drivers/iio/magnetometer/hid-sensor-magn-3d.c |  4 +-
>  drivers/iio/orientation/hid-sensor-incl-3d.c  |  4 +-
>  drivers/iio/orientation/hid-sensor-rotation.c |  4 +-
>  .../position/hid-sensor-custom-intel-hinge.c  |  4 +-
>  drivers/iio/pressure/hid-sensor-press.c       |  4 +-
>  .../iio/temperature/hid-sensor-temperature.c  |  4 +-
>  13 files changed, 78 insertions(+), 64 deletions(-)
> 
> 
> base-commit: 39b80c5c9830d12d2d6531059001301c4265322a

