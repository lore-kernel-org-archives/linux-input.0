Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793897187;
	b=adV9ke7NDKrAGY0wdlpoAGUT6dIuHrJKm8LOsH0+U3b0ivfmFIjPeeojpl89zqhjNHTM
	 Z66h7Q5txB3G47Oh/LDDJGKJZH6OTqN/FumBuNauZZlL9CFDjrWlTxWYpyrF1zc/Z1eLp
	 q609P2jAydafjaYVaKro4D+0uirYNOf2ZPiiQdQ6B+znhMX5YlNpTWR+/s4Grunx6+KZM
	 r22/Pu7U66+l1+7fPgIAIMtDtfk5BOIuEDzIYEB3ToseeK8AXCkkyI0e598zY4EqGHVHv
	 G1Ezu19R2OFqyUylX0CuaFde5LVnFgiQ+OFXHGiY+0CXb6lFiJqxXEqUTPKrkzepMVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897187;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=UephkWnsxE2cWbdnAcjd07eNbKg68ODRUaQObxWfBXI=;
	b=jQD+Ajlb/oqiKF+EEfPBa1mXzmPbnOfYUUFq+26VKnR3EN09PpXzii2lw8muzaoFtNrN
	 9YYIR+Au5hlLQ6+vtlkZw2LM6qYXo7UhbCNQ4kAkEa/iPmpOypm26MTXO1J43FErWv7qK
	 9vdr/S9any/hvp9bcS+mlFHcgc8B0rbjHj86AaRyh1PZXPVGuFvk/7AkgjAqYZGutNv8V
	 SfyPkggfqJFq1vtD1+3WI2Wh4sUzZDwouDq71VxwocV0wzN5y3S26B02p2ia2GvEeIIAd
	 WL0BL7KC1yfurziGCH2v1vqggaufX4gCrbsvSK/CWmb6G3xf1tEEkuZfh99ULSZ3Cbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DAT3jIBB;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E66B606A326
	for <linux-input@vger.kernel.org>; Thu,  5 Nov 2026 16:46:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E66B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DAT3jIBB
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1ae18eb9ad0so2464888c88.1
        for <linux-input@vger.kernel.org>; Thu, 05 Nov 2026 08:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793897186; x=1794501986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UephkWnsxE2cWbdnAcjd07eNbKg68ODRUaQObxWfBXI=;
        b=DAT3jIBBkvNW/TMlLUjOwalpPJ39DN//fNGPXUoo1TJ2h7XXmxbcIR390H1qNU3e8n
         nEv8qPHmAayMiF1xjnCFpp1LZgPfvfQ9kMMXEC3Gla9aWSXKmiEDhbFdcmjer03dVf8O
         TtNLR25KpRuhJLgYKKA0APgjARtn+ClddowT6lsPlSjjIrH8p4v4kXSlgm1fAjpyAMYi
         F6HirblkwzkTmR2t987KC+OtDjT1X+KmVBct6JEqYsf8YOPpP3hRrmd+RWuWcgu7fn6Y
         xf1jkAA+KdIcrYU7pX4Dm07mAA5CNNptK/dzuFMB6Tx59eQ6gmz/lHv2pA2xechYJVJO
         6XKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793897186; x=1794501986;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UephkWnsxE2cWbdnAcjd07eNbKg68ODRUaQObxWfBXI=;
        b=r8rNRmV662kk5L8L4Pkl5kX3Q2WvIwBau0CYd2upKPqXqoo6ix/ntY0ZZEGQYBLQLI
         RNH/zn1Q4N79KZD2GU2OUYssgJcSKmfni6LtoOKZemAY3GQOVXoI6o71kc56OuYckBxL
         yTtPkiqfF1wKEDBLimMPXTMlwWX6VSPPRaVN2wb6paYkcQUN+kaO2kwEznEOQJLvXYYU
         v0WCrHlEt4mUVApl86fj0Szmnuo9ZecCNKZ8saJtVWLh6l5qMM64eVRXRBPNg6IOPfVq
         DWRgkZMP+qqSyzE1aiKg/TQLMr+2t1b72+U5i9d1KOFlRHwwn13dTd1LFUhzB6BVU0Wz
         nLwQ==
X-Forwarded-Encrypted: i=1; AKwUvBxcpkmJ4+Fl606MCk0BQuG0QBJAzDeDZT9nRtSlCXiacISRTRsHyh8fML9irx/sOphAAyw1ehsax1u+Hg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8xqQYJD4xZPbJL/bBbGjTSR1Tl+tUc5dOVSnb9fhCfnK4onI58
	uELu2ESfqLtVfIYqrDfP4ucfYGwM61FwSCr/8RLdSrvLQuSiqtbjA7Vk
