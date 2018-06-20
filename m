From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v7 4/4] input/power: Add driver for BD71837/BD71847 PMIC
 power button
Date: Wed, 20 Jun 2018 09:43:16 +0300
Message-ID: <20180620064316.GB28784@localhost.localdomain>
References: <cover.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <af60857c6db5fcf14fbf0112f74719d898952459.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <20180619175028.GA71788@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180619175028.GA71788@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org, mazziesaccount@gmail.com, arnd@arndb.de, sre@kernel.org, chenjh@rock-chips.com, andrew.smirnov@gmail.com, linus.walleij@linaro.org, kstewart@linuxfoundation.org, heiko@sntech.de, gregkh@linuxfoundation.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
List-Id: linux-input@vger.kernel.org

Hello Dmitry,

First of all -  thanks for taking the time to review the patch =)

On Tue, Jun 19, 2018 at 10:50:28AM -0700, Dmitry Torokhov wrote:
> Hi Matti,
> 
> On Tue, Jun 19, 2018 at 01:57:09PM +0300, Matti Vaittinen wrote:
> > ROHM BD71837 PMIC power button driver providing power-key press
> > information to user-space.
> > 
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > ---
> >  drivers/input/misc/Kconfig          | 10 +++++
> >  drivers/input/misc/Makefile         |  1 +
> >  drivers/input/misc/bd718xx-pwrkey.c | 90 +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 101 insertions(+)
> >  create mode 100644 drivers/input/misc/bd718xx-pwrkey.c
> > 
> > +	platform_set_drvdata(pdev, pk);
> > +	err = regmap_update_bits(pk->mfd->regmap,
> > +				 BD71837_REG_PWRONCONFIG0,
> > +				 BD718XX_PWRBTN_SHORT_PRESS_MASK,
> > +				 BD718XX_PWRBTN_SHORT_PRESS_10MS);
> 
> This seems to be the only custom bit of set up in the driver, the rest I
> think can easily be handled by gpio-keys.c in interrupt-only mode. Maybe
> we could move this into MFD piece and drop this driver?

I looked at the gpio_keys.c (for first time so please bear with me if I
ask something you consider as obvious). This is also the first time I am
dealing with input subsystem drivers. So this patch was kind of "RFC"
because I am unsure if this is the best way...

HW we are dealing with is a PMIC which can hace a power-button attached.
HW can generate 3 different types of interrupts for power button
presses:

1. interrupt when button is pressed or released. (Eg. if someone just
hits the button we get two interrupts of this type). We get no 'position
information' from PMIC - just the irqs. Hence it is difficult to know if
buttown was pressed or released. This is the reason why I decided not to
use this IRQ (at least not for now).

2. interrupt when button is pressed for 'short time'. Short time is
configurable and IRQ is generated when button is released based on the
duration it was held down. The limit for 'short time' can be configured.
By default if button is pressed longer than 3 seconds but less than 10
seconds the the PMIC detects 'short push'.

3. interrupt when button is pressed for 'long time'. Mechanism is same
as with short push. Default time is button held over 10 seconds. This
interrupt is not handled if PMIC provides power to processor as PMIC
will cut the power when long push is detected.

So the custom piece is setting the 'short push detection' time from
t > 3 sec to t > 10 msec. Driver is then using short push irq.

This means that we don't detect button press if it is shorter than 10ms.
But we don't need any button state information in driver either. This is
why I decided to use the short push irq - is it Ok?

After this explanation - the gpio_keys_irq_isr seems to be doing exactly
what is needed for short push handling (as far as I can tell). Now it
boils down to question how we should bundle the MFD and gpio_keys
together?

Should I just fill the gpio_keys_platform_data for gpio_keys in MFD
driver? After my short browsing of existing MFD drivers I did not see
any other drivers doing that. This is why I wonder if this is a correct
approach?

Still if MFD is configuring the button presses the gpio_keys for this chip
should only be used if MFD is used, right? Hence the gpio_keys driver
should be instantiaed from MFD, right?

Another option would be using DT and adding gpio_keys node to MFD node
or to simple-bus node. But I have an idea that this would make Rob
unhappy :) I had lenghty discussion with him about declaring the PMIC
as interrupt-controller in device-tree - and I was kindly educated that
it was not the way to go :) I'd rather not started this discussion
again.

Finally, there may be cases when power button is not attached to PMIC
or is needing different configuration for 'short push'. This is why I
would prefer having own Kconfig option for this power-key driver. I am
not sure if it is easily doable if we use gpio_keys?

Can you please give me some further pointer on how I could use the
gpio_keys from MFD?

Best Regards
    Matti Vaittinen
