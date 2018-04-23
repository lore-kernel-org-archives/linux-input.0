From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: touchscreen: Fix a typo in Kconfig
Date: Mon, 23 Apr 2018 12:02:20 -0700
Message-ID: <20180423190220.GD66646@dtor-ws>
References: <20180419184514.9668-1-standby24x7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180419184514.9668-1-standby24x7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masanari Iida <standby24x7@gmail.com>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Apr 20, 2018 at 03:45:14AM +0900, Masanari Iida wrote:
> This patch fix a spelling typo found in Kconfig.
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 4f15496fec8b..3e613afa10b4 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -362,7 +362,7 @@ config TOUCHSCREEN_HIDEEP
>  
>  	  If unsure, say N.
>  
> -	  To compile this driver as a moudle, choose M here : the
> +	  To compile this driver as a module, choose M here : the
>  	  module will be called hideep_ts.
>  
>  config TOUCHSCREEN_ILI210X
> -- 
> 2.17.0.140.g0b0cc9f86731
> 

-- 
Dmitry
