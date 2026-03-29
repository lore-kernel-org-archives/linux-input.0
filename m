Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904B13043CF
	for <linux-input@vger.kernel.org>; Sun, 29 Mar 2026 22:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774823940; cv=none; b=OxHdnjMmQbHuiu04wGOJKebDIaTlv3VC89vPXFi2kwyEkzTfoVX4dZV36FKL9zlofvySR9RySX/WkpqxZgjPoTGRLgnaUYNRfa+EkatFz/AlWvvKfj87weNowxMC2cDXVvPnWHXQ6c7RfsuXZYpoUXJgXzgNn01CFfp6jp76exU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774823940; c=relaxed/simple;
	bh=i29DEr+cmezm28yicchzfOLgpY1e17qMsYz+akHVLMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmjbqIG0Xp04Z5BTVqfUUXWoIFGSxadNxF57slSRY8qxy9UuNmdZeLaJYtp3BnWHSYFbPw9G4Z/0hidtRr69TfwcbImOechnrRLz6zFDNWu2wnwPyfWoBHBu9pro1aUenhJxLU7BmF0msSKDk3iQEP5TFfSwpgccAHNXpyOqYTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a85LHOyH; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a85LHOyH"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12732e6a123so1787018c88.1
        for <linux-input@vger.kernel.org>; Sun, 29 Mar 2026 15:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774823938; x=1775428738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mIaCRwsPiPLGbHW57vve74Uei7PyZwajOXtEVAjCMmE=;
        b=a85LHOyH+4K7mj7zgCILRDQ/Q4Q/mEgptLKc8va27S0sLXjfSmYkvBXujQ4Z8SyFcu
         EPpTKHaIzrAm/HJIZZT/7u/Fx4oBX1b7WXJDyhv3mQvYtdG7OkG4YzJtwOfNu6ZaUjCJ
         Srwn3Avm9v30sKjDlQ2lJZzri72n9b5NLRCyspb5pXQxx3szjwtBVEEHBsyIx91PiORl
         J4jPWuScqu/tdNHKD+ExOuROfmztCOyJIpa0nexyczDwFkRrcwOaOqXb7JZkQlhjCA1p
         DziKNlsHsBaHZCsvuBE83MqQLgjXQISpFRSOztWGIkbPmHi64FRPDHxRDRMfYN4KCPtb
         8Nsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774823938; x=1775428738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIaCRwsPiPLGbHW57vve74Uei7PyZwajOXtEVAjCMmE=;
        b=oimH6Lw6/ddy50uVSvSB6S00K9MpD1fx+q2DEWeeFrNKa1pJnLzrqdC+8XFccuM0RQ
         cPhIMsY0pQEoH5BS2vJU1leC8PzScTXWAFnPVOTgBD3IkepnZsyMUrJhxa9ThJB6q35w
         wfQBsqlXNX5iBSlvSYj13+xCCsq1KvWFXgGvo4dhsGb+yrBSMw4sBYROm7aibki6Re21
         UzsI+uLyZ3K+T9VLfvy3j+1b3IO9S3VOz3P/fBJ1Vzkh6QhrCuXhRkdwxxntXGyfZdoj
         xkJcHs9y2N/8iggO0kZfCsl+xVOMrKR0Ll0d5xXJL39PGNCjMgrIJPCph+lUxGTxyOms
         pxUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtscWUL5B9odqFUtY44+vxR/povvBtcc/OA2G1k3QM/U+khO4/sx61cBgBUz7FlU6qW8x32M8Vx5P06w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDgAKClrSyAK0P9VLqCtA0xj6hjoTBrH8xkUDKVTyiIiadh5FL
	mvPuo0AnZPbmUl5pI24YwcewNnedIk4fk6l4vxe1z3wF+k4Imng/lXlr
