From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v2 4/8] input: goodix: reset device at init
Date: Tue, 23 Jun 2015 16:12:57 +0200
Message-ID: <1435068777.22211.4.camel@hadess.net>
References: <1433774273-23103-1-git-send-email-irina.tirdea@intel.com>
	 <1433774273-23103-5-git-send-email-irina.tirdea@intel.com>
	 <1433864084.5707.4.camel@hadess.net> <1433865182.5707.7.camel@hadess.net>
	 <1F3AC3675D538145B1661F571FE1805F2F061650@irsmsx105.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:41956 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933823AbbFWONe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Jun 2015 10:13:34 -0400
In-Reply-To: <1F3AC3675D538145B1661F571FE1805F2F061650@irsmsx105.ger.corp.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Tirdea, Irina" <irina.tirdea@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "Purdila, Octavian" <octavian.purdila@intel.com>

On Tue, 2015-06-23 at 13:23 +0000, Tirdea, Irina wrote:
> 
> > -----Original Message-----
> > From: linux-input-owner@vger.kernel.org [mailto:
> > linux-input-owner@vger.kernel.org] On Behalf Of Bastien Nocera
> > Sent: 09 June, 2015 18:53
> > To: Tirdea, Irina
> > Cc: Dmitry Torokhov; Mark Rutland; linux-input@vger.kernel.org; 
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Rob
> > Herring; Pawel Moll; Ian Campbell; Kumar Gala; Purdila, Octavian
> > Subject: Re: [PATCH v2 4/8] input: goodix: reset device at init
> > 
> > On Tue, 2015-06-09 at 17:34 +0200, Bastien Nocera wrote:
> > > On Mon, 2015-06-08 at 17:37 +0300, Irina Tirdea wrote:
> > > > After power on, it is recommended that the driver resets the
> > > > device.
> > > > The reset procedure timing is described in the datasheet and is
> > > > used
> > > > at device init (before writing device configuration) and
> > > > for power management. It is a sequence of setting the interrupt
> > > > and reset pins high/low at specific timing intervals. This
> > > > procedure
> > > > also includes setting the slave address to the one specified in 
> > > > the
> > > > ACPI/device tree.
> > > 
> > > This breaks the touchscreen on my Onda v975w:
> > > [  239.732858] Goodix-TS i2c-GDIX1001:00: ID 9271, version: 1020
> > > [  239.732977] Goodix-TS i2c-GDIX1001:00: Failed to get reset 
> > > GPIO:
> > > -16
> > > [  239.736071] Goodix-TS: probe of i2c-GDIX1001:00 failed with 
> > > error
> > > -16
> > > 
> > > This is the DSDT for that device:
> > > https://bugzilla.kernel.org/attachment.cgi?id=149331
> > 
> 
> Oops. That's right - I am using named interrupts which are available 
> only for ACPI 5.1, so 
> devices already out there will not work.
> 
> The problem here is that handling -ENOENT will not help. The gpio 
> pins are declared in the
> ACPI DSDT, but are not named. The devm_gpiod_get API will look for 
> the named interrupt
> first and fallback to searching by index if not found. Index will be 
> 0 in both cases, this is why
> the first call will succeed and the second will fail with -EBUSY.
> 
> One way to handle this would be to use indexed gpio pins instead of 
> named gpio pins:
> e.g. consider the first gpio pin to be the reset pin and the second 
> to be the interrupt pin.
> This is used in other drivers as well, e.g. zforce_ts. The problem 
> with this approach is that
> any devices that declare the gpio pins in reversed order in the DSDT 
> will not work and give
> no warning (the pins will be requested successfully, but some of the 
> functionality will not
> work). The DSDT mentioned in 
> https://bugzilla.kernel.org/attachment.cgi?id=149331 lists
> the reset pin first, while I am working on some devices that declare 
> the interrupt gpio pin
> first.
> 
> Another way to handle this is to treat -EBUSY like -ENOENT and not 
> use any functionality
> that depends on the gpio pins. Unfortunately, this means we will not 
> have suspend, esd and
> custom configs even if the pins are connected on the board and 
> available in ACPI(just not
> named).
> 
> I would go with the first approach and document the order requested 
> for the pins, but I would
> like to hear what you think first. Is there a better way to do this?
> 
> > (Note that this means that I haven't been able to test any 
> > following
> > patches in that series than 4/8).
> 
> Sure, that makes sense. The following patches depend on the gpio pins 
> so they would not have
> worked either.

We can apply quirks based on DMI information, so that devices with ACPI
in different orders will work after applying a quirk (as long as
there's a way to detect that it's in the wrong order, obviously).

