Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794443119;
	b=RD0x5uJIqHI4r82qI/MvxnlTy13jDANMkBrp1QK7LKq7plJbg8Sz0vMogzR5bYhUWEO3
	 sk0iN7DtXH4qTEkqvbLH0kU4c4nHpw8j2fW2cRN2Ltp77nMCBijF1mIDN8VYlKbN7leYw
	 x9ihsczNWKH+XQTdJA9loJ+QlrByChpFJv9yCl6dGowlwAJpB1tsgdvkTi1tWHeIzOcZG
	 4Nc8FC4ylsIE8olshhN/WtvkmsKGkRZLijTHXH26H3mILzU4ztJhILoi+S3OnOK9OW6gv
	 lRnuZ9f3vpZnc9mNKYRQQaY9b7UWf87X+1aKL9zmEa/USL78bUlgvX1f2jTL9GUvoAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794443119;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=WmDxcQotq3NgeobvzOlqzwVczvRUhsveENxWAqE5LCM=;
	b=U9BwbxlOIMX/vclDFfPhXw6QlPB53p/8xmBzpa4cIYxMJlVlMeoAOfm7v+K+LYsIlsbX
	 ZYOnh1aWIS+q1ILPCUlfIxmTmCQ76aPLklWC6aIUm1lEp0bT6LAI/hwxI1xjiZd2d64RF
	 NY7E6Nj8w8wNl/Uk8Iyve1sCsyOw6iZuI8ww79X78bLUEYVT8WR9/Yu52gYZO5Q+sqtg0
	 A2px+bO/jj/tMkCp38n9Tn1LG2iV04MHII1hFhFWiHbE9xe/8v70XY6XOyDgX4VQDgwzC
	 ENhVZAZSwJ7sP8VLWK/0O6UvuAfCjjmijXKkgH8jZ/+6sO+PLaH8hdk1H5zIXVlbRLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="h1S/DtRe";
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF0A606A326
	for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 00:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BF0A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h1S/DtRe
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3704d30b84fso4709732eec.1
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 16:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794443117; x=1795047917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WmDxcQotq3NgeobvzOlqzwVczvRUhsveENxWAqE5LCM=;
        b=h1S/DtReSrooUG+5tSN0w/2VC4kQ8AWHjCfF28Z9OQxDnt2zBOzOG5sKY0JnQnJnFJ
         zNwQbHhUCOB+mBz+KNl0PE8STaFR26KMtp9vkTpW7C07Cb/YyzjGHtqM07sjuYKHxOVT
         Bw6BOYKRKl4LpOTyraYV/EqXqZQE0emqlHIbes5FFn1qm34+50N3/YHSvLdJ19ytxeVE
         6yPp0kLgJnc0+ca3K6gduebk0nEVB67S9ZCzo6eMWtcjuyTSxgk/QI0JxuJsNwK89sRJ
         srUy5gRBPksXx3Vl0TSo+9xqOGXIDjeVqvcLE+cpxfsKW8sza5a3MUFK7cLr+uKfTsYC
         9a4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794443117; x=1795047917;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WmDxcQotq3NgeobvzOlqzwVczvRUhsveENxWAqE5LCM=;
        b=PY6gFcpCZrPc/WHvlyT5hpcz89XBrezQVnc//3sg2CQ9vnYuu2ZrT6+NAtK7tfVd81
         OdA7RJwwyhLpMo4ZCkazJhKKTcbr3T2TJz+1oRyMg6KVgoVoSz0sMZL7h/gLZlpW3ppv
         +2G2fGdWJZm7Q2HY7E+mhoauldMtapRcsxN+NBpMADC7G4W2qkKK+qHP1Y4Qt9BtaQBR
         xGsDvtJCJVYOkCQEtFGQNSbehfmqpRsgaDh6Gi/u6eE86pFcFoflQZrfst1V5BcfJ5wW
         +0q2Dw2f5JkPLR+Ld85q2nQNriyoBGBBnBDnBEw58tb6Lu1Pkx5BM2K60PCaAWoTMmNV
         PxAQ==
