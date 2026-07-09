Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E34335BA;
	Thu,  9 Jul 2026 05:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783573763; cv=none; b=Ua7T5tdE8NOqTdn8TtB6onJkDOLKMHv87PQDLGxkFc2dQdVZAIaN+R/C4yRGJx/GQWzSAEKOYopavcVvg0p718UDIvUefYbk7tU8sGcJROrcmgmVzueNs3tc81Y8OruFFuqr0pU4PA48aQsZuXK2V5V6DWeZLxABd26bnOBAUpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783573763; c=relaxed/simple;
	bh=EphSH5hmz7qWsddBBmPqf8NGUOLm9jycu0bGOmBKy50=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tp83QoPJwB6B1WtIsevv6qDj3X0LuX0wIAoJa+iMz5Qw/eVHxBv4CXz8EsPckIjS/k846yN4IlU4ZoHPy9ZhBv7idgOmWog+pk8Arl4e7JKSdU04ryqj2Nj6CNCqHyOhG0cWqXe7D5ObIQcQPfy238il8gk7efjDsD/gXfiPb4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXNY6uhY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXNY6uhY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F131F00A3E;
	Thu,  9 Jul 2026 05:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783573761;
	bh=D15yqdrjbGfAiPWT5pjDmetR4bNM6aneHpkvYGA5KzE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TXNY6uhYybwPO7ZETVj/pdkrfg4tO43T3D8ruioLzROnjQNDSifORGJdB96BH+wfd
	 0Xh85O5jc1VOffB0xlFafOLbr+UvrYIRvTVkjYkkr3V7rdDTfu19fFocCA43NZp0X4
	 EV5LApFP0oAMn3glVUEfVuPZevMOq2CeFyhBNoiagQzUZZwgbfTbLXeuYxU+XcGE4A
	 9gaV12jF6W7fl5mJsXWOWNM1fdTPexoz4nNoR2glpnAYN6sns0/Y9SRq26aeZvvxcx
	 f3DMvHxP1v7M3s2G3XfXU0DppdmWme9gTdO/wZ16K5G5/BvRF5cHBsa5Gp6brYWGZt
	 UfBn/NtqM39TQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/11] ARM: s3c: crag6410: switch keypad device to
 software properties
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260708-samsung-kp-v2-4-3c6ed4c9b3b6@gmail.com>
References: <20260708-samsung-kp-v2-0-3c6ed4c9b3b6@gmail.com>
 <20260708-samsung-kp-v2-4-3c6ed4c9b3b6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 05:09:20 +0000
Message-Id: <20260709050921.64F131F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Legacy device tree parsing fails because matrix_keypad_parse_prope=
rties() overwrites legacy values.
- [Low] pr_err() message lacks trailing newline.
- [Low] S3C64XX_SETUP_KEYPAD Kconfig symbol is dead code but remains select=
ed.

Pre-existing issues:
- [High] Uninitialized variables in samsung_parse_verbose_keymap() generate=
 random keycodes and leak kernel memory.
- [High] Asynchronous data abort occurs due to IRQ registration before PM r=
untime enablement.
--

--- Patch [4]: [PATCH v2 04/11] ARM: s3c: crag6410: switch keypad device to=
 software properties ---
commit acad872c671c37651ef2ad547b4a44b17438b49e
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: ARM: s3c: crag6410: switch keypad device to software properties

This commit switches the keypad device to use software properties. This cha=
nge
allows dropping support for platform data from the samsung-keypad driver. T=
he
platform data and related setup code are removed from the machine
initialization.

> diff --git a/arch/arm/mach-s3c/Makefile.s3c64xx b/arch/arm/mach-s3c/Makef=
ile.s3c64xx
> --- a/arch/arm/mach-s3c/Makefile.s3c64xx
> +++ b/arch/arm/mach-s3c/Makefile.s3c64xx
> @@ -32,7 +32,6 @@ obj-y				+=3D dev-audio-s3c64xx.o
>  obj-$(CONFIG_S3C64XX_SETUP_FB_24BPP)	+=3D setup-fb-24bpp-s3c64xx.o
>  obj-$(CONFIG_S3C64XX_SETUP_I2C0)	+=3D setup-i2c0-s3c64xx.o
>  obj-$(CONFIG_S3C64XX_SETUP_I2C1)	+=3D setup-i2c1-s3c64xx.o
> -obj-$(CONFIG_S3C64XX_SETUP_KEYPAD)	+=3D setup-keypad-s3c64xx.o

