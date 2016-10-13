From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v3 2/2] Input: synaptics-rmi4 - add support for F34
 device reflash
Date: Thu, 13 Oct 2016 15:52:45 +0200
Message-ID: <20161013135245.GM15950@mail.corp.redhat.com>
References: <1474404162-29357-1-git-send-email-nick@shmanahar.org>
 <1474404162-29357-3-git-send-email-nick@shmanahar.org>
 <20161010134807.GJ30411@mail.corp.redhat.com>
 <20161012185705.GA20820@lava.h.shmanahar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752150AbcJMNx3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 13 Oct 2016 09:53:29 -0400
Content-Disposition: inline
In-Reply-To: <20161012185705.GA20820@lava.h.shmanahar.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Chris Healy <cphealy@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Oct 12 2016 or thereabouts, Nick Dyer wrote:
> Hi Benjamin-
> 
> Thanks for the review, I've answered in line.
> 
> On Mon, Oct 10, 2016 at 03:48:07PM +0200, Benjamin Tissoires wrote:
> > On Sep 20 2016 or thereabouts, Nick Dyer wrote:
> > > Signed-off-by: Nick Dyer <nick@shmanahar.org>
> > > Tested-by: Chris Healy <cphealy@gmail.com>
> > > ---
> > >  drivers/input/rmi4/Kconfig      |  11 +
> > >  drivers/input/rmi4/Makefile     |   1 +
> > >  drivers/input/rmi4/rmi_bus.c    |   3 +
> > >  drivers/input/rmi4/rmi_driver.c | 161 ++++++++++++++-
> > >  drivers/input/rmi4/rmi_driver.h |   7 +
> > >  drivers/input/rmi4/rmi_f01.c    |   6 +
> > >  drivers/input/rmi4/rmi_f34.c    | 446 ++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/rmi.h             |   1 +
> > >  8 files changed, 634 insertions(+), 2 deletions(-)
> > >  create mode 100644 drivers/input/rmi4/rmi_f34.c
> [...]
> > > @@ -143,8 +154,11 @@ int rmi_process_interrupt_requests(struct rmi_device *rmi_dev)
> > >  	struct rmi_function *entry;
> > >  	int error;
> > >  
> > > -	if (!data)
> > > +	mutex_lock(&data->irq_mutex);
> > > +	if (!data || !data->irq_status || !data->f01_container) {
> > > +		mutex_unlock(&data->irq_mutex);
> > 
> > I have been now convinced that IRQ should be handled in core. It would
> > make everyone's life easier and I think means that we won't need these
> > checks given that IRQ could simply be disabled during FW update.
> > 
> > I guess it's time to resurrect Bjorn's patch at
> > https://lkml.org/lkml/2016/5/9/1055
> 
> We do use the interrupts in FW update in the current version. I haven't
> done the measurements, but my expectation would be that performance is
> slightly improved over polling, and it's more elegant.
> 
> > > +#ifdef CONFIG_RMI4_F34
> > > +static int rmi_firmware_update(struct rmi_driver_data *data,
> > > +			       const struct firmware *fw)
> > > +{
> > > +	struct device *dev = &data->rmi_dev->dev;
> > > +	int ret;
> > > +
> > > +	if (!data->f34_container) {
> > > +		dev_warn(dev, "%s: No F34 present!\n",
> > > +			 __func__);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	ret = rmi_f34_check_supported(data->f34_container);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/* Enter flash mode */
> > > +	rmi_dbg(RMI_DEBUG_CORE, dev, "Enabling flash\n");
> > > +	ret = rmi_f34_enable_flash(data->f34_container);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/* Tear down functions and re-probe */
> > > +	rmi_free_function_list(data->rmi_dev);
> > > +
> > > +	ret = rmi_probe_interrupts(data);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = rmi_init_functions(data);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	if (!data->f01_bootloader_mode || !data->f34_container) {
> > > +		dev_warn(dev, "%s: No F34 present or not in bootloader!\n",
> > > +			 __func__);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	/* Perform firmware update */
> > > +	ret = rmi_f34_update_firmware(data->f34_container, fw);
> > > +
> > > +	/* Re-probe */
> > > +	rmi_dbg(RMI_DEBUG_CORE, dev, "Re-probing device\n");
> > > +	rmi_free_function_list(data->rmi_dev);
> > > +
> > > +	ret = rmi_scan_pdt(data->rmi_dev, NULL, rmi_initial_reset);
> > > +	if (ret < 0)
> > > +		dev_warn(dev, "RMI reset failed!\n");
> > > +
> > > +	ret = rmi_probe_interrupts(data);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = rmi_init_functions(data);
> > > +	if (ret)
> > > +		return ret;
> > 
> > You could basically export rmi_fn_reset() which would call
> > rmi_free_function_list(), rmi_scan_pdt (if initial reset),
> > rmi_probe_interrupts() and rmi_init_functions, and this would allow you
> > to have all this in f34.
> 
> I see what you mean, and I do agree that it would be neater to have all
> of this in the f34 code.
> 
> However, the problem is that when you call rmi_free_function_list(), the
> f34 driver and all the context information attached to it (struct
> rmi_function, struct f34_data, and any sysfs attributes in the f34
> directory) gets torn down, so you're kind of left without the branch you
> were sitting on.
> 
> To get around that, I'd have to make f34 a special case anyway. Taking
> that into account, the current solution seemed neater to me. I could
> possibly cram a little more of it into rmi_f34.c, but I think the
> context has to be "struct rmi_driver_data".

If I understand correctly, rmi_firmware_update() is only called through
the sysfs. So how about you export the required functions from core you
are using and export 2 functions from rmi_f34 that will be a special
case: rmi_f34_create_sysfs() and rmi_f34_remove_sysfs() (or any better
names). You could just put your code in rmi_f34, provide noops
declarations if RMI_F34 is not set, and core will have only 2 calls to
rmi_f34.

BTW, I am thinking at carrying in my next RMI4 series your 1/2 patch. I
also want to take Bjorn and Andrew left patches so that we have a common
tree at some point. Any objections? 
Of course, if you resubmit before me, feel free to carry over 1/2.

Cheers,
Benjamin

> 
> Nick
