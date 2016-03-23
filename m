From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Subject: RE: [NEW DRIVER V6 0/7] DA9058 PMIC - please comment on this new
 driver
Date: Wed, 23 Mar 2016 17:47:38 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB70173D800D3__30456.0631084771$1458755301$gmane$org@SW-EX-MBX02.diasemi.com>
References: <201304191703.r3JH3du0017574@latitude>
 <20160323013139.GD2365@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.162]:54420 "EHLO
	mail1.bemta3.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755995AbcCWRrp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Mar 2016 13:47:45 -0400
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Alexandre Belloni' <alexandre.belloni@free-electrons.com>
Cc: 'LKML' <linux-kernel@vger.kernel.org>, 'Alessandro Zummo' <a.zummo@towertech.it>, 'Guenter Roeck' <linux@roeck-us.net>, 'Jonathan Cameron' <jic23@cam.ac.uk>, 'Lars-Peter Clausen' <lars@metafoo.de>, "'linux-iio@vger.kernel.org'" <'linux-iio@vger.kernel.org'>, "'linux-input@vger.kernel.org'" <'linux-input@vger.kernel.org'>, 'Randy Dunlap' <rdunlap@xenotime.net>, "'rtc-linux@googlegroups.com'" <'rtc-linux@googlegroups.com'>

> On 23 March 2016, Alexandre Belloni wrote:
> > Subject: Re: [NEW DRIVER V6 0/7] DA9058 PMIC - please comment on this new driver
> >
> > Hi Anthony, Steve,
> >
> > This driver has been submitted a while ago and reached v6 but still had
> > a few comments. Do you still have some interest in seeing it being
> > accepted?

Hi Alexandre,

The answer has come back.
As the device has been obsoleted at the moment there is no real benefit in seeing this driver accepted into the kernel.

Thank you.

Regards,
Steve