[Severity: Low]
Is the S3C64XX_SETUP_KEYPAD Kconfig symbol dead code now?

Since the file is removed from the Makefile, the config symbol doesn't seem
to compile any code anymore, but it is still selected by MACH_WLF_CRAGG_6410
in Kconfig.s3c64xx.

[ ... ]

> diff --git a/arch/arm/mach-s3c/mach-crag6410.c b/arch/arm/mach-s3c/mach-c=
rag6410.c
> --- a/arch/arm/mach-s3c/mach-crag6410.c
> +++ b/arch/arm/mach-s3c/mach-crag6410.c
[ ... ]
> @@ -192,17 +193,41 @@ static uint32_t crag6410_keymap[] =3D {
[ ... ]
> +static void __init crag6410_setup_keypad(void)
> +{
> +	struct platform_device *pd;
> +
> +	/* Set all the necessary GPK pins to special-function 3: KP_ROW[x] */
> +	s3c_gpio_cfgrange_nopull(S3C64XX_GPK(8), 2, S3C_GPIO_SFN(3));
> +
> +	/* Set all the necessary GPL pins to special-function 3: KP_COL[x] */
> +	s3c_gpio_cfgrange_nopull(S3C64XX_GPL(0), 6, S3C_GPIO_SFN(3));
> +
> +	pd =3D platform_device_register_full(&crag6410_keypad_info);
> +	if (IS_ERR(pd))
> +		pr_err("failed to instantiate keypad device");

[Severity: Low]
Would it be better to add a trailing newline to this pr_err() message?

It looks like the kernel log output might become garbled if the registration
fails.

> +}

[Severity: High]
Could this sequence cause a regression where legacy device trees fail to pr=
obe?

When reading properties:

drivers/input/keyboard/samsung-keypad.c:samsung_keypad_parse_properties() {
    ...
    error =3D matrix_keypad_parse_properties(dev, &num_rows, &num_cols);
    ...
}

The matrix_keypad_parse_properties() function unconditionally zeroes the
variables at entry, so if modern properties are absent, the legacy
samsung,keypad-num-rows properties are overwritten and the function returns
-EINVAL.

[Severity: High]
This is a pre-existing issue, but might samsung_parse_verbose_keymap() leak
uninitialized stack memory to userspace?

drivers/input/keyboard/samsung-keypad.c:samsung_parse_verbose_keymap() {
    ...
    u32 row, col, key_code;

    fwnode_property_read_u32(child, "keypad,row", &row);
    ...
    *keymap++ =3D KEY(row, col, key_code);
    ...
}

If a child node is missing the keypad,row, keypad,column, or linux,code
properties, fwnode_property_read_u32() leaves row, col, and key_code
uninitialized. These stack values are used in the KEY() macro and stored in
the keymap, where userspace can read them via the EVIOCGKEYCODE ioctl.

[Severity: High]
This is a pre-existing issue, but is it possible for an asynchronous data a=
bort
to occur if an IRQ is pending before PM runtime is enabled?

In probe, the IRQ is requested before the device is powered on:

drivers/input/keyboard/samsung-keypad.c:samsung_keypad_probe() {
    ...
    error =3D devm_request_threaded_irq(&pdev->dev, keypad->irq, NULL,
                                      samsung_keypad_irq, IRQF_ONESHOT,
                                      dev_name(&pdev->dev), keypad);
    ...
}

If an IRQ is pending from the bootloader, the handler runs immediately:

drivers/input/keyboard/samsung-keypad.c:samsung_keypad_irq() {
    ...
    pm_runtime_get_sync(&keypad->pdev->dev);

    do {
        readl(keypad->base + SAMSUNG_KEYIFSTSCLR);
    ...
}

Since the device is unclocked and pm_runtime_get_sync() fails, readl()
accesses unclocked registers and triggers a data abort.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-samsung-kp=
-v2-0-3c6ed4c9b3b6@gmail.com?part=3D4
