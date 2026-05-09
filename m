Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5447B39C00B
	for <linux-input@vger.kernel.org>; Sat,  9 May 2026 21:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778362718; cv=none; b=KeHO6eRmnCpBsvIschjsdPasIhw7UEQn7/PsYOjF/90xKxNHKSuFVeXskP0xvgikfDtS6u5rgTKBj7b3/As5tlEcvX0WAOQwHeZfLnfi7RS2+ABKyt+DAlaRKiW+tZGDvlW0dn1QNxheKN3kBKYOVUu74W0QaNmOot87QuLR1Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778362718; c=relaxed/simple;
	bh=Lzy8Y02vMM1ra6Kp3zwwNJPUui+pq/nw0dALYSvm0l4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PRWcLaR6hE1pYdRdvfcxq5bS1UtLUT96LQD7GPQK2MGeExPcUpUQ89GN0ZEg6X7TbJLneGjm9/8zEnd9UhLA3TsVNtYWG4WV53bgK5DuKpkgk8g8QRVk+SFhqLzKRle0AUVeMeYj672eHm2HAXjDrHz0LKSJjt8vxRnZOAa5Awk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=UKSOX0U6; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="UKSOX0U6"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7dbec19732eso2773781a34.3
        for <linux-input@vger.kernel.org>; Sat, 09 May 2026 14:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778362707; x=1778967507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0BizQb7RbXQIMM/Ma+be2LYItJpdbh1k0Zyy+TbXHjU=;
        b=UKSOX0U6eXaYON7bUHr9VYIGdJ891J6Kc8Wty0FGF5Xqc57k+Eo+6irngvVRkiW7JT
         RQ1dvKrzjTq4zYBkQ8VCP56LcrJesjzyWmTb0wLs+uKGYDgsQaag2cu+/9sDFX+9uV5l
         nJK3aLhMJ7jVf+5p8r0nORiagfdxeDTFUjRpTN9Aa3QgqndqYuoC296BShNJgiSOTJa2
         6BOCnq7q6HekpYafA5Ff1/M7xfnAoLwoTnfIrG3Zk8cMtoe5aiStBmIsmApjGbVpPN3V
         8nB+iTvYcPPr9F1L0sA/z0KMZoTtixmPZKIrJj+lOaWJchWOZAjC6sDYmuCZpZhu++hy
         wZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778362707; x=1778967507;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0BizQb7RbXQIMM/Ma+be2LYItJpdbh1k0Zyy+TbXHjU=;
        b=Orq2g8sh9ZpkJaLj2xYdZkd0TmdVNkPwKMXNNXRNjwHSZWeGNIFvNpDoMCH5Cmcfun
         dG1ifGjL1zxlnPxTbRZlSu1EZcrE62IMN+RfT0+cxqU50Kbbf79gHN10l5PWkeuFiB89
         E35kZOUAI85KGtwL4G3A+mCBgOajIZPJX0OjQE7X44mCnLlSQIy2Ifht5sNRIdugYqrZ
         W81IpRfRigQOXXx7nQaGkbv/nElDkHt51F4fvbnt9zGyPI1Nr4PBdAQdiQPNAAQVE1Y6
         Suv9fZJpZvxavJqoL6Zg6xz+xWBzpukGo13ahHtCa5ogIeLin5WqJu/AJQWFcapZFrbS
         eu/w==
X-Forwarded-Encrypted: i=1; AFNElJ/DlSxGnBHfuPG9W8/x4Sd9btpN1VVFRtp03GeIh6uhOcVr5YzEVrVE+maf+3XuRBH0O+Wu9bgOuKjWng==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3fODZpQ1Xkva/1f9cSNk5NcbHPCB0muis0xS+X0RWD261KdtX
	fTkMKabQI0W5wun+3CI+o0+0e3qhluCePcPOGvGNjLCOhkQbpT+4X22mzsLvEdJj/dg=
