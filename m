From: Carlo Caione <carlo@caione.org>
Subject: Re: [linux-sunxi] Re: [PATCH v3 08/10] ARM: sun7i/sun4i: dt: Add
 AXP209 support to various boards
Date: Fri, 28 Mar 2014 08:37:06 +0100
Message-ID: <CAOQ7t2bHdNHAtAS9dr6L=tJek+kP5NeNdmqSMy26vAdGX2=4Cg@mail.gmail.com>
References: <1395955764-18103-1-git-send-email-carlo@caione.org>
	<1395955764-18103-9-git-send-email-carlo@caione.org>
	<CAGb2v67a6kVMe9vxBYrQQtucVqpyvUby1Hyt3RBina8sKj9HOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from srv-hp10.netsons.net ([94.141.22.71]:46082 "EHLO
	srv-hp10.netsons.net" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750955AbaC1Hhe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Mar 2014 03:37:34 -0400
In-Reply-To: <CAGb2v67a6kVMe9vxBYrQQtucVqpyvUby1Hyt3RBina8sKj9HOw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: wens Tsai <wens@csie.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "maxime.ripard" <maxime.ripard@free-electrons.com>, Hans De Goede <hdegoede@redhat.com>, Emilio Lopez <emilio@elopez.com.ar>, sameo@linux.intel.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org, linux-sunxi@googlegroups.com

On Fri, Mar 28, 2014 at 4:12 AM, Chen-Yu Tsai <wens@csie.org> wrote:
>> diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
>> index fa746aea..cf18c4d 100644
>> --- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
>> +++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
>> @@ -88,6 +88,19 @@
>>                         pinctrl-names = "default";
>>                         pinctrl-0 = <&i2c0_pins_a>;
>>                         status = "okay";
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +
>> +                       axp: axp20x@34 {
>
> Hi,
>
> Sorry for spotting this just now. I suggest you change it to
>
>                           axp209: pmic@34 {
>
> or
>
>                           axp209_pmic@34 {
>
> to match the ePAPR policy that node names should be generic and
> describe functionality. The latter is what some DTs use.

Right. Thanks for reviewing this.

> Same for all the other files.
>
> Thanks for working on this!

Thank you,

-- 
Carlo Caione
