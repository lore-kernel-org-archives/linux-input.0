From: Mathias Gottschlag <mgottschlag@gmail.com>
Subject: Re: [PATCH] Input: psmouse - cleanup Focaltech code
Date: Mon, 17 Oct 2016 19:27:59 +0200
Message-ID: <f574d1ad-ad49-30d1-53ff-3722fda56b35@gmail.com>
References: <1475923136-6046-1-git-send-email-hanipouspilot@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:32795 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932567AbcJQR2D (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 17 Oct 2016 13:28:03 -0400
In-Reply-To: <1475923136-6046-1-git-send-email-hanipouspilot@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Tunin <hanipouspilot@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

The changes look good to me. However, what wording do other drivers use?
I've seen "TouchPad" with a capital P before. If this patch breaks
scripts searching for that string anyways, that's an opportunity to
unify the capitalization there. It probably doesn't matter, though... I
don't see a problem with this patch.

I can't test it because I no longer have the hardware.

Am 08.10.2016 um 12:38 schrieb Dmitry Tunin:
> psmouse->name "Focaltech Touchpad" is an overkill. In xinput it is too long as
> "FocaltechPS/2 Focaltech Focaltech Touchpad"
>
> In focaltech_report_state() pointer to psmouse->dev is already stored as *dev
>
> Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>
> ---
>  drivers/input/mouse/focaltech.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/input/mouse/focaltech.c b/drivers/input/mouse/focaltech.c
> index c8c6a8c..49a56f655 100644
> --- a/drivers/input/mouse/focaltech.c
> +++ b/drivers/input/mouse/focaltech.c
> @@ -43,7 +43,7 @@ int focaltech_detect(struct psmouse *psmouse, bool set_properties)
>  
>  	if (set_properties) {
>  		psmouse->vendor = "FocalTech";
> -		psmouse->name = "FocalTech Touchpad";
> +		psmouse->name = "Touchpad";
>  	}
>  
>  	return 0;
> @@ -146,8 +146,8 @@ static void focaltech_report_state(struct psmouse *psmouse)
>  	}
>  	input_mt_report_pointer_emulation(dev, true);
>  
> -	input_report_key(psmouse->dev, BTN_LEFT, state->pressed);
> -	input_sync(psmouse->dev);
> +	input_report_key(dev, BTN_LEFT, state->pressed);
> +	input_sync(dev);
>  }
>  
>  static void focaltech_process_touch_packet(struct psmouse *psmouse,


