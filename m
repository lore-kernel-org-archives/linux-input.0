From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: raspberrypi-ts: select CONFIG_INPUT_POLLDEV
Date: Sat, 9 Mar 2019 15:34:38 -0800
Message-ID: <20190309233438.GC13699@dtor-ws>
References: <20190304195845.1096214-1-arnd@arndb.de>
 <87a8108f573e04d5c2eaaaa23be0f3a58bd45eb1.camel@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87a8108f573e04d5c2eaaaa23be0f3a58bd45eb1.camel@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Zhu Yi <yi.zhu5@cn.bosch.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Mar 05, 2019 at 11:39:42AM +0100, Nicolas Saenz Julienne wrote:
> On Mon, 2019-03-04 at 20:57 +0100, Arnd Bergmann wrote:
> > When CONFIG_INPUT_POLLDEV is disabled, we get a link error:
> > 
> > drivers/input/touchscreen/raspberrypi-ts.o: In function `rpi_ts_probe':
> > raspberrypi-ts.c:(.text+0xec): undefined reference to
> > `devm_input_allocate_polled_device'
> > raspberrypi-ts.c:(.text+0xec): relocation truncated to fit: R_AARCH64_CALL26
> > against undefined symbol `devm_input_allocate_polled_device'
> > raspberrypi-ts.c:(.text+0x19c): undefined reference to
> > `input_register_polled_device'
> > raspberrypi-ts.c:(.text+0x19c): relocation truncated to fit: R_AARCH64_CALL26
> > against undefined symbol `input_register_polled_device'
> > 
> > Select that symbol like we do from the other similar drivers.
> > 
> > Fixes: 0b9f28fed3f7 ("Input: add official Raspberry Pi's touchscreen driver")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/input/touchscreen/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/input/touchscreen/Kconfig
> > b/drivers/input/touchscreen/Kconfig
> > index 7c597a49c265..7a4884ad198b 100644
> > --- a/drivers/input/touchscreen/Kconfig
> > +++ b/drivers/input/touchscreen/Kconfig
> > @@ -699,6 +699,7 @@ config TOUCHSCREEN_EDT_FT5X06
> >  config TOUCHSCREEN_RASPBERRYPI_FW
> >  	tristate "Raspberry Pi's firmware base touch screen support"
> >  	depends on RASPBERRYPI_FIRMWARE || (RASPBERRYPI_FIRMWARE=n &&
> > COMPILE_TEST)
> > +	select INPUT_POLLDEV
> >  	help
> >  	  Say Y here if you have the official Raspberry Pi 7 inch screen on
> >  	  your system.
> 
> Thanks!
> Looks good to me.
> 
> Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> 

Applied, thank you.


-- 
Dmitry
