From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Input: melfas_mip4 - use product id for firmware name
Date: Wed, 26 Oct 2016 15:54:47 -0700
Message-ID: <20161026225447.GC27930@dtor-ws>
References: <1477464684-5848-1-git-send-email-jeesw@melfas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33494 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933396AbcJZWy6 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 26 Oct 2016 18:54:58 -0400
Received: by mail-pf0-f193.google.com with SMTP id i85so663630pfa.0
        for <linux-input@vger.kernel.org>; Wed, 26 Oct 2016 15:54:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1477464684-5848-1-git-send-email-jeesw@melfas.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sangwon Jee <jeesw@melfas.com>
Cc: linux-input@vger.kernel.org

On Wed, Oct 26, 2016 at 03:51:24PM +0900, Sangwon Jee wrote:
> Use product id for firmware name to request compatible firmware.
> 
> Signed-off-by: Sangwon Jee <jeesw@melfas.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/melfas_mip4.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/melfas_mip4.c b/drivers/input/touchscreen/melfas_mip4.c
> index 8739cb7..0f2230a 100644
> --- a/drivers/input/touchscreen/melfas_mip4.c
> +++ b/drivers/input/touchscreen/melfas_mip4.c
> @@ -162,6 +162,7 @@ struct mip4_ts {
>  	char product_name[16];
>  	u16 product_id;
>  	char ic_name[4];
> +	char fw_name[32];
>  
>  	unsigned int max_x;
>  	unsigned int max_y;
> @@ -280,6 +281,11 @@ static int mip4_query_device(struct mip4_ts *ts)
>  		dev_dbg(&ts->client->dev, "product id: %04X\n", ts->product_id);
>  	}
>  
> +	/* Firmware name */
> +	snprintf(ts->fw_name, sizeof(ts->fw_name),
> +		"melfas_mip4_%04X.fw", ts->product_id);
> +	dev_dbg(&ts->client->dev, "firmware name: %s\n", ts->fw_name);
> +
>  	/* IC name */
>  	cmd[0] = MIP4_R0_INFO;
>  	cmd[1] = MIP4_R1_INFO_IC_NAME;
> @@ -1285,11 +1291,11 @@ static ssize_t mip4_sysfs_fw_update(struct device *dev,
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
> @@ -1608,6 +1614,6 @@ static struct i2c_driver mip4_driver = {
>  module_i2c_driver(mip4_driver);
>  
>  MODULE_DESCRIPTION("MELFAS MIP4 Touchscreen");
> -MODULE_VERSION("2016.10.20");
> +MODULE_VERSION("2016.10.24");
>  MODULE_AUTHOR("Sangwon Jee <jeesw@melfas.com>");
>  MODULE_LICENSE("GPL");
> -- 
> 1.9.1
> 

-- 
Dmitry
