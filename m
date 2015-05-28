From: "Tirdea, Irina" <irina.tirdea@intel.com>
Subject: RE: [PATCH 8/9] input: goodix: add support for ESD
Date: Thu, 28 May 2015 14:26:12 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F19A77432@irsmsx105.ger.corp.intel.com>
References: <1432817265-23891-1-git-send-email-irina.tirdea@intel.com>
 <1432817265-23891-9-git-send-email-irina.tirdea@intel.com>
 <20150528132353.GJ23176@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:21708 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932103AbbE1O0Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 May 2015 10:26:16 -0400
In-Reply-To: <20150528132353.GJ23176@leverpostej>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>



> -----Original Message-----
> From: linux-input-owner@vger.kernel.org [mailto:linux-input-owner@vger.kernel.org] On Behalf Of Mark Rutland
> Sent: 28 May, 2015 16:24
> To: Tirdea, Irina
> Cc: Dmitry Torokhov; Bastien Nocera; linux-input@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 8/9] input: goodix: add support for ESD
> 
> On Thu, May 28, 2015 at 01:47:44PM +0100, Irina Tirdea wrote:
> > Add ESD (Electrostatic Discharge) protection mechanism.
> >
> > The driver enables ESD protection in HW and checks a register
> > to determine if ESD occurred. If ESD is signalled by the HW,
> > the driver will reset the device.
> >
> > The ESD poll time (in ms) can be set through
> > esd-recovery-timeout-ms ACPI/DT property. If it is set to 0,
> > ESD protection is disabled.
> >
> > Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> > ---
> >  .../bindings/input/touchscreen/goodix.txt          |   4 +
> >  drivers/input/touchscreen/goodix.c                 | 106 ++++++++++++++++++++-
> >  2 files changed, 106 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > index 9e4ff69..9132ee0 100644
> > --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > @@ -19,6 +19,10 @@ Optional properties:
> >
> >   - device-config	: device configuration information (specified as byte
> >  			  array). Maximum size is 240 bytes.
> > + - esd-recovery-timeout-ms : ESD poll time (in milli seconds) for the driver to
> > +			     check if ESD occurred and in that case reset the
> > +			     device. ESD is disabled if this property is not set
> > +			     or is set to 0.
> 
> This sounds like software configuration rather than HW description. Is
> there any reason this needs to be a DT property?
> 

Although this enables a software feature, it depends on the platform if electrostatic discharge
protection should be enabled or not. Some platform designs handle ESD better and do not need
the SW mechanism, so the property can be used to disable it.

I also saw an example in Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt
and I though this is the standard way to use it.

> Can we not just choose a sensible default and allow this to be
> overridden dynamically?

I could separate the enabling part from the actual poll timeout by using a DT property to enable/disable
ESD and a sysfs property to set the timeout. I can also move this over to sysfs entirely if you prefer.

Thanks,
Irina

> 
> Mark.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
