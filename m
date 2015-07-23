From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V2 3/3] devicetree: da9062: Add device tree bindings for
 DA9062 OnKey
Date: Thu, 23 Jul 2015 16:07:11 +0100
Message-ID: <20150723150711.GI3436@x1>
References: <cover.1437399438.git.stwiss.opensource@diasemi.com>
 <f3630d64fd819832dc2d0925b49c1dca9b11644b.1437399438.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:37552 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437AbbGWPHQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jul 2015 11:07:16 -0400
Received: by wibud3 with SMTP id ud3so223676617wib.0
        for <linux-input@vger.kernel.org>; Thu, 23 Jul 2015 08:07:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <f3630d64fd819832dc2d0925b49c1dca9b11644b.1437399438.git.stwiss.opensource@diasemi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: S Twiss <stwiss.opensource@diasemi.com>
Cc: DEVICETREE <devicetree@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LINUXINPUT <linux-input@vger.kernel.org>, LINUXKERNEL <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, RTCLINUX <rtc-linux@googlegroups.com>, Rob Herring <robh+dt@kernel.org>, David Dajun Chen <david.chen@diasemi.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Support Opensource <support.opensource@diasemi.com>

On Mon, 20 Jul 2015, S Twiss wrote:

> From: S Twiss <stwiss.opensource@diasemi.com>
>=20
> Add device tree bindings for the DA9062 OnKey driver component
>=20
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
>=20
> ---
> Checks performed with linux-next/next-20150708/scripts/checkpatch.pl
>  da9062.txt                total: 0 errors, 0 warnings, 97 lines chec=
ked
> This patch applies against linux-next and next-20150708=20
>=20
>=20
>  Documentation/devicetree/bindings/mfd/da9062.txt | 18 ++++++++++++++=
++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt b/Docum=
entation/devicetree/bindings/mfd/da9062.txt
> index 5765ed9..7752093 100644
> --- a/Documentation/devicetree/bindings/mfd/da9062.txt
> +++ b/Documentation/devicetree/bindings/mfd/da9062.txt
> @@ -5,6 +5,7 @@ DA9062 consists of a large and varied group of sub-de=
vices:
>  Device                   Supply Names    Description
>  ------                   ------------    -----------
>  da9062-regulator        :               : LDOs & BUCKs
> +da9062-onkey            :               : On Key
>  da9062-watchdog         :               : Watchdog Timer
> =20
>  =3D=3D=3D=3D=3D=3D
> @@ -41,6 +42,18 @@ Sub-nodes:
>    Documentation/devicetree/bindings/regulator/regulator.txt
> =20
> =20
> +- onkey : This node defines the OnKey settings for controlling the k=
ey
> +  functionality of the device. The node should contain the compatibl=
e property
> +  with the value "dlg,da9063-onkey".
> +
> +  Optional onkey properties:
> +
> +  - dlg,disable-key-power : Disable power-down using a long key-pres=
s. If this
> +    entry exists the OnKey driver will remove support for the KEY_PO=
WER key
> +    press. If this entry does not exist then by default the key-pres=
s
> +    triggered power down is enabled and the OnKey will support both =
KEY_POWER
> +    and KEY_SLEEP.

Child driver specifics should be separated out into other SS'
documents, in this case ../input.

>  - watchdog: This node defines the settings for the watchdog driver a=
ssociated
>    with the DA9062 PMIC. The compatible =3D "dlg,da9062-watchdog" sho=
uld be added
>    if a node is created.
> @@ -59,6 +72,11 @@ Example:
>  			compatible =3D "dlg,da9062-watchdog";
>  		};
> =20
> +		onkey {
> +			compatible =3D "dlg,da9063-onkey";
> +			dlg,disable-key-power;
> +		};
> +
>  		regulators {
>  			DA9062_BUCK1: buck1 {
>  				regulator-name =3D "BUCK1";

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
