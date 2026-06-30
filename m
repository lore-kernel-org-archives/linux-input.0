Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF6D262808
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 19:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782846916; cv=none; b=fcRuyAdtWZA71c81NvMio7AL906SSbIYh6kMTvLfVKuIpszPgz9hwGY/4Dymj0DEmOoFxg2FpWlyWHgRXxlvibyBk1VppK1UTjAWQHWr6YFIQrX4kmeggeyLexL8oCHytZdkrJeU40g2uv/8rE4gi+XVDtECyRkoMAyLWbgq6GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782846916; c=relaxed/simple;
	bh=mEUU4k/pxnVZW4pACXwnVdN0YhBTqZv8x9zqIafDgcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCxG8vnN6sFf/84rKmcHxQeOsfHhWJg/QdY+7/DDgm33KbfHddNdBSSxygkDVztF1J9vc7WFDXa3zr4BuX3DUQ9DAZRyrR971qWwTZwdiN7G2j4j5DXJeGqQuoBOueirqW+R3k+Q3YQEworoB9nWAbiz04i2Fn2iFQ9A7YqgxZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WiRDK+l6; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiRDK+l6"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49270caa5c0so38936055e9.3
        for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 12:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782846913; x=1783451713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zuBq1qAG84ZA4NHRdfFmCaMLtFQOMgrbPaV8NPBW72k=;
        b=WiRDK+l6HRvApjZB1/kAUCWarT/bgLY4n0LOtdXENX6mpoSevUHgVbINBPRDo6cgpK
         JWCQPjVv2t2PQfqvxVuwrNWFjXmgJcV33HrR3jvc3/WT5ZRnf5TJUMFGDc2ROc8oGid6
         /JMbY+hZpDUwyVo5Ztl3l5O0UYaF8kFgJm3242zUSbBahfEzx78I9VqOCFg6Noix4gPQ
         3TGdFD3VQzj/d3ndo+QhSVo2c6wpLRButUuN6dYi/2NXyt9Sb1PxzWvkO1NpxcUmhgX4
         TP8pZbdMnWJuGf7MIgl3Y9hZE9xeQyO93pIvtT/jvA0PbJ45/i0ACJ61c/7d13x+YyKg
         l5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782846913; x=1783451713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zuBq1qAG84ZA4NHRdfFmCaMLtFQOMgrbPaV8NPBW72k=;
        b=YiPPeL8U/ZaO1zKzPZ2yKCEyF/LJ/2UyMrRU2TCoUsftOUfFNjL/slS56lUoJtNv54
         aXXlbJeBjccTEEgXEJ2r5RwWs4s9Pc9YC9abF/gcLhgmgEzFKzwQMWvE+C/7KLWUcRul
         6O6oa4v53SN1Zb3Bx1nSA+xIoIMBFg30KH+MX1l39AE0GRUFeqKrghRI6eHgW5mCC97V
         a/4i3YFgmCXX/qvqQi0s50ZtsfHfjfWSQFz5PFeccGUMVAe6yGFZlZLeCZMZI0ElMB0X
         wrTeGV4eXwX3z+JioN8wX56omE2QPbnEHWY7ZBQc4Icpr/L3sQSwRbXx/xaM6q/CRmwf
         x9vQ==
X-Gm-Message-State: AOJu0YzSatdGYzDgfImxRomj6Nb0mbo9sztHSgReDr5k0B8ZmS5oWx7g
	b1n1IfFe5F9eoGyJ84EyucXKycXWpY/VST/Hf3z3ArKRInqN+Ln3oVM=
X-Gm-Gg: AfdE7ckkkQd9cAdX1opiZYcj2ZdTLJEymlaUX6GTp+VK9A7s+JWQQu7SdOp2iHlHR39
	FcuiVCus/RH2l5MEFK3ZNb0U4qHJt1U4yfjQ/UVx3vhgwok6T+riFKvqxwleKVC0ZHbEHrDDDpO
	z98j7h6V2qRHydXrLjZZ8Huo5fip556MQmjTuzSVIdUwj5FfTxM83ZgIgVyECe9NhiXxorvxdyC
	PFtrw5AvFNpXl01I8bHvxADkkNKUopZsLQWwIHpxqCZOvr/bqfzyjH/YrnINPvUZKZ5bHIvDf1H
	hdliCI6zknp5AVEBeWJ2ClUgd1e9aW25xqrcbXki5yYWtt7FgBGpyz3becDTQ3b8n27h2Ip3DOX
	vh1ABcQa3OpI9duINVdrFOZUBKrZkySeb5ZMlIu3+z/5NuZYxxT/QpzUUWEvob1c6ljbISmJQgV
	KFg6gJYG7ZhMrRt8lPhYJoDy4AyBOvy3uJyc4qldIbBx5An+9DO0NDzL6tj5EuE6tKiL7Lbov3C
	lqv
X-Received: by 2002:a05:600c:4e90:b0:493:b962:4abe with SMTP id 5b1f17b1804b1-493b9624c71mr60343825e9.36.1782846912994;
        Tue, 30 Jun 2026 12:15:12 -0700 (PDT)
Received: from lithos ([2a02:810d:4a94:b300:989a:410e:90cf:c762])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4d1f1asm17141585e9.7.2026.06.30.12.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 12:15:12 -0700 (PDT)
Date: Tue, 30 Jun 2026 21:15:05 +0200
From: Florian Fuchs <fuchsfl@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	Adrian McMenamin <adrianmcmenamin@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: maplemouse - set driver data before registering
 input device
Message-ID: <akQVufpzru-mWe9_@lithos>
References: <akNXw45L_8bxD6QV@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akNXw45L_8bxD6QV@google.com>

On 29 Jun 22:47, Dmitry Torokhov wrote:
> Set maple driver data before calling input_register_device() to
> ensure that it is available if the device is opened immediately and
> the callback is triggered.
> 
> Cc: stable@vger.kernel.org
> Assisted-by: Antigravity:gemini-3.5-flash
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/mouse/maplemouse.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/maplemouse.c b/drivers/input/mouse/maplemouse.c
> index c41182766538..0c8f7d1b02aa 100644
> --- a/drivers/input/mouse/maplemouse.c
> +++ b/drivers/input/mouse/maplemouse.c
> @@ -88,6 +88,8 @@ static int probe_maple_mouse(struct device *dev)
>  	mse->dev = input_dev;
>  	mse->mdev = mdev;
>  
> +	maple_set_drvdata(mdev, mse);
> +
>  	input_set_drvdata(input_dev, mse);
>  	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REL);
>  	input_dev->keybit[BIT_WORD(BTN_MOUSE)] = BIT_MASK(BTN_LEFT) |
> @@ -103,12 +105,12 @@ static int probe_maple_mouse(struct device *dev)
>  		goto fail_register;
>  
>  	mdev->driver = mdrv;
> -	maple_set_drvdata(mdev, mse);
>  
>  	return error;
>  
>  fail_register:
>  	input_free_device(input_dev);
> +	maple_set_drvdata(mdev, NULL);
>  fail_nomem:
>  	kfree(mse);
>  fail:
> -- 
> 2.55.0.rc0.799.gd6f94ed593-goog
> 
> 
> -- 
> Dmitry

Tested-by: Florian Fuchs <fuchsfl@gmail.com>

Regards
Florian
