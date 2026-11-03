Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793710411;
	b=GcbmVf9zBZSF2nOfObu8JAlB5ml4Gte95LYWyMfPDCpOvn40tuHo9FySLp/HN2mpmcOe
	 D8zumuwqnyqNUtLUufj2zNpWphFEy7E4Uhjf/fftnkdqlV+bSkRoPaLbY4fL3ydv3HyF8
	 8EleP1cqQ3a85Fk9zdHs7On20oFWTH5/gB1BOaTyMQWlF5TSvznwWRzEXIUregjZTJf0f
	 81zr7wfaNspKGWf59haqriUrStgQvGF27OQRvBO1P4c4pRNEJUX9+7795nn1zcelXsVDm
	 ETm1uJecR/SU8KnCVu7ROYaIn4fTdH1/Gi2VhxvkHFWnAZze+hCeBYL9ft5GwR0+qGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793710411;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2S9p5aXlHLJbTEBexyM/MLcY9eb5i/Msz79aoiD2w+k=;
	b=s27rHFOopdR0G/jUP16YKgTPvOUAGyLL42ne1dZkbxDjLECLz7ECJ/ilQuYPGDEtAjCR
	 qADTD8hc6VNztoA8TfwRvy81sC/PZWi1QDVo8fxRqOTzgze9MbFFUv9yTiy0JRhNSi5N4
	 zReMMTSX3HXHO5SL0e/4/sdsJii2Oxn4dfHY+PLqHZ96gKXjMLopVh8LVIvmVjsE8UZql
	 G0LpfaXfrQGmfekAVlsVuaJkPt8/lHh15MvvnZaNe0h6InCDL6iUwAVkMqQDz+j2r6foZ
	 T2GDSRAaT2wXjwkvukIqRWzDSU+8uJxSX4LW3fiefY9ZpEYDILcHbQwUBBMcCmBjHqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TZiceSfc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E8230606A324;
	Tue,  3 Nov 2026 12:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TZiceSfc
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D3D761F000C1;
	Tue,  3 Nov 2026 12:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793710410;
	bh=2S9p5aXlHLJbTEBexyM/MLcY9eb5i/Msz79aoiD2w+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TZiceSfcAhePpCCKzOQeUoonLbX9iyIJYY9aN1IcwKxQ4fTHOukJ1d0tDWtQXqaHr
	 +eq2s+JExfXpl2mQKFqKGZnQKLU0shJshWsr/Fb8rfcAP+f5szXdcRqejgbo+mKKqc
	 xse+Po4s+nc7Ad3EZHZuuyl59u/MYayfudvrGLoL84aUs1FVehcEt0magOHJYqMIOa
	 fxHbttATmQ7Or0VETvpzaPkpBlfyvdpIIMF4aBzQsrqtyBf/1QM3Rl9x08Gkj8rwTm
	 d1Gpe6hZPtBb22BTyP5gDab5nxd27B+yLqksfZ7tTdkIqvbd8S9tfiZmoUOczmgX4E
	 5/wHeHMZqOyuA==
Date: Tue, 3 Nov 2026 13:53:26 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Michael Zaidman <michael.zaidman@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>, Germain Hebert <germain.hebert@ca.abb.com>, 
	Christina Quast <contact@christina-quast.de>, Rio Liu <rio@r26.me>, Bruno Giacomazzi <brunoceg1@gmail.com>, 
	linux-input@vger.kernel.org, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/15] HID: ft260: add GPIO support
Message-ID: <7a3kc2tj2mh62aklablkma5teiinm6b6z2rlvrfwk76xcnd2rb@xwsgziioxz6u>
References: <20261030223637.86907-1-michael.zaidman@gmail.com>
 <20261030223637.86907-4-michael.zaidman@gmail.com>
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
In-Reply-To: <20261030223637.86907-4-michael.zaidman@gmail.com>

On Sat, Oct 31, 2026 at 12:36:25AM +0200, Michael Zaidman wrote:
> Add gpiochip support for the FT260 multifunctional pins, including
> GPIO2/GPIOA/GPIOG function selection via sysfs, and enable the
> available GPIOs according to the active UART mode.
> 
> This supersedes the earlier pre-UART GPIO series:
> https://lore.kernel.org/lkml/20230211115752.26276-2-michael.zaidman@gmail.com/
> 
> The gpio_chip.set callback returns int to match the current gpiolib
> API, based on the adaptation originally contributed by Rio Liu
> <rio@r26.me>.
> 
> Read the current GPIO state before writing so a set does not clobber
> other pins with a zero shadow. Apply direction and value in one
> feature report, and return a failed value write to gpiolib. UART mode
> OFF clears only UART-owned bits. Reject an out-of-range uart_mode
> index (reported by Sashiko).
> 
> Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
> 
> ---

There's a lot of sashiko comments to address but a few additional nits
below.

...

