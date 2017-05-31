From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH] input: mouse: trackpoint: assume 3 buttons when buttons
 detection fails
Date: Wed, 31 May 2017 14:42:04 +1000
Message-ID: <20170531044204.GA31233@jelly>
References: <20170529114458.GA28855@ThinkStation>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:63982 "EHLO
        mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750930AbdEaEmO (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 31 May 2017 00:42:14 -0400
Content-Disposition: inline
In-Reply-To: <20170529114458.GA28855@ThinkStation>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oscar Campos <oscar.campos@member.fsf.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Mon, May 29, 2017 at 12:45:01PM +0100, Oscar Campos wrote:
> Trackpoint buttons detection fails on ThinkPad 570 and 470 series,
> this makes the middle button of the trackpoint to not being recogized.
> As I don't believe there is any trackpoint with less than 3 buttons this
> patch just assumes three buttons when the extended button information
> read fails.

I vaguely remember there may have been one at some point, but I can't
remember which model it was in (not a Lenovo anyway). This approach seems
sensible, but I worry about it papering over potential bugs (missing
support).

still, Acked-by: Peter Hutterer <peter.hutterer@who-t.net>

Cheers,
   Peter

> 
> Cc: linux-input@vger.kernel.org
> Signed-off-by: Oscar Campos <oscar.campos@member.fsf.org>
> ---
>  drivers/input/mouse/trackpoint.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/trackpoint.c
> index 922ea02edcc3..20b5b21c1bba 100644
> --- a/drivers/input/mouse/trackpoint.c
> +++ b/drivers/input/mouse/trackpoint.c
> @@ -380,8 +380,8 @@ int trackpoint_detect(struct psmouse *psmouse, bool set_properties)
>  		return 0;
> 
>  	if (trackpoint_read(ps2dev, TP_EXT_BTN, &button_info)) {
> -		psmouse_warn(psmouse, "failed to get extended button data\n");
> -		button_info = 0;
> +		psmouse_warn(psmouse, "failed to get extended button data, assuming 3 buttons\n");
> +		button_info = 0x33;
>  	}
> 
>  	psmouse->private = kzalloc(sizeof(struct trackpoint_data), GFP_KERNEL);
> --
> 2.13.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
