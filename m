From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH 03/11] Input: synaptics-rmi4 - have only one struct
 platform data
Date: Fri, 26 Aug 2016 18:35:12 -0700
Message-ID: <b7d953ee-ff91-3d7c-e888-2ca5cde7d567@synaptics.com>
References: <1471512289-10648-1-git-send-email-benjamin.tissoires@redhat.com>
 <1471512289-10648-4-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx1.synaptics.com ([192.147.44.131]:42384 "EHLO
        us-mx1.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754623AbcH0Bka (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 26 Aug 2016 21:40:30 -0400
In-Reply-To: <1471512289-10648-4-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lyude Paul <thatslyude@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Resending as plain text

On 08/18/2016 02:24 AM, Benjamin Tissoires wrote:
> If struct rmi_device_platform_data contains pointers to other struct,
> it gets difficult to allocate a fixed size struct and copy it over between
> drivers.
>
> Change the pointers into a struct and change the code in rmi4 accordingly.
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> ---
>
> this patch will conflict with Andrew's patch to switch hid-rmi
> to use rmi4_core...
> ---
>  drivers/input/rmi4/rmi_f11.c | 4 ++--
>  drivers/input/rmi4/rmi_f12.c | 4 ++--
>  drivers/input/rmi4/rmi_f30.c | 7 +++----
>  include/linux/rmi.h          | 4 ++--
>  4 files changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
> index 20c7134..b14a7b6 100644
> --- a/drivers/input/rmi4/rmi_f11.c
> +++ b/drivers/input/rmi4/rmi_f11.c
> @@ -1063,8 +1063,8 @@ static int rmi_f11_initialize(struct rmi_function *fn)
>  		rc = rmi_2d_sensor_of_probe(&fn->dev, &f11->sensor_pdata);
>  		if (rc)
>  			return rc;
> -	} else if (pdata->sensor_pdata) {
> -		f11->sensor_pdata = *pdata->sensor_pdata;
> +	} else {
> +		f11->sensor_pdata = pdata->sensor_pdata;
>  	}
>
>  	f11->rezero_wait_ms = f11->sensor_pdata.rezero_wait;
> diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
> index 332c02f..a631bed 100644
> --- a/drivers/input/rmi4/rmi_f12.c
> +++ b/drivers/input/rmi4/rmi_f12.c
> @@ -274,8 +274,8 @@ static int rmi_f12_probe(struct rmi_function *fn)
>  		ret = rmi_2d_sensor_of_probe(&fn->dev, &f12->sensor_pdata);
>  		if (ret)
>  			return ret;
> -	} else if (pdata->sensor_pdata) {
> -		f12->sensor_pdata = *pdata->sensor_pdata;
> +	} else {
> +		f12->sensor_pdata = pdata->sensor_pdata;
>  	}
>
>  	ret = rmi_read_register_desc(rmi_dev, query_addr,
> diff --git a/drivers/input/rmi4/rmi_f30.c b/drivers/input/rmi4/rmi_f30.c
> index 760aff1..7990bb0 100644
> --- a/drivers/input/rmi4/rmi_f30.c
> +++ b/drivers/input/rmi4/rmi_f30.c
> @@ -192,7 +192,7 @@ static int rmi_f30_config(struct rmi_function *fn)
>  				rmi_get_platform_data(fn->rmi_dev);
>  	int error;
>
> -	if (pdata->f30_data && pdata->f30_data->disable) {
> +	if (pdata && pdata->f30_data.disable) {

My one comment is that pdata struct is embedded in the transport device 
so rmi_get_platform_data() will not return NULL. Making the check of 
pdata unnecessary.


>  		drv->clear_irq_bits(fn->rmi_dev, fn->irq_mask);
>  	} else {
>  		/* Write Control Register values back to device */
> @@ -362,8 +362,7 @@ static inline int rmi_f30_initialize(struct rmi_function *fn)
>  				 * f30->has_mech_mouse_btns, but I am
>  				 * not sure, so use only the pdata info
>  				 */
> -				if (pdata->f30_data &&
> -				    pdata->f30_data->buttonpad)
> +				if (pdata && pdata->f30_data.buttonpad)

Same with this check of pdata.

>  					break;
>  			}
>  		}
> @@ -378,7 +377,7 @@ static int rmi_f30_probe(struct rmi_function *fn)
>  	const struct rmi_device_platform_data *pdata =
>  				rmi_get_platform_data(fn->rmi_dev);
>
> -	if (pdata->f30_data && pdata->f30_data->disable)
> +	if (pdata && pdata->f30_data.disable)

And this one.

That's a fairly minor comment and I could see an argument for keeping 
the checks in the event that the implementation of 
rmi_get_platform_data() changes.

So:
Reviewed-by: Andrew Duggan <aduggan@synaptics.com>

Andrew

>  		return 0;
>
>  	rc = rmi_f30_initialize(fn);
> diff --git a/include/linux/rmi.h b/include/linux/rmi.h
> index e0aca14..4a071e8 100644
> --- a/include/linux/rmi.h
> +++ b/include/linux/rmi.h
> @@ -211,9 +211,9 @@ struct rmi_device_platform_data {
>  	struct rmi_device_platform_data_spi spi_data;
>
>  	/* function handler pdata */
> -	struct rmi_2d_sensor_platform_data *sensor_pdata;
> +	struct rmi_2d_sensor_platform_data sensor_pdata;
>  	struct rmi_f01_power_management power_management;
> -	struct rmi_f30_data *f30_data;
> +	struct rmi_f30_data f30_data;
>  };
>
>  /**
>

