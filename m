From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4] HID: add missing hid usages
Date: Fri, 25 Apr 2014 11:30:44 -0700
Message-ID: <20140425183043.GC12355@core.coreip.homeip.net>
References: <1398450404-20484-1-git-send-email-ogay@logitech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:58260 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320AbaDYSar (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Apr 2014 14:30:47 -0400
Received: by mail-pd0-f170.google.com with SMTP id x10so7289pdj.15
        for <linux-input@vger.kernel.org>; Fri, 25 Apr 2014 11:30:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398450404-20484-1-git-send-email-ogay@logitech.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Olivier Gay <ogay@logitech.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Mathieu Meisser <mmeisser@logitech.com>

On Fri, Apr 25, 2014 at 08:26:44PM +0200, Olivier Gay wrote:
> Add some missing hid usages from consumer page, add
> some display brightness control usages from approved hid usage
> table request HUTTR41:
> http://www.usb.org/developers/hidpage/HUTRR41.pdf
> and add voice command usage from approved request HUTTR45:
> http://www.usb.org/developers/hidpage/Voice_Command_Usage.pdf
> 
> Signed-off-by: Olivier Gay <ogay@logitech.com>
> Signed-off-by: Mathieu Meisser <mmeisser@logitech.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

with a small nit below. Probably Jiri can fix it up without resubmitting.

> ---
>  drivers/hid/hid-debug.c    | 11 +++++++++++
>  drivers/hid/hid-input.c    | 14 ++++++++++++++
>  include/uapi/linux/input.h | 17 ++++++++++++++++-
>  3 files changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
> index 53b771d..826c847 100644
> --- a/drivers/hid/hid-debug.c
> +++ b/drivers/hid/hid-debug.c
> @@ -855,6 +855,17 @@ static const char *keys[KEY_MAX + 1] = {
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
> +	[KEY_BRIGHTNESS_TOGGLE] = "BrightnessToggle",

This needs to go as it smashes KEY_DISPLAYTOGGLE.

Thanks.

> +	[KEY_BRIGHTNESS_MIN] = "BrightnessMin",
> +	[KEY_BRIGHTNESS_MAX] = "BrightnessMax",
> +	[KEY_BRIGHTNESS_AUTO] = "BrightnessAuto",
>  };
>  
>  static const char *relatives[REL_MAX + 1] = {
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index e7e8b19..9f2076a 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -721,6 +721,13 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>  		case 0x06c: map_key_clear(KEY_YELLOW);		break;
>  		case 0x06d: map_key_clear(KEY_ZOOM);		break;
>  
> +		case 0x06f: map_key_clear(KEY_BRIGHTNESSUP);		break;
> +		case 0x070: map_key_clear(KEY_BRIGHTNESSDOWN);		break;
> +		case 0x072: map_key_clear(KEY_BRIGHTNESS_TOGGLE);	break;
> +		case 0x073: map_key_clear(KEY_BRIGHTNESS_MIN);		break;
> +		case 0x074: map_key_clear(KEY_BRIGHTNESS_MAX);		break;
> +		case 0x075: map_key_clear(KEY_BRIGHTNESS_AUTO);		break;
> +
>  		case 0x082: map_key_clear(KEY_VIDEO_NEXT);	break;
>  		case 0x083: map_key_clear(KEY_LAST);		break;
>  		case 0x084: map_key_clear(KEY_ENTER);		break;
> @@ -761,6 +768,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>  		case 0x0bf: map_key_clear(KEY_SLOW);		break;
>  
>  		case 0x0cd: map_key_clear(KEY_PLAYPAUSE);	break;
> +		case 0x0cf: map_key_clear(KEY_VOICECOMMAND);	break;
>  		case 0x0e0: map_abs_clear(ABS_VOLUME);		break;
>  		case 0x0e2: map_key_clear(KEY_MUTE);		break;
>  		case 0x0e5: map_key_clear(KEY_BASSBOOST);	break;
> @@ -768,6 +776,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>  		case 0x0ea: map_key_clear(KEY_VOLUMEDOWN);	break;
>  		case 0x0f5: map_key_clear(KEY_SLOW);		break;
>  
> +		case 0x181: map_key_clear(KEY_BUTTONCONFIG);	break;
>  		case 0x182: map_key_clear(KEY_BOOKMARKS);	break;
>  		case 0x183: map_key_clear(KEY_CONFIG);		break;
>  		case 0x184: map_key_clear(KEY_WORDPROCESSOR);	break;
> @@ -781,6 +790,8 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>  		case 0x18c: map_key_clear(KEY_VOICEMAIL);	break;
>  		case 0x18d: map_key_clear(KEY_ADDRESSBOOK);	break;
>  		case 0x18e: map_key_clear(KEY_CALENDAR);	break;
> +		case 0x18f: map_key_clear(KEY_TASKMANAGER);	break;
> +		case 0x190: map_key_clear(KEY_JOURNAL);		break;
>  		case 0x191: map_key_clear(KEY_FINANCE);		break;
>  		case 0x192: map_key_clear(KEY_CALC);		break;
>  		case 0x193: map_key_clear(KEY_PLAYER);		break;
> @@ -789,12 +800,15 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>  		case 0x199: map_key_clear(KEY_CHAT);		break;
>  		case 0x19c: map_key_clear(KEY_LOGOFF);		break;
>  		case 0x19e: map_key_clear(KEY_COFFEE);		break;
> +		case 0x19f: map_key_clear(KEY_CONTROLPANEL);		break;
> +		case 0x1a2: map_key_clear(KEY_APPSELECT);		break;
>  		case 0x1a3: map_key_clear(KEY_NEXT);		break;
>  		case 0x1a4: map_key_clear(KEY_PREVIOUS);	break;
>  		case 0x1a6: map_key_clear(KEY_HELP);		break;
>  		case 0x1a7: map_key_clear(KEY_DOCUMENTS);	break;
>  		case 0x1ab: map_key_clear(KEY_SPELLCHECK);	break;
>  		case 0x1ae: map_key_clear(KEY_KEYBOARD);	break;
> +		case 0x1b1: map_key_clear(KEY_SCREENSAVER);		break;
>  		case 0x1b4: map_key_clear(KEY_FILE);		break;
>  		case 0x1b6: map_key_clear(KEY_IMAGES);		break;
>  		case 0x1b7: map_key_clear(KEY_AUDIO);		break;
> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> index bd24470..b75b5d6 100644
> --- a/include/uapi/linux/input.h
> +++ b/include/uapi/linux/input.h
> @@ -461,7 +461,10 @@ struct input_keymap_entry {
>  #define KEY_VIDEO_NEXT		241	/* drive next video source */
>  #define KEY_VIDEO_PREV		242	/* drive previous video source */
>  #define KEY_BRIGHTNESS_CYCLE	243	/* brightness up, after max is min */
> -#define KEY_BRIGHTNESS_ZERO	244	/* brightness off, use ambient */
> +#define KEY_BRIGHTNESS_AUTO	244	/* Set Auto Brightness: manual
> +					  brightness control is off,
> +					  rely on ambient */
> +#define KEY_BRIGHTNESS_ZERO	KEY_BRIGHTNESS_AUTO
>  #define KEY_DISPLAY_OFF		245	/* display device to off state */
>  
>  #define KEY_WWAN		246	/* Wireless WAN (LTE, UMTS, GSM, etc.) */
> @@ -631,6 +634,7 @@ struct input_keymap_entry {
>  #define KEY_ADDRESSBOOK		0x1ad	/* AL Contacts/Address Book */
>  #define KEY_MESSENGER		0x1ae	/* AL Instant Messaging */
>  #define KEY_DISPLAYTOGGLE	0x1af	/* Turn display (LCD) on and off */
> +#define KEY_BRIGHTNESS_TOGGLE	KEY_DISPLAYTOGGLE
>  #define KEY_SPELLCHECK		0x1b0   /* AL Spell Check */
>  #define KEY_LOGOFF		0x1b1   /* AL Logoff */
>  
> @@ -722,6 +726,17 @@ struct input_keymap_entry {
>  
>  #define KEY_ALS_TOGGLE		0x230	/* Ambient light sensor */
>  
> +#define KEY_BUTTONCONFIG		0x240	/* AL Button Configuration */
> +#define KEY_TASKMANAGER		0x241	/* AL Task/Project Manager */
> +#define KEY_JOURNAL		0x242	/* AL Log/Journal/Timecard */
> +#define KEY_CONTROLPANEL		0x243	/* AL Control Panel */
> +#define KEY_APPSELECT		0x244	/* AL Select Task/Application */
> +#define KEY_SCREENSAVER		0x245	/* AL Screen Saver */
> +#define KEY_VOICECOMMAND		0x246	/* Listening Voice Command */
> +
> +#define KEY_BRIGHTNESS_MIN		0x250	/* Set Brightness to Minimum */
> +#define KEY_BRIGHTNESS_MAX		0x251	/* Set Brightness to Maximum */
> +
>  #define BTN_TRIGGER_HAPPY		0x2c0
>  #define BTN_TRIGGER_HAPPY1		0x2c0
>  #define BTN_TRIGGER_HAPPY2		0x2c1
> -- 
> 1.9.0
> 

-- 
Dmitry
