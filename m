From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/3] Input: gpio_keys.c: Enable use with non-local GPIO chips.
Date: Mon, 6 Jun 2011 10:15:42 -0600
Message-ID: <BANLkTimf5EAdCeqESvdKbwbnMoAMqcux8g@mail.gmail.com>
References: <1307373155-29470-1-git-send-email-david@protonic.nl> <1307373155-29470-4-git-send-email-david@protonic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:55236 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941Ab1FFQQC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Jun 2011 12:16:02 -0400
Received: by pwi15 with SMTP id 15so2178655pwi.19
        for <linux-input@vger.kernel.org>; Mon, 06 Jun 2011 09:16:02 -0700 (PDT)
In-Reply-To: <1307373155-29470-4-git-send-email-david@protonic.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Jander <david@protonic.nl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Mon, Jun 6, 2011 at 9:12 AM, David Jander <david@protonic.nl> wrote:
> Use a threaded interrupt handler in order to permit the handler to us=
e
> a GPIO driver that causes things like I2C transactions being done ins=
ide
> the handler context.
> Also, gpio_keys_init needs to be declared as a late_initcall, to make=
 sure
> all needed GPIO drivers have been loaded if the drivers are built int=
o the
> kernel.
>
> Signed-off-by: David Jander <david@protonic.nl>

Looks okay to me.  Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0drivers/input/keyboard/gpio_keys.c | =A0 =A08 ++++----
> =A01 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keybo=
ard/gpio_keys.c
> index 4efd067..bfbdfe8 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -3,7 +3,7 @@
> =A0*
> =A0* Copyright 2005 Phil Blundell
> =A0*
> - * Added OF support:
> + * Added OF support and enabled use with I2C GPIO expanders:
> =A0* Copyright 2010 David Jander <david@protonic.nl>
> =A0*
> =A0* This program is free software; you can redistribute it and/or mo=
dify
> @@ -418,7 +418,7 @@ static int __devinit gpio_keys_setup_key(struct d=
evice *dev,
> =A0 =A0 =A0 =A0if (!button->can_disable)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0irqflags |=3D IRQF_SHARED;
>
> - =A0 =A0 =A0 error =3D request_any_context_irq(irq, gpio_keys_isr, i=
rqflags, desc, bdata);
> + =A0 =A0 =A0 error =3D request_threaded_irq(irq, NULL, gpio_keys_isr=
, irqflags, desc, bdata);
> =A0 =A0 =A0 =A0if (error < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "Unable to claim irq %d; =
error %d\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0irq, error);
> @@ -771,10 +771,10 @@ static void __exit gpio_keys_exit(void)
> =A0 =A0 =A0 =A0platform_driver_unregister(&gpio_keys_device_driver);
> =A0}
>
> -module_init(gpio_keys_init);
> +late_initcall(gpio_keys_init);
> =A0module_exit(gpio_keys_exit);
>
> =A0MODULE_LICENSE("GPL");
> =A0MODULE_AUTHOR("Phil Blundell <pb@handhelds.org>");
> -MODULE_DESCRIPTION("Keyboard driver for CPU GPIOs");
> +MODULE_DESCRIPTION("Keyboard driver for GPIOs");
> =A0MODULE_ALIAS("platform:gpio-keys");
> --
> 1.7.4.1
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
