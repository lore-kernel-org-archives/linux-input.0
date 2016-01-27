From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: xpad: remove unused function
Date: Wed, 27 Jan 2016 15:43:03 -0800
Message-ID: <20160127234303.GG28687@dtor-ws>
References: <1453735884-1958624-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34200 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934689AbcA0XnH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Jan 2016 18:43:07 -0500
Content-Disposition: inline
In-Reply-To: <1453735884-1958624-1-git-send-email-arnd@arndb.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Pavel Rojtberg <rojtberg@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jan 25, 2016 at 04:30:41PM +0100, Arnd Bergmann wrote:
> There are two definitions of xpad_identify_controller(), one is used
> when CONFIG_JOYSTICK_XPAD_LEDS is set, but the other one is empty
> and never used, and we get a gcc warning about it:
> 
> drivers/input/joystick/xpad.c:1210:13: warning: 'xpad_identify_controller' defined but not used [-Wunused-function]
> 
> This removes the second definition.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: cae705baa40b ("Input: xpad - re-send LED command on present event")

Applied, thank you.

> ---
>  drivers/input/joystick/xpad.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 6727954ab74b..e8a84d12b7ff 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -1207,7 +1207,6 @@ static void xpad_led_disconnect(struct usb_xpad *xpad)
>  #else
>  static int xpad_led_probe(struct usb_xpad *xpad) { return 0; }
>  static void xpad_led_disconnect(struct usb_xpad *xpad) { }
> -static void xpad_identify_controller(struct usb_xpad *xpad) { }
>  #endif
>  
>  static int xpad_start_input(struct usb_xpad *xpad)
> -- 
> 2.7.0
> 

-- 
Dmitry
