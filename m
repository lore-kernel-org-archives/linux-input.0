From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Input: melfas_mip4 - add hw_version sysfs attribute
Date: Fri, 18 Mar 2016 10:02:04 -0700
Message-ID: <20160318170204.GB27348@dtor-ws>
References: <1457778170-31320-1-git-send-email-jeesw@melfas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:32816 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754960AbcCRRCI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Mar 2016 13:02:08 -0400
Received: by mail-pf0-f174.google.com with SMTP id 4so44661505pfd.0
        for <linux-input@vger.kernel.org>; Fri, 18 Mar 2016 10:02:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1457778170-31320-1-git-send-email-jeesw@melfas.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sangwon Jee <jeesw@melfas.com>
Cc: linux-input@vger.kernel.org

On Sat, Mar 12, 2016 at 07:22:50PM +0900, Sangwon Jee wrote:
> Add hw_version sysfs attribute for retrieving hardware information
> from firmware.
> 
> Signed-off-by: Sangwon Jee <jeesw@melfas.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/melfas_mip4.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/melfas_mip4.c b/drivers/input/touchscreen/melfas_mip4.c
> index 89272973..fb5fb91 100644
> --- a/drivers/input/touchscreen/melfas_mip4.c
> +++ b/drivers/input/touchscreen/melfas_mip4.c
> @@ -1310,8 +1310,34 @@ static ssize_t mip4_sysfs_read_fw_version(struct device *dev,
>  
>  static DEVICE_ATTR(fw_version, S_IRUGO, mip4_sysfs_read_fw_version, NULL);
>  
> +static ssize_t mip4_sysfs_read_hw_version(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct mip4_ts *ts = i2c_get_clientdata(client);
> +	size_t count;
> +
> +	/* Take lock to prevent racing with firmware update */
> +	mutex_lock(&ts->input->mutex);
> +
> +	/*
> +	 * product_name shows the name or version of the hardware
> +	 * paired with current firmware in the chip.
> +	 */
> +	count = snprintf(buf, PAGE_SIZE, "%.*s\n",
> +		(int)sizeof(ts->product_name), ts->product_name);
> +
> +	mutex_unlock(&ts->input->mutex);
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR(hw_version, S_IRUGO, mip4_sysfs_read_hw_version, NULL);
> +
>  static struct attribute *mip4_attrs[] = {
>  	&dev_attr_fw_version.attr,
> +	&dev_attr_hw_version.attr,
>  	&dev_attr_update_fw.attr,
>  	NULL,
>  };
> @@ -1512,6 +1538,6 @@ static struct i2c_driver mip4_driver = {
>  module_i2c_driver(mip4_driver);
>  
>  MODULE_DESCRIPTION("MELFAS MIP4 Touchscreen");
> -MODULE_VERSION("2016.03.03");
> +MODULE_VERSION("2016.03.12");
>  MODULE_AUTHOR("Sangwon Jee <jeesw@melfas.com>");
>  MODULE_LICENSE("GPL");
> -- 
> 1.9.1
> 

-- 
Dmitry
