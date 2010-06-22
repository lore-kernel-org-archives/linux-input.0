From: Michael Poole <mdpoole@troilus.org>
Subject: Re: [PATCH 3/3] HID: magicmouse: enable horizontal scrolling
Date: Mon, 21 Jun 2010 21:29:08 -0400
Message-ID: <87eifzdfdn.fsf@troilus.org>
References: <1277083951-29137-1-git-send-email-chase.douglas@canonical.com>
	<1277083951-29137-4-git-send-email-chase.douglas@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:59046 "HELO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758732Ab0FVB3M (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Jun 2010 21:29:12 -0400
Received: by mail-vw0-f53.google.com with SMTP id 2so918202vws.40
        for <linux-input@vger.kernel.org>; Mon, 21 Jun 2010 18:29:11 -0700 (PDT)
In-Reply-To: <1277083951-29137-4-git-send-email-chase.douglas@canonical.com>
	(Chase Douglas's message of "Sun, 20 Jun 2010 21:32:31 -0400")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

Chase Douglas writes:

> Mimicks OS X behavior.
>
> Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
> ---
>  drivers/hid/hid-magicmouse.c |   25 +++++++++++++++++++------
>  1 files changed, 19 insertions(+), 6 deletions(-)

I like this general idea, but Dmitry Torokhov didn't like my previous
patch to achieve a similar effect:
https://patchwork.kernel.org/patch/84201/

The only behavioral question I would have is whether a single
touch/swipe should be locked in one direction or if it should be able to
generate both horizontal and vertical scroll events.  That seems like a
user preference thing to me.

(My real wish is for X and the various widget libraries to get decent
multitouch support soon, so that the kernel doesn't have to address
those policy questions.)

Michael

> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
> index fe0c760..0b89c1c 100644
> --- a/drivers/hid/hid-magicmouse.c
> +++ b/drivers/hid/hid-magicmouse.c
> @@ -95,6 +95,7 @@ struct magicmouse_sc {
>  	struct {
>  		short x;
>  		short y;
> +		short scroll_x;
>  		short scroll_y;
>  		u8 size;
>  	} touches[16];
> @@ -181,11 +182,13 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
>  	 */
>  	if (emulate_scroll_wheel) {
>  		unsigned long now = jiffies;
> -		int step = msc->touches[id].scroll_y - y;
> +		int step_x = msc->touches[id].scroll_x - x;
> +		int step_y = msc->touches[id].scroll_y - y;
>  
>  		/* Calculate and apply the scroll motion. */
>  		switch (tdata[7] & TOUCH_STATE_MASK) {
>  		case TOUCH_STATE_START:
> +			msc->touches[id].scroll_x = x;
>  			msc->touches[id].scroll_y = y;
>  
>  			/* Reset acceleration after half a second. */
> @@ -198,12 +201,20 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
>  
>  			break;
>  		case TOUCH_STATE_DRAG:
> -			step /= (64 - (int)scroll_speed) * msc->scroll_accel;
> -			if (step != 0) {
> -				msc->touches[id].scroll_y -= step *
> +			step_x /= (64 - (int)scroll_speed) * msc->scroll_accel;
> +			if (step_x != 0) {
> +				msc->touches[id].scroll_x -= step_x *
>  					(64 - scroll_speed) * msc->scroll_accel;
>  				msc->scroll_jiffies = now;
> -				input_report_rel(input, REL_WHEEL, step);
> +				input_report_rel(input, REL_HWHEEL, -step_x);
> +			}
> +
> +			step_y /= (64 - (int)scroll_speed) * msc->scroll_accel;
> +			if (step_y != 0) {
> +				msc->touches[id].scroll_y -= step_y *
> +					(64 - scroll_speed) * msc->scroll_accel;
> +				msc->scroll_jiffies = now;
> +				input_report_rel(input, REL_WHEEL, step_y);
>  			}
>  			break;
>  		}
> @@ -318,8 +329,10 @@ static void magicmouse_setup_input(struct input_dev *input, struct hid_device *h
>  	__set_bit(EV_REL, input->evbit);
>  	__set_bit(REL_X, input->relbit);
>  	__set_bit(REL_Y, input->relbit);
> -	if (emulate_scroll_wheel)
> +	if (emulate_scroll_wheel) {
>  		__set_bit(REL_WHEEL, input->relbit);
> +		__set_bit(REL_HWHEEL, input->relbit);
> +	}
>  
>  	if (report_touches) {
>  		__set_bit(EV_ABS, input->evbit);
