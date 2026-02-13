Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1796928D8D0
	for <linux-input@vger.kernel.org>; Fri, 13 Feb 2026 20:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771015721; cv=none; b=aB97CG3KKixIVlyXgVPBIXoZPfgUbRFrKcbxlYX7QG3sdPJCjtRPLMGKsCqabud+DEFfOQ9IHX1/bnwcHycxDEjr473qyXNZoPGXobIO1HAstZ/V07k1/Q+nHPgO0icdkDmLsMqJmcG31IQLav5hHCyjG9hCZJsPg4Pv8ABeM60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771015721; c=relaxed/simple;
	bh=W/pVJt/wvydYWWC0lqeyhGED8yc2b22X0xX48t6bb+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHt5xttMTT4PzVgszMtz0YJV5GPRc+uTQQCyPvMNfQqcP5+N/qMLkxM+fjYxgz+QsGsqjs3hXTHhLJrUxkawUyRir824K8QycmzWyOqYKfTE8GbFS2zv3SvkW6zbZhCX2REs6xD8Nhc6dxQ5MWZ/b6R5MM6M7xY8ccgCcQWYr2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bs6TGQ7w; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bs6TGQ7w"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8850aa5b56so189238566b.2
        for <linux-input@vger.kernel.org>; Fri, 13 Feb 2026 12:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771015717; x=1771620517; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/XdoMoffXlEUCxzIMNRrk5M4zeOLPJRBb48+Cvgmzlg=;
        b=bs6TGQ7wFugheoZ1dqFDoje9ij5UghWUG3iJPbIoWdGR8ijQO+Lss/6zVNbCXMA8+S
         QGPKf/U9kT3QSIeWwyT3ICYMxUn0U6+LPinkv/LS6OqDBlzD+KsTBbCXndXHBEBZqFMN
         k7gaJ2Ts7yIq+nKAQZRmaEn4Xo0w4BotOeDUNxoYh/EOFoGPHb6UG5M/qN/9zwe9aj8P
         T+Gon9f2rY1OWirMAaaSgvKRlH5XWjYaoMiQqnaht0VE/sLC/xKPWg7nOF4q5hEXvAvn
         LxUae8mNen8WsihdzLkqrCVmhj/xtRYsux3HpuZ/Xo2oFe+GG6TQTRF1SR0Xxp+F0CPF
         HuRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771015717; x=1771620517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/XdoMoffXlEUCxzIMNRrk5M4zeOLPJRBb48+Cvgmzlg=;
        b=p14UZ2x1Sv4MdBDbvHW6iIFNFB0YLnIZuCg1vessDx/wGD5TSLXFfXaTudTsfULeCh
         LowNF/rT7B1p5w/ig5VMGyHwfwErwGX80pQF4CY/bYX1Y1ZI308zzNYYyRRFPnt9/uNH
         eoMv3UJQkcaRwUvwYylvMEJw10J1js3ivReJryaYG01ts04ydHo1yp6qqxpsTMBp5/0i
         Z9U2Row/Ub0FmDgSzGE8po4e1lGcRuT+HUIYSe//3rvEZCPRSB1bG3cVy6AEM/xwdWaW
         tyP4tWuToFHbdDohYRUJLojdJ/D7pETwsqySjrqzsUa7vDQEhDb6ap+IMkuJj50VBzmo
         BdVA==
X-Gm-Message-State: AOJu0YzEVXXtIA9IQjiSJgugt3y7SeDqyM5B4dU0Uj1RjyHOVQIXnFN2
	d9iPChBIIlj4QCNuoxseZi33SnynwfNClq4yvSJ3GiWdm8fJMuPb5Z6UVu4IFw==
X-Gm-Gg: AZuq6aLl9+6PnETLO8jQeoEDHf5hPZ+khjYKADfzbDiNmsGnKOEIPcQSPA+8TkFB1LV
	ZWy1RCrJJax64Hdyr47hXQlk10GF8QmpwkpDFeGNcn+6+L/dEoVa6UiYB+xo2WbYkzkHK4Vygyw
	geqBavyiWmkyHnN4FvEVE0f5nDu9RGgnxNi9qFvcKB/Q+o8JnSoX72jbTk6ahBdEvmq2TTbUX2I
	6gcSQJzYQKI749zW/MSwppuUyeVnetboSw6n5nGFkIVhhKC/lWZ2pfLJ4SdhNOGMXQnLzICPNkc
	K6RSee79mzfJZXCFahxxvDI9HAJopBngNuPWs2yIvho5QktDkKfSaVRQe8Akqf05LjWbiBQBCqu
	nMfgkcTghwIBBg039iV+a7+v6+3KktCdtV979SLAUGIZc49WzMmvFPOzAL+7yxfY/2cZmClCUFs
	H0Ba8CiRd3wzHJtA==
