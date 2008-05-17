From: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [PATCH] Add support for HTC Shift Touchscreen
Date: Sat, 17 May 2008 16:02:15 +0300
Message-ID: <84144f020805170602lc43b2f3g5088ef601481a926@mail.gmail.com>
References: <482ED31E.2000009@eslack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.224]:52429 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755634AbYEQNCQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 17 May 2008 09:02:16 -0400
Received: by rv-out-0506.google.com with SMTP id l9so614760rvb.1
        for <linux-input@vger.kernel.org>; Sat, 17 May 2008 06:02:15 -0700 (PDT)
In-Reply-To: <482ED31E.2000009@eslack.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pau Oliva Fora <pau@eslack.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Pau,

On Sat, May 17, 2008 at 3:44 PM, Pau Oliva Fora <pau@eslack.org> wrote:
> @@ -0,0 +1,148 @@
> +/*
> + * HTC Shift touchscreen driver
> + *
> + * Copyright (C) 2008 Pau Oliva Fora <pof@eslack.org>
> + *
> + * Thanks to:
> + *     Heikki Linnakangas - Penmount LPC touchscreen driver
> + *     Wacom / Ping Cheng - Help on linuxwacom-devel
> + *     Esteve Espuna      - Ideas, tips, moral support :)
> + *
> + * Changelog:
> + *   29980517 v0.5 - code cleanup
> + *   29980517 v0.4 - initialization works (thanks esteve!)
> + *   20080514 v0.3 - works best with TouchKit egalax xorg driver
> + *   20080511 v0.2 - little hacks to make it more usable
> + *   20080510 v0.1 - works with evtouch driver
> + *   20080428 first non-working attempt

Please drop the changelog from your source file.

> +#define DRIVER_VERSION         "v0.5"
> +#define DRIVER_DESC    "HTC Shift touchscreen driver"
> +
> +MODULE_AUTHOR("Pau Oliva Fora <pau@eslack.org>");
> +MODULE_DESCRIPTION(DRIVER_DESC);
> +MODULE_LICENSE("GPL");
> +
> +#define HTCPEN_PORT0 0x068
> +#define HTCPEN_PORT1 0x06c
> +#define HTCPEN_PORT2 0x0250
> +#define HTCPEN_PORT3 0x0251
> +#define HTCPEN_IRQ 3
> +
> +static int inverse_y;
> +module_param(inverse_y, bool, 0644);
> +MODULE_PARM_DESC(inverse_y, "If set Y axe is inversed.");
> +
> +struct input_dev *htcpen_dev;

Why are you not using isa_register_driver() instead?

> +
> +static void poll_htcpen(void)
> +{
> +

Extra newline.

> +       unsigned short x, y, xy;
> +       unsigned short touch;
> +static int __init htcpen_init(void)
> +{
> +

Extra newline.

> +       printk(KERN_INFO "htcpen: module inserted\n");
> +
> +       inb_p(HTCPEN_PORT0);

So there's no way to probe the existence of this device?

> +
> +       htcpen_dev = input_allocate_device();
> +       if (!htcpen_dev) {
> +               printk(KERN_ERR "htcpen: can't allocate device\n");
> +               return -ENOMEM;
> +       }
> +
> +       if (request_irq(HTCPEN_IRQ, htcpen_interrupt, 0, "htcpen", NULL)) {

This is leaking htcpen_dev here. Look at some other drivers for
examples how to use gotos for this kind of error handling.

> +               printk(KERN_ERR "htcpen: irq busy\n");
> +               return -EBUSY;
> +       }
> +
