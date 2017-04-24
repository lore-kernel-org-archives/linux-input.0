From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/2] Alps HID I2C T4 device support
Date: Mon, 24 Apr 2017 16:54:10 +0200
Message-ID: <20170424145410.GA19770@mail.corp.redhat.com>
References: <20170330025317.4093-1-masaki.ota@jp.alps.com>
 <20170330025317.4093-2-masaki.ota@jp.alps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57878 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1172834AbdDXOyT (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 24 Apr 2017 10:54:19 -0400
Content-Disposition: inline
In-Reply-To: <20170330025317.4093-2-masaki.ota@jp.alps.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Masaki Ota <012nexus@gmail.com>
Cc: jikos@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, masaki.ota@jp.alps.com

Hi,

I have this review in my inbox for a while, but couldn't find the time
to finish it earlier. Sorry about that.

On Mar 30 2017 or thereabouts, Masaki Ota wrote:
> From Masaki Ota <masai.ota@jp.alps.com>
> 
> -Support Alps HID I2C T4 Touchpad device.
> -Laptop names that use this Touchpad:HP Zbook Studio, Elitebook Folio G1, Elitebook 1030 G1, Elitebook 1040 G3
> 
> Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
> ---
>  drivers/hid/hid-alps.c | 500 +++++++++++++++++++++++++++++++++++++++----------
>  drivers/hid/hid-core.c |   3 +-
>  drivers/hid/hid-ids.h  |   1 +
>  3 files changed, 403 insertions(+), 101 deletions(-)
> 
> diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
> index ed9c0ea..13a6db1 100644
> --- a/drivers/hid/hid-alps.c
> +++ b/drivers/hid/hid-alps.c
> @@ -52,8 +52,30 @@
>  #define ADDRESS_U1_PAD_BTN		0x00800052
>  #define ADDRESS_U1_SP_BTN		0x0080009F
>  
> +#define T4_INPUT_REPORT_LEN			sizeof(T4_INPUT_REPORT)
> +#define T4_FEATURE_REPORT_LEN		T4_INPUT_REPORT_LEN
> +#define T4_FEATURE_REPORT_ID		7
> +#define T4_CMD_REGISTER_READ			0x08
> +#define T4_CMD_REGISTER_WRITE			0x07
> +
> +#define T4_ADDRESS_BASE				0xC2C0
> +#define PRM_SYS_CONFIG_1			(T4_ADDRESS_BASE + 0x0002)
> +#define T4_PRM_FEED_CONFIG_1		(T4_ADDRESS_BASE + 0x0004)
> +#define T4_PRM_FEED_CONFIG_4		(T4_ADDRESS_BASE + 0x001A)
> +#define T4_PRM_ID_CONFIG_3			(T4_ADDRESS_BASE + 0x00B0)
> +
> +
> +#define T4_FEEDCFG4_ADVANCED_ABS_ENABLE			0x01
> +#define T4_I2C_ABS	0x78
> +
> +#define T4_COUNT_PER_ELECTRODE		256
>  #define MAX_TOUCHES	5
>  
> +typedef enum {
> +	U1,
> +	T4,
> +	UNKNOWN,
> +} DEV_TYPE;
>  /**
>   * struct u1_data
>   *
> @@ -61,43 +83,168 @@
>   * @input2: pointer to the kernel input2 device
>   * @hdev: pointer to the struct hid_device
>   *
> - * @dev_ctrl: device control parameter
>   * @dev_type: device type
> - * @sen_line_num_x: number of sensor line of X
> - * @sen_line_num_y: number of sensor line of Y
> - * @pitch_x: sensor pitch of X
> - * @pitch_y: sensor pitch of Y
> - * @resolution: resolution
> - * @btn_info: button information
> + * @max_fingers: total number of fingers
> + * @has_sp: boolean of sp existense
> + * @sp_btn_info: button information
>   * @x_active_len_mm: active area length of X (mm)
>   * @y_active_len_mm: active area length of Y (mm)
>   * @x_max: maximum x coordinate value
>   * @y_max: maximum y coordinate value
> + * @x_min: minimum x coordinate value
> + * @y_min: minimum y coordinate value
>   * @btn_cnt: number of buttons
>   * @sp_btn_cnt: number of stick buttons
>   */
> -struct u1_dev {
> +struct alps_dev {
>  	struct input_dev *input;
>  	struct input_dev *input2;
>  	struct hid_device *hdev;
>  
> -	u8	dev_ctrl;
> -	u8	dev_type;
> -	u8	sen_line_num_x;
> -	u8	sen_line_num_y;
> -	u8	pitch_x;
> -	u8	pitch_y;
> -	u8	resolution;
> -	u8	btn_info;
> +	DEV_TYPE dev_type;
> +	u8  max_fingers;
> +	u8  has_sp;
>  	u8	sp_btn_info;
>  	u32	x_active_len_mm;
>  	u32	y_active_len_mm;
>  	u32	x_max;
>  	u32	y_max;
> +	u32	x_min;
> +	u32	y_min;
>  	u32	btn_cnt;
>  	u32	sp_btn_cnt;
>  };
>  
> +typedef struct _T4_CONTACT_DATA {
> +	u8  Palm;

I think the coding style guidelines requires to not use camelcase, so
it should be 'palm', not 'Palm'.

> +	u8	x_lo;
> +	u8	x_hi;
> +	u8	y_lo;
> +	u8	y_hi;
> +} T4_CONTACT_DATA, *PT4_CONTACT_DATA;

We don't rely on typedefs in the kernel (see
Documentation/process/coding-styles.rst). Please keep the "struct
t4_contact_data" naming (and lower case I think).

> +
> +typedef struct _T4_INPUT_REPORT {
> +	u8  ReportID;

Coding style (and throughout the file, please).

> +	u8  NumContacts;
> +	T4_CONTACT_DATA Contact[5];
> +	u8  Button;
> +	u8  Track[5];
> +	u8  ZX[5], ZY[5];
> +	u8  PalmTime[5];
> +	u8  Kilroy;
> +	u16 TimeStamp;
> +} T4_INPUT_REPORT, *PT4_INPUT_REPORT;

Same here regarding typedef.

> +
> +static u16 t4_calc_check_sum(u8 *buffer,
> +		unsigned long offset, unsigned long length)
> +{
> +	u16 sum1 = 0xFF, sum2 = 0xFF;
> +	unsigned long i = 0;
> +
> +	if (offset + length >= 50)
> +		return 0;
> +
> +	while (length > 0) {
> +		u32 tlen = length > 20 ? 20 : length;
> +
> +		length -= tlen;
> +
> +		do {
> +			sum1 += buffer[offset + i];
> +			sum2 += sum1;
> +			i++;
> +		} while (--tlen > 0);
> +
> +		sum1 = (sum1 & 0xFF) + (sum1 >> 8);
> +		sum2 = (sum2 & 0xFF) + (sum2 >> 8);
> +	}
> +
> +	sum1 = (sum1 & 0xFF) + (sum1 >> 8);
> +	sum2 = (sum2 & 0xFF) + (sum2 >> 8);
> +
> +	return(sum2 << 8 | sum1);
> +}
> +
> +static int T4_read_write_register(struct hid_device *hdev, u32 address,

I'd rather have the name starting with a lower case (and everywhere in
the code).

> +	u8 *read_val, u8 write_val, bool read_flag)
> +{
> +	int ret;
> +	u16 check_sum;
> +	u8 *input;
> +	u8 *readbuf;
> +
> +	input = kzalloc(T4_FEATURE_REPORT_LEN, GFP_KERNEL);
> +	if (!input)
> +		return -ENOMEM;
> +
> +	input[0] = T4_FEATURE_REPORT_ID;
> +	if (read_flag) {
> +		input[1] = T4_CMD_REGISTER_READ;
> +		input[8] = 0x00;
> +	} else {
> +		input[1] = T4_CMD_REGISTER_WRITE;
> +		input[8] = write_val;
> +	}
> +	put_unaligned_le32(address, input + 2);
> +	//input[4] = 0;
> +	//input[5] = 0;

No C++ comments, and why would you need to have those at first? Just
remove those.

> +	input[6] = 1;
> +	input[7] = 0;
> +
> +	// Calculate amd append the checksum

No C++ comments.

> +	check_sum = t4_calc_check_sum(input, 1, 8);
> +	input[9] = (u8)check_sum;
> +	input[10] = (u8)(check_sum >> 8);
> +	input[11] = 0;
> +
> +	ret = hid_hw_raw_request(hdev, T4_FEATURE_REPORT_ID, input,
> +			T4_FEATURE_REPORT_LEN,
> +			HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
> +
> +	if (ret < 0) {
> +		dev_err(&hdev->dev, "failed to read command (%d)\n", ret);
> +		goto exit;
> +	}
> +
> +	if (read_flag) {
> +		readbuf = kzalloc(T4_FEATURE_REPORT_LEN, GFP_KERNEL);
> +		if (!readbuf) {
> +			kfree(input);
> +			return -ENOMEM;

ret = -ENOMEM;
goto exit;

> +		}
> +
> +		ret = hid_hw_raw_request(hdev, T4_FEATURE_REPORT_ID, readbuf,
> +				T4_FEATURE_REPORT_LEN,
> +				HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
> +		if (ret < 0) {
> +			dev_err(&hdev->dev, "failed read register (%d)\n", ret);

You are leaking readbuf here.

> +			goto exit;
> +		}
> +		if (*(u32 *)&readbuf[6] != address)
> +			hid_alert(hdev, "T4_read_write_register address error %x %x\n",
> +				*(u32 *)&readbuf[6], address);
> +
> +		if (*(u16 *)&readbuf[10] != 1)
> +			hid_alert(hdev, "T4_read_write_register size error %x\n",
> +				*(u16 *)&readbuf[10]);
> +
> +		check_sum = t4_calc_check_sum(readbuf, 6, 7);
> +		if (*(u16 *)&readbuf[13] != check_sum)
> +			hid_alert(hdev, "T4_read_write_register checksum error %x %x\n",
> +				*(u16 *)&readbuf[13], check_sum);

Don't you want to abort if any of the alert above is raised?

> +
> +		*read_val = readbuf[12];
> +
> +		kfree(readbuf);
> +	}
> +
> +	ret = 0;
> +
> +exit:
> +	kfree(input);
> +	return ret;
> +}
> +
>  static int u1_read_write_register(struct hid_device *hdev, u32 address,
>  	u8 *read_val, u8 write_val, bool read_flag)
>  {
> @@ -165,21 +312,63 @@ static int u1_read_write_register(struct hid_device *hdev, u32 address,
>  	return ret;
>  }
>  
> -static int alps_raw_event(struct hid_device *hdev,
> -		struct hid_report *report, u8 *data, int size)
> +static int T4_raw_event(struct alps_dev *hdata, u8 *data, int size)
> +{
> +	unsigned int x, y, z;
> +	int i;
> +	PT4_INPUT_REPORT p_report = (PT4_INPUT_REPORT)data;
> +
> +	if (!data)
> +		return 0;
> +	for (i = 0; i < hdata->max_fingers; i++) {
> +		x = p_report->Contact[i].x_hi<<8 | p_report->Contact[i].x_lo;

spaces issues (should be 'p_report->Contact[i].x_hi << 8')

> +		y = p_report->Contact[i].y_hi<<8 | p_report->Contact[i].y_lo;

idem

> +		y = hdata->y_max - y + hdata->y_min;
> +		z = (p_report->Contact[i].Palm < 0x80 &&
> +			p_report->Contact[i].Palm > 0) * 62;
> +		if (x == 0xffff) {
> +			x = 0;
> +			y = 0;
> +			z = 0;
> +		}
> +		input_mt_slot(hdata->input, i);
> +
> +		if (z != 0) {
> +			input_mt_report_slot_state(hdata->input,
> +				MT_TOOL_FINGER, 1);
> +		} else {
> +			input_mt_report_slot_state(hdata->input,
> +				MT_TOOL_FINGER, 0);

You could have:
	input_mt_report_slot_state(hdata->input, MT_TOOL_FINGER, z != 0);
	if (!z)
		continue

> +			continue;
> +		}
> +
> +		input_report_abs(hdata->input, ABS_MT_POSITION_X, x);
> +		input_report_abs(hdata->input, ABS_MT_POSITION_Y, y);
> +		input_report_abs(hdata->input, ABS_MT_PRESSURE, z);
> +	}
> +	input_mt_sync_frame(hdata->input);
> +
> +	input_report_key(hdata->input, BTN_LEFT,	p_report->Button);
> +
> +	input_sync(hdata->input);
> +	return 1;
> +}
> +
> +static int U1_raw_event(struct alps_dev *hdata, u8 *data, int size)
>  {
>  	unsigned int x, y, z;
>  	int i;
>  	short sp_x, sp_y;
> -	struct u1_dev *hdata = hid_get_drvdata(hdev);
>  
> +	if (!data)
> +		return 0;

Can this happen (genuine question)?

>  	switch (data[0]) {
>  	case U1_MOUSE_REPORT_ID:
>  		break;
>  	case U1_FEATURE_REPORT_ID:
>  		break;
>  	case U1_ABSOLUTE_REPORT_ID:
> -		for (i = 0; i < MAX_TOUCHES; i++) {
> +		for (i = 0; i < hdata->max_fingers; i++) {
>  			u8 *contact = &data[i * 5];
>  
>  			x = get_unaligned_le16(contact + 3);
> @@ -241,122 +430,246 @@ static int alps_raw_event(struct hid_device *hdev,
>  	return 0;
>  }
>  
> +static int alps_raw_event(struct hid_device *hdev,
> +		struct hid_report *report, u8 *data, int size)
> +{
> +	int ret = 0;
> +	struct alps_dev *hdata = hid_get_drvdata(hdev);
> +
> +	if (hdev->product == HID_PRODUCT_ID_T4_BTNLESS)
> +		ret = T4_raw_event(hdata, data, size);
> +	else
> +		ret = U1_raw_event(hdata, data, size);

Maybe a switch/case on dev->type would be better here in case you need
to add further devices in the future.

> +
> +	return ret;
> +}
> +
>  #ifdef CONFIG_PM

drop the #ifdef ...

>  static int alps_post_reset(struct hid_device *hdev)

and add "__maybe_unused" to the PM functions (see other drivers in HID).

>  {
> -	return u1_read_write_register(hdev, ADDRESS_U1_DEV_CTRL_1,
> -				NULL, U1_TP_ABS_MODE | U1_SP_ABS_MODE, false);
> +	int ret = -1;
> +	struct alps_dev *data = hid_get_drvdata(hdev);
> +
> +	switch (data->dev_type) {
> +	case T4:
> +		ret = T4_read_write_register(hdev, T4_PRM_FEED_CONFIG_1,
> +			NULL, T4_I2C_ABS, false);
> +		ret = T4_read_write_register(hdev, T4_PRM_FEED_CONFIG_4,
> +			NULL, T4_FEEDCFG4_ADVANCED_ABS_ENABLE, false);
> +		break;
> +	case U1:
> +		ret = u1_read_write_register(hdev,
> +			ADDRESS_U1_DEV_CTRL_1, NULL,
> +			U1_TP_ABS_MODE | U1_SP_ABS_MODE, false);
> +		break;
> +	default:
> +		break;
> +	}
> +	return ret;
>  }
>  
>  static int alps_post_resume(struct hid_device *hdev)
>  {
> -	return u1_read_write_register(hdev, ADDRESS_U1_DEV_CTRL_1,
> -				NULL, U1_TP_ABS_MODE | U1_SP_ABS_MODE, false);
> +	return alps_post_reset(hdev);
>  }
>  #endif /* CONFIG_PM */
>  
> -static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
> +static int u1_init(struct hid_device *hdev, struct alps_dev *pri_data)
>  {
> -	struct u1_dev *data = hid_get_drvdata(hdev);
> -	struct input_dev *input = hi->input, *input2;
> -	struct u1_dev devInfo;
>  	int ret;
> -	int res_x, res_y, i;
> -
> -	data->input = input;
> -
> -	hid_dbg(hdev, "Opening low level driver\n");
> -	ret = hid_hw_open(hdev);
> -	if (ret)
> -		return ret;
> -
> -	/* Allow incoming hid reports */
> -	hid_device_io_start(hdev);
> +	u8 tmp, dev_ctrl, sen_line_num_x, sen_line_num_y;
> +	u8 pitch_x, pitch_y, resolution;
>  
>  	/* Device initialization */
>  	ret = u1_read_write_register(hdev, ADDRESS_U1_DEV_CTRL_1,
> -			&devInfo.dev_ctrl, 0, true);
> +			&dev_ctrl, 0, true);
>  	if (ret < 0) {
>  		dev_err(&hdev->dev, "failed U1_DEV_CTRL_1 (%d)\n", ret);
>  		goto exit;
>  	}
>  
> -	devInfo.dev_ctrl &= ~U1_DISABLE_DEV;
> -	devInfo.dev_ctrl |= U1_TP_ABS_MODE;
> +	dev_ctrl &= ~U1_DISABLE_DEV;
> +	dev_ctrl |= U1_TP_ABS_MODE;
>  	ret = u1_read_write_register(hdev, ADDRESS_U1_DEV_CTRL_1,
> -			NULL, devInfo.dev_ctrl, false);
> +			NULL, dev_ctrl, false);
>  	if (ret < 0) {
>  		dev_err(&hdev->dev, "failed to change TP mode (%d)\n", ret);
>  		goto exit;
>  	}
>  
>  	ret = u1_read_write_register(hdev, ADDRESS_U1_NUM_SENS_X,
> -			&devInfo.sen_line_num_x, 0, true);
> +			&sen_line_num_x, 0, true);
>  	if (ret < 0) {
>  		dev_err(&hdev->dev, "failed U1_NUM_SENS_X (%d)\n", ret);
>  		goto exit;
>  	}
>  
>  	ret = u1_read_write_register(hdev, ADDRESS_U1_NUM_SENS_Y,
> -			&devInfo.sen_line_num_y, 0, true);
> +			&sen_line_num_y, 0, true);
>  		if (ret < 0) {
>  		dev_err(&hdev->dev, "failed U1_NUM_SENS_Y (%d)\n", ret);
>  		goto exit;
>  	}
>  
>  	ret = u1_read_write_register(hdev, ADDRESS_U1_PITCH_SENS_X,
> -			&devInfo.pitch_x, 0, true);
> +			&pitch_x, 0, true);
>  	if (ret < 0) {
>  		dev_err(&hdev->dev, "failed U1_PITCH_SENS_X (%d)\n", ret);
>  		goto exit;
>  	}
>  
>  	ret = u1_read_write_register(hdev, ADDRESS_U1_PITCH_SENS_Y,
> -			&devInfo.pitch_y, 0, true);
> +			&pitch_y, 0, true);
>  	if (ret < 0) {
>  		dev_err(&hdev->dev, "failed U1_PITCH_SENS_Y (%d)\n", ret);
>  		goto exit;
>  	}
>  
>  	ret = u1_read_write_register(hdev, ADDRESS_U1_RESO_DWN_ABS,
> -		&devInfo.resolution, 0, true);
> +		&resolution, 0, true);
>  	if (ret < 0) {
>  		dev_err(&hdev->dev, "failed U1_RESO_DWN_ABS (%d)\n", ret);
>  		goto exit;
>  	}
> +	pri_data->x_active_len_mm =
> +		(pitch_x * (sen_line_num_x - 1)) / 10;
> +	pri_data->y_active_len_mm =
> +		(pitch_y * (sen_line_num_y - 1)) / 10;
> +
> +	pri_data->x_max =
> +		(resolution << 2) * (sen_line_num_x - 1);
> +	pri_data->x_min = 1;
> +	pri_data->y_max =
> +		(resolution << 2) * (sen_line_num_y - 1);
> +	pri_data->y_min = 1;
>  
>  	ret = u1_read_write_register(hdev, ADDRESS_U1_PAD_BTN,
> -			&devInfo.btn_info, 0, true);
> +			&tmp, 0, true);
>  	if (ret < 0) {
>  		dev_err(&hdev->dev, "failed U1_PAD_BTN (%d)\n", ret);
>  		goto exit;
>  	}
> +	if ((tmp & 0x0F) == (tmp & 0xF0) >> 4) {
> +		pri_data->btn_cnt = (tmp & 0x0F);
> +	} else {
> +		/* Button pad */
> +		pri_data->btn_cnt = 1;
> +	}
>  
> +	pri_data->has_sp = 0;
>  	/* Check StickPointer device */
>  	ret = u1_read_write_register(hdev, ADDRESS_U1_DEVICE_TYP,
> -			&devInfo.dev_type, 0, true);
> +			&tmp, 0, true);
>  	if (ret < 0) {
>  		dev_err(&hdev->dev, "failed U1_DEVICE_TYP (%d)\n", ret);
>  		goto exit;
>  	}
> +	if (tmp & U1_DEVTYPE_SP_SUPPORT) {

Is this some new feature of U1 devices or am I reading it wrong?

> +		dev_ctrl |= U1_SP_ABS_MODE;
> +		ret = u1_read_write_register(hdev, ADDRESS_U1_DEV_CTRL_1,
> +			NULL, dev_ctrl, false);
> +		if (ret < 0) {
> +			dev_err(&hdev->dev, "failed SP mode (%d)\n", ret);
> +			goto exit;
> +		}
> +
> +		ret = u1_read_write_register(hdev, ADDRESS_U1_SP_BTN,
> +			&pri_data->sp_btn_info, 0, true);
> +		if (ret < 0) {
> +			dev_err(&hdev->dev, "failed U1_SP_BTN (%d)\n", ret);
> +			goto exit;
> +		}
> +		pri_data->has_sp = 1;
> +	}
> +	pri_data->max_fingers = 5;
> +exit:
> +	return ret;
> +}

