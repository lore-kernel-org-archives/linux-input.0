From: Michael Poole <mdpoole@troilus.org>
Subject: Re: [PATCH 2/3] HID: suppress the second input for the Apple Magic Mouse.
Date: Mon, 08 Mar 2010 19:33:17 -0500
Message-ID: <87eiju2v1u.fsf@troilus.org>
References: <1268083784.9018.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:49124 "HELO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753884Ab0CIAdV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 8 Mar 2010 19:33:21 -0500
Received: by qyk33 with SMTP id 33so6201825qyk.17
        for <linux-input@vger.kernel.org>; Mon, 08 Mar 2010 16:33:19 -0800 (PST)
In-Reply-To: <1268083784.9018.20.camel@localhost.localdomain> (Benjamin
	Tissoires's message of "Mon, 08 Mar 2010 22:29:44 +0100")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <tissoire@cena.fr>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Stephane Chatty <chatty@enac.fr>

Benjamin Tissoires writes:

> The first version of hid-magicmouse creates a second input to handle
> the data. However, this new device is not deleted after the disconnect
> of the Magic Mouse. Moreover the user space saw 2 input devices, one
> of them was not reporting any events (the first reported by the device).
> The last pitfall is that if we try to stop the Xserver after disconnecting
> the Magic Mouse, this results in a kernel oops.
>
> This patch deletes everything related to this second input. Instead,
> it manually injects in the report TOUCH_REPORT_ID the fields of the
> report descriptor. The original input created by hid can now be used
> to send the events.
>
> Signed-off-by: Benjamin Tissoires <tissoire@cena.fr>
> ---
>  drivers/hid/hid-magicmouse.c |  198 ++++++++++++++++++++++++++++++++++++------
>  1 files changed, 172 insertions(+), 26 deletions(-)

This diffstat, compared to the functionality being added, says an awful
lot about the approach (IMO).  What is the ongoing maintenance benefit
of writing fake report pseudo-descriptors only to translate them
immediately?

In a moment I'll send a much smaller patch that is similar to one of Ed
Tomlinson's patches (unfortunately never provided with his
Signed-Off-By), but which also avoids creating two input devices.

There are numerous coding style violations in this version:

> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
> index 4a3a94f..32d90c8 100644
> --- a/drivers/hid/hid-magicmouse.c
> +++ b/drivers/hid/hid-magicmouse.c
> @@ -37,6 +37,8 @@ static bool report_undeciphered;
>  module_param(report_undeciphered, bool, 0644);
>  MODULE_PARM_DESC(report_undeciphered, "Report undeciphered multi-touch state field using a MSC_RAW event");
>  
> +#define ArrayLength(a) (sizeof(a) / (sizeof((a)[0])))

As indicated in Chapter 17 of Documentation/CodingStyle, you should just
use ARRAY_SIZE(a) instead of redefining this.

>  #define TOUCH_REPORT_ID   0x29
>  /* These definitions are not precise, but they're close enough.  (Bits
>   * 0x03 seem to indicate the aspect ratio of the touch, bits 0x70 seem
> @@ -328,15 +330,166 @@ static void magicmouse_setup_input(struct input_dev *input, struct hid_device *h
>  	}
>  }
>  
> +static int magicmouse_input_mapping(struct hid_device *hdev, struct hid_input *hinput,
> +		struct hid_field *field, struct hid_usage *usage,
> +		unsigned long **bit, int *max)
> +{
> +	int return_value = report_touches ? 1 : -1;
> +	struct magicmouse_sc *msc = hid_get_drvdata(hdev);
> +
> +	if (field->report->id != TOUCH_REPORT_ID){
> +		/* we let hid_input in charge of the mapping */
> +		return 0;
> +	}

There should be a space after the close parenthesis, but you should
probably just remove the brackets because they're not needed.

> +
> +	if (usage->collection_index != 1) {
> +		/* The only collection we had to map is the multitouch one.
> +		 * The part containing the relatives axes has been mapped
> +		 * by hid in the report given by the device. */
> +		return -1;
> +	}

Ditto here.

> +	/* we store the struct input_dev */
> +	msc->input = hinput->input;
> +
> +	if (emulate_3button)
> +	{
> +		__set_bit(BTN_MIDDLE, hinput->input->keybit);
> +	}

Likewise.  Open brackets should be on the same line as their
corresponding control statement (Chapter 3 of CodingStyle).

