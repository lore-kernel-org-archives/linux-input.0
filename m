From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2] input: touchscreen: wm97xx-core: Fix possible
 null-pointer dereferences in wm97xx_ts_input_open()
Date: Fri, 26 Jul 2019 10:28:17 +0100
Message-ID: <20190726092817.GB54126@ediswmail.ad.cirrus.com>
References: <20190726091436.8866-1-baijiaju1990@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190726091436.8866-1-baijiaju1990@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: dmitry.torokhov@gmail.com, tglx@linutronix.de, gregkh@linuxfoundation.org, allison@lohutok.net, rdunlap@infradead.org, patches@opensource.cirrus.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Jul 26, 2019 at 05:14:36PM +0800, Jia-Ju Bai wrote:
> In wm97xx_ts_input_open(), there is an if statement on line 507 to check
> whether wm->mach_ops is NULL:
>     if (wm->mach_ops && wm->mach_ops->acc_enabled)
> 
> When wm->mach_ops is NULL, it is used on line 521:
>     wm97xx_init_pen_irq(wm);
>         BUG_ON(!wm->mach_ops->irq_enable);
>         BUG_ON(!wm->mach_ops->irq_gpio);
>         wm97xx_reg_write(..., reg & ~(wm->mach_ops->irq_gpio))
> 
> Thus, possible null-pointer dereferences may occur.
> 
> To fix these bugs, wm->mach_ops is checked at the beginning of 
> wm97xx_init_pen_irq().
> 
> These bugs found by a static analysis tool STCheck written by us.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
> v2:
> * Add a new check of wm->mach_ops in wm97xx_init_pen_irq().
>   Thank Charles for helpful advice.
> 
> ---
>  drivers/input/touchscreen/wm97xx-core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
> index 0a174bd82915..50b016abf492 100644
> --- a/drivers/input/touchscreen/wm97xx-core.c
> +++ b/drivers/input/touchscreen/wm97xx-core.c
> @@ -374,6 +374,9 @@ static int wm97xx_init_pen_irq(struct wm97xx *wm)
>  {
>  	u16 reg;
>  
> +	if (!wm->mach_ops)
> +		return -EINVAL;
> +

Probably worth adding an printk in here too, the calling function
doesn't check the return value of this function so otherwise
there will be no indication this failed.

Thanks,
Charles

>  	/* If an interrupt is supplied an IRQ enable operation must also be
>  	 * provided. */
>  	BUG_ON(!wm->mach_ops->irq_enable);
> -- 
> 2.17.0
> 
