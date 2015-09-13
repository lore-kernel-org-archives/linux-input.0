From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: Re: [PATCH] Input: xpad - fix "Razer Atrox Arcade Stick" mapping
 definition
Date: Sun, 13 Sep 2015 15:22:54 +0200
Message-ID: <55F578AE.6020404@gmail.com>
References: <20150830113500.GA12138@xps.deltalabs>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38349 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455AbbIMNW5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Sep 2015 09:22:57 -0400
Received: by wiclk2 with SMTP id lk2so103535246wic.1
        for <linux-input@vger.kernel.org>; Sun, 13 Sep 2015 06:22:56 -0700 (PDT)
In-Reply-To: <20150830113500.GA12138@xps.deltalabs>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dario Scarpa <dario.scarpa@duskzone.it>, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

Reviewed-by:  Pavel Rojtberg <rojtberg@gmail.com>

Am 30.08.2015 um 13:35 schrieb Dario Scarpa:
> The "Razer Atrox Arcade Stick" features 10 buttons,
> and two of them (LT/RT) don't work properly.
> Change its definition in xpad_device[] (mapping field) to fix.
>
> Signed-off-by: Dario Scarpa <dario.scarpa@duskzone.it>
> ---
>   drivers/input/joystick/xpad.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index f8850f9..6417a8a 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -204,7 +204,7 @@ static const struct xpad_device {
>   	{ 0x1bad, 0xf900, "Harmonix Xbox 360 Controller", 0, XTYPE_XBOX360 },
>   	{ 0x1bad, 0xf901, "Gamestop Xbox 360 Controller", 0, XTYPE_XBOX360 },
>   	{ 0x1bad, 0xf903, "Tron Xbox 360 controller", 0, XTYPE_XBOX360 },
> -	{ 0x24c6, 0x5000, "Razer Atrox Arcade Stick", 0, XTYPE_XBOX360 },
> +	{ 0x24c6, 0x5000, "Razer Atrox Arcade Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
>   	{ 0x24c6, 0x5300, "PowerA MINI PROEX Controller", 0, XTYPE_XBOX360 },
>   	{ 0x24c6, 0x5303, "Xbox Airflo wired controller", 0, XTYPE_XBOX360 },
>   	{ 0x24c6, 0x5500, "Hori XBOX 360 EX 2 with Turbo", 0, XTYPE_XBOX360 },
