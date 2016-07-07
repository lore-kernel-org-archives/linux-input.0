From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] [v1.1 1/3] driver: input :touchscreen : add Raydium crc
 touch function
Date: Thu, 7 Jul 2016 10:12:04 -0700
Message-ID: <20160707171204.GI5447@dtor-ws>
References: <1467909479-43471-1-git-send-email-jeffrey.lin@rad-ic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35044 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753336AbcGGRMI (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jul 2016 13:12:08 -0400
Content-Disposition: inline
In-Reply-To: <1467909479-43471-1-git-send-email-jeffrey.lin@rad-ic.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "jeffrey.lin" <yajohn@gmail.com>
Cc: rydberg@euromail.se, groeck@chromium.org, robh@kernel.org, jeffrey.lin@rad-ic.com, ealin.chiu@rad-ic.com, jason.yeh@rad-ic.com, KP.li@rad-ic.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Thu, Jul 07, 2016 at 09:37:59AM -0700, jeffrey.lin wrote:
> add checksum for touch report points.
> 
> Signed-off-by: jeffrey.lin <jeffrey.lin@rad-ic.com>
> ---
>  drivers/input/touchscreen/raydium_i2c_ts.c | 86 +++++++++++++++++++-----------
>  1 file changed, 56 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
> index f3076d9..de31b41 100644
> --- a/drivers/input/touchscreen/raydium_i2c_ts.c
> +++ b/drivers/input/touchscreen/raydium_i2c_ts.c
> @@ -70,6 +70,8 @@
>  #define RM_CONTACT_WIDTH_X_POS	6
>  #define RM_CONTACT_WIDTH_Y_POS	7
>  
> +#define RM_CONTACT_CRC_OFFSET	2

This is not offset, this is size, or length, of CRC.

> +
>  /* Bootloader relative info */
>  #define RM_BL_WRT_CMD_SIZE	3	/* bl flash wrt cmd size */
>  #define RM_BL_WRT_PKG_SIZE	32	/* bl wrt pkg size */
> @@ -137,6 +139,7 @@ struct raydium_data {
>  	u32 data_bank_addr;
>  	u8 report_size;
>  	u8 contact_size;
> +	u8 pkg_size;
>  
>  	enum raydium_boot_mode boot_mode;
>  
> @@ -280,12 +283,14 @@ static int raydium_i2c_query_ts_info(struct raydium_data *ts)
>  		 * then the size changed (due to firmware update?) and keep
>  		 * old size instead.
>  		 */
> -		if (ts->report_data && ts->report_size != data_info.pkg_size)
> +		if (ts->report_data && ts->pkg_size != data_info.pkg_size)
>  			dev_warn(&client->dev,
>  				 "report size changes, was: %d, new: %d\n",
> -				 ts->report_size, data_info.pkg_size);
> -		else
> -			ts->report_size = data_info.pkg_size;
> +				 ts->pkg_size, data_info.pkg_size);
> +		else {
> +			ts->pkg_size = data_info.pkg_size;
> +			ts->report_size = ts->pkg_size - RM_CONTACT_CRC_OFFSET;
> +		}
>  
>  		ts->contact_size = data_info.tp_info_size;
>  		ts->data_bank_addr = le32_to_cpu(data_info.data_bank_addr);
> @@ -612,6 +617,17 @@ static int raydium_i2c_fw_write_page(struct i2c_client *client,
>  	return error;
>  }
>  
> +static u16 raydium_calc_chksum(const u8 *buf, u16 len)
> +{
> +	u16 checksum = 0;
> +	u16 i;
> +
> +	for (i = 0; i < len; i++)
> +		checksum += buf[i];
> +
> +	return checksum;
> +}
> +
>  static int raydium_i2c_do_update_firmware(struct raydium_data *ts,
>  					 const struct firmware *fw)
>  {
> @@ -724,9 +740,7 @@ static int raydium_i2c_do_update_firmware(struct raydium_data *ts,
>  		return error;
>  	}
>  
> -	fw_checksum = 0;
> -	for (i = 0; i < fw->size; i++)
> -		fw_checksum += fw->data[i];
> +	fw_checksum = raydium_calc_chksum(fw->data, fw->size);
>  
>  	error = raydium_i2c_write_checksum(client, fw->size, fw_checksum);
>  	if (error)
> @@ -780,15 +794,6 @@ out_enable_irq:
>  static void raydium_mt_event(struct raydium_data *ts)
>  {
>  	int i;
> -	int error;
> -
> -	error = raydium_i2c_read_message(ts->client, ts->data_bank_addr,
> -					 ts->report_data, ts->report_size);
> -	if (error) {
> -		dev_err(&ts->client->dev, "%s: failed to read data: %d\n",
> -			__func__, error);
> -		return;
> -	}
>  
>  	for (i = 0; i < ts->report_size / ts->contact_size; i++) {
>  		u8 *contact = &ts->report_data[ts->contact_size * i];
> @@ -798,33 +803,54 @@ static void raydium_mt_event(struct raydium_data *ts)
>  		input_mt_slot(ts->input, i);
>  		input_mt_report_slot_state(ts->input, MT_TOOL_FINGER, state);
>  
> -		if (!state)
> -			continue;
> -
> -		input_report_abs(ts->input, ABS_MT_POSITION_X,
> +		if (state == 0x01) {

Why we need this change? How is it related to CRC? Do you intent to
report contact as active but not emit any position data of state is
neither 0 nor 1?

> +			input_report_abs(ts->input, ABS_MT_POSITION_X,
>  				get_unaligned_le16(&contact[RM_CONTACT_X_POS]));
> -		input_report_abs(ts->input, ABS_MT_POSITION_Y,
> +			input_report_abs(ts->input, ABS_MT_POSITION_Y,
>  				get_unaligned_le16(&contact[RM_CONTACT_Y_POS]));
> -		input_report_abs(ts->input, ABS_MT_PRESSURE,
> -				contact[RM_CONTACT_PRESSURE_POS]);
> +			input_report_abs(ts->input, ABS_MT_PRESSURE,
> +					contact[RM_CONTACT_PRESSURE_POS]);
>  
> -		wx = contact[RM_CONTACT_WIDTH_X_POS];
> -		wy = contact[RM_CONTACT_WIDTH_Y_POS];
> +			wx = contact[RM_CONTACT_WIDTH_X_POS];
> +			wy = contact[RM_CONTACT_WIDTH_Y_POS];
>  
> -		input_report_abs(ts->input, ABS_MT_TOUCH_MAJOR, max(wx, wy));
> -		input_report_abs(ts->input, ABS_MT_TOUCH_MINOR, min(wx, wy));
> +			input_report_abs(ts->input, ABS_MT_TOUCH_MAJOR,
> +				max(wx, wy));
> +			input_report_abs(ts->input, ABS_MT_TOUCH_MINOR,
> +				min(wx, wy));
> +		}
>  	}
>  
>  	input_mt_sync_frame(ts->input);
>  	input_sync(ts->input);
>  }
>  
> +static void raydium_i2c_event(struct raydium_data *ts)
> +{
> +	u16 fw_crc;
> +	u16 calc_crc = raydium_calc_chksum(ts->report_data, ts->report_size);
> +
> +	fw_crc = get_unaligned_le16(&ts->report_data[ts->report_size]);
> +
> +	if (unlikely(fw_crc != calc_crc))
> +		dev_warn(&ts->client->dev,
> +			 "%s: invalid packet crc %04x &. %04x\n",
> +			 __func__, calc_crc, fw_crc);
> +	else
> +		raydium_mt_event(ts);
> +}
> +
>  static irqreturn_t raydium_i2c_irq(int irq, void *_dev)
>  {
>  	struct raydium_data *ts = _dev;
> +	int error;
>  
> -	if (ts->boot_mode != RAYDIUM_TS_BLDR)
> -		raydium_mt_event(ts);
> +	if (ts->boot_mode == RAYDIUM_TS_MAIN) {
> +		error = raydium_i2c_read_message(ts->client, ts->data_bank_addr,
> +				 ts->report_data, ts->pkg_size);
> +		if (!error)
> +			raydium_i2c_event(ts);
> +	}

This chunk seems to belong to some other patch.

>  
>  	return IRQ_HANDLED;
>  }
> @@ -1050,7 +1076,7 @@ static int raydium_i2c_probe(struct i2c_client *client,
>  	}
>  
>  	ts->report_data = devm_kmalloc(&client->dev,
> -				       ts->report_size, GFP_KERNEL);
> +				       ts->pkg_size, GFP_KERNEL);
>  	if (!ts->report_data)
>  		return -ENOMEM;
>  
> -- 
> 2.1.2
> 

Thanks.

-- 
Dmitry
