From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH resend v4] Input: silead - Add support for capactive home
 button found on some x86 tablets
Date: Tue, 9 Jan 2018 11:41:25 -0800
Message-ID: <20180109194125.vu5rlikoww3fesfj@dtor-ws>
References: <20180109143054.20963-1-hdegoede@redhat.com>
 <20180109143054.20963-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38742 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754849AbeAITl3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 9 Jan 2018 14:41:29 -0500
Received: by mail-pf0-f195.google.com with SMTP id k19so2242643pfj.5
        for <linux-input@vger.kernel.org>; Tue, 09 Jan 2018 11:41:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20180109143054.20963-2-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>

On Tue, Jan 09, 2018 at 03:30:54PM +0100, Hans de Goede wrote:
> On some x86 tablets with a silead touchscreen the windows logo on the
> front is a capacitive home button. Touching this button results in a touch
> with bits 12-15 of the Y coordinates set, while normally only the lower 12
> are used.
> 
> Detect this and report a KEY_LEFTMETA press when this happens. Note for
> now we only respond to the Y coordinate bits 12-15 containing 0x01, on some
> tablets *without* a capacative button I've noticed these bits containing
> 0x04 when crossing the edges of the screen.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thank you.

> ---
> Changes in v2:
> -Only enable support for the home-button if a "silead,home-button"
>  boolean device-property is set on the device
> 
> Changes in v3:
> -Document the new silead,home-button property in:
>  Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> 
> Changes in v4:
> -Add Rob's Acked-by for the DT binding
> ---
>  .../bindings/input/touchscreen/silead_gsl1680.txt  |  2 +
>  drivers/input/touchscreen/silead.c                 | 46 ++++++++++++++++------
>  2 files changed, 37 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt b/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
> index 6aa625e0cb8d..84752de12412 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
> @@ -23,6 +23,8 @@ Optional properties:
>  - touchscreen-inverted-y  : See touchscreen.txt
>  - touchscreen-swapped-x-y : See touchscreen.txt
>  - silead,max-fingers	  : maximum number of fingers the touchscreen can detect
> +- silead,home-button	  : Boolean, set to true on devices which have a
> +			    capacitive home-button build into the touchscreen
>  - vddio-supply		  : regulator phandle for controller VDDIO
>  - avdd-supply		  : regulator phandle for controller AVDD
>  
> diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
> index 531f22891462..ff7043f74a3d 100644
> --- a/drivers/input/touchscreen/silead.c
> +++ b/drivers/input/touchscreen/silead.c
> @@ -56,7 +56,7 @@
>  #define SILEAD_POINT_Y_MSB_OFF	0x01
>  #define SILEAD_POINT_X_OFF	0x02
>  #define SILEAD_POINT_X_MSB_OFF	0x03
> -#define SILEAD_TOUCH_ID_MASK	0xF0
> +#define SILEAD_EXTRA_DATA_MASK	0xF0
>  
>  #define SILEAD_CMD_SLEEP_MIN	10000
>  #define SILEAD_CMD_SLEEP_MAX	20000
> @@ -109,6 +109,9 @@ static int silead_ts_request_input_dev(struct silead_ts_data *data)
>  			    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED |
>  			    INPUT_MT_TRACK);
>  
> +	if (device_property_read_bool(dev, "silead,home-button"))
> +		input_set_capability(data->input, EV_KEY, KEY_LEFTMETA);
> +
>  	data->input->name = SILEAD_TS_NAME;
>  	data->input->phys = "input/ts";
>  	data->input->id.bustype = BUS_I2C;
> @@ -139,7 +142,8 @@ static void silead_ts_read_data(struct i2c_client *client)
>  	struct input_dev *input = data->input;
>  	struct device *dev = &client->dev;
>  	u8 *bufp, buf[SILEAD_TS_DATA_LEN];
> -	int touch_nr, error, i;
> +	int touch_nr, softbutton, error, i;
> +	bool softbutton_pressed = false;
>  
>  	error = i2c_smbus_read_i2c_block_data(client, SILEAD_REG_DATA,
>  					      SILEAD_TS_DATA_LEN, buf);
> @@ -148,21 +152,40 @@ static void silead_ts_read_data(struct i2c_client *client)
>  		return;
>  	}
>  
> -	touch_nr = buf[0];
> -	if (touch_nr > data->max_fingers) {
> +	if (buf[0] > data->max_fingers) {
>  		dev_warn(dev, "More touches reported then supported %d > %d\n",
> -			 touch_nr, data->max_fingers);
> -		touch_nr = data->max_fingers;
> +			 buf[0], data->max_fingers);
> +		buf[0] = data->max_fingers;
>  	}
>  
> +	touch_nr = 0;
>  	bufp = buf + SILEAD_POINT_DATA_LEN;
> -	for (i = 0; i < touch_nr; i++, bufp += SILEAD_POINT_DATA_LEN) {
> -		/* Bits 4-7 are the touch id */
> -		data->id[i] = (bufp[SILEAD_POINT_X_MSB_OFF] &
> -			       SILEAD_TOUCH_ID_MASK) >> 4;
> -		touchscreen_set_mt_pos(&data->pos[i], &data->prop,
> +	for (i = 0; i < buf[0]; i++, bufp += SILEAD_POINT_DATA_LEN) {
> +		softbutton = (bufp[SILEAD_POINT_Y_MSB_OFF] &
> +			      SILEAD_EXTRA_DATA_MASK) >> 4;
> +
> +		if (softbutton) {
> +			/*
> +			 * For now only respond to softbutton == 0x01, some
> +			 * tablets *without* a capacative button send 0x04
> +			 * when crossing the edges of the screen.
> +			 */
> +			if (softbutton == 0x01)
> +				softbutton_pressed = true;
> +
> +			continue;
> +		}
> +
> +		/*
> +		 * Bits 4-7 are the touch id, note not all models have
> +		 * hardware touch ids so atm we don't use these.
> +		 */
> +		data->id[touch_nr] = (bufp[SILEAD_POINT_X_MSB_OFF] &
> +				      SILEAD_EXTRA_DATA_MASK) >> 4;
> +		touchscreen_set_mt_pos(&data->pos[touch_nr], &data->prop,
>  			get_unaligned_le16(&bufp[SILEAD_POINT_X_OFF]) & 0xfff,
>  			get_unaligned_le16(&bufp[SILEAD_POINT_Y_OFF]) & 0xfff);
> +		touch_nr++;
>  	}
>  
>  	input_mt_assign_slots(input, data->slots, data->pos, touch_nr, 0);
> @@ -178,6 +201,7 @@ static void silead_ts_read_data(struct i2c_client *client)
>  	}
>  
>  	input_mt_sync_frame(input);
> +	input_report_key(input, KEY_LEFTMETA, softbutton_pressed);
>  	input_sync(input);
>  }
>  
> -- 
> 2.14.3
> 

-- 
Dmitry
