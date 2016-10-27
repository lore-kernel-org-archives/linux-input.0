From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] Input: gpio-keys: Convert to universal device properties
 API
Date: Thu, 27 Oct 2016 10:02:23 +0300
Message-ID: <20161027070223.GS1476@lahna.fi.intel.com>
References: <20161017143803.142231-1-mika.westerberg@linux.intel.com>
 <20161027011610.GB31660@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:1363 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933466AbcJ0HCf (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 27 Oct 2016 03:02:35 -0400
Content-Disposition: inline
In-Reply-To: <20161027011610.GB31660@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-input@vger.kernel.org

On Wed, Oct 26, 2016 at 06:16:10PM -0700, Dmitry Torokhov wrote:
> Hi Mika,
> 
> On Mon, Oct 17, 2016 at 05:38:03PM +0300, Mika Westerberg wrote:
> > In order to use this driver in ACPI based systems, convert the driver to
> > take advantage of device properties APIs instead of Device Tree specific
> > one and make it available outside of CONFIG_OF.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/input/keyboard/gpio_keys.c | 92 ++++++++++++++++----------------------
> >  1 file changed, 38 insertions(+), 54 deletions(-)
> > 
> > diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> > index 29093657f2ef..0e6d516df01b 100644
> > --- a/drivers/input/keyboard/gpio_keys.c
> > +++ b/drivers/input/keyboard/gpio_keys.c
> > @@ -22,13 +22,12 @@
> >  #include <linux/proc_fs.h>
> >  #include <linux/delay.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/property.h>
> >  #include <linux/input.h>
> >  #include <linux/gpio_keys.h>
> >  #include <linux/workqueue.h>
> >  #include <linux/gpio.h>
> >  #include <linux/of.h>
> > -#include <linux/of_platform.h>
> > -#include <linux/of_gpio.h>
> >  #include <linux/of_irq.h>
> >  #include <linux/spinlock.h>
> >  
> > @@ -479,13 +478,15 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
> >  	spin_lock_init(&bdata->lock);
> >  
> >  	if (gpio_is_valid(button->gpio)) {
> > -
> > -		error = devm_gpio_request_one(&pdev->dev, button->gpio,
> > -					      GPIOF_IN, desc);
> > -		if (error < 0) {
> > -			dev_err(dev, "Failed to request GPIO %d, error %d\n",
> > -				button->gpio, error);
> > -			return error;
> > +		/* Only request GPIO if GPIO descriptor is not used */
> > +		if (!button->gpiod) {
> 
> So the issue here is that button is supposed to be constant (in case of
> legacy platform data) and we should not be stuffing gpiod in there. The
> commit adding the descriptor to button data was wrong.
> 
> I have a patch that moves in from button data to bdata for polled keys
> and also an alternative patch for gpio_keys; I'll post the series.

OK, thanks!
