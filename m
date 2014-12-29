From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 04/11 linux-next] input: remove unnecessary version.h
 inclusion
Date: Mon, 29 Dec 2014 10:32:55 -0800
Message-ID: <20141229183255.GE9565@dtor-ws>
References: <1419863387-24233-1-git-send-email-fabf@skynet.be>
 <1419863387-24233-5-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1419863387-24233-5-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Dec 29, 2014 at 03:29:38PM +0100, Fabian Frederick wrote:
> Based on versioncheck.
> 
> Signed-off-by: Fabian Frederick <fabf@skynet.be>

Applied, thank you.

> ---
>  drivers/input/touchscreen/elants_i2c.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
> index a510f7e..926c58e 100644
> --- a/drivers/input/touchscreen/elants_i2c.c
> +++ b/drivers/input/touchscreen/elants_i2c.c
> @@ -33,10 +33,8 @@
>  #include <linux/delay.h>
>  #include <linux/uaccess.h>
>  #include <linux/buffer_head.h>
> -#include <linux/version.h>
>  #include <linux/slab.h>
>  #include <linux/firmware.h>
> -#include <linux/version.h>
>  #include <linux/input/mt.h>
>  #include <linux/acpi.h>
>  #include <linux/of.h>
> -- 
> 2.1.0
> 

-- 
Dmitry
