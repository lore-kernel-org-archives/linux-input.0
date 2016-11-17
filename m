From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elan_i2c - Add new ic and modify some functions
 for new IC infomation Signed-off-by: KT Liao <kt.liao@emc.com.tw>
Date: Thu, 17 Nov 2016 09:15:24 -0800
Message-ID: <20161117171524.GA40773@dtor-ws>
References: <1479383263-34546-1-git-send-email-kt.liao@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34680 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933271AbcKQRPc (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 17 Nov 2016 12:15:32 -0500
Content-Disposition: inline
In-Reply-To: <1479383263-34546-1-git-send-email-kt.liao@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: KT Liao <ktalex.liao@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, phoenix@emc.com.tw, kt.liao@emc.com.tw

Hi KT,

On Thu, Nov 17, 2016 at 07:47:43PM +0800, KT Liao wrote:
> ---
>  drivers/input/mouse/elan_i2c.h       |  6 ++--
>  drivers/input/mouse/elan_i2c_core.c  | 46 ++++++++++++++++++--------
>  drivers/input/mouse/elan_i2c_i2c.c   | 63 ++++++++++++++++++++++++++++++------
>  drivers/input/mouse/elan_i2c_smbus.c | 11 +++++--
>  4 files changed, 99 insertions(+), 27 deletions(-)
>  mode change 100644 => 100755 drivers/input/mouse/elan_i2c.h
>  mode change 100644 => 100755 drivers/input/mouse/elan_i2c_core.c
>  mode change 100644 => 100755 drivers/input/mouse/elan_i2c_i2c.c
>  mode change 100644 => 100755 drivers/input/mouse/elan_i2c_smbus.c

Why are you changing mode on the files?

> 
> diff --git a/drivers/input/mouse/elan_i2c.h b/drivers/input/mouse/elan_i2c.h
> old mode 100644
> new mode 100755
> index c0ec261..a90df14
> --- a/drivers/input/mouse/elan_i2c.h
> +++ b/drivers/input/mouse/elan_i2c.h
> @@ -56,9 +56,10 @@ struct elan_transport_ops {
>  	int (*get_baseline_data)(struct i2c_client *client,
>  				 bool max_baseliune, u8 *value);
>  
> -	int (*get_version)(struct i2c_client *client, bool iap, u8 *version);
> +	int (*get_version)(struct i2c_client *client,
> +			   bool iap, u8 *version, u8 pattern);
>  	int (*get_sm_version)(struct i2c_client *client,
> -			      u8* ic_type, u8 *version);
> +			      u16 *ic_type, u8 *version, u8 pattern);
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
> old mode 100644
> new mode 100755
> index d15b338..bb0c832
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
> @@ -204,12 +208,17 @@ static int elan_query_product(struct elan_tp_data *data)
>  {
>  	int error;
>  
> +	error = data->ops->get_pattern(data->client, &data->pattern);
> +	if (error)
> +		return error;
> +
>  	error = data->ops->get_product_id(data->client, &data->product_id);
>  	if (error)
>  		return error;
>  
>  	error = data->ops->get_sm_version(data->client, &data->ic_type,
> -					  &data->sm_version);
> +					&data->sm_version, data->pattern);
> +
>  	if (error)
>  		return error;
>  
> @@ -302,9 +311,10 @@ static int elan_initialize(struct elan_tp_data *data)
>  
>  static int elan_query_device_info(struct elan_tp_data *data)
>  {
> -	int error;
> +	int error, ic_type;
>  
> -	error = data->ops->get_version(data->client, false, &data->fw_version);
> +	error = data->ops->get_version(data->client, false, &data->fw_version,
> +			       data->pattern);
>  	if (error)
>  		return error;
>  
> @@ -313,16 +323,23 @@ static int elan_query_device_info(struct elan_tp_data *data)
>  	if (error)
>  		return error;
>  
> -	error = data->ops->get_version(data->client, true, &data->iap_version);
> +	error = data->ops->get_version(data->client, true, &data->iap_version,
> +				       data->pattern);
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
> +	if (data->pattern == 0x01)
> +		ic_type = data->ic_type;
> +	else
> +		ic_type = data->iap_version;
> +
> +	error = elan_get_fwinfo(ic_type, &data->fw_validpage_count,
>  				&data->fw_signature_address);
>  	if (error)
>  		dev_warn(&data->client->dev,
> @@ -1093,7 +1110,7 @@ static int elan_probe(struct i2c_client *client,
>  	if (error)
>  		return error;
>  
> -	dev_dbg(&client->dev,
> +	dev_info(&client->dev,
>  		"Elan Touchpad Information:\n"
>  		"    Module product ID:  0x%04x\n"
>  		"    Firmware Version:  0x%04x\n"
> @@ -1101,14 +1118,17 @@ static int elan_probe(struct i2c_client *client,
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
> old mode 100644
> new mode 100755
> index a679e56..c108589
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
> @@ -240,7 +243,7 @@ static int elan_i2c_get_baseline_data(struct i2c_client *client,
>  }
>  
>  static int elan_i2c_get_version(struct i2c_client *client,
> -				bool iap, u8 *version)
> +				bool iap, u8 *version, u8 pattern)
>  {
>  	int error;
>  	u8 val[3];
> @@ -255,24 +258,47 @@ static int elan_i2c_get_version(struct i2c_client *client,
>  		return error;
>  	}
>  
> -	*version = val[0];
> +	if (pattern == 0x01)
> +		*version = iap ? val[1] : val[0];
> +	else
> +		*version = val[0];
>  	return 0;
>  }
>  
>  static int elan_i2c_get_sm_version(struct i2c_client *client,
> -				   u8 *ic_type, u8 *version)
> +				   u16 *ic_type, u8 *version, u8 pattern)
>  {
>  	int error;
>  	u8 val[3];
>  
> -	error = elan_i2c_read_cmd(client, ETP_I2C_SM_VERSION_CMD, val);
> -	if (error) {
> -		dev_err(&client->dev, "failed to get SM version: %d\n", error);
> -		return error;
> +	if (pattern == 0x01) {
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
>  	}
>  
> -	*version = val[0];
> -	*ic_type = val[1];
>  	return 0;
>  }
>  
> @@ -611,6 +637,21 @@ static int elan_i2c_get_report(struct i2c_client *client, u8 *report)
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

Is the pattern command available on all firmware versions?

Also, instead of plumbing whole parrent thing, maybe it would be easier
to read it twice, once in elan_i2c_get_version and another in
elan_i2c_get_sm_version?

Thanks.

-- 
Dmitry
