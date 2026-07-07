Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9541823183F
	for <linux-input@vger.kernel.org>; Tue,  7 Jul 2026 04:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783400078; cv=none; b=BKGPZDNTQAWHtVg7bGTUKp1WB+pJIlC13hSTnQqmFOtGY2KxaPzzKiQ5B5v+VEUTqIn6SI+8VbSEK4tSfY6+3fthKfWDx+pS+KxLiuHdCJptiJ+YcAtO3sq/zwFPoe34YU4OCRQvxHv0WCaUfyzD1kq5PBmMRGESBBl29R4pNhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783400078; c=relaxed/simple;
	bh=kb60zbfA89OyEA3MIB/FOsifXnD30hWKiiEVbRbkXjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKDANa4y2mF12OctdFWfjSqDz9jUSc+LdnDsUUOYuYUjqb8U0icNBzsLSuFUitFuQqZZJGdE60V1QZJoQXIoTNS7C1r6o3HimWuzEly9nCqntRgJ9tUAL2WbukqkmvuXSmn9yr3oODPkaGNZst33t94bY61vD04uZtTlj9HoklQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUo2m0y5; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUo2m0y5"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-847d1e9db22so4096872b3a.2
        for <linux-input@vger.kernel.org>; Mon, 06 Jul 2026 21:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783400077; x=1784004877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ibd+yXAbv6+zm2PGw2sGUeLwGtlFhz0ZTLec7wv+mwQ=;
        b=cUo2m0y507UYqOIc69HmEZy+fW2lgrgsDJ6z8MzW/D4d+AWDV8nnrVfZhazY9K2GU1
         aBKGbLl6j10FC1//H9ZUHp1nHUDTLMweZlWrtF9V+iJHT/NGoadddAsYI7ZvGJ/1SoRK
         R99Y411nEMD0Plb2qEpQ4lzCV3eWaj7sz2bK9e7BTdHUneU7R2ULBo9blwjaT7Zd72QT
         KlA897BvK3eRmZAwST1zNNfnzk3rK47flNUL2hwKieawpU67NNUkcROvHvrLvgCkbO34
         6SA4g/FKN62BugkxBJLKkivr9qKfxHAOJtqoWoto0ghuNytzqwn61Pjp5ofrfDRaACIB
         2acg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783400077; x=1784004877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibd+yXAbv6+zm2PGw2sGUeLwGtlFhz0ZTLec7wv+mwQ=;
        b=Q3JSK2OekBZVZBMmr5lckerKAb+Zo4mKzDx+cD57W4D4xOt+mDOnkak8TDLySpompO
         Oe1xYIN/8vXaSF55I7A76Yyl42cYdh4ID+I8tTBgkpUzj2VKiExCKzb93z/lzfNS2/B2
         E2WZEVVhfTZsjmmn/Ntg4Q3wwo7a4WUf4Z0Bb2BuvnuBYn0j/An5owbNAYELkPtwPtBO
         G1vZ/+i6hgkWv7+uwdiyYl3akuhGZIWSv7FjpmeK6t0gJElwcfJoD9h8hV2GuUJBsUnB
         vVugPWrToPQ7isUy57RjDXgzx+BadGQlihoxXOI93enQw9i2cgnCKEeSTaeJf+Rt37yx
         5jUA==
X-Forwarded-Encrypted: i=1; AHgh+RpkJEnbyu6AzOOMCzcu6i+YSDhCYb0wazzgZacIVYQ4ONG2cnB40EYNKWyiv18mA0CVjdXIxCA/XN9psA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9eAXS+Mk/maWpx8ZHshASh0ZfEtmGGO77FqJ1VIhEZkWw43qS
	/LUFa10v0dwQ4lTL+VvspyQprT2tXIdJOJjRihAlDyNOH3+gA8qKNTPK
