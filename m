From: Trilok Soni <tsoni@codeaurora.org>
Subject: Re: [PATCH] msm: trout: add keypad support
Date: Thu, 09 Dec 2010 12:36:54 +0530
Message-ID: <4D00800E.7050004@codeaurora.org>
References: <1291854285-29566-1-git-send-email-dwalker@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:41705 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156Ab0LIHG5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Dec 2010 02:06:57 -0500
In-Reply-To: <1291854285-29566-1-git-send-email-dwalker@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Walker <dwalker@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, arve@android.com

Hi Daniel,

> --- /dev/null
> +++ b/arch/arm/mach-msm/board-trout-keypad.c
> @@ -0,0 +1,342 @@
> +/* arch/arm/mach-msm/board-trout-keypad.c

No paths please.

> + *
> + * Copyright (C) 2008 Google, Inc.
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful),
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/input/matrix_keypad.h>
> +#include <linux/gpio_keys.h>
> +#include <asm/mach-types.h>
> +
> +#include "board-trout.h"
> +
> +static char *keycaps = "--qwerty";
> +#undef MODULE_PARAM_PREFIX
> +#define MODULE_PARAM_PREFIX "board_trout."
> +module_param_named(keycaps, keycaps, charp, 0);

I would like to know what is the use of this param?

> +
> +
> +static unsigned int trout_col_gpios[] = { 35, 34, 33, 32, 31, 23, 30, 78 };
> +static unsigned int trout_row_gpios[] = { 42, 41, 40, 39, 38, 37, 36 };

const?

> +
> +static unsigned int trout_col_gpios_evt2[] = { 35, 34, 33, 32, 31, 23, 30, 109 };
> +static unsigned int trout_row_gpios_evt2[] = { 42, 41, 40, 39, 38, 37, 36 };

const?

> +static int __init trout_init_keypad(void)
> +{
> +	int ret;
> +
> +	if (!machine_is_trout())
> +		return 0;
> +
> +	switch (system_rev) {
> +	case 0:
> +		/* legacy default keylayout */
> +		break;
> +	case 1:
> +		/* v1 has a new keyboard layout */
> +		trout_pdata.keymap_data = &trout_keymap_data_2_1;
> +		trout_pdata.col_gpios = trout_col_gpios_evt2;
> +		trout_pdata.row_gpios = trout_row_gpios_evt2;
> +
> +		/* userspace needs to know about these changes as well */

?? what is the meaning of this comment?

> +		break;
> +	default: /* 2, 3, 4 currently */
> +		/* v2 has a new keyboard layout */
> +		trout_pdata.keymap_data = &trout_keymap_data_2_2;
> +		trout_pdata.col_gpios = trout_col_gpios_evt2;
> +		trout_pdata.row_gpios = trout_row_gpios_evt2;
> +
> +		/* userspace needs to know about these changes as well */

ditto.

---Trilok Soni

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
