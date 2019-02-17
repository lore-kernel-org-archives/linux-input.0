From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: st1232 - include gpio/consumer.h header for
 gpiod_set_value_cansleep()
Date: Sat, 16 Feb 2019 21:35:03 -0800
Message-ID: <20190217053503.GC107793@dtor-ws>
References: <201902131841.xHSZ8Cvm%fengguang.wu@intel.com>
 <20190213111958.9031-1-martink@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190213111958.9031-1-martink@posteo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Kepplinger <martink@posteo.de>
Cc: kuninori.morimoto.gx@renesas.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Feb 13, 2019 at 12:19:58PM +0100, Martin Kepplinger wrote:
> gpiod_set_value_cansleep() needs it's declaration in the corresponding
> header. This fixes build errors like
> 
>    drivers/input/touchscreen/st1232.c: In function 'st1232_ts_power':
> >> drivers/input/touchscreen/st1232.c:146:3: error: implicit declaration of
>    function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'?
>    [-Werror=implicit-function-declaration]
>       gpiod_set_value_cansleep(ts->reset_gpio, !poweron);
>       ^~~~~~~~~~~~~~~~~~~~~~~~
>       gpio_set_value_cansleep
> 
> Signed-off-by: Martin Kepplinger <martink@posteo.de>

Thanks Martin, I'll fold it into the original patch introducing gpiod so
we keep bisectability.

-- 
Dmitry
