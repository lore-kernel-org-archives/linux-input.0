From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/2] input: keypad: tc3589x: localize platform data
Date: Fri, 27 Mar 2015 11:52:57 +0000
Message-ID: <20150327115257.GD15988@x1>
References: <1426776765-18812-1-git-send-email-linus.walleij@linaro.org>
 <1426776765-18812-2-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:33559 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432AbbC0LxC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Mar 2015 07:53:02 -0400
Received: by wgbgs4 with SMTP id gs4so5495266wgb.0
        for <linux-input@vger.kernel.org>; Fri, 27 Mar 2015 04:53:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1426776765-18812-2-git-send-email-linus.walleij@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

On Thu, 19 Mar 2015, Linus Walleij wrote:

> This driver can only get its platform data from the device tree,
> and all platforms using it does that. Localize the platform data
> for the keypad. A later patch will enforce the device tree / OF
> dependence.
>=20
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Dmitry it would be great if you could ACK this patch so Lee can
> take it with the other patch through MFD.
> ---
>  drivers/input/keyboard/tc3589x-keypad.c | 49 ++++++++++++++++++++++-=
----------
>  include/linux/mfd/tc3589x.h             | 23 ----------------
>  2 files changed, 33 insertions(+), 39 deletions(-)

Applied, thanks.

