From: Nick Dyer <nick@shmanahar.org>
Subject: Re: [PATCH] Input: synaptics-rmi4 - create firmware update sysfs
 attribute in F34
Date: Sun, 12 Feb 2017 22:50:56 +0000
Message-ID: <20170212225056.GB17938@lava.h.shmanahar.org>
References: <20170209212508.GA24684@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avasout05.plus.net ([84.93.230.250]:50467 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751340AbdBLWvB (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 12 Feb 2017 17:51:01 -0500
Content-Disposition: inline
In-Reply-To: <20170209212508.GA24684@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-kernel@vger.kernel.org, Chris Healy <cphealy@gmail.com>

On Thu, Feb 09, 2017 at 01:25:08PM -0800, Dmitry Torokhov wrote:
> There is no need to create sysfs attributes in the main driver core,
> let F34 implementation do that.

Hi Dmitry-

I haven't tested this yet, but I did try creating/removing the sysfs
entries in the f34 function probe/remove as you're suggesting when I
wrote the F34 support.

The problem is that when we do a firmware update, we have to tear down
the function list (because most of the functions are not there during
firmware update and they may in fact come back different). Which removes
the sysfs entries, meaning it's rather like sawing off the branch you're
sitting on, and it crashes almost immediately. I couldn't think of a
cleaner way to solve it that the current implementation.

cheers

Nick

> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/rmi4/rmi_driver.c |  5 ---
>  drivers/input/rmi4/rmi_driver.h | 14 -------
>  drivers/input/rmi4/rmi_f34.c    | 87 +++++++++++++++++++++++------------------
>  3 files changed, 50 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> index d64fc92858f2..d9cfe4ec93fa 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -1001,7 +1001,6 @@ static int rmi_driver_remove(struct device *dev)
>  
>  	rmi_disable_irq(rmi_dev, false);
>  
> -	rmi_f34_remove_sysfs(rmi_dev);
>  	rmi_free_function_list(rmi_dev);
>  
>  	return 0;
> @@ -1215,10 +1214,6 @@ static int rmi_driver_probe(struct device *dev)
>  	if (retval)
>  		goto err;
>  
> -	retval = rmi_f34_create_sysfs(rmi_dev);
> -	if (retval)
> -		goto err;
> -
>  	if (data->input) {
>  		rmi_driver_set_input_name(rmi_dev, data->input);
>  		if (!rmi_dev->xport->input) {
> diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
> index f1a2a2266022..1ada14d7d005 100644
> --- a/drivers/input/rmi4/rmi_driver.h
> +++ b/drivers/input/rmi4/rmi_driver.h
> @@ -120,20 +120,6 @@ static inline int rmi_f03_overwrite_button(struct rmi_function *fn,
>  static inline void rmi_f03_commit_buttons(struct rmi_function *fn) {}
>  #endif
>  
> -#ifdef CONFIG_RMI4_F34
> -int rmi_f34_create_sysfs(struct rmi_device *rmi_dev);
> -void rmi_f34_remove_sysfs(struct rmi_device *rmi_dev);
> -#else
> -static inline int rmi_f34_create_sysfs(struct rmi_device *rmi_dev)
> -{
> -	return 0;
> -}
> -
> -static inline void rmi_f34_remove_sysfs(struct rmi_device *rmi_dev)
> -{
> -}
> -#endif /* CONFIG_RMI_F34 */
> -
>  extern struct rmi_function_handler rmi_f01_handler;
>  extern struct rmi_function_handler rmi_f03_handler;
>  extern struct rmi_function_handler rmi_f11_handler;
> diff --git a/drivers/input/rmi4/rmi_f34.c b/drivers/input/rmi4/rmi_f34.c
> index 425fe140e9df..d4d5297d5a8b 100644
> --- a/drivers/input/rmi4/rmi_f34.c
> +++ b/drivers/input/rmi4/rmi_f34.c
> @@ -509,33 +509,21 @@ static struct attribute_group rmi_firmware_attr_group = {
>  	.attrs = rmi_firmware_attrs,
>  };
>  
> -static int rmi_f34_probe(struct rmi_function *fn)
> +static int rmi_f34v5_probe(struct f34_data *f34)
>  {
> -	struct f34_data *f34;
> -	unsigned char f34_queries[9];
> +	struct rmi_function *fn = f34->fn;
> +	u8 f34_queries[9];
>  	bool has_config_id;
> -	u8 version = fn->fd.function_version;
> -	int ret;
> -
> -	f34 = devm_kzalloc(&fn->dev, sizeof(struct f34_data), GFP_KERNEL);
> -	if (!f34)
> -		return -ENOMEM;
> -
> -	f34->fn = fn;
> -	dev_set_drvdata(&fn->dev, f34);
> -
> -	/* v5 code only supported version 0, try V7 probe */
> -	if (version > 0)
> -		return rmi_f34v7_probe(f34);
> +	int error;
>  
>  	f34->bl_version = 5;
>  
> -	ret = rmi_read_block(fn->rmi_dev, fn->fd.query_base_addr,
> -			     f34_queries, sizeof(f34_queries));
> -	if (ret) {
> -		dev_err(&fn->dev, "%s: Failed to query properties\n",
> -			__func__);
> -		return ret;
> +	error = rmi_read_block(fn->rmi_dev, fn->fd.query_base_addr,
> +			       f34_queries, sizeof(f34_queries));
> +	if (error) {
> +		dev_err(&fn->dev, "%s: Failed to query properties: %d\n",
> +			__func__, error);
> +		return error;
>  	}
>  
>  	snprintf(f34->bootloader_id, sizeof(f34->bootloader_id),
> @@ -548,8 +536,8 @@ static int rmi_f34_probe(struct rmi_function *fn)
>  	f34->v5.fw_blocks = get_unaligned_le16(&f34_queries[5]);
>  	f34->v5.config_blocks = get_unaligned_le16(&f34_queries[7]);
>  	f34->v5.ctrl_address = fn->fd.data_base_addr + F34_BLOCK_DATA_OFFSET +
> -		f34->v5.block_size;
> -	has_config_id = f34_queries[2] & (1 << 2);
> +				f34->v5.block_size;
> +	has_config_id = f34_queries[2] & BIT(2);
>  
>  	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "Bootloader ID: %s\n",
>  		f34->bootloader_id);
> @@ -561,11 +549,11 @@ static int rmi_f34_probe(struct rmi_function *fn)
>  		f34->v5.config_blocks);
>  
>  	if (has_config_id) {
> -		ret = rmi_read_block(fn->rmi_dev, fn->fd.control_base_addr,
> -				     f34_queries, sizeof(f34_queries));
> -		if (ret) {
> +		error = rmi_read_block(fn->rmi_dev, fn->fd.control_base_addr,
> +				       f34_queries, sizeof(f34_queries));
> +		if (error) {
>  			dev_err(&fn->dev, "Failed to read F34 config ID\n");
> -			return ret;
> +			return error;
>  		}
>  
>  		snprintf(f34->configuration_id, sizeof(f34->configuration_id),
> @@ -580,21 +568,46 @@ static int rmi_f34_probe(struct rmi_function *fn)
>  	return 0;
>  }
>  
> -int rmi_f34_create_sysfs(struct rmi_device *rmi_dev)
> +static int rmi_f34_probe(struct rmi_function *fn)
>  {
> -	return sysfs_create_group(&rmi_dev->dev.kobj, &rmi_firmware_attr_group);
> +	struct f34_data *f34;
> +	u8 version = fn->fd.function_version;
> +	int error;
> +
> +	f34 = devm_kzalloc(&fn->dev, sizeof(struct f34_data), GFP_KERNEL);
> +	if (!f34)
> +		return -ENOMEM;
> +
> +	f34->fn = fn;
> +	dev_set_drvdata(&fn->dev, f34);
> +
> +	/* v5 code only supported version 0 */
> +	error = version > 0 ? rmi_f34v7_probe(f34) : rmi_f34v5_probe(f34);
> +	if (error)
> +		return error;
> +
> +	error = sysfs_create_group(&fn->rmi_dev->dev.kobj,
> +				   &rmi_firmware_attr_group);
> +	if (error) {
> +		dev_err(&fn->dev, "%s: Failed to create sysfs attributes: %d\n",
> +			__func__, error);
> +		return error;
> +	}
> +
> +	return 0;
>  }
>  
> -void rmi_f34_remove_sysfs(struct rmi_device *rmi_dev)
> +static void rmi_f34_remove(struct rmi_function *fn)
>  {
> -	sysfs_remove_group(&rmi_dev->dev.kobj, &rmi_firmware_attr_group);
> +	sysfs_remove_group(&fn->rmi_dev->dev.kobj, &rmi_firmware_attr_group);
>  }
>  
>  struct rmi_function_handler rmi_f34_handler = {
> -	.driver = {
> -		.name = "rmi4_f34",
> +	.driver	= {
> +		.name	= "rmi4_f34",
>  	},
> -	.func = 0x34,
> -	.probe = rmi_f34_probe,
> -	.attention = rmi_f34_attention,
> +	.func		= 0x34,
> +	.probe		= rmi_f34_probe,
> +	.remove		= rmi_f34_remove,
> +	.attention	= rmi_f34_attention,
>  };
> -- 
> 2.11.0.483.g087da7b7c-goog
> 
> 
> -- 
> Dmitry
