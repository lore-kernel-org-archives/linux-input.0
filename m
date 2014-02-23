From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] Add device id for Thrustmaster GPX Gamepad for
 joystick/xpad.c driver
Date: Sat, 22 Feb 2014 22:28:59 -0800
Message-ID: <20140223062859.GA10151@core.coreip.homeip.net>
References: <1393023081-31679-1-git-send-email-info@webreactor.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:43504 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbaBWG3D (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 23 Feb 2014 01:29:03 -0500
Content-Disposition: inline
In-Reply-To: <1393023081-31679-1-git-send-email-info@webreactor.eu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcin Lulek <admin@webreactor.eu>
Cc: Marcin Lulek <info@webreactor.eu>, Thomaz de Oliveira dos Reis <thor27@gmail.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Feb 21, 2014 at 11:51:21PM +0100, Marcin Lulek wrote:
> Signed-off-by: Marcin Lulek <info@webreactor.eu>
> ---
>  drivers/input/joystick/xpad.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 603fe0d..b94668f 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -124,6 +124,7 @@ static const struct xpad_device {
>  	{ 0x045e, 0x0291, "Xbox 360 Wireless Receiver (XBOX)", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
>  	{ 0x045e, 0x0719, "Xbox 360 Wireless Receiver", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
>  	{ 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", 0, XTYPE_XBOX },
> +	{ 0x24c6, 0x5b02, "Thrustmaster, Inc. GPX Controller", 0, XTYPE_XBOX360 },
>  	{ 0x046d, 0xc21d, "Logitech Gamepad F310", 0, XTYPE_XBOX360 },
>  	{ 0x046d, 0xc21f, "Logitech Gamepad F710", 0, XTYPE_XBOX360 },
>  	{ 0x046d, 0xc242, "Logitech Chillstream Controller", 0, XTYPE_XBOX360 },
> -- 
> 1.8.3.2
> 

Applied, thank you.

-- 
Dmitry
