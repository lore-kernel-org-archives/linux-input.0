From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] made the byd_detect function more restrictive to prevent
 false positives when actual mouse is a generic PS/2 mouse; byd_detect now
 tries to go through BYD touchpad configuration steps, which fail when not
 performed on BYD touchpad
Date: Mon, 27 Jun 2016 14:34:12 -0700
Message-ID: <20160627213412.GC22620@dtor-ws>
References: <1466907921-10210-1-git-send-email-pospeselr@gmail.com>
 <1466907921-10210-2-git-send-email-pospeselr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33737 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbcF0VeP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jun 2016 17:34:15 -0400
Received: by mail-pf0-f195.google.com with SMTP id c74so16851547pfb.0
        for <linux-input@vger.kernel.org>; Mon, 27 Jun 2016 14:34:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1466907921-10210-2-git-send-email-pospeselr@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard Pospesel <pospeselr@gmail.com>
Cc: linux-input@vger.kernel.org, chris@diamand.org, phonesyfreakies@gmail.com

Hi Richard,

On Sat, Jun 25, 2016 at 07:25:21PM -0700, Richard Pospesel wrote:
> ---
>  drivers/input/mouse/byd.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/mouse/byd.c b/drivers/input/mouse/byd.c
> index ec73f75..380e295 100644
> --- a/drivers/input/mouse/byd.c
> +++ b/drivers/input/mouse/byd.c
> @@ -355,7 +355,7 @@ static int byd_reset_touchpad(struct psmouse *psmouse)
>  		{ PSMOUSE_CMD_ENABLE, 0 },
>  		/*
>  		 * BYD-specific initialization, which enables absolute mode and
> -		 * (if desired), the touchpad's built-in gesture detection.
> +		 * disables the builtin hardware gesture recogniton.
>  		 */
>  		{ 0x10E2, 0x00 },
>  		{ 0x10E0, 0x02 },
> @@ -435,6 +435,7 @@ int byd_detect(struct psmouse *psmouse, bool set_properties)
>  	struct ps2dev *ps2dev = &psmouse->ps2dev;
>  	u8 param[4] = {0x03, 0x00, 0x00, 0x00};
>  
> +	/* 'Secret' handshake */
>  	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
>  		return -1;
>  	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
> @@ -446,7 +447,21 @@ int byd_detect(struct psmouse *psmouse, bool set_properties)
>  	if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO))
>  		return -1;
>  
> -	if (param[1] != 0x03 || param[2] != 0x64)
> +	/*
> +	 * BYD touchpad returns 0x03 for resolution ( 8 count / mm ) and
> +	 * 0x64 ( 100 samples / sec ) for sampling rate
> +	 * The first byte's value is dependent on the mouse button states:
> +	 *  0 : no button pressed
> +	 *  1 : right button pressed
> +	 *  4 : left button pressed
> +	 *  5 : right and left button pressed
> +	 */
> +	if ((param[0] & 0x05) != param[0] || param[1] != 0x03 ||
> +	    param[2] != 0x64)
> +		return -ENODEV;
> +
> +	/* Attempt to set BYD unique settings */
> +	if (byd_reset_touchpad(psmouse))
>  		return -ENODEV;

If we do full initialization then there is no point in splitting into
byd_detect/byd_init and repeating initialization in byd_init() and
byd_reconnect().

Thanks.

-- 
Dmitry
