From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Re: [PATCH v4 7/9] ARM: sun7i/sun4i: dt: Add AXP209
 support to various boards
Date: Mon, 14 Apr 2014 12:20:32 +0200
Message-ID: <534BB670.8030102@redhat.com>
References: <1397209093-10077-1-git-send-email-carlo@caione.org>	<1397209093-10077-8-git-send-email-carlo@caione.org>	<20140414095256.GA28585@lukather> <CAOQ7t2ZybF=dm-NBQ3niN7gb-Asgwz5CW-VSkOzWR6t2NCaA8w@mail.gmail.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDL4X2GMZUKRB2H5V2NAKGQEPOOWXQA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <CAOQ7t2ZybF=dm-NBQ3niN7gb-Asgwz5CW-VSkOzWR6t2NCaA8w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,

On 04/14/2014 12:02 PM, Carlo Caione wrote:
> On Mon, Apr 14, 2014 at 11:52 AM, Maxime Ripard
> <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
>> Hi Carlo,
> 
> Hi Maxime,
> 
>> On Fri, Apr 11, 2014 at 11:38:11AM +0200, Carlo Caione wrote:
>>> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>>> Signed-off-by: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
>>> ---
>>>
>>> In all the DTs the min and max microvolt allowed for each regulator are actually
>>> the min and max voltage possible for the regulator itself. This is not safe but
>>> we do not have the ranges allowed for each board and the original Allwinner
>>> driver does exactly this way.
>>>
>>> AXP20x has the so called Power Path Management (IPS) that can select the proper
>>> power supply according to the status of the external power and the Li-battery
>>> status. The output of the IPS block is usually a 5V fixed voltage used as
>>> input supply for all the other regulators. This fixed voltage is represented
>>> in the DT as a fixed voltage regulator in the "regulator" subnode.
>>>
>>>  arch/arm/boot/dts/sun4i-a10-a1000.dts           | 69 +++++++++++++++++++++++
>>>  arch/arm/boot/dts/sun4i-a10-cubieboard.dts      | 69 +++++++++++++++++++++++
>>>  arch/arm/boot/dts/sun4i-a10-hackberry.dts       | 75 +++++++++++++++++++++++++
>>>  arch/arm/boot/dts/sun4i-a10-inet97fv2.dts       | 69 +++++++++++++++++++++++
>>>  arch/arm/boot/dts/sun4i-a10-mini-xplus.dts      | 75 +++++++++++++++++++++++++
>>>  arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts  | 75 +++++++++++++++++++++++++
>>>  arch/arm/boot/dts/sun4i-a10-pcduino.dts         | 69 +++++++++++++++++++++++
>>>  arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     | 70 +++++++++++++++++++++++
>>>  arch/arm/boot/dts/sun7i-a20-cubietruck.dts      | 70 +++++++++++++++++++++++
>>>  arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 70 +++++++++++++++++++++++
>>
>> That looks like a lot of them. Did you test all of them?
>> Are all those regulators you define used on all these boards?
> 
> I tested it only on cubieboard2, all the other boards are contributed by Hans.
> I'll double check with Hans.

Well my contribution stems from the time when we still had a dtsi for the regulators,
if were going to do them per board, then we should be more precise IMHO.

As Mark has also mentioned we should probably pin the regulators to a certain
voltage, except for those which we expect to be controlled by a driver, so basically
all of them should be pinned to a certain voltage except for DCDC2 which gets used
for the cpu voltage which we will want to scale as soon as we've a cpufreq driver.

While testing the latest revision of your code I also noticed that the kernel ends
up disabling LDO3 and LDO4, which could be fine on some boards and a problem on
other boards.

I think we need to be careful here. For now it may be best to only add the DCDC2 regulator
to the dts, as we know that dcdc2 is used for the cpu voltage everywhere, and we will
actually want to control that later on.

For the others, for the boards where we've schematics (*) it would be good to add the other
regulators with fixed voltages as specified in the schematics. For the rest it may be
best to simply leave the regulators alone / at their default settings.




> 
>>>  10 files changed, 711 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
>>> index fa746aea..029a880 100644
>>> --- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
>>> +++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
>>> @@ -88,6 +88,75 @@
>>>                       pinctrl-names = "default";
>>>                       pinctrl-0 = <&i2c0_pins_a>;
>>>                       status = "okay";
>>> +                     #address-cells = <1>;
>>> +                     #size-cells = <0>;
>>
>> That should be in the DTSI.
> 
> Agree.

Note I've just send a patch-series for that and Maxime has added that series to his
sunxi/dt-for-3.16 branch.

<snip>

Regards,

Hans