X-Gm-Gg: ATEYQzyv5uguEcaW76aMSnYbII2QWIyLq987teEb7Kt/PtPGeZdkpxizGTmd/IfPJeU
	vdTj8nVLXA72Bor/dk3vCfkeHWDB6WSWN25EGf3OeaTsMe+n4MPck4GOa6f2lsOkW2M5oD/Pf9u
	3IribU2NLl82zdWWyFgcHKxzksiCxNzbNvb9qEu3EcdfmzGyvuh1OGyd1DohC+B0ylbmcwuMA8I
	468UoofIQ+qYsIgZ5cEJRcCfTiQFLCAwA+wNIdBaw08y/6xZXsbwjxEpDue3hr5Jkj4B/bC263j
	LrNn7xLnpvo9Mf1PVjyTjK3WtGngT/jEWPxGLZsFlMtMo5aSRH+xAAodmvT29YnXJhImqm8KAJY
	0CTGog5YCypAefndSL5SBkNYrDNE63Atb6e53o+XAMxlCCxcbzS6f3aKdX+CUi1eet0yZ2SRWsX
	9OujZKuUFYxnhlNFK6vhSd6THMup/zCoLMMLTRjG9ZlArDZEI6iX4/9KZye/8sBoeO
X-Received: by 2002:a05:7022:6190:b0:11a:641f:ba11 with SMTP id a92af1059eb24-12ab2928cb4mr5161322c88.29.1774823937606;
        Sun, 29 Mar 2026 15:38:57 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:7265:773a:8e51:c62f])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab983f9f3sm8212926c88.10.2026.03.29.15.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 15:38:57 -0700 (PDT)
Date: Sun, 29 Mar 2026 15:38:53 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Bartosz Golaszewski <brgl@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	linux-mips@vger.kernel.org, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH 1/2] MIPS/input: Move RB532 button to GPIO descriptors
Message-ID: <acmo7_clKRWzhyOi@google.com>
References: <20260328-mips-input-rb532-button-v1-0-98e201621501@kernel.org>
 <20260328-mips-input-rb532-button-v1-1-98e201621501@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260328-mips-input-rb532-button-v1-1-98e201621501@kernel.org>

Hi Linus,

On Sat, Mar 28, 2026 at 04:55:47PM +0100, Linus Walleij wrote:
> Convert the Mikrotik RouterBoard RB532 to use GPIO descriptors
> by defining a software node for the GPIO chip, then register
> the button platform device with full info passing the GPIO
> as a device property.
> 
> This can be used as a base to move more of the RB532 devices
> over to passing GPIOs using device properties.
> 
> Use the GPIO_ACTIVE_LOW flag and drop the inversion in the
> rb532_button_pressed() function.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  arch/mips/rb532/devices.c         | 47 +++++++++++++++++++++++++++++++++------
>  drivers/input/misc/rb532_button.c | 35 ++++++++++++++++++++++++-----
>  2 files changed, 69 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/mips/rb532/devices.c b/arch/mips/rb532/devices.c
> index 4f027efbf27b..3f56d9feb73a 100644
> --- a/arch/mips/rb532/devices.c
> +++ b/arch/mips/rb532/devices.c
> @@ -16,8 +16,10 @@
>  #include <linux/mtd/mtd.h>
>  #include <linux/gpio.h>
>  #include <linux/gpio/machine.h>
> +#include <linux/gpio/property.h>
>  #include <linux/gpio_keys.h>
>  #include <linux/input.h>
> +#include <linux/property.h>
>  #include <linux/serial_8250.h>
>  
>  #include <asm/bootinfo.h>
> @@ -38,6 +40,10 @@ extern unsigned int idt_cpu_freq;
>  
>  static struct mpmc_device dev3;
>  
> +static const struct software_node rb532_gpio0_node = {
> +	.name = "gpio0",
> +};

You need to move this and registration into arch/mips/rb532/gpio.c,
export it and use it here: Bartosz is against using gpiohip label to
match with software node name and prefers identity matching.

...

> -static bool rb532_button_pressed(void)
> +static bool rb532_button_pressed(struct rb532_button *button)
>  {
>  	int val;
>  
>  	set_latch_u5(0, LO_FOFF);
> -	gpio_direction_input(GPIO_BTN_S1);
> +	gpiod_direction_input(button->gpio);
>  
> -	val = gpio_get_value(GPIO_BTN_S1);
> +	val = gpiod_get_value(button->gpio);
>  
>  	rb532_gpio_set_func(GPIO_BTN_S1);
>  	set_latch_u5(LO_FOFF, 0);
>  
> -	return !val;
> +	return val;
>  }

I suppose there is no reasonable way of making this work with
gpio-keys...

For input piece:

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
