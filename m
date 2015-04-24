From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] [Input: add a driver for wdt87xx touchscreen
 controller]  The main function of this driver is to report touch events and
 update firmware for the controller.
Date: Fri, 24 Apr 2015 10:36:28 +0200
Message-ID: <1429864588.2927.48.camel@x220>
References: <1429806091-5089-1-git-send-email-hn.chen@weidahitech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429806091-5089-1-git-send-email-hn.chen@weidahitech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: HungNien Chen <hn.chen@weidahitech.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com
List-Id: linux-input@vger.kernel.org

Just a license mismatch.

On Fri, 2015-04-24 at 00:21 +0800, HungNien Chen wrote:
> --- /dev/null
> +++ b/drivers/input/touchscreen/wdt87xx_i2c.c

> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.

This states the license is GPL v2.

> +MODULE_LICENSE("GPL");

And, according to include/linux/module.h, this states the license is GPL
v2 or later. So, to make these statements match, either the comment at
the top of this file or the license ident used in the MODULE_LICENSE()
macro needs to change.

Thanks,


Paul Bolle
