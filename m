From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V2 1/3] mfd: da9062: Support for the DA9063 OnKey in the
 DA9062 core
Date: Thu, 23 Jul 2015 16:07:35 +0100
Message-ID: <20150723150735.GJ3436@x1>
References: <cover.1437399438.git.stwiss.opensource@diasemi.com>
 <9c56142bcfae19a370da54e558f4f70e068d9529.1437399438.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:36770 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753403AbbGWPHj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jul 2015 11:07:39 -0400
Received: by wicgb10 with SMTP id gb10so147415317wic.1
        for <linux-input@vger.kernel.org>; Thu, 23 Jul 2015 08:07:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <9c56142bcfae19a370da54e558f4f70e068d9529.1437399438.git.stwiss.opensource@diasemi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: S Twiss <stwiss.opensource@diasemi.com>
Cc: DEVICETREE <devicetree@vger.kernel.org>, LINUXINPUT <linux-input@vger.kernel.org>, LINUXKERNEL <linux-kernel@vger.kernel.org>, RTCLINUX <rtc-linux@googlegroups.com>, Samuel Ortiz <sameo@linux.intel.com>, David Dajun Chen <david.chen@diasemi.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <support.opensource@diasemi.com>

On Mon, 20 Jul 2015, S Twiss wrote:

> From: S Twiss <stwiss.opensource@diasemi.com>
>=20
> Add MFD core driver support for a OnKey component
>=20
> - MFD core adds the resource da9062_onkey_resources[] for the OnKey
> - An appropriate value has been added into mfd_cell da9062_devs[] to
>   support component .name =3D "da9062-onkey" and
>   .of_compatible  =3D "dlg,da9062-onkey"
>=20
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
>=20
> ---
> Checks performed with linux-next/next-20150708/scripts/checkpatch.pl
>  da9062-core.c             total: 0 errors, 0 warnings, 523 lines che=
cked
> Changes in V2:
>  - No change
>=20
> This patch applies against linux-next and next-20150708=20
>=20
>=20
>  drivers/mfd/da9062-core.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

=46or my own reference:
  Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
> index 4cf0643..0732977 100644
> --- a/drivers/mfd/da9062-core.c
> +++ b/drivers/mfd/da9062-core.c
> @@ -118,6 +118,10 @@ static struct resource da9062_wdt_resources[] =3D=
 {
>  	DEFINE_RES_NAMED(DA9062_IRQ_WDG_WARN, 1, "WD_WARN", IORESOURCE_IRQ)=
,
>  };
> =20
> +static struct resource da9062_onkey_resources[] =3D {
> +	DEFINE_RES_NAMED(DA9062_IRQ_ONKEY, 1, "ONKEY", IORESOURCE_IRQ),
> +};
> +
>  static const struct mfd_cell da9062_devs[] =3D {
>  	{
>  		.name		=3D "da9062-core",
> @@ -141,6 +145,13 @@ static const struct mfd_cell da9062_devs[] =3D {
>  		.resources	=3D da9062_thermal_resources,
>  		.of_compatible  =3D "dlg,da9062-thermal",
>  	},
> +	{
> +		.name		=3D "da9062-onkey",
> +		.num_resources	=3D ARRAY_SIZE(da9062_onkey_resources),
> +		.resources	=3D da9062_onkey_resources,
> +		.of_compatible =3D "dlg,da9062-onkey",
> +	},
> +
>  };
> =20
>  static int da9062_clear_fault_log(struct da9062 *chip)

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
