Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792601768;
	b=I02HzutM8+aT+QOQGWw4vYrpf6LVJHWNUtuhoi6V4DN4sPHphPjhSREi6UtEA5pnclwm
	 mZufD452eaXc3pspaYheY4vFPe0TDiqAHOBMeu1yyeEQbx83M8Xe4O8hmDQ5KV54PZthK
	 e5v1MAjnvL4obg/TJUQBdc979cLPoTUgPMlhbgZv0/H9nNX1xSusKVg1fp9P7pjVqCnde
	 HWa6Bj7iLUjdsdTfbHL2laYj8irp4OmJl/gqye2qHJDJ5pDKC0tyLSHQJKQzhhhqakHKE
	 jzve6Gi0l6eOxKGSKwcOeXZe33QMDjvRNzqcjgmBntrX+V6moBA9Qb/yslW7uaXLHtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792601768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=BqFxca6gK6ThfbYRhXakalZoTDjV2OaXfqMDjTk93C4=;
	b=vd4NUpVoAlSuz3+P75CxO7wM+Bd/W7FvAXOSnUD3ysJp4PwjVkekI2u+8dfsYhq/oOhS
	 vbnWoahOUqSJkzUj0bDw2Lylo2U1V5IenzVVsuQuURBNMAoAtXNwiyfEApceuFAzBShom
	 703MM73H1umTT82gX922JDa6w+i0NqTE2+YVUx91gZcDQ7vhnx5aKD8SDKfwL09pQJRKi
	 rkMihcLaj/1V5qmbjIRUqxVPbCFOx6OsC0vhgVAqUuMtncYdTTkveC9xUXx+gV5NqcU9E
	 4QbxvUUsHCaln1mJvaM5MxX3uMGwKQ09NX8rf5bIwwIzeF1nOW8uPa5zgI1K2SGwl1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="b47HAwz/";
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F65760A2606
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 16:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F65760A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b47HAwz/
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3282db206d3so2158742eec.0
        for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 09:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792601767; x=1793206567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BqFxca6gK6ThfbYRhXakalZoTDjV2OaXfqMDjTk93C4=;
        b=b47HAwz/VVcj8i8Dk6rywlLjp4QPLVE9QU/sIDpiX4l5uicFU6+OyIDhEv6/jeqZc3
         gDnlsX41vd9jS8QBqF5eWd0LEL7ObgKGc+mFe1J17hRYjevyusHa4RG6Bou9yDFMB+7H
         1ZX2qmpzbQuFCAWRa4FS1QfTA4DnlBvO1ZgiAtM3Z5SowmDDqNG29VsiLXZc/XgUQ5O+
         iAp/OmcJB+abmkYlNO2Nkk26Eh1FNrHWcRmxaaCR3H2KFKajAHxrDVISqotylsi7Xs3W
         PysGqH5xjgqIys5FyNfXPc0mTOYqh01SIjH96t/1KQEVQMDj4hztLVadfGy6lOdAAt1j
         XNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792601767; x=1793206567;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BqFxca6gK6ThfbYRhXakalZoTDjV2OaXfqMDjTk93C4=;
        b=fqDccVfWI2w8g/GtkIHmnBXb/puI4zvuqthnUEB1ESCzdc1lRg6JsxjlhAl33g9/Wb
         8t/sZnxP8XFUVSiESfcuo7dlfHabSV5H0h5ep86IOx1foW4QtuX3GYTTrmAROq1wduHo
         NjSxYlPxskE4iuGDgnAhwiJArgi2kIaJ+J1Dlk18AFnMFXZW1vsYTwU1BINdHxB/gfsk
         3MsahPtIxMJ1WL0Pmp7gN4NBiIVC+HmciWUVzBJoTyk7XlvM0jwr4SK5BAHhOYeSjwfL
         ezjTrghupdlCjBJ5g9HpXxwpDikmPyNYXYyv/G+hbBGBSl21icAceHfoBSEyuMzRyRvD
         e2aQ==
