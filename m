From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V5 2/2] devicetree: da9062: Add bindings for DA9062 driver
Date: Tue, 7 Jul 2015 12:42:41 +0100
Message-ID: <20150707114241.GW3182@x1>
References: <cover.1435756293.git.stwiss.opensource@diasemi.com>
 <f7d3b86530f871549159fed1fd0519375997a2af.1435756293.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f7d3b86530f871549159fed1fd0519375997a2af.1435756293.git.stwiss.opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: S Twiss <stwiss.opensource@diasemi.com>
Cc: DEVICETREE <devicetree@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LINUXKERNEL <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, David Dajun Chen <david.chen@diasemi.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LINUXINPUT <linux-input@vger.kernel.org>, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, RTCLINUX <rtc-linux@googlegroups.com>, Samuel Ortiz <sameo@linux.intel.com>, Support Opensource <support.opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>
List-Id: linux-input@vger.kernel.org

On Wed, 01 Jul 2015, S Twiss wrote:

> From: S Twiss <stwiss.opensource@diasemi.com>
>=20
> Add device tree bindings for the DA9062 driver
>=20
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
>=20
> ---
> Changes in V5:
>  - No change
>=20
> Changes in V4:
>  - No change
>=20
> Changes in V3:
>  - No change
> =20
> Changes in V2:
>  - Dropped the RTC and Onkey binding information in this patch-set
>    Those drivers have been dropped from this patch set and the
>    binding information has been removed accordingly.
>=20
> This patch applies against linux-next and next-20150701=20
>=20
>=20
>=20
>  Documentation/devicetree/bindings/mfd/da9062.txt | 79 ++++++++++++++=
++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/da9062.txt

Applied, thanks.

> diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt b/Docum=
entation/devicetree/bindings/mfd/da9062.txt
> new file mode 100644
> index 0000000..5765ed9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/da9062.txt
> @@ -0,0 +1,79 @@
> +* Dialog DA9062 Power Management Integrated Circuit (PMIC)
> +
> +DA9062 consists of a large and varied group of sub-devices:
> +
> +Device                   Supply Names    Description
> +------                   ------------    -----------
> +da9062-regulator        :               : LDOs & BUCKs
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
