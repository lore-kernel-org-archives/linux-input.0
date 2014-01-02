From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: xpad - added new USB IDs for Logitech F310 and
 F710
Date: Thu, 2 Jan 2014 15:35:21 -0800
Message-ID: <20140102233520.GB21548@core.coreip.homeip.net>
References: <1388705063-6922-1-git-send-email-petr@scssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:54397 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754198AbaACAIE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 Jan 2014 19:08:04 -0500
Received: by mail-pb0-f52.google.com with SMTP id uo5so14962592pbc.25
        for <linux-input@vger.kernel.org>; Thu, 02 Jan 2014 16:08:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1388705063-6922-1-git-send-email-petr@scssoft.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Petr Sebor <petr@scssoft.com>
Cc: linux-input@vger.kernel.org

On Fri, Jan 03, 2014 at 12:24:23AM +0100, Petr Sebor wrote:
> This enables the rumble force feedback on the F710 unit since
> it is no longer treated as XTYPE_UNKNOWN type.
> 
> Signed-off-by: Petr Sebor <petr@scssoft.com>

Applied, thank you.

> ---
>  drivers/input/joystick/xpad.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 75e3b10..958489a 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -125,6 +125,8 @@ static const struct xpad_device {
>  	{ 0x045e, 0x0291, "Xbox 360 Wireless Receiver (XBOX)", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
>  	{ 0x045e, 0x0719, "Xbox 360 Wireless Receiver", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
>  	{ 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", 0, XTYPE_XBOX },
> +	{ 0x046d, 0xc21d, "Logitech Gamepad F310", 0, XTYPE_XBOX360 },
> +	{ 0x046d, 0xc21f, "Logitech Gamepad F710", 0, XTYPE_XBOX360 },
>  	{ 0x046d, 0xc242, "Logitech Chillstream Controller", 0, XTYPE_XBOX360 },
>  	{ 0x046d, 0xca84, "Logitech Xbox Cordless Controller", 0, XTYPE_XBOX },
>  	{ 0x046d, 0xca88, "Logitech Compact Controller for Xbox", 0, XTYPE_XBOX },
> -- 
> 1.8.3.2
> 

-- 
Dmitry
