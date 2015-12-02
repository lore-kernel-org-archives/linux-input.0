From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: sparcspkr - Use
 platform_register/unregister_drivers()
Date: Wed, 2 Dec 2015 09:32:51 -0800
Message-ID: <20151202173251.GB15531@dtor-ws>
References: <1449073519-11768-1-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449073519-11768-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Dec 02, 2015 at 05:25:19PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> These new helpers simplify implementing multi-driver modules and
> properly handle failure to register one driver by unregistering all
> previously registered drivers.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Applied, thank you.

> ---
>  drivers/input/misc/sparcspkr.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/input/misc/sparcspkr.c b/drivers/input/misc/sparcspkr.c
> index 6f997aa49183..4a5afc7fe96e 100644
> --- a/drivers/input/misc/sparcspkr.c
> +++ b/drivers/input/misc/sparcspkr.c
> @@ -345,23 +345,19 @@ static struct platform_driver grover_beep_driver = {
>  	.shutdown	= sparcspkr_shutdown,
>  };
>  
> +static struct platform_driver * const drivers[] = {
> +	&bbc_beep_driver,
> +	&grover_beep_driver,
> +};
> +
>  static int __init sparcspkr_init(void)
>  {
> -	int err = platform_driver_register(&bbc_beep_driver);
> -
> -	if (!err) {
> -		err = platform_driver_register(&grover_beep_driver);
> -		if (err)
> -			platform_driver_unregister(&bbc_beep_driver);
> -	}
> -
> -	return err;
> +	return platform_register_drivers(drivers, ARRAY_SIZE(drivers));
>  }
>  
>  static void __exit sparcspkr_exit(void)
>  {
> -	platform_driver_unregister(&bbc_beep_driver);
> -	platform_driver_unregister(&grover_beep_driver);
> +	platform_unregister_drivers(drivers, ARRAY_SIZE(drivers));
>  }
>  
>  module_init(sparcspkr_init);
> -- 
> 2.5.0
> 

-- 
Dmitry
