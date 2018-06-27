From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH v3 12/12] HID: multitouch: handle palm for touchscreens
Date: Wed, 27 Jun 2018 11:10:11 +1000
Message-ID: <20180627011011.GC25847@jelly>
References: <20180621120908.16706-1-benjamin.tissoires@redhat.com>
 <20180621120908.16706-13-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180621120908.16706-13-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mario.Limonciello@dell.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Jun 21, 2018 at 02:09:08PM +0200, Benjamin Tissoires wrote:
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Usually, there is no palm rejection for touchscreens. You don't rest
> your palm on the touchscreen while interacting with it.
> However, some wacom devices do so because you can rest your palm while
> interacting with the stylus.
> 
> Unfortunately, the spec for touchscreens[1] is less precise than the one
> for touchpads[2]. This leads to a situation where it's 'legitimate'
> for a touchscreen to provide both tipswitch off and confidence off in the
> same report.
> 
> Work around that by keeping the slot active for one frame where we report
> MT_TOOL_PALM, and then synthesizing the release event in a separate frame.
> frame
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> [rebased and new commit message]
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Acked-by: Peter Hutterer <peter.hutterer@who-t.net>

to the series unless otherwise noted.

Cheers,
   Peter

> ---
> changes in v2 (compared to Dmitry's initial submission):
> - extracted from the initial submission in a separate patch
> - rebased on top of my current series
> - add an extra input_mt_sync_frame(input); to release the single touch
>   emulation
> 
> no changes in v3
> ---
>  drivers/hid/hid-multitouch.c | 52 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 9c708aa261ee..3a1c2d80729b 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -118,6 +118,9 @@ struct mt_application {
>  	int left_button_state;		/* left button state */
>  	unsigned int mt_flags;		/* flags to pass to input-mt */
>  
> +	unsigned long *pending_palm_slots;	/* slots where we reported palm
> +						 * and need to release */
> +
>  	__u8 num_received;	/* how many contacts we received */
>  	__u8 num_expected;	/* expected last contact index */
>  	__u8 buttons_count;	/* number of physical buttons per touchpad */
> @@ -863,6 +866,28 @@ static int mt_compute_slot(struct mt_device *td, struct mt_application *app,
>  	return input_mt_get_slot_by_key(input, *slot->contactid);
>  }
>  
> +static void mt_release_pending_palms(struct mt_device *td,
> +				     struct mt_application *app,
> +				     struct input_dev *input)
> +{
> +	int slotnum;
> +	bool need_sync = false;
> +
> +	for_each_set_bit(slotnum, app->pending_palm_slots, td->maxcontacts) {
> +		clear_bit(slotnum, app->pending_palm_slots);
> +
> +		input_mt_slot(input, slotnum);
> +		input_mt_report_slot_state(input, MT_TOOL_PALM, false);
> +
> +		need_sync = true;
> +	}
> +
> +	if (need_sync) {
> +		input_mt_sync_frame(input);
> +		input_sync(input);
> +	}
> +}
> +
>  /*
>   * this function is called when a whole packet has been received and processed,
>   * so that it can decide what to send to the input layer.
> @@ -876,6 +901,9 @@ static void mt_sync_frame(struct mt_device *td, struct mt_application *app,
>  	input_mt_sync_frame(input);
>  	input_event(input, EV_MSC, MSC_TIMESTAMP, app->timestamp);
>  	input_sync(input);
> +
> +	mt_release_pending_palms(td, app, input);
> +
>  	app->num_received = 0;
>  	app->left_button_state = 0;
>  
> @@ -970,8 +998,23 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
>  
>  	if (app->application == HID_GD_SYSTEM_MULTIAXIS)
>  		tool = MT_TOOL_DIAL;
> -	else if (unlikely(!confidence_state))
> +	else if (unlikely(!confidence_state)) {
>  		tool = MT_TOOL_PALM;
> +		if (!active &&
> +		    input_mt_is_active(&mt->slots[slotnum])) {
> +			/*
> +			 * The non-confidence was reported for
> +			 * previously valid contact that is also no
> +			 * longer valid. We can't simply report
> +			 * lift-off as userspace will not be aware
> +			 * of non-confidence, so we need to split
> +			 * it into 2 events: active MT_TOOL_PALM
> +			 * and a separate liftoff.
> +			 */
> +			active = true;
> +			set_bit(slotnum, app->pending_palm_slots);
> +		}
> +	}
>  
>  	input_mt_slot(input, slotnum);
>  	input_mt_report_slot_state(input, tool, active);
> @@ -1206,6 +1249,13 @@ static int mt_touch_input_configured(struct hid_device *hdev,
>  	if (td->is_buttonpad)
>  		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
>  
> +	app->pending_palm_slots = devm_kcalloc(&hi->input->dev,
> +					       BITS_TO_LONGS(td->maxcontacts),
> +					       sizeof(long),
> +					       GFP_KERNEL);
> +	if (!app->pending_palm_slots)
> +		return -ENOMEM;
> +
>  	ret = input_mt_init_slots(input, td->maxcontacts, app->mt_flags);
>  	if (ret)
>  		return ret;
> -- 
> 2.14.3
> 