This function is a massive rework of U1. I'd be more confident if you
split the patch in 2. One for the U1 rework to make it more generic, and
one other with just the T4 bits.

> +
> +static int T4_init(struct hid_device *hdev, struct alps_dev *pri_data)
> +{
> +	int ret;
> +	u8 tmp, sen_line_num_x, sen_line_num_y;
> +
> +	ret = T4_read_write_register(hdev, T4_PRM_ID_CONFIG_3, &tmp, 0, true);
> +	if (ret < 0) {
> +		dev_err(&hdev->dev, "failed T4_PRM_ID_CONFIG_3 (%d)\n", ret);
> +		goto exit;
> +	}
> +	sen_line_num_x = 16+((tmp & 0x0F)  | (tmp & 0x08 ? 0xF0 : 0));

I am surprised checkpatch.pl doesn't complains about the spaces issues
around '+'.

> +	sen_line_num_y = 12+(((tmp & 0xF0) >> 4)  | (tmp & 0x80 ? 0xF0 : 0));

likewise

> +
> +	pri_data->x_max = sen_line_num_x * T4_COUNT_PER_ELECTRODE;
> +	pri_data->x_min = T4_COUNT_PER_ELECTRODE;
> +	pri_data->y_max = sen_line_num_y * T4_COUNT_PER_ELECTRODE;
> +	pri_data->y_min = T4_COUNT_PER_ELECTRODE;
> +	pri_data->x_active_len_mm = pri_data->y_active_len_mm = 0;
> +	pri_data->btn_cnt = 1;
> +
> +	ret = T4_read_write_register(hdev, PRM_SYS_CONFIG_1, &tmp, 0, true);
> +	if (ret < 0) {
> +		dev_err(&hdev->dev, "failed PRM_SYS_CONFIG_1 (%d)\n", ret);
> +		goto exit;
> +	}
> +	tmp |= 0x02;
> +	ret = T4_read_write_register(hdev, PRM_SYS_CONFIG_1, NULL, tmp, false);
> +	if (ret < 0) {
> +		dev_err(&hdev->dev, "failed PRM_SYS_CONFIG_1 (%d)\n", ret);
> +		goto exit;
> +	}
>  
> -	devInfo.x_active_len_mm =
> -		(devInfo.pitch_x * (devInfo.sen_line_num_x - 1)) / 10;
> -	devInfo.y_active_len_mm =
> -		(devInfo.pitch_y * (devInfo.sen_line_num_y - 1)) / 10;
> +	ret = T4_read_write_register(hdev, T4_PRM_FEED_CONFIG_1,
> +					NULL, T4_I2C_ABS, false);
> +	if (ret < 0) {
> +		dev_err(&hdev->dev, "failed T4_PRM_FEED_CONFIG_1 (%d)\n", ret);
> +		goto exit;
> +	}
>  
> -	devInfo.x_max =
> -		(devInfo.resolution << 2) * (devInfo.sen_line_num_x - 1);
> -	devInfo.y_max =
> -		(devInfo.resolution << 2) * (devInfo.sen_line_num_y - 1);
> +	ret = T4_read_write_register(hdev, T4_PRM_FEED_CONFIG_4, NULL,
> +				T4_FEEDCFG4_ADVANCED_ABS_ENABLE, false);
> +	if (ret < 0) {
> +		dev_err(&hdev->dev, "failed T4_PRM_FEED_CONFIG_4 (%d)\n", ret);
> +		goto exit;
> +	}
> +	pri_data->max_fingers = 5;
> +	pri_data->has_sp = 0;
> +exit:
> +	return ret;
> +}
> +
> +static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
> +{
> +	struct alps_dev *data = hid_get_drvdata(hdev);
> +	struct input_dev *input = hi->input, *input2;
> +	int ret;
> +	int res_x, res_y, i;
> +
> +	data->input = input;
> +
> +	hid_dbg(hdev, "Opening low level driver\n");
> +	ret = hid_hw_open(hdev);
> +	if (ret)
> +		return ret;
> +
> +	/* Allow incoming hid reports */
> +	hid_device_io_start(hdev);
> +	if (data->dev_type == T4)

switch/case?

> +		ret = T4_init(hdev, data);
> +	else
> +		ret = u1_init(hdev, data);
> +
> +	if (ret)
> +		goto exit;
>  
>  	__set_bit(EV_ABS, input->evbit);
> -	input_set_abs_params(input, ABS_MT_POSITION_X, 1, devInfo.x_max, 0, 0);
> -	input_set_abs_params(input, ABS_MT_POSITION_Y, 1, devInfo.y_max, 0, 0);
> +	input_set_abs_params(input, ABS_MT_POSITION_X,
> +						data->x_min, data->x_max, 0, 0);
> +	input_set_abs_params(input, ABS_MT_POSITION_Y,
> +						data->y_min, data->y_max, 0, 0);
>  
> -	if (devInfo.x_active_len_mm && devInfo.y_active_len_mm) {
> -		res_x = (devInfo.x_max - 1) / devInfo.x_active_len_mm;
> -		res_y = (devInfo.y_max - 1) / devInfo.y_active_len_mm;
> +	if (data->x_active_len_mm && data->y_active_len_mm) {
> +		res_x = (data->x_max - 1) / data->x_active_len_mm;
> +		res_y = (data->y_max - 1) / data->y_active_len_mm;
>  
>  		input_abs_set_res(input, ABS_MT_POSITION_X, res_x);
>  		input_abs_set_res(input, ABS_MT_POSITION_Y, res_y);
> @@ -364,49 +677,25 @@ static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
>  
>  	input_set_abs_params(input, ABS_MT_PRESSURE, 0, 64, 0, 0);
>  
> -	input_mt_init_slots(input, MAX_TOUCHES, INPUT_MT_POINTER);
> +	input_mt_init_slots(input, data->max_fingers, INPUT_MT_POINTER);
>  
>  	__set_bit(EV_KEY, input->evbit);
> -	if ((devInfo.btn_info & 0x0F) == (devInfo.btn_info & 0xF0) >> 4) {
> -		devInfo.btn_cnt = (devInfo.btn_info & 0x0F);
> -	} else {
> -		/* Button pad */
> -		devInfo.btn_cnt = 1;
> +
> +	if (data->btn_cnt == 1)
>  		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
> -	}
>  
> -	for (i = 0; i < devInfo.btn_cnt; i++)
> +	for (i = 0; i < data->btn_cnt; i++)
>  		__set_bit(BTN_LEFT + i, input->keybit);
>  
> -
>  	/* Stick device initialization */
> -	if (devInfo.dev_type & U1_DEVTYPE_SP_SUPPORT) {
> -
> +	if (data->has_sp) {
>  		input2 = input_allocate_device();

Not in the current patch, but this would be better with
devm_input_allocate(), especially because this input device is leaked
and is never released in the current code.

>  		if (!input2) {
> -			ret = -ENOMEM;
> -			goto exit;
> -		}
> -
> -		data->input2 = input2;
> -
> -		devInfo.dev_ctrl |= U1_SP_ABS_MODE;
> -		ret = u1_read_write_register(hdev, ADDRESS_U1_DEV_CTRL_1,
> -			NULL, devInfo.dev_ctrl, false);
> -		if (ret < 0) {
> -			dev_err(&hdev->dev, "failed SP mode (%d)\n", ret);
> -			input_free_device(input2);
> -			goto exit;
> -		}
> -
> -		ret = u1_read_write_register(hdev, ADDRESS_U1_SP_BTN,
> -			&devInfo.sp_btn_info, 0, true);
> -		if (ret < 0) {
> -			dev_err(&hdev->dev, "failed U1_SP_BTN (%d)\n", ret);
>  			input_free_device(input2);
>  			goto exit;
>  		}
>  
> +		data->input2 = input2;
>  		input2->phys = input->phys;
>  		input2->name = "DualPoint Stick";
>  		input2->id.bustype = BUS_I2C;
> @@ -416,8 +705,8 @@ static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
>  		input2->dev.parent = input->dev.parent;
>  
>  		__set_bit(EV_KEY, input2->evbit);
> -		devInfo.sp_btn_cnt = (devInfo.sp_btn_info & 0x0F);
> -		for (i = 0; i < devInfo.sp_btn_cnt; i++)
> +		data->sp_btn_cnt = (data->sp_btn_info & 0x0F);
> +		for (i = 0; i < data->sp_btn_cnt; i++)
>  			__set_bit(BTN_LEFT + i, input2->keybit);
>  
>  		__set_bit(EV_REL, input2->evbit);
> @@ -426,8 +715,7 @@ static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
>  		__set_bit(INPUT_PROP_POINTER, input2->propbit);
>  		__set_bit(INPUT_PROP_POINTING_STICK, input2->propbit);
>  
> -		ret = input_register_device(data->input2);
> -		if (ret) {
> +		if (input_register_device(data->input2)) {
>  			input_free_device(input2);
>  			goto exit;
>  		}
> @@ -448,10 +736,9 @@ static int alps_input_mapping(struct hid_device *hdev,
>  
>  static int alps_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  {
> -	struct u1_dev *data = NULL;
> +	struct alps_dev *data = NULL;
>  	int ret;
> -
> -	data = devm_kzalloc(&hdev->dev, sizeof(struct u1_dev), GFP_KERNEL);
> +	data = devm_kzalloc(&hdev->dev, sizeof(struct alps_dev), GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
>  
> @@ -466,6 +753,17 @@ static int alps_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		return ret;
>  	}
>  
> +	switch (hdev->product) {
> +	case HID_DEVICE_ID_ALPS_T4_BTNLESS:
> +		data->dev_type = T4;
> +		break;
> +	case HID_DEVICE_ID_ALPS_U1_DUAL:
> +		data->dev_type = U1;
> +		break;
> +	default:
> +		data->dev_type = UNKNOWN;
> +	}
> +
>  	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
>  	if (ret) {
>  		hid_err(hdev, "hw start failed\n");
> @@ -483,6 +781,8 @@ static void alps_remove(struct hid_device *hdev)
>  static const struct hid_device_id alps_id[] = {
>  	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY,
>  		USB_VENDOR_ID_ALPS_JP, HID_DEVICE_ID_ALPS_U1_DUAL) },
> +	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY,
> +		USB_VENDOR_ID_ALPS_JP, HID_DEVICE_ID_ALPS_T4_BTNLESS) },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(hid, alps_id);
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 3ceb4a2..f315192 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1769,7 +1769,8 @@ static const struct hid_device_id hid_have_special_driver[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_A4TECH, USB_DEVICE_ID_A4TECH_RP_649) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ACRUX, 0x0802) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ACRUX, 0xf705) },
> -	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY, USB_VENDOR_ID_ALPS_JP, HID_DEVICE_ID_ALPS_U1_DUAL) },
> +	{ HID_I2C_DEVICE(USB_VENDOR_ID_ALPS_JP, HID_DEVICE_ID_ALPS_U1_DUAL) },
> +	{ HID_I2C_DEVICE(USB_VENDOR_ID_ALPS_JP, HID_DEVICE_ID_ALPS_T4_BTNLESS) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MIGHTYMOUSE) },
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGICMOUSE) },
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGICTRACKPAD) },
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 0e2e7c5..9239543 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -75,6 +75,7 @@
>  
>  #define USB_VENDOR_ID_ALPS_JP		0x044E
>  #define HID_DEVICE_ID_ALPS_U1_DUAL	0x120B
> +#define HID_DEVICE_ID_ALPS_T4_BTNLESS	0x120C
>  
>  #define USB_VENDOR_ID_AMI		0x046b
>  #define USB_DEVICE_ID_AMI_VIRT_KEYBOARD_AND_MOUSE	0xff10
> -- 
> 2.9.3
> 

Cheers,
Benjamin