X-Received: by 2002:a17:907:7fa5:b0:b87:1d71:f44d with SMTP id a640c23a62f3a-b8facca14bemr223447866b.11.1771015717211;
        Fri, 13 Feb 2026 12:48:37 -0800 (PST)
Received: from jekhomev ([46.251.53.180])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc7385f5dsm878966b.20.2026.02.13.12.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 12:48:36 -0800 (PST)
Date: Fri, 13 Feb 2026 22:48:36 +0200
From: Yauhen Kharuzhy <jekhor@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH 2/5] input: drv260x: Add support for ACPI-enumerated
 devices
Message-ID: <aY-HibKtT-thpaoS@jekhomev>
References: <20260211235902.4156624-1-jekhor@gmail.com>
 <20260211235902.4156624-3-jekhor@gmail.com>
 <aY4MqXG2zr01Pk4Q@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aY4MqXG2zr01Pk4Q@google.com>

On Thu, Feb 12, 2026 at 09:26:24AM -0800, Dmitry Torokhov wrote:
> Hi Yauhen,
> 
> On Thu, Feb 12, 2026 at 01:46:52AM +0200, Yauhen Kharuzhy wrote:
> > Add ACPI ids and GPIO lookup mapping for drv2604 haptics device.
> > Found in Lenovo Yoga Book YB1-X91L tablet.
> > 
> > Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> > ---
> >  drivers/input/misc/drv260x.c | 30 ++++++++++++++++++++++++++++--
> >  1 file changed, 28 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
> > index 18360bdfe877..f613c81fa2ba 100644
> > --- a/drivers/input/misc/drv260x.c
> > +++ b/drivers/input/misc/drv260x.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/gpio/consumer.h>
> >  #include <linux/regulator/consumer.h>
> > +#include <linux/acpi.h>
> 
> Sort alphabetically please.

Sure.

> 
> >  
> >  #include <dt-bindings/input/ti-drv260x.h>
> >  
> > @@ -419,6 +420,12 @@ static const struct regmap_config drv260x_regmap_config = {
> >  	.cache_type = REGCACHE_NONE,
> >  };
> >  
> > +static const struct acpi_gpio_params enable_gpio = { 0, 0, false };
> > +static const struct acpi_gpio_mapping acpi_drv260x_default_gpios[] = {
> > +	{ "enable-gpio", &enable_gpio, 1 },
> > +	{ }
> > +};
> 
> I'd rather move this ACPI/device-specifin handling into drivers/platform/x86/x86-android-tablets/lenovo.c

I am not sure if this is device-specific, but since there are no other
devices with a DRV260x ACPI entry, I may agree. Will move it.

> 
> > +
> >  static int drv260x_probe(struct i2c_client *client)
> >  {
> >  	struct device *dev = &client->dev;
> > @@ -426,6 +433,14 @@ static int drv260x_probe(struct i2c_client *client)
> >  	u32 voltage;
> >  	int error;
> >  
> > +	if (has_acpi_companion(dev)) {
> > +		error = devm_acpi_dev_add_driver_gpios(dev, acpi_drv260x_default_gpios);
> > +		if (error) {
> > +			dev_err(dev, "can't add GPIO ACPI mapping\n");
> > +			return error;
> > +		}
> > +	}
> > +
> >  	haptics = devm_kzalloc(dev, sizeof(*haptics), GFP_KERNEL);
> >  	if (!haptics)
> >  		return -ENOMEM;
> > @@ -484,8 +499,10 @@ static int drv260x_probe(struct i2c_client *client)
> >  		return error;
> >  	}
> >  
> > -	haptics->enable_gpio = devm_gpiod_get_optional(dev, "enable",
> > -						       GPIOD_OUT_HIGH);
> > +	haptics->enable_gpio = devm_gpiod_get_optional(dev,
> > +			"enable", GPIOD_OUT_HIGH);
> 
> Why this change?

A good question. Looks like artifact from previous development
iterations, will remove it.

> 
> > +
> > +	dev_dbg(dev, "Enable gpio = 0x%p\n", haptics->enable_gpio);
> 
> ?

Hmm, looks like a forgotten debug stuff, removing it.


-- 
Yauhen Kharuzhy
