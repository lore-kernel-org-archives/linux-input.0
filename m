From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 10/12] Input: cros_ec_keyb - Switch to SPDX identifier.
Date: Tue, 12 Jun 2018 16:30:45 -0700
Message-ID: <20180612233045.GF38773@dtor-ws>
References: <20180606150900.8342-1-enric.balletbo@collabora.com>
 <20180606150900.8342-11-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180606150900.8342-11-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Jun 06, 2018 at 05:08:58PM +0200, Enric Balletbo i Serra wrote:
> Adopt the SPDX license identifier headers to ease license compliance
> management.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Applied, thank you.

> ---
> 
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/input/keyboard/cros_ec_keyb.c | 34 ++++++++++-----------------
>  1 file changed, 12 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> index 9dd8c146699f..dd1b356d0004 100644
> --- a/drivers/input/keyboard/cros_ec_keyb.c
> +++ b/drivers/input/keyboard/cros_ec_keyb.c
> @@ -1,25 +1,15 @@
> -/*
> - * ChromeOS EC keyboard driver
> - *
> - * Copyright (C) 2012 Google, Inc
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * This driver uses the Chrome OS EC byte-level message-based protocol for
> - * communicating the keyboard state (which keys are pressed) from a keyboard EC
> - * to the AP over some bus (such as i2c, lpc, spi).  The EC does debouncing,
> - * but everything else (including deghosting) is done here.  The main
> - * motivation for this is to keep the EC firmware as simple as possible, since
> - * it cannot be easily upgraded and EC flash/IRAM space is relatively
> - * expensive.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// ChromeOS EC keyboard driver
> +//
> +// Copyright (C) 2012 Google, Inc.
> +//
> +// This driver uses the ChromeOS EC byte-level message-based protocol for
> +// communicating the keyboard state (which keys are pressed) from a keyboard EC
> +// to the AP over some bus (such as i2c, lpc, spi).  The EC does debouncing,
> +// but everything else (including deghosting) is done here.  The main
> +// motivation for this is to keep the EC firmware as simple as possible, since
> +// it cannot be easily upgraded and EC flash/IRAM space is relatively
> +// expensive.
>  
>  #include <linux/module.h>
>  #include <linux/bitops.h>
> -- 
> 2.17.1
> 

-- 
Dmitry
