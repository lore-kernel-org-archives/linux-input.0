From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/4] Input: synaptics-rmi4 - fix handling failures from
 rmi_enable_sensor
Date: Fri, 31 Mar 2017 11:15:46 +0200
Message-ID: <20170331091546.GI22683@mail.corp.redhat.com>
References: <20170325060050.39867-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170325060050.39867-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nick Dyer <nick@shmanahar.org>
List-Id: linux-input@vger.kernel.org

On Mar 24 2017 or thereabouts, Dmitry Torokhov wrote:
> If rmi_enable_sensor() fails in rmi_driver_probe(), we should not return
> immediately, but disable IRQs and tear down function list.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/input/rmi4/rmi_driver.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> index d9cfe4ec93fa..daba87c7e707 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -1229,16 +1229,21 @@ static int rmi_driver_probe(struct device *dev)
>  	if (retval < 0)
>  		goto err_destroy_functions;
>  
> -	if (data->f01_container->dev.driver)
> +	if (data->f01_container->dev.driver) {
>  		/* Driver already bound, so enable ATTN now. */
> -		return rmi_enable_sensor(rmi_dev);
> +		retval = rmi_enable_sensor(rmi_dev);
> +		if (retval)
> +			goto err_disable_irq;
> +	}
>  
>  	return 0;
>  
> +err_disable_irq:
> +	rmi_disable_irq(rmi_dev, false);
>  err_destroy_functions:
>  	rmi_free_function_list(rmi_dev);
>  err:
> -	return retval < 0 ? retval : 0;
> +	return retval;
>  }
>  
>  static struct rmi_driver rmi_physical_driver = {
> -- 
> 2.12.1.578.ge9c3154ca4-goog
> 
