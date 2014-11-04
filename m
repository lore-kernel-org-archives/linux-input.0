From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC 1/1] Input: gpio_keys - add device tree support for
 interrupt only keys
Date: Mon, 3 Nov 2014 23:50:04 -0800
Message-ID: <20141104075004.GA13100@dtor-ws>
References: <1412091647-1562-1-git-send-email-alexander.stein@systec-electronic.com>
 <3831095.dNKMkPVWlN@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:39643 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbaKDHuJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Nov 2014 02:50:09 -0500
Received: by mail-ie0-f174.google.com with SMTP id x19so6804769ier.5
        for <linux-input@vger.kernel.org>; Mon, 03 Nov 2014 23:50:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <3831095.dNKMkPVWlN@ws-stein>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-input@vger.kernel.org

Hi ALexander,

On Tue, Oct 14, 2014 at 08:30:43AM +0200, Alexander Stein wrote:
> Ping?
> 
> On Tuesday 30 September 2014 17:40:47, Alexander Stein wrote:
> > This features already exists for board config setups. Add support for
> > device tree based systems.
> > 
> > Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> > ---
> > I'm aware thatthe device tree binding description is missing yet. But for now
> > I just want some feedback about that approach.
> > 
> >  drivers/input/keyboard/gpio_keys.c | 31 ++++++++++++++++++-------------
> >  1 file changed, 18 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> > index 8c98e97..7b90e1b 100644
> > --- a/drivers/input/keyboard/gpio_keys.c
> > +++ b/drivers/input/keyboard/gpio_keys.c
> > @@ -29,6 +29,7 @@
> >  #include <linux/of.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/of_gpio.h>
> > +#include <linux/of_irq.h>
> >  #include <linux/spinlock.h>
> >  
> >  struct gpio_button_data {
> > @@ -617,28 +618,32 @@ gpio_keys_get_devtree_pdata(struct device *dev)
> >  
> >  	i = 0;
> >  	for_each_child_of_node(node, pp) {
> > -		int gpio;
> > +		int gpio = -1;
> > +		int irq;
> >  		enum of_gpio_flags flags;
> >  
> > -		if (!of_find_property(pp, "gpios", NULL)) {
> > +		irq = irq_of_parse_and_map(pp, 0);
> > +

Hmm, the current button setup code will ignore the irq if button's gpio
is valid. We shoudl either not try to parse/map irq or make that code
properly handle cases where both gpio and interrupt are specified (and
they might be different).

Also, board code supports having a single interrupt shared between all
buttons, it woudl be nice if OF supported the same.

And lastly, we need the device tree binding updated (please CC device
tree folks/list).

Thanks! 

> > +		if (of_find_property(pp, "gpios", NULL)) {
> > +			gpio = of_get_gpio_flags(pp, 0, &flags);
> > +			if (gpio < 0) {
> > +				error = gpio;
> > +				if (error != -EPROBE_DEFER)
> > +					dev_err(dev,
> > +						"Failed to get gpio flags, error: %d\n",
> > +						error);
> > +				return ERR_PTR(error);
> > +			}
> > +		} else if (irq == 0) {
> >  			pdata->nbuttons--;
> > -			dev_warn(dev, "Found button without gpios\n");
> > +			dev_warn(dev, "Found button without gpios or irqs\n");
> >  			continue;
> >  		}
> >  
> > -		gpio = of_get_gpio_flags(pp, 0, &flags);
> > -		if (gpio < 0) {
> > -			error = gpio;
> > -			if (error != -EPROBE_DEFER)
> > -				dev_err(dev,
> > -					"Failed to get gpio flags, error: %d\n",
> > -					error);
> > -			return ERR_PTR(error);
> > -		}
> > -
> >  		button = &pdata->buttons[i++];
> >  
> >  		button->gpio = gpio;
> > +		button->irq = irq;
> >  		button->active_low = flags & OF_GPIO_ACTIVE_LOW;
> >  
> >  		if (of_property_read_u32(pp, "linux,code", &button->code)) {
> > 
> 

-- 
Dmitry
