From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] HID: Logitech K290: Add driver for the Logitech K290 USB keyboard
Date: Sat, 3 Mar 2018 18:08:30 +0200
Message-ID: <CAHp75VeLaXb+wOUJOXojOwXSm68=oaiA7=RCKH_tOsBT7OzUxg@mail.gmail.com>
References: <20180302220425.27707-1-contact@florentflament.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180302220425.27707-1-contact@florentflament.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florent Flament <contact@florentflament.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sat, Mar 3, 2018 at 12:04 AM, Florent Flament
<contact@florentflament.com> wrote:
> With the generic HID driver, K290 keyboards' F1 to F12 keys send
> multimedia events by default, and standard keycodes when the function
> key is pressed. This driver allows to configure K290 keyboards, so
> that F1 to F12 have a standard behavior and send multimedia events
> when the function key is pressed. The keyboard mode is set through the
> fn_mode module parameter: when set to 1 (default setting) the keyboard
> behaves as with the generic HID driver, when set to 0 the keyboard is
> configured to work as standard keyboards.

SPDX ID?

> +/*
> + * HID driver for Logitech K290 keyboard
> + *
> + * Copyright (c) 2018 Florent Flament
> + *
> + * This drivers allows to configure the K290 keyboard's function key
> + * behaviour (whether function mode is activated or not by default).
> + *
> + * Logitech custom commands taken from Marcus Ilgner k290-fnkeyctl
> + * (https://github.com/milgner/k290-fnkeyctl):
> + * K290_SET_FUNCTION_CMD
> + * K290_SET_FUNCTION_VAL
> + * K290_SET_FUNCTION_OFF
> + * K290_SET_FUNCTION_ON
> + *
> + * Based on hid-accutouch.c and hid-elo.c
> + *

> + * This driver is licensed under the terms of GPLv2.

...instead of this.

> + */

> +
> +#include <linux/device.h>
> +#include <linux/hid.h>
> +#include <linux/module.h>

> +#include <linux/moduleparam.h>
> +#include <linux/mod_devicetable.h>

Do you need these both? I suppose module.h effectively provides them.

> +#include <linux/stat.h>
> +#include <linux/types.h>
> +#include <linux/usb.h>

-- 
With Best Regards,
Andy Shevchenko
