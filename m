From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Input: melfas_mip4 - add resolution reporting
Date: Fri, 11 Mar 2016 10:06:56 -0800
Message-ID: <20160311180656.GB13175@dtor-ws>
References: <1457078101-3190-1-git-send-email-jeesw@melfas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36541 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbcCKSG7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Mar 2016 13:06:59 -0500
Received: by mail-pa0-f53.google.com with SMTP id tt10so105255037pab.3
        for <linux-input@vger.kernel.org>; Fri, 11 Mar 2016 10:06:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1457078101-3190-1-git-send-email-jeesw@melfas.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sangwon Jee <jeesw@melfas.com>
Cc: linux-input@vger.kernel.org

On Fri, Mar 04, 2016 at 04:55:01PM +0900, Sangwon Jee wrote:
> Add resolution(pixels per mm) value registers and resolution reporting 
> by input_abs_set_res.
> 
> Signed-off-by: Sangwon Jee <jeesw@melfas.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/melfas_mip4.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/melfas_mip4.c b/drivers/input/touchscreen/melfas_mip4.c
> index b8e9ead..2a879e4b 100644
> --- a/drivers/input/touchscreen/melfas_mip4.c
> +++ b/drivers/input/touchscreen/melfas_mip4.c
> @@ -33,7 +33,7 @@
>  
>  /*****************************************************************
>   * Protocol
> - * Version : MIP 4.0 Rev 4.4
> + * Version : MIP 4.0 Rev 4.6
>   *****************************************************************/
>  
>  /* Address */
> @@ -52,6 +52,11 @@
>  #define MIP4_R1_INFO_NODE_NUM_X			0x14
>  #define MIP4_R1_INFO_NODE_NUM_Y			0x15
>  #define MIP4_R1_INFO_KEY_NUM			0x16
> +#define MIP4_R1_INFO_PRESSURE_NUM		0x17
> +#define MIP4_R1_INFO_LENGTH_X			0x18
> +#define MIP4_R1_INFO_LENGTH_Y			0x1A
> +#define MIP4_R1_INFO_PPM_X				0x1C
> +#define MIP4_R1_INFO_PPM_Y				0x1D
>  #define MIP4_R1_INFO_VERSION_BOOT		0x20
>  #define MIP4_R1_INFO_VERSION_CORE		0x22
>  #define MIP4_R1_INFO_VERSION_APP		0x24
> @@ -158,6 +163,8 @@ struct mip4_ts {
>  	u8 node_x;
>  	u8 node_y;
>  	u8 node_key;
> +	unsigned int ppm_x;
> +	unsigned int ppm_y;
>  
>  	struct mip4_fw_version fw_version;
>  
> @@ -242,7 +249,7 @@ static int mip4_query_device(struct mip4_ts *ts)
>  {
>  	int error;
>  	u8 cmd[2];
> -	u8 buf[8];
> +	u8 buf[14];
>  
>  	/* Product name */
>  	cmd[0] = MIP4_R0_INFO;
> @@ -269,7 +276,7 @@ static int mip4_query_device(struct mip4_ts *ts)
>  	/* Resolution */
>  	cmd[0] = MIP4_R0_INFO;
>  	cmd[1] = MIP4_R1_INFO_RESOLUTION_X;
> -	error = mip4_i2c_xfer(ts, cmd, sizeof(cmd), buf, 7);
> +	error = mip4_i2c_xfer(ts, cmd, sizeof(cmd), buf, 14);
>  	if (error) {
>  		dev_warn(&ts->client->dev,
>  			 "Failed to retrieve touchscreen parameters: %d\n",
> @@ -287,6 +294,11 @@ static int mip4_query_device(struct mip4_ts *ts)
>  			"node_x: %d, node_y: %d, node_key: %d\n",
>  			ts->node_x, ts->node_y, ts->node_key);
>  
> +		ts->ppm_x = buf[12];
> +		ts->ppm_y = buf[13];
> +		dev_dbg(&ts->client->dev, "ppm_x: %d, ppm_y: %d\n",
> +			ts->ppm_x, ts->ppm_y);
> +
>  		/* Key ts */
>  		if (ts->node_key > 0)
>  			ts->key_num = ts->node_key;
> @@ -1095,6 +1107,10 @@ exit_bl:
>  	input_set_abs_params(ts->input, ABS_MT_POSITION_Y, 0, ts->max_y, 0, 0);
>  	input_set_abs_params(ts->input, ABS_X, 0, ts->max_x, 0, 0);
>  	input_set_abs_params(ts->input, ABS_Y, 0, ts->max_y, 0, 0);
> +	input_abs_set_res(ts->input, ABS_MT_POSITION_X, ts->ppm_x);
> +	input_abs_set_res(ts->input, ABS_MT_POSITION_Y, ts->ppm_y);
> +	input_abs_set_res(ts->input, ABS_X, ts->ppm_x);
> +	input_abs_set_res(ts->input, ABS_Y, ts->ppm_y);
>  
>  	return error ? error : 0;
>  }
> @@ -1377,6 +1393,8 @@ static int mip4_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  			     MIP4_TOUCH_MAJOR_MIN, MIP4_TOUCH_MAJOR_MAX, 0, 0);
>  	input_set_abs_params(input, ABS_MT_TOUCH_MINOR,
>  			     MIP4_TOUCH_MINOR_MIN, MIP4_TOUCH_MINOR_MAX, 0, 0);
> +	input_abs_set_res(ts->input, ABS_MT_POSITION_X, ts->ppm_x);
> +	input_abs_set_res(ts->input, ABS_MT_POSITION_Y, ts->ppm_y);
>  
>  	error = input_mt_init_slots(input, MIP4_MAX_FINGERS, INPUT_MT_DIRECT);
>  	if (error)
> @@ -1494,6 +1512,6 @@ static struct i2c_driver mip4_driver = {
>  module_i2c_driver(mip4_driver);
>  
>  MODULE_DESCRIPTION("MELFAS MIP4 Touchscreen");
> -MODULE_VERSION("2016.01.13");
> +MODULE_VERSION("2016.03.03");
>  MODULE_AUTHOR("Sangwon Jee <jeesw@melfas.com>");
>  MODULE_LICENSE("GPL");
> -- 
> 1.9.1
> 

-- 
Dmitry
