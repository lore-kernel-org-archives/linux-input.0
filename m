From: Zhi Li <lznuaa@gmail.com>
Subject: Re: [PATCH] input: snvs_pwrkey: add linux prefix for wakeup property
Date: Wed, 15 Jul 2015 09:00:12 -0500
Message-ID: <CAHrpEqS2o6_B6dNrnWJ06ASWaB0SGxur1o3VuN2A-QywWhbWVA@mail.gmail.com>
References: <1436930409-6536-1-git-send-email-shawnguo@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:34043 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813AbbGOOAN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Jul 2015 10:00:13 -0400
In-Reply-To: <1436930409-6536-1-git-send-email-shawnguo@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Frank Li <Frank.Li@freescale.com>, linux-input@vger.kernel.org

On Tue, Jul 14, 2015 at 10:20 PM, Shawn Guo <shawnguo@kernel.org> wrote:
> The wakeup capability is somehow linux specific, and all existing
> bindings name the property "linux,wakeup" to reflect that, e.g.
> Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt.  Let's
> follow the convention.
>
> Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> ---
> This is a fixup for Frank's patch which is queued on i.MX tree, so I
> will apply it to the same branch.
>
> Shawn
>
>  Documentation/devicetree/bindings/crypto/fsl-sec4.txt | 2 +-
>  drivers/input/keyboard/snvs_pwrkey.c                  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> index 71a39c5bd486..fa821c6a0b5b 100644
> --- a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> +++ b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> @@ -408,7 +408,7 @@ System ON/OFF key driver
>        Value type: <int>
>        Definition: Keycode to emit, KEY_POWER by default.
>
> -  - wakeup:
> +  - linux,wakeup:

I remember Dmitry Torokhov said use wakeup, instead of linux, wakeup
when I sent patch to review.

best regards
Frank Li

>        Usage: option
>        Value type: <boo>
>        Definition: Button can wake-up the system.
> diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
> index 512a1fc2a864..021b7c1ddc2f 100644
> --- a/drivers/input/keyboard/snvs_pwrkey.c
> +++ b/drivers/input/keyboard/snvs_pwrkey.c
> @@ -122,7 +122,7 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>                 dev_warn(&pdev->dev, "KEY_POWER without setting in dts\n");
>         }
>
> -       pdata->wakeup = of_property_read_bool(np, "wakeup");
> +       pdata->wakeup = of_property_read_bool(np, "linux,wakeup");
>
>         pdata->irq = platform_get_irq(pdev, 0);
>         if (pdata->irq < 0) {
> --
> 1.9.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
