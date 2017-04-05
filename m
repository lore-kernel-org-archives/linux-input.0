From: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 00/11] add thermal throttling to
 Allwinner A33 SoC
Date: Wed, 5 Apr 2017 13:23:07 +0200
Message-ID: <a5ef789f-7cd4-3f00-e4f0-dce86076e506@free-electrons.com>
References: <20170321153611.16228-1-quentin.schulz@free-electrons.com>
 <20170404083133.ffrsxjsakynruwzv@dell>
 <fcc2ec2c-cf46-0cf9-1933-53511fe77cf2@free-electrons.com>
 <20170405095752.pji6o7u5no6svd5i@dell>
Reply-To: quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCLZXSNY5IDBBHNHSPDQKGQEAGGASFI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170405095752.pji6o7u5no6svd5i@dell>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, icenowy-ymACFijhrKM@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Lee,

On 05/04/2017 11:57, Lee Jones wrote:
> On Wed, 05 Apr 2017, Quentin Schulz wrote:
>> On 04/04/2017 10:31, Lee Jones wrote:
>>> On Tue, 21 Mar 2017, Quentin Schulz wrote:
>>>> v3:
>>>>   - fixed compatible name in DT and in documentation,
>>>>   - fixed DT node name and label,
>>>>   - added explanations in commit logs,
>>>>   - moved frequencies that need overvolting to board DTS instead of A33 DTSI,
>>>>   - fixed a typo in if is_enabled condition,
>>>>   - removed all patches concerning Olimex Olinuxino (no HW to test on),
>>>
>>> What is the plan for this series?
>>>
>>> I'm guessing there are no hard dependencies on the ARM parts?
>>>
>>> If not, I'm happy to take the changes to 'drivers/*'.
>>>
>>
>> I've sent a v4 to add some Acked-by and change a few commit "titles".
>> It's ready to be merged with only the following patch required (which
>> Jonathan asked if you could merge it through the mfd tree): "[RESEND
>> PATCH v4] iio: adc: add support for X-Powers AXP20X and AXP22X PMICs
>> ADCs" (https://patchwork.kernel.org/patch/9660879/)

I got things mixed up between the two different IIO/ADC drivers I'm
trying to get merge. Forget about this dependency, that's not for this
patch series. Sorry for that.

> 
> Right, but how would you like *this* patch-set applied?
> 
> I'm guessing the ARM patches need to go in via ARM-SoC.
> 
> What about the drivers/{input,iio,mfd} patches?
> 
> I'm guessing they're to all go in via my tree?
> 

Patches 1-2 - MFD maintainer I guess? (Lee)
Patches 3-4 - IIO maintainer (Jonathan)
Patches 5-8 - SUNXI maintainer (Maxime)

I think that should do it.

Quentin

>>>> [1] https://lkml.org/lkml/2016/12/13/298 : "[PATCH v9] add support for Allwinner
>>>> SoCs ADC"
>>>>
>>>> Thanks,
>>>> Quentin
>>>>
>>>> Maxime Ripard (1):
>>>>   ARM: sun8i: a33: Add devfreq-based GPU cooling
>>>>
>>>> Quentin Schulz (10):
>>>>   ARM: sun8i: a33: add operating-points-v2 property to all nodes
>>>>   ARM: sun8i: a33: add all operating points
>>>>   ARM: dts: sun8i: sina33: add cpu-supply
>>>>   Documentation: DT: bindings: mfd: add A33 GPADC binding
>>>>   Documentation: DT: bindings: input: touschcreen: remove sun4i
>>>>     documentation
>>>>   iio: adc: sun4i-gpadc-iio: move code used in MFD probing to new
>>>>     function
>>>>   iio: adc: sun4i-gpadc-iio: add support for A33 thermal sensor
>>>>   ARM: dtsi: sun8i: a33: add thermal sensor
>>>>   ARM: dtsi: sun8i: a33: add CPU thermal throttling
>>>>   ARM: sun8i: sina33: add highest OPP of CPUs
>>>>
>>>>  .../touchscreen/sun4i.txt => mfd/sun4i-gpadc.txt}  |  21 +++
>>>>  arch/arm/boot/dts/sun8i-a23-a33.dtsi               |   1 +
>>>>  arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts     |  18 +++
>>>>  arch/arm/boot/dts/sun8i-a33.dtsi                   | 141 +++++++++++++++++
>>>>  drivers/iio/adc/Kconfig                            |   2 +-
>>>>  drivers/iio/adc/sun4i-gpadc-iio.c                  | 170 +++++++++++++++++----
>>>>  include/linux/mfd/sun4i-gpadc.h                    |   4 +
>>>>  7 files changed, 324 insertions(+), 33 deletions(-)
>>>>  rename Documentation/devicetree/bindings/{input/touchscreen/sun4i.txt => mfd/sun4i-gpadc.txt} (64%)
>>>>
>>>
>>
> 

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
