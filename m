From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elan_i2c - Add new ic and modify some functions
 for new IC infomation Signed-off-by: KT Liao <kt.liao@emc.com.tw>
Date: Thu, 11 May 2017 18:03:03 -0700
Message-ID: <20170512010303.GC513@dtor-ws>
References: <1479797006-2770-1-git-send-email-kt.liao@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35266 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757259AbdELBDJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 11 May 2017 21:03:09 -0400
Content-Disposition: inline
In-Reply-To: <1479797006-2770-1-git-send-email-kt.liao@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: KT Liao <ktalex.liao@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, phoenix@emc.com.tw, kt.liao@emc.com.tw

On Tue, Nov 22, 2016 at 02:43:26PM +0800, KT Liao wrote:

Applied, thank you. Sorry for the delay.

> ---
>  drivers/input/mouse/elan_i2c.h       |  6 ++-
>  drivers/input/mouse/elan_i2c_core.c  | 40 +++++++++++++------
>  drivers/input/mouse/elan_i2c_i2c.c   | 74 ++++++++++++++++++++++++++++++++----
>  drivers/input/mouse/elan_i2c_smbus.c |  9 ++++-
>  4 files changed, 108 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/input/mouse/elan_i2c.h b/drivers/input/mouse/elan_i2c.h
> index c0ec261..a1228dd 100644
> --- a/drivers/input/mouse/elan_i2c.h
> +++ b/drivers/input/mouse/elan_i2c.h
> @@ -56,9 +56,10 @@ struct elan_transport_ops {
>  	int (*get_baseline_data)(struct i2c_client *client,
>  				 bool max_baseliune, u8 *value);
>  
> -	int (*get_version)(struct i2c_client *client, bool iap, u8 *version);
> +	int (*get_version)(struct i2c_client *client,
> +			   bool iap, u8 *version);
>  	int (*get_sm_version)(struct i2c_client *client,
> -			      u8* ic_type, u8 *version);
> +			      u16 *ic_type, u8 *version);
>  	int (*get_checksum)(struct i2c_client *client, bool iap, u16 *csum);
>  	int (*get_product_id)(struct i2c_client *client, u16 *id);
>  
> @@ -82,6 +83,7 @@ struct elan_transport_ops {
>  	int (*get_report)(struct i2c_client *client, u8 *report);
>  	int (*get_pressure_adjustment)(struct i2c_client *client,
>  				       int *adjustment);
> +	int (*get_pattern)(struct i2c_client *client, u8 *pattern);
>  };
>  
>  extern const struct elan_transport_ops elan_smbus_ops, elan_i2c_ops;
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> index d15b338..818c73a 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -5,7 +5,7 @@
>   *
>   * Author: 林政維 (Duson Lin) <dusonlin@emc.com.tw>
>   * Author: KT Liao <kt.liao@emc.com.tw>
> - * Version: 1.6.2
> + * Version: 1.6.3
>   *
>   * Based on cyapa driver:
>   * copyright (c) 2011-2012 Cypress Semiconductor, Inc.
> @@ -41,7 +41,7 @@
>  #include "elan_i2c.h"
>  
>  #define DRIVER_NAME		"elan_i2c"
> -#define ELAN_DRIVER_VERSION	"1.6.2"
> +#define ELAN_DRIVER_VERSION	"1.6.3"
>  #define ELAN_VENDOR_ID		0x04f3
>  #define ETP_MAX_PRESSURE	255
>  #define ETP_FWIDTH_REDUCE	90
> @@ -78,6 +78,7 @@ struct elan_tp_data {
>  	unsigned int		x_res;
>  	unsigned int		y_res;
>  
> +	u8			pattern;
>  	u16			product_id;
>  	u8			fw_version;
>  	u8			sm_version;
> @@ -85,7 +86,7 @@ struct elan_tp_data {
>  	u16			fw_checksum;
>  	int			pressure_adjustment;
>  	u8			mode;
> -	u8			ic_type;
> +	u16			ic_type;
>  	u16			fw_validpage_count;
>  	u16			fw_signature_address;
>  
> @@ -96,10 +97,10 @@ struct elan_tp_data {
>  	bool			baseline_ready;
>  };
>  
> -static int elan_get_fwinfo(u8 iap_version, u16 *validpage_count,
> +static int elan_get_fwinfo(u16 ic_type, u16 *validpage_count,
>  			   u16 *signature_address)
>  {
> -	switch (iap_version) {
> +	switch (ic_type) {
>  	case 0x00:
>  	case 0x06:
>  	case 0x08:
> @@ -119,6 +120,9 @@ static int elan_get_fwinfo(u8 iap_version, u16 *validpage_count,
>  	case 0x0E:
>  		*validpage_count = 640;
>  		break;
> +	case 0x10:
> +		*validpage_count = 1024;
> +		break;
>  	default:
>  		/* unknown ic type clear value */
>  		*validpage_count = 0;
> @@ -209,7 +213,8 @@ static int elan_query_product(struct elan_tp_data *data)
>  		return error;
>  
>  	error = data->ops->get_sm_version(data->client, &data->ic_type,
> -					  &data->sm_version);
> +					&data->sm_version);
> +
>  	if (error)
>  		return error;
>  
> @@ -302,7 +307,7 @@ static int elan_initialize(struct elan_tp_data *data)
>  
>  static int elan_query_device_info(struct elan_tp_data *data)
>  {
> -	int error;
> +	int error, ic_type;
>  
>  	error = data->ops->get_version(data->client, false, &data->fw_version);
>  	if (error)
> @@ -317,12 +322,22 @@ static int elan_query_device_info(struct elan_tp_data *data)
>  	if (error)
>  		return error;
>  
> +
>  	error = data->ops->get_pressure_adjustment(data->client,
>  						   &data->pressure_adjustment);
>  	if (error)
>  		return error;
>  
> -	error = elan_get_fwinfo(data->iap_version, &data->fw_validpage_count,
> +	error = data->ops->get_pattern(data->client, &data->pattern);
> +	if (error)
> +		return error;
> +
> +	if (data->pattern == 0x01)
> +		ic_type = data->ic_type;
> +	else
> +		ic_type = data->iap_version;
> +
> +	error = elan_get_fwinfo(ic_type, &data->fw_validpage_count,
>  				&data->fw_signature_address);
>  	if (error)
>  		dev_warn(&data->client->dev,
> @@ -1093,7 +1108,7 @@ static int elan_probe(struct i2c_client *client,
>  	if (error)
>  		return error;
>  
> -	dev_dbg(&client->dev,
> +	dev_info(&client->dev,
>  		"Elan Touchpad Information:\n"
>  		"    Module product ID:  0x%04x\n"
>  		"    Firmware Version:  0x%04x\n"
> @@ -1101,14 +1116,17 @@ static int elan_probe(struct i2c_client *client,
>  		"    IAP Version:  0x%04x\n"
>  		"    Max ABS X,Y:   %d,%d\n"
>  		"    Width X,Y:   %d,%d\n"
> -		"    Resolution X,Y:   %d,%d (dots/mm)\n",
> +		"    Resolution X,Y:   %d,%d (dots/mm)\n"
> +		"    ic type: 0x%x\n"
> +		"    info pattern: 0x%x\n",
>  		data->product_id,
>  		data->fw_version,
>  		data->sm_version,
>  		data->iap_version,
>  		data->max_x, data->max_y,
>  		data->width_x, data->width_y,
> -		data->x_res, data->y_res);
> +		data->x_res, data->y_res,
> +		data->ic_type, data->pattern);
>  
>  	/* Set up input device properties based on queried parameters. */
>  	error = elan_setup_input_device(data);
> diff --git a/drivers/input/mouse/elan_i2c_i2c.c b/drivers/input/mouse/elan_i2c_i2c.c
> index a679e56..7e75fcd 100644
> --- a/drivers/input/mouse/elan_i2c_i2c.c
> +++ b/drivers/input/mouse/elan_i2c_i2c.c
> @@ -34,9 +34,12 @@
>  #define ETP_I2C_DESC_CMD		0x0001
>  #define ETP_I2C_REPORT_DESC_CMD		0x0002
>  #define ETP_I2C_STAND_CMD		0x0005
> +#define ETP_I2C_PATTERN_CMD		0x0100
>  #define ETP_I2C_UNIQUEID_CMD		0x0101
>  #define ETP_I2C_FW_VERSION_CMD		0x0102
> -#define ETP_I2C_SM_VERSION_CMD		0x0103
> +#define ETP_I2C_IC_TYPE_CMD		0x0103
> +#define ETP_I2C_OSM_VERSION_CMD		0x0103
> +#define ETP_I2C_NSM_VERSION_CMD		0x0104
>  #define ETP_I2C_XY_TRACENUM_CMD		0x0105
>  #define ETP_I2C_MAX_X_AXIS_CMD		0x0106
>  #define ETP_I2C_MAX_Y_AXIS_CMD		0x0107
> @@ -64,6 +67,8 @@
>  #define ETP_I2C_IAP_REG_L		0x01
>  #define ETP_I2C_IAP_REG_H		0x06
>  
> +static int elan_i2c_get_pattern(struct i2c_client *client, u8 *pattern);
> +
>  static int elan_i2c_read_block(struct i2c_client *client,
>  			       u16 reg, u8 *val, u16 len)
>  {
> @@ -243,8 +248,16 @@ static int elan_i2c_get_version(struct i2c_client *client,
>  				bool iap, u8 *version)
>  {
>  	int error;
> +	u8 pattern_ver;
>  	u8 val[3];
>  
> +	error = elan_i2c_get_pattern(client, &pattern_ver);
> +	if (error) {
> +		dev_err(&client->dev, "failed to get pattern version\n");
> +		return error;
> +	}
> +
> +
>  	error = elan_i2c_read_cmd(client,
>  				  iap ? ETP_I2C_IAP_VERSION_CMD :
>  					ETP_I2C_FW_VERSION_CMD,
> @@ -255,24 +268,54 @@ static int elan_i2c_get_version(struct i2c_client *client,
>  		return error;
>  	}
>  
> -	*version = val[0];
> +	if (pattern_ver == 0x01)
> +		*version = iap ? val[1] : val[0];
> +	else
> +		*version = val[0];
>  	return 0;
>  }
>  
>  static int elan_i2c_get_sm_version(struct i2c_client *client,
> -				   u8 *ic_type, u8 *version)
> +				   u16 *ic_type, u8 *version)
>  {
>  	int error;
> +	u8 pattern_ver;
>  	u8 val[3];
>  
> -	error = elan_i2c_read_cmd(client, ETP_I2C_SM_VERSION_CMD, val);
> +	error = elan_i2c_get_pattern(client, &pattern_ver);
>  	if (error) {
> -		dev_err(&client->dev, "failed to get SM version: %d\n", error);
> +		dev_err(&client->dev, "failed to get pattern version\n");
>  		return error;
>  	}
>  
> -	*version = val[0];
> -	*ic_type = val[1];
> +	if (pattern_ver == 0x01) {
> +		error = elan_i2c_read_cmd(client, ETP_I2C_IC_TYPE_CMD, val);
> +		if (error) {
> +			dev_err(&client->dev, "failed to get ic type: %d\n",
> +				error);
> +			return error;
> +		}
> +		*ic_type = be16_to_cpup((__be16 *)val);
> +
> +		error = elan_i2c_read_cmd(client, ETP_I2C_NSM_VERSION_CMD,
> +					  val);
> +		if (error) {
> +			dev_err(&client->dev, "failed to get SM version: %d\n",
> +				error);
> +			return error;
> +		}
> +		*version = val[1];
> +	} else {
> +		error = elan_i2c_read_cmd(client, ETP_I2C_OSM_VERSION_CMD, val);
> +		if (error) {
> +			dev_err(&client->dev, "failed to get SM version: %d\n",
> +				error);
> +			return error;
> +		}
> +		*version = val[0];
> +		*ic_type = val[1];
> +	}
> +
>  	return 0;
>  }
>  
> @@ -611,6 +654,21 @@ static int elan_i2c_get_report(struct i2c_client *client, u8 *report)
>  	return 0;
>  }
>  
> +static int elan_i2c_get_pattern(struct i2c_client *client, u8 *pattern)
> +{
> +	int error;
> +	u8 val[3];
> +
> +	error = elan_i2c_read_cmd(client, ETP_I2C_PATTERN_CMD, val);
> +	if (error) {
> +		dev_err(&client->dev, "failed to get pattern: %d\n", error);
> +		return error;
> +	}
> +	*pattern = val[1];
> +
> +	return 0;
> +}
> +
>  const struct elan_transport_ops elan_i2c_ops = {
>  	.initialize		= elan_i2c_initialize,
>  	.sleep_control		= elan_i2c_sleep_control,
> @@ -639,5 +697,7 @@ const struct elan_transport_ops elan_i2c_ops = {
>  	.write_fw_block		= elan_i2c_write_fw_block,
>  	.finish_fw_update	= elan_i2c_finish_fw_update,
>  
> +	.get_pattern		= elan_i2c_get_pattern,
> +
>  	.get_report		= elan_i2c_get_report,
>  };
> diff --git a/drivers/input/mouse/elan_i2c_smbus.c b/drivers/input/mouse/elan_i2c_smbus.c
> index e23b249..df7a57c 100644
> --- a/drivers/input/mouse/elan_i2c_smbus.c
> +++ b/drivers/input/mouse/elan_i2c_smbus.c
> @@ -166,7 +166,7 @@ static int elan_smbus_get_version(struct i2c_client *client,
>  }
>  
>  static int elan_smbus_get_sm_version(struct i2c_client *client,
> -				     u8 *ic_type, u8 *version)
> +				     u16 *ic_type, u8 *version)
>  {
>  	int error;
>  	u8 val[3];
> @@ -495,6 +495,12 @@ static int elan_smbus_finish_fw_update(struct i2c_client *client,
>  	return 0;
>  }
>  
> +static int elan_smbus_get_pattern(struct i2c_client *client, u8 *pattern)
> +{
> +	*pattern = 0;
> +	return 0;
> +}
> +
>  const struct elan_transport_ops elan_smbus_ops = {
>  	.initialize		= elan_smbus_initialize,
>  	.sleep_control		= elan_smbus_sleep_control,
> @@ -524,4 +530,5 @@ const struct elan_transport_ops elan_smbus_ops = {
>  	.finish_fw_update	= elan_smbus_finish_fw_update,
>  
>  	.get_report		= elan_smbus_get_report,
> +	.get_pattern		= elan_smbus_get_pattern,
>  };
> -- 
> 2.7.4
> 

-- 
Dmitry
