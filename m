From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] HID: fix incorrect handling of devices with high button
 count
Date: Tue, 30 Oct 2012 23:36:25 -0700
Message-ID: <20121031063625.GB32539@core.coreip.homeip.net>
References: <508e9004.5593cc0a.3323.0a6c@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:46929 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018Ab2JaGg3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 31 Oct 2012 02:36:29 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so737597pad.19
        for <linux-input@vger.kernel.org>; Tue, 30 Oct 2012 23:36:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <508e9004.5593cc0a.3323.0a6c@mx.google.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ingo Ruhnke <grumbel@gmail.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

On Mon, Oct 29, 2012 at 02:29:30PM +0100, Ingo Ruhnke wrote:
> Button names for USB gamepads are currently assigned incorrectly, as
> the evdev code assigned to buttons is "BTN_GAMEPAD + code", which on
> devices with more then 16 buttons bleeds over into button names
> reserved for graphic tablets (BTN_TOOL_PEN, etc.). This causes
> problems further down the line as the device are now no longer
> detected as joystick. This patch fixes that by assigning buttons
> outside the range to BTN_TRIGGER_HAPPY (as is already the case for USB
> joysticks).
> 
> Furthermore this patch corrects the assignment to BTN_TRIGGER_HAPPY,
> as currently the first button over 16 is assigned to
> BTN_TRIGGER_HAPPY17 (i.e. BTN_TRIGGER_HAPPY+0x10) not BTN_TRIGGER_HAPPY.
> 
> Signed-off-by: Ingo Ruhnke <grumbel@gmail.com>

Makes sense.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/hid/hid-input.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index d917c0d..10248cf 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -502,9 +502,14 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>  				if (code <= 0xf)
>  					code += BTN_JOYSTICK;
>  				else
> -					code += BTN_TRIGGER_HAPPY;
> +					code += BTN_TRIGGER_HAPPY - 0x10;
> +				break;
> +		case HID_GD_GAMEPAD:
> +				if (code <= 0xf)
> +					code += BTN_GAMEPAD;
> +				else
> +					code += BTN_TRIGGER_HAPPY - 0x10;
>  				break;
> -		case HID_GD_GAMEPAD:  code += BTN_GAMEPAD; break;
>  		default:
>  			switch (field->physical) {
>  			case HID_GD_MOUSE:
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Dmitry
