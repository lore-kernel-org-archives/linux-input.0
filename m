From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: RE: [PATCH V7 6/7] thermal: da9062/61: Thermal junction temperature
 monitoring driver
Date: Mon, 3 Apr 2017 13:21:19 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7018CD6B0A2@SW-EX-MBX02.diasemi.com>
References: <cover.1490712213.git.stwiss.opensource@diasemi.com>
 <2c1ee249b6746ae3914041a4fc106c89a561f7de.1490712213.git.stwiss.opensource@diasemi.com>
 <20170401195916.GF28514@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170401195916.GF28514@localhost.localdomain>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Lee Jones <lee.jones@linaro.org>
Cc: LINUX-KERNEL <linux-kernel@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, DEVICETREE <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Lukasz Luba <lukasz.luba@arm.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <Support.Opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>
List-Id: linux-input@vger.kernel.org

On 01 April 2017 @20:59, Eduardo Valentin wrote:

> Subject: Re: [PATCH V7 6/7] thermal: da9062/61: Thermal junction temperature monitoring driver
> 
> On Tue, Mar 28, 2017 at 03:43:33PM +0100, Steve Twiss wrote:
> > From: Steve Twiss <stwiss.opensource@diasemi.com>
> >
> > Add junction temperature monitoring supervisor device driver, compatible
> > with the DA9062 and DA9061 PMICs. A MODULE_DEVICE_TABLE() macro is added.
> >
> > If the PMIC's internal junction temperature rises above T_WARN (125 degC)
> > an interrupt is issued. This T_WARN level is defined as the
> > THERMAL_TRIP_HOT trip-wire inside the device driver.
> >
> > The thermal triggering mechanism is interrupt based and happens when the
> > temperature rises above a given threshold level. The component cannot
> > return an exact temperature, it only has knowledge if the temperature is
> > above or below a given threshold value. A status bit must be polled to
> > detect when the temperature falls below that threshold level again. A
> > kernel work queue is configured to repeatedly poll and detect when the
> > temperature falls below this trip-wire, between 1 and 10 second intervals
> > (defaulting at 3 seconds).
> >
> > This scheme is provided as an example. It would be expected that any
> > final implementation will also include a notify() function and any of these
> > settings could be altered to match the application where appropriate.
> >
> > When over-temperature is reached, the interrupt from the DA9061/2 will be
> > repeatedly triggered. The IRQ is therefore disabled when the first
> > over-temperature event happens and the status bit is polled using a
> > work-queue until it becomes false.
> >
> > This strategy is designed to allow the periodic transmission of uevents
> > (HOT trip point) as the first level of temperature supervision method. It
> > is intended for non-invasive temperature control, where the necessary
> > measures for cooling the system down are left to the host software. Once
> > the temperature falls again, the IRQ is re-enabled so a new critical
> > over-temperature event can be detected.
> >
> > Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> > Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> I have had a look on the history of this driver on its previous
> versions, and I do not think I have any other point to request on it.

Thank you.

> Obviously, I still need to state that I do not like its oddness as it is
> not really benefiting much of the thermal control implemented on the
> thermal subsystem.

Agreed.
But, it should be useful in the case of an over-temperature in the system PMIC 
when the OS needs to be notified to bring core temperature under control.

> What is the plan for this series? Am I expected to get this driver
> through thermal tree ? Or is this series going into a one shot?
> 
> If option 1 is the expected, would the driver need to get its
> mfd parent merged first?

Other components such as the ONKEY and Watchdog have not required the MFD
to be merged first. I don't see any strong dependency for the MFD to exist with this
thermal component.

I'm not sure how much Lee is waiting for Acks to exist before proceeding with the MFD.
I have TO:'d Lee Jones, for this case.

Regards,
Steve
