From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: gpio_keys: add missing include to gpio_keys.h
Date: Wed, 18 Jul 2018 16:48:27 +0000
Message-ID: <20180718164827.yq2j3e5gt3jkjuyl@penguin>
References: <20180627073458.GA27800@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180627073458.GA27800@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: robh@kernel.org, gregkh@linuxfoundation.org, tglx@linutronix.de, jeffy.chen@rock-chips.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Jun 27, 2018 at 10:34:58AM +0300, Matti Vaittinen wrote:
> gpio_keys.h uses 'bool' - type which is defined in linux/types.h.
> Include this header.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

Applied, thank you.

> ---
>  include/linux/gpio_keys.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
> index 7160df54a6fe..3f84aeb81e48 100644
> --- a/include/linux/gpio_keys.h
> +++ b/include/linux/gpio_keys.h
> @@ -2,6 +2,8 @@
>  #ifndef _GPIO_KEYS_H
>  #define _GPIO_KEYS_H
>  
> +#include <linux/types.h>
> +
>  struct device;
>  
>  /**
> -- 
> 2.14.3
> 

-- 
Dmitry
