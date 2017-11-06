From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2 3/3] HID: multitouch: Fix BTN_LEFT on some touchpads
Date: Mon, 6 Nov 2017 19:05:55 +0100
Message-ID: <20171106180555.GP9728@mail.corp.redhat.com>
References: <20171106150149.13986-1-hdegoede@redhat.com>
 <20171106150149.13986-3-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55986 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753726AbdKFSGC (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 6 Nov 2017 13:06:02 -0500
Content-Disposition: inline
In-Reply-To: <20171106150149.13986-3-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org

On Nov 06 2017 or thereabouts, Hans de Goede wrote:
> This commit fixes 2 different issues with BTN_LEFT on touchpads in one go:
> 
> 1) Devices in "single finger hybrid mode" will send one report per finger,
>    on some devices only the first report of such a multi-packet frame will
>    contain a value for BTN_LEFT, in subsequent reports (if multiple fingers
>    are down) the value is always 0, causing hid-mt to report BTN_LEFT going
>    1 - 0 - 1 - 0 when pressing a clickpad and putting down a second finger.
>    This happens for example on USB 0603:0002 mt touchpads.
> 
> 2) According to the Win8 Precision Touchpad spec, inside the HID_UP_BUTTON
>    usage-page usage 1 is for a clickpad getting clicked, 2 for an external
>    left button and 3 for an external right button. Since Linux uses
>    BTN_LEFT for a clickpad being clicked we end up mapping both usage 1
>    and 2 to BTN_LEFT and if a single report contains both then we ended
>    up always reporting the value of both in a single SYN, e.g. :
>    BTN_LEFT 1, BTN_LEFT 0, SYN. This happens for example with SYNA3602
>    i2c mt touchpads.
> 
> This commit fixes both issues by not immediately reporting BTN_LEFT when
> we parse the report, but instead or-ing the values of all fields mapped
> to BTN_LEFT together and reporting the result from mt_sync_frame()
> when we've a complete frame.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Rewrite of v1 of "HID: multitouch: Fix BTN_LEFT 0-1-0-1 events on Novatek
>  mt touchpad" to kill two birds with one stone
> ---
>  drivers/hid/hid-multitouch.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 76a3e9e074ba..bacbd1ba75ba 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -117,6 +117,7 @@ struct mt_device {
>  	unsigned long mt_io_flags;	/* mt flags (MT_IO_FLAGS_*) */
>  	int cc_index;	/* contact count field index in the report */
>  	int cc_value_index;	/* contact count value index in the field */
> +	int btn_left;		/* BTN_LEFT state */
>  	unsigned last_slot_field;	/* the last field of a slot */
>  	unsigned mt_report_id;	/* the report ID of the multitouch device */
>  	unsigned long initial_quirks;	/* initial quirks state */
> @@ -717,9 +718,11 @@ static void mt_complete_slot(struct mt_device *td, struct input_dev *input)
>   */
>  static void mt_sync_frame(struct mt_device *td, struct input_dev *input)
>  {
> +	input_event(input, EV_KEY, BTN_LEFT, td->btn_left);
>  	input_mt_sync_frame(input);
>  	input_sync(input);
>  	td->num_received = 0;
> +	td->btn_left = 0;
>  	if (test_bit(MT_IO_FLAGS_ACTIVE_SLOTS, &td->mt_io_flags))
>  		set_bit(MT_IO_FLAGS_PENDING_SLOTS, &td->mt_io_flags);
>  	else
> @@ -794,6 +797,17 @@ static void mt_process_mt_event(struct hid_device *hid, struct hid_field *field,
>  			break;
>  
>  		default:
> +			/*
> +			 * On some hardware we get multiple BTN_LEFT reports
> +			 * per frame, with only 1 report reporting 1 if pressed.
> +			 * So for BTN_LEFT we or the values together and
> +			 * report the combined state in mt_sync_frame()
> +			 */
> +			if (usage->type == EV_KEY && usage->code == BTN_LEFT) {
> +				td->btn_left |= value;

Nah... We need to delay all the non multitouch events in the report if
we are not in the first report. This only fixes BTN_LEFT, but BTN_RIGHT
and others should also be fixed.

And for the point 2 you are raising, we should probably not map the
first button in case of a Precision Touchpad which is a non clickpad
one.

I still think you should rely on the scan time to detect the beginning
of the frame. If you store the current scan time and remember if we are
at the beginning or not of the frame (in mt_touch_report()), this should
be pretty straightforward to fix.

Cheers,
Benjamin

> +				return;
> +			}
> +
>  			if (usage->type)
>  				input_event(input, usage->type, usage->code,
>  						value);
> -- 
> 2.14.3
> 