X-Forwarded-Encrypted: i=1; AKwUvBwB1cPwVQ2H0bFPal3GtejdZBRlhdsiH4l/5anks59TOUZaDoKhl9awRue3k3/KLYmCLjfKfU3NRGEevA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLjVLh8kvJpyS77HxjvGUxRCyJH4gQ6dOob1qRE6HUcnj9i4bSi
	T6xuSTleNWKk/VrJEOaKubl2KcADdA+uiQ2UwpB6getzJUMq/IgN0hw/
X-Gm-Gg: AYBFou1KM3eHbGVY8pwgHSCEct66cqKu73sTH++uNApPxVMu6QjWqIQs/bkizxmXuLx
	M/YOtYchgoyjzjeLa4t8tOhktLUySjDkWiC8t2IX+nUus7uVXXDMS8q153ZRhEO7lHkdSNuEDRr
	xTzJ7PNijgwAUwblmPa12mH76/f29nFD2bGxaBX9mOtn7Kd7nvhz9IwCDCjtejJQkmInRBGWGCT
	8009QbHTc/GaAh8ojRb3lOyeIFX9FHRvmyQLzQQw/GLysg/QwSoq6OToM07dIX20wFPhpxr4jcC
	UfpI798d/mdUyBS99U7A1DoNbqW3CmsJB/rEZAQOliJ1mnJd1YlrS01p5InMBIyqtmJU8k4keFP
	Fo5y/HMjbC/VDuHurJzF9exgzDL5HrCMm4zBOvzNVKNnjsRHHrbmrDIBmG+jOrS/etoqTrJMQTK
	nszEn1xbByfKVZWVIPQ7mYWh6vJzDQC4inaZE0ZyJqFo18Plvau1o1baUx5P/XqxULLvlQbj/Ot
	8l/lBOi7m4j5lJRKiIRZyWrATxTsiMXjlenABukXAHLMKuNZRG9PrIp5WrNsv39cgRdScS6e8p7
	Wo1/bEQ8J3DHmOtSWbKmCQ==
X-Received: by 2002:a05:7022:1709:b0:13b:4ab5:41d7 with SMTP id a92af1059eb24-190a051ddf3mr2928490c88.3.1792601767120;
        Wed, 21 Oct 2026 09:56:07 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:92d1:8038:c4e7:1f0c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903b3d0530sm7935669c88.11.2026.10.21.09.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 09:56:06 -0700 (PDT)
Date: Wed, 21 Oct 2026 09:56:03 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH 3/3] Input: soc_button_array - convert to software nodes
Message-ID: <atjuDNi0_SXs4y2d@google.com>
References: <20261021015004.1537738-1-dmitry.torokhov@gmail.com>
 <20261021015004.1537738-3-dmitry.torokhov@gmail.com>
 <CAMRc=MfZg36BULXh3n-ce_x_4B_xOn3Jp4Jgo5BN1LsB2FqaTw@mail.gmail.com>
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
In-Reply-To: <CAMRc=MfZg36BULXh3n-ce_x_4B_xOn3Jp4Jgo5BN1LsB2FqaTw@mail.gmail.com>

