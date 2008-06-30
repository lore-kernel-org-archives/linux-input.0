From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] [V2] powerpc: Xilinx: PS2: Added new XPS PS2 driver
Date: Mon, 30 Jun 2008 14:21:12 -0400
Message-ID: <20080630141552.ZZRA012@mailhub.coreip.homeip.net>
References: <20080630153824.ED3D319B0075@mail96-wa4.bigfish.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:17062 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117AbYF3SVR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Jun 2008 14:21:17 -0400
Received: by yx-out-2324.google.com with SMTP id 8so17200yxm.1
        for <linux-input@vger.kernel.org>; Mon, 30 Jun 2008 11:21:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080630153824.ED3D319B0075@mail96-wa4.bigfish.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: John Linn <john.linn@xilinx.com>
Cc: linuxppc-dev@ozlabs.org, linux-input@vger.kernel.org, Sadanand <sadanan@xilinx.com>

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
> +	if (!request_mem_region(regs_res->start, remap_size, DRIVER_NAME)) {
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
> +		drvdata->phys_addr, (u32)drvdata->base_address, drvdata->irq);
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