X-Forwarded-Encrypted: i=1; AL+hErH2X611ZmMCCSCOW/ctRMafvCrdt4nCVnqnZb4pypZvEFoehvJ5P2FQwhhM8Fzfyql+ezKP+DFkJ3oRRw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8CrjW5km5TVDCAav+Zf5PzQejcEGerHaWGkjE8dGHuDPnHGaWy
	zGbtWlNDYJAUnQj+y5LKsKx4bJ7q7XqZ/AQ9qqYBwV4czEpFUXpuUmL4key4tw==
X-Gm-Gg: AYBFou2xErWR459+Y4Kpuu9R8uXnZDNJkgBSdeUR4dJyLcrrHu1hn6Icx1nX1pPkEQc
	eqJWsPx2v3/GzuFGf8U5gbQ9a/elEHGQ8TgDAKqhe8Jo/jL7XEK2UonmGXX91Mw1bvesV/DqBIC
	RMNI3W/8AOrWOPazGj2Eq3PHqMhJVZWzfApVxdfM97pTW38NUMP+bgurH7suHl2oXbSZJV5jTiR
	ti5OnZUHepNOXjySzoZZ0enQRRfVXiFj444xdnik8V//dGFOBHAhWqQbXWdJeHpUwj4uT0qNSew
	OIF8v4hErvNW3VU2gCyfimi8Qr8by6wPgFWat49TKsohCTs3aN09pojAtDHEx1I000WdHMXLShy
	CObeytgwlS0YJFbZRBuXaKpN8UmVuvSsj+vB9lf0TdJKsjied/KL0kU7rTz9DcWz5wEMd1Usgjs
	+qGm3tmHMl7OSfrZ+/kI0HK42DJ+0GKXelBb9z5HfG9OSt81EI8Q4tMyBhnVb2xe9MArPuLOWk7
	ub+Dloj/Q6L1RapgT1eXI3De+fWIMMG9FZUU9REySpYItku50EHgasY1VCeOBB3XXXx0ClKSJIT
	DFixpoYzYHbwQ+QADkW8Hy4lIAZpGwOpz+Nu5w9XiYDDZgeJPNadmzzKo99Fegi/BTuoig==
X-Received: by 2002:a05:7301:d807:b0:378:2e89:3958 with SMTP id 5a478bee46e88-3782e893b15mr345363eec.19.1794443117438;
        Wed, 11 Nov 2026 16:25:17 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:182d:659:ffce:39a4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3766146551asm12082193eec.1.2026.11.11.16.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 16:25:15 -0800 (PST)
Date: Wed, 11 Nov 2026 16:25:11 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jakob Unterwurzacher <jakobunt@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Joseph Chen <chenjh@rock-chips.com>, Lee Jones <lee@kernel.org>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	mfd@lists.linux.dev, devicetree@vger.kernel.org, 
	Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
Subject: Re: [PATCH 1/4] Input: rk805-pwrkey - enable the wakeup interrupt
 during system suspend
Message-ID: <avUGEQhSKlko0Fm9@google.com>
References: <20261029-dev-tiger-v7-4-pre-20261028-tiger-suspend-b4-v1-0-cb12621c1fb4@cherry.de>
 <20261029-dev-tiger-v7-4-pre-20261028-tiger-suspend-b4-v1-1-cb12621c1fb4@cherry.de>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029-dev-tiger-v7-4-pre-20261028-tiger-suspend-b4-v1-1-cb12621c1fb4@cherry.de>

Hi Jakob,

