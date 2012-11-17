From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH 04/06] input/rmi4: Config files and makefiles
Date: Sat, 17 Nov 2012 23:50:36 +0100
Message-ID: <CACRpkdZ_dAPT6swXqEHor=ka64YPd_7-bZQHGjTAsEeEsvzJWg@mail.gmail.com>
References: <1353124734-16803-1-git-send-email-cheiny@synaptics.com>
	<1353124734-16803-5-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:52734 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274Ab2KQWuh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 17 Nov 2012 17:50:37 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so493432eek.19
        for <linux-input@vger.kernel.org>; Sat, 17 Nov 2012 14:50:36 -0800 (PST)
In-Reply-To: <1353124734-16803-5-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jean Delvare <khali@linux-fr.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Allie Xiong <axiong@synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Alexandra Chin <alexandra.chin@tw.synaptics.com>, Joerie de Gram <j.de.gram@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>, Mathieu Poirier <mathieu.poirier@linaro.org>, Linus Walleij <linus.walleij@stericsson.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>

On Sat, Nov 17, 2012 at 4:58 AM, Christopher Heiny <cheiny@synaptics.com> wrote:

> Infrastructure files for configuration and building.
>
>
> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
>

Cut blank line.

> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Linus Walleij <linus.walleij@stericsson.com>
> Cc: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
> Cc: Joeri de Gram <j.de.gram@gmail.com>

(...)
> +++ b/drivers/input/rmi4/Makefile
> @@ -0,0 +1,22 @@
> +obj-$(CONFIG_RMI4_BUS) += rmi_bus.o
> +obj-$(CONFIG_RMI4_I2C) += rmi_i2c.o
> +obj-$(CONFIG_RMI4_GENERIC) += rmi_driver.o rmi_f01.o
> +obj-$(CONFIG_RMI4_F11) += rmi_f11.o
> +
> +ccflags-$(CONFIG_RMI4_DEBUG) += -DDEBUG
> +


>From here:

> +ifeq ($(KERNELRELEASE),)
> +
> +# KERNELDIR ?= /home/<AndroidKernelDirectory>
> +PWD := $(shell pwd)
> +
> +.PHONY: build clean
> +
> +build:
> +       $(MAKE) -C $(KERNELDIR) M=$(PWD) modules
> +
> +clean:
> +       rm -rf *.o *~ core .depend .*.cmd *.ko *.mod.c
> +
> +endif

This stuff looks weird. Like some local build rule to just rebuild
this part, and the commented-out Android thing is really just
cruft. Just delete all this, keep it in your private delta
if you need it.

Yours,
Linus Walleij
