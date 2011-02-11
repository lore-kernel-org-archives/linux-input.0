From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 4/4] input - wacom: Support 2FGT in MT format
Date: Fri, 11 Feb 2011 21:20:10 +0100
Message-ID: <20110211202010.GB2287@polaris.bitmath.org>
References: <1297387983-13761-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:53665 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756989Ab1BKUUh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Feb 2011 15:20:37 -0500
Content-Disposition: inline
In-Reply-To: <1297387983-13761-1-git-send-email-pinglinux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

Hi Ping,

On Thu, Feb 10, 2011 at 05:33:03PM -0800, Ping Cheng wrote:

Given the nice patch below, there has to be _something_ to say about it here, hmm?

> Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---
>  drivers/input/tablet/wacom_sys.c |   12 ++++----
>  drivers/input/tablet/wacom_wac.c |   61 ++++++++++++++++++++++++++++++-------
>  2 files changed, 55 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
> index fc38149..b97665f 100644
> --- a/drivers/input/tablet/wacom_sys.c
> +++ b/drivers/input/tablet/wacom_sys.c
> @@ -193,16 +193,16 @@ static int wacom_parse_hid(struct usb_interface *intf, struct hid_descriptor *hi
>  			case HID_USAGE_X:
>  				if (usage == WCM_DESKTOP) {
>  					if (finger) {
> -						features->device_type = BTN_TOOL_DOUBLETAP;
> +						features->device_type = BTN_TOOL_FINGER;
>  						if (features->type == TABLETPC2FG) {
>  							/* need to reset back */
>  							features->pktlen = WACOM_PKGLEN_TPC2FG;
> -							features->device_type = BTN_TOOL_TRIPLETAP;
> +							features->device_type = BTN_TOOL_DOUBLETAP;
>  						}
>  						if (features->type == BAMBOO_PT) {
>  							/* need to reset back */
>  							features->pktlen = WACOM_PKGLEN_BBTOUCH;
> -							features->device_type = BTN_TOOL_TRIPLETAP;
> +							features->device_type = BTN_TOOL_DOUBLETAP;
>  							features->x_phy =
>  								get_unaligned_le16(&report[i + 5]);
>  							features->x_max =
> @@ -241,11 +241,11 @@ static int wacom_parse_hid(struct usb_interface *intf, struct hid_descriptor *hi
>  			case HID_USAGE_Y:
>  				if (usage == WCM_DESKTOP) {
>  					if (finger) {
> -						features->device_type = BTN_TOOL_DOUBLETAP;
> +						features->device_type = BTN_TOOL_FINGER;
>  						if (features->type == TABLETPC2FG) {
>  							/* need to reset back */
>  							features->pktlen = WACOM_PKGLEN_TPC2FG;
> -							features->device_type = BTN_TOOL_TRIPLETAP;
> +							features->device_type = BTN_TOOL_DOUBLETAP;
>  							features->y_max =
>  								get_unaligned_le16(&report[i + 3]);
>  							features->y_phy =
> @@ -254,7 +254,7 @@ static int wacom_parse_hid(struct usb_interface *intf, struct hid_descriptor *hi
>  						} else if (features->type == BAMBOO_PT) {
>  							/* need to reset back */
>  							features->pktlen = WACOM_PKGLEN_BBTOUCH;
> -							features->device_type = BTN_TOOL_TRIPLETAP;
> +							features->device_type = BTN_TOOL_DOUBLETAP;
>  							features->y_phy =
>  								get_unaligned_le16(&report[i + 3]);
>  							features->y_max =
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
> index fc0669d..39c289d 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -675,6 +675,38 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
>  	return 1;
>  }
>  
> +static int wacom_tpc_mt_touch(struct wacom_wac *wacom)
> +{
> +	struct input_dev *input = wacom->input;
> +	unsigned char *data = wacom->data;
> +	int i;
> +
> +	if (wacom->shared->stylus_in_proximity && !wacom->shared->touch_down)
> +		return 0;

Seeing one case handled out of four possible always makes me nervous.

> +
> +	for (i = 0; i < 2; i++) {
> +		int p = data[1] & (1 << i);
> +		bool touch = p && !wacom->shared->stylus_in_proximity;
> +
> +		input_mt_slot(input, i);
> +		input_mt_report_slot_state(input, MT_TOOL_FINGER, touch);
> +		if (touch) {
> +			int x = le16_to_cpup((__le16 *)&data[i * 2 + 2]) & 0x7fff;
> +			int y = le16_to_cpup((__le16 *)&data[i * 2 + 6]) & 0x7fff;
> +
> +			input_report_abs(input, ABS_MT_POSITION_X, x);
> +			input_report_abs(input, ABS_MT_POSITION_Y, y);
> +		}
> +
> +		/* keep touch bit to send proper touch up event */
> +		wacom->shared->touch_down = max(touch, wacom->shared->touch_down);

So only false->true is possible here. What I can see from the
patchset, only wacom_tpc_single_touch() will ever set touch_down to
false. Is that sufficient?

> +	}
> +
> +	input_mt_report_pointer_emulation(input, true);
> +
> +	return 1;
> +}
> +
>  static int wacom_tpc_single_touch(struct wacom_wac *wacom, size_t len)
>  {
>  	char *data = wacom->data;
> @@ -753,6 +785,8 @@ static int wacom_tpc_irq(struct wacom_wac *wacom, size_t len)
>  
>  	if (len == WACOM_PKGLEN_TPC1FG || data[0] == WACOM_REPORT_TPC1FG)
>  		return wacom_tpc_single_touch(wacom, len);
> +	else if (data[0] == WACOM_REPORT_TPC2FG)
> +		return wacom_tpc_mt_touch(wacom);
>  	else if (data[0] == WACOM_REPORT_PENABLED)
>  		return wacom_tpc_pen(wacom);
>  
> @@ -979,7 +1013,7 @@ void wacom_setup_device_quirks(struct wacom_features *features)
>  {
>  
>  	/* touch device found but size is not defined. use default */
> -	if (features->device_type == BTN_TOOL_DOUBLETAP && !features->x_max) {
> +	if (features->device_type == BTN_TOOL_FINGER && !features->x_max) {
>  		features->x_max = 1023;
>  		features->y_max = 1023;
>  	}
> @@ -991,7 +1025,7 @@ void wacom_setup_device_quirks(struct wacom_features *features)
>  
>  	/* quirks for bamboo touch */
>  	if (features->type == BAMBOO_PT &&
> -	    features->device_type == BTN_TOOL_TRIPLETAP) {
> +	    features->device_type == BTN_TOOL_DOUBLETAP) {
>  		features->x_max <<= 5;
>  		features->y_max <<= 5;
>  		features->x_fuzz <<= 5;
> @@ -1127,28 +1161,31 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
>  		break;
>  
>  	case TABLETPC2FG:
> -		if (features->device_type == BTN_TOOL_TRIPLETAP) {
> -			__set_bit(BTN_TOOL_TRIPLETAP, input_dev->keybit);
> -			input_set_capability(input_dev, EV_MSC, MSC_SERIAL);
> +		if (features->device_type == BTN_TOOL_DOUBLETAP) {
> +			__set_bit(BTN_TOOL_DOUBLETAP, input_dev->keybit);
> +
> +			input_mt_init_slots(input_dev, 2);
> +			input_set_abs_params(input_dev, ABS_MT_TOOL_TYPE,
> +					0, MT_TOOL_MAX, 0, 0);
> +			input_set_abs_params(input_dev, ABS_MT_POSITION_X,
> +					0, features->x_max, 0, 0);
> +			input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
> +					0, features->y_max, 0, 0);
>  		}
>  		/* fall through */
>  
>  	case TABLETPC:
>  		__clear_bit(ABS_MISC, input_dev->absbit);
>  
> -		if (features->device_type == BTN_TOOL_DOUBLETAP ||
> -		    features->device_type == BTN_TOOL_TRIPLETAP) {
> +		if (features->device_type != BTN_TOOL_PEN) {
>  			input_abs_set_res(input_dev, ABS_X,
>  				wacom_calculate_touch_res(features->x_max,
>  							features->x_phy));
>  			input_abs_set_res(input_dev, ABS_Y,
>  				wacom_calculate_touch_res(features->y_max,
>  							features->y_phy));
> -		}
> -
> -		if (features->device_type != BTN_TOOL_PEN)
>  			break;  /* no need to process stylus stuff */
> -
> +		}
>  		/* fall through */
>  
>  	case PL:
> @@ -1166,7 +1203,7 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
>  	case BAMBOO_PT:
>  		__clear_bit(ABS_MISC, input_dev->absbit);
>  
> -		if (features->device_type == BTN_TOOL_TRIPLETAP) {
> +		if (features->device_type == BTN_TOOL_DOUBLETAP) {
>  			__set_bit(BTN_LEFT, input_dev->keybit);
>  			__set_bit(BTN_FORWARD, input_dev->keybit);
>  			__set_bit(BTN_BACK, input_dev->keybit);
> -- 

Thanks,
Henrik
