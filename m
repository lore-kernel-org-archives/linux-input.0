From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCHv3] input: ROHM BU21013 touch panel controller support
Date: Wed, 22 Sep 2010 20:21:00 +0200
Message-ID: <4C9A490C.6020907@euromail.se>
References: <1285060851-30173-1-git-send-email-naveen.gaddipati@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:46024 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751967Ab0IVSVw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Sep 2010 14:21:52 -0400
In-Reply-To: <1285060851-30173-1-git-send-email-naveen.gaddipati@stericsson.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Naveen Kumar G <naveen.gaddipati@stericsson.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, STEricsson_nomadik_linux@list.st.com, linux-input@vger.kernel.org, tsoni@codeaurora.org

Hi Naveen,

Looks much better now, thanks. Some comments below.

[...]

> +struct bu21013_ts_data {
> +	struct i2c_client *client;
> +	wait_queue_head_t wait;
> +	bool touch_stopped;
> +	const struct bu21013_platform_device *chip;
> +	struct input_dev *in_dev;
> +	unsigned int intr_pin;
> +	signed short	x_pos[2];
> +	signed short	y_pos[2];
> +	bool previous_press_reported;


The MT state here (x_pos, y_pos, previous_press_reported) could, in principle,
be simplified away, since the type A protocol is stateless.

[...]
> +static int bu21013_do_touch_report(struct bu21013_ts_data *data)

> +{
> +	u8	buf[LENGTH_OF_BUFFER];
> +	bool	finger1_valid = true;
> +	bool	finger2_valid = true;
> +	unsigned int	finger1_pos_x;
> +	unsigned int	finger1_pos_y;
> +	unsigned int	finger2_pos_x = 0;
> +	unsigned int	finger2_pos_y = 0;


These could be arrays instead.

> +	int	number_of_active_x_sensors;
> +	int	number_of_active_y_sensors;
> +	int	total_number_of_active_sensors;
> +	int	finger_down_count = 0;
> +	int	ret = 0;
> +	int	i;
> +	int	retry_count = I2C_RETRY_COUNT;
> +
> +	if (data == NULL)
> +		return -EINVAL;
> +
> +	do {
> +		ret = i2c_smbus_read_i2c_block_data
> +			(data->client, BU21013_SENSORS_BTN_0_7_REG,
> +				LENGTH_OF_BUFFER, buf);
> +		retry_count--;
> +		if ((ret < LENGTH_OF_BUFFER) && (!retry_count))
> +			return -EINVAL;
> +	} while (ret < LENGTH_OF_BUFFER);
> +
> +	number_of_active_x_sensors = hweight32(buf[0] &
> +					BU21013_SENSORS_EN_0_7);
> +	number_of_active_y_sensors = hweight32(
> +			((buf[1] & BU21013_SENSORS_EN_8_15) |
> +		((buf[2] & BU21013_SENSORS_EN_16_23) << SHIFT_8)) >> SHIFT_2);
> +	if (((number_of_active_x_sensors != 0) &&
> +		(number_of_active_y_sensors == 0)) ||
> +		((number_of_active_x_sensors == 0) &&
> +		(number_of_active_y_sensors != 0)))
> +		return 0;


So these should really be completely ignored, not reported as touch up? Any
chance the above is the last event seen before a period of no activity?


> +	total_number_of_active_sensors =
> +		number_of_active_x_sensors + number_of_active_y_sensors;
> +
> +	if (total_number_of_active_sensors) {
> +		finger1_pos_x = buf[3] << SHIFT_2 | (buf[4] & MASK_BITS);
> +		finger1_pos_y = buf[5] << SHIFT_2 | (buf[6] & MASK_BITS);
> +		finger2_pos_x = buf[7] << SHIFT_2 | (buf[8] & MASK_BITS);
> +		finger2_pos_y = buf[9] << SHIFT_2 | (buf[10] & MASK_BITS);
> +
> +		if ((finger1_pos_x == 0) || (finger1_pos_y == 0))
> +			finger1_valid = false;
> +
> +		if ((finger2_pos_x == 0) || (finger2_pos_y == 0))
> +			finger2_valid = false;
> +
> +		if ((!finger1_valid) && (!finger2_valid)) {
> +			return 0;
> +		} else if ((!finger1_valid) && (finger2_valid)) {
> +			finger1_valid = finger2_valid;
> +			finger1_pos_x = finger2_pos_x;
> +			finger1_pos_y = finger2_pos_y;
> +			finger2_valid = false;
> +			finger2_pos_x = 0;
> +			finger2_pos_y = 0;
> +		}


An array and a for-loop here would remove some more lines of code.

> +
> +		if (finger2_valid) {
> +			ret = bu21013_verify_delta(finger1_pos_x,
> +				finger1_pos_y, finger2_pos_x, finger2_pos_y);
> +			if (!ret)
> +				goto report;


Can finger1 be valid here?

> +			bu21013_touch_calc(data, finger2_pos_x,
> +					finger2_pos_y, finger_down_count);
> +			finger_down_count++;


The MT report could in principle be made right here.

> +		}
> +
> +		if (finger1_valid) {
> +			bu21013_touch_calc(data, finger1_pos_x,
> +					finger1_pos_y, finger_down_count);
> +			finger_down_count++;


Same here, no real need to store it first.

> +		}
> +	}
> +
> +report:
> +	if ((finger_down_count <= 0) && (data->previous_press_reported)) {
> +		/* report pen up to input subsystem */
> +		input_report_key(data->in_dev, BTN_TOUCH, 0);
> +		input_mt_sync(data->in_dev);
> +		input_sync(data->in_dev);
> +		data->previous_press_reported = false;


The previous_press_reported state is already accounted for in the input core,
and could be simplified away.

> +	} else if (finger_down_count > 0) {
> +		/* report pen down to input subsystem */
> +		input_report_abs(data->in_dev, ABS_X, data->x_pos[0]);
> +		input_report_abs(data->in_dev, ABS_Y, data->y_pos[0]);
> +		input_report_key(data->in_dev, BTN_TOUCH, 1);


Out of curiosity, is there any guarantee that pos[0] stays with the initial
finger as the second finger is added?

> +
> +		for (i = 0; i < finger_down_count; i++) {
> +			input_report_abs(data->in_dev, ABS_MT_POSITION_X,
> +							data->x_pos[i]);
> +			input_report_abs(data->in_dev, ABS_MT_POSITION_Y,
> +							data->y_pos[i]);
> +			input_mt_sync(data->in_dev);
> +		}
> +		input_sync(data->in_dev);
> +		data->previous_press_reported = true;
> +	}
> +
> +	return ret;
> +}


Thanks,
Henrik
