From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 04/15] input: convert LoCoMo keyboard driver to use new
 locomo core
Date: Mon, 27 Oct 2014 17:09:38 -0700
Message-ID: <20141028000938.GE7594@dtor-ws>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
 <1414454528-24240-5-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1414454528-24240-5-git-send-email-dbaryshkov@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org, Andrea Adami <andrea.adami@gmail.com>, Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: linux-input@vger.kernel.org

On Tue, Oct 28, 2014 at 03:01:57AM +0300, Dmitry Eremin-Solenikov wrote:
> As LoCoMo is switching to new device model, adapt keyboard driver to
> support new locomo core driver.
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>  drivers/input/keyboard/Kconfig     |   1 -
>  drivers/input/keyboard/locomokbd.c | 165 ++++++++++++++++++++-----------------
>  2 files changed, 91 insertions(+), 75 deletions(-)
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index a3958c6..b660516 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -337,7 +337,6 @@ config KEYBOARD_LM8333
>  
>  config KEYBOARD_LOCOMO
>  	tristate "LoCoMo Keyboard Support"
> -	depends on SHARP_LOCOMO
>  	help
>  	  Say Y here if you are running Linux on a Sharp Zaurus Collie or Poodle based PDA
>  
> diff --git a/drivers/input/keyboard/locomokbd.c b/drivers/input/keyboard/locomokbd.c
> index c94d610..c2fabf3 100644
> --- a/drivers/input/keyboard/locomokbd.c
> +++ b/drivers/input/keyboard/locomokbd.c
> @@ -28,16 +28,10 @@
>  #include <linux/init.h>
>  #include <linux/input.h>
>  #include <linux/delay.h>
> -#include <linux/device.h>
> +#include <linux/platform_device.h>
>  #include <linux/interrupt.h>
> -#include <linux/ioport.h>
> -
> -#include <asm/hardware/locomo.h>
> -#include <asm/irq.h>
> -
> -MODULE_AUTHOR("John Lenz <lenz@cs.wisc.edu>");
> -MODULE_DESCRIPTION("LoCoMo keyboard driver");
> -MODULE_LICENSE("GPL");
> +#include <linux/io.h>
> +#include <linux/mfd/locomo.h>
>  
>  #define LOCOMOKBD_NUMKEYS	128
>  
> @@ -75,7 +69,8 @@ struct locomokbd {
>  	struct input_dev *input;
>  	char phys[32];
>  
> -	unsigned long base;
> +	void __iomem *base;
> +	int irq;
>  	spinlock_t lock;
>  
>  	struct timer_list timer;
> @@ -84,37 +79,37 @@ struct locomokbd {
>  };
>  
>  /* helper functions for reading the keyboard matrix */
> -static inline void locomokbd_charge_all(unsigned long membase)
> +static inline void locomokbd_charge_all(void __iomem *membase)
>  {
> -	locomo_writel(0x00FF, membase + LOCOMO_KSC);
> +	writew(0x00FF, membase + LOCOMO_KSC);
>  }
>  
> -static inline void locomokbd_activate_all(unsigned long membase)
> +static inline void locomokbd_activate_all(void __iomem *membase)
>  {
>  	unsigned long r;
>  
> -	locomo_writel(0, membase + LOCOMO_KSC);
> -	r = locomo_readl(membase + LOCOMO_KIC);
> +	writew(0, membase + LOCOMO_KSC);
> +	r = readw(membase + LOCOMO_KIC);
>  	r &= 0xFEFF;
> -	locomo_writel(r, membase + LOCOMO_KIC);
> +	writew(r, membase + LOCOMO_KIC);
>  }
>  
> -static inline void locomokbd_activate_col(unsigned long membase, int col)
> +static inline void locomokbd_activate_col(void __iomem *membase, int col)
>  {
>  	unsigned short nset;
>  	unsigned short nbset;
>  
>  	nset = 0xFF & ~(1 << col);
>  	nbset = (nset << 8) + nset;
> -	locomo_writel(nbset, membase + LOCOMO_KSC);
> +	writew(nbset, membase + LOCOMO_KSC);
>  }
>  
> -static inline void locomokbd_reset_col(unsigned long membase, int col)
> +static inline void locomokbd_reset_col(void __iomem *membase, int col)
>  {
>  	unsigned short nbset;
>  
>  	nbset = ((0xFF & ~(1 << col)) << 8) + 0xFF;
> -	locomo_writel(nbset, membase + LOCOMO_KSC);
> +	writew(nbset, membase + LOCOMO_KSC);
>  }
>  
>  /*
> @@ -129,7 +124,7 @@ static void locomokbd_scankeyboard(struct locomokbd *locomokbd)
>  	unsigned int row, col, rowd;
>  	unsigned long flags;
>  	unsigned int num_pressed;
> -	unsigned long membase = locomokbd->base;
> +	void __iomem *membase = locomokbd->base;
>  
>  	spin_lock_irqsave(&locomokbd->lock, flags);
>  
> @@ -141,7 +136,7 @@ static void locomokbd_scankeyboard(struct locomokbd *locomokbd)
>  		locomokbd_activate_col(membase, col);
>  		udelay(KB_DELAY);
>  
> -		rowd = ~locomo_readl(membase + LOCOMO_KIB);
> +		rowd = ~readw(membase + LOCOMO_KIB);
>  		for (row = 0; row < KB_ROWS; row++) {
>  			unsigned int scancode, pressed, key;
>  
> @@ -194,11 +189,11 @@ static irqreturn_t locomokbd_interrupt(int irq, void *dev_id)
>  	struct locomokbd *locomokbd = dev_id;
>  	u16 r;
>  
> -	r = locomo_readl(locomokbd->base + LOCOMO_KIC);
> +	r = readw(locomokbd->base + LOCOMO_KIC);
>  	if ((r & 0x0001) == 0)
>  		return IRQ_HANDLED;
>  
> -	locomo_writel(r & ~0x0100, locomokbd->base + LOCOMO_KIC); /* Ack */
> +	writew(r & ~0x0100, locomokbd->base + LOCOMO_KIC); /* Ack */
>  
>  	/** wait chattering delay **/
>  	udelay(100);
> @@ -222,8 +217,8 @@ static int locomokbd_open(struct input_dev *dev)
>  	struct locomokbd *locomokbd = input_get_drvdata(dev);
>  	u16 r;
>  	
> -	r = locomo_readl(locomokbd->base + LOCOMO_KIC) | 0x0010;
> -	locomo_writel(r, locomokbd->base + LOCOMO_KIC);
> +	r = readw(locomokbd->base + LOCOMO_KIC) | 0x0010;
> +	writew(r, locomokbd->base + LOCOMO_KIC);
>  	return 0;
>  }
>  
> @@ -232,35 +227,39 @@ static void locomokbd_close(struct input_dev *dev)
>  	struct locomokbd *locomokbd = input_get_drvdata(dev);
>  	u16 r;
>  	
> -	r = locomo_readl(locomokbd->base + LOCOMO_KIC) & ~0x0010;
> -	locomo_writel(r, locomokbd->base + LOCOMO_KIC);
> +	r = readw(locomokbd->base + LOCOMO_KIC) & ~0x0010;
> +	writew(r, locomokbd->base + LOCOMO_KIC);
>  }
>  
> -static int locomokbd_probe(struct locomo_dev *dev)
> +static int locomokbd_probe(struct platform_device *dev)
>  {
>  	struct locomokbd *locomokbd;
>  	struct input_dev *input_dev;
>  	int i, err;
> +	struct resource *res;
> +
> +	locomokbd = devm_kzalloc(&dev->dev, sizeof(struct locomokbd),
> +			GFP_KERNEL);
> +	if (!locomokbd)
> +		return -ENOMEM;
>  
> -	locomokbd = kzalloc(sizeof(struct locomokbd), GFP_KERNEL);
>  	input_dev = input_allocate_device();
> -	if (!locomokbd || !input_dev) {
> -		err = -ENOMEM;
> -		goto err_free_mem;
> -	}
> +	if (!input_dev)
> +		return -ENOMEM;
>  
> -	/* try and claim memory region */
> -	if (!request_mem_region((unsigned long) dev->mapbase,
> -				dev->length,
> -				LOCOMO_DRIVER_NAME(dev))) {
> -		err = -EBUSY;
> -		printk(KERN_ERR "locomokbd: Can't acquire access to io memory for keyboard\n");
> -		goto err_free_mem;
> -	}
> +	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
>  
> -	locomo_set_drvdata(dev, locomokbd);
> +	locomokbd->irq = platform_get_irq(dev, 0);
> +	if (locomokbd->irq < 0)
> +		return -ENXIO;
>  
> -	locomokbd->base = (unsigned long) dev->mapbase;
> +	platform_set_drvdata(dev, locomokbd);
> +
> +	locomokbd->base = devm_ioremap_resource(&dev->dev, res);
> +	if (IS_ERR(locomokbd->base))
> +		return PTR_ERR(locomokbd->base);

You are leaking memory (input device) here. Since you can't convert all
resources to devm* I'd rather you leave them all explicitly managed
instead of having a mix.

Thanks.

-- 
Dmitry
