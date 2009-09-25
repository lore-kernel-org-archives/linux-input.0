From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Subject: Re: [PATCH 1/3] Input: DaVinci Key Scan Driver
Date: Fri, 25 Sep 2009 08:19:37 -0600
Message-ID: <4ABCD179.9010007@ridgerun.com>
References: <1253811202-21407-1-git-send-email-miguel.aguilar@ridgerun.com> <20090925040127.GA416@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.navvo.net ([74.208.67.6]:58799 "EHLO mail.navvo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752750AbZIYOTk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Sep 2009 10:19:40 -0400
In-Reply-To: <20090925040127.GA416@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: nsnehaprabha@ti.com, davinci-linux-open-source@linux.davincidsp.com, linux-input@vger.kernel.org, todd.fischer@ridgerun.com, diego.dompe@ridgerun.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com

Dmitry Torokhov wrote:
> On Thu, Sep 24, 2009 at 10:53:22AM -0600, miguel.aguilar@ridgerun.com wrote:
>>  
>> +config KEYBOARD_DAVINCI
>> +	tristate "TI DaVinci Key Scan"
>> +	depends on ARCH_DAVINCI_DM365
>> +	help
>> +	  Say Y to enable keypad module support for the TI DaVinci
>> +	  platforms (DM365).
> 
> Missing period.
[MA] Ok
> 
>> +	  
>> +	  To compile this driver as a module, choose M here: the
>> +	  module will be called davinci_keyscan.
>> +
>> +
>> +static int __init davinci_ks_probe(struct platform_device *pdev)
>> +{
>> +	struct davinci_ks *davinci_ks;
>> +	struct input_dev *key_dev;
>> +	struct resource *res, *mem;
>> +	struct device * dev = &pdev->dev;
>> +	struct davinci_ks_platform_data *pdata = pdev->dev.platform_data;
>> +	int ret, i;
>> +
>> +	dev_info(dev, "DaVinci Key Scan Driver\n");
> 
> The boot is already quite noisy and input core will emit message when
> device is registered so this one is not needed.
[MA] OK.
> 
>> +
>> +	davinci_ks = kzalloc(sizeof(struct davinci_ks) +
>> +		sizeof(unsigned short) * pdata->keymapsize, GFP_KERNEL);
>> +	if(!davinci_ks) {
>> +		dev_dbg(dev, "could not allocate memory for private data\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	if (!pdata->keymap) {
>> +		dev_dbg(dev, "no keymap from pdata\n");
> 
> You are leaking davinci_ks here. Maybe you should check pdata->keymap
> first.
[MA] Do you mean check pdata->keymap before davinci_ks allocation?
> 
>> +		return -EINVAL;
>> +	}
>> +
>> +	memcpy(davinci_ks->keymap, pdata->keymap,
>> +		    sizeof(unsigned short) * pdata->keymapsize);
>> +
>> +	key_dev = input_allocate_device();
>> +	if (!key_dev) {
>> +		dev_dbg(dev, "could not allocate input device\n");
>> +		ret = -ENOMEM;
>> +		goto fail1;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, davinci_ks);
>> +
>> +	davinci_ks->input = key_dev;
>> +
>> +	davinci_ks->irq = platform_get_irq(pdev, 0);
>> +	if (davinci_ks->irq < 0) {
>> +		dev_err(dev, "no key scan irq\n");
>> +		ret = davinci_ks->irq;
>> +		goto fail2;
>> +	}
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res) {
>> +		dev_err(dev, "no mem resource\n");
>> +		ret = -EINVAL;
>> +		goto fail2;
>> +	}
>> +
>> +	davinci_ks->pbase = res->start;
>> +	davinci_ks->base_size = resource_size(res);
>> +
>> +	mem = request_mem_region(davinci_ks->pbase, davinci_ks->base_size, pdev->name);
>> +	if (!mem) {
>> +		dev_err(dev, "key scan registers at %08x are not free\n",
>> +			davinci_ks->pbase);
>> +		ret = -EBUSY;
>> +		goto fail2;
>> +	}
>> +
>> +	davinci_ks->base = ioremap(davinci_ks->pbase, davinci_ks->base_size);
>> +	if (!davinci_ks->base) {
>> +		dev_err(dev, "can't ioremap MEM resource.\n");
>> +		ret = -ENOMEM;
>> +		goto fail3;
>> +	}
>> +
>> +	/* Enable auto repeat feature of Linux input subsystem */
>> +	if (pdata->rep)
>> +		__set_bit(EV_REP, key_dev->evbit);
>> +
>> +	/* Setup input device */
>> +	__set_bit(EV_KEY, key_dev->evbit);
>> +
>> +	/* Setup the platform data */
>> +	davinci_ks->pdata = pdata;
>> +
>> +	for (i = 0; i < davinci_ks->pdata->keymapsize; i++)
>> +		__set_bit(davinci_ks->pdata->keymap[i], key_dev->keybit);
>> +
>> +	key_dev->name = "davinci_keyscan";
>> +	key_dev->phys = "davinci_keyscan/input0";
>> +	key_dev->dev.parent = &pdev->dev;
>> +	key_dev->id.bustype = BUS_HOST;
>> +	key_dev->id.vendor = 0x0001;
>> +	key_dev->id.product = 0x0001;
>> +	key_dev->id.version = 0x0001;
>> +	key_dev->keycode = davinci_ks->keymap;
>> +	key_dev->keycodesize = sizeof(davinci_ks->keymap[0]);
>> +	key_dev->keycodemax = davinci_ks->pdata->keymapsize;
>> +
>> +	ret = input_register_device(davinci_ks->input);
>> +	if (ret < 0) {
>> +		dev_err(dev, "unable to register DaVinci keyscan device\n");
>> +		goto fail4;
>> +	}
>> +
>> +	ret = request_irq(davinci_ks->irq, davinci_ks_interrupt, IRQF_DISABLED,
>> +                         "davinci_keyscan", davinci_ks);
>> +	if (ret < 0) {
>> +		dev_err(dev, "unable to register DaVinci keyscan Interrupt\n");
>> +		goto fail5;
>> +	}
> 
> FWIW you may request IRQ before registering the device - as soon as it
> is alloctaed it can survive events going through it.
[MA] Ok. request_irq before input_register_device.
> 

Thanks,

Miguel Aguilar

