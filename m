From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: soc_button_array - Fix leaking the ACPI button
 descriptor buffer
Date: Sun, 18 Jun 2017 15:13:59 -0700
Message-ID: <20170618221359.GD40590@dtor-ws>
References: <20170617105713.16164-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33447 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752569AbdFRWOD (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 18 Jun 2017 18:14:03 -0400
Received: by mail-pf0-f194.google.com with SMTP id w12so14079652pfk.0
        for <linux-input@vger.kernel.org>; Sun, 18 Jun 2017 15:14:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170617105713.16164-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-input@vger.kernel.org

On Sat, Jun 17, 2017 at 12:57:13PM +0200, Hans de Goede wrote:
> We are passing a buffer with ACPI_ALLOCATE_BUFFER set to
> acpi_evaluate_object, so we must free it when we are done with it.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thank you.

> ---
>  drivers/input/misc/soc_button_array.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
> index e37d37273182..f600f3a7a3c6 100644
> --- a/drivers/input/misc/soc_button_array.c
> +++ b/drivers/input/misc/soc_button_array.c
> @@ -248,7 +248,8 @@ static struct soc_button_info *soc_button_get_button_info(struct device *dev)
>  
>  	if (!btns_desc) {
>  		dev_err(dev, "ACPI Button Descriptors not found\n");
> -		return ERR_PTR(-ENODEV);
> +		button_info = ERR_PTR(-ENODEV);
> +		goto out;
>  	}
>  
>  	/* The first package describes the collection */
> @@ -264,24 +265,31 @@ static struct soc_button_info *soc_button_get_button_info(struct device *dev)
>  	}
>  	if (collection_uid == -1) {
>  		dev_err(dev, "Invalid Button Collection Descriptor\n");
> -		return ERR_PTR(-ENODEV);
> +		button_info = ERR_PTR(-ENODEV);
> +		goto out;
>  	}
>  
>  	/* There are package.count - 1 buttons + 1 terminating empty entry */
>  	button_info = devm_kcalloc(dev, btns_desc->package.count,
>  				   sizeof(*button_info), GFP_KERNEL);
> -	if (!button_info)
> -		return ERR_PTR(-ENOMEM);
> +	if (!button_info) {
> +		button_info = ERR_PTR(-ENOMEM);
> +		goto out;
> +	}
>  
>  	/* Parse the button descriptors */
>  	for (i = 1, btn = 0; i < btns_desc->package.count; i++, btn++) {
>  		if (soc_button_parse_btn_desc(dev,
>  					      &btns_desc->package.elements[i],
>  					      collection_uid,
> -					      &button_info[btn]))
> -			return ERR_PTR(-ENODEV);
> +					      &button_info[btn])) {
> +			button_info = ERR_PTR(-ENODEV);
> +			goto out;
> +		}
>  	}
>  
> +out:
> +	kfree(buf.pointer);
>  	return button_info;
>  }
>  
> -- 
> 2.13.0
> 

-- 
Dmitry
