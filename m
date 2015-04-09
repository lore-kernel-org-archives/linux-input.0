From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V1 2/2] devicetree: Add bindings for DA9063 OnKey
Date: Thu, 9 Apr 2015 10:21:38 +0100
Message-ID: <20150409092138.GA3467@x1>
References: <cover.1428504804.git.stwiss.opensource@diasemi.com>
 <addbebc419ed2d693d398e07131c119cd1d4160b.1428504804.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <addbebc419ed2d693d398e07131c119cd1d4160b.1428504804.git.stwiss.opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, DT <devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, INPUT <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-input@vger.kernel.org

On Wed, 08 Apr 2015, Steve Twiss wrote:

> From: Steve Twiss <stwiss.opensource@diasemi.com>

What format is this?  Why aren't you using `git send-email`?

> Add device tree bindings for the DA9063 OnKey driver
>=20
> This patch is dependent on PATCH V1 1/2=20

How can there be dependencies between a binding document and a driver
patch?

> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
>=20
> ---
> This patch applies against linux-next and v4.0-rc6=20
>=20
>=20
>  Documentation/devicetree/bindings/mfd/da9063.txt | 22 ++++++++++++++=
++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/da9063.txt b/Docum=
entation/devicetree/bindings/mfd/da9063.txt
> index 42c6fa6..3449b75 100644
> --- a/Documentation/devicetree/bindings/mfd/da9063.txt
> +++ b/Documentation/devicetree/bindings/mfd/da9063.txt
> @@ -2,9 +2,10 @@
> =20
>  DA9093 consists of a large and varied group of sub-devices (I2C Only=
):
> =20
> -Device                   Supply Names    Description
> -------                   ------------    -----------
> +Device			 Supply Names	 Description
> +------			 ------------	 -----------
>  da9063-regulator        :               : LDOs & BUCKs
> +da9063-onkey            :               : On Key
>  da9063-rtc              :               : Real-Time Clock
>  da9063-watchdog         :               : Watchdog
> =20
> @@ -51,6 +52,18 @@ Sub-nodes:
>    the DA9063. There are currently no entries in this binding, howeve=
r
>    compatible =3D "dlg,da9063-rtc" should be added if a node is creat=
ed.
> =20
> +- onkey : This node defines the OnKey settings for controlling the k=
ey
> +  functionality of the device. The node should contain the compatibl=
e keyword

s/keyword/property/

> +  with the value "dlg,da9063-onkey".
> +
> +  The platform data needs to match the OTP content of high address r=
egister

It's wrong to mention platform data here.  Just tell us what the
property is for.

> +  DA9063_REG_CONFIG_I and the device tree entry "dlg,disable-key-pow=
er" can

I feel like you're burying the dlg,disable-key-power documentation in
side a long winded paragraph.  It's better to start the line with it,
like:

Optional Properties:

dlg,disable-key-power:  Disable power-down using a long key-press.  If
			absent <blah> ...=20

> +  be used to control this. If the onkey node contains "dlg,disable-k=
ey-power"
> +  then the power down using a long key-press is disabled. If this en=
try is
> +  missing then by default the key-press triggered power down is enab=
led.
> +  By toggling this key-power keyword the OnKey driver will support K=
EY_POWER
> +  and KEY_SLEEP key presses.
> +
>  - watchdog : This node defines settings for the Watchdog timer assoc=
iated
>    with the DA9063. There are currently no entries in this binding, h=
owever
>    compatible =3D "dlg,da9063-watchdog" should be added if a node is =
created.
> @@ -73,6 +86,11 @@ Example:
>  			compatible =3D "dlg,da9063-watchdog";
>  		};
> =20
> +		onkey {
> +			compatible =3D "dlg,da9063-onkey";
> +			dlg,disable-key-power;
> +		};
> +
>  		regulators {
>  			DA9063_BCORE1: bcore1 {
>  				regulator-name =3D "BCORE1";

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
