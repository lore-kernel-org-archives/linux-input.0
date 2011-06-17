From: David Jander <david.jander@protonic.nl>
Subject: Re: [PATCH v4 2/3] Input: gpio_keys.c: Added support for
 device-tree platform data
Date: Fri, 17 Jun 2011 10:58:23 +0200
Message-ID: <20110617105823.77c5920a@archvile>
References: <1308042491-20203-1-git-send-email-david@protonic.nl>
	<1308042491-20203-3-git-send-email-david@protonic.nl>
	<20110616192559.GI3795@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([213.84.116.84]:1586 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757271Ab1FQI6Y (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jun 2011 04:58:24 -0400
In-Reply-To: <20110616192559.GI3795@ponder.secretlab.ca>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: David Jander <david@protonic.nl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org


Hi Grant,

On Thu, 16 Jun 2011 13:25:59 -0600
Grant Likely <grant.likely@secretlab.ca> wrote:

> On Tue, Jun 14, 2011 at 11:08:10AM +0200, David Jander wrote:
> > This patch enables fetching configuration data which is normally provided
> > via platform_data from the device-tree instead.
> > If the device is configured from device-tree data, the platform_data struct
> > is not used, and button data needs to be allocated dynamically.
> > Big part of this patch deals with confining pdata usage to the probe
> > function, to make this possible.
> > 
> > Signed-off-by: David Jander <david@protonic.nl>
> > ---
> >  .../devicetree/bindings/gpio/gpio_keys.txt         |   49 +++++++
> >  drivers/input/keyboard/gpio_keys.c                 |  147
> > ++++++++++++++++++-- 2 files changed, 186 insertions(+), 10 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/gpio/gpio_keys.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/gpio/gpio_keys.txt
> > b/Documentation/devicetree/bindings/gpio/gpio_keys.txt new file mode 100644
> > index 0000000..60a4d8e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gpio/gpio_keys.txt
> > @@ -0,0 +1,49 @@
> > +Device-Tree bindings for input/gpio_keys.c keyboard driver
> > +
> > +Required properties:
> > +	- compatible = "gpio-keys";
> > +
> > +Optional properties:
> > +	- autorepeat: Boolean, Enable auto repeat feature of Linux input
> > +	  subsystem.
> > +
> > +Each button (key) is represented as a sub-node of "gpio-keys":
> > +Subnode properties:
> > +
> > +	- reg: GPIO number the key is bound to if linux GPIO numbering is
> > used.
> 
> Wait.  That won't work.  There is no concept of "linux gpio numbering"
> in the device tree data.  When using device tree, the gpio numbers
> usually get dynamically assigned.

Yes I know, but suppose you want to use this driver with a GPIO-driver that
does not have devaice-tree support yet? I need a way of binding the button to
a GPIO pin that does not have a device-tree definition. How should I do this
otherwise?
I am using this driver with a pca963x, as you might have suspected already,
and I just added OF device-tree support to it, so that will work, but
others...?
Before "fixing" pca963x, I used this property and it worked perfectly well, so
please explain what is not supposed to work. Please keep in mind that this
is meant as more of a backwards-compatibility feature. If you think that being
backwards compatible with non-OF GPIO drivers is a bad idea, I'll remove this.

> > +	- gpios: OF devcie-tree gpio specification, can be used
> > alternatively
> > +	  if 'reg' is not specified, to use device-tree GPIOs.
> > +	- label: Descriptive name of the key.
> > +	- linux,code: Keycode to emit.
> > +
> > +Optional subnode-properties:
> > +	- active-low: Boolean flag to specify active-low GPIO input. Not
> > used
> > +	  if device-tree gpios property is used.
> > +	- linux,input-type: Specify event type this button/key generates.
> > +	  Default if unspecified is <1> == EV_KEY.
> > +	- debounce-interval: Debouncing interval time in milliseconds.
> > +	  Default if unspecified is 5.
> > +	- wakeup: Boolean, button can wake-up the system.
> 
> "wakeup" is potentially too generic a property name (potential to
> conflict with a generic wakeup binding if one ever exists).  Just to
> be defencive, I'd suggest prefixing these custom gpio keys properties
> with something like "gpio-key,".

Ok, "gpio-key,wakeup" it will be then? But isn't this function something
potentially other IO-pins/keys/buttons/interrupts/etc... could have to be able
to wake up the system?

> > +
> > +Example nodes:
> > +
> > +	gpio_keys {
> > +			compatible = "gpio-keys";
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			autorepeat;
> > +			button@20 {
> > +				label = "GPIO Key ESC";
> > +				linux,code = <1>;
> > +				reg = <0x20>;
> > +				key-active-low;
> > +				linux,input-type = <1>;
> > +			};
> > +			button@21 {
> > +				label = "GPIO Key UP";
> > +				linux,code = <103>;
> > +				gpios = <&gpio1 0 1>;
> > +				linux,input-type = <1>;
> > +			};
> > +			...
> > +
> > diff --git a/drivers/input/keyboard/gpio_keys.c
> > b/drivers/input/keyboard/gpio_keys.c index 987498e..78aeeaa 100644
> > --- a/drivers/input/keyboard/gpio_keys.c
> > +++ b/drivers/input/keyboard/gpio_keys.c
> > @@ -3,6 +3,9 @@
> >   *
> >   * Copyright 2005 Phil Blundell
> >   *
> > + * Added OF support:
> > + * Copyright 2010 David Jander <david@protonic.nl>
> > + *
> 
> But it's 2011!  :-)

Ooops :-) You see... this patch is rather old already (in my tree). I actually
wrote it in 2010, but I am submitting it now. I guess it should be "2010, 2011"
then?

> >   * This program is free software; you can redistribute it and/or modify
> >   * it under the terms of the GNU General Public License version 2 as
> >   * published by the Free Software Foundation.
> > @@ -25,6 +28,8 @@
> >  #include <linux/gpio_keys.h>
> >  #include <linux/workqueue.h>
> >  #include <linux/gpio.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/of_gpio.h>
> >  
> >  struct gpio_button_data {
> >  	struct gpio_keys_button *button;
> > @@ -442,15 +447,124 @@ static void gpio_keys_close(struct input_dev *input)
> >  		ddata->disable(input->dev.parent);
> >  }
> >  
> > +/*
> > + * Handlers for alternative sources of platform_data
> > + */
> > +#ifdef CONFIG_OF
> > +/*
> > + * Translate OpenFirmware node properties into platform_data
> > + */
> > +static struct gpio_keys_platform_data *
> > +gpio_keys_get_devtree_pdata(struct device *dev,
> > +			    struct gpio_keys_platform_data *altp)
> > +{
> > +	struct gpio_keys_platform_data *pdata = altp;
> 
> pdata is always the same as altp.

Ok, right.

> You don't need this on the stack, and the return value should be an error
> code instead of a pointer because the pointer is already passed in!

Hmm... I was (mis-)using the returned pointer as an error code. Will try to
come up with something more sensible.

> > +	struct device_node *node, *pp;
> > +	int i;
> > +	struct gpio_keys_button *buttons;
> > +	const u32 *reg;
> > +	int len;
> > +
> > +	node = dev->of_node;
> > +	if (node == NULL)
> > +		return NULL;
> > +
> > +	memset(pdata, 0, sizeof *pdata);
> > +
> > +	pdata->rep = !!of_get_property(node, "autorepeat", &len);
> > +
> > +	/* First count the subnodes */
> > +	pdata->nbuttons = 0;
> > +	pp = NULL;
> > +	while ((pp = of_get_next_child(node, pp)))
> > +		pdata->nbuttons++;
> > +
> > +	if (pdata->nbuttons == 0)
> > +		return NULL;
> > +
> > +	buttons = kzalloc(pdata->nbuttons * (sizeof *buttons),
> > GFP_KERNEL);
> > +	if (!buttons)
> > +		return NULL;
> > +
> > +	pp = NULL;
> > +	i = 0;
> > +	while ((pp = of_get_next_child(node, pp))) {
> > +		const char *lbl;
> > +		enum of_gpio_flags flags;
> > +
> > +		reg = of_get_property(pp, "reg", &len);
> > +		if (!reg && !of_find_property(pp, "gpios", NULL)) {
> > +			pdata->nbuttons--;
> > +			dev_warn(dev, "Found button without reg and
> > without gpios\n");
> > +			continue;
> > +		}
> > +		if (reg) {
> > +			buttons[i].gpio = be32_to_cpup(reg);
> 
> As mentioned above, this won't work.  Linux gpio numbers cannot be
> encoded into the DT.

Why not? It worked fine for me before I "fixed" pca963x.
If you have a non-OF GPIO controller, that one will need a numeric range of
GPIO numbers. If that range is fixed, I can perfectly well give this number to
the driver here.... again, this is only used if the GPIO driver does not
have a device-tree node.

> > +			buttons[i].active_low = !!of_get_property(pp,
> > "key-active-low", NULL);
> > +		} else {
> > +			buttons[i].gpio = of_get_gpio_flags(pp, 0,
> > &flags);
> > +			buttons[i].active_low = !!(flags &
> > OF_GPIO_ACTIVE_LOW);
> > +		}
> > +
> > +		reg = of_get_property(pp, "linux,code", &len);
> > +		if (!reg) {
> > +			dev_err(dev, "Button without keycode: 0x%x\n",
> > buttons[i].gpio);
> > +			goto out_fail;
> > +		}
> > +		buttons[i].code = be32_to_cpup(reg);
> > +
> > +		lbl = of_get_property(pp, "label", &len);
> > +		buttons[i].desc = (char *)lbl;
> > +
> > +		reg = of_get_property(pp, "linux,input-type", &len);
> > +		if (reg)
> > +			buttons[i].type = be32_to_cpup(reg);
> > +		else
> > +			buttons[i].type = EV_KEY;
> how about:
> 		buttons[i].type = reg ? be32_to_cpup(reg) : EV_KEY;

Ok, if you prefer this notation.... just an "if...else" in another dress ;-)

> > +
> > +		buttons[i].wakeup = !!of_get_property(pp, "wakeup", NULL);
> > +
> > +		reg = of_get_property(pp, "debounce-interval", &len);
> > +		if (reg)
> > +			buttons[i].debounce_interval = be32_to_cpup(reg);
> > +		else
> > +			buttons[i].debounce_interval = 5;
> 
> Ditto here.

Ok, as you wish.

> > +		i++;
> > +	}
> > +
> > +	pdata->buttons = buttons;
> > +
> > +	return pdata;
> > +
> > +out_fail:
> > +	kfree(buttons);
> > +	return NULL;
> > +}
> > +#else
> > +static struct gpio_keys_platform_data *
> > +gpio_keys_get_devtree_pdata(struct device *dev,
> > +			    struct gpio_keys_platform_data *altp)
> > +{
> > +	return NULL;
> > +}
> > +#endif
> > +
> >  static int __devinit gpio_keys_probe(struct platform_device *pdev)
> >  {
> >  	struct gpio_keys_drvdata *ddata;
> >  	struct device *dev = &pdev->dev;
> >  	struct gpio_keys_platform_data *pdata = dev->platform_data;
> > +	struct gpio_keys_platform_data alt_pdata;
> >  	struct input_dev *input;
> >  	int i, error;
> >  	int wakeup = 0;
> >  
> > +	if (!pdata) {
> > +		pdata = gpio_keys_get_devtree_pdata(dev, &alt_pdata);
> > +		if (!pdata)
> > +			return -ENODEV;
> > +	}
> 
> then this would become:
> 
> 	if (!pdata) {
> 		rc = gpio_keys_get_devtree_pdata(dev, &alt_pdata);
> 		if (rc)
> 			return rc;
> 		pdata = &alt_pdata;
> 	}

Yes, of course. I just need to "invent" which error codes to use for the
different failure cases.... no problem.

> > +
> >  	ddata = kzalloc(sizeof(struct gpio_keys_drvdata) +
> >  			pdata->nbuttons * sizeof(struct gpio_button_data),
> >  			GFP_KERNEL);
> > @@ -548,7 +662,6 @@ static int __devinit gpio_keys_probe(struct
> > platform_device *pdev) static int __devexit gpio_keys_remove(struct
> > platform_device *pdev) {
> >  	struct device *dev = &pdev->dev;
> > -	struct gpio_keys_platform_data *pdata = dev->platform_data;
> >  	struct gpio_keys_drvdata *ddata = dev_get_drvdata(dev);
> >  	struct input_dev *input = ddata->input;
> >  	int i;
> > @@ -557,30 +670,42 @@ static int __devexit gpio_keys_remove(struct
> > platform_device *pdev) 
> >  	device_init_wakeup(dev, 0);
> >  
> > -	for (i = 0; i < pdata->nbuttons; i++) {
> > -		int irq = gpio_to_irq(pdata->buttons[i].gpio);
> > +	for (i = 0; i < ddata->n_buttons; i++) {
> > +		int irq = gpio_to_irq(ddata->data[i].button->gpio);
> >  		free_irq(irq, &ddata->data[i]);
> >  		if (ddata->data[i].timer_debounce)
> >  			del_timer_sync(&ddata->data[i].timer);
> >  		cancel_work_sync(&ddata->data[i].work);
> > -		gpio_free(pdata->buttons[i].gpio);
> > +		gpio_free(ddata->data[i].button->gpio);
> >  	}
> >  
> > +	/*
> > +	 * If we had no platform_data, we allocated buttons dynamically,
> > and
> > +	 * must free them here. ddata->data[0].button is the pointer to
> > the
> > +	 * beginning of the allocated array.
> > +	 */
> > +	if (!dev->platform_data)
> > +		kfree(ddata->data[0].button);
> > +
> >  	input_unregister_device(input);
> >  
> >  	return 0;
> >  }
> >  
> > +static struct of_device_id gpio_keys_of_match[] = {
> > +	{ .compatible = "gpio-keys", },
> > +	{},
> > +};
> >  
> >  #ifdef CONFIG_PM
> >  static int gpio_keys_suspend(struct device *dev)
> >  {
> > -	struct gpio_keys_platform_data *pdata = dev->platform_data;
> > +	struct gpio_keys_drvdata *ddata = dev_get_drvdata(dev);
> >  	int i;
> >  
> >  	if (device_may_wakeup(dev)) {
> > -		for (i = 0; i < pdata->nbuttons; i++) {
> > -			struct gpio_keys_button *button =
> > &pdata->buttons[i];
> > +		for (i = 0; i < ddata->n_buttons; i++) {
> > +			struct gpio_keys_button *button =
> > ddata->data[i].button; if (button->wakeup) {
> >  				int irq = gpio_to_irq(button->gpio);
> >  				enable_irq_wake(irq);
> > @@ -594,12 +719,11 @@ static int gpio_keys_suspend(struct device *dev)
> >  static int gpio_keys_resume(struct device *dev)
> >  {
> >  	struct gpio_keys_drvdata *ddata = dev_get_drvdata(dev);
> > -	struct gpio_keys_platform_data *pdata = dev->platform_data;
> >  	int i;
> >  
> > -	for (i = 0; i < pdata->nbuttons; i++) {
> > +	for (i = 0; i < ddata->n_buttons; i++) {
> >  
> > -		struct gpio_keys_button *button = &pdata->buttons[i];
> > +		struct gpio_keys_button *button = ddata->data[i].button;
> >  		if (button->wakeup && device_may_wakeup(dev)) {
> >  			int irq = gpio_to_irq(button->gpio);
> >  			disable_irq_wake(irq);
> > @@ -618,6 +742,8 @@ static const struct dev_pm_ops gpio_keys_pm_ops = {
> >  };
> >  #endif
> >  
> > +MODULE_DEVICE_TABLE(of, gpio_keys_of_match);
> > +
> 
> Modules device table needs to be #ifdef CONFIG_OF protected.
> Otherwise the driver advertises behaviour that it cannot provide.

Ah, ok. Will add an #ifdef. Thanks for pointing out.

Best regards,

-- 
David Jander
Protonic Holland.
