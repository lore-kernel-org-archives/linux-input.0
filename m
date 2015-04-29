From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V1 6/6] devicetree: da9062: Add bindings for DA9062 driver
Date: Wed, 29 Apr 2015 11:54:15 +0100
Message-ID: <20150429105415.GX9169@x1>
References: <cover.1429280614.git.stwiss.opensource@diasemi.com>
 <94535acf974274822c5ac16d6427299778e11ccf.1429280614.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <94535acf974274822c5ac16d6427299778e11ccf.1429280614.git.stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: S Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, LINUXKERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, David Dajun Chen <david.chen-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, LINUXINPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUXWATCHDOG <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, RTCLINUX <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, 17 Apr 2015, S Twiss wrote:

> From: S Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
>=20
> Add device tree bindings for the DA9062 driver
>=20
> Signed-off-by: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
>=20
> ---
>=20
> This patch applies against linux-next and v4.0=20
>=20
>=20
>=20
>  Documentation/devicetree/bindings/mfd/da9062.txt | 107 +++++++++++++=
++++++++++
>  1 file changed, 107 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/da9062.txt

I don't see anything groundbreaking or offensive.

Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

> diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt b/Docum=
entation/devicetree/bindings/mfd/da9062.txt
> new file mode 100644
> index 0000000..cf8f3f6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/da9062.txt
> @@ -0,0 +1,107 @@
> +* Dialog DA9062 Power Management Integrated Circuit (PMIC)
> +
> +DA9062 consists of a large and varied group of sub-devices:
> +
> +Device                   Supply Names    Description
> +------                   ------------    -----------
> +da9062-regulator        :               : LDOs & BUCKs
> +da9062-onkey            :               : On Key
> +da9062-rtc              :               : Real-Time Clock
> +da9062-watchdog         :               : Watchdog Timer
> +
> +=3D=3D=3D=3D=3D=3D
> +
> +Required properties:
> +
> +- compatible : Should be "dlg,da9062".
> +- reg : Specifies the I2C slave address (this defaults to 0x58 but i=
t can be
> +  modified to match the chip's OTP settings).
> +- interrupt-parent : Specifies the reference to the interrupt contro=
ller for
> +  the DA9062.
> +- interrupts : IRQ line information.
> +- interrupt-controller
> +
> +See Documentation/devicetree/bindings/interrupt-controller/interrupt=
s.txt for
> +further information on IRQ bindings.
> +
> +Sub-nodes:
> +
> +- regulators : This node defines the settings for the LDOs and BUCKs=
=2E The
> +  DA9062 regulators are bound using their names listed below:
> +
> +    buck1    : BUCK_1
> +    buck2    : BUCK_2
> +    buck3    : BUCK_3
> +    buck4    : BUCK_4
> +    ldo1     : LDO_1
> +    ldo2     : LDO_2
> +    ldo3     : LDO_3
> +    ldo4     : LDO_4
> +
> +  The component follows the standard regulator framework and the bin=
dings
> +  details of individual regulator device can be found in:
> +  Documentation/devicetree/bindings/regulator/regulator.txt
> +
> +
> +- rtc : This node defines settings required for the Real-Time Clock =
associated
> +  with the DA9062. There are currently no entries in this binding, h=
owever
> +  compatible =3D "dlg,da9062-rtc" should be added if a node is creat=
ed.
> +
> +
> +- onkey : This node defines the OnKey settings for controlling the k=
ey
> +  functionality of the device. The node should contain the compatibl=
e property
> +  with the value "dlg,da9062-onkey".
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
> +
> +- watchdog: This node defines the settings for the watchdog driver a=
ssociated
> +  with the DA9062 PMIC. The compatible =3D "dlg,da9062-watchdog" sho=
uld be added
> +  if a node is created.
> +
> +
> +Example:
> +
> +	pmic0: da9062@58 {
> +		compatible =3D "dlg,da9062";
> +		reg =3D <0x58>;
> +		interrupt-parent =3D <&gpio6>;
> +		interrupts =3D <11 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-controller;
> +
> +		rtc {
> +			compatible =3D "dlg,da9062-rtc";
> +		};
> +
> +		onkey {
> +			compatible =3D "dlg,da9062-onkey";
> +			dlg,disable-key-power;
> +		};
> +
> +		watchdog {
> +			compatible =3D "dlg,da9062-watchdog";
> +		};
> +
> +		regulators {
> +			DA9062_BUCK1: buck1 {
> +				regulator-name =3D "BUCK1";
> +				regulator-min-microvolt =3D <300000>;
> +				regulator-max-microvolt =3D <1570000>;
> +				regulator-min-microamp =3D <500000>;
> +				regulator-max-microamp =3D <2000000>;
> +				regulator-boot-on;
> +			};
> +			DA9062_LDO1: ldo1 {
> +				regulator-name =3D "LDO_1";
> +				regulator-min-microvolt =3D <900000>;
> +				regulator-max-microvolt =3D <3600000>;
> +				regulator-boot-on;
> +			};
> +		};
> +	};
> +

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
