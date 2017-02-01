From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] gpio: Rename devm_get_gpiod_from_child()
Date: Wed, 1 Feb 2017 09:17:59 -0800
Message-ID: <20170201171759.GA40531@dtor-ws>
References: <1485790909-2915-1-git-send-email-boris.brezillon@free-electrons.com>
 <1485790909-2915-2-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1485790909-2915-2-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>
List-Id: linux-input@vger.kernel.org

On Mon, Jan 30, 2017 at 04:41:48PM +0100, Boris Brezillon wrote:
> Rename devm_get_gpiod_from_child() into
> devm_fwnode_get_gpiod_from_child() to reflect the fact that this
> function is operating on a fwnode object.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/gpio/devres.c                     | 11 ++++++-----
>  drivers/input/keyboard/gpio_keys.c        |  3 ++-
>  drivers/input/keyboard/gpio_keys_polled.c |  5 +++--

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

for input bits.

-- 
Dmitry
