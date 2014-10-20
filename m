From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/3] mfd: stmpe: add pull up/down register offsets for
 STMPE
Date: Mon, 20 Oct 2014 07:46:05 +0100
Message-ID: <20141020064605.GB25349@x1>
References: <1413636974-3244-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:65018 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322AbaJTGqL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Oct 2014 02:46:11 -0400
Received: by mail-ob0-f180.google.com with SMTP id va2so3263653obc.25
        for <linux-input@vger.kernel.org>; Sun, 19 Oct 2014 23:46:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1413636974-3244-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Sat, 18 Oct 2014, Linus Walleij wrote:

> This adds the register offsets for pull up/down for the STMPE
> 1601, 1801 and 24xx expanders. This is used to bias GPIO lines
> and keypad lines.
>=20
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Hi Sam, Lee: I think you should just ACK this so Dmitry can take the
> patch series through the input tree, where the registers need to be
> used to enable the keypad on the STMPE2401.
> ---
>  drivers/mfd/stmpe.c       | 4 ++++
>  drivers/mfd/stmpe.h       | 3 +++
>  include/linux/mfd/stmpe.h | 2 ++
>  3 files changed, 9 insertions(+)

Does this need to go in with the other patches in the set?

I'm _guessing_ that, as you've sent them separately, they can be
applied separately?

This needs to go in via MFD, but for my own reference:

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
> index 3004d5ba0b82..497505bad4c4 100644
> --- a/drivers/mfd/stmpe.c
> +++ b/drivers/mfd/stmpe.c
> @@ -547,6 +547,7 @@ static const u8 stmpe1601_regs[] =3D {
>  	[STMPE_IDX_GPDR_LSB]	=3D STMPE1601_REG_GPIO_SET_DIR_LSB,
>  	[STMPE_IDX_GPRER_LSB]	=3D STMPE1601_REG_GPIO_RE_LSB,
>  	[STMPE_IDX_GPFER_LSB]	=3D STMPE1601_REG_GPIO_FE_LSB,
> +	[STMPE_IDX_GPPUR_LSB]	=3D STMPE1601_REG_GPIO_PU_LSB,
>  	[STMPE_IDX_GPAFR_U_MSB]	=3D STMPE1601_REG_GPIO_AF_U_MSB,
>  	[STMPE_IDX_IEGPIOR_LSB]	=3D STMPE1601_REG_INT_EN_GPIO_MASK_LSB,
>  	[STMPE_IDX_ISGPIOR_MSB]	=3D STMPE1601_REG_INT_STA_GPIO_MSB,
> @@ -695,6 +696,7 @@ static const u8 stmpe1801_regs[] =3D {
>  	[STMPE_IDX_GPDR_LSB]	=3D STMPE1801_REG_GPIO_SET_DIR_LOW,
>  	[STMPE_IDX_GPRER_LSB]	=3D STMPE1801_REG_GPIO_RE_LOW,
>  	[STMPE_IDX_GPFER_LSB]	=3D STMPE1801_REG_GPIO_FE_LOW,
> +	[STMPE_IDX_GPPUR_LSB]	=3D STMPE1801_REG_GPIO_PULL_UP_LOW,
>  	[STMPE_IDX_IEGPIOR_LSB]	=3D STMPE1801_REG_INT_EN_GPIO_MASK_LOW,
>  	[STMPE_IDX_ISGPIOR_LSB]	=3D STMPE1801_REG_INT_STA_GPIO_LOW,
>  };
> @@ -778,6 +780,8 @@ static const u8 stmpe24xx_regs[] =3D {
>  	[STMPE_IDX_GPDR_LSB]	=3D STMPE24XX_REG_GPDR_LSB,
>  	[STMPE_IDX_GPRER_LSB]	=3D STMPE24XX_REG_GPRER_LSB,
>  	[STMPE_IDX_GPFER_LSB]	=3D STMPE24XX_REG_GPFER_LSB,
> +	[STMPE_IDX_GPPUR_LSB]	=3D STMPE24XX_REG_GPPUR_LSB,
> +	[STMPE_IDX_GPPDR_LSB]	=3D STMPE24XX_REG_GPPDR_LSB,
>  	[STMPE_IDX_GPAFR_U_MSB]	=3D STMPE24XX_REG_GPAFR_U_MSB,
>  	[STMPE_IDX_IEGPIOR_LSB]	=3D STMPE24XX_REG_IEGPIOR_LSB,
>  	[STMPE_IDX_ISGPIOR_MSB]	=3D STMPE24XX_REG_ISGPIOR_MSB,
> diff --git a/drivers/mfd/stmpe.h b/drivers/mfd/stmpe.h
> index bee0abf82040..84adb46b3e2f 100644
> --- a/drivers/mfd/stmpe.h
> +++ b/drivers/mfd/stmpe.h
> @@ -188,6 +188,7 @@ int stmpe_remove(struct stmpe *stmpe);
>  #define STMPE1601_REG_GPIO_ED_MSB		0x8A
>  #define STMPE1601_REG_GPIO_RE_LSB		0x8D
>  #define STMPE1601_REG_GPIO_FE_LSB		0x8F
> +#define STMPE1601_REG_GPIO_PU_LSB		0x91
>  #define STMPE1601_REG_GPIO_AF_U_MSB		0x92
> =20
>  #define STMPE1601_SYS_CTRL_ENABLE_GPIO		(1 << 3)
> @@ -276,6 +277,8 @@ int stmpe_remove(struct stmpe *stmpe);
>  #define STMPE24XX_REG_GPEDR_MSB		0x8C
>  #define STMPE24XX_REG_GPRER_LSB		0x91
>  #define STMPE24XX_REG_GPFER_LSB		0x94
> +#define STMPE24XX_REG_GPPUR_LSB		0x97
> +#define STMPE24XX_REG_GPPDR_LSB		0x9a
>  #define STMPE24XX_REG_GPAFR_U_MSB	0x9B
> =20
>  #define STMPE24XX_SYS_CTRL_ENABLE_GPIO		(1 << 3)
> diff --git a/include/linux/mfd/stmpe.h b/include/linux/mfd/stmpe.h
> index af9e1b07a630..976e1a390177 100644
> --- a/include/linux/mfd/stmpe.h
> +++ b/include/linux/mfd/stmpe.h
> @@ -50,6 +50,8 @@ enum {
>  	STMPE_IDX_GPEDR_MSB,
>  	STMPE_IDX_GPRER_LSB,
>  	STMPE_IDX_GPFER_LSB,
> +	STMPE_IDX_GPPUR_LSB,
> +	STMPE_IDX_GPPDR_LSB,
>  	STMPE_IDX_GPAFR_U_MSB,
>  	STMPE_IDX_IEGPIOR_LSB,
>  	STMPE_IDX_ISGPIOR_LSB,

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
