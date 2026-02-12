Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585CA23ED75
	for <linux-input@vger.kernel.org>; Thu, 12 Feb 2026 17:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770917696; cv=none; b=bAYZLIe42x0eudxgtJzEJGz9nSVUVgLaGzLICK7vT3Ybby+OQIqFtaGH9vxMTXZD4RCgIVT1ECp+o0LdCgWw5jzS4RQ5X4kkL+lwZSdFhgNwJEMuYLPZEiI3jITU1TnAp3KJrTGMhGnZYUcfkjSwpBiLUC/Nus0gWL839sDvv9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770917696; c=relaxed/simple;
	bh=zkp3B0gIbfLvHN/pLycxBkbu8Wk9slRdsqiTAwHW5ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqPnZIvfT74EOyvoroQ52Znqn8iYuNM4tWhVQmOnr9MlBx2eNX1G8d6aqdaxgQ5ZUALtHWl9R3oGTBvefWUF/L3WAM5BRAKPQl1AlZDeVRB0vSbgPP1aUjO2eesTWpAAsq53rsPZZsRZ0OK7py9e+SMe0kg7PDP60a3uTP+QVMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dA+wdKEc; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dA+wdKEc"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b785801c93so101505eec.0
        for <linux-input@vger.kernel.org>; Thu, 12 Feb 2026 09:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770917694; x=1771522494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PMM4sBDT61PMWPYsAipBDQlJ8h04IgnR2ES6PRKkXVc=;
        b=dA+wdKEcABJQ1ho+WQXpf/RF+D72KTzWZ5ooQDtLMzmfmom58zat8VMJsKp0J4PVVK
         PRJiuQaz/SbM4dhXcn+Nzsr/lJpYU7mOjjdBUyspnCEwCyhj8Gqv+34bkLXTyPeqWm7l
         sM9Vw2CCR+m/XDLd0cimPwO+XFWHvIEwNG2WaERZ+lcGGF3gvPz3xC/ZlMxUDFpOb23w
         DGo8BhJ++IF2ygzzqIOe+rp4iHLtFDp/eTcWng2d6Tpaze70uSXxS4krz4UcMJzczrea
         eLdZBLznB96mSwMmmAagUwuN+aPPoHfP2cWL1h2IV2pFB0YCCGlZa4WIZ643rYSe76Lm
         jnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770917694; x=1771522494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PMM4sBDT61PMWPYsAipBDQlJ8h04IgnR2ES6PRKkXVc=;
        b=RLUJvnsWBG6l7dqQTHGiEMnlqhrQRtOucIe7nbFpoRz6XJ3YAmNEIZCHOkjY4Hr+tg
         b9fhZEhFppQTwqKrM9r8S33lX9kiam+Vz7o8fS+Nl6pQb3m31StiWO7OyAMkSUpiTw6K
         6QcWee+Cai9X4rfFIQP07hHJ3I/b8VwOCcZncuAs8py4L7EGgNacF2VPKUjtagfSOJkj
         9xBvctYED81Eu7Q6YYWCs6rMdXjmmS8bGdfDJ5V02UCEGSkLgzDbwjZsHL+m0KHS+VvH
         JeyK9L/TmLC3Epy1MBhDzKLnmTLgfdt0raf7wMvbUVIc1EhHNmMSgDA457zXAfXgz/BK
         kGLQ==
X-Gm-Message-State: AOJu0YzSW4QFGn5FZY7PRIh6f/qbvikrpMQcOSxTfc4h0VIAQOA0MPGT
	1uxP9tTPZjllFUZGIiUOiY9gE4kxI/q8wYhS3FOCWBtZfe2hRQmj4+6h