X-Gm-Gg: AfdE7ckjlTaCppakvgAbpXS7Wbdr+igySXatFuHe2a90N3tvATnhgiZtnr0SWSRzwSb
	zC3LslST8Y/RPVmpPpD7z89k1cG2+hWFugtpGeCSuO3AO2Wkp6xjTA8qBKKhFwWX/5RVEW0wJka
	QYBeP3HiIz2b6843dG3yWDwFeXVzstwhNNviGp/v3vOq3FmTvkAKE2oCEzGggu2iPuXybPT4iFv
	oRnqa1P91FPRycCNDp73B/L28Y3EVQZvmCOZgIGYvAn2mYMCvYQq/HWusQKyo+Tdv+m2bK4hAM4
	h7jzkpwTWqRO/etNHSJ7OHxyCwb4gjFWbssLatDTxe/2mtQt9i6LBYR42k9iX8tKRdPPbwAeQEk
	jxJIytNxM7HhER8hWEaVzBsWU1m9qbUKcei2s/oge4ygJl86MZU5wLRxj5RAvOPm8jIz2nNXOqd
	i8Yud55LTS47knCEG09cIbmsQr8X8Ox5lDCTUcvXKV97lvXJloTdIeWA==
X-Received: by 2002:a05:6a20:7347:b0:3bf:b1f4:747b with SMTP id adf61e73a8af0-3c08ed0f571mr4685540637.12.1783400076823;
        Mon, 06 Jul 2026 21:54:36 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:d89b:1fdd:a8f2:dbeb])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b6593c9a1sm4161788c88.2.2026.07.06.21.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 21:54:35 -0700 (PDT)
Date: Mon, 6 Jul 2026 21:54:32 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-input@vger.kernel.org, 
	Hans de Goede <hansg@kernel.org>, Jin Yao <yao.jin@linux.intel.com>
Subject: Re: [PATCH 02/10] [v3] input: gpio-keys: make legacy gpiolib optional
Message-ID: <akyF3Log1X8_FGIB@google.com>
References: <20260520183815.2510387-3-arnd@kernel.org>
 <20260530004519.1C8E81F00893@smtp.kernel.org>
 <dfe153e1-a3d1-4dca-a59b-59899082c4e9@app.fastmail.com>
 <ah-1z9LhVG0wtfBw@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah-1z9LhVG0wtfBw@google.com>

On Tue, Jun 02, 2026 at 10:10:28PM -0700, Dmitry Torokhov wrote:
> On Mon, Jun 01, 2026 at 08:32:31PM +0200, Arnd Bergmann wrote:
> > 
> > Hans, Dmitry, do you already have plans to deal with the
> > soc_button_array driver to move it away from legacy GPIOs?
> > 
> > So far I can see four possible ways we can deal with it,
> > but none that I actually like:
> > 
> > a) delay the problem, apply my original oneline change
> >    to 'select GPIOLIB_LEGACY' and fix it later, so we
> >    can make GPIOLIB_LEGACY default-disabled in 7.3.
> > 
> > b) add a gpiod member to struct gpio_keys_button and skip
> >    the intermediate gpio number here. Clean it up later.
> > 
> > c) always pass the gpio as an interrupt, as the driver
> >    already does for some machines
> > 
> > d) add dynamic device properties that duplicate the
> >    information from ACPI/DMI, so the driver can
> >    stop using platform data
> > 
> > e) disconnect gpio_keys_button from gpio-keys.c and
> >    register the buttons to the input subsystem
> >    directly from soc_button_device_create().
> 
> I tried doing e) and while it is possible I ended up re-implementing
> most of gpio_keys.c which is not great. We still need both GPIO and
> IRQ-only modes, and handling debouncing, both software and hardware, and
> so on. So I would like to see if d) is possible. The problem is that we
> need to reconstruct GPIO reference from existing gpio_desc. If Bart will
> be OK with something like below then I think the conversion should be
> achievable.

It turns out Bart was not on the CC list so I was waiting for response
in vain...

