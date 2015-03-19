From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: elan_i2c - fix typo in include header guard
Date: Thu, 19 Mar 2015 09:13:55 -0700
Message-ID: <20150319161355.GD30732@dtor-ws>
References: <1426770631-29665-1-git-send-email-nicolas.iooss_linux@m4x.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426770631-29665-1-git-send-email-nicolas.iooss_linux@m4x.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Cc: dusonlin@emc.com.tw, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Mar 19, 2015 at 09:10:31PM +0800, Nicolas Iooss wrote:
> Signed-off-by: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
> Fixes: 6696777c6506 ("Input: add driver for Elan I2C/SMbus touchpad")

Applied, thank you.

> ---
>  drivers/input/mouse/elan_i2c.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/elan_i2c.h b/drivers/input/mouse/elan_i2c.h
> index e100c1b31597..9b2dc015f20c 100644
> --- a/drivers/input/mouse/elan_i2c.h
> +++ b/drivers/input/mouse/elan_i2c.h
> @@ -17,7 +17,7 @@
>   */
>  
>  #ifndef _ELAN_I2C_H
> -#define _ELAN_i2C_H
> +#define _ELAN_I2C_H
>  
>  #include <linux/types.h>
>  
> -- 
> 2.3.3
> 

-- 
Dmitry