On Thu, Oct 29, 2026 at 11:06:23AM +0100, Jakob Unterwurzacher wrote:
> From: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
> 
> The driver marks the device as wakeup capable, but never enables the
> power key interrupt as a wakeup interrupt. As a consequence, the PMIC
> interrupt line is masked during system suspend and the power key cannot
> wake up the system, e.g. from suspend-to-ram on RK3588 with an RK806.
> 
> Enable the interrupt as wakeup interrupt in the suspend callback if the
> device may wake up the system, and disable it again on resume.
> 
> This is done in the regular suspend phase on purpose, rather than with
> dev_pm_set_wake_irq(), which arms the wakeup in the noirq phase: there,
> enabling it updates the PMIC's interrupt registers through regmap-irq,
> which fails when the PMIC is connected via SPI:
> 
>   spi_master spi2: Failed to power device: -13
>   rk8xx-spi spi2.0: Failed to sync masks in 7a

Sounds like this needs to be solved in PM core rather than hacked around
in individual driver? Let's CC Tony and Rafael.

> 
> Fixes: 5a35b85c2d92 ("Input: add power key driver for Rockchip RK805 PMIC")
> ---
>  drivers/input/misc/rk805-pwrkey.c | 42 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/rk805-pwrkey.c b/drivers/input/misc/rk805-pwrkey.c
> index 76873aa005b41..9b64ec7463c62 100644
> --- a/drivers/input/misc/rk805-pwrkey.c
> +++ b/drivers/input/misc/rk805-pwrkey.c
> @@ -15,6 +15,10 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  
> +struct rk805_pwrkey {
> +	int irq;
> +};
> +
>  static irqreturn_t pwrkey_fall_irq(int irq, void *_pwr)
>  {
>  	struct input_dev *pwr = _pwr;
> @@ -37,10 +41,15 @@ static irqreturn_t pwrkey_rise_irq(int irq, void *_pwr)
>  
>  static int rk805_pwrkey_probe(struct platform_device *pdev)
>  {
> +	struct rk805_pwrkey *priv;
>  	struct input_dev *pwr;
>  	int fall_irq, rise_irq;
>  	int err;
>  
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
>  	pwr = devm_input_allocate_device(&pdev->dev);
>  	if (!pwr) {
>  		dev_err(&pdev->dev, "Can't allocate power button\n");
> @@ -84,16 +93,47 @@ static int rk805_pwrkey_probe(struct platform_device *pdev)
>  		return err;
>  	}
>  
> -	platform_set_drvdata(pdev, pwr);
> +	priv->irq = fall_irq;
> +	platform_set_drvdata(pdev, priv);
>  	device_init_wakeup(&pdev->dev, true);
>  
>  	return 0;
>  }
>  
> +/*
> + * Arm the wakeup in the regular suspend phase rather than with
> + * dev_pm_set_wake_irq(), which does it in the noirq phase: enabling the
> + * wakeup updates the PMIC's interrupt registers, which is no longer
> + * possible once the bus to the PMIC (e.g. SPI on RK806) is suspended.
> + */
> +static int rk805_pwrkey_suspend(struct device *dev)
> +{
> +	struct rk805_pwrkey *priv = dev_get_drvdata(dev);
> +
> +	if (device_may_wakeup(dev))
> +		enable_irq_wake(priv->irq);
> +
> +	return 0;
> +}
> +
> +static int rk805_pwrkey_resume(struct device *dev)
> +{
> +	struct rk805_pwrkey *priv = dev_get_drvdata(dev);
> +
> +	if (device_may_wakeup(dev))
> +		disable_irq_wake(priv->irq);
> +
> +	return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(rk805_pwrkey_pm_ops, rk805_pwrkey_suspend,
> +				rk805_pwrkey_resume);
> +
>  static struct platform_driver rk805_pwrkey_driver = {
>  	.probe	= rk805_pwrkey_probe,
>  	.driver	= {
>  		.name = "rk805-pwrkey",
> +		.pm = pm_sleep_ptr(&rk805_pwrkey_pm_ops),
>  	},
>  };
>  module_platform_driver(rk805_pwrkey_driver);
> 

Thanks.

-- 
Dmitry
