From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 5/5] HID: sony: Handle multiple touch events input record
Date: Wed, 5 Oct 2016 10:35:49 +0200
Message-ID: <20161005083548.GC19261@mail.corp.redhat.com>
References: <1475636338-3779-1-git-send-email-roderick@gaikai.com>
 <1475636338-3779-6-git-send-email-roderick@gaikai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47442 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753174AbcJEIf7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 5 Oct 2016 04:35:59 -0400
Content-Disposition: inline
In-Reply-To: <1475636338-3779-6-git-send-email-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roderick Colenbrander <roderick@gaikai.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Oct 04 2016 or thereabouts, Roderick Colenbrander wrote:
> From: Roderick Colenbrander <roderick.colenbrander@sony.com>
> 
> Read the touch history field in the HID descriptor and use this value
> to determine how many touch events to read from the report. As part
> of this patch, we did a first attempt of making the offset calculation
> code less magical.
> 
> Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
> ---
>  drivers/hid/hid-sony.c | 76 +++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 50 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index 24f7d19..2387aaf 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -1030,6 +1030,12 @@ struct motion_output_report_02 {
>  #define SIXAXIS_REPORT_0xF5_SIZE 8
>  #define MOTION_REPORT_0x02_SIZE 49
>  
> +/* Offsets relative to USB input report (0x1). Bluetooth (0x11) requires an
> + * additional +2.
> + */
> +#define DS4_INPUT_REPORT_BATTERY_OFFSET  30
> +#define DS4_INPUT_REPORT_TOUCHPAD_OFFSET 33
> +
>  static DEFINE_SPINLOCK(sony_dev_list_lock);
>  static LIST_HEAD(sony_device_list);
>  static DEFINE_IDA(sony_device_id_allocator);
> @@ -1226,19 +1232,17 @@ static void dualshock4_parse_report(struct sony_sc *sc, u8 *rd, int size)
>  						struct hid_input, list);
>  	struct input_dev *input_dev = hidinput->input;
>  	unsigned long flags;
> -	int n, offset;
> +	int n, m, offset, num_touch_data, max_touch_data;
>  	u8 cable_state, battery_capacity, battery_charging;
>  
> -	/*
> -	 * Battery and touchpad data starts at byte 30 in the USB report and
> -	 * 32 in Bluetooth report.
> -	 */
> -	offset = (sc->quirks & DUALSHOCK4_CONTROLLER_USB) ? 30 : 32;
> +	/* When using Bluetooth the header is 2 bytes longer, so skip these. */
> +	int data_offset = (sc->quirks & DUALSHOCK4_CONTROLLER_USB) ? 0 : 2;
>  
>  	/*
> -	 * The lower 4 bits of byte 30 contain the battery level
> +	 * The lower 4 bits of byte 30 (or 32 for BT) contain the battery level
>  	 * and the 5th bit contains the USB cable state.
>  	 */
> +	offset = data_offset + DS4_INPUT_REPORT_BATTERY_OFFSET;
>  	cable_state = (rd[offset] >> 4) & 0x01;
>  	battery_capacity = rd[offset] & 0x0F;
>  
> @@ -1265,30 +1269,50 @@ static void dualshock4_parse_report(struct sony_sc *sc, u8 *rd, int size)
>  	sc->battery_charging = battery_charging;
>  	spin_unlock_irqrestore(&sc->lock, flags);
>  
> -	offset += 5;
> -
>  	/*
> -	 * The Dualshock 4 multi-touch trackpad data starts at offset 35 on USB
> -	 * and 37 on Bluetooth.
> -	 * The first 7 bits of the first byte is a counter and bit 8 is a touch
> -	 * indicator that is 0 when pressed and 1 when not pressed.
> -	 * The next 3 bytes are two 12 bit touch coordinates, X and Y.
> -	 * The data for the second touch is in the same format and immediatly
> -	 * follows the data for the first.
> +	 * The Dualshock 4 multi-touch trackpad data starts at offset 33 on USB
> +	 * and 35 on Bluetooth.
> +	 * The first byte indicates the number of touch data in the report.
> +	 * Trackpad data starts 2 bytes later (e.g. 35 for USB).
>  	 */
> -	for (n = 0; n < 2; n++) {
> -		u16 x, y;
> +	offset = data_offset + DS4_INPUT_REPORT_TOUCHPAD_OFFSET;
> +	max_touch_data = (sc->quirks & DUALSHOCK4_CONTROLLER_USB) ? 3 : 4;
> +	if (rd[offset] > 0 && rd[offset] <= max_touch_data)
> +		num_touch_data = rd[offset];
> +	else
> +		num_touch_data = 1;
> +	offset += 1;
>  
> -		x = rd[offset+1] | ((rd[offset+2] & 0xF) << 8);
> -		y = ((rd[offset+2] & 0xF0) >> 4) | (rd[offset+3] << 4);
> +	for (m = 0; m < num_touch_data; m++) {
> +		/* Skip past timestamp */
> +		offset += 1;
>  
> -		input_mt_slot(input_dev, n);
> -		input_mt_report_slot_state(input_dev, MT_TOOL_FINGER,
> -					!(rd[offset] >> 7));
> -		input_report_abs(input_dev, ABS_MT_POSITION_X, x);
> -		input_report_abs(input_dev, ABS_MT_POSITION_Y, y);
> +		/*
> +		 * The first 7 bits of the first byte is a counter and bit 8 is
> +		 * a touch indicator that is 0 when pressed and 1 when not
> +		 * pressed.
> +		 * The next 3 bytes are two 12 bit touch coordinates, X and Y.
> +		 * The data for the second touch is in the same format and
> +		 * immediately follows the data for the first.
> +		 */
> +		for (n = 0; n < 2; n++) {
> +			u16 x, y;
> +			bool active;
> +
> +			x = rd[offset+1] | ((rd[offset+2] & 0xF) << 8);
> +			y = ((rd[offset+2] & 0xF0) >> 4) | (rd[offset+3] << 4);
> +
> +			active = !(rd[offset] >> 7);
> +			input_mt_slot(input_dev, n);

Just to be sure, the device reports 2 touches only, and the
"num_touch_data" chunks are just the history of these 2 touches, the
last chunk being the last known touches?

If so, then why aren't you simply jumping to the last valid value?
If not, then you probably need to report (n+m*2) slot, and change the
input_mt_init_slot parameter as well.

Cheers,
Benjamin

> +			input_mt_report_slot_state(input_dev, MT_TOOL_FINGER, active);
>  
> -		offset += 4;
> +			if (active) {
> +				input_report_abs(input_dev, ABS_MT_POSITION_X, x);
> +				input_report_abs(input_dev, ABS_MT_POSITION_Y, y);
> +			}
> +
> +			offset += 4;
> +		}
>  	}
>  }
>  
> -- 
> 2.7.4
> 
