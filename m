From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [2/2] Input: melfas_mip4 - add fw_name sysfs attribute
Date: Fri, 21 Oct 2016 15:33:00 -0700
Message-ID: <20161021223300.GB1350@dtor-ws>
References: <1477046966-9385-1-git-send-email-jeesw@melfas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36584 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935056AbcJUWdE (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 21 Oct 2016 18:33:04 -0400
Received: by mail-pf0-f195.google.com with SMTP id r16so9689198pfg.3
        for <linux-input@vger.kernel.org>; Fri, 21 Oct 2016 15:33:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1477046966-9385-1-git-send-email-jeesw@melfas.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sangwon Jee <jeesw@melfas.com>
Cc: linux-input@vger.kernel.org

On Fri, Oct 21, 2016 at 07:49:26PM +0900, Sangwon Jee wrote:
> To support user firmware file name, add fw_name sysfs attribute 
> and modify to use fw_name variable instead of predefined value.
> 

No, please have userspace adjust to whatever name kernel expects. If
there are concerns about multiple devices with incompatible firmware in
the system consider encoding product ID number in firmware name that
kernel requests.

Thanks.

> Signed-off-by: Sangwon Jee <jeesw@melfas.com>
> ---
>  drivers/input/touchscreen/melfas_mip4.c | 46 +++++++++++++++++++++++++++++++--
>  1 file changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/melfas_mip4.c b/drivers/input/touchscreen/melfas_mip4.c
> index 8739cb7..ae9c428 100644
> --- a/drivers/input/touchscreen/melfas_mip4.c
> +++ b/drivers/input/touchscreen/melfas_mip4.c
> @@ -162,6 +162,7 @@ struct mip4_ts {
>  	char product_name[16];
>  	u16 product_id;
>  	char ic_name[4];
> +	char *fw_name;
>  
>  	unsigned int max_x;
>  	unsigned int max_y;
> @@ -1285,11 +1286,11 @@ static ssize_t mip4_sysfs_fw_update(struct device *dev,
>  	const struct firmware *fw;
>  	int error;
>  
> -	error = request_firmware(&fw, MIP4_FW_NAME, dev);
> +	error = request_firmware(&fw, ts->fw_name, dev);
>  	if (error) {
>  		dev_err(&ts->client->dev,
>  			"Failed to retrieve firmware %s: %d\n",
> -			MIP4_FW_NAME, error);
> +			ts->fw_name, error);
>  		return error;
>  	}
>  
> @@ -1403,11 +1404,51 @@ static ssize_t mip4_sysfs_read_ic_name(struct device *dev,
>  
>  static DEVICE_ATTR(ic_name, S_IRUGO, mip4_sysfs_read_ic_name, NULL);
>  
> +static ssize_t mip4_sysfs_read_fw_name(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct mip4_ts *ts = i2c_get_clientdata(client);
> +	size_t count;
> +
> +	mutex_lock(&ts->input->mutex);
> +
> +	count = snprintf(buf, PAGE_SIZE, "%s\n", ts->fw_name);
> +
> +	mutex_unlock(&ts->input->mutex);
> +
> +	return count;
> +}
> +
> +static ssize_t mip4_sysfs_write_fw_name(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf,
> +					size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct mip4_ts *ts = i2c_get_clientdata(client);
> +	char *filename;
> +
> +	filename = devm_kzalloc(dev, count - 1, GFP_KERNEL);
> +	memcpy(filename, buf, count - 1);
> +
> +	ts->fw_name = devm_kstrdup(dev, filename, GFP_KERNEL);
> +
> +	devm_kfree(dev, filename);
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR(fw_name, S_IRUGO | S_IWUSR,
> +			mip4_sysfs_read_fw_name, mip4_sysfs_write_fw_name);
> +
>  static struct attribute *mip4_attrs[] = {
>  	&dev_attr_fw_version.attr,
>  	&dev_attr_hw_version.attr,
>  	&dev_attr_product_id.attr,
>  	&dev_attr_ic_name.attr,
> +	&dev_attr_fw_name.attr,
>  	&dev_attr_update_fw.attr,
>  	NULL,
>  };
> @@ -1444,6 +1485,7 @@ static int mip4_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  
>  	ts->client = client;
>  	ts->input = input;
> +	ts->fw_name = devm_kstrdup(&client->dev, MIP4_FW_NAME, GFP_KERNEL);
>  
>  	snprintf(ts->phys, sizeof(ts->phys),
>  		 "%s/input0", dev_name(&client->dev));
> -- 
> 1.9.1
> 

-- 
Dmitry
