From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: atmel_mxt_ts - Implement support for T100
 touch object
Date: Mon, 6 Apr 2015 13:10:13 -0700
Message-ID: <20150406201013.GB36776@dtor-ws>
References: <1426600846-13346-1-git-send-email-javier.martinez@collabora.co.uk>
 <1426600846-13346-2-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426600846-13346-2-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Henrik Rydberg <rydberg@euromail.se>, Nick Dyer <nick.dyer@itdev.co.uk>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, Yufeng Shen <miletus@chromium.org>, Benson Leung <bleung@chromium.org>, Chung-yih Wang <cywang@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Javier,

On Tue, Mar 17, 2015 at 03:00:45PM +0100, Javier Martinez Canillas wrote:
> From: Nick Dyer <nick.dyer@itdev.co.uk>
> 
> Add support for the new T100 object which replaces the previous
> T9 multitouch touchscreen object in recent maXTouch devices.
> T100 provides improved reporting with selectable auxiliary
> information, and a type field for hover/stylus/glove reporting.
> 
> The hovering finger support was based on Chung-Yih's work in
> the ChromiumOS downstream kernel:
> 
> https://chromium-review.googlesource.com/#/c/219280/
> 
> Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
> Acked-by: Yufeng Shen <miletus@chromium.org>
> [javier: Factor out T9 and T100 init functions and rework hover support]
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 323 +++++++++++++++++++++++++++++--
>  1 file changed, 302 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 95ee92a91bd2..749371761669 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -79,6 +79,7 @@
>  #define MXT_SPT_DIGITIZER_T43		43
>  #define MXT_SPT_MESSAGECOUNT_T44	44
>  #define MXT_SPT_CTECONFIG_T46		46
> +#define MXT_TOUCH_MULTITOUCHSCREEN_T100 100
>  
>  /* MXT_GEN_MESSAGE_T5 object */
>  #define MXT_RPTID_NOMSG		0xff
> @@ -185,6 +186,36 @@ struct t9_range {
>  #define MXT_RESET_VALUE		0x01
>  #define MXT_BACKUP_VALUE	0x55
>  
> +/* T100 Multiple Touch Touchscreen */
> +#define MXT_T100_CTRL		0
> +#define MXT_T100_CFG1		1
> +#define MXT_T100_TCHAUX		3
> +#define MXT_T100_XRANGE		13
> +#define MXT_T100_YRANGE		24
> +
> +#define MXT_T100_CFG_SWITCHXY	(1 << 5)
> +
> +#define MXT_T100_TCHAUX_VECT	(1 << 0)
> +#define MXT_T100_TCHAUX_AMPL	(1 << 1)
> +#define MXT_T100_TCHAUX_AREA	(1 << 2)
> +
> +#define MXT_T100_DETECT		(1 << 7)

I'll change these to BIT(x).

> +#define MXT_T100_TYPE_MASK	0x70
> +
> +enum t100_type {
> +	MXT_T100_TYPE_FINGER		= 1,
> +	MXT_T100_TYPE_PASSIVE_STYLUS	= 2,
> +	MXT_T100_TYPE_HOVERING_FINGER	= 4,
> +	MXT_T100_TYPE_GLOVE		= 5,
> +	MXT_T100_TYPE_LARGE_TOUCH	= 6,
> +};
> +
> +#define MXT_DISTANCE_ACTIVE_TOUCH	0
> +#define MXT_DISTANCE_HOVERING		1
> +
> +#define MXT_TOUCH_MAJOR_DEFAULT	1
> +#define MXT_PRESSURE_DEFAULT	1
> +
>  /* Delay times */
>  #define MXT_BACKUP_TIME		50	/* msec */
>  #define MXT_RESET_TIME		200	/* msec */
> @@ -244,6 +275,9 @@ struct mxt_data {
>  	unsigned int max_y;
>  	bool in_bootloader;
>  	u16 mem_size;
> +	u8 t100_aux_ampl;
> +	u8 t100_aux_area;
> +	u8 t100_aux_vect;
>  	u8 max_reportid;
>  	u32 config_crc;
>  	u32 info_crc;
> @@ -253,6 +287,7 @@ struct mxt_data {
>  	bool update_input;
>  	u8 last_message_count;
>  	u8 num_touchids;
> +	u8 multitouch;
>  
>  	/* Cached parameters from object table */
>  	u16 T5_address;
> @@ -264,6 +299,8 @@ struct mxt_data {
>  	u8 T9_reportid_max;
>  	u8 T19_reportid;
>  	u16 T44_address;
> +	u8 T100_reportid_min;
> +	u8 T100_reportid_max;
>  
>  	/* for fw update in bootloader */
>  	struct completion bl_completion;
> @@ -771,6 +808,108 @@ static void mxt_proc_t9_message(struct mxt_data *data, u8 *message)
>  	data->update_input = true;
>  }
>  
> +static void mxt_proc_t100_message(struct mxt_data *data, u8 *message)
> +{
> +	struct device *dev = &data->client->dev;
> +	struct input_dev *input_dev = data->input_dev;
> +	int id;
> +	u8 status;
> +	u8 type = 0;
> +	int x;
> +	int y;
> +	int distance = 0;
> +	int tool = 0;
> +	u8 major = 0;
> +	u8 pressure = 0;
> +	u8 orientation = 0;
> +
> +	id = message[0] - data->T100_reportid_min - 2;
> +
> +	/* ignore SCRSTATUS events */
> +	if (id < 0)
> +		return;
> +
> +	status = message[1];
> +	x = (message[3] << 8) | message[2];
> +	y = (message[5] << 8) | message[4];

This looks like job for get_unaligned_le16().

> +
> +	if (status & MXT_T100_DETECT) {
> +		type = (status & MXT_T100_TYPE_MASK) >> 4;
> +
> +		switch (type) {
> +		case MXT_T100_TYPE_HOVERING_FINGER:
> +			tool = MT_TOOL_FINGER;
> +			distance = MXT_DISTANCE_HOVERING;
> +
> +			if (data->t100_aux_vect)
> +				orientation = message[data->t100_aux_vect];
> +
> +			break;
> +		case MXT_T100_TYPE_FINGER:
> +		case MXT_T100_TYPE_GLOVE:
> +			tool = MT_TOOL_FINGER;
> +			distance = MXT_DISTANCE_ACTIVE_TOUCH;
> +
> +			if (data->t100_aux_area)
> +				major = message[data->t100_aux_area];
> +
> +			if (data->t100_aux_ampl)
> +				pressure = message[data->t100_aux_ampl];
> +
> +			if (data->t100_aux_vect)
> +				orientation = message[data->t100_aux_vect];
> +
> +			break;
> +		case MXT_T100_TYPE_PASSIVE_STYLUS:
> +			tool = MT_TOOL_PEN;
> +
> +			/* Passive stylus is reported with size zero so
> +			 * hardcode */
> +			major = MXT_TOUCH_MAJOR_DEFAULT;
> +
> +			if (data->t100_aux_ampl)
> +				pressure = message[data->t100_aux_ampl];
> +
> +			break;
> +		case MXT_T100_TYPE_LARGE_TOUCH:
> +			/* Ignore suppressed touch */
> +			break;
> +		default:
> +			dev_dbg(dev, "Unexpected T100 type\n");
> +			return;
> +		}
> +	}
> +
> +	/*
> +	 * Values reported should be non-zero if tool is touching the
> +	 * device
> +	 */
> +	if (!pressure && type != MXT_T100_TYPE_HOVERING_FINGER)
> +		pressure = MXT_PRESSURE_DEFAULT;
> +
> +	input_mt_slot(input_dev, id);
> +
> +	if (status & MXT_T100_DETECT) {
> +		dev_dbg(dev, "[%u] type:%u x:%u y:%u a:%02X p:%02X v:%02X\n",
> +			id, type, x, y, major, pressure, orientation);
> +
> +		input_mt_report_slot_state(input_dev, tool, 1);
> +		input_report_abs(input_dev, ABS_MT_POSITION_X, x);
> +		input_report_abs(input_dev, ABS_MT_POSITION_Y, y);
> +		input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR, major);
> +		input_report_abs(input_dev, ABS_MT_PRESSURE, pressure);
> +		input_report_abs(input_dev, ABS_MT_DISTANCE, distance);
> +		input_report_abs(input_dev, ABS_MT_ORIENTATION, orientation);
> +	} else {
> +		dev_dbg(dev, "[%u] release\n", id);
> +
> +		/* close out slot */
> +		input_mt_report_slot_state(input_dev, 0, 0);
> +	}
> +
> +	data->update_input = true;
> +}
> +
>  static int mxt_proc_message(struct mxt_data *data, u8 *message)
>  {
>  	u8 report_id = message[0];
> @@ -789,6 +928,9 @@ static int mxt_proc_message(struct mxt_data *data, u8 *message)
>  	} else if (report_id >= data->T9_reportid_min
>  	    && report_id <= data->T9_reportid_max) {
>  		mxt_proc_t9_message(data, message);
> +	} else if (report_id >= data->T100_reportid_min
> +	    && report_id <= data->T100_reportid_max) {
> +		mxt_proc_t100_message(data, message);
>  	} else if (report_id == data->T19_reportid) {
>  		mxt_input_button(data, message);
>  		data->update_input = true;
> @@ -1411,6 +1553,8 @@ static void mxt_free_object_table(struct mxt_data *data)
>  	data->T9_reportid_max = 0;
>  	data->T19_reportid = 0;
>  	data->T44_address = 0;
> +	data->T100_reportid_min = 0;
> +	data->T100_reportid_max = 0;
>  	data->max_reportid = 0;
>  }
>  
> @@ -1487,6 +1631,7 @@ static int mxt_get_object_table(struct mxt_data *data)
>  			data->T7_address = object->start_address;
>  			break;
>  		case MXT_TOUCH_MULTI_T9:
> +			data->multitouch = MXT_TOUCH_MULTI_T9;
>  			data->T9_reportid_min = min_id;
>  			data->T9_reportid_max = max_id;
>  			data->num_touchids = object->num_report_ids
> @@ -1498,6 +1643,13 @@ static int mxt_get_object_table(struct mxt_data *data)
>  		case MXT_SPT_GPIOPWM_T19:
>  			data->T19_reportid = min_id;
>  			break;
> +		case MXT_TOUCH_MULTITOUCHSCREEN_T100:
> +			data->multitouch = MXT_TOUCH_MULTITOUCHSCREEN_T100;
> +			data->T100_reportid_min = min_id;
> +			data->T100_reportid_max = max_id;
> +			/* first two report IDs reserved */
> +			data->num_touchids = object->num_report_ids - 2;
> +			break;
>  		}
>  
>  		end_address = object->start_address
> @@ -1582,10 +1734,88 @@ static int mxt_read_t9_resolution(struct mxt_data *data)
>  	return 0;
>  }
>  
> +static int mxt_read_t100_config(struct mxt_data *data)
> +{
> +	struct i2c_client *client = data->client;
> +	int error;
> +	struct mxt_object *object;
> +	u16 range_x, range_y;
> +	u8 cfg, tchaux;
> +	u8 aux;
> +
> +	object = mxt_get_object(data, MXT_TOUCH_MULTITOUCHSCREEN_T100);
> +	if (!object)
> +		return -EINVAL;
> +
> +	error = __mxt_read_reg(client,
> +			       object->start_address + MXT_T100_XRANGE,
> +			       sizeof(range_x), &range_x);
> +	if (error)
> +		return error;
> +
> +	le16_to_cpus(range_x);

Needs to be "le16_to_cpus(&range_x);" - note "&" or it will likely fail
compilation on big endians, or won't work right there.

Applied, thank you.

-- 
Dmitry
