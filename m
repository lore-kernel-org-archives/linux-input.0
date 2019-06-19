From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: gpio_keys - use struct_size() in devm_kzalloc()
Date: Tue, 18 Jun 2019 17:20:57 -0700
Message-ID: <20190619002057.GB62571@dtor-ws>
References: <20190618152325.GA21504@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190618152325.GA21504@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Jun 18, 2019 at 10:23:25AM -0500, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct gpio_keys_drvdata {
> 	...
>         struct gpio_button_data data[0];
> };
> 
> 
> size = sizeof(struct gpio_keys_drvdata) + count * sizeof(struct gpio_button_data);
> instance = devm_kzalloc(dev, size, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> instance = devm_kzalloc(dev, struct_size(instance, data, count), GFP_KERNEL);
> 
> Notice that, in this case, variable size is not necessary, hence it
> is removed.
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied, thank you.

> ---
>  drivers/input/keyboard/gpio_keys.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index 6cd199e8a370..c186c2552b04 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -774,7 +774,6 @@ static int gpio_keys_probe(struct platform_device *pdev)
>  	struct fwnode_handle *child = NULL;
>  	struct gpio_keys_drvdata *ddata;
>  	struct input_dev *input;
> -	size_t size;
>  	int i, error;
>  	int wakeup = 0;
>  
> @@ -784,9 +783,8 @@ static int gpio_keys_probe(struct platform_device *pdev)
>  			return PTR_ERR(pdata);
>  	}
>  
> -	size = sizeof(struct gpio_keys_drvdata) +
> -			pdata->nbuttons * sizeof(struct gpio_button_data);
> -	ddata = devm_kzalloc(dev, size, GFP_KERNEL);
> +	ddata = devm_kzalloc(dev, struct_size(ddata, data, pdata->nbuttons),
> +			     GFP_KERNEL);
>  	if (!ddata) {
>  		dev_err(dev, "failed to allocate state\n");
>  		return -ENOMEM;
> -- 
> 2.21.0
> 

-- 
Dmitry
