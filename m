Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB2D32BF3A
	for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 20:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768941631; cv=none; b=a97kVjlPIl8CiVXSh411gFnkA+zYDxBr4NPK0HNaaNWKnQxFpn0kFN50TC6x46f3w1N4mnb4aowG454ezziIEw5d+Ut5RZi4DlUvTBZL614q48LmNtQl6aFktfw70x6ul83EHBxER8c/d0cJfqJowgPiQElikFF3eFdcCq6sKv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768941631; c=relaxed/simple;
	bh=0qfc06G3pC0idpJZYHbhnMOizpqUb4hfbQDWZGzoXxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXYXgimHJY/pGWYZBcaguS6d0mbFJWxtweZriUjaoenARUt3wnCeQqlm+Y/p3va9JAMtft5pXjDTZEDZW2TmSSwwKouwhTEfnEDZyQWgsmPk2cc8ENGgSFBDTF3+6mNfBqX2vJ8jihgwpMvwcE0KuEyzQnb3n7tCZEyFG3oBpFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmt9gQel; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmt9gQel"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-124566b6693so8498178c88.0
        for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 12:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768941629; x=1769546429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nDwmmS2g74b2WXKMuCXknWA40CioERDiacGBlXr128Y=;
        b=kmt9gQelGlzaOdbtFS0ioh7scA2YUM06+lbjDE4ZaGIv0BaVdqZQtLYHF5gPVRS952
         LFLV0Sis4z3GDCX8YNL9OABh3O1rvhGl8eSdl7o9m7h+Z1D1KRonZ87leyowarHjKiOJ
         76fmFh72n3O9QT455DLXxnxxBXjyl+H4cgu1fAvgsCf7opVqvms3bkDf0jysF0y2PDUg
         M7lb+arG8hza3Kw6O77Slm8Qv5gsrKR8ppiUY4sDRkhshAyJ03lMB0jpqy/tTju55ZtN
         VbWHo6Fj4DTdaQgZpUXes0IJt4gjbHTm6RmPiEMH4J8FTol8V5s94TIm12Y7EahTHHZs
         Iywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768941629; x=1769546429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDwmmS2g74b2WXKMuCXknWA40CioERDiacGBlXr128Y=;
        b=FsWpT7CLZ/OUFgt7p857Svg3GsQqCw1hOzaFKCst975jPY3hnviZLcRpK3H3JWBfuG
         SFcwj/7KWd0lLtmol2INaFs56zKn2rAZJ4cnAT+Y9Kk8x8/aGAHAzij0Mk6B05BrIRSO
         /L6XiGkJ4lMK4UT0H/4fF6L0jIEJT3F4wyagZR92b84msCq7NT2D8UxVghd05QPchoMv
         i8nejTVKcT/g8wqhIY+9EWx5iFe9pNrRRBwgGayDM2yU4luL2DXl8hyzOBuSomOZbbiJ
         FXFk/IsjvCMsHKROMMX82dIt1t7TQLYgWGJ8MC1sTNcX4Zt5R2IO9sisOjFNrGmpiko2
         0A3g==
X-Gm-Message-State: AOJu0YxOBQ0ve2UyRQI+dMEOrRz6+4uzZr/CDO3oWWMd3UpWaod2HUDP
	ZGsieiXBuY8m870ejSyzN8JYPbSX2k3TWNAsKufhBLdjj8nTJXH/3MUC
X-Gm-Gg: AY/fxX4Tsd87kwStgWvJVdh/BM2joO6UAtJ0PW5EdW4yprKq2dInJP8ohZcIzZwYr2+
	y5WvKT7wHgJ38+6f7iNqcS6ILThTBWbsDq0sjEtIczWRMDtMjQ09oULwRrG3TpHCHuTy3bFD0DJ
	L8rh177hMfO1b+mr7MUmwqf6GQ8pDo4Bi1YhDETwXPDpNWIXn0NzFSfagn/FQQdBRR2llw3mgwC
	roXdSqJoTs33M2517PCa3widnq63E1PkI2sU8+WTpfprSK/PO6N16Rp98Xr1tebV2xzlwEn+4yA
	wdl8zkKS4LjWwufJRUk9SJu3wIdi+CorDv6+AmP/oRAhzg/1JBdUvVbTqXtv2lMcd9oZZfA3h/F
	aXMwB5PYdPONx1cvKbiJxLKAIESzZiaH9NR9ZsG2rvd4DZU3+7P+ko5u0aOGoSVGSOZtMNt7SjB
	UooyTPhpRSC8/+iFC0GD8P8KMI9j5OiQY8Gdz7IUrFhFUTeqhndBpS
