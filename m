Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEB325334B
	for <linux-input@vger.kernel.org>; Thu, 12 Feb 2026 17:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770917336; cv=none; b=DEiC1mnQtp6j59wqzFUeHOJumz7/5as8pTshhxxjEomUg2vM7vu4PHZ/hNcoxf+P8q1ZW2/1HV/yQseZSgoWdO9F6AgLXIxJIzLqzJ+dnI86VvBhX4/QKT/SrJChMbqgPJj0GbIwcfyv+mb2thPD8VlIC6nilocSBcene4IIFgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770917336; c=relaxed/simple;
	bh=GEQ+K5R4w+c2MSnOGLqtZrFgtzydQKPtQDM7+ucRvr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yqboa3XyldzMhi8E8NPtjKNSzOG7Ymmvas5RQBi/bbQJcd+bWh4mLgySz3YJbLSy7Ghmzx2mIagMBMghQju8eicVRSvYuoMvZGlwGe5Ik1uXNaKriILycg38Lx8gJLjnZOKEil1c9qtFk1VE0cBom274ps2oVyT1HwaG9H/+NLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYyGp6+i; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYyGp6+i"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-126ea4e9694so151611c88.1
        for <linux-input@vger.kernel.org>; Thu, 12 Feb 2026 09:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770917335; x=1771522135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gb3qoKX+TkGp8ne19Z/SaQjM0YnFM6856sgOcj160U4=;
        b=JYyGp6+iEcbix/PA4MxkzmL3L9Yz3GF1snlnZQxpzuQLckKBhRi8xs/XSXy+BLkIYt
         KaR1Muo58v/vsKAF6bxXgNtjvmiYkSoj8MFo8ckgueGpiStzk4XgOnvggSNXM77qLCfC
         XA8VNJnspjmXxeSZKVRztIKhu6Qn3vi2NRgRKd5zAaQ8n93+o4QH+22a7L+M+8nFrmf1
         L/Kblkbz8amjbVU1eohC0AdEpeRru7FCZrVwkfrkX6njH/ExOPfJJWmZtarlXb2hIjpb
         EaPSycoZAG+QrhWh+v/CLnXccY7C4f2OAmHSdukShAOqEjjXAkmGzycNITrdcZ2rYtnn
         Xg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770917335; x=1771522135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gb3qoKX+TkGp8ne19Z/SaQjM0YnFM6856sgOcj160U4=;
        b=jRL3B6oo2WwhmmD+kjEwGvVxBYN/ARN88hI/DnWwgRpiyMyZlTxyjERn7tmIBBweU8
         HaPcUQXEeiqL2rQfsroUvArZ/0galoxJX0+EXO4nKpB2WNMTEabJZuQOccl1SrzXEV5S
         GTmCHUj5Xwi6Y00utH7+dyfmbb0wDg3sbIoGweXrCBnsaMp1Jo+4uu6M1JBZcor7tAA/
         p1l9zuQ9gclZQkYZXjwwCAItwQPhGIiuNVpfYT2e81xUKDVNFaWdhZxVIqyz3hTYEm74
         9tbVpmz8TdnCeSvlUDlwm04kP6DR+VZXCw8+9b1c7PuLiZoSkvzQ6+LI1rs7XAhlS1lU
         ibEA==
X-Gm-Message-State: AOJu0YyCCTrp99R17X+01WOIivMyoHxScXiBq0kFwumhmzGd8SPSPWXu
	j8DQzX8ORxR0MKxupy3sOayCGPQK42WZNUYE2H1N63Trover6I4LqtnXY6wWuQ==
X-Gm-Gg: AZuq6aK56W+TFkC90af1ovClVb0YDD/HoyDDBpoPVDZZKhmNStcptuJiyId8wCReh5o
	E/a1jF8L8hurIxpLeQNef7X+r5fPpwk/diXNVLQB5fIHR8m6wB5wCvAw436B25gdeqNPtZyIY/1
	7gp7r+u9RznVdaEp5/GaNeOAllvtTCnm+W3XRItvkRoPqGO8+xzQVUpzALJeNRNgcr7QRQBArP0
	m8ht/KaV464dvTasdFz+qr5Y1diUzh+pInjpTIHC+N1irG6Vfrg4UK6GC3Yx0mkh9qEVPobi1JG
	MfoDLU/5g/Fnl5Tq366kFgKXz+RoESJQMw4xGq6CUxOiLP4FbmUOq2E7qif5NEm+wLxIPtrYM4g
	a5ULJ6mWC16UDegYvmRqIIsN+GKteO1JW6WMJrmWrxKSgfo9PJqpkv2qtMnACWiui+RgTKBx8yA
	hNvnCJ4ghDET8Xx+gALGsIfNq8Lp0ePU4nLN0JZthvt52lVsa/VShCTqWHParPgPgJ