> diff --git a/drivers/input/keyboard/tc3589x-keypad.c b/drivers/input/=
keyboard/tc3589x-keypad.c
> index 563932500ff1..0ccc7de9b59d 100644
> --- a/drivers/input/keyboard/tc3589x-keypad.c
> +++ b/drivers/input/keyboard/tc3589x-keypad.c
> @@ -70,6 +70,28 @@
>  #define TC3589x_KBD_INT_CLR	0x1
> =20
>  /**
> + * struct tc35893_keypad_platform_data - platform specific keypad da=
ta
> + * @keymap_data:        matrix scan code table for keycodes
> + * @krow:               mask for available rows, value is 0xFF
> + * @kcol:               mask for available columns, value is 0xFF
> + * @debounce_period:    platform specific debounce time
> + * @settle_time:        platform specific settle down time
> + * @irqtype:            type of interrupt, falling or rising edge
> + * @enable_wakeup:      specifies if keypad event can wake up system=
 from sleep
> + * @no_autorepeat:      flag for auto repetition
> + */
> +struct tc3589x_keypad_platform_data {
> +	const struct matrix_keymap_data *keymap_data;
> +	u8                      krow;
> +	u8                      kcol;
> +	u8                      debounce_period;
> +	u8                      settle_time;
> +	unsigned long           irqtype;
> +	bool                    enable_wakeup;
> +	bool                    no_autorepeat;
> +};
> +
> +/**
>   * struct tc_keypad - data structure used by keypad driver
>   * @tc3589x:    pointer to tc35893
>   * @input:      pointer to input device object
> @@ -360,23 +382,19 @@ static int tc3589x_keypad_probe(struct platform=
_device *pdev)
>  	struct tc3589x *tc3589x =3D dev_get_drvdata(pdev->dev.parent);
>  	struct tc_keypad *keypad;
>  	struct input_dev *input;
> -	const struct tc3589x_keypad_platform_data *plat;
>  	int error, irq;
> =20
> -	plat =3D tc3589x->pdata->keypad;
> -	if (!plat) {
> -		plat =3D tc3589x_keypad_of_probe(&pdev->dev);
> -		if (IS_ERR(plat)) {
> -			dev_err(&pdev->dev, "invalid keypad platform data\n");
> -			return PTR_ERR(plat);
> -		}
> -	}
> -
>  	irq =3D platform_get_irq(pdev, 0);
>  	if (irq < 0)
>  		return irq;
> =20
>  	keypad =3D kzalloc(sizeof(struct tc_keypad), GFP_KERNEL);
> +	keypad->board =3D tc3589x_keypad_of_probe(&pdev->dev);
> +	if (IS_ERR(keypad->board)) {
> +		dev_err(&pdev->dev, "invalid keypad platform data\n");
> +		return PTR_ERR(keypad->board);
> +	}
> +
>  	input =3D input_allocate_device();
>  	if (!keypad || !input) {
>  		dev_err(&pdev->dev, "failed to allocate keypad memory\n");
> @@ -384,7 +402,6 @@ static int tc3589x_keypad_probe(struct platform_d=
evice *pdev)
>  		goto err_free_mem;
>  	}
> =20
> -	keypad->board =3D plat;
>  	keypad->input =3D input;
>  	keypad->tc3589x =3D tc3589x;
> =20
> @@ -395,7 +412,7 @@ static int tc3589x_keypad_probe(struct platform_d=
evice *pdev)
>  	input->open =3D tc3589x_keypad_open;
>  	input->close =3D tc3589x_keypad_close;
> =20
> -	error =3D matrix_keypad_build_keymap(plat->keymap_data, NULL,
> +	error =3D matrix_keypad_build_keymap(keypad->board->keymap_data, NU=
LL,
>  					   TC3589x_MAX_KPROW, TC3589x_MAX_KPCOL,
>  					   NULL, input);
>  	if (error) {
> @@ -406,13 +423,13 @@ static int tc3589x_keypad_probe(struct platform=
_device *pdev)
>  	keypad->keymap =3D input->keycode;
> =20
>  	input_set_capability(input, EV_MSC, MSC_SCAN);
> -	if (!plat->no_autorepeat)
> +	if (!keypad->board->no_autorepeat)
>  		__set_bit(EV_REP, input->evbit);
> =20
>  	input_set_drvdata(input, keypad);
> =20
>  	error =3D request_threaded_irq(irq, NULL, tc3589x_keypad_irq,
> -				     plat->irqtype | IRQF_ONESHOT,
> +				     keypad->board->irqtype | IRQF_ONESHOT,
>  				     "tc3589x-keypad", keypad);
>  	if (error < 0) {
>  		dev_err(&pdev->dev,
> @@ -428,8 +445,8 @@ static int tc3589x_keypad_probe(struct platform_d=
evice *pdev)
>  	}
> =20
>  	/* let platform decide if keypad is a wakeup source or not */
> -	device_init_wakeup(&pdev->dev, plat->enable_wakeup);
> -	device_set_wakeup_capable(&pdev->dev, plat->enable_wakeup);
> +	device_init_wakeup(&pdev->dev, keypad->board->enable_wakeup);
> +	device_set_wakeup_capable(&pdev->dev, keypad->board->enable_wakeup)=
;
> =20
>  	platform_set_drvdata(pdev, keypad);
> =20
> diff --git a/include/linux/mfd/tc3589x.h b/include/linux/mfd/tc3589x.=
h
> index c203c9c56776..468c31a27fcf 100644
> --- a/include/linux/mfd/tc3589x.h
> +++ b/include/linux/mfd/tc3589x.h
> @@ -140,36 +140,13 @@ extern int tc3589x_set_bits(struct tc3589x *tc3=
589x, u8 reg, u8 mask, u8 val);
>  #define TC_KPD_DEBOUNCE_PERIOD  0xA3
>  #define TC_KPD_SETTLE_TIME      0xA3
> =20
> -/**
> - * struct tc35893_platform_data - data structure for platform specif=
ic data
> - * @keymap_data:        matrix scan code table for keycodes
> - * @krow:               mask for available rows, value is 0xFF
> - * @kcol:               mask for available columns, value is 0xFF
> - * @debounce_period:    platform specific debounce time
> - * @settle_time:        platform specific settle down time
> - * @irqtype:            type of interrupt, falling or rising edge
> - * @enable_wakeup:      specifies if keypad event can wake up system=
 from sleep
> - * @no_autorepeat:      flag for auto repetition
> - */
> -struct tc3589x_keypad_platform_data {
> -	const struct matrix_keymap_data *keymap_data;
> -	u8                      krow;
> -	u8                      kcol;
> -	u8                      debounce_period;
> -	u8                      settle_time;
> -	unsigned long           irqtype;
> -	bool                    enable_wakeup;
> -	bool                    no_autorepeat;
> -};
> =20
>  /**
>   * struct tc3589x_platform_data - TC3589x platform data
>   * @block: bitmask of blocks to enable (use TC3589x_BLOCK_*)
> - * @keypad: keypad-specific platform data
>   */
>  struct tc3589x_platform_data {
>  	unsigned int block;
> -	const struct tc3589x_keypad_platform_data *keypad;
>  };
> =20
>  #endif

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
