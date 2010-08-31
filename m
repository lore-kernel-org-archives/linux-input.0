From: Michael Poole <mdpoole@troilus.org>
Subject: Re: [PATCH 6/6] HID: magicmouse: Adjust major / minor axes to scale
Date: Tue, 31 Aug 2010 00:28:08 -0400
Message-ID: <1283228888.14419.65.camel@graviton>
References: <1283188858-4839-1-git-send-email-chase.douglas@canonical.com>
	 <1283188858-4839-6-git-send-email-chase.douglas@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:54112 "HELO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751599Ab0HaEbT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Aug 2010 00:31:19 -0400
Received: by mail-qy0-f177.google.com with SMTP id 8so8564309qyk.1
        for <linux-input@vger.kernel.org>; Mon, 30 Aug 2010 21:31:19 -0700 (PDT)
In-Reply-To: <1283188858-4839-6-git-send-email-chase.douglas@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Mon, 2010-08-30 at 13:20 -0400, Chase Douglas wrote:
> From: Henrik Rydberg <rydberg@euromail.se>
> 
> By visual inspection, the reported touch_major and touch_minor axes
> are roughly a factor of four too small. The factor is approximate,
> since the protocol is not known and the HID report encodes touch size
> with fewer bits than positions. This patch scales the reported values
> by a factor of four.
> 
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>

Acked-by: Michael Poole <mdpoole@troilus.org>

I never did figure out a more elegant or robust way to figure out this
scaling factor.  Four seems like about the right number.

> ---
>  drivers/hid/hid-magicmouse.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
> index 687dde4..b051f7d 100644
> --- a/drivers/hid/hid-magicmouse.c
> +++ b/drivers/hid/hid-magicmouse.c
> @@ -253,8 +253,8 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
>  	/* Generate the input events for this touch. */
>  	if (report_touches && down) {
>  		input_report_abs(input, ABS_MT_TRACKING_ID, id);
> -		input_report_abs(input, ABS_MT_TOUCH_MAJOR, touch_major);
> -		input_report_abs(input, ABS_MT_TOUCH_MINOR, touch_minor);
> +		input_report_abs(input, ABS_MT_TOUCH_MAJOR, touch_major << 2);
> +		input_report_abs(input, ABS_MT_TOUCH_MINOR, touch_minor << 2);
>  		input_report_abs(input, ABS_MT_ORIENTATION, orientation);
>  		input_report_abs(input, ABS_MT_POSITION_X, x);
>  		input_report_abs(input, ABS_MT_POSITION_Y, y);