Bart, will you be OK with something like below?

> 
> gpiolib: Introduce gpiod_get_software_node_reference()
> 
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> To support converting drivers (such as soc_button_array) to use static
> device properties/software nodes, we need a way to reconstruct a GPIO
> reference from an existing gpio_desc.
> 
> Introduce gpiod_get_software_node_reference() which populates a
> struct software_node_ref_args with the GPIO device's fwnode, the pin
> offset, and the appropriate active-low flag.
> 
> Assisted-by: Gemini:gemini-3.1-pro
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/gpio/gpiolib.c        |   35 +++++++++++++++++++++++++++++++++++
>  include/linux/gpio/consumer.h |   12 ++++++++++++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 1e6dce430dca..63cef0fb02b5 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -247,6 +247,41 @@ int gpiod_hwgpio(const struct gpio_desc *desc)
>  }
>  EXPORT_SYMBOL_GPL(gpiod_hwgpio);
>  
> +/**
> + * gpiod_get_software_node_reference() - Reconstruct a software node reference
> + *                                       from a GPIO descriptor
> + * @desc: GPIO descriptor
> + * @args: Pointer to software node reference arguments structure to populate
> + *
> + * This function can be used to construct a software node reference from
> + * an existing GPIO descriptor. This is useful when a driver wants to pass
> + * a software node to a secondary device, but needs to reconstruct a GPIO
> + * reference dynamically.
> + *
> + * Returns:
> + * 0 on success, or a negative error code on failure.
> + */
> +int gpiod_get_software_node_reference(const struct gpio_desc *desc,
> +				      struct software_node_ref_args *args)
> +{
> +	struct gpio_device *gdev;
> +
> +	if (IS_ERR_OR_NULL(desc) || !args)
> +		return -EINVAL;
> +
> +	gdev = desc->gdev;
> +
> +	memset(args, 0, sizeof(*args));
> +	args->fwnode = dev_fwnode(&gdev->dev);
> +	args->nargs = 2;
> +	args->args[0] = gpiod_hwgpio(desc);
> +	if (test_bit(GPIOD_FLAG_ACTIVE_LOW, &desc->flags))
> +		args->args[1] = GPIO_ACTIVE_LOW;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(gpiod_get_software_node_reference);
> +
>  /**
>   * gpiod_to_chip - Return the GPIO chip to which a GPIO descriptor belongs
>   * @desc:	descriptor to return the chip of
> diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
> index 3efb5cb1e1d1..c95b715a1d15 100644
> --- a/include/linux/gpio/consumer.h
> +++ b/include/linux/gpio/consumer.h
> @@ -11,6 +11,7 @@
>  struct acpi_device;
>  struct device;
>  struct fwnode_handle;
> +struct software_node_ref_args;
>  
>  struct gpio_array;
>  struct gpio_desc;
> @@ -177,6 +178,9 @@ int desc_to_gpio(const struct gpio_desc *desc);
>  
>  int gpiod_hwgpio(const struct gpio_desc *desc);
>  
> +int gpiod_get_software_node_reference(const struct gpio_desc *desc,
> +				      struct software_node_ref_args *args);
> +
>  struct gpio_desc *fwnode_gpiod_get_index(struct fwnode_handle *fwnode,
>  					 const char *con_id, int index,
>  					 enum gpiod_flags flags,
> @@ -545,6 +549,14 @@ static inline int desc_to_gpio(const struct gpio_desc *desc)
>  	return -EINVAL;
>  }
>  
> +static inline
> +int gpiod_get_software_node_reference(const struct gpio_desc *desc,
> +				      struct software_node_ref_args *args)
> +{
> +	WARN_ON(desc);
> +	return -EINVAL;
> +}
> +
>  static inline
>  struct gpio_desc *fwnode_gpiod_get_index(struct fwnode_handle *fwnode,
>  					 const char *con_id, int index,
> 
> Thanks.
> 

-- 
Dmitry
