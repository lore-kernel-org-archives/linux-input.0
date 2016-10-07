From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: RE: [PATCH V1 05/10] thermal: da9062/61: Thermal junction
 temperature monitoring driver
Date: Fri, 7 Oct 2016 17:48:56 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7018CCE2815@SW-EX-MBX02.diasemi.com>
References: <cover.1475743411.git.stwiss.opensource@diasemi.com>
 <b5ce58ca00f7ab30a025d24083549241f135b0e9.1475743411.git.stwiss.opensource@diasemi.com>
 <3bc9fd76-2885-b07a-9df8-7802b7535da2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <3bc9fd76-2885-b07a-9df8-7802b7535da2@ti.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
To: Keerthy <a0393675@ti.com>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: DEVICETREE <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <Support.Opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi,

On 07 October 2016 06:29, Keerthy [mailto:a0393675@ti.com] wrote:
> On Thursday 06 October 2016 02:13 PM, Steve Twiss wrote:
> > From: Steve Twiss <stwiss.opensource@diasemi.com>

[...]

> > +
> > +static int da9062_thermal_get_trip_type(struct thermal_zone_device *z,
> > +				int trip,
> > +				enum thermal_trip_type *type)
> > +{
> > +	struct da9062_thermal *thermal = z->devdata;
> > +
> > +	switch (trip) {
> > +	case 0:
> > +		*type = THERMAL_TRIP_HOT;
> 
> 125C is pretty hot. Just a suggestion, do look at THERMAL_TRIP_CRITICAL.
> 

Quite warm.
I got this from the Documentation/devicetree/bindings/thermal/thermal.txt
	"hot":		A trip point to notify emergency
	"critical":	Hardware not reliable.

The junction temperature supervision characteristics for DA9061 supports three
levels and 125degC is the lowest "warning" level.  This warning level is intended
for non-invasive temperature control where the necessary mitigation is under
software control of the system.

The other two levels are hotter than 125degC and it is not possible to intervene
using software. The hardware will automatically power off.

[...]

> > +static int da9062_thermal_notify(struct thermal_zone_device *z,
> > +				 int trip,
> > +				 enum thermal_trip_type type)
> > +{
> > +	struct da9062_thermal *thermal = z->devdata;
> > +
> > +	switch (type) {
> > +	case THERMAL_TRIP_HOT:
> > +		dev_warn(thermal->dev, "Reached HOT (125degC)
> temperature\n");
> 
> Any cooling action? What is done once you reach this high temperature?

There is nothing to do in the device driver. This is just a stub for board specific additions
to mitigate the temperature. There is a similar function in the  RCAR thermal driver which
contains a FIXME comment. But, apart from helping with my testing, it doesn't add
anything in the driver. It can be removed.

[...]

> > +static const struct da9062_thermal_config da9062_config = {
> > +	.name = "da9062-thermal",
> > +};
> > +
> > +static const struct da9062_thermal_config da9061_config = {
> > +	.name = "da9061-thermal",
> > +};
> > +
> > +static const struct of_device_id da9062_compatible_reg_id_table[] = {
> > +	{ .compatible = "dlg,da9062-thermal", .data = &da9062_config },
> > +	{ .compatible = "dlg,da9061-thermal", .data = &da9061_config },
> 
> Two separate compatible values. Do you have anything different apart
> from the name? Why use 2 compatibles when there is absolutely no
> difference?

Yes.
This was a comment for the watchdog device driver as well. My concern was having 
multiple devices (61 and 62) in the same system -- and allowing the driver to report 
the hardware difference.

There is discussion going on about this in other threads. Not certain of the final outcome
yet, apart from my existing proposal should be changed.

-- From Guenter Roeck:
-- http://www.spinics.net/lists/linux-watchdog/msg10040.html

[...]

> > +	INIT_DELAYED_WORK(&thermal->work, da9062_thermal_poll_on);
> > +	mutex_init(&thermal->lock);
> 
> thermal_zone_device_register itself does
> INIT_DELAYED_WORK(&(tz->poll_queue), thermal_zone_device_check);
> 
> refer: drivers/thermal/thermal_core.c
> 
> It does a periodic monitoring of the temperature as well. Do you really
> want to have an additional work for monitoring temperature in your
> driver also?

I will take a look at this for V2.

Regards,
Steve

