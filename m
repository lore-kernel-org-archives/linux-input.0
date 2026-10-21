Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792610390;
	b=OgSFMGsNS55ifX8C/NcxpZjZAmZNRnX4Hzfsk3mx8pLPpWHyAkIunIV6yxqia4RvvnMl
	 FHFVAYCyh1gdpV3tmQt8QtbK51h7U2krG62N8ZMC+uXQahlnQU62aTlDSu46ZBLfBd+u9
	 t8xNhQaQGJebFoYRusCY1FtvbQoWJF6pfjblfMXMHioqD0iyBtW8IWC27S3CwWQ5GAys4
	 nR730cTjKNpaEao2Z1qRdG4XQlZWXcrtYsyVAGx0dAkHiPnkpnL++tny41k5N+uy89OtP
	 D1Us2q7CkB0z03V5vy3c3lUCNvIcClgsEzd4y86cv4Zx2S8RFNghVFBY1ZYgE+b3hkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792610390;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ubD8jlES2r9JS1ilGa+r04b+PuxqIhs9kd1HnDejkPY=;
	b=sj+mKhOhgH0RIdwqQRwsojsXPMDndU84ggtJJDMng3Gje8ZdDTn0kl4clbtI4V9XPIQz
	 TPcTez20GZ/OYqgh9mrJT/PAqCI4beHGZ3P8yTOVue5HDgnYGgvhC7CfBuQkCPNqN/J78
	 QDN1MN6lTg/Y/NcDuBByLz2tEjrxgQz7IF4bfysF6ySyrXKLq7RgpQYukBb+SR20tWzCw
	 1F2UcQ46eWsTySWOeO2TLuLbwyxlr8gEU3cbACfhyNtYaqDL1avsNsIstrx1LPPvDHwBA
	 4C2X59+ZmHX2dsD7IPQTYz7nR5ayPtOduKJXjB8pAb7gr+yb54xvD8FjLBdHqpTr/6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BbA0vOuq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DDD606A324;
	Wed, 21 Oct 2026 19:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BbA0vOuq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0E71F000C2;
	Wed, 21 Oct 2026 19:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792610389;
	bh=ubD8jlES2r9JS1ilGa+r04b+PuxqIhs9kd1HnDejkPY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BbA0vOuq4XksLwfEBfKH0Mg/HesUwrzRg3nbNBByJuoIfwSj//7JtxU8UX2urpuiC
	 y9CD6iqC8wPLe24M9fSoQ2xx022IoaPUW5IxH0wRyb/NsVbvuEEqiVGyjaKg4Aq1EM
	 m+qfMkt5WpvQtVgBW9uQoijmRNfqCAhn+CXpUvZrPZ5Inc1nVUO0TWy1yN91bAjvW0
	 OQw+dWJ9Lvt4fF6XS6kWV8Zu5tvjIVOLZzxYX+GqPmC0lcEfcqZH1HjX1Qwnbb4ouf
	 P2ZAzQhs7KqMHMkMfeFXIkJFi5pfVYStj779wXkEBjQvkonBRoH+eo2ssWNaDT4UcG
	 t2cJpPkALSe/g==
Date: Wed, 21 Oct 2026 20:19:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Shi Hao <i.shihao.999@gmail.com>, Rachna Patil
 <rachna@ti.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, mfd@lists.linux.dev
Subject: Re: [PATCH 28/28] mfd: ti_am335x_tscadc: Remove redundant
 ti_tscadc_dev_get() helper
Message-ID: <20261021201943.6159ecdf@jic23-hlaptop>
In-Reply-To: <20261021121245.3111563-28-lee@kernel.org>
References: <20261021121245.3111563-1-lee@kernel.org>
	<20261021121245.3111563-28-lee@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Oct 2026 12:09:50 +0000
Lee Jones <lee@kernel.org> wrote:

> Now that ti_tscadc_dev_get() is a single-line wrapper around
> dev_get_drvdata(p->dev.parent), remove the bespoke helper and retrieve
> the parent driver data directly in the child ADC and touchscreen
> drivers.
> 
> Signed-off-by: Lee Jones <lee@kernel.org>
Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Seems moderately unlikely we will get a flurry of activity on
this driver and if we do merge conflicts should be minimal
so no need for an immutable I think.

J
> ---
>  drivers/iio/adc/ti_am335x_adc.c           | 2 +-
>  drivers/input/touchscreen/ti_am335x_tsc.c | 2 +-
>  include/linux/mfd/ti_am335x_tscadc.h      | 5 -----
>  3 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index 1516dd332f90..77ea59d6c6b7 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -636,7 +636,7 @@ static int tiadc_probe(struct platform_device *pdev)
>  
>  	adc_dev = iio_priv(indio_dev);
>  
> -	adc_dev->mfd_tscadc = ti_tscadc_dev_get(pdev);
> +	adc_dev->mfd_tscadc = dev_get_drvdata(pdev->dev.parent);
>  	tiadc_parse_dt(pdev, adc_dev);
>  
>  	indio_dev->name = dev_name(&pdev->dev);
> diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
> index 623546e80668..40ffdec9d207 100644
> --- a/drivers/input/touchscreen/ti_am335x_tsc.c
> +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
> @@ -418,7 +418,7 @@ static int titsc_probe(struct platform_device *pdev)
>  {
>  	struct titsc *ts_dev;
>  	struct input_dev *input_dev;
> -	struct ti_tscadc_dev *tscadc_dev = ti_tscadc_dev_get(pdev);
> +	struct ti_tscadc_dev *tscadc_dev = dev_get_drvdata(pdev->dev.parent);
>  	int err;
>  
>  	/* Allocate memory for device */
> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
> index 4a048a897cf3..36d365b64fe6 100644
> --- a/include/linux/mfd/ti_am335x_tscadc.h
> +++ b/include/linux/mfd/ti_am335x_tscadc.h
> @@ -175,11 +175,6 @@ struct ti_tscadc_dev {
>  	struct adc_device *adc;
>  };
>  
> -static inline struct ti_tscadc_dev *ti_tscadc_dev_get(struct platform_device *p)
> -{
> -	return dev_get_drvdata(p->dev.parent);
> -}
> -
>  static inline bool ti_adc_with_touchscreen(struct ti_tscadc_dev *tscadc)
>  {
>  	return of_device_is_compatible(tscadc->dev->of_node,

