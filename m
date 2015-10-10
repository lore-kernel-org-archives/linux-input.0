From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 02/15] Input: xpad: fix Razer Atrox Arcade Stick button
 mapping
Date: Sat, 10 Oct 2015 09:43:10 -0700
Message-ID: <20151010164310.GC39573@dtor-ws>
References: <1443733046-29610-1-git-send-email-rojtberg@gmail.com>
 <1443733046-29610-3-git-send-email-rojtberg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34866 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbbJJQnN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 10 Oct 2015 12:43:13 -0400
Received: by pabve7 with SMTP id ve7so56498764pab.2
        for <linux-input@vger.kernel.org>; Sat, 10 Oct 2015 09:43:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1443733046-29610-3-git-send-email-rojtberg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Rojtberg <rojtberg@gmail.com>
Cc: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, gregkh@linuxfoundation.org, Dario Scarpa <dario.scarpa@duskzone.it>

On Thu, Oct 01, 2015 at 10:57:13PM +0200, Pavel Rojtberg wrote:
> From: Dario Scarpa <dario.scarpa@duskzone.it>
> 
> The "Razer Atrox Arcade Stick" features 10 buttons,
> and two of them (LT/RT) don't work properly.
> Change its definition in xpad_device[] (mapping field) to fix.
> 
> Signed-off-by: Dario Scarpa <dario.scarpa@duskzone.it>
> Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>

Applied, thank you.

> ---
>  drivers/input/joystick/xpad.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index c3ba5be..e3b393c 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -205,7 +205,7 @@ static const struct xpad_device {
>  	{ 0x1bad, 0xf900, "Harmonix Xbox 360 Controller", 0, XTYPE_XBOX360 },
>  	{ 0x1bad, 0xf901, "Gamestop Xbox 360 Controller", 0, XTYPE_XBOX360 },
>  	{ 0x1bad, 0xf903, "Tron Xbox 360 controller", 0, XTYPE_XBOX360 },
> -	{ 0x24c6, 0x5000, "Razer Atrox Arcade Stick", 0, XTYPE_XBOX360 },
> +	{ 0x24c6, 0x5000, "Razer Atrox Arcade Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
>  	{ 0x24c6, 0x5300, "PowerA MINI PROEX Controller", 0, XTYPE_XBOX360 },
>  	{ 0x24c6, 0x5303, "Xbox Airflo wired controller", 0, XTYPE_XBOX360 },
>  	{ 0x24c6, 0x5500, "Hori XBOX 360 EX 2 with Turbo", 0, XTYPE_XBOX360 },
> -- 
> 1.9.1
> 

-- 
Dmitry