> +
> +static int ft260_gpio_set(struct gpio_chip *gc, u32 offset, int value)
> +{
> +	int ret = 0;
> +	struct ft260_gpio_read_request_report buf;
> +	struct ft260_gpio_write_request_report rep;
> +	struct ft260_device *dev = gpiochip_get_data(gc);
> +	struct hid_device *hdev = dev->hdev;
> +
> +	if (offset >= FT260_GPIO_TOTAL) {
> +		hid_err(hdev, "%s: invalid offset %d\n", __func__, offset);
> +		return -EINVAL;
> +	}
> +
> +	ft260_dbg("offset %d val %d\n", offset, value);
> +
> +	mutex_lock(&dev->lock);

Use lock guards from linux/cleanup.h.

> +
> +	if (!(dev->gpio_en & BIT(offset))) {
> +		hid_err(hdev, "%s: wrong pin function %d\n", __func__, offset);
> +		ret = -EINVAL;
> +		goto exit;
> +	}
> +
> +	ret = ft260_hid_feature_report_get(hdev, FT260_GPIO, (u8 *)&buf,
> +					   sizeof(buf));
> +	if (unlikely(ret < 0)) {
> +		hid_err(hdev, "%s: cannot get GPIO: %d\n", __func__, ret);
> +		goto exit;
> +	}
> +
> +	rep.report = FT260_GPIO;
> +	rep.gpio = buf.gpio;
> +
> +	if (offset < FT260_GPIO_0_5_COUNT) {
> +		if (value)
> +			rep.gpio.vals |= !!value << offset;
> +		else
> +			rep.gpio.vals &= ~BIT(offset);
> +	} else {
> +		offset = offset - FT260_GPIO_0_5_COUNT;
> +		if (value)
> +			rep.gpio.ex_vals |= !!value << offset;
> +		else
> +			rep.gpio.ex_vals &= ~BIT(offset);
> +	}
> +
> +	ft260_dbg("dirs %#02x vals %#02x ex_dir %#02x ex_vals %#02x\n",
> +		  rep.gpio.dirs, rep.gpio.vals,
> +		  rep.gpio.ex_dirs, rep.gpio.ex_vals);
> +
> +	ret = ft260_hid_feature_report_set(hdev, (u8 *)&rep, sizeof(rep));
> +	if (unlikely(ret < 0)) {
> +		hid_err(hdev, "%s: cannot set GPIO: %d\n", __func__, ret);
> +		goto exit;
> +	}
> +
> +	dev->gpio = rep.gpio;
> +	ret = 0;
> +exit:
> +	mutex_unlock(&dev->lock);

That way you'll avoid this label. Same elsewhere.

> +	return ret;
> +}
> +
> +
> +	hid_info(hdev, "enabled GPIOs: %04x\n", dev->gpio_en);
> +
> +	dev->gc = devm_kzalloc(&hdev->dev, sizeof(*dev->gc), GFP_KERNEL);
> +	if (!dev->gc)
> +		return -ENOMEM;

Why is this dynamically allocated? Make it part of ft260_device.

> +
> +	label_sz = strlen(dev_name(&hdev->dev)) + strlen(prefix) + 1;
> +	label = devm_kzalloc(&hdev->dev, label_sz, GFP_KERNEL);
> +	if (!label) {
> +		ret = -ENOMEM;
> +		goto exit;

Just return here? Why the label?

> +	}
> +	snprintf(label, label_sz, "%s%s", prefix, dev_name(&hdev->dev));

devm_kasprintf()?

> +	hid_info(hdev, "initialize gpio chip on %s\n", label);

Drop logs like this, they add nothing except useless noise. Same
elsewhere.

> +
> +	dev->gc->label			= label;
> +	dev->gc->direction_input	= ft260_gpio_direction_input;
> +	dev->gc->direction_output	= ft260_gpio_direction_output;
> +	dev->gc->get_direction		= ft260_gpio_get_direction;
> +	dev->gc->set			= ft260_gpio_set;
> +	dev->gc->get			= ft260_gpio_get;
> +	dev->gc->base			= -1;
> +	dev->gc->ngpio			= FT260_GPIO_TOTAL;
> +	dev->gc->can_sleep		= true;
> +	dev->gc->parent			= &hdev->dev;
> +
> +	/* Wakeup chip */
> +	(void)ft260_hid_feature_report_get(dev->hdev, FT260_CHIP_VERSION,
> +					(u8 *)&ver, sizeof(ver));
> +
> +	ret = ft260_hid_feature_report_get(hdev, FT260_GPIO, (u8 *)&gbuf,
> +					   sizeof(gbuf));
> +	if (ret < 0)
> +		hid_warn(hdev, "cannot read GPIO state: %d\n", ret);
> +	else
> +		dev->gpio = gbuf.gpio;
> +
> +	ret = devm_gpiochip_add_data(&hdev->dev, dev->gc, dev);
> +	if (ret < 0)
> +		hid_err(hdev, "cannot add GPIO chip %d\n", ret);
> +exit:
> +	return ret;
> +}
> +
>  static int ft260_get_system_config(struct hid_device *hdev,
>  				   struct ft260_get_system_status_report *cfg)
 
Bart
