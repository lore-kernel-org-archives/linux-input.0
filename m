From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] Input: adxl34x - Make it enumerable in ACPI
 environment
Date: Tue, 03 Jan 2017 12:49:43 +0200
Message-ID: <1483440583.9552.200.camel@linux.intel.com>
References: <20170102120624.178283-1-andriy.shevchenko@linux.intel.com>
         <20170103063501.GB5743@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:20360 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757255AbdACKww (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 3 Jan 2017 05:52:52 -0500
In-Reply-To: <20170103063501.GB5743@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

On Mon, 2017-01-02 at 22:35 -0800, Dmitry Torokhov wrote:
> On Mon, Jan 02, 2017 at 02:06:23PM +0200, Andy Shevchenko wrote:
> > The ACPI-enabled platform may contain _DSD method to enable this
> > driver using
> > compatible string.
> > 
> > Remove OF specifics to re-use existing code on ACPI-enabled
> > platforms.
> 
> Is there an x86 box that uses this device?

Any open connected one, Edison, Galileo, Joule.

Since we have open connected hardware any sensor can be connected to
x86-based board.

> 
> Thanks.
> 
> > 
> > Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/input/misc/adxl34x-i2c.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/input/misc/adxl34x-i2c.c
> > b/drivers/input/misc/adxl34x-i2c.c
> > index a8b0a2eec344..7fed92fb8cc1 100644
> > --- a/drivers/input/misc/adxl34x-i2c.c
> > +++ b/drivers/input/misc/adxl34x-i2c.c
> > @@ -136,7 +136,6 @@ static const struct i2c_device_id adxl34x_id[] =
> > {
> >  
> >  MODULE_DEVICE_TABLE(i2c, adxl34x_id);
> >  
> > -#ifdef CONFIG_OF
> >  static const struct of_device_id adxl34x_of_id[] = {
> >  	/*
> >  	 * The ADXL346 is backward-compatible with the ADXL345.
> > Differences are
> > @@ -153,13 +152,12 @@ static const struct of_device_id
> > adxl34x_of_id[] = {
> >  };
> >  
> >  MODULE_DEVICE_TABLE(of, adxl34x_of_id);
> > -#endif
> >  
> >  static struct i2c_driver adxl34x_driver = {
> >  	.driver = {
> >  		.name = "adxl34x",
> >  		.pm = &adxl34x_i2c_pm,
> > -		.of_match_table = of_match_ptr(adxl34x_of_id),
> > +		.of_match_table = adxl34x_of_id,
> >  	},
> >  	.probe    = adxl34x_i2c_probe,
> >  	.remove   = adxl34x_i2c_remove,
> > -- 
> > 2.11.0
> > 
> 
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
