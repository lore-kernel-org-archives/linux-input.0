From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 1/2] Input: xpad - add product ID for Xbox One S pad
Date: Sun, 27 Nov 2016 20:37:47 -0800
Message-ID: <20161128043747.GA2821@dtor-ws>
References: <cover.1480111549.git.aicommander@gmail.com>
 <0933bcf40040714e9ca3efdf80fd942f1b009547.1480111549.git.aicommander@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34775 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752302AbcK1Eil (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 27 Nov 2016 23:38:41 -0500
Received: by mail-pf0-f195.google.com with SMTP id y68so5700777pfb.1
        for <linux-input@vger.kernel.org>; Sun, 27 Nov 2016 20:37:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <0933bcf40040714e9ca3efdf80fd942f1b009547.1480111549.git.aicommander@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Cameron Gutman <aicommander@gmail.com>
Cc: rojtberg@gmail.com, linux-input@vger.kernel.org

On Fri, Nov 25, 2016 at 02:18:34PM -0800, Cameron Gutman wrote:
> This is the new gamepad that ships with the Xbox One S which
> includes Bluetooth functionality.
> 
> Signed-off-by: Cameron Gutman <aicommander@gmail.com>

Applied, thank you.

> ---
> No changes in v3.
> 
> ---
>  drivers/input/joystick/xpad.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 83af17a..19886db 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -134,6 +134,7 @@ static const struct xpad_device {
>  	{ 0x045e, 0x02d1, "Microsoft X-Box One pad", 0, XTYPE_XBOXONE },
>  	{ 0x045e, 0x02dd, "Microsoft X-Box One pad (Firmware 2015)", 0, XTYPE_XBOXONE },
>  	{ 0x045e, 0x02e3, "Microsoft X-Box One Elite pad", 0, XTYPE_XBOXONE },
> +	{ 0x045e, 0x02ea, "Microsoft X-Box One S pad", 0, XTYPE_XBOXONE },
>  	{ 0x045e, 0x0291, "Xbox 360 Wireless Receiver (XBOX)", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
>  	{ 0x045e, 0x0719, "Xbox 360 Wireless Receiver", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
>  	{ 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", 0, XTYPE_XBOX },
> -- 
> 2.9.3
> 

-- 
Dmitry
