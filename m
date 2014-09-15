From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 4/4] mfd: max77693: Update DT binding to support haptic
Date: Tue, 16 Sep 2014 00:00:43 +0100
Message-ID: <20140915230043.GI25162@lee--X1>
References: <1410440062-19963-1-git-send-email-jaewon02.kim@samsung.com>
 <1410440062-19963-5-git-send-email-jaewon02.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1410440062-19963-5-git-send-email-jaewon02.kim@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaewon Kim <jaewon02.kim@samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 11 Sep 2014, Jaewon Kim wrote:

> This patch add haptic DT binding documentation and example
> to support haptic driver in max77693 Multifunction device.
>=20
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  Documentation/devicetree/bindings/mfd/max77693.txt |   18 ++++++++++=
++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/max77693.txt b/Doc=
umentation/devicetree/bindings/mfd/max77693.txt
> index 11921cc..d178b9e 100644
> --- a/Documentation/devicetree/bindings/mfd/max77693.txt
> +++ b/Documentation/devicetree/bindings/mfd/max77693.txt
> @@ -27,6 +27,17 @@ Optional properties:
> =20
>  	[*] refer Documentation/devicetree/bindings/regulator/regulator.txt
> =20
> +- haptic : The haptic of max77693 have to be instantiated under subn=
od

Perhaps a description as to what "The haptic" is might be handy?

s/have/has

s/subnod/subnode

What do you mean by "under" a subnode?  Do you mean "as a" subnode?

> +  named "haptic" using the following haptic format in example.

What is the "haptic format"?  It just looks like a normal node to me.

> +  Haptic sensation from motor can be changed by changing a period cy=
cle in pwms.

Is "Haptic sensation" a technical term?

s/from motor/from a motor/

s/changed by changing/changed by varying/

s/period cycle/duty cycle/

s/in pwms/in the pwms property/

> +
> + Required properties:
> +	- compatible : Must be "maxim,max77693-hpatic"
> +	- haptic-supply : power supply for haptic motor

s/for haptic/for the haptic/

> +		[*] refer Documentation/devicetree/bindings/regulator/regulator.tx=
t
> +	- pwms : phandle to the physical PWM device,

It's not just the phandle though is it?

> +		[*] refer Documentation/devicetree/bindings/pwm/pwm.txt
> +
>  Example:
>  	max77693@66 {
>  		compatible =3D "maxim,max77693";
> @@ -52,4 +63,11 @@ Example:
>  					regulator-boot-on;
>  			};
>  		};
> +
> +		haptic {
> +			compatible =3D "maxim,max77693-haptic";
> +			haptic-supply =3D <&haptic_supply>;
> +			pwms =3D <&pwm 0 40000 0>;
> +			pwm-names =3D "haptic";
> +		};
>  	};

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
