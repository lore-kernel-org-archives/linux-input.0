From: Michael Poole <mdpoole@troilus.org>
Subject: Re: [PATCH 3/6] HID: magicmouse: simplify touch data bit
 manipulation
Date: Mon, 30 Aug 2010 23:55:26 -0400
Message-ID: <1283226926.14419.51.camel@graviton>
References: <1283188858-4839-1-git-send-email-chase.douglas@canonical.com>
	 <1283188858-4839-3-git-send-email-chase.douglas@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:49600 "HELO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932081Ab0HaEhE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Aug 2010 00:37:04 -0400
Received: by mail-qy0-f173.google.com with SMTP id 34so360808qyk.11
        for <linux-input@vger.kernel.org>; Mon, 30 Aug 2010 21:37:03 -0700 (PDT)
In-Reply-To: <1283188858-4839-3-git-send-email-chase.douglas@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: linux-input@vger.kernel.org

On Mon, 2010-08-30 at 13:20 -0400, Chase Douglas wrote:
> The new format should be easier to read to determine which bits
> correspond to which data. It also brings all the manipulation logic to
> the top of the function. This makes size and orientation reading more
> clear.
> 
> Note that the impetus for this change is the forthcoming support for the
> Magic Trackpad, which has a different touch data protocol.
> 
> Signed-off-by: Chase Douglas <chase.douglas@canonical.com>

Acked-by: Michael Poole <mdpoole@troilus.org>

> ---
>  drivers/hid/hid-magicmouse.c |   25 +++++++++++++------------
>  1 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
> index d758061..f3ee6ab 100644
> --- a/drivers/hid/hid-magicmouse.c
> +++ b/drivers/hid/hid-magicmouse.c
> @@ -166,18 +166,21 @@ static void magicmouse_emit_buttons(struct magicmouse_sc *msc, int state)
>  static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tdata)
>  {
>  	struct input_dev *input = msc->input;
> -	__s32 x_y = tdata[0] << 8 | tdata[1] << 16 | tdata[2] << 24;
> -	int misc = tdata[5] | tdata[6] << 8;
> -	int id = (misc >> 6) & 15;
> -	int x = x_y << 12 >> 20;
> -	int y = -(x_y >> 20);
> -	int down = (tdata[7] & TOUCH_STATE_MASK) != TOUCH_STATE_NONE;
> +	int id = (tdata[6] << 2 | tdata[5] >> 6) & 0xf;
> +	int x = (tdata[1] << 28 | tdata[0] << 20) >> 20;
> +	int y = -((tdata[2] << 24 | tdata[1] << 16) >> 20);
> +	int size = tdata[5] & 0x3f;
> +	int orientation = (tdata[6] >> 2) - 32;
> +	int touch_major = tdata[3];
> +	int touch_minor = tdata[4];
> +	int state = tdata[7] & TOUCH_STATE_MASK;
> +	int down = state != TOUCH_STATE_NONE;
>  
>  	/* Store tracking ID and other fields. */
>  	msc->tracking_ids[raw_id] = id;
>  	msc->touches[id].x = x;
>  	msc->touches[id].y = y;
> -	msc->touches[id].size = misc & 63;
> +	msc->touches[id].size = size;
>  
>  	/* If requested, emulate a scroll wheel by detecting small
>  	 * vertical touch motions.
> @@ -188,7 +191,7 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
>  		int step_y = msc->touches[id].scroll_y - y;
>  
>  		/* Calculate and apply the scroll motion. */
> -		switch (tdata[7] & TOUCH_STATE_MASK) {
> +		switch (state) {
>  		case TOUCH_STATE_START:
>  			msc->touches[id].scroll_x = x;
>  			msc->touches[id].scroll_y = y;
> @@ -224,13 +227,11 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
>  
>  	/* Generate the input events for this touch. */
>  	if (report_touches && down) {
> -		int orientation = (misc >> 10) - 32;
> -
>  		msc->touches[id].down = 1;
>  
>  		input_report_abs(input, ABS_MT_TRACKING_ID, id);
> -		input_report_abs(input, ABS_MT_TOUCH_MAJOR, tdata[3]);
> -		input_report_abs(input, ABS_MT_TOUCH_MINOR, tdata[4]);
> +		input_report_abs(input, ABS_MT_TOUCH_MAJOR, touch_major);
> +		input_report_abs(input, ABS_MT_TOUCH_MINOR, touch_minor);
>  		input_report_abs(input, ABS_MT_ORIENTATION, orientation);
>  		input_report_abs(input, ABS_MT_POSITION_X, x);
>  		input_report_abs(input, ABS_MT_POSITION_Y, y);