> +	if (emulate_scroll_wheel)
> +		__set_bit(REL_WHEEL, hinput->input->relbit);
> +
> +	__set_bit(BTN_TOOL_FINGER, hinput->input->keybit);
> +
> +	if (report_undeciphered) {
> +		__set_bit(EV_MSC, hinput->input->evbit);
> +		__set_bit(MSC_RAW, hinput->input->mscbit);
> +	}
> +
> +	if (usage->hid == HID_UP_UNDEFINED) {
> +		return -1;
> +	}

Brackets should be removed.

> +	switch (usage->hid & HID_USAGE_PAGE) {
> +
> +		case HID_UP_GENDESK:

The usual convention is to not have a blank line before a "case"
statement, although I don't know if that's a hard rule.

> +			switch (usage->hid) {
> +			case HID_GD_X:
> +				hid_map_usage(hinput, usage, bit, max,
> +						EV_ABS, ABS_MT_POSITION_X);
> +				return return_value;
> +			case HID_GD_Y:
> +				hid_map_usage(hinput, usage, bit, max,
> +						EV_ABS, ABS_MT_POSITION_Y);
> +				return return_value;
> +			}
> +			return 0;
> +
> +		case HID_UP_DIGITIZER:
> +			switch (usage->hid) {
> +				case HID_DG_INRANGE:
> +				case HID_DG_CONFIDENCE:
> +				case HID_DG_INPUTMODE:
> +				case HID_DG_DEVICEINDEX:
> +				case HID_DG_CONTACTCOUNT:
> +				case HID_DG_CONTACTMAX:
> +				case HID_DG_TIPPRESSURE:
> +					return -1;
> +
> +				case HID_DG_PUCK:
> +					hid_map_usage(hinput, usage, bit, max,
> +							EV_ABS, ABS_MT_ORIENTATION);
> +					return return_value;
> +				case HID_DG_WIDTH:
> +					hid_map_usage(hinput, usage, bit, max,
> +							EV_ABS, ABS_MT_TOUCH_MAJOR);
> +					return return_value;
> +				case HID_DG_HEIGHT:
> +					hid_map_usage(hinput, usage, bit, max,
> +							EV_ABS, ABS_MT_TOUCH_MINOR);
> +					return return_value;
> +				case HID_DG_CONTACTID:
> +					hid_map_usage(hinput, usage, bit, max,
> +							EV_ABS, ABS_MT_TRACKING_ID);
> +					return return_value;
> +
> +			}
> +			return 0;
> +	}
> +
> +	return 0;
> +}
> +
> +struct magicmouse_descriptor {
> +	unsigned size;
> +	unsigned application;
> +	unsigned hid;
> +	int logical_minimum;
> +	int logical_maximum;
> +};
> +
> +static const struct magicmouse_descriptor magicmouse_multitouch_rel_desc[] = {
> +	{ 8,  HID_GD_MOUSE,  HID_GD_X,           -1,    1 }, /* REL_X */
> +	{ 8,  HID_GD_MOUSE,  HID_GD_Y,           -1,    1 }, /* REL_Y */
> +	{ 1,  HID_GD_MOUSE,  HID_UP_BUTTON+1,    0,     1 }, /* BTN_LEFT */
> +	{ 1,  HID_GD_MOUSE,  HID_UP_BUTTON+2,    0,     1 }, /* BTN_RIGHT */
> +	{ 22, HID_GD_MOUSE,  HID_GD_FEATURE,     0,     0 }, /* TimeStamp */
> +};
> +
> +
> +/* Note: Touch Y position from the device is inverted relative
> + * to how pointer motion is reported (and relative to how USB
> + * HID recommends the coordinates work).  This driver keeps
> + * the origin at the same position, and just uses the additive
> + * inverse of the reported Y.
> + */
> +static const struct magicmouse_descriptor magicmouse_multitouch_abs_desc[] = {
> +	{ 12, HID_GD_MOUSE,  HID_GD_X,           -1100, 1358 }, /* ABS_MT_X */
> +	{ 12, HID_GD_MOUSE,  HID_GD_Y,           -1589, 2047 }, /* ABS_MT_Y */
> +	{ 8,  HID_GD_MOUSE,  HID_DG_WIDTH,       0,     255 }, /* ABS_MT_TOUCH_MAJOR */
> +	{ 8,  HID_GD_MOUSE,  HID_DG_HEIGHT,      0,     255 }, /* ABS_MT_TOUCH_MINOR */
> +	{ 6,  HID_GD_MOUSE,  HID_DG_TIPPRESSURE, 0,     63 }, /* Pressure */
> +	{ 4,  HID_GD_MOUSE,  HID_DG_CONTACTID,   0,     15 }, /* Contact ID */
> +	{ 6,  HID_GD_MOUSE,  HID_DG_PUCK,        -32,   31 }, /* ORIENTATION */
> +	{ 4,  HID_GD_MOUSE,  HID_DG_DEVICEINDEX, 0,     15 }, /* ? */
> +	{ 4,  HID_GD_MOUSE,  HID_DG_CONFIDENCE,  0,     15 }, /* State */
> +};