On Wed, Oct 21, 2026 at 05:11:32AM -0500, Bartosz Golaszewski wrote:
> On Wed, 21 Oct 2026 03:50:01 +0200, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> said:
> > Convert the driver from using legacy platform data to using software
> > nodes for registering 'gpio-keys' devices. This allows us to
> > transition away from platform data and use generic device properties.
> >
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/input/misc/Kconfig            |   1 -
> >  drivers/input/misc/soc_button_array.c | 134 ++++++++++++++++++--------
> >  2 files changed, 92 insertions(+), 43 deletions(-)
> >
> > diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> > index 169768e3d5bb..a2984c1048f3 100644
> > --- a/drivers/input/misc/Kconfig
> > +++ b/drivers/input/misc/Kconfig
> > @@ -906,7 +906,6 @@ config INPUT_SOC_BUTTON_ARRAY
> >  	depends on KEYBOARD_GPIO && ACPI
> >  	depends on X86
> >  	depends on GPIOLIB
> > -	select GPIOLIB_LEGACY
> >  	help
> >  	  Say Y here if you have a SoC-based tablet that originally runs
> >  	  Windows 8 or a Microsoft Surface Book 2, Pro 5, Laptop 1 or later.
> > diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
> > index 8d782ef4f78b..aa7838b864c2 100644
> > --- a/drivers/input/misc/soc_button_array.c
> > +++ b/drivers/input/misc/soc_button_array.c
> > @@ -14,9 +14,11 @@
> >  #include <linux/acpi.h>
> >  #include <linux/dmi.h>
> >  #include <linux/gpio/consumer.h>
> > -#include <linux/gpio_keys.h>
> > +#include <linux/gpio/driver.h>
> > +#include <linux/gpio/machine.h>
> >  #include <linux/platform_data/x86/soc.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/property.h>
> >  #include <linux/slab.h>
> >
> >  static bool use_low_level_irq;
> > @@ -59,10 +61,10 @@ struct soc_button_data {
> >   * gets called with the lid open (e.g. on boot and on resume), it sets the
> >   * irq-type to IRQ_TYPE_LEVEL_LOW. Where as the gpio-keys driver programs the
> >   * type to, and expects it to be, IRQ_TYPE_EDGE_BOTH.
> > - * To work around this we don't set gpio_keys_button.gpio on these 2-in-1s,
> > + * To work around this we don't set "gpios" property on these 2-in-1s,
> >   * instead we get the irq for the GPIO ourselves, configure it as
> >   * IRQ_TYPE_LEVEL_LOW (to match how the _LID AML code configures it) and pass
> > - * the irq in gpio_keys_button.irq. Below is a list of affected devices.
> > + * the irq as a device resource. Below is a list of affected devices.
> >   */
> >  static const struct dmi_system_id dmi_use_low_level_irq[] = {
> >  	{
> > @@ -131,18 +133,31 @@ static const struct dmi_system_id dmi_invalid_acpi_index[] = {
> >  };
> >
> >  /*
> > - * Get the Nth GPIO number from the ACPI object.
> > + * Get the Nth GPIO information from the ACPI object.
> >   */
> >  static int soc_button_lookup_gpio(struct device *dev, int acpi_index,
> > -				  int *gpio_ret, int *irq_ret)
> > +				  bool active_low,
> > +				  struct software_node_ref_args *gpio_ref,
> > +				  int *irq_ret)
> >  {
> > +	struct gpio_device *gdev;
> > +	struct fwnode_handle *fwnode;
> >  	struct gpio_desc *desc;
> >
> >  	desc = gpiod_get_index(dev, NULL, acpi_index, GPIOD_ASIS);
> >  	if (IS_ERR(desc))
> >  		return PTR_ERR(desc);
> 
> This GPIO is requested for a short time and then released. Do we run into
> a risk of the actual target user requesting this pin at the same time and
> failing? We don't support shared GPIO pins for ACPI yet (though I want to
> add that eventually).
> 
> I know this has always been like this but I'm wondering how it works exactly.

The soc_button_array driver controls instantiation of devices that
consume these GPIOs, so there is no concern of them being consumed too
early.

> 
> >
> > -	*gpio_ret = desc_to_gpio(desc);
> > +	gdev = gpiod_to_gpio_device(desc);
> > +	fwnode = dev_fwnode(gpio_device_to_device(gdev));
> > +	if (!fwnode) {
> > +		gpiod_put(desc);
> > +		return -ENODEV;
> > +	}
> > +
> > +	*gpio_ref = SOFTWARE_NODE_REFERENCE(fwnode, gpiod_hwgpio(desc),
> > +					    active_low ? GPIO_ACTIVE_LOW :
> > +							 GPIO_ACTIVE_HIGH);
> 
> Sigh... I hate it and it looks hacky but I also don't have a better idea. :(

Thanks, that is quite common reaction to the code I write ;)

-- 
Dmitry