X-Received: by 2002:a05:7022:6287:b0:11b:9386:8263 with SMTP id a92af1059eb24-12738685d39mr70399c88.48.1770917334460;
        Thu, 12 Feb 2026 09:28:54 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:7027:6cb0:48e2:2882])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1272a6fbb25sm5827839c88.15.2026.02.12.09.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 09:28:54 -0800 (PST)
Date: Thu, 12 Feb 2026 09:28:51 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Yauhen Kharuzhy <jekhor@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH 3/5] input: drv260x: Check the device ID at initialization
Message-ID: <aY4NfZm80ofkxzNW@google.com>
References: <20260211235902.4156624-1-jekhor@gmail.com>
 <20260211235902.4156624-4-jekhor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211235902.4156624-4-jekhor@gmail.com>

On Thu, Feb 12, 2026 at 01:46:53AM +0200, Yauhen Kharuzhy wrote:
> To ensure that the device is accessible on the I2C bus, read the status
> register and check the Device ID field in drv260x_init().
> 
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> ---
>  drivers/input/misc/drv260x.c | 44 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
> index f613c81fa2ba..f08a3d6c3ed8 100644
> --- a/drivers/input/misc/drv260x.c
> +++ b/drivers/input/misc/drv260x.c
> @@ -56,6 +56,13 @@
>  #define DRV260X_LRA_RES_PERIOD	0x22
>  #define DRV260X_MAX_REG			0x23
>  
> +#define DRV260X_STATUS_ID_MASK		0xe0
> +#define DRV260X_STATUS_ID_SHIFT		5
> +#define DRV260X_ID_DRV2605		3
> +#define DRV260X_ID_DRV2604		4
> +#define DRV260X_ID_DRV2604L		6
> +#define DRV260X_ID_DRV2605L		7
> +
>  #define DRV260X_GO_BIT				0x01
>  
>  /* Library Selection */
> @@ -305,10 +312,47 @@ static const struct reg_sequence drv260x_erm_cal_regs[] = {
>  	{ DRV260X_CTRL4, DRV260X_AUTOCAL_TIME_500MS },
>  };
>  
> +struct drv260x_id_map {
> +	u8 id;
> +	char *name;
> +};
> +
> +static const struct drv260x_id_map drv_260x_devids[] = {
> +	{ DRV260X_ID_DRV2605, "DRV2605"},
> +	{ DRV260X_ID_DRV2604, "DRV2604"},
> +	{ DRV260X_ID_DRV2604L, "DRV2604L"},
> +	{ DRV260X_ID_DRV2605L, "DRV2605L"},
> +};
> +
> +static char *drv260x_get_model(u8 id)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(drv_260x_devids); i++)
> +		if (id == drv_260x_devids[i].id)
> +			return drv_260x_devids[i].name;
> +
> +	return NULL;
> +}
> +
>  static int drv260x_init(struct drv260x_data *haptics)
>  {
>  	int error;
>  	unsigned int cal_buf;
> +	u8 id;
> +
> +	error = regmap_read(haptics->regmap, DRV260X_STATUS, &cal_buf);
> +	if (error) {
> +		dev_err(&haptics->client->dev,
> +				"Failed to read DRV260X_status register: %d\n",
> +				error);
> +		return error;
> +	}
> +
> +	id = (cal_buf & DRV260X_STATUS_ID_MASK) >> DRV260X_STATUS_ID_SHIFT;
> +
> +	dev_info(&haptics->client->dev, "ID: %u (%s)\n", id,
> +		 drv260x_get_model(id));
>  
>  	error = regmap_write(haptics->regmap,
>  			     DRV260X_RATED_VOLT, haptics->rated_voltage);

If the device is not available this regmap_write() will fail so I am not
sure why we need all this new code.

Thanks.

-- 
Dmitry