The last five digitizer constants don't seem like very natural mappings
of what the fields contain.  This also splits the definition of the
fields into two places (this array and magicmouse_input_mapping()),
which doesn't seem like a great idea.

> +
> +static void magicmouse_register_descriptor(const struct magicmouse_descriptor *desc,
> +	int collection, struct hid_report *report)
> +{
> +	struct hid_field *field;
> +	int offset = report->size;
> +	report->size += desc->size;
> +	field = hid_register_field(report, 1, 1);
> +	field->physical = 0;
> +	field->logical = 0;
> +	field->application = desc->application;
> +	field->usage[0].hid = desc->hid;
> +	field->usage[0].collection_index = collection;
> +	field->maxusage = 1;
> +	field->flags = 2;
> +	field->report_offset = offset;
> +	field->report_type = 0;
> +	field->report_size = desc->size;
> +	field->report_count = 1;
> +	field->logical_minimum = desc->logical_minimum;
> +	field->logical_maximum = desc->logical_maximum;
> +	field->physical_minimum = 0;
> +	field->physical_maximum = 0;
> +	field->unit_exponent = 0;
> +	field->unit = 0;
> +}
> +
>  static int magicmouse_probe(struct hid_device *hdev,
>  	const struct hid_device_id *id)
>  {
>  	__u8 feature_1[] = { 0xd7, 0x01 };
>  	__u8 feature_2[] = { 0xf8, 0x01, 0x32 };
> -	struct input_dev *input;
>  	struct magicmouse_sc *msc;
>  	struct hid_report *report;
> -	int ret;
> +	int ret,i;

There should be a space between the comma and "i" here.

>  
>  	msc = kzalloc(sizeof(*msc), GFP_KERNEL);
>  	if (msc == NULL) {
> @@ -353,19 +506,28 @@ static int magicmouse_probe(struct hid_device *hdev,
>  		goto err_free;
>  	}
>  
> -	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> -	if (ret) {
> -		dev_err(&hdev->dev, "magicmouse hw start failed\n");
> -		goto err_free;
> -	}
> -
>  	report = hid_register_report(hdev, HID_INPUT_REPORT, TOUCH_REPORT_ID);
>  	if (!report) {
>  		dev_err(&hdev->dev, "unable to register touch report\n");
>  		ret = -ENOMEM;
>  		goto err_stop_hw;
>  	}
> -	report->size = 6;
> +
> +	for (i = 0 ; i < ArrayLength(magicmouse_multitouch_rel_desc) ; ++i) {
> +		magicmouse_register_descriptor(&(magicmouse_multitouch_rel_desc[i]),
> +			0, report);
> +	}
> +
> +	for (i = 0 ; i < ArrayLength(magicmouse_multitouch_abs_desc) ; ++i) {
> +		magicmouse_register_descriptor(&(magicmouse_multitouch_abs_desc[i]),
> +			1, report);
> +	}
> +
> +	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +	if (ret) {
> +		dev_err(&hdev->dev, "magicmouse hw start failed\n");
> +		goto err_free;
> +	}
>  
>  	ret = hdev->hid_output_raw_report(hdev, feature_1, sizeof(feature_1),
>  			HID_FEATURE_REPORT);
> @@ -382,24 +544,7 @@ static int magicmouse_probe(struct hid_device *hdev,
>  		goto err_stop_hw;
>  	}
>  
> -	input = input_allocate_device();
> -	if (!input) {
> -		dev_err(&hdev->dev, "can't alloc input device\n");
> -		ret = -ENOMEM;
> -		goto err_stop_hw;
> -	}
> -	magicmouse_setup_input(input, hdev);
> -
> -	ret = input_register_device(input);
> -	if (ret) {
> -		dev_err(&hdev->dev, "input device registration failed\n");
> -		goto err_input;
> -	}
> -	msc->input = input;
> -
>  	return 0;
> -err_input:
> -	input_free_device(input);
>  err_stop_hw:
>  	hid_hw_stop(hdev);
>  err_free:
> @@ -426,6 +571,7 @@ static struct hid_driver magicmouse_driver = {
>  	.probe = magicmouse_probe,
>  	.remove = magicmouse_remove,
>  	.raw_event = magicmouse_raw_event,
> +	.input_mapping = magicmouse_input_mapping,
>  };
>  
>  static int __init magicmouse_init(void)
> -- 1.6.6.1 
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