> > On 19/04/2013 at 17:56:29 +0100, Anthony Olech wrote :
> > > This is submission attempt number 6 to have this driver included in
> > > the linux kernel source tree. This is the driver for the Dialog DA9058.
> > >
> > > The DA9058 is a low power Power Management Integrated Circuit with
> extra
> > > functionality. It is a Multi Function Device controlled only from an I2C
> > > bus whose components can raise an interrupt request on a single IRQ line.
> > >
> > > The driver for the DA9058 consists of a core (i2c) device driver that
> > > instantiates the individual component device drivers for:
> > >
> > > adc - 5 ADC channels
> > > gpio - 2 available pins
> > > onkey - 1 device
> > > regulator - 4 BUCKS, 19 LDO and 3 fixed
> > > rtc - low power clock
> > > hwmon - 5 monitored voltages/temperatures
> > >
> > > All the above six component device drivers depend on the 'core'
> > > component driver, which is number one in the patch series.
> > >
> > > Each component driver for the Dialog DA9058 will follow as an e-mail
> > > patch relative to
> > >
> > > This driver has been tested on a Samsung SMDK6410 connected to a Dialog
> > > DA9058 Evaluation Board via one GPIO and a 3-wire I2C connection.
> > >
> > > All the components can be builtin to the kernel or compiled as modules.
> > > As far as I can tell, all the latest APIs both for the core driver and
> > > all the component drivers have been adhered to, but if I have missed
> > > something please let me know.
> > >
> > > In a clean check out of next-20130419 in linux-next, each patch has been
> > > applied individually and the final result has been built successfully.
> > >
> > > Many thanks,
> > > Anthony Olech, Dialog Semiconductor Ltd.
> > >
> > > Tony Olech (at Home) (7):
> > >   drivers/mfd: DA9058 MFD core driver
> > >   drivers/iio/adc: DA9058 ADC driver
> > >   drivers/input/misc: DA9058 ONKEY driver
> > >   drivers/rtc: DA9058 RTC driver
> > >   drivers/gpio: DA9058 GPIO driver
> > >   drivers/hwmon: DA9058 HWMON driver
> > >   drivers/regulator: DA9058 REGULATOR driver
> > >
> > >  Documentation/hwmon/da9058           |   38 ++
> > >  drivers/gpio/Kconfig                 |   12 +
> > >  drivers/gpio/Makefile                |    1 +
> > >  drivers/gpio/gpio-da9058.c           |  376 ++++++++++++++
> > >  drivers/hwmon/Kconfig                |   10 +
> > >  drivers/hwmon/Makefile               |    3 +-
> > >  drivers/hwmon/da9058-hwmon.c         |  330 ++++++++++++
> > >  drivers/iio/adc/Kconfig              |   12 +
> > >  drivers/iio/adc/Makefile             |    1 +
> > >  drivers/iio/adc/da9058-adc.c         |  396 ++++++++++++++
> > >  drivers/input/misc/Kconfig           |   10 +
> > >  drivers/input/misc/Makefile          |    1 +
> > >  drivers/input/misc/da9058_onkey.c    |  173 +++++++
> > >  drivers/mfd/Kconfig                  |   17 +
> > >  drivers/mfd/Makefile                 |    3 +
> > >  drivers/mfd/da9058-core.c            |   73 +++
> > >  drivers/mfd/da9058-i2c.c             |   96 ++++
> > >  drivers/mfd/da9058-info.c            |  939
> > ++++++++++++++++++++++++++++++++++
> > >  drivers/mfd/da9058-irq.c             |   56 ++
> > >  drivers/regulator/Kconfig            |   11 +
> > >  drivers/regulator/Makefile           |    1 +
> > >  drivers/regulator/da9058-regulator.c |  199 +++++++
> > >  drivers/rtc/Kconfig                  |   10 +
> > >  drivers/rtc/Makefile                 |    1 +
> > >  drivers/rtc/rtc-da9058.c             |  448 ++++++++++++++++
> > >  include/linux/mfd/da9058/adc.h       |   18 +
> > >  include/linux/mfd/da9058/bat.h       |   33 ++
> > >  include/linux/mfd/da9058/codec.h     |   22 +
> > >  include/linux/mfd/da9058/conf.h      |   22 +
> > >  include/linux/mfd/da9058/core.h      |   66 +++
> > >  include/linux/mfd/da9058/gpio.h      |   19 +
> > >  include/linux/mfd/da9058/hwmon.h     |   32 ++
> > >  include/linux/mfd/da9058/i2c.h       |   22 +
> > >  include/linux/mfd/da9058/irq.h       |   50 ++
> > >  include/linux/mfd/da9058/onkey.h     |   17 +
> > >  include/linux/mfd/da9058/pdata.h     |   30 ++
> > >  include/linux/mfd/da9058/registers.h |  480 +++++++++++++++++
> > >  include/linux/mfd/da9058/regulator.h |   26 +
> > >  include/linux/mfd/da9058/rtc.h       |   17 +
> > >  39 files changed, 4070 insertions(+), 1 deletion(-)
> > >  create mode 100644 Documentation/hwmon/da9058
> > >  create mode 100644 drivers/gpio/gpio-da9058.c
> > >  create mode 100644 drivers/hwmon/da9058-hwmon.c
> > >  create mode 100644 drivers/iio/adc/da9058-adc.c
> > >  create mode 100644 drivers/input/misc/da9058_onkey.c
> > >  create mode 100644 drivers/mfd/da9058-core.c
> > >  create mode 100644 drivers/mfd/da9058-i2c.c
> > >  create mode 100644 drivers/mfd/da9058-info.c
> > >  create mode 100644 drivers/mfd/da9058-irq.c
> > >  create mode 100644 drivers/regulator/da9058-regulator.c
> > >  create mode 100644 drivers/rtc/rtc-da9058.c
> > >  create mode 100644 include/linux/mfd/da9058/adc.h
> > >  create mode 100644 include/linux/mfd/da9058/bat.h
> > >  create mode 100644 include/linux/mfd/da9058/codec.h
> > >  create mode 100644 include/linux/mfd/da9058/conf.h
> > >  create mode 100644 include/linux/mfd/da9058/core.h
> > >  create mode 100644 include/linux/mfd/da9058/gpio.h
> > >  create mode 100644 include/linux/mfd/da9058/hwmon.h
> > >  create mode 100644 include/linux/mfd/da9058/i2c.h
> > >  create mode 100644 include/linux/mfd/da9058/irq.h
> > >  create mode 100644 include/linux/mfd/da9058/onkey.h
> > >  create mode 100644 include/linux/mfd/da9058/pdata.h
> > >  create mode 100644 include/linux/mfd/da9058/registers.h
> > >  create mode 100644 include/linux/mfd/da9058/regulator.h
> > >  create mode 100644 include/linux/mfd/da9058/rtc.h
> > >
> > > --
> > > end-of-patch for NEW DRIVER V6
