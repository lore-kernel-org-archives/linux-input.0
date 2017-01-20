From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2] Input: synaptics-rmi4 - add sysfs attribute
 update_fw_status
Date: Fri, 20 Jan 2017 14:35:10 +0100
Message-ID: <20170120133510.GH28187@mail.corp.redhat.com>
References: <CAFXsbZq2yjOA++A788KGu0Y0QcV2Vq+e6833AQqteJxgS=7vmg@mail.gmail.com>
 <1484426782-10877-1-git-send-email-nick@shmanahar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45970 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752029AbdATOAE (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 20 Jan 2017 09:00:04 -0500
Content-Disposition: inline
In-Reply-To: <1484426782-10877-1-git-send-email-nick@shmanahar.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>
Cc: Chris Healy <cphealy@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org

On Jan 14 2017 or thereabouts, Nick Dyer wrote:
> The status is the percentage complete, or once complete, zero for
> success or a negative return code.

I am probably just bike-shedding, but I don't think you should report
on success. I would say 100 when the transfert went fine, or a negative
error code (which means 0 is the transfert hasn't started yet).

Also, I am surprised there is no generic way of reporting this to
userspace.

Other than that, I think the code is safe here. You can have concurrent
accesses to the sysfs, but given that you are only setting the value
from the driver, I don't think using an atomic would help.

This one is:
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> 
> Signed-off-by: Nick Dyer <nick@shmanahar.org>
> ---
> 
> Hi Chris-
> 
> Here's an updated version which should fix the issues on S7817 - could you retest?
> 
> cheers
> 
> Nick
> 
>  drivers/input/rmi4/rmi_f34.c   | 34 ++++++++++++++++++++++++++++++++++
>  drivers/input/rmi4/rmi_f34.h   |  4 ++++
>  drivers/input/rmi4/rmi_f34v7.c | 11 +++++++++++
>  3 files changed, 49 insertions(+)
> 
> diff --git a/drivers/input/rmi4/rmi_f34.c b/drivers/input/rmi4/rmi_f34.c
> index c3285ce..d7709bc 100644
> --- a/drivers/input/rmi4/rmi_f34.c
> +++ b/drivers/input/rmi4/rmi_f34.c
> @@ -157,6 +157,9 @@ static int rmi_f34_write_blocks(struct f34_data *f34, const void *data,
>  			i + 1, block_count);
>  
>  		data += f34->v5.block_size;
> +		f34->update_progress += f34->v5.block_size;
> +		f34->update_status = (f34->update_progress * 100) /
> +			f34->update_size;
>  	}
>  
>  	return 0;
> @@ -186,6 +189,8 @@ static int rmi_f34_flash_firmware(struct f34_data *f34,
>  	struct rmi_function *fn = f34->fn;
>  	int ret;
>  
> +	f34->update_progress = 0;
> +	f34->update_size = syn_fw->image_size + syn_fw->config_size;
>  	if (syn_fw->image_size) {
>  		dev_info(&fn->dev, "Erasing firmware...\n");
>  		ret = rmi_f34_command(f34, F34_ERASE_ALL,
> @@ -283,6 +288,17 @@ out:
>  	return ret;
>  }
>  
> +int rmi_f34_status(struct rmi_function *fn)
> +{
> +	struct f34_data *f34 = dev_get_drvdata(&fn->dev);
> +
> +	/*
> +	 * The status is the percentage complete, or once complete,
> +	 * zero for success or a negative return code.
> +	 */
> +	return f34->update_status;
> +}
> +
>  static int rmi_firmware_update(struct rmi_driver_data *data,
>  			       const struct firmware *fw)
>  {
> @@ -347,6 +363,7 @@ static int rmi_firmware_update(struct rmi_driver_data *data,
>  		ret = rmi_f34_update_firmware(f34, fw);
>  
>  	dev_info(&f34->fn->dev, "Firmware update complete, status:%d\n", ret);
> +	f34->update_status = ret;
>  
>  	rmi_disable_irq(rmi_dev, false);
>  
> @@ -414,8 +431,25 @@ static ssize_t rmi_driver_update_fw_store(struct device *dev,
>  
>  static DEVICE_ATTR(update_fw, 0200, NULL, rmi_driver_update_fw_store);
>  
> +static ssize_t rmi_driver_update_fw_status_show(struct device *dev,
> +						struct device_attribute *dattr,
> +						char *buf)
> +{
> +	struct rmi_driver_data *data = dev_get_drvdata(dev);
> +	int update_status = 0;
> +
> +	if (data->f34_container)
> +		update_status = rmi_f34_status(data->f34_container);
> +
> +	return scnprintf(buf, PAGE_SIZE, "%d\n", update_status);
> +}
> +
> +static DEVICE_ATTR(update_fw_status, 0444,
> +		   rmi_driver_update_fw_status_show, NULL);
> +
>  static struct attribute *rmi_firmware_attrs[] = {
>  	&dev_attr_update_fw.attr,
> +	&dev_attr_update_fw_status.attr,
>  	NULL
>  };
>  
> diff --git a/drivers/input/rmi4/rmi_f34.h b/drivers/input/rmi4/rmi_f34.h
> index 2c21056..43a9134 100644
> --- a/drivers/input/rmi4/rmi_f34.h
> +++ b/drivers/input/rmi4/rmi_f34.h
> @@ -301,6 +301,10 @@ struct f34_data {
>  	unsigned char bootloader_id[5];
>  	unsigned char configuration_id[CONFIG_ID_SIZE*2 + 1];
>  
> +	int update_status;
> +	int update_progress;
> +	int update_size;
> +
>  	union {
>  		struct f34v5_data v5;
>  		struct f34v7_data v7;
> diff --git a/drivers/input/rmi4/rmi_f34v7.c b/drivers/input/rmi4/rmi_f34v7.c
> index ca31f95..56c6c39 100644
> --- a/drivers/input/rmi4/rmi_f34v7.c
> +++ b/drivers/input/rmi4/rmi_f34v7.c
> @@ -588,6 +588,7 @@ static int rmi_f34v7_check_ui_firmware_size(struct f34_data *f34)
>  	u16 block_count;
>  
>  	block_count = f34->v7.img.ui_firmware.size / f34->v7.block_size;
> +	f34->update_size += block_count;
>  
>  	if (block_count != f34->v7.blkcount.ui_firmware) {
>  		dev_err(&f34->fn->dev,
> @@ -604,6 +605,7 @@ static int rmi_f34v7_check_ui_config_size(struct f34_data *f34)
>  	u16 block_count;
>  
>  	block_count = f34->v7.img.ui_config.size / f34->v7.block_size;
> +	f34->update_size += block_count;
>  
>  	if (block_count != f34->v7.blkcount.ui_config) {
>  		dev_err(&f34->fn->dev, "UI config size mismatch\n");
> @@ -618,6 +620,7 @@ static int rmi_f34v7_check_dp_config_size(struct f34_data *f34)
>  	u16 block_count;
>  
>  	block_count = f34->v7.img.dp_config.size / f34->v7.block_size;
> +	f34->update_size += block_count;
>  
>  	if (block_count != f34->v7.blkcount.dp_config) {
>  		dev_err(&f34->fn->dev, "Display config size mismatch\n");
> @@ -632,6 +635,8 @@ static int rmi_f34v7_check_guest_code_size(struct f34_data *f34)
>  	u16 block_count;
>  
>  	block_count = f34->v7.img.guest_code.size / f34->v7.block_size;
> +	f34->update_size += block_count;
> +
>  	if (block_count != f34->v7.blkcount.guest_code) {
>  		dev_err(&f34->fn->dev, "Guest code size mismatch\n");
>  		return -EINVAL;
> @@ -645,6 +650,7 @@ static int rmi_f34v7_check_bl_config_size(struct f34_data *f34)
>  	u16 block_count;
>  
>  	block_count = f34->v7.img.bl_config.size / f34->v7.block_size;
> +	f34->update_size += block_count;
>  
>  	if (block_count != f34->v7.blkcount.bl_config) {
>  		dev_err(&f34->fn->dev, "Bootloader config size mismatch\n");
> @@ -881,6 +887,9 @@ static int rmi_f34v7_write_f34v7_blocks(struct f34_data *f34,
>  
>  		block_ptr += (transfer * f34->v7.block_size);
>  		remaining -= transfer;
> +		f34->update_progress += transfer;
> +		f34->update_status = (f34->update_progress * 100) /
> +				     f34->update_size;
>  	} while (remaining);
>  
>  	return 0;
> @@ -1191,6 +1200,8 @@ int rmi_f34v7_do_reflash(struct f34_data *f34, const struct firmware *fw)
>  	rmi_f34v7_read_queries_bl_version(f34);
>  
>  	f34->v7.image = fw->data;
> +	f34->update_progress = 0;
> +	f34->update_size = 0;
>  
>  	ret = rmi_f34v7_parse_image_info(f34);
>  	if (ret < 0)
> -- 
> 2.7.4
> 
