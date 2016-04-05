From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: xpad - Add Mad Catz FightStick TE 2 VID/PID
Date: Tue, 5 Apr 2016 09:58:26 -0700
Message-ID: <20160405165826.GA9976@dtor-ws>
References: <1457982428-9849-1-git-send-email-s.jegen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:32834 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbcDEQ6a (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Apr 2016 12:58:30 -0400
Content-Disposition: inline
In-Reply-To: <1457982428-9849-1-git-send-email-s.jegen@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Silvan Jegen <s.jegen@gmail.com>
Cc: Pavel Rojtberg <rojtberg@gmail.com>, linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Pierre-Loup A. Griffais" <githubpublic@plagman.net>, linux-kernel@vger.kernel.org

On Mon, Mar 14, 2016 at 08:07:08PM +0100, Silvan Jegen wrote:
> This adds the VID/PID combination for the Xbox One version of the Mad
> Catz FightStick TE 2.
> 
> The functionality that this provides is about on par with what the
> Windows drivers for the stick manage to deliver.
> 
> What works:
> - Digital stick
> - 6 main buttons
> - Xbox button
> - The two buttons on the back
> - The locking buttons (preventing accidental Xbox button press)
> 
> What doesn't work:
> - Two of the main buttons (don't work on Windows either)
> - The "Haptic" button setting does not have an effect (not sure if it
>   works on Windows)
> 
> I added the MAP_TRIGGERS_TO_BUTTONS option but in my (limited) testing
> there was no practical difference with or without. The FightStick does
> not have triggers though so adding it makes sense.
> 
> Signed-off-by: Silvan Jegen <s.jegen@gmail.com>

Applied, thank you.

> ---
>  drivers/input/joystick/xpad.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index e8a84d1..d3d7f7c 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -149,6 +149,7 @@ static const struct xpad_device {
>  	{ 0x0738, 0x4556, "Mad Catz Lynx Wireless Controller", 0, XTYPE_XBOX },
>  	{ 0x0738, 0x4716, "Mad Catz Wired Xbox 360 Controller", 0, XTYPE_XBOX360 },
>  	{ 0x0738, 0x4718, "Mad Catz Street Fighter IV FightStick SE", 0, XTYPE_XBOX360 },
> +	{ 0x0738, 0x4a01, "Mad Catz FightStick TE 2", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOXONE },
>  	{ 0x0738, 0x4726, "Mad Catz Xbox 360 Controller", 0, XTYPE_XBOX360 },
>  	{ 0x0738, 0x4728, "Mad Catz Street Fighter IV FightPad", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
>  	{ 0x0738, 0x4738, "Mad Catz Wired Xbox 360 Controller (SFIV)", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
> @@ -304,6 +305,7 @@ static struct usb_device_id xpad_table[] = {
>  	XPAD_XBOX360_VENDOR(0x046d),		/* Logitech X-Box 360 style controllers */
>  	XPAD_XBOX360_VENDOR(0x0738),		/* Mad Catz X-Box 360 controllers */
>  	{ USB_DEVICE(0x0738, 0x4540) },		/* Mad Catz Beat Pad */
> +	XPAD_XBOXONE_VENDOR(0x0738),		/* Mad Catz FightStick TE 2 */
>  	XPAD_XBOX360_VENDOR(0x0e6f),		/* 0x0e6f X-Box 360 controllers */
>  	XPAD_XBOX360_VENDOR(0x12ab),		/* X-Box 360 dance pads */
>  	XPAD_XBOX360_VENDOR(0x1430),		/* RedOctane X-Box 360 controllers */
> -- 
> 2.7.2
> 

-- 
Dmitry
