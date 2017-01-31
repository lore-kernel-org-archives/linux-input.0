From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 2/2] Input: synaptics-rmi4 - add sysfs interfaces for
 hardware IDs
Date: Tue, 31 Jan 2017 01:02:46 -0800
Message-ID: <20170131090246.GF8311@dtor-ws>
References: <1485630362-27423-1-git-send-email-nick@shmanahar.org>
 <1485630362-27423-3-git-send-email-nick@shmanahar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32877 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750906AbdAaJLQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 31 Jan 2017 04:11:16 -0500
Received: by mail-pf0-f195.google.com with SMTP id e4so26802797pfg.0
        for <linux-input@vger.kernel.org>; Tue, 31 Jan 2017 01:11:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1485630362-27423-3-git-send-email-nick@shmanahar.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>
Cc: Chris Healy <cphealy@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On Sat, Jan 28, 2017 at 07:06:02PM +0000, Nick Dyer wrote:
> These attributes provide various bits of information which may be enumerated
> under the RMI4 protocol to user space.
> 
> This may be useful for displaying the particular version which is in use, or
> selecting the correct firmware to flash.
> 
> Signed-off-by: Nick Dyer <nick@shmanahar.org>
> Tested-by: Chris Healy <cphealy@gmail.com>
> ---
>  drivers/input/rmi4/rmi_driver.c |   2 +-
>  drivers/input/rmi4/rmi_driver.h |   6 +-
>  drivers/input/rmi4/rmi_f01.c    |  45 ++++++++++++++-
>  drivers/input/rmi4/rmi_f34.c    | 123 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 172 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> index 30397cc..b398550 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -365,7 +365,7 @@ static void rmi_driver_set_input_name(struct rmi_device *rmi_dev,
>  				struct input_dev *input)
>  {
>  	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
> -	char *device_name = rmi_f01_get_product_ID(data->f01_container);
> +	const char *device_name = rmi_f01_get_product_ID(data->f01_container);
>  	char *name;
>  
>  	name = devm_kasprintf(&rmi_dev->dev, GFP_KERNEL,
> diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
> index 24f8f76..48b3131 100644
> --- a/drivers/input/rmi4/rmi_driver.h
> +++ b/drivers/input/rmi4/rmi_driver.h
> @@ -104,7 +104,11 @@ int rmi_init_functions(struct rmi_driver_data *data);
>  int rmi_initial_reset(struct rmi_device *rmi_dev, void *ctx,
>  		      const struct pdt_entry *pdt);
>  
> -char *rmi_f01_get_product_ID(struct rmi_function *fn);
> +const char *rmi_f01_get_product_ID(struct rmi_function *fn);
> +u8 rmi_f01_get_manufacturer_ID(struct rmi_function *fn);
> +const char *rmi_f01_get_date_of_manufacture(struct rmi_function *fn);
> +u32 rmi_f01_get_firmware_ID(struct rmi_function *fn);
> +u32 rmi_f01_get_package_ID(struct rmi_function *fn);

Why do we plumb this over to F34 instead of creating attributes when F01
is initialized? This data might be interesting to userspace even if F34
is disabled or not available.

Thanks.

-- 
Dmitry
