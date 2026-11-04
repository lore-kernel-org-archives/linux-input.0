Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793831298;
	b=n8Fcnf8I+/WncOwvmDQ+6Fq7D69JAwzdgyyQnfECc/jVhHG0bvURekntzYps6XbOmBOc
	 d6baqgT+fVrQyKVcgVE3eKZpGT/9XZGmUO/Ryq/nGI7+j+GHxJy90xE7/gm6tfX7v+ewA
	 GDCcxaD9qTh9TeM/Pg5ynjUQAkFaIxAfBlO+zD7hviIwvtHa1vMztQx5c2Xvx6rUD2gHK
	 AEnSt7FGFwZM++fuRNDV8vFe5tf0XMHiNNzOO/evwSHBbioKm7G7Soj7CiuefiuNAHv0t
	 7o9TbEER1iCu8fJapMUO/fK7LYWG3qUkQYWhsrCQ6yqr9sRbeeTj4i8EfLgHIp/C0Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793831298;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=rORPcwpKcsLoZavTsDXE5+1r14NtYgKold9FpGxIEUA=;
	b=JuGWvAA7O/RXCZq53lPmx1YqLrZ7oMMNS+rGFWMtCWuKz4lCb1yu8wjpziKkuaRAe3i/
	 rsfvn5lxRAXEKyAmMdyYX2CHUaabTJTxB27B3DwqQy+/33RgNVYOwt2k4ccHn+5tjUFxN
	 VSYneep01AvPyPzUZqeZ3OTb8nU+KhFQOHiUrGHPH2Y4WvSE0tb5mZQJGZ5wHO5ZOfXWr
	 tCUFeND0rm0Flcnr3ttvY+OZL4xsGaA8Yan7GiLTEQxsXonDMAKdgTALqrYo4AWbPTxtY
	 We3SWd6Nhc7Ej0n4I/OJ4iDSYmnap6uexDXyKk0dctTpFHGrPKWz9ukHNzal9gOESfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VFQQwjVQ;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1D8606AC39
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 22:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD1D8606AC39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VFQQwjVQ
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1a8cc11ac42so1394768c88.0
        for <linux-input@vger.kernel.org>; Wed, 04 Nov 2026 14:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793831297; x=1794436097; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rORPcwpKcsLoZavTsDXE5+1r14NtYgKold9FpGxIEUA=;
        b=VFQQwjVQRPQRUQLEKQZ0uCHBD6AiMJmbUbfvGwNX3j3vqFrcm5mawXNoYHM8TH+ZrU
         7YFcdbOBvMl/K1om4r2gP5o0e/DChYOrZcoomOZeQ/QhKS5sOv8AYNGdCQHifyG4DgCt
         7emLFI7dY/6+FylAuJsnOc6s8pU+DjJadx1aE+FM6/AWCJ3tqb1QWwgl40AkL/4DZIak
         3GOSpOU2wPX5QgtRh1D2Z3mxwacfDT5c2IigvAgT7/f7dLbGE2xlz1uZBYjn1P4gGuSQ
         NYuTAfgURb0t8EF4QpQEiiAFWrGwes1nrfXaPTg0vQiZBMIALZrPhfPuXnBNKj1kifZ5
         Tsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793831297; x=1794436097;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rORPcwpKcsLoZavTsDXE5+1r14NtYgKold9FpGxIEUA=;
        b=ZbSQaN8yPGChVglJhUIP5LiY781Py4tuwcjcJ9Riwblix6jC5sjOa76I5oDdlH4dFv
         7uMbuUofIraJFOApZBFgk+lR7VvqXhmqcSyY5a540h9H8pUg0yKof3BCs9VWADKBIBTG
         C5M3RA85yeL3ZOWruAzOKtliN0O2HMjJqLAFPd2ZG8uC4jvz2B7OOVDcV0mye5Um01iI
         nIpKkjgD8eys9feeldMHGSCtJVNwTYtHrZWBcwg6nHUC6ZzZ5oAHzp13cPRh/ZMTerYg
         1vZ2Psn/OTBOIHEUKe2rgrmEBf5IdSfiOPGbfPFoTvyRuka3T21Pxeg1YpjA3Y8+lVTg
         03GQ==
