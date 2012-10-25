From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFT/PATCH] Input: omap4-keypad - switch to use managed resources
Date: Thu, 25 Oct 2012 11:24:23 -0700
Message-ID: <20121025182423.GB24594@core.coreip.homeip.net>
References: <20121025074559.GA17710@core.coreip.homeip.net>
 <5089382C.2020202@ti.com>
 <20121025140916.GC16564@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:49158 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759429Ab2JYSY1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Oct 2012 14:24:27 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2202156pbb.19
        for <linux-input@vger.kernel.org>; Thu, 25 Oct 2012 11:24:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20121025140916.GC16564@arwen.pp.htv.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Sourav <sourav.poddar@ti.com>, linux-input@vger.kernel.org

On Thu, Oct 25, 2012 at 05:09:16PM +0300, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Oct 25, 2012 at 06:31:32PM +0530, Sourav wrote:
> > Hi Dmitry,
> > 
> > -       pm_runtime_put_sync(dev);
> > -
> >  out:
> >         pm_runtime_disable(dev);
> >         return retval;
> > @@ -387,8 +385,9 @@
> >                 return error;
> >         }
> > 
> > +       pm_runtime_put_sync(dev);
> > +
> >         platform_set_drvdata(pdev, keypad_data);
> > -       pm_runtime_enable(dev);
> > 
> >         return 0;
> >  }
> > 
> > This patch seems to solve the warning and keypad functionality is restored.
> 
> the driver looks wrong to me. Why are calling pm_runtime_put_sync()
> after pm_runtime_disable() ???

No, we should not be doing this...

OK, so the idea was to do everything via managed resources (devm_*) and
not having any gotos :) But I guess we had keypad somewhat alive and it
managed to generate an interrupt while parent(s) was sleeping because we
did pm_runtime_put_sync()/pm_runtime_disable() after reading register.
I wonder if we should have something like:

static void omap4_keypad_inhibit()
{
	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
			 OMAP4_VAL_IRQDISABLE);
	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS,
			 kbd_read_irqreg(keypad_data,
					 OMAP4_KBD_IRQSTATUS));
}

and call it after reading the revision register.

Either that or we need devm_pm_runtime_enable().

Thanks.

-- 
Dmitry
