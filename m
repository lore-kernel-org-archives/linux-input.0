From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 13/33] Input: bfin_rotary - Use 'dev' instead of
 dereferencing it and other changes
Date: Wed, 18 Jan 2017 12:35:17 -0800
Message-ID: <20170118203517.GB6807@roeck-us.net>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
 <1484761614-12225-14-git-send-email-linux@roeck-us.net>
 <20170118193952.GG33920@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:57812 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752550AbdARUfV (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 18 Jan 2017 15:35:21 -0500
Content-Disposition: inline
In-Reply-To: <20170118193952.GG33920@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jan 18, 2017 at 11:39:52AM -0800, Dmitry Torokhov wrote:
> On Wed, Jan 18, 2017 at 09:46:34AM -0800, Guenter Roeck wrote:
> > Use local variable 'dev' instead of dereferencing it several times.
> > Other relevant changes:
> >   Replace devm_add_action() with devm_add_action_or_reset()
> > 
> > This conversion was done automatically with coccinelle using the
> > following semantic patches. The semantic patches and the scripts
> > used to generate this commit log are available at
> > https://github.com/groeck/coccinelle-patches
> > 
> > - Replace devm_add_action() followed by failure action with
> >   devm_add_action_or_reset()
> > - Drop unnecessary braces around conditional return statements
> > - Use local variable 'struct device *dev' consistently
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/input/misc/bfin_rotary.c | 18 ++++++++----------
> >  1 file changed, 8 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/input/misc/bfin_rotary.c b/drivers/input/misc/bfin_rotary.c
> > index a0fc18fdfc0c..9f5790c6e06b 100644
> > --- a/drivers/input/misc/bfin_rotary.c
> > +++ b/drivers/input/misc/bfin_rotary.c
> > @@ -141,25 +141,23 @@ static int bfin_rotary_probe(struct platform_device *pdev)
> >  
> >  	/* Basic validation */
> >  	if ((pdata->rotary_up_key && !pdata->rotary_down_key) ||
> > -	    (!pdata->rotary_up_key && pdata->rotary_down_key)) {
> > +	    (!pdata->rotary_up_key && pdata->rotary_down_key))
> >  		return -EINVAL;
> > -	}
> 
> This is complex "if" statement, would prefer keep the braces.
> 
Agreed.

> >  
> >  	if (pdata->pin_list) {
> >  		error = peripheral_request_list(pdata->pin_list,
> > -						dev_name(&pdev->dev));
> > +						dev_name(dev));
> >  		if (error) {
> >  			dev_err(dev, "requesting peripherals failed: %d\n",
> >  				error);
> >  			return error;
> >  		}
> >  
> > -		error = devm_add_action(dev, bfin_rotary_free_action,
> > -					pdata->pin_list);
> > +		error = devm_add_action_or_reset(dev, bfin_rotary_free_action,
> > +						 pdata->pin_list);
> >  		if (error) {
> >  			dev_err(dev, "setting cleanup action failed: %d\n",
> >  				error);
> > -			peripheral_free_list(pdata->pin_list);
> >  			return error;
> >  		}
> >  	}
> > @@ -189,7 +187,7 @@ static int bfin_rotary_probe(struct platform_device *pdev)
> >  
> >  	input->name = pdev->name;
> >  	input->phys = "bfin-rotary/input0";
> > -	input->dev.parent = &pdev->dev;
> > +	input->dev.parent = dev;
> >  
> >  	input_set_drvdata(input, rotary);
> >  
> > @@ -224,8 +222,8 @@ static int bfin_rotary_probe(struct platform_device *pdev)
> >  		return -ENOENT;
> >  	}
> >  
> > -	error = devm_request_irq(dev, rotary->irq, bfin_rotary_isr,
> > -				 0, dev_name(dev), rotary);
> > +	error = devm_request_irq(dev, rotary->irq, bfin_rotary_isr, 0,
> > +				 dev_name(dev), rotary);
> 
> Do not see point of this change.
> 
Me fighting with coccinelle ;-). Diffficult to tell it to avoid non-changes
like this. I need to figure out to tell it to ...

> >  	if (error) {
> >  		dev_err(dev, "unable to claim irq %d; error %d\n",
> >  			rotary->irq, error);
> > @@ -239,7 +237,7 @@ static int bfin_rotary_probe(struct platform_device *pdev)
> >  	}
> >  
> >  	platform_set_drvdata(pdev, rotary);
> > -	device_init_wakeup(&pdev->dev, 1);
> > +	device_init_wakeup(dev, 1);

... only reformat a line when it is actually doing something on that line,
not on the entire function.

Thanks,
Guenter
