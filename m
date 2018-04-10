From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH] Input: atmel_mxt_ts - add missing compatible strings to
 OF device table
Date: Tue, 10 Apr 2018 12:20:47 +0200
Message-ID: <CAFqH_50O=V2jh3FDJ+udqL_F2s5W4G+KF1USHR_dKaT82_3EXw@mail.gmail.com>
References: <20180410095340.24074-1-javierm@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180410095340.24074-1-javierm@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring <robh+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>, Nick Dyer <nick@shmanahar.org>, Mark Rutland <mark.rutland@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-input@vger.kernel.org

Thanks Javier!

2018-04-10 11:53 GMT+02:00 Javier Martinez Canillas <javierm@redhat.com>:
> Commit af503716ac14 ("i2c: core: report OF style module alias for devices
> registered via OF") fixed how the I2C core reports the module alias when
> devices are registered via OF.
>
> But the atmel_mxt_ts driver only has an "atmel,maxtouch" compatible in its
> OF device ID table, so if a Device Tree is using a different one, autoload
> won't be working for the module (the matching works because the I2C device
> ID table is used as a fallback).
>
> So add compatible strings for each of the entries in the I2C device table.
>
> Fixes: af503716ac14 ("i2c: core: report OF style module alias for devices registered via OF")
> Reported-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>
>  Documentation/devicetree/bindings/input/atmel,maxtouch.txt | 6 +++++-
>  drivers/input/touchscreen/atmel_mxt_ts.c                   | 4 ++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt b/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
> index 23e3abc3fdef..cd43fb8bc2ce 100644
> --- a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
> +++ b/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
> @@ -1,8 +1,12 @@
>  Atmel maXTouch touchscreen/touchpad
>
>  Required properties:
> -- compatible:
> +- compatible: Must be one of the following
> +    atmel,qt602240_ts
> +    atmel,atmel_mxt_ts
> +    atmel,atmel_mxt_tp
>      atmel,maxtouch
> +    atmel,mXT224
>
>  - reg: The I2C address of the device
>
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 7659bc48f1db..e8ef83f168d6 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -3238,7 +3238,11 @@ static int __maybe_unused mxt_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(mxt_pm_ops, mxt_suspend, mxt_resume);
>
>  static const struct of_device_id mxt_of_match[] = {
> +       { .compatible = "atmel,qt602240_ts", },
> +       { .compatible = "atmel,atmel_mxt_ts", },
> +       { .compatible = "atmel,atmel_mxt_tp", },
>         { .compatible = "atmel,maxtouch", },
> +       { .compatible = "atmel,mXT224", },
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, mxt_of_match);
> --
> 2.14.3
>

The Samsung Chromebook Plus is one of the affected devices, with
current mainline the module is not autoloaded, this patch fixes the
issue.

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