X-Forwarded-Encrypted: i=1; AKwUvBz/esVdH8ybw8I3rTcOVWS6QMbcy0V6XiNL5vBeULcTDgr1qhMVCtgNEsKgfvNouRqpXDJ0+Wt3E4twCw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+0z2LTgcxA3zqJvmXzbjNUiMcuphEvelwpPh2L/qEuyw1EWHqh
	mvqFdBs3pahws8GgegIUjCbLub7obM9Bh10CsKs0SkS5KoeNr9krg3u4
X-Gm-Gg: AYBFou03u67SWTcVejG3l0OwGmvZItSK5gX+7eGcurTM9q3jz68PuPTX3f0UL25jfog
	CcBArrRN3pfjT6/IxXjet1gC3wsoJDu+h3QWpXetaB5+Uj4eS1T+BxSLfQ3wJ0Jftdj48iM9eLt
	dlEL1UQk1Pi5FFux32G1dCoRXOP7d8lHOJqVw2gd8mSKhDY1cZGrXrjJiI4/AvO00Elr4KeicoO
	D6pCY4bYsf8c00akN3h2fiZ64MbF78cvHartkE8mFyLVXjnnbauqaCtmtLuuNeAyhpqf6PwiJSN
	T+ZW45zzjLQeUPcqguF56zlL4uCfuphA0VUDjHr5tdDmFAhBsFMQk5OjTj9wBQenlTQaZcGYyaf
	mpD1h1u3Tkid1+nUtYBuGXFue8Ygw3UYPE+J2F43yJHze6ApxSTvBMkFWGs+sA6we+tiKY2xh73
	MFyOw9weT5GbTL8yr3uZkiBJ+xGLnvXYP6n51x9xebz+n+OEzGBZ+pRRl7ojUqAyAWM48UdYP05
	wP6vaXwkPUmaYLCOH+BZm6H2UWqQHeBRk2DSyYI3qXRMJTZ0fmIPLqjkZTif3i03wTXT2x5A8o+
	uVT6r6J/6ATHBGUoL+nrkLBVkhhYIlrOgXbPDUzKWdJa01TyONhRfLlwvzp7DPTSysocc9QZFRg
	3XOoXjTBudOK8prY=
X-Received: by 2002:a05:701b:42c7:20b0:1b0:f0f5:e38f with SMTP id a92af1059eb24-1b0f0f5e3b5mr18662779c88.34.1793831296771;
        Wed, 04 Nov 2026 14:28:16 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:c8f4:b7d9:252f:4483])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c463e9sm10694316c88.14.2026.11.04.14.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 14:28:16 -0800 (PST)
Date: Wed, 04 Nov 2026 14:28:15 -0800
Message-ID: <f5c1435fbfa7568a107c864781897d6e@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: bartosz.golaszewski@oss.qualcomm.com,
	marco.crivellari@suse.com,
	arnd@arndb.de,
	tony@atomide.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	brgl@kernel.org
Subject: Re: [PATCH] Input: gpio-keys - do not BUG() on requested wakeirqs
In-Reply-To: <20261104160305.2501369-1-andreas@kemnade.info>
References: <20261104160305.2501369-1-andreas@kemnade.info>
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
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Andreas,

On Wed, Nov 04, 2026 at 05:03:05PM +0100, Andreas Kemnade wrote:
> Having the IRQ handler called when enabled IRQs arrive should be considered
> as a feature not as a bug. So do not BUG() there when this happens.
>
> Fixes: 3717194f24922 ("Input: gpio-keys - add system suspend support for dedicated wakeirqs")
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/input/keyboard/gpio_keys.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index fbc31c5db3db..f1c31c5366f0 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -412,7 +412,7 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void *dev_id)
>  {
>  	struct gpio_button_data *bdata = dev_id;
>  
> -	BUG_ON(irq != bdata->irq);
> +	BUG_ON((irq != bdata->irq) && (irq != bdata->wakeirq));
>  
>  	if (bdata->button->wakeup) {
>  		const struct gpio_keys_button *button = bdata->button;

Doesn't gpio_keys_irq_isr() have the same issue when a wakeirq is
configured for an interrupt-only button?

Also, neither gpio_keys_gpio_isr() nor gpio_keys_irq_isr() uses the irq
argument for anything else, so instead of expanding the condition, could
we simply drop the BUG_ON() from both handlers?

Thanks.

-- 
Dmitry