X-Received: by 2002:a05:7022:e28:b0:119:e569:f262 with SMTP id a92af1059eb24-1244b3359e7mr13792959c88.11.1768941628780;
        Tue, 20 Jan 2026 12:40:28 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:d631:e554:f0bd:4106])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244aefa7c5sm23139396c88.10.2026.01.20.12.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 12:40:28 -0800 (PST)
Date: Tue, 20 Jan 2026 12:40:25 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Input: wdt87xx_i2c - switch to use dev_err_probe()
Message-ID: <u5nsup2neifb2k3ujtxtcnwzs76ieqdwjr2o45eu5uhwwo3dhw@cjyxn43etrzm>
References: <20260113082445.44186-1-andriy.shevchenko@linux.intel.com>
 <20260113082445.44186-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113082445.44186-3-andriy.shevchenko@linux.intel.com>

Hi Andy,

On Tue, Jan 13, 2026 at 09:22:58AM +0100, Andy Shevchenko wrote:
> Switch to use dev_err_probe() to simplify the error path and
> unify a message template. With that being done, drop the now no-op
> message for -ENOMEM as allocator will print a big warning anyway
> and remove duplicate message for devm_request_threaded_irq().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/input/touchscreen/wdt87xx_i2c.c | 24 +++++++-----------------
>  1 file changed, 7 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/wdt87xx_i2c.c b/drivers/input/touchscreen/wdt87xx_i2c.c
> index 99636d6eb0f3..3bf899fe615c 100644
> --- a/drivers/input/touchscreen/wdt87xx_i2c.c
> +++ b/drivers/input/touchscreen/wdt87xx_i2c.c
> @@ -1033,10 +1033,8 @@ static int wdt87xx_ts_create_input_device(struct wdt87xx_data *wdt)
>  	int error;
>  
>  	input = devm_input_allocate_device(dev);
> -	if (!input) {
> -		dev_err(dev, "failed to allocate input device\n");
> +	if (!input)
>  		return -ENOMEM;
> -	}
>  	wdt->input = input;
>  
>  	input->name = "WDT87xx Touchscreen";
> @@ -1060,16 +1058,15 @@ static int wdt87xx_ts_create_input_device(struct wdt87xx_data *wdt)
>  			    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
>  
>  	error = input_register_device(input);
> -	if (error) {
> -		dev_err(dev, "failed to register input device: %d\n", error);
> -		return error;
> -	}
> +	if (error)
> +		return dev_err_probe(dev, error, "failed to register input device\n");
>  
>  	return 0;
>  }
>  
>  static int wdt87xx_ts_probe(struct i2c_client *client)
>  {
> +	struct device *dev = &client->dev;

You introduced a tempo but used it in only one place. I dropped it.

>  	struct wdt87xx_data *wdt;
>  	int error;
>  
> @@ -1099,16 +1096,9 @@ static int wdt87xx_ts_probe(struct i2c_client *client)
>  	if (error)
>  		return error;
>  
> -	error = devm_request_threaded_irq(&client->dev, client->irq,
> -					  NULL, wdt87xx_ts_interrupt,
> -					  IRQF_ONESHOT,
> -					  client->name, wdt);
> -	if (error) {
> -		dev_err(&client->dev, "request irq failed: %d\n", error);
> -		return error;
> -	}
> -
> -	return 0;
> +	return devm_request_threaded_irq(dev, client->irq,
> +					 NULL, wdt87xx_ts_interrupt,
> +					 IRQF_ONESHOT, client->name, wdt);

My preference is to keep "if (error) return error;" even for the last
call when there are multiple potential points of failure in the
function, adjusted.

Applied the updated patch.

Thanks.

-- 
Dmitry
