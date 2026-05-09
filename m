Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85E637BE89
	for <linux-input@vger.kernel.org>; Sat,  9 May 2026 21:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778362559; cv=none; b=jp8kOPs1WaLHXxuesFSkVExzcgDg8OP3UylyG45qvakHDShRkgnJQ74I4riUhCiS+i06kqDrrfbaCPd3Uj2NZINT82FKQGKBCEBQOU3/HiZ350AUz8sKXLnEdXqHPxa7sSpmrrwfHoM3vwE6VPPVRdZkru/AZgRJB0f3bhDd+Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778362559; c=relaxed/simple;
	bh=J67uTUzOtJv34a1o3K1+pm6HLFFypjoFMklnf6FHSa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O40GOq5HtzC+5djUQoeOo3+sAXJTu4kHqhA97zDrth48eHu6autS+UbiDBqzz+32SCIoKUQaWNoqfPv8wVPqaamP/GLrPYKp9gvr80l+ID3VVYgIq/3U/whTzPSUT1lFFw69LK+mZp0bhRUZXnXGVs51lbsgLjBZXiewKK70/3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=ahvZ3RAg; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="ahvZ3RAg"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7dbd23bc684so1897578a34.2
        for <linux-input@vger.kernel.org>; Sat, 09 May 2026 14:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778362556; x=1778967356; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E/ekXA5bmU61aG7UyRq3M0hlEU3MeLb60TJwuJg45PY=;
        b=ahvZ3RAg9YmKWyMxux+4iay/owfd3ZX+hm7wP/IpMuo9Xm+S2Uyz/uOjQehbfHWeug
         0c6OJauURQpOL4xmdZCdlBZvzSQgEV/eKTHIkyz/WbGfKVf3JX16cPOGOGYJ9KUwAx7L
         8rB3YmzeB7Cc+kzGEOjnT4Hk0EaotqZoPRR2AllEmNAVTbE3T/fd8Q/fjnvz1dtxMD9X
         5/sP6ByZieeDA0rE2AzTk3liukVESii8PsTbqFM6dg2s/rHlBgkzT5Gueb2GEPwrnt7s
         FtjDMbbyKQMUE2YwZDHH9wClCNa2Wnsyv23RmyRUYk/jpvkHkxigNPBpQISHE2Daai4d
         ZJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778362556; x=1778967356;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E/ekXA5bmU61aG7UyRq3M0hlEU3MeLb60TJwuJg45PY=;
        b=intnK4SuXON9LVxz64GAunMGfs86vka0H8E7YhngFnsfeMHCou3D5yJKVRU5vatmI2
         kuPnVT4PgWSTMcMUVH9X4VHcUvw9xKf1ckfpgxkMZ2/uVlFDa0dlZOWTNR4SfTM/g5po
         Fcbv2ig8GzAQmjCQKlhsCHbOrm7MY570JucLnIX0ODB+YGhwUoqakDMG3qbJSSvEkpZz
         OvK/I4wh8zaZJ6iO41jtDYoQfdYgXxRXdqTdlU8oqo3PuMd/ipUAy+339lSFZ/1+RuVW
         M4uXKepFg+1jP+LM3N1OVNC7GI0kQTvcNBv6CDSNq/K9v5jCJLUObGr4pPbYIJmgDUFB
         CPmA==
X-Forwarded-Encrypted: i=1; AFNElJ/OuKoHL61UlmBiMpyvdpIFKToHLGDuHfblyy7XI5C2oDYPc9GVcVN0AzfKH6rVNIlIRtpcVvG77DEA9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdwJq61iFPxGl4jkS3wa/gfPVqqF+/JAR1KTm9ULFQPSBcwCWR
	tBljN/EehQ9hIw240Twakl0H47Jh3P1iPVCaiJpqomX87066QsD7OLtCGZFCVQP7JE4=
X-Gm-Gg: Acq92OGhVgXexTI2vLGRYnMO1Sy0skYZFFEuvyobaAyPmw4aoZB1dThcu8Nuo2az7fg
	u9ydIR2Djo8YV8xpeT9bKQhbw3RlG+WHI3bISiO7kBEaOhZ4zSGE/d7EbZBH9npsHJ7V5evqUBU
	RgiHtkY61pd9LlVo2ErivYU9EDraPKla/oHr8/NL4EgOdnLijB3rwyDjpi5KdziS9CrqBBgUMUD
	xltG1yvi8SVlc0EEHKHN3+LZyseJyB0ERwvRBT9MENdnhfMwYZS5NDH/eKXsOLewpdmXg5WlMht
	9Z1EDHTDP8LJEnfnbTTbTl1Rs1LDkdO4yEIObGzbJHjoMFkonoiJo9/nDEY1TJckCVwhS4W26qt
	Zao97Aypneos1pS5af6itrVnc62nqgvh+wM0B+ghHFN/Vkt2ERLWYnqdhDMfkjPTWC4EfeKbScI
	KW2ejVVCbJdi9VdDW/yrUZSFOE7FpfxK4m0/iRP4e7lls/MAlaHirhPMMmMaN3QKCFo/aqNefxy
	Q==
X-Received: by 2002:a05:6830:2a10:b0:7db:d229:d51e with SMTP id 46e09a7af769-7e381f98af6mr2630712a34.12.1778362555980;
        Sat, 09 May 2026 14:35:55 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3548:c22e:ea52:dbc7? ([2600:8803:e7e4:500:3548:c22e:ea52:dbc7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367c04e00sm3715141a34.7.2026.05.09.14.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2026 14:35:55 -0700 (PDT)
Message-ID: <eb091bdc-3c1d-45aa-aedd-3c9da27f7f21@baylibre.com>
Date: Sat, 9 May 2026 16:35:53 -0500
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] iio: hid-sensors: cleanup codestyle warning
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>, jikos@kernel.org,
 jic23@kernel.org, srinivas.pandruvada@linux.intel.com
Cc: nuno.sa@analog.com, andy@kernel.org, sakari.ailus@linux.intel.com,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260509101040.791404-1-sanjayembedded@gmail.com>
 <20260509101040.791404-3-sanjayembedded@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260509101040.791404-3-sanjayembedded@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/26 5:10 AM, Sanjay Chitroda wrote:
> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Reported by checkpatch:
> FILE: drivers/iio/common/hid-sensors/hid-sensor-trigger.c

checkpatch (or any other linter) says so is not a good reason
for a change. They are suggestions, not requirements. If the code
is improved, say why this is better. I.e. improve readability.

> 
> WARNING: Missing a blank line after declarations
> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> ---
>  drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> index 28d050b45c74..98fadc61a68a 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> @@ -313,7 +313,9 @@ static int __maybe_unused hid_sensor_resume(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct hid_sensor_common *attrb = iio_device_get_drvdata(indio_dev);
> +
>  	schedule_work(&attrb->work);
> +
>  	return 0;
>  }
>  
> @@ -321,6 +323,7 @@ static int __maybe_unused hid_sensor_runtime_resume(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct hid_sensor_common *attrb = iio_device_get_drvdata(indio_dev);
> +
>  	return _hid_sensor_power_state(attrb, true);
>  }
>  

