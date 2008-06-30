From: John Linn <John.Linn@xilinx.com>
Subject: RE: [PATCH] [V2] powerpc: Xilinx: PS2: Added new XPS PS2 driver
Date: Mon, 30 Jun 2008 15:28:26 -0600
Message-ID: <20080630212827.DBE0E5E0076@mail105-va3.bigfish.com>
References: <20080630153824.ED3D319B0075@mail96-wa4.bigfish.com> <20080630141552.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from outbound-va3.frontbridge.com ([216.32.180.16]:41395 "EHLO
	VA3EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757000AbYF3V2b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Jun 2008 17:28:31 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <20080630141552.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linuxppc-dev@ozlabs.org, linux-input@vger.kernel.org, Sadanand Mutyala <sadanan@xilinx.com>

Thanks Dmitry, see my comments inline.

-- John

>On Mon, Jun 30, 2008 at 08:38:21AM -0700, John Linn wrote:
>> +	spin_lock_init(&drvdata->lock);
>> +	dev_set_drvdata(dev, (void *)drvdata);
>
>No need to cast to void *.

OK.

>
>> +
>> +	if (!regs_res || !irq_res) {
>> +		dev_err(dev, "IO resource(s) not found\n");
>> +		retval = -EFAULT;
>> +		goto failed1;
>> +	}
>> +
>> +	drvdata->irq = irq_res->start;
>> +	remap_size = regs_res->end - regs_res->start + 1;
>> +	if (!request_mem_region(regs_res->start, remap_size,
DRIVER_NAME)) {
>> +
>> +		dev_err(dev, "Couldn't lock memory region at 0x%08X\n",
>> +			(unsigned int)regs_res->start);
>> +		retval = -EBUSY;
>> +		goto failed1;
>> +	}
>> +
>> +	/* Fill in configuration data and add them to the list */
>> +	drvdata->phys_addr = regs_res->start;
>> +	drvdata->remap_size = remap_size;
>> +	drvdata->base_address = ioremap(regs_res->start, remap_size);
>> +	if (drvdata->base_address == NULL) {
>> +
>> +		dev_err(dev, "Couldn't ioremap memory at 0x%08X\n",
>> +			(unsigned int)regs_res->start);
>> +		retval = -EFAULT;
>> +		goto failed2;
>> +	}
>> +
>> +	/* Initialize the PS/2 interface */
>> +	down(&cfg_sem);
>> +	if (xps2_initialize(drvdata)) {
>> +		up(&cfg_sem);
>> +		dev_err(dev, "Could not initialize device\n");
>> +		retval = -ENODEV;
>> +		goto failed3;
>> +	}
>> +	up(&cfg_sem);
>
>Do you need a counting semaphore here?
>

Seems like a simpler kind of mutal exclusion would do the job, like a
spinlock.
Looks like mutual exclusion is needed as the device contains 2 ps2
controllers.

>> +
>> +	dev_info(dev, "Xilinx PS2 at 0x%08X mapped to 0x%08X, irq=%d\n",
>> +		drvdata->phys_addr, (u32)drvdata->base_address,
drvdata->irq);
>> +
>> +	drvdata->serio.id.type = SERIO_8042;
>> +	drvdata->serio.write = sxps2_write;
>> +	drvdata->serio.open = sxps2_open;
>> +	drvdata->serio.close = sxps2_close;
>> +	drvdata->serio.port_data = drvdata;
>> +	drvdata->serio.dev.parent = dev;
>> +	snprintf(drvdata->serio.name, sizeof(drvdata->serio.name),
>> +		 XPS2_NAME_DESC, id);
>> +	snprintf(drvdata->serio.phys, sizeof(drvdata->serio.phys),
>> +		 XPS2_PHYS_DESC, id);
>
>I bet if you make a temp variable for drvdata->serio the code size wil
>shrink a tiny bit.

Ok, not sure the complexity of the temp is worth the tiny code
shrinkage.
I would think the compiler should optimize it as well but your
experience
must say otherwise.

>
>-- 
>Dmitry
>

-----Original Message-----
From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com] 
Sent: Monday, June 30, 2008 12:21 PM
To: John Linn
Cc: linuxppc-dev@ozlabs.org; linux-input@vger.kernel.org; Sadanand
Mutyala
Subject: Re: [PATCH] [V2] powerpc: Xilinx: PS2: Added new XPS PS2 driver

On Mon, Jun 30, 2008 at 08:38:21AM -0700, John Linn wrote:
> +	spin_lock_init(&drvdata->lock);
> +	dev_set_drvdata(dev, (void *)drvdata);

No need to cast to void *.

> +
> +	if (!regs_res || !irq_res) {
> +		dev_err(dev, "IO resource(s) not found\n");
> +		retval = -EFAULT;
> +		goto failed1;
> +	}
> +
> +	drvdata->irq = irq_res->start;
> +	remap_size = regs_res->end - regs_res->start + 1;
> +	if (!request_mem_region(regs_res->start, remap_size,
DRIVER_NAME)) {
> +
> +		dev_err(dev, "Couldn't lock memory region at 0x%08X\n",
> +			(unsigned int)regs_res->start);
> +		retval = -EBUSY;
> +		goto failed1;
> +	}
> +
> +	/* Fill in configuration data and add them to the list */
> +	drvdata->phys_addr = regs_res->start;
> +	drvdata->remap_size = remap_size;
> +	drvdata->base_address = ioremap(regs_res->start, remap_size);
> +	if (drvdata->base_address == NULL) {
> +
> +		dev_err(dev, "Couldn't ioremap memory at 0x%08X\n",
> +			(unsigned int)regs_res->start);
> +		retval = -EFAULT;
> +		goto failed2;
> +	}
> +
> +	/* Initialize the PS/2 interface */
> +	down(&cfg_sem);
> +	if (xps2_initialize(drvdata)) {
> +		up(&cfg_sem);
> +		dev_err(dev, "Could not initialize device\n");
> +		retval = -ENODEV;
> +		goto failed3;
> +	}
> +	up(&cfg_sem);

Do you need a counting semaphore here?

> +
> +	dev_info(dev, "Xilinx PS2 at 0x%08X mapped to 0x%08X, irq=%d\n",
> +		drvdata->phys_addr, (u32)drvdata->base_address,
drvdata->irq);
> +
> +	drvdata->serio.id.type = SERIO_8042;
> +	drvdata->serio.write = sxps2_write;
> +	drvdata->serio.open = sxps2_open;
> +	drvdata->serio.close = sxps2_close;
> +	drvdata->serio.port_data = drvdata;
> +	drvdata->serio.dev.parent = dev;
> +	snprintf(drvdata->serio.name, sizeof(drvdata->serio.name),
> +		 XPS2_NAME_DESC, id);
> +	snprintf(drvdata->serio.phys, sizeof(drvdata->serio.phys),
> +		 XPS2_PHYS_DESC, id);

I bet if you make a temp variable for drvdata->serio the code size wil
shrink a tiny bit.

-- 
Dmitry


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.


