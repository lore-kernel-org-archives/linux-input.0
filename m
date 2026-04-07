Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E6A35F8D1;
	Tue,  7 Apr 2026 19:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775591500; cv=none; b=Tcmr4VA41jfcM6Oi2Z/FoXsq0jfjOLqyWnRQR9VFk5fMBE5SoQcSRWwxQoYP23hlht2qzbYXMyqqUEPnQm19uahNYZzqvyvgCmyiT10dca7r2T6rqcITo3ClPetZsUalbNGRSQbleBtecKVY9Z6rcafSnk/EWpIrZL+LyBbl4tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775591500; c=relaxed/simple;
	bh=wkJaa1V5imfoX3g+eLH6u6RILerj7s1gC85sLBO5f70=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=poBAEX1wP8XLAJm4ZS8dC+jtQBeezuNR8gQK4XEFi1aMzlih1RMP0CSbUBJXudGon88dhKh8V9FC7xORDCNJQF58reg5tg9BrAqZKPW4StkuruXEACef0gnojx7FmNIXnSLGmzMHqgtJ86NMzOmC7lvYyMdAUqja8znWQDulnm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACoNBpPy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACoNBpPy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C261C116C6;
	Tue,  7 Apr 2026 19:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775591499;
	bh=wkJaa1V5imfoX3g+eLH6u6RILerj7s1gC85sLBO5f70=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ACoNBpPyg4GhTe7JZgsiCgbXjp0BmfyIeEhRtUpBZCTlP7FiGIHi6P7XZrHS4bqiz
	 hVd91KzLvNFk/qSjRGxAemkE+Afo1nQMkMKc68QGgk9x6pKf9jYdMje+P0yAYq4QGG
	 xsQUL/z2ADclvh1NQZOVBygfUYr27ogh6uyKQGDyH2C/ocNAS79+TBJQ193Ex1sqLP
	 zRkOh1Yd8nZj4vb3MP31OCwRV45CBifFTplEYCGOhx3Ouv+XOy0QhDue13YViZSHxZ
	 U9KgML9coqTtH+lM4W8DSuUi0dm84cMLm8GEHAkNU4MVYho92Dd/9Z1uOhEuoPOO6H
	 qJdauKh0STq0w==
Date: Tue, 7 Apr 2026 14:51:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vojtech Pavlik <vojtech@ucw.cz>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [RFC PATCH 3/5] Input: pc110pad - remove driver
Message-ID: <20260407195138.GA251078@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808172733.1194442-4-dmitry.torokhov@gmail.com>

[+cc Maciej]

On Thu, Aug 08, 2024 at 10:27:29AM -0700, Dmitry Torokhov wrote:
> Palm Top PC 110 is a handheld personal computer with 80486SX CPU that
> was released exclusively in Japan in September 1995.
> 
> While the kernel still supports 486 CPU it is highly unlikely that
> anyone is using this device with the latest kernel.
> 
> Remove the driver.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I applied this patch only to remove pc110pad to pci/enumeration for
v7.1, since "x86/cpu: Remove M486/M486SX/ELAN support" has been queued
for v7.1:
https://lore.kernel.org/all/20251214084710.3606385-2-mingo@kernel.org/

I put this in the PCI tree because pc110pad was the only user of
no_pci_devices(), which we can now remove as well.

