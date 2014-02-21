From: Christopher Heiny <Cheiny@synaptics.com>
Subject: RE: [PATCH] input synaptics-rmi4: Use put_device() and
 device_type.release() to free storage.
Date: Fri, 21 Feb 2014 23:29:42 +0000
Message-ID: <BFABBC009FBA1C43B207B15FD485ABD930342470@USW-MAIL1.synaptics-inc.local>
References: <1392160410-8293-1-git-send-email-cheiny@synaptics.com>
 <20140212064925.GC15855@core.coreip.homeip.net>
 <52FC2E68.1060709@synaptics.com>
 <20140213061524.GA15260@core.coreip.homeip.net>
 <20140213215930.GH1706@sonymobile.com>,<20140213221048.GA6650@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:43972 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734AbaBUX3L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Feb 2014 18:29:11 -0500
In-Reply-To: <20140213221048.GA6650@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Courtney Cavin <courtney.cavin@sonymobile.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <Vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

Sorry for top posting - using web mail right now.

I think something like allocate_device and free_device will be needed sooner rather than later. I'll get a patch out for that in the next couple of days.

Chris

________________________________________
From: linux-input-owner@vger.kernel.org [linux-input-owner@vger.kernel.org] on behalf of Dmitry Torokhov [dmitry.torokhov@gmail.com]
Sent: Thursday, February 13, 2014 2:10 PM
To: Courtney Cavin
Cc: Christopher Heiny; Linux Input; Andrew Duggan; Vincent Huang; Vivian Ly; Daniel Rosenberg; Jean Delvare; Joerie de Gram; Linus Walleij; Benjamin Tissoires; David Herrmann; Jiri Kosina
Subject: Re: [PATCH] input synaptics-rmi4: Use put_device() and device_type.release() to free storage.

On Thu, Feb 13, 2014 at 01:59:31PM -0800, Courtney Cavin wrote:
> On Thu, Feb 13, 2014 at 07:15:24AM +0100, Dmitry Torokhov wrote:
> > On Wed, Feb 12, 2014 at 06:31:04PM -0800, Christopher Heiny wrote:
> > > Input: synaptics-rmi4 - Use put_device() and device_type.release()
> > > to free storage.
> > >
> > > From: Christopher Heiny <cheiny@synaptics.com>
> > >
> > > For rmi_sensor and rmi_function device_types, use put_device() and
> > > the assocated device_type.release() function to clean up related
> > > structures and storage in the correct and safe order.
> > >
> > > Allocate irq_mask as part of struct rmi_function.
> > >
> > > Delete unused rmi_driver_irq_get_mask() function.
> [...]
> > Input: synaptics-rmi4 - use put_device() to free devices
> >
> > From: Christopher Heiny <cheiny@synaptics.com>
> >
> > For rmi_sensor and rmi_function device_types, use put_device() and
> > the associated device_type->release() function to clean up related
> > structures and storage in the correct and safe order.
> >
> > Allocate irq_mask as part of struct rmi_function.
> >
> > Suggested-by: Courtney Cavin <courtney.cavin@sonymobile.com>
> > Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/input/rmi4/rmi_bus.c    |   30 +++++++++++++++++++++---------
> >  drivers/input/rmi4/rmi_bus.h    |    7 ++++---
> >  drivers/input/rmi4/rmi_driver.c |   25 +++++++------------------
> >  3 files changed, 32 insertions(+), 30 deletions(-)
> >
> > diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
> [...]
> > @@ -142,6 +150,7 @@ EXPORT_SYMBOL(rmi_unregister_transport_device);
> >  static void rmi_release_function(struct device *dev)
> >  {
> >     struct rmi_function *fn = to_rmi_function(dev);
> > +
> >     kfree(fn);
> >  }
>
> Ownership of this memory is a bit weird...
>
> [...]
> >  void rmi_unregister_function(struct rmi_function *fn)
> >  {
> > +   device_del(&fn->dev);
> >     rmi_function_teardown_debugfs(fn);
> > -   device_unregister(&fn->dev);
> > +   put_device(&fn->dev);
> >  }
>
> Here clearly the bus code owns it...
>
> > diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> [...]
> >  static int rmi_create_function(struct rmi_device *rmi_dev,
> > -                         void *ctx, const struct pdt_entry *pdt)
> > +                          void *ctx, const struct pdt_entry *pdt)
> >  {
> >     struct device *dev = &rmi_dev->dev;
> >     struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
> > @@ -630,7 +629,9 @@ static int rmi_create_function(struct rmi_device *rmi_dev,
> >     dev_dbg(dev, "Initializing F%02X for %s.\n",
> >             pdt->function_number, pdata->sensor_name);
> >
> > -   fn = kzalloc(sizeof(struct rmi_function), GFP_KERNEL);
> > +   fn = kzalloc(sizeof(struct rmi_function) +
> > +                   BITS_TO_LONGS(data->irq_count) * sizeof(unsigned long),
> > +                GFP_KERNEL);
>
> But it's allocated in the chip driver...
>
> >     if (!fn) {
> >             dev_err(dev, "Failed to allocate memory for F%02X\n",
> >                     pdt->function_number);
> > @@ -646,22 +647,12 @@ static int rmi_create_function(struct rmi_device *rmi_dev,
> >     fn->irq_pos = *current_irq_count;
> >     *current_irq_count += fn->num_of_irqs;
> >
> > -   fn->irq_mask = kzalloc(
> > -           BITS_TO_LONGS(data->irq_count) * sizeof(unsigned long),
> > -           GFP_KERNEL);
> > -   if (!fn->irq_mask) {
> > -           dev_err(dev, "%s: Failed to create irq_mask for F%02X.\n",
> > -                   __func__, pdt->function_number);
> > -           error = -ENOMEM;
> > -           goto err_free_mem;
> > -   }
> > -
> >     for (i = 0; i < fn->num_of_irqs; i++)
> >             set_bit(fn->irq_pos + i, fn->irq_mask);
> >
> >     error = rmi_register_function(fn);
> >     if (error)
> > -           goto err_free_irq_mask;
> > +           goto err_put_fn;
> >
> >     if (pdt->function_number == 0x01)
> >             data->f01_container = fn;
> > @@ -670,10 +661,8 @@ static int rmi_create_function(struct rmi_device *rmi_dev,
> >
> >     return RMI_SCAN_CONTINUE;
> >
> > -err_free_irq_mask:
> > -   kfree(fn->irq_mask);
> > -err_free_mem:
> > -   kfree(fn);
> > +err_put_fn:
> > +   put_device(&fn->dev);
>
> And the chip driver now is expected to know it's a device, and trust
> that the bus code knows how to free the memory.

Yeah. That is why for input devices I have a separate
input_allocate_device and input_free_device... But given that RMI is
pretty-much self-contained I think we can live with this.

>
> As this clearly fixes a bug or two, I say we should take this patch
> as-is and worry about proper ownership at some other time.
>
> -Courtney

--
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
