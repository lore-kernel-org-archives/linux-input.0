From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/2] Input: synaptics-rmi4 - add sysfs interfaces for
 hardware IDs
Date: Fri, 20 Jan 2017 14:42:52 +0100
Message-ID: <20170120134252.GI28187@mail.corp.redhat.com>
References: <1483123398-27595-1-git-send-email-nick@shmanahar.org>
 <1483123398-27595-3-git-send-email-nick@shmanahar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37016 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751977AbdATNn2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 20 Jan 2017 08:43:28 -0500
Content-Disposition: inline
In-Reply-To: <1483123398-27595-3-git-send-email-nick@shmanahar.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Chris Healy <cphealy@gmail.com>, linux-input@vger.kernel.org

Hi Nick,

Well, first, you need a changelog explaining why you need custom sysfs
files.

Then, I really wonder if this is the best solution. You are trying to
solve a general problem in a specific way, while other drivers/devices
could benefit from reporting such information in a generic way.

I don't have a solution, but I know that we already had the case where
userspace wants to know which firmware is currently loaded on a
board[1].

A solution could be to add some ioctls to evdev to report those various
hardware IDs, but I am not so sure it will help in the RMI4 device while
in bootloader case.

If Dmitry agrees to take this one, I have nothing against it.

Cheers,
Benjamin

[1] https://bugs.freedesktop.org/show_bug.cgi?id=97912

