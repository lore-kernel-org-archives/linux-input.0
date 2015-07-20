From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Subject: RE: [PATCH RFC V1 3/3] devicetree: da9062: Add device tree bindings
 for DA9062 RTC
Date: Mon, 20 Jul 2015 17:08:00 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B253DAD@SW-EX-MBX02.diasemi.com>
References: <cover.1436427954.git.stwiss.opensource@diasemi.com>
 <b47f52abd6a574e5f95760a07a59f445031baefc.1436427954.git.stwiss.opensource@diasemi.com>
 <20150717234737.GJ3487@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail1.bemta14.messagelabs.com ([193.109.254.109]:52705 "EHLO
	mail1.bemta14.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751975AbbGTRIF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jul 2015 13:08:05 -0400
In-Reply-To: <20150717234737.GJ3487@piout.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: DEVICETREE <devicetree@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LINUXINPUT <linux-input@vger.kernel.org>, LINUXKERNEL <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, RTCLINUX <rtc-linux@googlegroups.com>, Rob Herring <robh+dt@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, David Dajun Chen <david.chen@diasemi.com>, Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Support Opensource <Support.Opensource@diasemi.com>

On 18 July 2015 00:48, Alexandre Belloni wrote:

> On 09/07/2015 at 08:45:54 +0100, S Twiss wrote :
> > From: S Twiss <stwiss.opensource@diasemi.com>
> >
> > Add device tree bindings for the DA9062 RTC driver component
> >
> > Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

[...]

> > +- rtc : This node defines settings required for the Real-Time Clock associated
> > +  with the DA9062. There are currently no entries in this binding, however
> > +  compatible = "dlg,da9062-rtc" should be added if a node is created.

[...]

> > @@ -55,6 +60,10 @@ Example:
> >  		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> >  		interrupt-controller;
> >
> > +		rtc {
> > +			compatible = "dlg,da9062-rtc";
> > +		};
> > +
> 
> Are those subnodes even parsed? As the parent node is not compatible
> with "simple-bus" or "simple-mfd", I guess not. You driver is probed
> from the mfd_cells in da9063-core.c

Hi Alexandre,

If I miss out the compatible line for the RTC in the DTSI for DA9062, or is I alter it
so it does not match the string specified in the DA9063 RTC driver, the DA9063 RTC
driver will not be probed for the DA9062 compatibility.
The RTC compatible = "dlg,da9062-rtc"  is essential in this case.

[...]

Regards,
Stephen

