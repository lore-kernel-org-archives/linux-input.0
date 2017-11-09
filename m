From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v2 3/5] Input: add KEY_ROTATE_LOCK_TOGGLE
Date: Fri, 10 Nov 2017 00:34:53 +0100
Message-ID: <1510270493.2624.49.camel@hadess.net>
References: <20171109224436.16472-1-stefan.bruens@rwth-aachen.de>
         <8ebdb255-b0b5-4de2-a680-e7f6713256d0@rwthex-w2-a.rwth-ad.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:47445 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754687AbdKIXe4 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 9 Nov 2017 18:34:56 -0500
In-Reply-To: <8ebdb255-b0b5-4de2-a680-e7f6713256d0@rwthex-w2-a.rwth-ad.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan =?ISO-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>, platform-driver-x86@vger.kernel.org
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org

On Thu, 2017-11-09 at 23:44 +0100, Stefan Brüns wrote:
> The key has the same use as the SW_ROTATE_LOCK, but is used on
> devices
> where the state is not tracked by the hardware but has to be handled
> in software.

I'll let the input and hid subsystem maintainers have the final say
here, though I think that sending out Win+O would be easier, as this is
already something that desktops need to support for those devices that
send the actual Win+O key combination when those buttons are pressed
there.

If we're going with the separate keycode, could you also file bugs
against xkbd-common and xkeyboard-config to get the key added to the
list of XF86 keysyms and to the default evdev keymap? Otherwise Wayland
and X11 based desktops won't be able to use it.

Cheers

> Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
> 
> ---
> 
> Changes in v2:
> - New patch, add support for KEY_ROTATE_LOCK_TOGGLE
> 
>  include/uapi/linux/input-event-codes.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/input-event-codes.h
> b/include/uapi/linux/input-event-codes.h
> index f4058bd4c373..ba5d709a8923 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -593,6 +593,7 @@
>  #define BTN_DPAD_RIGHT		0x223
>  
>  #define KEY_ALS_TOGGLE		0x230	/* Ambient light
> sensor */
> +#define KEY_ROTATE_LOCK_TOGGLE	0x231	/* Display
> rotation lock */
>  
>  #define KEY_BUTTONCONFIG		0x240	/* AL Button
> Configuration */
>  #define KEY_TASKMANAGER		0x241	/* AL
> Task/Project Manager */
