Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8739388E5B
	for <linux-input@vger.kernel.org>; Sat, 26 Sep 2026 04:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790397639; cv=none; b=LdYBreVxvWg72D/ceEs7EPlqYFX56DIoovc1XyGrwchhcYP59l6eSKSc4YkvURv6Ss7kcc75rH+y1Nmzbk4w5igLiBJgNw7tBfQ3/hF6slo8TZSmZ2RM1ydoGYEwTI2yV5rqplEf9HvMW9Uqu3l2VpqiEUtVVY9x4Mjgwyn+8ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790397639; c=relaxed/simple;
	bh=9/8pQ7p02Q5KmGp4IRdYWIfOXW7xj9/SWyUcOpAt66s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLiaaMLDLyVS5OIX0Da6HSQ+IJTcnoDCGDoeRLj/adhBuTZgObbkFZyOyYmIWeMcvDZ/tequjFaB8Ha02dxsg5vnWWpk0xCY8AyENqIYiBfE/9nANwOb+6imTjPTLMpWEPYsSBGsxTOcqae4KUaOGnCu5k64s7PW3PpcoVT0W7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHFqIveH; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHFqIveH"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-3396cec93b6so1774606eec.3
        for <linux-input@vger.kernel.org>; Fri, 25 Sep 2026 21:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790397637; x=1791002437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IUYBRI5sdXRLkIxlzo71bpLRDvT0ncaqZ/+GUrIm8/E=;
        b=gHFqIveHlSgyZ4QVzipdY90D+kIdy/SFJD8cS0BCanBLrrYVvtRhshoemJpCDiAErA
         VukDVYnD0CoHqJeChBGv33cUF69vaE+/Qvz6mjKnfSx/gTVfokJf4DNFT+QK830kLtLk
         h2YqyIViCrGfwWYATOUSoFqDjsxgG490ZyBMAOfaLgzKPsozYSKpSCuasLq1IC73JCdN
         XhwGWfTaH0YmJ1nwGdfsJVcP2eOD3kWSH+NLZT0wx7rNJ12ZruTtypetx0OWgpqUO2iE
         wazIJr7gkyBOTVU2+WqbreWHy2HbGJa1Xf6wAC1LNsf0wBXXJaBm7Bf66co2DtxGaXyG
         ysxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790397637; x=1791002437;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IUYBRI5sdXRLkIxlzo71bpLRDvT0ncaqZ/+GUrIm8/E=;
        b=t5xWBgJzLU1zGsfrQ1YyyfoXTluKd/aDzv/l029h2HqSuB1HsPSUShG5eNHYP6VbHF
         rJ8CJHXHzLtRLUJmehLm5ExXK46Xt2lrhsiVYAxZGAv3MkNFlMnzTkpnlC+w56N8wRhG
         ovEaIoB+eehXsTB1y7jWqWqI9kHftCHq0o+C/Lwk+UsBYU3ohLTLGfd17Kg94+TTQ9KS
         nY8F0qCmzWho9efMwlE8ui2ia3YNwvnXtN9YBZ/iTtfI7o6fHw4GYfd11jDojdlqwQ0i
         Pl61u0xlays7vbVaBa6IZsfoQlFGYN15RBUouszeIjyNQonBgUml9GKzE+8fsKruNbkx
         Q6iQ==
X-Forwarded-Encrypted: i=1; AKwUvBzJ/Zo7sacuO7E6YhEUzC4pqOQweHuyEBmYX+a2JuXILpV1bgrQYgiJP+S6fyAI4oHdU89vBWGC8W4idQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lB9h0eHXNrOLHEKwK6iluMLGRHce4aNzdKLohESaJyM471I9Xc
	kw2mUDRH7sPao7kWCI3/0VwfKha0VkS9T2sK4YSXcqNI+TzezFUd7ynT
