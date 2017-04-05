From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 00/11] add thermal throttling to
 Allwinner A33 SoC
Date: Wed, 5 Apr 2017 10:57:52 +0100
Message-ID: <20170405095752.pji6o7u5no6svd5i@dell>
References: <20170321153611.16228-1-quentin.schulz@free-electrons.com>
 <20170404083133.ffrsxjsakynruwzv@dell>
 <fcc2ec2c-cf46-0cf9-1933-53511fe77cf2@free-electrons.com>
Reply-To: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDA7X7F2WUEBBJP7SLDQKGQEBQYYP5A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <fcc2ec2c-cf46-0cf9-1933-53511fe77cf2-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, icenowy-ymACFijhrKM@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, 05 Apr 2017, Quentin Schulz wrote:
> On 04/04/2017 10:31, Lee Jones wrote:
> > On Tue, 21 Mar 2017, Quentin Schulz wrote:
> >> v3:
> >>   - fixed compatible name in DT and in documentation,
> >>   - fixed DT node name and label,
> >>   - added explanations in commit logs,
> >>   - moved frequencies that need overvolting to board DTS instead of A3=
3 DTSI,
> >>   - fixed a typo in if is_enabled condition,
> >>   - removed all patches concerning Olimex Olinuxino (no HW to test on)=
,
> >=20
> > What is the plan for this series?
> >=20
> > I'm guessing there are no hard dependencies on the ARM parts?
> >=20
> > If not, I'm happy to take the changes to 'drivers/*'.
> >=20
>=20
> I've sent a v4 to add some Acked-by and change a few commit "titles".
> It's ready to be merged with only the following patch required (which
> Jonathan asked if you could merge it through the mfd tree): "[RESEND
> PATCH v4] iio: adc: add support for X-Powers AXP20X and AXP22X PMICs
> ADCs" (https://patchwork.kernel.org/patch/9660879/)

Right, but how would you like *this* patch-set applied?

I'm guessing the ARM patches need to go in via ARM-SoC.

What about the drivers/{input,iio,mfd} patches?

I'm guessing they're to all go in via my tree?

> >> [1] https://lkml.org/lkml/2016/12/13/298 : "[PATCH v9] add support for=
 Allwinner
> >> SoCs ADC"
> >>
> >> Thanks,
> >> Quentin
> >>
> >> Maxime Ripard (1):
> >>   ARM: sun8i: a33: Add devfreq-based GPU cooling
> >>
> >> Quentin Schulz (10):
> >>   ARM: sun8i: a33: add operating-points-v2 property to all nodes
> >>   ARM: sun8i: a33: add all operating points
> >>   ARM: dts: sun8i: sina33: add cpu-supply
> >>   Documentation: DT: bindings: mfd: add A33 GPADC binding
> >>   Documentation: DT: bindings: input: touschcreen: remove sun4i
> >>     documentation
> >>   iio: adc: sun4i-gpadc-iio: move code used in MFD probing to new
> >>     function
> >>   iio: adc: sun4i-gpadc-iio: add support for A33 thermal sensor
> >>   ARM: dtsi: sun8i: a33: add thermal sensor
> >>   ARM: dtsi: sun8i: a33: add CPU thermal throttling
> >>   ARM: sun8i: sina33: add highest OPP of CPUs
> >>
> >>  .../touchscreen/sun4i.txt =3D> mfd/sun4i-gpadc.txt}  |  21 +++
> >>  arch/arm/boot/dts/sun8i-a23-a33.dtsi               |   1 +
> >>  arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts     |  18 +++
> >>  arch/arm/boot/dts/sun8i-a33.dtsi                   | 141 ++++++++++++=
+++++
> >>  drivers/iio/adc/Kconfig                            |   2 +-
> >>  drivers/iio/adc/sun4i-gpadc-iio.c                  | 170 ++++++++++++=
+++++----
> >>  include/linux/mfd/sun4i-gpadc.h                    |   4 +
> >>  7 files changed, 324 insertions(+), 33 deletions(-)
> >>  rename Documentation/devicetree/bindings/{input/touchscreen/sun4i.txt=
 =3D> mfd/sun4i-gpadc.txt} (64%)
> >>
> >=20
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
