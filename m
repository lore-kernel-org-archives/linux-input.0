From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] remove explicit devm_kfree
Date: Fri, 15 Aug 2014 09:51:58 -0700
Message-ID: <20140815165158.GA25225@core.coreip.homeip.net>
References: <1408116365-3013-1-git-send-email-arjun024@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1408116365-3013-1-git-send-email-arjun024@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arjun Sreedharan <arjun024@gmail.com>
Cc: lejun.zhu@linux.intel.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Aug 15, 2014 at 08:56:05PM +0530, Arjun Sreedharan wrote:
> Memory allocated with devm_kzalloc() is freed automatically when device
> out of scope.

But in this case the device does not necessarily goes "out of scope" and we
still want to release memory.

Thanks.

> 
> Signed-off-by: Arjun Sreedharan <arjun024@gmail.com>
> ---
>  drivers/input/misc/soc_button_array.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
> index 5a6334b..123e59f 100644
> --- a/drivers/input/misc/soc_button_array.c
> +++ b/drivers/input/misc/soc_button_array.c
> @@ -131,7 +131,6 @@ soc_button_device_create(struct pnp_dev *pdev,
>  err_free_pdev:
>  	platform_device_put(pd);
>  err_free_mem:
> -	devm_kfree(&pdev->dev, gpio_keys_pdata);
>  	return ERR_PTR(error);
>  }
>  
> -- 
> 1.7.11.7
> 

-- 
Dmitry
