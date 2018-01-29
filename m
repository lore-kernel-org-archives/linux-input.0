From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 6/8] Input: mms114 - Use BIT() macro instead of explicit
 shifting
Date: Mon, 29 Jan 2018 11:46:52 -0800
Message-ID: <20180129194652.wf7oklunpu2fyoo6@dtor-ws>
References: <20180129113323.18961-1-andi.shyti@samsung.com>
 <CGME20180129113331epcas2p130b8bf772fc3124c0a76a0938bcacecc@epcas2p1.samsung.com>
 <20180129113323.18961-7-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180129113323.18961-7-andi.shyti@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Shyti <andi.shyti@samsung.com>
Cc: Simon Shields <simon@lineageos.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>
List-Id: linux-input@vger.kernel.org

On Mon, Jan 29, 2018 at 08:33:21PM +0900, Andi Shyti wrote:
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/mms114.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
> index fdf23bc416af..d70c03adf148 100644
> --- a/drivers/input/touchscreen/mms114.c
> +++ b/drivers/input/touchscreen/mms114.c
> @@ -21,7 +21,7 @@
>  /* Write only registers */
>  #define MMS114_MODE_CONTROL		0x01
>  #define MMS114_OPERATION_MODE_MASK	0xe
> -#define MMS114_ACTIVE			(1 << 1)
> +#define MMS114_ACTIVE			BIT(1)
>  
>  #define MMS114_XY_RESOLUTION_H		0x02
>  #define MMS114_X_RESOLUTION		0x03
> -- 
> 2.15.1
> 

-- 
Dmitry