X-Gm-Gg: AZuq6aIpl/TAOm6mlHGFk1u1dLpcTvp/0qPWgneibwpiXYCEowdGa/bg9W8q7wZhvMD
	rHcHPo0cow6+BlHA8GGZPLiE6/aZ84WrWGlycbJyygDveOKQVeDRj+r4/CdJBxsh2CgEcUhObdc
	q7k1x5LCLldvIU5DMNofjcHrO1n98B4VDU9Qa7JVS7CZu5sdeFFpBvZTj4LKsmz2f+YQGxe5sOL
	l7dDVMUjAq3tdVrOE5vdMNuY7JLCQdAjsL8vdUWJj7pabTjfYjXbGAEoLjCn45tYP8o6c1mPjdT
	GUhBncTNGgLIdhZeBaoPadGh209mP+UygB9POTWqGcCn2GVucfns7XM1D8sKQxzISASXL0PhqWV
	XtqnmEAs5RtzGH1PCEH6hPUrcH1LQ18R051LiUzWzmiupXK8q24PcYguWbwdFwUPIy7ID8oDrMa
	jZILgjxgqmSVFfdLEF8+3sNoHAKej8JXb0PlqH273oBH6xyKeMWZxXuHYAgW7VezsVTe1+ZC1Xj
	M8=
X-Received: by 2002:a05:7300:b905:b0:2ba:8018:cc53 with SMTP id 5a478bee46e88-2baa80ca2e7mr1137423eec.35.1770917694187;
        Thu, 12 Feb 2026 09:34:54 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:7027:6cb0:48e2:2882])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dd00adcsm3870385eec.32.2026.02.12.09.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 09:34:53 -0800 (PST)
Date: Thu, 12 Feb 2026 09:34:51 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Yauhen Kharuzhy <jekhor@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH 4/5] input: drv260x: Stop waiting for GO bit clearing
 after timeout
Message-ID: <aY4OAw_IMeta1z9e@google.com>
References: <20260211235902.4156624-1-jekhor@gmail.com>
 <20260211235902.4156624-5-jekhor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211235902.4156624-5-jekhor@gmail.com>

On Thu, Feb 12, 2026 at 01:46:54AM +0200, Yauhen Kharuzhy wrote:
> If something goes wrong during effect playing or calibration, the GO bit
> may not be cleared after some time, and the driver will get stuck.
> To prevent this, add a timeout to the waiting loop.
> 
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> ---
>  drivers/input/misc/drv260x.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
> index f08a3d6c3ed8..f7bfac6d3973 100644
> --- a/drivers/input/misc/drv260x.c
> +++ b/drivers/input/misc/drv260x.c
> @@ -173,6 +173,12 @@
>  #define DRV260X_AUTOCAL_TIME_500MS		(2 << 4)
>  #define DRV260X_AUTOCAL_TIME_1000MS		(3 << 4)
>  
> +/*
> + * Timeout for waiting for the GO status bit, in seconds. Should be reasonably
> + * large to allow long-duration effects and a calibration cycle
> + */
> +#define DRV260X_GO_TIMEOUT_S 5
> +
>  /**
>   * struct drv260x_data -
>   * @input_dev: Pointer to the input device
> @@ -339,6 +345,7 @@ static int drv260x_init(struct drv260x_data *haptics)
>  {
>  	int error;
>  	unsigned int cal_buf;
> +	unsigned long timeout;
>  	u8 id;
>  
>  	error = regmap_read(haptics->regmap, DRV260X_STATUS, &cal_buf);
> @@ -442,6 +449,7 @@ static int drv260x_init(struct drv260x_data *haptics)
>  		return error;
>  	}
>  
> +	timeout = jiffies + DRV260X_GO_TIMEOUT_S * HZ;
>  	do {
>  		usleep_range(15000, 15500);
>  		error = regmap_read(haptics->regmap, DRV260X_GO, &cal_buf);
> @@ -451,6 +459,10 @@ static int drv260x_init(struct drv260x_data *haptics)
>  				error);
>  			return error;
>  		}
> +		if (jiffies - timeout <= 0) {

time_after()

> +			dev_err(&haptics->client->dev, "GO timeout\n");

This should be a warning, not error, since we are continuing.

But actually, shouldn't we signal an error? This is probe path and if
the controller does not ever signal readiness I do not think we should
pretend that it will work.

> +			break;
> +		}
>  	} while (cal_buf == DRV260X_GO_BIT);

Thanks.

-- 
Dmitry