X-Gm-Gg: Acq92OHy9iZlg8Nb4a+A1PUd6rs/K5buXYVGns3bDEJdqN4W3/wx885wwTKjQZw2lh5
	YhXvBCqQd0+npofhtJ/aPMpm16V74zTeRE0HBh/OPpuU+bZYoAQ3tc9Qh9P09P6cjNEV9rLHtpf
	Hy0pNScLKQIjZFhDLvLq28n8WtCJ1yCtVjvEJY7UZBGfbcaiXkI74ahhdsVP5iJNAG9jeeOemtg
	7j+RegCZrDsK4dvxSh+95y418+Fve0a910lhPkOKsYPDDIQBYFFzZyoHN2gNNAXuHXHCwEu0Sfa
	pHAny3OwOM9hVpV92VUB/DLjYtxcFnDzCutYhHgcfCB/g4FIq1/wlBZINoLnDC4HTKRswX9DizS
	LhWGV3RGeTJqs6wz2zlYTjxAQkWffR+RFFyhKRCxvz97cXjZAbnIprpmk8RGV6hJoaKD4HPvuic
	r7k63SObwmXr4e0VzeE29Ird+5XvnpcJb4+oEKvJjQvRwoylsHI9v1PICQWGoXTv7lbOPMBWPWj
	g==
X-Received: by 2002:a05:6830:600c:b0:7d9:b58e:55ed with SMTP id 46e09a7af769-7e1df137a49mr11616808a34.25.1778362707189;
        Sat, 09 May 2026 14:38:27 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3548:c22e:ea52:dbc7? ([2600:8803:e7e4:500:3548:c22e:ea52:dbc7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367c0bc16sm3723179a34.12.2026.05.09.14.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2026 14:38:26 -0700 (PDT)
Message-ID: <16811995-2371-4f4e-add8-76b5acc30f53@baylibre.com>
Date: Sat, 9 May 2026 16:38:26 -0500
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] iio: gyro: hid-sensor-gyro-3d: cleanup codestyle
 warning
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>, jikos@kernel.org,
 jic23@kernel.org, srinivas.pandruvada@linux.intel.com
Cc: nuno.sa@analog.com, andy@kernel.org, sakari.ailus@linux.intel.com,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260509101040.791404-1-sanjayembedded@gmail.com>
 <20260509101040.791404-5-sanjayembedded@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260509101040.791404-5-sanjayembedded@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/26 5:10 AM, Sanjay Chitroda wrote:
> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Reported by checkpatch:
> FILE: drivers/iio/gyro/hid-sensor-gyro-3d.c
> 
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> +                               unsigned usage_id,

Even better would be to use u32 since this driver already uses
that type.

> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> ---
>  drivers/iio/gyro/hid-sensor-gyro-3d.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> index fe663b19e902..87537f9c58fb 100644
> --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> @@ -187,7 +187,7 @@ static const struct iio_info gyro_3d_info = {
>  
>  /* Callback handler to send event after all samples are received and captured */
>  static int gyro_3d_proc_event(struct hid_sensor_hub_device *hsdev,
> -				unsigned usage_id,
> +				unsigned int usage_id,
>  				void *priv)
>  {
>  	struct iio_dev *indio_dev = platform_get_drvdata(priv);
> @@ -209,7 +209,7 @@ static int gyro_3d_proc_event(struct hid_sensor_hub_device *hsdev,
>  
>  /* Capture samples in local storage */
>  static int gyro_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
> -				unsigned usage_id,
> +				unsigned int usage_id,
>  				size_t raw_len, char *raw_data,
>  				void *priv)
>  {
> @@ -244,7 +244,7 @@ static int gyro_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
>  static int gyro_3d_parse_report(struct platform_device *pdev,
>  				struct hid_sensor_hub_device *hsdev,
>  				struct iio_chan_spec *channels,
> -				unsigned usage_id,
> +				unsigned int usage_id,
>  				struct gyro_3d_state *st)
>  {
>  	int ret;

