From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v3] input: touchscreen: wm97xx-core: Fix possible
 null-pointer dereferences in wm97xx_ts_input_open()
Date: Fri, 26 Jul 2019 11:33:07 +0100
Message-ID: <20190726103307.GC54126@ediswmail.ad.cirrus.com>
References: <20190726102326.9266-1-baijiaju1990@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190726102326.9266-1-baijiaju1990@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: dmitry.torokhov@gmail.com, allison@lohutok.net, gregkh@linuxfoundation.org, tglx@linutronix.de, rdunlap@infradead.org, patches@opensource.cirrus.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Jul 26, 2019 at 06:23:26PM +0800, Jia-Ju Bai wrote:
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
> v3:
> * Print a message if wm->mach_ops is NULL in wm97xx_init_pen_irq().
>   Thank Charles for helpful advice.
> 
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
