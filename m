From: Courtney Cavin <courtney.cavin@sonymobile.com>
Subject: Re: [PATCH] input synaptics-rmi4: rmi_f01.c storage fix
Date: Wed, 12 Feb 2014 15:35:33 -0800
Message-ID: <20140212233533.GF1706@sonymobile.com>
References: <1392160380-8221-1-git-send-email-cheiny@synaptics.com>
 <20140212064049.GA15855@core.coreip.homeip.net>
 <20140212214819.GE1706@sonymobile.com>
 <52FC0202.7020003@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([212.209.106.2]:7644 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750767AbaBLXdt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Feb 2014 18:33:49 -0500
Content-Disposition: inline
In-Reply-To: <52FC0202.7020003@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

On Thu, Feb 13, 2014 at 12:21:38AM +0100, Christopher Heiny wrote:
> On 02/12/2014 01:48 PM, Courtney Cavin wrote:
> > On Wed, Feb 12, 2014 at 07:40:49AM +0100, Dmitry Torokhov wrote:
> >> Hi Chris,
> >>
> >> On Tue, Feb 11, 2014 at 03:13:00PM -0800, Christopher Heiny wrote:
> > [...]
> >> -static int rmi_f01_initialize(struct rmi_function *fn)
> >> +static int rmi_f01_probe(struct rmi_function *fn)
> >>   {
> >> -       u8 temp;
> >> -       int error;
> >> -       u16 ctrl_base_addr;
> >>          struct rmi_device *rmi_dev = fn->rmi_dev;
> >>          struct rmi_driver_data *driver_data = dev_get_drvdata(&rmi_dev->dev);
> >> -       struct f01_data *data = fn->data;
> >> -       struct rmi_device_platform_data *pdata = to_rmi_platform_data(rmi_dev);
> >> +       const struct rmi_device_platform_data *pdata =
> >> +                               to_rmi_platform_data(rmi_dev);
> >> +       struct f01_data *f01;
> >> +       size_t f01_size;
> >> +       int error;
> >> +       u16 ctrl_base_addr;
> >> +       u8 device_status;
> >> +       u8 temp;
> >> +
> >> +       f01_size = sizeof(struct f01_data) +
> >> +                               sizeof(u8) * driver_data->num_of_irq_regs;
> >> +       f01 = devm_kzalloc(&fn->dev, f01_size, GFP_KERNEL);
> >> +       if (!f01) {
> >> +               dev_err(&fn->dev, "Failed to allocate fn01_data.\n");
> >
> > Nitpick: Can we drop this printout in the process?  It's much less
> > useful than the error and backtrace coming from kmalloc on failure anyway.
> 
> We print messages like that in a lot of places.  Based on your prior 
> comments, I figured to do a blanket up date that removes all of those at 
> once across the driver.  Would that be an OK solution?

It's not really necessary to do a bulk cleanup of this, as it's not a
huge thing.  I just thought that since we were changing the text anyway, we
might as well get rid of the unnecessary stuff.  Dmitry's new email in this
thread settles the issue though, he prefers it, so it stays.

> >> +               return -ENOMEM;
> >> +       }
> > [...]
> >
> >> +       /* XXX: why we check has_lts here but has_adjustable_doze in probe? */
> >
> > Hrm.  This register is poorly documented in the spec.  All of these bits
> > are reserved.  Chris, is there a newer version of the spec which
> > documents these bits?
> 
> Unfortunately, no.  I've filed a bug on that.  In the meantime, I've 
> found the following:
> 
> * It looks like there's a control register F01_RMI_Ctrl4 which is 
> present if the has_lts bit is set, but is not used in any shipped LTS 
> products.
> 
> * Both F01_RMI_Ctrl2 and F01_RMI_Ctrl3 (doze_interval and 
> wakeup_threshold) are controlled by the has_adjustable_doze bit.
> 
> The patch I sent a bit ago includes fixes based on this info.

Ah, OK.  Thanks for the info!

-Courtney