X-Gm-Gg: AYBFou3JS7U/42spW2IoNArm0/3Oy1oqI1GzUPwkSBv5WL7CYo/38nINSL6fJ0tbNPf
	jLgu3hNLSeXwZz4F90RLbSpkf8qrN7xeIAQFD/y/OXrPioZS2rA/LXNWBEOdTZEZPBNV41WYNBQ
	Ki8IntQ+I41CaqjqzPuKRdDbf0Jj6pSfJjn9SnkdnlCddwzvQiFVvnElddc9DHyhPCyDvAXwA7V
	l76tQkRotG/kiZ7q1VuexKUCmbTucw62/JEDzSa5GHuH2IRjGZ/N6BrKayui1NRNQ8RLz35zKj3
	EJEQHx6igSxzgP64y9lqI+VKJ4hkUYg9/JMDe8busnmwOsd108QL1W5W4uVj5rmVt2A1CmyrBg9
	UIEsUHEv0bq8SCX+xLK6lr3Umvs6OlhcSxh/8QPJu4Bc9VaAM5Y41aTuZUGTg27MYl8FL6tnoOU
	j95PXRjfG/JjlkgIRjI90fjdIg0ogdFvQ05N7b8q4OUPr5zWmlZbEIhaLOkfEgQrjgr8IUt9ZY4
	ntyYphFZvvCRMw6ghIuE5tgsio3GY+IIMtZKabVB1TE1fLqyzJJJsul2OD61t5YAaDBUxfz1m86
	/Jx7WZaWCLdF3Vl+YpF53J6WMggqgxZ+pZgFguOK47lpOKq8Vz51PMaGCkcyaS7ThGSyzA==
X-Received: by 2002:a05:7022:108c:b0:163:c5eb:d42f with SMTP id a92af1059eb24-1ac574551afmr25949024c88.5.1793897185745;
        Thu, 05 Nov 2026 08:46:25 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:c8f4:b7d9:252f:4483])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25100667esm9417659c88.19.2026.11.05.08.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 08:46:25 -0800 (PST)
Date: Thu, 5 Nov 2026 08:46:22 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: bartosz.golaszewski@oss.qualcomm.com, marco.crivellari@suse.com, 
	arnd@arndb.de, tony@atomide.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, brgl@kernel.org
Subject: Re: [PATCH] Input: gpio-keys - do not BUG() on requested wakeirqs
Message-ID: <auyyyQN6_GIqeDox@google.com>
References: <20261104160305.2501369-1-andreas@kemnade.info>
 <f5c1435fbfa7568a107c864781897d6e@gmail.com>
 <20261105071952.33c39dd8@kemnade.info>
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
In-Reply-To: <20261105071952.33c39dd8@kemnade.info>

On Thu, Nov 05, 2026 at 07:19:52AM +0100, Andreas Kemnade wrote:
> On Wed, 04 Nov 2026 14:28:15 -0800
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > Hi Andreas,
> > 
> > On Wed, Nov 04, 2026 at 05:03:05PM +0100, Andreas Kemnade wrote:
> > > Having the IRQ handler called when enabled IRQs arrive should be considered
> > > as a feature not as a bug. So do not BUG() there when this happens.
> > >
> > > Fixes: 3717194f24922 ("Input: gpio-keys - add system suspend support for dedicated wakeirqs")
> > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > ---
> > >  drivers/input/keyboard/gpio_keys.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> > > index fbc31c5db3db..f1c31c5366f0 100644
> > > --- a/drivers/input/keyboard/gpio_keys.c
> > > +++ b/drivers/input/keyboard/gpio_keys.c
> > > @@ -412,7 +412,7 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void *dev_id)
> > >  {
> > >  	struct gpio_button_data *bdata = dev_id;
> > >  
> > > -	BUG_ON(irq != bdata->irq);
> > > +	BUG_ON((irq != bdata->irq) && (irq != bdata->wakeirq));
> > >  
> > >  	if (bdata->button->wakeup) {
> > >  		const struct gpio_keys_button *button = bdata->button;  
> > 
> > Doesn't gpio_keys_irq_isr() have the same issue when a wakeirq is
> > configured for an interrupt-only button?
> > 
> yes, it has.
> 
> > Also, neither gpio_keys_gpio_isr() nor gpio_keys_irq_isr() uses the irq
> > argument for anything else, so instead of expanding the condition, could
> > we simply drop the BUG_ON() from both handlers?
> >
> Sure, was just unsure about the intention of escalating things so much here.
> I think we should trust the interrupt system a bit.

Will you be sending a new patch?

-- 
Dmitry
