From: Zhi Li <lznuaa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 0/7] Change snvs rtc and poweroff to use syscon add
 pwrkey driver
Date: Wed, 20 May 2015 13:44:58 -0500
Message-ID: <CAHrpEqSngMgOj5Bjp0XWpw9CJCjoiU63iRuAX3Zw_aEO+-5RHg@mail.gmail.com>
References: <1432055082-28983-1-git-send-email-Frank.Li@freescale.com>
	<20150520015851.GB1071@dragon>
	<20150520182540.GQ2067@n2100.arm.linux.org.uk>
	<20150520183050.GR2067@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150520183050.GR2067-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, "Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, May 20, 2015 at 1:30 PM, Russell King - ARM Linux
<linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:
> On Wed, May 20, 2015 at 07:25:41PM +0100, Russell King - ARM Linux wrote:
>> On Wed, May 20, 2015 at 09:58:51AM +0800, Shawn Guo wrote:
>> > On Wed, May 20, 2015 at 01:04:35AM +0800, Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org wrote:
>> > > Frank Li (6):
>> > >   arm: imx: power-off: change to syscon to access register
>> > >   rtc: arm: imx: snvs: change use syscon to access register
>> > >   Document: dt: fsl: snvs: change support syscon
>> > >   arm: dts: imx: update snvs to use syscon access register
>> > >   document: devicetree: input: imx: i.mx snvs power device tree bindings
>> > >   arm: dts: imx6sx: enable snvs power key
>> >
>> > So, the series will break existing DTBs for RTC and poweroff, right?
>> > If this is unavoidable, should we at least have some warning messages
>> > telling users about his breakage?
>>
>> What's the justification for breaking existing DTBs?  Really, this is
>> something we should strive to avoid, _and_ actually avoid by providing
>> backwards compatibility.
>
> Looking at the RTC code, it would be pretty trivial to do.
>
> Rather than passing around struct regmap, pass around the private data
> structure.
>
> Rename the regmap_* function calls to be private accessors.  Implement
> a set of new accessors - if the private data has the regmap, use the
> regmap API.  Otherwise, use the old method, and print a warning that an
> old DT is being used.

This method work.  But code will become ugly and complex. I seach
whole dts tree.
Only imx6 use this driver.

Does it really valuable to keep compatiblity with cost of complex driver code?

best regards
Frank Li

>
> --
> FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
> according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