> ---
>  drivers/input/mouse/Kconfig    |  10 ---
>  drivers/input/mouse/Makefile   |   1 -
>  drivers/input/mouse/pc110pad.c | 160 ---------------------------------
>  3 files changed, 171 deletions(-)
>  delete mode 100644 drivers/input/mouse/pc110pad.c
> 
> diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
> index f660e6ba24c2..7b7053c57588 100644
> --- a/drivers/input/mouse/Kconfig
> +++ b/drivers/input/mouse/Kconfig
> @@ -312,16 +312,6 @@ config MOUSE_ELAN_I2C_SMBUS
>  
>  	   If unsure, say Y.
>  
> -config MOUSE_PC110PAD
> -	tristate "IBM PC110 touchpad"
> -	depends on ISA
> -	help
> -	  Say Y if you have the IBM PC-110 micro-notebook and want its
> -	  touchpad supported.
> -
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called pc110pad.
> -
>  config MOUSE_AMIGA
>  	tristate "Amiga mouse"
>  	depends on AMIGA
> diff --git a/drivers/input/mouse/Makefile b/drivers/input/mouse/Makefile
> index e745b64fed49..4f9fb7d87a37 100644
> --- a/drivers/input/mouse/Makefile
> +++ b/drivers/input/mouse/Makefile
> @@ -13,7 +13,6 @@ obj-$(CONFIG_MOUSE_CYAPA)		+= cyapatp.o
>  obj-$(CONFIG_MOUSE_ELAN_I2C)		+= elan_i2c.o
>  obj-$(CONFIG_MOUSE_GPIO)		+= gpio_mouse.o
>  obj-$(CONFIG_MOUSE_MAPLE)		+= maplemouse.o
> -obj-$(CONFIG_MOUSE_PC110PAD)		+= pc110pad.o
>  obj-$(CONFIG_MOUSE_PS2)			+= psmouse.o
>  obj-$(CONFIG_MOUSE_RISCPC)		+= rpcmouse.o
>  obj-$(CONFIG_MOUSE_SERIAL)		+= sermouse.o
> diff --git a/drivers/input/mouse/pc110pad.c b/drivers/input/mouse/pc110pad.c
> deleted file mode 100644
> index efa58049f746..000000000000
> --- a/drivers/input/mouse/pc110pad.c
> +++ /dev/null
> @@ -1,160 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - *  Copyright (c) 2000-2001 Vojtech Pavlik
> - *
> - *  Based on the work of:
> - *	Alan Cox	Robin O'Leary
> - */
> -
> -/*
> - * IBM PC110 touchpad driver for Linux
> - */
> -
> -#include <linux/module.h>
> -#include <linux/kernel.h>
> -#include <linux/errno.h>
> -#include <linux/ioport.h>
> -#include <linux/input.h>
> -#include <linux/init.h>
> -#include <linux/interrupt.h>
> -#include <linux/pci.h>
> -#include <linux/delay.h>
> -
> -#include <asm/io.h>
> -#include <asm/irq.h>
> -
> -MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
> -MODULE_DESCRIPTION("IBM PC110 touchpad driver");
> -MODULE_LICENSE("GPL");
> -
> -#define PC110PAD_OFF	0x30
> -#define PC110PAD_ON	0x38
> -
> -static int pc110pad_irq = 10;
> -static int pc110pad_io = 0x15e0;
> -
> -static struct input_dev *pc110pad_dev;
> -static int pc110pad_data[3];
> -static int pc110pad_count;
> -
> -static irqreturn_t pc110pad_interrupt(int irq, void *ptr)
> -{
> -	int value     = inb_p(pc110pad_io);
> -	int handshake = inb_p(pc110pad_io + 2);
> -
> -	outb(handshake |  1, pc110pad_io + 2);
> -	udelay(2);
> -	outb(handshake & ~1, pc110pad_io + 2);
> -	udelay(2);
> -	inb_p(0x64);
> -
> -	pc110pad_data[pc110pad_count++] = value;
> -
> -	if (pc110pad_count < 3)
> -		return IRQ_HANDLED;
> -
> -	input_report_key(pc110pad_dev, BTN_TOUCH,
> -		pc110pad_data[0] & 0x01);
> -	input_report_abs(pc110pad_dev, ABS_X,
> -		pc110pad_data[1] | ((pc110pad_data[0] << 3) & 0x80) | ((pc110pad_data[0] << 1) & 0x100));
> -	input_report_abs(pc110pad_dev, ABS_Y,
> -		pc110pad_data[2] | ((pc110pad_data[0] << 4) & 0x80));
> -	input_sync(pc110pad_dev);
> -
> -	pc110pad_count = 0;
> -	return IRQ_HANDLED;
> -}
> -
> -static void pc110pad_close(struct input_dev *dev)
> -{
> -	outb(PC110PAD_OFF, pc110pad_io + 2);
> -}
> -
> -static int pc110pad_open(struct input_dev *dev)
> -{
> -	pc110pad_interrupt(0, NULL);
> -	pc110pad_interrupt(0, NULL);
> -	pc110pad_interrupt(0, NULL);
> -	outb(PC110PAD_ON, pc110pad_io + 2);
> -	pc110pad_count = 0;
> -
> -	return 0;
> -}
> -
> -/*
> - * We try to avoid enabling the hardware if it's not
> - * there, but we don't know how to test. But we do know
> - * that the PC110 is not a PCI system. So if we find any
> - * PCI devices in the machine, we don't have a PC110.
> - */
> -static int __init pc110pad_init(void)
> -{
> -	int err;
> -
> -	if (!no_pci_devices())
> -		return -ENODEV;
> -
> -	if (!request_region(pc110pad_io, 4, "pc110pad")) {
> -		printk(KERN_ERR "pc110pad: I/O area %#x-%#x in use.\n",
> -				pc110pad_io, pc110pad_io + 4);
> -		return -EBUSY;
> -	}
> -
> -	outb(PC110PAD_OFF, pc110pad_io + 2);
> -
> -	if (request_irq(pc110pad_irq, pc110pad_interrupt, 0, "pc110pad", NULL)) {
> -		printk(KERN_ERR "pc110pad: Unable to get irq %d.\n", pc110pad_irq);
> -		err = -EBUSY;
> -		goto err_release_region;
> -	}
> -
> -	pc110pad_dev = input_allocate_device();
> -	if (!pc110pad_dev) {
> -		printk(KERN_ERR "pc110pad: Not enough memory.\n");
> -		err = -ENOMEM;
> -		goto err_free_irq;
> -	}
> -
> -	pc110pad_dev->name = "IBM PC110 TouchPad";
> -	pc110pad_dev->phys = "isa15e0/input0";
> -	pc110pad_dev->id.bustype = BUS_ISA;
> -	pc110pad_dev->id.vendor = 0x0003;
> -	pc110pad_dev->id.product = 0x0001;
> -	pc110pad_dev->id.version = 0x0100;
> -
> -	pc110pad_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
> -	pc110pad_dev->absbit[0] = BIT_MASK(ABS_X) | BIT_MASK(ABS_Y);
> -	pc110pad_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
> -
> -	input_abs_set_max(pc110pad_dev, ABS_X, 0x1ff);
> -	input_abs_set_max(pc110pad_dev, ABS_Y, 0x0ff);
> -
> -	pc110pad_dev->open = pc110pad_open;
> -	pc110pad_dev->close = pc110pad_close;
> -
> -	err = input_register_device(pc110pad_dev);
> -	if (err)
> -		goto err_free_dev;
> -
> -	return 0;
> -
> - err_free_dev:
> -	input_free_device(pc110pad_dev);
> - err_free_irq:
> -	free_irq(pc110pad_irq, NULL);
> - err_release_region:
> -	release_region(pc110pad_io, 4);
> -
> -	return err;
> -}
> -
> -static void __exit pc110pad_exit(void)
> -{
> -	outb(PC110PAD_OFF, pc110pad_io + 2);
> -	free_irq(pc110pad_irq, NULL);
> -	input_unregister_device(pc110pad_dev);
> -	release_region(pc110pad_io, 4);
> -}
> -
> -module_init(pc110pad_init);
> -module_exit(pc110pad_exit);
> -- 
> 2.46.0.76.ge559c4bf1a-goog
> 
