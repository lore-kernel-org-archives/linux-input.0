From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 00/11] add thermal throttling to
 Allwinner A33 SoC
Date: Tue, 4 Apr 2017 09:31:33 +0100
Message-ID: <20170404083133.ffrsxjsakynruwzv@dell>
References: <20170321153611.16228-1-quentin.schulz@free-electrons.com>
Reply-To: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDA7X7F2WUEBB25TRXDQKGQEAONFXQY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20170321153611.16228-1-quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, icenowy-ymACFijhrKM@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, 21 Mar 2017, Quentin Schulz wrote:

> The Allwinner SoCs all have an ADC that can also act as a touchscreen
> controller and a thermal sensor. The first four channels can be used
> either for the ADC or the touchscreen and the fifth channel is used for
> the thermal sensor. We currently have a driver for the two latter
> functions in drivers/input/touchscreen/sun4i-ts.c but we don't have
> access to the ADC feature at all. It is meant to replace the current
> driver by using MFD and subdrivers for existing bindings.
>=20
> The Allwinner A33 only has a thermal sensor present in the GPADC. In
> addition, there is not an existing DT binding for the GPADC. Thus, we do
> not need the sun4i-gpadc MFD driver which was made to keep DT compatibili=
ty
> and probe subdrivers without the need to add DT subnodes.
>=20
> This series of patch adds the thermal sensor for the A33 and GPU/CPU
> thermal throttling. It also adds the cpu-supply property to the CPU node
> needed by the Sinlinx SinA33 and Olinuxino A33 to adapt their CPU regulat=
or
> voltage depending on the currently used OPP. The other A33 boards all hav=
e
> their cpu-supply property set.
>=20
> This series also fixes the missing operating-points-v2 property in cpu DT
> nodes. Finally, it also adds all remaining OPPs which can be found in
> Allwinner 3.4 linux and fex files of all A33 boards.
>=20
> This series of patch is based on this[1] series of patch.
>=20
> v3:
>   - fixed compatible name in DT and in documentation,
>   - fixed DT node name and label,
>   - added explanations in commit logs,
>   - moved frequencies that need overvolting to board DTS instead of A33 D=
TSI,
>   - fixed a typo in if is_enabled condition,
>   - removed all patches concerning Olimex Olinuxino (no HW to test on),

What is the plan for this series?

I'm guessing there are no hard dependencies on the ARM parts?

If not, I'm happy to take the changes to 'drivers/*'.

> [1] https://lkml.org/lkml/2016/12/13/298 : "[PATCH v9] add support for Al=
lwinner
> SoCs ADC"
>=20
> Thanks,
> Quentin
>=20
> Maxime Ripard (1):
>   ARM: sun8i: a33: Add devfreq-based GPU cooling
>=20
> Quentin Schulz (10):
>   ARM: sun8i: a33: add operating-points-v2 property to all nodes
>   ARM: sun8i: a33: add all operating points
>   ARM: dts: sun8i: sina33: add cpu-supply
>   Documentation: DT: bindings: mfd: add A33 GPADC binding
>   Documentation: DT: bindings: input: touschcreen: remove sun4i
>     documentation
>   iio: adc: sun4i-gpadc-iio: move code used in MFD probing to new
>     function
>   iio: adc: sun4i-gpadc-iio: add support for A33 thermal sensor
>   ARM: dtsi: sun8i: a33: add thermal sensor
>   ARM: dtsi: sun8i: a33: add CPU thermal throttling
>   ARM: sun8i: sina33: add highest OPP of CPUs
>=20
>  .../touchscreen/sun4i.txt =3D> mfd/sun4i-gpadc.txt}  |  21 +++
>  arch/arm/boot/dts/sun8i-a23-a33.dtsi               |   1 +
>  arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts     |  18 +++
>  arch/arm/boot/dts/sun8i-a33.dtsi                   | 141 +++++++++++++++=
++
>  drivers/iio/adc/Kconfig                            |   2 +-
>  drivers/iio/adc/sun4i-gpadc-iio.c                  | 170 +++++++++++++++=
++----
>  include/linux/mfd/sun4i-gpadc.h                    |   4 +
>  7 files changed, 324 insertions(+), 33 deletions(-)
>  rename Documentation/devicetree/bindings/{input/touchscreen/sun4i.txt =
=3D> mfd/sun4i-gpadc.txt} (64%)
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
