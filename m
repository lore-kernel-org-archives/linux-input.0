From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] HID: add missing hid usages
Date: Fri, 25 Apr 2014 09:38:28 -0700
Message-ID: <20140425163828.GA12355@core.coreip.homeip.net>
References: <1398413623-19233-1-git-send-email-ogay@logitech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:45936 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbaDYQic (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Apr 2014 12:38:32 -0400
Received: by mail-pd0-f173.google.com with SMTP id p10so2979071pdj.4
        for <linux-input@vger.kernel.org>; Fri, 25 Apr 2014 09:38:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398413623-19233-1-git-send-email-ogay@logitech.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Olivier Gay <ogay@logitech.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Mathieu Meisser <mmeisser@logitech.com>

On Fri, Apr 25, 2014 at 10:13:43AM +0200, Olivier Gay wrote:
> Add some missing hid usages from consumer page, add
> some display brightness control usages from approved hid usage
> table request HUTTR41:
> http://www.usb.org/developers/hidpage/HUTRR41.pdf
> and add voice command usage from approved request HUTTR45:
> http://www.usb.org/developers/hidpage/Voice_Command_Usage.pdf
> 
> Signed-off-by: Olivier Gay <ogay@logitech.com>
> Signed-off-by: Mathieu Meisser <mmeisser@logitech.com>
> ---
>  drivers/hid/hid-debug.c    | 13 +++++++++++++
>  drivers/hid/hid-input.c    | 14 ++++++++++++++
>  include/uapi/linux/input.h | 15 +++++++++++++++
>  3 files changed, 42 insertions(+)
> 
> diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
> index 53b771d..08b95ef 100644
> --- a/drivers/hid/hid-debug.c
> +++ b/drivers/hid/hid-debug.c
> @@ -855,6 +855,19 @@ static const char *keys[KEY_MAX + 1] = {
>  	[KEY_KBDILLUMDOWN] = "KbdIlluminationDown",
>  	[KEY_KBDILLUMUP] = "KbdIlluminationUp",
>  	[KEY_SWITCHVIDEOMODE] = "SwitchVideoMode",
> +	[KEY_BUTTONCONFIG] = "ButtonConfig",
> +	[KEY_TASKMANAGER] = "TaskManager",
> +	[KEY_JOURNAL] = "Journal",
> +	[KEY_CONTROLPANEL] = "ControlPanel",
> +	[KEY_APPSELECT] = "AppSelect",
> +	[KEY_SCREENSAVER] = "ScreenSaver",
> +	[KEY_VOICECOMMAND] = "VoiceCommand",
> +	[KEY_BRIGHTNESS_INC] = "BrightnessInc",
> +	[KEY_BRIGHTNESS_DEC] = "BrightnessDec",

This table already has entries for KEY_BRIGHTNESS_UP/DOWN, you are
overriding them. I'd rather we did not define gratuitous aliases
(sometimes aliasing is necessary when we got the name wrong, but UP/DOWN
vs INC/DEC for brightness is not the case here).

...

> +
> +#define KEY_BRIGHTNESS_INC		KEY_BRIGHTNESSUP
> +#define KEY_BRIGHTNESS_DEC		KEY_BRIGHTNESSDOWN
> +#define KEY_BRIGHTNESS_TOGGLE		KEY_DISPLAYTOGGLE
> +#define KEY_BRIGHTNESS_MIN		0x250	/* Set Brightness to Minimum */
> +#define KEY_BRIGHTNESS_MAX		0x251	/* Set Brightness to Maximum */
> +#define KEY_BRIGHTNESS_AUTO		0x252	/* Set Auto Brightness */

I was looking through keycodes again and we have:

#define KEY_BRIGHTNESS_ZERO|----244|----/* brightness off, use ambient */

which seems to be exactly the same as KEY_BRIGHTNESS_AUTO, but here I
agree that old name is not the best. Could you please change its
definition earlier in the file to:

#define KEY_BRIGHTNESS_AUTO	224	/* Set Auto Brightness: manual
					  brightness control is off,
					  rely on ambient */
#define KEY_BRIGHTNESS_ZERO	KEY_BRIGHTNESS_AUTO

Sorry it takes so long...

-- 
Dmitry
