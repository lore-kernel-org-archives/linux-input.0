From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V3 2/3] devicetree: da9062: Add device tree bindings for
 DA9062 RTC
Date: Thu, 23 Jul 2015 16:27:34 +0100
Message-ID: <20150723152734.GO3436@x1>
References: <cover.1437474547.git.stwiss.opensource@diasemi.com>
 <f899992aaa9b5ea54cb2e27c1cabf626d5969c07.1437474547.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <f899992aaa9b5ea54cb2e27c1cabf626d5969c07.1437474547.git.stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: S Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, LINUXINPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUXKERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, RTCLINUX <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, David Dajun Chen <david.chen-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Tue, 21 Jul 2015, S Twiss wrote:

> From: S Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
>=20
> Add device tree bindings for the DA9062 RTC driver component
>=20
> Signed-off-by: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
>=20
> ---
> Checks performed with linux-next/next-20150708/scripts/checkpatch.pl
>  da9062.txt                total: 0 errors, 0 warnings, 88 lines chec=
ked
> This patch applies against linux-next and next-20150708=20
>=20
>=20
>  Documentation/devicetree/bindings/mfd/da9062.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)

Applied, thanks.

> diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt b/Docum=
entation/devicetree/bindings/mfd/da9062.txt
> index 5765ed9..38802b5 100644
> --- a/Documentation/devicetree/bindings/mfd/da9062.txt
> +++ b/Documentation/devicetree/bindings/mfd/da9062.txt
> @@ -5,6 +5,7 @@ DA9062 consists of a large and varied group of sub-de=
vices:
>  Device                   Supply Names    Description
>  ------                   ------------    -----------
>  da9062-regulator        :               : LDOs & BUCKs
> +da9062-rtc              :               : Real-Time Clock
>  da9062-watchdog         :               : Watchdog Timer
> =20
>  =3D=3D=3D=3D=3D=3D
> @@ -41,6 +42,10 @@ Sub-nodes:
>    Documentation/devicetree/bindings/regulator/regulator.txt
> =20
> =20
> +- rtc : This node defines settings required for the Real-Time Clock =
associated
> +  with the DA9062. There are currently no entries in this binding, h=
owever
> +  compatible =3D "dlg,da9062-rtc" should be added if a node is creat=
ed.
> +
>  - watchdog: This node defines the settings for the watchdog driver a=
ssociated
>    with the DA9062 PMIC. The compatible =3D "dlg,da9062-watchdog" sho=
uld be added
>    if a node is created.
> @@ -55,6 +60,10 @@ Example:
>  		interrupts =3D <11 IRQ_TYPE_LEVEL_LOW>;
>  		interrupt-controller;
> =20
> +		rtc {
> +			compatible =3D "dlg,da9062-rtc";
> +		};
> +
>  		watchdog {
>  			compatible =3D "dlg,da9062-watchdog";
>  		};

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
