From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v1 41/63] Input: touchscreen: Atmel: Enable
 IRQ_DISABLE_UNLAZY flag for interrupt
Date: Fri, 16 Aug 2019 10:26:15 -0700
Message-ID: <20190816172615.GJ121898@dtor-ws>
References: <20190816083558.19189-1-jiada_wang@mentor.com>
 <20190816083558.19189-2-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190816083558.19189-2-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiada Wang <jiada_wang@mentor.com>
Cc: nick@shmanahar.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, george_davis@mentor.com
List-Id: linux-input@vger.kernel.org

On Fri, Aug 16, 2019 at 05:35:36PM +0900, Jiada Wang wrote:
> From: Bhuvanesh Surachari <bhuvanesh_surachari@mentor.com>
> 
> The de-/serializer driver has defined only irq_mask "ds90ub927_irq_mask" and
> irq_unmask "ds90ub927_irq_unmask" callback functions. And de-/serializer
> driver doesn't implement the irq_disable and irq_enable callback functions.
> Hence inorder to invoke irq_mask callback function when disable_irq_nosync is
> called the IRQ_DISABLE_UNLAZY interrupt flag should be set. If not the
> disable_irq_nosync will just increment the depth field in the irq
> descriptor only once as shown below.
> 
> disable_irq_nosync
>  __disable_irq_nosync
>   __disable_irq (desc->depth++)
>    irq_disable
>     if irq_disable present -----------> if IRQ_DISABLE_UNLAZYflag set
>              |                  no                  |
>          yes |                                  yes |
>              |                                      |
>      desc->irq_data.chip->irq_disable   desc->irq_data.chip->irq_unmask
>                                          (ds90ub927_irq_mask)
>                                           disable_irq
>                                            __disable_irq_nosync
>                                             __disable_irq
> (desc->depth++)
> But the enable_irq will try to decrement the depth field twice which generates
> the backtrace stating "Unbalanced enable for irq 293". This is because there is
> no IRQ_DISABLE_UNLAZY flag check while calling irq_unmask callback function
> of the "ds90ub927_irq_unmask" de-/serializer via enable_irq.
> 
> enable_irq
>  __enable_irq (desc->depth--)
>   irq_enable
>    if irq_enable present -------------> desc->irq_data.chip->irq_unmask
>               |                no        (ds90ub927_irq_unmask)
>           yes |                            enable_irq
>               |                             __enable_irq (desc->depth--)
>     (desc->irq_data.chip->irq_enable)

I'd prefer if we instead did not use the disable_irq_nosync() in the
driver.

Thanks.

-- 
Dmitry
