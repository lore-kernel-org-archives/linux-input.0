From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 4/4] Input: add Apple SPI keyboard and trackpad driver.
Date: Wed, 27 Mar 2019 11:35:30 +0200
Message-ID: <20190327093530.GH9224@smile.fi.intel.com>
References: <20190327014807.7472-1-ronald@innovation.ch>
 <20190327014807.7472-5-ronald@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190327014807.7472-5-ronald@innovation.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>, Federico Lorenzi <federico@travelground.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Mar 26, 2019 at 06:48:07PM -0700, Ronald Tschalär wrote:
> The keyboard and trackpad on recent MacBook's (since 8,1) and
> MacBookPro's (13,* and 14,*) are attached to an SPI controller instead
> of USB, as previously. The higher level protocol is not publicly
> documented and hence has been reverse engineered. As a consequence there
> are still a number of unknown fields and commands. However, the known
> parts have been working well and received extensive testing and use.
> 
> In order for this driver to work, the proper SPI drivers need to be
> loaded too; for MB8,1 these are spi_pxa2xx_platform and spi_pxa2xx_pci;
> for all others they are spi_pxa2xx_platform and intel_lpss_pci. For this
> reason enabling this driver in the config implies enabling the above
> drivers.

> +// SPDX-License-Identifier: GPL-2.0

According to last changes this should be GPL-2.0-only

> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/crc16.h>
> +#include <linux/delay.h>
> +#include <linux/efi.h>
> +#include <linux/input.h>
> +#include <linux/input/mt.h>
> +#include <linux/ktime.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/spinlock.h>
> +#include <linux/spi/spi.h>
> +#include <linux/wait.h>
> +#include <linux/workqueue.h>
> +
> +#include <asm/barrier.h>

> +#include <asm-generic/unaligned.h>

generic?!

#include <asm/unaligned.h>
should work.

> +static const char *applespi_debug_facility(unsigned int log_mask)
> +{
> +	switch (log_mask) {
> +	case DBG_CMD_TP_INI:
> +		return "Touchpad Initialization";
> +	case DBG_CMD_BL:
> +		return "Backlight Command";
> +	case DBG_CMD_CL:
> +		return "Caps-Lock Command";
> +	case DBG_RD_KEYB:
> +		return "Keyboard Event";
> +	case DBG_RD_TPAD:
> +		return "Touchpad Event";
> +	case DBG_RD_UNKN:
> +		return "Unknown Event";
> +	case DBG_RD_IRQ:
> +		return "Interrupt Request";
> +	case DBG_RD_CRC:
> +		return "Corrupted packet";
> +	case DBG_TP_DIM:
> +		return "Touchpad Dimensions";
> +	default:

> +		return "-Unrecognized log mask-";

I don't think '-' surroundings are needed, but this is rather minor. Up to you.

> +	}
> +}

-- 
With Best Regards,
Andy Shevchenko
