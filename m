From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] Input: introduce medfield keypad driver
Date: Thu, 8 Jul 2010 20:42:33 +0300
Message-ID: <20100708174233.GI10135@sci.fi>
References: <20100708164127.22458.31279.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:33346 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758186Ab0GHRv1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Jul 2010 13:51:27 -0400
Content-Disposition: inline
In-Reply-To: <20100708164127.22458.31279.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Thu, Jul 08, 2010 at 05:41:33PM +0100, Alan Cox wrote:
> From: Zheng Ba <zheng.ba@intel.com>
>=20
> An i2c bus driver for the Intel Medfield keypad interface.
>=20
> Signed-off-by: Zheng Ba <zheng.ba@intel.com>
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
>=20
>  drivers/input/keyboard/Kconfig       |   10 +
>  drivers/input/keyboard/Makefile      |    1=20
>  drivers/input/keyboard/mfld_keypad.c |  613 ++++++++++++++++++++++++=
++++++++++
>  drivers/input/keyboard/mfld_keypad.h |   56 +++
>  4 files changed, 680 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/input/keyboard/mfld_keypad.c
>  create mode 100644 drivers/input/keyboard/mfld_keypad.h
>=20
>=20
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/=
Kconfig
> index 950f6d1..10cc686 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -309,6 +309,16 @@ config KEYBOARD_MCS
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called mcs_touchkey.
> =20
> +config KEYBOARD_MFLD
> +	tristate "Medfield I2C keypad support"
> +	depends on I2C && GPIOLIB && X86_MRST
> +	help
> +	  Say Y here if you want to get support for the keypad controller
> +	  on the Medfield (MFLD) platform of Intel MID.
> +
> +	  To compile this as a module, choose M here: the
> +	  module will be called mfld_keypad.
> +
>  config KEYBOARD_IMX
>  	tristate "IMX keypad support"
>  	depends on ARCH_MXC
> diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard=
/Makefile
> index a1f5e9d..9672c3d 100644
> --- a/drivers/input/keyboard/Makefile
> +++ b/drivers/input/keyboard/Makefile
<snip>
> +/*
> + * We cannot use I2c in interrupt context, so we just schedule work.
> + */
> +static irqreturn_t mfld_keypad_irq(int irq, void *data)
> +{
> +	struct mfld_keypad_chip *tc =3D data;
> +	schedule_work(&tc->work);

Use threaded irq?

> +	return IRQ_HANDLED;
> +}

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
