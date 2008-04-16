From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: xpad - Rename buttons to avoid conflict with mouse input
Date: Wed, 16 Apr 2008 19:49:33 +0300
Message-ID: <48062E1D.40805@gmail.com>
References: <74d457500804150313n3487e672r35261b9dd75b0303@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pne-smtpout4-sn1.fre.skanova.net ([81.228.11.168]:44948 "EHLO
	pne-smtpout4-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754421AbYDPQti (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Apr 2008 12:49:38 -0400
In-Reply-To: <74d457500804150313n3487e672r35261b9dd75b0303@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: Michael Gruber <lists.mg@googlemail.com>, linux-input@vger.kernel.org

Michael Gruber wrote:
> From: Michael Gruber <lists.mg@googlemail.com>
> 
> BTN_LEFT, BTN_RIGHT and BTN_BACK are listed as mouse buttons according to
> input.h. Rename them to make sure they do not interfere with mouse input.
> 
> Signed-off-by: Michael Gruber <lists.mg@googlemail.com>
> 
> ---
> 
> When I set up the driver to use MAP_DPAD_TO_BUTTONS the controller starts
> acting as mouse. Touching the d-pad issues left and right mouse click events
> and the back button acts like one of my other mouse buttons.

Patch seems correct to me.

Acked-by: Anssi Hannula <anssi.hannula@gmail.com>

>  drivers/input/joystick/xpad.c |   20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> --- a/drivers/input/joystick/xpad.c	2008-04-15 10:41:42.000000000 +0200
> +++ b/drivers/input/joystick/xpad.c	2008-04-15 10:49:41.000000000 +0200
> @@ -150,7 +150,7 @@ static const struct xpad_device {
>  /* buttons shared with xbox and xbox360 */
>  static const signed short xpad_common_btn[] = {
>  	BTN_A, BTN_B, BTN_X, BTN_Y,			/* "analog" buttons */
> -	BTN_START, BTN_BACK, BTN_THUMBL, BTN_THUMBR,	/* start/back/sticks */
> +	BTN_START, BTN_SELECT, BTN_THUMBL, BTN_THUMBR,	/* start/back/sticks */
>  	-1						/* terminating entry */
>  };
> 
> @@ -162,9 +162,9 @@ static const signed short xpad_btn[] = {
> 
>  /* only used if MAP_DPAD_TO_BUTTONS */
>  static const signed short xpad_btn_pad[] = {
> -	BTN_LEFT, BTN_RIGHT,		/* d-pad left, right */
> -	BTN_0, BTN_1,			/* d-pad up, down (XXX names??) */
> -	-1				/* terminating entry */
> +	BTN_0, BTN_1,		/* d-pad up, down */
> +	BTN_2, BTN_3,		/* d-pad left, right */
> +	-1			/* terminating entry */
>  };
> 
>  static const signed short xpad360_btn[] = {  /* buttons for x360 controller */
> @@ -279,15 +279,15 @@ static void xpad_process_packet(struct u
>  		input_report_abs(dev, ABS_HAT0Y,
>  				 !!(data[2] & 0x02) - !!(data[2] & 0x01));
>  	} else /* xpad->dpad_mapping == MAP_DPAD_TO_BUTTONS */ {
> -		input_report_key(dev, BTN_LEFT,  data[2] & 0x04);
> -		input_report_key(dev, BTN_RIGHT, data[2] & 0x08);
>  		input_report_key(dev, BTN_0,     data[2] & 0x01); /* up */
>  		input_report_key(dev, BTN_1,     data[2] & 0x02); /* down */
> +		input_report_key(dev, BTN_2,     data[2] & 0x04); /* left */
> +		input_report_key(dev, BTN_3,     data[2] & 0x08); /* right */
>  	}
> 
>  	/* start/back buttons and stick press left/right */
>  	input_report_key(dev, BTN_START,  data[2] & 0x10);
> -	input_report_key(dev, BTN_BACK,   data[2] & 0x20);
> +	input_report_key(dev, BTN_SELECT, data[2] & 0x20);
>  	input_report_key(dev, BTN_THUMBL, data[2] & 0x40);
>  	input_report_key(dev, BTN_THUMBR, data[2] & 0x80);
> 
> @@ -327,15 +327,15 @@ static void xpad360_process_packet(struc
>  				 !!(data[2] & 0x02) - !!(data[2] & 0x01));
>  	} else if (xpad->dpad_mapping == MAP_DPAD_TO_BUTTONS) {
>  		/* dpad as buttons (right, left, down, up) */
> -		input_report_key(dev, BTN_LEFT, data[2] & 0x04);
> -		input_report_key(dev, BTN_RIGHT, data[2] & 0x08);
>  		input_report_key(dev, BTN_0, data[2] & 0x01);	/* up */
>  		input_report_key(dev, BTN_1, data[2] & 0x02);	/* down */
> +		input_report_key(dev, BTN_2, data[2] & 0x04);	/* left */
> +		input_report_key(dev, BTN_3, data[2] & 0x08);	/* right */
>  	}
> 
>  	/* start/back buttons */
>  	input_report_key(dev, BTN_START,  data[2] & 0x10);
> -	input_report_key(dev, BTN_BACK,   data[2] & 0x20);
> +	input_report_key(dev, BTN_SELECT, data[2] & 0x20);
> 
>  	/* stick press left/right */
>  	input_report_key(dev, BTN_THUMBL, data[2] & 0x40);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Anssi Hannula
