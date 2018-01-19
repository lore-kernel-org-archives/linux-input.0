From: thatslyude@gmail.com
Subject: Re: [PATCH 1/3] Input: synaptics_rmi4 - do not delete interrupt
 memory too early
Date: Thu, 18 Jan 2018 20:05:51 -0500
Message-ID: <1516323951.2814.2.camel@gmail.com>
References: <20180119004955.247190-1-dmitry.torokhov@gmail.com>
         <20180119004955.247190-2-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:40551 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753476AbeASBGW (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 18 Jan 2018 20:06:22 -0500
In-Reply-To: <20180119004955.247190-2-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Damjan Georgievski <gdamjan@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Duggan <aduggan@synaptics.com>, stable@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>
(hope you don't mind that I'm using my gmail address for this ;)

On Thu, 2018-01-18 at 16:49 -0800, Dmitry Torokhov wrote:
> We want to free memory reserved for interrupt mask handling only after we
> free functions, as function drivers might want to mask interrupts. This is
> needed for the followup patch to the F03 that would implement unmasking and
> masking interrupts from the serio pass-through port open() and close()
> methods.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/rmi4/rmi_driver.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_driver.c
> b/drivers/input/rmi4/rmi_driver.c
> index 27791d6546c66..ce3ede289ed04 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -41,6 +41,13 @@ void rmi_free_function_list(struct rmi_device *rmi_dev)
>  
>  	rmi_dbg(RMI_DEBUG_CORE, &rmi_dev->dev, "Freeing function list\n");
>  
> +	/* Doing it in the reverse order so F01 will be removed last */
> +	list_for_each_entry_safe_reverse(fn, tmp,
> +					 &data->function_list, node) {
> +		list_del(&fn->node);
> +		rmi_unregister_function(fn);
> +	}
> +
>  	devm_kfree(&rmi_dev->dev, data->irq_memory);
>  	data->irq_memory = NULL;
>  	data->irq_status = NULL;
> @@ -50,13 +57,6 @@ void rmi_free_function_list(struct rmi_device *rmi_dev)
>  
>  	data->f01_container = NULL;
>  	data->f34_container = NULL;
> -
> -	/* Doing it in the reverse order so F01 will be removed last */
> -	list_for_each_entry_safe_reverse(fn, tmp,
> -					 &data->function_list, node) {
> -		list_del(&fn->node);
> -		rmi_unregister_function(fn);
> -	}
>  }
>  
>  static int reset_one_function(struct rmi_function *fn)
