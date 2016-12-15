From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: RE: [PATCH V2 09/10] thermal: da9062/61: Thermal junction
 temperature monitoring driver
Date: Thu, 15 Dec 2016 19:06:35 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7018CD34C5F@SW-EX-MBX02.diasemi.com>
References: <cover.1477501000.git.stwiss.opensource@diasemi.com>
 <20fefc922818ab0511101f73b1a4d3468c9a8ed3.1477501000.git.stwiss.opensource@diasemi.com>
 <20161129012409.GA2813@localhost.localdomain>
 <6ED8E3B22081A4459DAC7699F3695FB7018CCEC2F8@SW-EX-MBX02.diasemi.com>
 <20161130060956.GA28175@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161130060956.GA28175@localhost.localdomain>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: LINUX-KERNEL <linux-kernel@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, DEVICETREE <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <Support.Opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>
List-Id: linux-input@vger.kernel.org

Hi Eduardo,

Thank you for your review comments,

On 30 November 2016 06:10, Eduardo Valentin wrote,

> On Tue, Nov 29, 2016 at 11:11:59AM +0000, Steve Twiss wrote:
> > On 29 November 2016 01:24, Eduardo Valentin, wrote:
> > > On Wed, Oct 26, 2016 at 05:56:39PM +0100, Steve Twiss wrote:

[...]

> > > > +static irqreturn_t da9062_thermal_irq_handler(int irq, void *data)
> > > > +{
> > > > +	struct da9062_thermal *thermal = data;
> > > > +
> > > > +	disable_irq_nosync(thermal->irq);
> > > > +	schedule_delayed_work(&thermal->work, 0);
[...]
> >
> > Over-temperature triggering is event based: an interrupt happens when the
> > temperature rises above 125 degC. However, this event based system changes into
> > a polling operation to detect when the temperature falls below the threshold
> > level again. This asymmetry in the chip's behaviour is the reasoning behind
> > why I am not using the thermal core's built-in polling functionality.
> >
> > When over-temperature is reached, the interrupt from the DA9061/2 will be
> > repeatedly triggered. The IRQ is disabled when the first over-temperature event
> > happens and the status bit is polled using the work-queue until it becomes false.
> > After that, the IRQ is re-enabled again so a new critical temperature event can
> > be detected.
> >
> > After the interrupt has happened, event bit for the interrupt switches into a status
> > bit and is used for polling and detecting when the temperature drops below the
> > threshold.
> 
> OK. got it. Then, I am assuming your strategy here is to keep periodically issuing uevents
> (HOT trip point) to userland, hoping that something would change the
> system power consumption, then, relying on the hardware shutdown protection
> if nothing happens.
> 
> I would say, your above explanation, and the uevent based strategy,
> deserves to be at least in the commit message, preferably in the driver
> documentation, so people know what to expect from the driver.

Ah, yes. I did not discuss that part in the design. Looking at this objectively, it is not
immediately obvious -- although you did describe my intentions exactly. I will add
those two changes into the next PATCH V5 submission so the meaning is explicit.

> The data sheet does not mention anything, but does one have any silicon
> lifetime implication if one leaves the PMIC running for very long time
> in a temperature between Twarn and Tcrit?

As of writing this reply, the latest available datasheet for DA9062 contains
sections on "Absolute Maximum Ratings" and "Recommended Operating Conditions"
for the junction temperature.

Regarding the warning temperature the datasheet says, "Operating the device in
conditions exceeding [this level] [...] for extended periods of time may
affect device reliability".

Reference to the documentation in the Linux kernel would also be useful on
the warning threshold. The driver defines this trip-point as,

Documentation/devicetree/bindings/thermal/thermal.txt
"hot": A trip point to notify emergency

I chose this trip point to indicate a strong recommendation that the
temperature warning is treated as an emergency, and should be brought under
control as fast as possible. This will stop any potential reliability problems before
the hardware enforces "a shutdown sequence to RESET mode" in the PMIC.

> Now, if my understand is correct, would it make sense to have still a
> failsafe mechanism in the driver? Maybe having a max number of polling?

I'm not certain what failsafe capability the general driver "should" have.
I am not implementing a notify function for instance. I expect the general
driver to be modified by the designers of the final integrated system. They
will also have access to the PMIC product datasheet and the information on
over-temperature and would be best placed to make a decision for their
system.

> > > > +	thermal->zone = thermal_zone_device_register(thermal->config->name,
> > > > +					1, 0, thermal,
> > > > +					&da9062_thermal_ops, NULL, 0,
> > > > +					0);
> > >
> > > Did you try using of-thermal?
> > >
> > > So you would avoid having specific DT properties for something that
> > > there is already a defined property?

[...]

> using the of-thermal DT support to get the polling value, instead of
> you having a manufacturer specific property:
> Documentation/devicetree/bindings/thermal/thermal.txt
> 
> But given that your case is more specific, I start to see why you
> avoided using it. But still, you could probably get the polling
> values from of-thermal, populated in the tz struct, then using them from
> the tz, when handling the IRQ event.
> 
> Probably your regular polling should always be set to 0, and the passive
> polling to the value you want.

Thank you for your additional explanation.

I will implement this as part of the next PATCH V5 submission.

> then again, this comment is more from a DT perspective than from the
> driver code itself. Just trying to avoid specific properties that may
> get described by what is already defined.

I agree. If I can possibly avoid creating device specific properties that are not
required and instead re-use existing core ones, I should do that.

[...]
 
Regards,
Steve
