From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V4 2/3] devicetree: Add bindings for DA9063 OnKey
Date: Wed, 13 May 2015 11:34:25 +0100
Message-ID: <20150513103425.GF3394@x1>
References: <cover.1431437466.git.stwiss.opensource@diasemi.com>
 <507b01ea2d4717b07cea0ea937949e11cb89d58e.1431437466.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <507b01ea2d4717b07cea0ea937949e11cb89d58e.1431437466.git.stwiss.opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: S Twiss <stwiss.opensource@diasemi.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, DT <devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, INPUT <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Support Opensource <support.opensource@diasemi.com>
List-Id: linux-input@vger.kernel.org

On Tue, 12 May 2015, S Twiss wrote:

> From: Steve Twiss <stwiss.opensource@diasemi.com>
>=20
> Add device tree bindings for the DA9063 OnKey driver
>=20
>=20
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
>=20
> ---
> Version History
>=20
> Changes in V4
>  - No change
>=20
> Changes in V3
>  - No change
>=20
> Changes in V2
>  - Remove the circular dependency comment linking patches in the main=
 e-mail
>  - Search and replace 'keyword' with 'property' in onkey sub-node des=
cription
>  - Reformat onkey sub-node content to move the description for key-po=
wer into
>    a new optional properties sub-section so it has a more promiment p=
osition
>=20
> This patch applies against linux-next and v4.1-rc3=20
>=20
>=20
>  Documentation/devicetree/bindings/mfd/da9063.txt | 18 ++++++++++++++=
++++
>  1 file changed, 18 insertions(+)

I'll wait to see what Dmitry has to say before applying, but for my
own reference:

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/Documentation/devicetree/bindings/mfd/da9063.txt b/Docum=
entation/devicetree/bindings/mfd/da9063.txt
> index 42c6fa6..05b21bc 100644
> --- a/Documentation/devicetree/bindings/mfd/da9063.txt
> +++ b/Documentation/devicetree/bindings/mfd/da9063.txt
> @@ -5,6 +5,7 @@ DA9093 consists of a large and varied group of sub-de=
vices (I2C Only):
>  Device                   Supply Names    Description
>  ------                   ------------    -----------
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