On Dec 30 2016 or thereabouts, Nick Dyer wrote:
> Signed-off-by: Nick Dyer <nick@shmanahar.org>
> ---
>  drivers/input/rmi4/rmi_driver.c |   2 +-
>  drivers/input/rmi4/rmi_driver.h |   6 +-
>  drivers/input/rmi4/rmi_f01.c    |  45 ++++++++++++++-
>  drivers/input/rmi4/rmi_f34.c    | 123 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 172 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> index cb6efe6..e0359d6 100644
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
>  
>  #ifdef CONFIG_RMI4_F34
>  int rmi_f34_create_sysfs(struct rmi_device *rmi_dev);
> diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
> index cae35c6..1b03f4d 100644
> --- a/drivers/input/rmi4/rmi_f01.c
> +++ b/drivers/input/rmi4/rmi_f01.c
> @@ -13,6 +13,7 @@
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
>  #include <linux/of.h>
> +#include <asm/unaligned.h>
>  #include "rmi_driver.h"
>  
>  #define RMI_PRODUCT_ID_LENGTH    10
> @@ -55,6 +56,7 @@ struct f01_basic_properties {
>  	u8 product_id[RMI_PRODUCT_ID_LENGTH + 1];
>  	u16 productinfo;
>  	u32 firmware_id;
> +	u32 package_id;
>  };
>  
>  /* F01 device status bits */
> @@ -221,8 +223,19 @@ static int rmi_f01_read_properties(struct rmi_device *rmi_dev,
>  			has_build_id_query = !!(queries[0] & BIT(1));
>  		}
>  
> -		if (has_package_id_query)
> +		if (has_package_id_query) {
> +			ret = rmi_read_block(rmi_dev, prod_info_addr,
> +					     queries, sizeof(__le64));
> +			if (ret) {
> +				dev_err(&rmi_dev->dev,
> +					"Failed to read package info: %d\n",
> +					ret);
> +				return ret;
> +			}
> +
> +			props->package_id = get_unaligned_le64(queries);
>  			prod_info_addr++;
> +		}
>  
>  		if (has_build_id_query) {
>  			ret = rmi_read_block(rmi_dev, prod_info_addr, queries,
> @@ -242,13 +255,41 @@ static int rmi_f01_read_properties(struct rmi_device *rmi_dev,
>  	return 0;
>  }
>  
> -char *rmi_f01_get_product_ID(struct rmi_function *fn)
> +const char *rmi_f01_get_product_ID(struct rmi_function *fn)
>  {
>  	struct f01_data *f01 = dev_get_drvdata(&fn->dev);
>  
>  	return f01->properties.product_id;
>  }
>  
> +u8 rmi_f01_get_manufacturer_ID(struct rmi_function *fn)
> +{
> +	struct f01_data *f01 = dev_get_drvdata(&fn->dev);
> +
> +	return f01->properties.manufacturer_id;
> +}
> +
> +const char *rmi_f01_get_date_of_manufacture(struct rmi_function *fn)
> +{
> +	struct f01_data *f01 = dev_get_drvdata(&fn->dev);
> +
> +	return f01->properties.dom;
> +}
> +
> +u32 rmi_f01_get_firmware_ID(struct rmi_function *fn)
> +{
> +	struct f01_data *f01 = dev_get_drvdata(&fn->dev);
> +
> +	return f01->properties.firmware_id;
> +}
> +
> +u32 rmi_f01_get_package_ID(struct rmi_function *fn)
> +{
> +	struct f01_data *f01 = dev_get_drvdata(&fn->dev);
> +
> +	return f01->properties.package_id;
> +}
> +
>  #ifdef CONFIG_OF
>  static int rmi_f01_of_probe(struct device *dev,
>  				struct rmi_device_platform_data *pdata)
> diff --git a/drivers/input/rmi4/rmi_f34.c b/drivers/input/rmi4/rmi_f34.c
> index d7709bc..b7b38c1 100644
> --- a/drivers/input/rmi4/rmi_f34.c
> +++ b/drivers/input/rmi4/rmi_f34.c
> @@ -394,6 +394,122 @@ static int rmi_firmware_update(struct rmi_driver_data *data,
>  	return ret;
>  }
>  
> +static ssize_t rmi_driver_manufacturer_id_show(struct device *dev,
> +					       struct device_attribute *dattr,
> +					       char *buf)
> +{
> +	struct rmi_driver_data *data = dev_get_drvdata(dev);
> +	struct rmi_function *fn = data->f01_container;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%d\n",
> +			 rmi_f01_get_manufacturer_ID(fn));
> +}
> +
> +static DEVICE_ATTR(manufacturer_id, 0444,
> +		   rmi_driver_manufacturer_id_show, NULL);
> +
> +static ssize_t rmi_driver_dom_show(struct device *dev,
> +				   struct device_attribute *dattr, char *buf)
> +{
> +	struct rmi_driver_data *data = dev_get_drvdata(dev);
> +	struct rmi_function *fn = data->f01_container;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%s\n",
> +			 rmi_f01_get_date_of_manufacture(fn));
> +}
> +
> +static DEVICE_ATTR(date_of_manufacture, 0444, rmi_driver_dom_show, NULL);
> +
> +static ssize_t rmi_driver_product_id_show(struct device *dev,
> +					  struct device_attribute *dattr,
> +					  char *buf)
> +{
> +	struct rmi_driver_data *data = dev_get_drvdata(dev);
> +	struct rmi_function *fn = data->f01_container;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%s\n",
> +			 rmi_f01_get_product_ID(fn));
> +}
> +
> +static DEVICE_ATTR(product_id, 0444,
> +		   rmi_driver_product_id_show, NULL);
> +
> +static ssize_t rmi_driver_firmware_id_show(struct device *dev,
> +					   struct device_attribute *dattr,
> +					   char *buf)
> +{
> +	struct rmi_driver_data *data = dev_get_drvdata(dev);
> +	struct rmi_function *fn = data->f01_container;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%d\n",
> +			 rmi_f01_get_firmware_ID(fn));
> +}
> +
> +static DEVICE_ATTR(firmware_id, 0444,
> +		   rmi_driver_firmware_id_show, NULL);
> +
> +static ssize_t rmi_driver_bootloader_id_show(struct device *dev,
> +					     struct device_attribute *dattr,
> +					     char *buf)
> +{
> +	struct rmi_driver_data *data = dev_get_drvdata(dev);
> +	struct rmi_function *fn = data->f34_container;
> +	struct f34_data *f34;
> +
> +	if (fn) {
> +		f34 = dev_get_drvdata(&fn->dev);
> +
> +		if (f34->bl_version == 5)
> +			return scnprintf(buf, PAGE_SIZE, "%c%c\n",
> +					 f34->bootloader_id[0],
> +					 f34->bootloader_id[1]);
> +		else
> +			return scnprintf(buf, PAGE_SIZE, "V%d.%d\n",
> +					 f34->bootloader_id[1],
> +					 f34->bootloader_id[0]);
> +	}
> +
> +	return 0;
> +}
> +
> +static DEVICE_ATTR(bootloader_id, 0444,
> +		   rmi_driver_bootloader_id_show, NULL);
> +
> +static ssize_t rmi_driver_configuration_id_show(struct device *dev,
> +						struct device_attribute *dattr,
> +						char *buf)
> +{
> +	struct rmi_driver_data *data = dev_get_drvdata(dev);
> +	struct rmi_function *fn = data->f34_container;
> +	struct f34_data *f34;
> +
> +	if (fn) {
> +		f34 = dev_get_drvdata(&fn->dev);
> +
> +		return scnprintf(buf, PAGE_SIZE, "%s\n", f34->configuration_id);
> +	}
> +
> +	return 0;
> +}
> +
> +static DEVICE_ATTR(configuration_id, 0444,
> +		   rmi_driver_configuration_id_show, NULL);
> +
> +static ssize_t rmi_driver_package_id_show(struct device *dev,
> +					  struct device_attribute *dattr,
> +					  char *buf)
> +{
> +	struct rmi_driver_data *data = dev_get_drvdata(dev);
> +	struct rmi_function *fn = data->f01_container;
> +
> +	u32 package_id = rmi_f01_get_package_ID(fn);
> +
> +	return scnprintf(buf, PAGE_SIZE, "%04x.%04x\n",
> +			 package_id & 0xffff, (package_id >> 16) & 0xffff);
> +}
> +
> +static DEVICE_ATTR(package_id, 0444, rmi_driver_package_id_show, NULL);
> +
>  static int rmi_firmware_update(struct rmi_driver_data *data,
>  			       const struct firmware *fw);
>  
> @@ -448,6 +564,13 @@ static DEVICE_ATTR(update_fw_status, 0444,
>  		   rmi_driver_update_fw_status_show, NULL);
>  
>  static struct attribute *rmi_firmware_attrs[] = {
> +	&dev_attr_bootloader_id.attr,
> +	&dev_attr_configuration_id.attr,
> +	&dev_attr_manufacturer_id.attr,
> +	&dev_attr_date_of_manufacture.attr,
> +	&dev_attr_product_id.attr,
> +	&dev_attr_package_id.attr,
> +	&dev_attr_firmware_id.attr,
>  	&dev_attr_update_fw.attr,
>  	&dev_attr_update_fw_status.attr,
>  	NULL
> -- 
> 2.7.4
> 
