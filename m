From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Subject: RE: [PATCH RFC V1 2/3] onkey: da9063: Add DA9062 OnKey capability
 to DA9063 OnKey driver
Date: Mon, 20 Jul 2015 13:05:43 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B251D0A@SW-EX-MBX02.diasemi.com>
References: <cover.1436879270.git.stwiss.opensource@diasemi.com>
 <37d843a776028807e94e513a34847a34d821bf81.1436879270.git.stwiss.opensource@diasemi.com>
 <20150717225042.GF39282@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.175]:36441 "EHLO
	mail1.bemta3.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753013AbbGTNGf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jul 2015 09:06:35 -0400
In-Reply-To: <20150717225042.GF39282@dtor-ws>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: DEVICETREE <devicetree@vger.kernel.org>, LINUXINPUT <linux-input@vger.kernel.org>, LINUXKERNEL <linux-kernel@vger.kernel.org>, RTCLINUX <rtc-linux@googlegroups.com>, David Dajun Chen <david.chen@diasemi.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Support Opensource <Support.Opensource@diasemi.com>

On 17 July 2015 23:51, Dmitry Torokhov wrote:

> Hi Steve,
> On Tue, Jul 14, 2015 at 02:07:50PM +0100, S Twiss wrote:
> > From: S Twiss <stwiss.opensource@diasemi.com>
> > Add DA9062 OnKey support into the existing DA9063 OnKey driver component by
> > using generic access tables for common register and bit mask definitions.
> >
> > The following change will add generic register and bit mask support to the
> > DA9063 OnKey.
> >
> > The following alterations have been made to the DA9063 OnKey:
> >
> > - Addition of a da9063_compatible_onkey_regmap structure to hold all
> >   generic registers and bitmasks for this type of OnKey component.
> > - Addition of an struct of_device_id table for DA9063 and DA9062
> >   defaults
> > - Refactoring functions to use struct da9063_compatible_onkey accesses
> >   to generic registers/masks instead of using defines from registers.h
> > - Re-work of da9063_onkey_probe() to use of_match_node() and
> >   dev_get_regmap() to provide initialisation of generic registers and
> >   masks and access to regmap
> >
> > Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> Looks generally good, just a few comments.
> 

Hi Dmitry,

Thanks for taking the time to review this.

[...]

> > diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> > index d4f0a81..42860f9 100644
> > --- a/drivers/input/misc/Kconfig
> > +++ b/drivers/input/misc/Kconfig
> > @@ -612,10 +612,10 @@ config INPUT_DA9055_ONKEY
> >
> >  config INPUT_DA9063_ONKEY
> >  	tristate "Dialog DA9063 OnKey"
> 
> "Dialog DA9062/63 OnKey" maybe?

Yep.
I can do that.

[...]
> >
> > -struct da9063_onkey {
> > -	struct da9063 *hw;
> > +struct da9063_compatible_onkey_regmap {
> 
> Maybe call it da906x_chip_config?

I will do this.

> > +	/* REGS */
> > +	int onkey_status;
> > +	int onkey_pwr_signalling;
> > +	int onkey_fault_log;
> > +	int onkey_shutdown;
> > +	/* MASKS */
> > +	int onkey_nonkey_mask;
> > +	int onkey_nonkey_lock_mask;
> > +	int onkey_key_reset_mask;
> > +	int onkey_shutdown_mask;
> > +	/* NAMES */
> > +	char *name;
> 
> const char *?
> 

Sure -- I'll change that.

> > +};
> > +
> > +struct da9063_compatible_onkey {
> 
> If you did not rename the structure your diff would be smaller.

Yep. I can rename this back to what it was previously.
[...]

I'll submit a PATCH V2 with those changes.

Regards,
Steve

