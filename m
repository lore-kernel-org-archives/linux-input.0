From: Michael Welling <mwelling@ieee.org>
Subject: Re: [PATCH v3] Input: tsc2005 - Add support for tsc2004
Date: Thu, 29 Oct 2015 21:08:45 -0500
Message-ID: <20151030020845.GA6599@qwerty.qwertyembedded>
References: <1446077554-19684-1-git-send-email-mwelling@ieee.org>
 <20151030014522.GA14178@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:36515 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467AbbJ3CI7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Oct 2015 22:08:59 -0400
Content-Disposition: inline
In-Reply-To: <20151030014522.GA14178@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Felipe Balbi <balbi@ti.com>, Sebastian Reichel <sre@kernel.org>, Roger Quadros <rogerq@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Dmitry,

On Thu, Oct 29, 2015 at 06:45:22PM -0700, Dmitry Torokhov wrote:
> Hi Michael,
> 
> On Wed, Oct 28, 2015 at 07:12:34PM -0500, Michael Welling wrote:
> > Adds support for the i2c based tsc2004.
> > 
> > Due to the overlapping functionality of the tsc2004 and tsc2005
> > the common code was moved to a core driver (tsc200x-core).
> > 
> > Signed-off-by: Michael Welling <mwelling@ieee.org>
> 
> In addition to what has been discussed in the other email:
> 
> > ---
> > v3: Splits the tsc2004 and tsc2005 into separate drivers with
> > with common routines in tsc200x-core.
> > v2: Fixes Kconfig based on report for 0-day build bot.
> >  .../bindings/input/touchscreen/tsc2004.txt         |  38 +
> 
> Can we please combine tsc2004.txt and tsc2005.txt?

Sure.

> 
> >  
> > +config TOUCHSCREEN_TSC200X
> > +	tristate
> 
> Let's call it TOUCHSCREEN_TSC200X_CORE.

Okay.

> 
> > --- /dev/null
> > +++ b/drivers/input/touchscreen/tsc2004.c
> > @@ -0,0 +1,73 @@
> > +/*
> > + * TSC2004 touchscreen driver
> > + *
> > + * Copyright (C) 2015 EMAC Inc.
> > + * Copyright (C) 2015 QWERTY Embedded Design
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> > + * GNU General Public License for more details.
> > + *
> 
> Please drop this empty line in the comment.
>

No problem.
 
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/input.h>
> > +#include <linux/pm.h>
> > +#include <linux/of.h>
> > +#include <linux/i2c.h>
> > +#include <linux/regmap.h>
> > +#include "tsc200x-core.h"
> > +
> > +static int tsc2004_probe(struct i2c_client *i2c,
> > +			 const struct i2c_device_id *id)
> > +
> > +{
> > +	return tsc200x_probe(&i2c->dev, i2c->irq, BUS_I2C,
> > +			     devm_regmap_init_i2c(i2c,
> > +						  &tsc2005_regmap_config));
> > +}
> > +
> > +static int tsc2004_remove(struct i2c_client *i2c)
> > +{
> > +	return tsc200x_remove(&i2c->dev);
> > +}
> > +
> > +static const struct i2c_device_id tsc2004_idtable[] = {
> > +	{ "tsc2004", 0 },
> > +	{ }
> > +};
> > +
> > +MODULE_DEVICE_TABLE(i2c, tsc2004_idtable);
> > +
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id tsc2004_of_match[] = {
> > +	{ .compatible = "ti,tsc2004" },
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, tsc2004_of_match);
> > +#endif
> > +
> > +static SIMPLE_DEV_PM_OPS(tsc2004_pm_ops, tsc200x_suspend, tsc200x_resume);
> 
> Hmm, maybe you should export tsc200x_pm_ops instead of individual
> functions.
> 
> > +
> > +int __maybe_unused tsc200x_suspend(struct device *dev)
> > +{
> > +	struct tsc2005 *ts = dev_get_drvdata(dev);
> > +
> > +	mutex_lock(&ts->mutex);
> > +
> > +	if (!ts->suspended && ts->opened)
> > +		__tsc2005_disable(ts);
> > +
> > +	ts->suspended = true;
> > +
> > +	mutex_unlock(&ts->mutex);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(tsc200x_suspend);
> 
> __maybe_unused does not make sense here - the symbol is exported and
> therefore is always used. If you export the pm_ops stucture then you can
> keep functions as __maybe_unused.
> 
> BTW, can you generate the patch with -M to let git do the rename
> detection - it will be easier to see what changed in the core.

Okay.

Here is somthing that I just saw. The tsc2005_cmd function uses a pointer to
struct tsc2005 as a paramter. So the struct needs to moved into the 
tsc200x-core.h. Should all of the defines be moved there too?

Also the old platform data is in a SPI specific include directory.
Do we want to move this?

Also should I change all of the names of the core functions, variables, structs,
and defines to tsc200x for consistency including the driver struct/defines/etc?

Regards,

Michael
> 
> Thanks!
> 
> -- 
> Dmitry
