From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: soc_button_array: Remove kfree on data
 allocated with devm_zalloc
Date: Fri, 25 Jul 2014 09:22:58 -0700
Message-ID: <20140725162258.GA12254@core.coreip.homeip.net>
References: <1406288074-28725-1-git-send-email-pramod.gurav@smartplayin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1406288074-28725-1-git-send-email-pramod.gurav@smartplayin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: pramod.gurav.etc@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Pramod Gurav <pramod.gurav@smartplayin.com>, Lejun Zhu <lejun.zhu@linux.intel.com>, Sachin Kamat <sachin.kamat@linaro.org>
List-Id: linux-input@vger.kernel.org

Hi Pramod,

On Fri, Jul 25, 2014 at 05:04:34PM +0530, pramod.gurav.etc@gmail.com wrote:
> From: Pramod Gurav <pramod.gurav@smartplayin.com>
> 
> This patch does below:
> - Removes kfree done on data allocated with devm_zalloc in probe
>   path of the driver.
> - Adds a check on return value from devm_kzalloc which was missing
> 
> CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> CC: Lejun Zhu <lejun.zhu@linux.intel.com>
> CC: Sachin Kamat <sachin.kamat@linaro.org>
> 
> Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>
> ---
>  drivers/input/misc/soc_button_array.c |   17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
> index 5a6334b..fc64ec6 100644
> --- a/drivers/input/misc/soc_button_array.c
> +++ b/drivers/input/misc/soc_button_array.c
> @@ -83,6 +83,9 @@ soc_button_device_create(struct pnp_dev *pdev,
>  				       sizeof(*gpio_keys_pdata) +
>  					sizeof(*gpio_keys) * MAX_NBUTTONS,
>  				       GFP_KERNEL);
> +	if (!gpio_keys_pdata)
> +		return ERR_PTR(-ENOMEM);

OK, that makes sense.

> +
>  	gpio_keys = (void *)(gpio_keys_pdata + 1);
>  
>  	for (info = button_info; info->name; info++) {
> @@ -102,20 +105,16 @@ soc_button_device_create(struct pnp_dev *pdev,
>  		n_buttons++;
>  	}
>  
> -	if (n_buttons == 0) {
> -		error = -ENODEV;
> -		goto err_free_mem;
> -	}
> +	if (n_buttons == 0)
> +		return ERR_PTR(-ENODEV);

But that one and the rest don't, because failure in
soc_button_device_create() does not necessarily mean that binding for
the whole device will fail. In this case we do not want unused memory
hang around.

Thanks.

-- 
Dmitry
