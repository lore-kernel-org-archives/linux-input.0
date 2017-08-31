From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] Input: tegra-kbc: Handle return value of
 clk_prepare_enable.
Date: Thu, 31 Aug 2017 11:51:05 -0700
Message-ID: <20170831185105.GD14370@dtor-ws>
References: <e18b64df1c144ac6ac05bd16e0d5d0cd59a20d13.1501581502.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <e18b64df1c144ac6ac05bd16e0d5d0cd59a20d13.1501581502.git.arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: riyer-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, Aug 01, 2017 at 03:32:26PM +0530, Arvind Yadav wrote:
> clk_prepare_enable() can fail here and we must check its return value.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Applied, thank you.

> ---
>  drivers/input/keyboard/tegra-kbc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
> index 0c07e10..edc1385 100644
> --- a/drivers/input/keyboard/tegra-kbc.c
> +++ b/drivers/input/keyboard/tegra-kbc.c
> @@ -370,8 +370,11 @@ static int tegra_kbc_start(struct tegra_kbc *kbc)
>  {
>  	unsigned int debounce_cnt;
>  	u32 val = 0;
> +	int ret;
>  
> -	clk_prepare_enable(kbc->clk);
> +	ret = clk_prepare_enable(kbc->clk);
> +	if (ret)
> +		return ret;
>  
>  	/* Reset the KBC controller to clear all previous status.*/
>  	reset_control_assert(kbc->rst);
> -- 
> 1.9.1
> 

-- 
Dmitry