X-Gm-Gg: AYBFou1z5Tb90i7894SXVzAqA2RmzxyB20oOxAj73fLHEfNWmYpLGhG3IIUYV5odZf2
	u8uXp9M939fbp2CTIYmFccbu56yNnzftbhTaN7GilAUHUkK4efwY6nkwywjzqERSMZl1N+zjRnI
	effCYYNrh0DoXsv2yEsPLWGBOngRwdhhfKENgnS2z9j0SWOcsu5pC+Be+JYRPdSUIHSqtR1CWlS
	kmmPFPn6D2cVcUa6LDl33ls3NJlNYa29t6qXjulGAbtNXG2r2WbAm0LA2E/e4+Q9YDZUGL7AAm+
	a52elzlwTG015rmpk8LPBJCzS7o/E2PrU4TE1qtXrK0h2i422LsV6P7phs5DcQylTIZB+Xf9vSD
	iugrESl3CzqTTcJGpUCDZeblAdh/rnWPBPjcBUchQAd0XMzIq+Z29r+e6rK00IZL3ZznPwJmHvJ
	RI1lUbZLLVROq/KrSKsBWO1v6mz/JcXNNRby2C50iq1v8oabTzfcVn7g5xX1fQ4uhd5WFrispQA
	ByUJcGyI69ZfKuCMvKA3XIsslMd7FAMLKKmXTI=
X-Received: by 2002:a05:7301:4d0b:b0:341:d191:b838 with SMTP id 5a478bee46e88-34272562bc0mr2032551eec.31.1790397636098;
        Fri, 25 Sep 2026 21:40:36 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:375:19cf:5fee:be32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-341447576b9sm11731720eec.15.2026.09.25.21.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 21:40:35 -0700 (PDT)
Date: Fri, 25 Sep 2026 21:40:32 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: david@ixit.cz
Cc: Andi Shyti <andi@etezian.org>, Rob Herring <robh@kernel.org>, 
	Marco Mattiolo <marco.mattiolo@hotmail.it>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	phone-devel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Input: s6sy761 - fix resume ordering and restore sensing
Message-ID: <ardMSVsG1RlOOkNp@google.com>
References: <20260923-s6sy761-suspend-v1-1-6fff96e71cb0@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923-s6sy761-suspend-v1-1-6fff96e71cb0@ixit.cz>

Hi David,

On Wed, Sep 23, 2026 at 03:27:06PM +0200, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> System suspend powers the controller off and resume powers it back on,
> but the resume path enables the interrupt before s6sy761_power_on()
> checks the boot. The firmware raises its boot-complete event on the
> interrupt line, the threaded handler consumes it, s6sy761_power_on()
> then reads an empty event and resume fails with -ENODEV, skipping the
> touch function setup:
> 
>   s6sy761 2-0048: PM: dpm_run_callback(): s6sy761_resume [s6sy761] returns -19
> 
> Power the chip on first and only then unmask the interrupt. Once resume
> completes the boot handshake the chip comes back with sensing off, as
> at probe where input_open() turns it on, so the touchscreen stays dead
> after resume. Send SENSE_ON again when the input device is open.
> 
> Tested on a Pixel 3 XL over several s2idle cycles: resume succeeds and
> the touch function and sense status match the pre-suspend state.
> 
> Assisted-by: LLM
> Cc: stable@vger.kernel.org
> Fixes: 0145a7141e59 ("Input: add support for the Samsung S6SY761 touchscreen")
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  drivers/input/touchscreen/s6sy761.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/s6sy761.c b/drivers/input/touchscreen/s6sy761.c
> index 0f24a9b730635..c52c45a7d1029 100644
> --- a/drivers/input/touchscreen/s6sy761.c
> +++ b/drivers/input/touchscreen/s6sy761.c
> @@ -495,20 +495,29 @@ static int s6sy761_suspend(struct device *dev)
>  	s6sy761_power_off(sdata);
>  
>  	return 0;
>  }
>  
>  static int s6sy761_resume(struct device *dev)
>  {
>  	struct s6sy761_data *sdata = dev_get_drvdata(dev);
> +	int err;
>  
> +	err = s6sy761_power_on(sdata);
>  	enable_irq(sdata->client->irq);

Why are we enabling the interrupt even if power on failed?

> +	if (err)
> +		return err;
>  
> -	return s6sy761_power_on(sdata);
> +	guard(mutex)(&sdata->input->mutex);
> +
> +	if (!input_device_enabled(sdata->input))
> +		return 0;
> +
> +	return i2c_smbus_write_byte(sdata->client, S6SY761_SENSE_ON);

Explicit return err/return 0 please - there are multiple failure points
in this function.

Thanks.

-- 
Dmitry
