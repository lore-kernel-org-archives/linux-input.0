From: Zhi Li <lznuaa@gmail.com>
Subject: Re: [PATCH 4/7] arm: dts: imx: update snvs to use syscon access register
Date: Mon, 18 May 2015 14:30:50 -0500
Message-ID: <CAHrpEqSxgqUSWFkAh+R4K1oShsWfErE4nndxkYGGktMdkb3=xw@mail.gmail.com>
References: <1431696990-23078-1-git-send-email-Frank.Li@freescale.com>
	<1431696990-23078-5-git-send-email-Frank.Li@freescale.com>
	<1431938725.3209.15.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1431938725.3209.15.camel@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: "Frank.Li@freescale.com" <Frank.Li@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, sachin.kamat@linaro.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-input@vger.kernel.org, rtc-linux@googlegroups.com, linux-pm@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, May 18, 2015 at 3:45 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Hi Frank,
>
> Am Freitag, den 15.05.2015, 21:36 +0800 schrieb Frank.Li@freescale.com:
>> From: Frank Li <Frank.Li@freescale.com>
>>
>> snvs is MFP device. Change dts to use syscon to allocate register resource.
>>
>> Signed-off-by: Frank Li <Frank.Li@freescale.com>
>> ---
>>  arch/arm/boot/dts/imx6qdl.dtsi | 12 ++++--------
>>  arch/arm/boot/dts/imx6sl.dtsi  | 12 ++++--------
>>  arch/arm/boot/dts/imx6sx.dtsi  | 12 ++++--------
>>  arch/arm/boot/dts/vfxxx.dtsi   |  9 +++------
>>  4 files changed, 15 insertions(+), 30 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
>> index 0482a66..6d8161d 100644
>> --- a/arch/arm/boot/dts/imx6qdl.dtsi
>> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
>> @@ -687,21 +687,17 @@
>>                       };
>>
>>                       snvs@020cc000 {
>> -                             compatible = "fsl,sec-v4.0-mon", "simple-bus";
>> -                             #address-cells = <1>;
>> -                             #size-cells = <1>;
>> -                             ranges = <0 0x020cc000 0x4000>;
>> +                             compatible = "fsl,sec-v4.0-mon", "syscon",  "simple-bus";
>
> The compatible should change from "simple-bus" to "simple-mfd", then.

After change to simple-mfd,  driver can't been probed. Anything missed?

>
> regards
> Philipp
>
