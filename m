From: Zhi Li <lznuaa@gmail.com>
Subject: Re: [PATCH v2 0/7] Change snvs rtc and poweroff to use syscon add
 pwrkey driver
Date: Wed, 20 May 2015 09:30:45 -0500
Message-ID: <CAHrpEqSpeMO=zLyii8qZUznP+9EAQqJ-D3O8hbXj99m+UNvpzA@mail.gmail.com>
References: <1432055082-28983-1-git-send-email-Frank.Li@freescale.com>
	<20150520015851.GB1071@dragon>
	<CAHrpEqS5gAsu6=ut-mPwZiipqKJb=VicRooCPFhEf324kuhnDQ@mail.gmail.com>
	<20150520142205.GA24844@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20150520142205.GA24844@dragon>
Sender: linux-pm-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>, "Frank.Li@freescale.com" <Frank.Li@freescale.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, a.zummo@towertech.it, Philipp Zabel <p.zabel@pengutronix.de>, alexandre.belloni@free-electrons.com, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, rtc-linux@googlegroups.com, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-input@vger.kernel.org

On Wed, May 20, 2015 at 9:22 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Tue, May 19, 2015 at 09:44:46PM -0500, Zhi Li wrote:
>> On Tue, May 19, 2015 at 8:58 PM, Shawn Guo <shawnguo@kernel.org> wrote:
>> > On Wed, May 20, 2015 at 01:04:35AM +0800, Frank.Li@freescale.com wrote:
>> >> From: Frank Li <Frank.Li@freescale.com>
>> >>
>> >> Change from v1 to v2
>> >>  - Change simple-bus to simple-mfd
>> >>  - RTC remove lock.
>> >>  - RTC remove comments "These register offsets are relative to LP (Low Power) range"
>> >>  - power off, remove extra space
>> >>
>> >> SNVS is MPF module.
>> >> include rtc, power off, ON/OFF power key
>> >>
>> >>   arm: imx: power-off: change to syscon to access register
>> >>   rtc: arm: imx: snvs: change use syscon to access register
>> >> Above two patch change existed power-off and rtc use syscon
>> >>
>> >>   Document: dt: fsl: snvs: change support syscon
>> >>   arm: dts: imx: update snvs to use syscon access register
>> >> Update dt file and document
>> >>
>> >>   input: keyboard: imx: add snvs power key driver
>> >>   document: devicetree: input: imx: i.mx snvs power device tree bindings
>> >>   arm: dts: imx6sx: enable snvs power key
>> >> Added on/off key driver
>> >>
>> >> Frank Li (6):
>> >>   arm: imx: power-off: change to syscon to access register
>> >>   rtc: arm: imx: snvs: change use syscon to access register
>> >>   Document: dt: fsl: snvs: change support syscon
>> >>   arm: dts: imx: update snvs to use syscon access register
>> >>   document: devicetree: input: imx: i.mx snvs power device tree bindings
>> >>   arm: dts: imx6sx: enable snvs power key
>> >
>> > So, the series will break existing DTBs for RTC and poweroff, right?
>> > If this is unavoidable, should we at least have some warning messages
>> > telling users about his breakage?
>>
>> How to do that?
>> Just added it commit message or need runtime warning?
>
> runtime, so that users can know why their installed DTBs break with the
> new kernel.

+       snvs_np = of_get_parent(pdev->dev.of_node);
+       if (!snvs_np)
+               return -ENODEV;
+
+       data->snvs = syscon_node_to_regmap(snvs_np);
+       of_node_put(snvs_np);
+
+       if (!data->snvs) {
+               pr_err("Can't snvs syscon\n");
+               return -ENODEV;
+       }

How about change error message to " Can't snvs syscon, probably use
old dts file"?

>
> Shawn
