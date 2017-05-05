From: Cameron Gutman <aicommander@gmail.com>
Subject: Re: Input: xpad - add USB IDs for Mad Catz Brawlstick and Razer
 Sabertooth
Date: Thu, 4 May 2017 17:04:49 -0700
Message-ID: <7111ba9e-df4d-5ea0-3580-9963448c02cf@gmail.com>
References: <20170504231544.335e8f42@nashorn>
 <20170504231714.16ea40d2@nashorn> <20170505004747.05c466ac@nashorn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33443 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751756AbdEEAFV (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 4 May 2017 20:05:21 -0400
Received: by mail-pg0-f66.google.com with SMTP id s62so67284pgc.0
        for <linux-input@vger.kernel.org>; Thu, 04 May 2017 17:05:21 -0700 (PDT)
In-Reply-To: <20170505004747.05c466ac@nashorn>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Valentin <benpicco@googlemail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Pavel Rojtberg <rojtberg@gmail.com>

On 05/04/2017 03:47 PM, Benjamin Valentin wrote:
> Add USB IDs for two more Xbox 360 controllers.
> 
> I found them in the pull requests for the xboxdrv userspace driver, which seems abandoned.
> 
> Thanks to psychogony and mkaito for reporting the IDs there!
> 
> Signed-off-by: Benjamin Valentin <benpicco@googlemail.com>
> ---
>  drivers/input/joystick/xpad.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index a1a0c03fb0f2..8636b2abd103 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -212,10 +212,12 @@ static const struct xpad_device {
>  	{ 0x162e, 0xbeef, "Joytech Neo-Se Take2", 0, XTYPE_XBOX360 },
>  	{ 0x1689, 0xfd00, "Razer Onza Tournament Edition", 0, XTYPE_XBOX360 },
>  	{ 0x1689, 0xfd01, "Razer Onza Classic Edition", 0, XTYPE_XBOX360 },
> +	{ 0x1689, 0xfe00, "Razer Sabertooth", 0, XTYPE_XBOX360 },
>  	{ 0x1bad, 0x0002, "Harmonix Rock Band Guitar", 0, XTYPE_XBOX360 },
>  	{ 0x1bad, 0x0003, "Harmonix Rock Band Drumkit", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360 },
>  	{ 0x1bad, 0xf016, "Mad Catz Xbox 360 Controller", 0, XTYPE_XBOX360 },
>  	{ 0x1bad, 0xf018, "Mad Catz Street Fighter IV SE Fighting Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
> +	{ 0x1bad, 0xf019, "Mad Catz Brawlstick for Xbox 360", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
>  	{ 0x1bad, 0xf021, "Mad Cats Ghost Recon FS GamePad", 0, XTYPE_XBOX360 },
>  	{ 0x1bad, 0xf023, "MLG Pro Circuit Controller (Xbox)", 0, XTYPE_XBOX360 },
>  	{ 0x1bad, 0xf028, "Street Fighter IV FightPad", 0, XTYPE_XBOX360 },
> 

Reviewed-by: Cameron Gutman <aicommander@gmail.com>
