From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: gpio_keys - fix warning regarding uninitialized
 'button' variable
Date: Sat, 13 Dec 2014 11:05:20 -0800
Message-ID: <20141213190520.GC22702@dtor-ws>
References: <1418136252-14365-1-git-send-email-fabio.estevam@freescale.com>
 <20141213190035.GB22702@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:55773 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752360AbaLMTFZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Dec 2014 14:05:25 -0500
Received: by mail-ie0-f174.google.com with SMTP id rl12so8745730iec.19
        for <linux-input@vger.kernel.org>; Sat, 13 Dec 2014 11:05:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141213190035.GB22702@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: linux-input@vger.kernel.org, festevam@gmail.com

On Sat, Dec 13, 2014 at 11:00:35AM -0800, Dmitry Torokhov wrote:
> On Tue, Dec 09, 2014 at 12:44:12PM -0200, Fabio Estevam wrote:
> > Commit af906faabcf91eb1 ("Input: gpio_keys - fix warning regarding uninitialized
> > 'irq' variable") introduced the following build warning:
> > 
> > drivers/input/keyboard/gpio_keys.c:625:16: warning: 'button' may be used uninitialized in this function [-Wmaybe-uninitialized]
> > 
> > Move the 'button' initialization to a proper location to avoid such warning.
> 
> Doh! Why didn't I see the warning at least? Argh!
> 
> Applied, thank you.
> 
> > 
> > Reported-by: Olof's autobuilder <build@lixom.net>
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> > ---
> >  drivers/input/keyboard/gpio_keys.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> > index fb8256f..28ac922 100644
> > --- a/drivers/input/keyboard/gpio_keys.c
> > +++ b/drivers/input/keyboard/gpio_keys.c
> > @@ -621,6 +621,8 @@ gpio_keys_get_devtree_pdata(struct device *dev)
> >  		int gpio = -1;
> >  		enum of_gpio_flags flags;
> >  
> > +		button = &pdata->buttons[i++];
> > +
> >  		if (!of_find_property(pp, "gpios", NULL)) {
> >  			button->irq = irq_of_parse_and_map(pp, 0);
> >  			if (button->irq == 0) {

By the way, I added
				i--;

here to avoid skipping over one element.

> > @@ -640,8 +642,6 @@ gpio_keys_get_devtree_pdata(struct device *dev)
> >  			}
> >  		}
> >  
> > -		button = &pdata->buttons[i++];
> > -
> >  		button->gpio = gpio;
> >  		button->active_low = flags & OF_GPIO_ACTIVE_LOW;
> >  
> > -- 
> > 1.9.1
> > 
> 
> -- 
> Dmitry

-- 
Dmitry
