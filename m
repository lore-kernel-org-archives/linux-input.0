From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCHv3] i8042 driver for unicore32 architecture
Date: Mon, 17 Jan 2011 21:05:22 -0800
Message-ID: <20110118050522.GC23851@core.coreip.homeip.net>
References: <012701cbb6cc$e2f32400$a8d96c00$@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44928 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811Ab1ARFF2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Jan 2011 00:05:28 -0500
Received: by iwn9 with SMTP id 9so5367326iwn.19
        for <linux-input@vger.kernel.org>; Mon, 17 Jan 2011 21:05:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <012701cbb6cc$e2f32400$a8d96c00$@mprc.pku.edu.cn>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>
Cc: linux-input@vger.kernel.org

On Tue, Jan 18, 2011 at 01:02:20PM +0800, Guan Xuetao wrote:
> This patch implements i8042 driver for unicore32 architecture.
> 
> Changes from V2:
>   Restore request_region and release_region for i8042 ports.
> 
> Changes from V1:
>   Move i8042-ucio.h to drivers/input/serio/i8042-unicore32io.h.
>   Move puv3_ps2_init() to arch/unicore32/kernel/puv3-core.c.
>   Remove unused comments.
>   Remove request_region and release_region for I8042_DATA_REG.
> 
> Signed-off-by: Guan Xuetao <gxt@mprc.pku.edu.cn>

Excellent, please feel free to merge with the rest of your arch when
such time comes.

Acked-by: Dmitry Torokhov <dtor@mail.ru>

> ---
>  drivers/input/serio/i8042-unicore32io.h |   70 +++++++++++++++++++++++++++++++
>  drivers/input/serio/i8042.h             |    2 +
>  2 files changed, 72 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/serio/i8042-unicore32io.h b/drivers/input/serio/i8042-unicore32io.h
> new file mode 100644
> index 0000000..6a7e8b3
> --- /dev/null
> +++ b/drivers/input/serio/i8042-unicore32io.h
> @@ -0,0 +1,70 @@
> +/*
> + * Code specific to PKUnity SoC and UniCore ISA
> + *
> + *	Maintained by GUAN Xue-tao <gxt@mprc.pku.edu.cn>
> + *	Copyright (C) 2001-2011 Guan Xuetao
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#ifndef _I8042_UNICORE32_H
> +#define _I8042_UNICORE32_H
> +
> +#include <mach/hardware.h>
> +
> +/*
> + * Names.
> + */
> +#define I8042_KBD_PHYS_DESC "isa0060/serio0"
> +#define I8042_AUX_PHYS_DESC "isa0060/serio1"
> +#define I8042_MUX_PHYS_DESC "isa0060/serio%d"
> +
> +/*
> + * IRQs.
> + */
> +#define I8042_KBD_IRQ           IRQ_PS2_KBD
> +#define I8042_AUX_IRQ           IRQ_PS2_AUX
> +
> +/*
> + * Register numbers.
> + */
> +#define I8042_COMMAND_REG	((unsigned long)&PS2_COMMAND)
> +#define I8042_STATUS_REG	((unsigned long)&PS2_STATUS)
> +#define I8042_DATA_REG		((unsigned long)&PS2_DATA)
> +
> +static inline int i8042_read_data(void)
> +{
> +	return inb(I8042_DATA_REG);
> +}
> +
> +static inline int i8042_read_status(void)
> +{
> +	return inb(I8042_STATUS_REG);
> +}
> +
> +static inline void i8042_write_data(int val)
> +{
> +	outb(val, I8042_DATA_REG);
> +}
> +
> +static inline void i8042_write_command(int val)
> +{
> +	outb(val, I8042_COMMAND_REG);
> +}
> +
> +static inline int i8042_platform_init(void)
> +{
> +	if (!request_region(I8042_DATA_REG, 16, "i8042"))
> +		return -EBUSY;
> +
> +	i8042_reset = 1;
> +	return 0;
> +}
> +
> +static inline void i8042_platform_exit(void)
> +{
> +	release_region(I8042_DATA_REG, 16);
> +}
> +
> +#endif /* _I8042_UNICORE32_H */
> diff --git a/drivers/input/serio/i8042.h b/drivers/input/serio/i8042.h
> index cbc1beb..e0fe4af 100644
> --- a/drivers/input/serio/i8042.h
> +++ b/drivers/input/serio/i8042.h
> @@ -26,6 +26,8 @@
>  #include "i8042-sparcio.h"
>  #elif defined(CONFIG_X86) || defined(CONFIG_IA64)
>  #include "i8042-x86ia64io.h"
> +#elif defined(CONFIG_UNICORE32)
> +#include "i8042-unicore32io.h"
>  #else
>  #include "i8042-io.h"
>  #endif
> 

-- 
Dmitry
