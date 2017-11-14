From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v4 4/4] HID: multitouch: Combine all left-button events
 in a frame
Date: Tue, 14 Nov 2017 09:02:29 +0100
Message-ID: <20171114080229.GE403@mail.corp.redhat.com>
References: <20171113163259.18150-1-hdegoede@redhat.com>
 <20171113163259.18150-4-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37002 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751626AbdKNICf (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 14 Nov 2017 03:02:35 -0500
Content-Disposition: inline
In-Reply-To: <20171113163259.18150-4-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org

On Nov 13 2017 or thereabouts, Hans de Goede wrote:
> According to the Win8 Precision Touchpad spec, inside the HID_UP_BUTTON
> usage-page usage 1 is for a clickpad getting clicked, 2 for an external
> left button and 3 for an external right button. Since Linux uses
> BTN_LEFT for a clickpad being clicked we end up mapping both usage 1
> and 2 to BTN_LEFT and if a single report contains both then we ended
> up always reporting the value of both in a single SYN, e.g. :
> BTN_LEFT 1, BTN_LEFT 0, SYN. This happens for example with Hantick
> HTT5288 i2c mt touchpads.
> 
> This commit fixes this by not immediately reporting left button when we
> parse the report, but instead storing or-ing together the values and
> reporting the result from mt_sync_frame() when we've a complete frame.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Thanks Hans for the re-spin of the series.
I think we are good now, series is:

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> Changes in v2:
> -Rewrite of v1 of "HID: multitouch: Fix BTN_LEFT 0-1-0-1 events on Novatek
>  mt touchpad" to kill two birds with one stone
> 
> Changes in v3:
> -Delay reporting for all buttons not just for BTN_LEFT
> 
> Changes in v4:
> -Back to combining only the value for BTN_LEFT, the other issues are fixed
>  with the new "HID: multitouch: Only look at non touch fields in first
>  packet of a frame" patch
> ---
>  drivers/hid/hid-multitouch.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index bc6a4f13c9ae..00d4e32681b1 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -120,6 +120,7 @@ struct mt_device {
>  	int scantime_index;	/* scantime field index in the report */
>  	int scantime_val_index;	/* scantime value index in the field */
>  	int prev_scantime;	/* scantime reported in the previous packet */
> +	int left_button_state;	/* left button state */
>  	unsigned last_slot_field;	/* the last field of a slot */
>  	unsigned mt_report_id;	/* the report ID of the multitouch device */
>  	unsigned long initial_quirks;	/* initial quirks state */
> @@ -728,9 +729,15 @@ static void mt_complete_slot(struct mt_device *td, struct input_dev *input)
>   */
>  static void mt_sync_frame(struct mt_device *td, struct input_dev *input)
>  {
> +	__s32 cls = td->mtclass.name;
> +
> +	if (cls == MT_CLS_WIN_8 || cls == MT_CLS_WIN_8_DUAL)
> +		input_event(input, EV_KEY, BTN_LEFT, td->left_button_state);
> +
>  	input_mt_sync_frame(input);
>  	input_sync(input);
>  	td->num_received = 0;
> +	td->left_button_state = 0;
>  	if (test_bit(MT_IO_FLAGS_ACTIVE_SLOTS, &td->mt_io_flags))
>  		set_bit(MT_IO_FLAGS_PENDING_SLOTS, &td->mt_io_flags);
>  	else
> @@ -816,6 +823,19 @@ static void mt_process_mt_event(struct hid_device *hid, struct hid_field *field,
>  			    !first_packet)
>  				return;
>  
> +			/*
> +			 * For Win8 PTP touchpads we map both the clickpad click
> +			 * and any "external" left buttons to BTN_LEFT if a
> +			 * device claims to have both we need to report 1 for
> +			 * BTN_LEFT if either is pressed, so we or all values
> +			 * together and report the result in mt_sync_frame().
> +			 */
> +			if ((cls == MT_CLS_WIN_8 || cls == MT_CLS_WIN_8_DUAL) &&
> +			    usage->type == EV_KEY && usage->code == BTN_LEFT) {
> +				td->left_button_state |= value;
> +				return;
> +			}
> +
>  			if (usage->type)
>  				input_event(input, usage->type, usage->code,
>  						value);
> -- 
> 2.14.3
> 
