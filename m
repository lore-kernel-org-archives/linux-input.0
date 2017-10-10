From: Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: [PATCH v4] HID: hid-multitouch: support fine-grain orientation
 reporting
Date: Tue, 10 Oct 2017 08:57:40 +0200
Message-ID: <20171010065740.GA22909@mars.bitmath.org>
References: <20171010041631.22093-1-wnhuang@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171010041631.22093-1-wnhuang@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei-Ning Huang <wnhuang@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Dmitry Torokhov <dtor@chromium.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

Hi Wei-Ning,

> The current hid-multitouch driver only allow the report of two
> orientations, vertical and horizontal. We use the Azimuth orientation
> usage 0x3F under the Digitizer usage page to report orientation if the
> device supports it.
> 
> Changelog:
>   v1 -> v2:
>    - Fix commit message.
>    - Remove resolution reporting for ABS_MT_ORIENTATION.
>   v2 -> v3:
>    - Fix commit message.
>   v3 -> v4:
>    - Fix ABS_MT_ORIENTATION ABS param range.
>    - Don't set ABS_MT_ORIENTATION in ABS_DG_HEIGHT when it is already
>      set by ABS_DG_AZIMUTH.
> 
> Signed-off-by: Wei-Ning Huang <wnhuang@chromium.org>
> Reviewed-by: Dmitry Torokhov <dtor@chromium.org>
> ---
>  drivers/hid/hid-multitouch.c | 52 ++++++++++++++++++++++++++++++++++++++++----
>  include/linux/hid.h          |  1 +
>  2 files changed, 49 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 440b999304a5..3317dae64ef7 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -84,11 +84,12 @@ MODULE_LICENSE("GPL");
>  #define MT_IO_FLAGS_PENDING_SLOTS	2
>  
>  struct mt_slot {
> -	__s32 x, y, cx, cy, p, w, h;
> +	__s32 x, y, cx, cy, p, w, h, a;
>  	__s32 contactid;	/* the device ContactID assigned to this slot */
>  	bool touch_state;	/* is the touch valid? */
>  	bool inrange_state;	/* is the finger in proximity of the sensor? */
>  	bool confidence_state;  /* is the touch made by a finger? */
> +	bool has_azimuth;       /* the contact reports azimuth */
>  };
>  
>  struct mt_class {
> @@ -571,8 +572,15 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>  			if (!(cls->quirks & MT_QUIRK_NO_AREA)) {
>  				set_abs(hi->input, ABS_MT_TOUCH_MINOR, field,
>  					cls->sn_height);
> -				input_set_abs_params(hi->input,
> -					ABS_MT_ORIENTATION, 0, 1, 0, 0);
> +
> +				/*
> +				 * Only set ABS_MT_ORIENTATION if it is not
> +				 * already set by the HID_DG_AZIMUTH usage.
> +				 */
> +				if (!test_bit(ABS_MT_ORIENTATION,
> +						hi->input->absbit))
> +					input_set_abs_params(hi->input,
> +						ABS_MT_ORIENTATION, 0, 1, 0, 0);
>  			}
>  			mt_store_field(usage, td, hi);
>  			return 1;
> @@ -591,6 +599,21 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>  			td->cc_index = field->index;
>  			td->cc_value_index = usage->usage_index;
>  			return 1;
> +		case HID_DG_AZIMUTH:
> +			hid_map_usage(hi, usage, bit, max,
> +				EV_ABS, ABS_MT_ORIENTATION);
> +			/*
> +			 * Azimuth has the range of [0, MAX) representing a full
> +			 * revolution. Set ABS_MT_ORIENTATION to a quarter of
> +			 * MAX according the definition of ABS_MT_ORIENTATION
> +			 */
> +			input_set_abs_params(hi->input, ABS_MT_ORIENTATION,
> +				-field->logical_maximum / 4,
> +				field->logical_maximum / 4,
> +				cls->sn_move ?
> +				field->logical_maximum / cls->sn_move : 0, 0);
> +			mt_store_field(usage, td, hi);
> +			return 1;
>  		case HID_DG_CONTACTMAX:
>  			/* we don't set td->last_slot_field as contactcount and
>  			 * contact max are global to the report */
> @@ -683,6 +706,10 @@ static void mt_complete_slot(struct mt_device *td, struct input_dev *input)
>  			int wide = (s->w > s->h);
>  			int major = max(s->w, s->h);
>  			int minor = min(s->w, s->h);
> +			int orientation = wide;
> +
> +			if (s->has_azimuth)
> +				orientation = s->a;
>  
>  			/*
>  			 * divided by two to match visual scale of touch
> @@ -699,7 +726,8 @@ static void mt_complete_slot(struct mt_device *td, struct input_dev *input)
>  			input_event(input, EV_ABS, ABS_MT_TOOL_Y, s->cy);
>  			input_event(input, EV_ABS, ABS_MT_DISTANCE,
>  				!s->touch_state);
> -			input_event(input, EV_ABS, ABS_MT_ORIENTATION, wide);
> +			input_event(input, EV_ABS, ABS_MT_ORIENTATION,
> +				orientation);
>  			input_event(input, EV_ABS, ABS_MT_PRESSURE, s->p);
>  			input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, major);
>  			input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR, minor);
> @@ -789,6 +817,22 @@ static void mt_process_mt_event(struct hid_device *hid, struct hid_field *field,
>  			break;
>  		case HID_DG_CONTACTCOUNT:
>  			break;
> +		case HID_DG_AZIMUTH:
> +			/*
> +			 * Azimuth is counter-clockwise and ranges from [0, MAX)
> +			 * (a full revolution). Convert it to clockwise ranging
> +			 * [-MAX/2, MAX/2].
> +			 *
> +			 * Note that ABS_MT_ORIENTATION require us to report
> +			 * the limit of [-MAX/4, MAX/4], but the value can go
> +			 * out of range to [-MAX/2, MAX/2] to report an upside
> +			 * down ellipsis.
> +			 */
> +			if (value > field->logical_maximum / 2)
> +				value -= field->logical_maximum;
> +			td->curdata.a = -value;
> +			td->curdata.has_azimuth = true;
> +			break;
>  		case HID_DG_TOUCH:
>  			/* do nothing */
>  			break;
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index ab05a86269dc..d81b9b6fd83a 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -281,6 +281,7 @@ struct hid_item {
>  
>  #define HID_DG_DEVICECONFIG	0x000d000e
>  #define HID_DG_DEVICESETTINGS	0x000d0023
> +#define HID_DG_AZIMUTH		0x000d003f
>  #define HID_DG_CONFIDENCE	0x000d0047
>  #define HID_DG_WIDTH		0x000d0048
>  #define HID_DG_HEIGHT		0x000d0049
> -- 
> 2.12.2
> 

Acked-by: Henrik Rydberg <rydberg@bitmath.org>

This version looks good - thank you Wei-Ning, thank you Benjamin.

Henrik
