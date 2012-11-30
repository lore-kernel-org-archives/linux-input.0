From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RFC v2] input: Add new driver for GPIO beeper
Date: Fri, 30 Nov 2012 08:44:35 -0800
Message-ID: <20121130164435.GA28721@core.coreip.homeip.net>
References: <1354210139-25374-1-git-send-email-shc_work@mail.ru>
 <20121130062815.GA27232@core.coreip.homeip.net>
 <1354270680.610219472@f26.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58385 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602Ab2K3Qov (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Nov 2012 11:44:51 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so549853pbc.19
        for <linux-input@vger.kernel.org>; Fri, 30 Nov 2012 08:44:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1354270680.610219472@f26.mail.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-input@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

Hi Alexander,

On Fri, Nov 30, 2012 at 02:18:00PM +0400, Alexander Shiyan wrote:
> > On Thu, Nov 29, 2012 at 09:28:59PM +0400, Alexander Shiyan wrote:
> > > This patch adds a new driver for the beeper controlled via GPIO pin.
> > > The driver does not depend on the architecture and is positioned as
> > > a replacement for the specific drivers that are used for this function,
> > > for example drivers/input/misc/ixp4xx-beeper.
> > > Since this patch is RFC only, inline comments are welcome.
> ...
> > > +static int gpio_beeper_event(struct input_dev *dev, unsigned int type,
> > > +			     unsigned int code, int value)
> > > +{
> > > +	struct gpio_beeper_priv *s = input_get_drvdata(dev);
> > > +
> > > +	if ((type != EV_SND) || (code != SND_BELL))
> > > +		return -ENOTSUPP;
> > > +
> > > +	if (value < 0)
> > > +		return -EINVAL;
> > > +
> > > +	if (!value)
> > > +		value = 1000;
> > > +
> > > +	/* Turning beeper ON */
> > > +	gpio_beeper_change(s, 1);
> > 
> > You are running under spinlock, you can't touch GPIO here using
> > "cansleep" operations.
> > 
> > > +	/* Schedule work for turning OFF */
> > > +	mod_delayed_work(system_wq, &s->work, msecs_to_jiffies(value));
> > > +
> > 
> > This is incorrect. The "value" here is pitch, not the duration of sound.
> > The callers are responsible to shut off the sound. The difference
> > between SND_BELL and SND_TONE is that latter allows controlling pitch
> > while the former uses driver- and platform-specific pitch.
> As it turned out, I understand the purpose of the parameter is incorrect.
> My mistake.
> 
> > I think the driver should look like in the patch below. Can you please
> > tell me if it works for you?
> Works. The test was on ARM CLPS711X board with the driver is compiled
> into the kernel, ie without modules. Non-critical comments inlined.
> 

Excellent, thank you.

> 
> > Input: Add new driver for GPIO beeper
> > 
> > From: Alexander Shiyan <shc_work@mail.ru>
> > 
> > This patch adds a new driver for the beeper controlled via GPIO pin.
> > The driver does not depend on the architecture and is positioned as
> > a replacement for the specific drivers that are used for this function,
> > for example drivers/input/misc/ixp4xx-beeper.
> > Since this patch is RFC only, inline comments are welcome.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/input/misc/Kconfig                      |    9 +
> >  drivers/input/misc/Makefile                     |    1 
> >  drivers/input/misc/gpio-beeper.c                |  154 +++++++++++++++++++++++
> >  include/linux/platform_data/input-gpio-beeper.h |   20 +++
> 
> > +static int gpio_beeper_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	const struct gpio_beeper_pdata *pdata = dev_get_platdata(dev);
> > +	struct gpio_beeper *beeper;
> > +	struct input_dev *input;
> > +	int error;
> > +
> > +	if (!pdata) {
> > +		dev_err(dev, "Missing platform data\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (!gpio_is_valid(pdata->gpio_nr)) {
> > +		dev_err(dev, "Invalid gpio %i\n", pdata->gpio_nr);
> > +		return -EINVAL;
> > +	}
> > +
> > +	beeper = devm_kzalloc(&pdev->dev, sizeof(struct gpio_beeper),
> > +				GFP_KERNEL);
> I would prefer to do when moving padding on brackets.

I am not sure what you were trying to say here... Are you saying
GFP_KERNEL should be aligned with opening parenthesis?

> 
> > +	if (!beeper) {
> > +		dev_err(dev, "Memory allocate error\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	beeper->gpio_nr = pdata->gpio_nr;
> > +	beeper->active_low = pdata->active_low;
> > +
> > +	INIT_WORK(&beeper->work, gpio_beeper_work);
> > +	snprintf(beeper->phys, sizeof(beeper->phys),
> > +		 "%s/input0", dev_name(dev));
> > +
> > +	input = devm_input_allocate_device(dev);
> I am temporaty replace this function to input_allocate_device() because
> I am tested this driver on 2.6.8.

Surely not 2.6? Anyway for devm_input_allocate_device() support you need
the following commit from my 'next' branch in
git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git

commit 2be975c6d920de989ff5e4bc09ffe87e59d94662
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Sat Nov 3 12:16:12 2012 -0700

    Input: introduce managed input devices (add devres support)

> 
> > +	if (!input) {
> > +		dev_err(&pdev->dev, "Input device allocate error\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	input->name		= pdata->name ?: "GPIO Beeper";
> > +	input->phys		= beeper->phys;
> > +	input->id.bustype	= BUS_HOST;
> > +	input->id.vendor	= 0x0001;
> > +	input->id.product	= 0x0001;
> > +	input->id.version	= 0x0100;
> > +
> IMHO, no empty line needed here.
> 
> > +	input->close		= gpio_beeper_close;
> > +	input->event		= gpio_beeper_event;
> ...
> > +
> > +	input_set_capability(input, EV_SND, SND_BELL);
> > +
> > +	error = devm_gpio_request(dev, beeper->gpio_nr, input->name);
> > +	if (error) {
> > +		dev_err(dev, "Unable to claim gpio %i\n", beeper->gpio_nr);
> > +		return error;
> > +	}
> > +
> > +	gpio_direction_output(beeper->gpio_nr, beeper->active_low);
> > +
> > +	beeper->input = input;
> > +	input_set_drvdata(input, beeper);
> > +	platform_set_drvdata(pdev, beeper);
> > +
> > +	return input_register_device(beeper->input);
> > +}
> > +
> > +static void gpio_beeper_shutdown(struct platform_device *pdev)
> > +{
> > +	struct gpio_beeper *beeper = platform_get_drvdata(pdev);
> > +
> > +	/* Turning OFF immediately */
> > +	gpio_beeper_close(beeper->input);
> > +}
> > +
> > +static struct platform_driver gpio_beeper_platform_driver = {
> > +	.driver	= {
> > +		.name	= "gpio-beeper",
> > +		.owner	= THIS_MODULE,
> > +	},
> > +	.probe		= gpio_beeper_probe,
> > +	.shutdown	= gpio_beeper_shutdown,
> > +};
> > +module_platform_driver(gpio_beeper_platform_driver);
> No "remove" function?

With all resources being devm_* managed (and shuttign off beeper
happening in gpio_keys_close()) the remove function would be just an
empty stub. As far as I can see platform devices not have to have a
remove function, but testing this by unloading the driver or unbinding
it via sysfs would be nice.

Thanks.

-- 
Dmitry
