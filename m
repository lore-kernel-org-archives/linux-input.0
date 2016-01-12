From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: xpad: correct xbox one pad device name
Date: Tue, 12 Jan 2016 14:36:39 -0800
Message-ID: <20160112223639.GF32064@dtor-ws>
References: <1452637389-7690-1-git-send-email-rojtberg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33547 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708AbcALWgm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Jan 2016 17:36:42 -0500
Received: by mail-pa0-f67.google.com with SMTP id pv5so27302615pac.0
        for <linux-input@vger.kernel.org>; Tue, 12 Jan 2016 14:36:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1452637389-7690-1-git-send-email-rojtberg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Rojtberg <rojtberg@gmail.com>
Cc: linux-input@vger.kernel.org

On Tue, Jan 12, 2016 at 11:23:09PM +0100, Pavel Rojtberg wrote:
> From: Pavel Rojtberg <rojtberg@gmail.com>
> 
> apparently the Covert Forces id is not Covert Forces pad exclusive, but
> rather denotes a new Firmware Version that can be found on all new
> controllers and can be also updated on old hardware using Windows 10.
> 
> see: https://github.com/paroj/xpad/issues/19
> 
> Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>

Applied, thank you.

> ---
>  drivers/input/joystick/xpad.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 22e6205..6727954 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -128,7 +128,7 @@ static const struct xpad_device {
>  	{ 0x045e, 0x0289, "Microsoft X-Box pad v2 (US)", 0, XTYPE_XBOX },
>  	{ 0x045e, 0x028e, "Microsoft X-Box 360 pad", 0, XTYPE_XBOX360 },
>  	{ 0x045e, 0x02d1, "Microsoft X-Box One pad", 0, XTYPE_XBOXONE },
> -	{ 0x045e, 0x02dd, "Microsoft X-Box One pad (Covert Forces)", 0, XTYPE_XBOXONE },
> +	{ 0x045e, 0x02dd, "Microsoft X-Box One pad (Firmware 2015)", 0, XTYPE_XBOXONE },
>  	{ 0x045e, 0x0291, "Xbox 360 Wireless Receiver (XBOX)", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
>  	{ 0x045e, 0x0719, "Xbox 360 Wireless Receiver", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
>  	{ 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", 0, XTYPE_XBOX },
> -- 
> 1.9.1
> 

-- 
Dmitry
