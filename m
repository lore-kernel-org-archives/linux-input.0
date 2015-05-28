From: "Tirdea, Irina" <irina.tirdea@intel.com>
Subject: RE: [PATCH 5/9] input: goodix: reset device at init
Date: Thu, 28 May 2015 13:42:50 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F19A77392@irsmsx105.ger.corp.intel.com>
References: <1432817265-23891-1-git-send-email-irina.tirdea@intel.com>
 <1432817265-23891-6-git-send-email-irina.tirdea@intel.com>
 <20150528131934.GH23176@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:47519 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372AbbE1Nmy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 May 2015 09:42:54 -0400
In-Reply-To: <20150528131934.GH23176@leverpostej>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Purdila, Octavian" <octavian.purdila@intel.com>



> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland@arm.com]
> Sent: 28 May, 2015 16:20
> To: Tirdea, Irina
> Cc: Dmitry Torokhov; Bastien Nocera; linux-input@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> Purdila, Octavian
> Subject: Re: [PATCH 5/9] input: goodix: reset device at init
> 
> Hi,
> 

Hi Mark,

Thanks for your quick review!

> On Thu, May 28, 2015 at 01:47:41PM +0100, Irina Tirdea wrote:
> > After power on, it is recommended that the driver resets the device.
> > For reset the driver needs to control the interrupt and
> > reset gpio pins (configured through ACPI/device tree).
> 
> Why is it necessary to mess with the GPIO the interrupts is wired up to?
> What exactly does the device expect at reset w.r.t. the interrupt line?
> 

The reset procedure is described in the Goodix documentation (https://drive.google.com/folderview?id=0BxCVOQS3ZymGfmJyY2RKbE5XbVlKNlktVTlwV0lxNEdxd2dzeWZER094cmJPVnMxN1F0Yzg&usp=sharing) and implemented in their reference driver.

It is used at device init (before writing device configuration) and for power management (as described in chapter 7.1 of the documentation, when entering suspend the device must output low on the interrupt pin and when resuming it must output high on the interrupt pin). 

> >
> > Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
> > Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> > ---
> >  .../bindings/input/touchscreen/goodix.txt          |  5 ++
> >  drivers/input/touchscreen/goodix.c                 | 99 ++++++++++++++++++++++
> >  2 files changed, 104 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > index 8ba98ee..7137881 100644
> > --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > @@ -12,6 +12,8 @@ Required properties:
> >   - reg			: I2C address of the chip. Should be 0x5d or 0x14
> >   - interrupt-parent	: Interrupt controller to which the chip is connected
> >   - interrupts		: Interrupt to which the chip is connected
> > + - irq-gpio		: GPIO pin used for IRQ
> > + - reset-gpio		: GPIO pin used for reset
> >
> >  Example:
> >
> > @@ -23,6 +25,9 @@ Example:
> >  			reg = <0x5d>;
> >  			interrupt-parent = <&gpio>;
> >  			interrupts = <0 0>;
> > +
> > +			irq-gpio = <&gpio1 0 0>;
> > +			reset-gpio = <&gpio1 1 0>;
> >  		};
> >
> >  		/* ... */
> > diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> > index 9e7d215..4405c55 100644
> > --- a/drivers/input/touchscreen/goodix.c
> > +++ b/drivers/input/touchscreen/goodix.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/acpi.h>
> >  #include <linux/of.h>
> >  #include <asm/unaligned.h>
> > +#include <linux/gpio.h>
> 
> Nit: weird include ordering.

Will fix this in v2.

> 
> Mark.
