From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] HID: Support telephony devices
Date: Fri, 7 Oct 2016 16:19:07 -0700
Message-ID: <20161007231907.GA8473@dtor-ws>
References: <1475736899-21279-1-git-send-email-nolsen@jabra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34611 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbcJGXTK (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 7 Oct 2016 19:19:10 -0400
Received: by mail-pf0-f194.google.com with SMTP id 190so3518188pfv.1
        for <linux-input@vger.kernel.org>; Fri, 07 Oct 2016 16:19:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1475736899-21279-1-git-send-email-nolsen@jabra.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: nolsen@jabra.com
Cc: linux-input@vger.kernel.org, jikos@kernel.org, benjamin.tissoires@redhat.com

On Thu, Oct 06, 2016 at 08:54:59AM +0200, nolsen@jabra.com wrote:
> From: Niels Skou Olsen <nolsen@jabra.com>
> 
> Add support for telephony device buttons and LEDs as described in the USB
> HID Usage Tables specification.
> 
> This allows user mode applications convenient access to telephony devices
> such as headsets, speaker phones and desk phones.
> 
> Signed-off-by: Niels Skou Olsen <nolsen@jabra.com>
> ---
> Changes in v2:
>  - hid_usage_table[]: "LedRinger" -> "RingerTone"
>  - hidinput_configure_usage(): Change LED_SPEAKER mapping to LED usage
>  - input_led_info[]: Add LED_RINGER
>  - IS_INPUT_APPLICATION(): predicate now includes: Phone, Answering Machine, Message Controls, Handset and Headset collections

I'd rather we did not add any new leds to the input core. The ones
defined there are legacy that we have had since before LED subsystem was
introduced. The new LEDs should be using LED subsystem directly.

Thanks.

> 
> 
>  drivers/hid/hid-debug.c                | 39 ++++++++++++++++++++-
>  drivers/hid/hid-input.c                | 63 +++++++++++++++++++++++++++++++---
>  drivers/input/input-leds.c             |  6 ++++
>  include/linux/hid.h                    | 12 ++++++-
>  include/linux/mod_devicetable.h        |  2 +-
>  include/uapi/linux/input-event-codes.h | 18 +++++++++-
>  6 files changed, 131 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
> index acfb522..b017745 100644
> --- a/drivers/hid/hid-debug.c
> +++ b/drivers/hid/hid-debug.c
> @@ -129,9 +129,42 @@ static const struct hid_usage_entry hid_usage_table[] = {
>        {0, 0x03, "ScrollLock"},
>        {0, 0x04, "Compose"},
>        {0, 0x05, "Kana"},
> +	{0, 0x09, "Mute"},
> +	{0, 0x17, "OffHook"},
> +	{0, 0x18, "Ring"},
> +	{0, 0x19, "MessageWaiting"},
> +	{0, 0x20, "Hold"},
> +	{0, 0x21, "Microphone"},
> +	{0, 0x27, "Standby"},
> +	{0, 0x2a, "Online"},
> +	{0, 0x4c, "SystemSuspend"},
> +	{0, 0x4d, "ExtPowerConnected"},
>        {0, 0x4b, "GenericIndicator"},
>    {  9, 0, "Button" },
>    { 10, 0, "Ordinal" },
> +	{ 11, 0, "Telephony" },
> +	{0, 0x20, "KeyHookSwitch"},
> +	{0, 0x21, "KeyFlash"},
> +	{0, 0x23, "KeyHold"},
> +	{0, 0x24, "KeyRedial"},
> +	{0, 0x2f, "KeyMicMute"},
> +	{0, 0x9e, "RingerTone"},
> +	{0, 0xb0, "KeyNumeric0"},
> +	{0, 0xb1, "KeyNumeric1"},
> +	{0, 0xb2, "KeyNumeric2"},
> +	{0, 0xb3, "KeyNumeric3"},
> +	{0, 0xb4, "KeyNumeric4"},
> +	{0, 0xb5, "KeyNumeric5"},
> +	{0, 0xb6, "KeyNumeric6"},
> +	{0, 0xb7, "KeyNumeric7"},
> +	{0, 0xb8, "KeyNumeric8"},
> +	{0, 0xb9, "KeyNumeric9"},
> +	{0, 0xba, "KeyNumericStar"},
> +	{0, 0xbb, "KeyNumericPound"},
> +	{0, 0xbc, "KeyNumericA"},
> +	{0, 0xbd, "KeyNumericB"},
> +	{0, 0xbe, "KeyNumericC"},
> +	{0, 0xbf, "KeyNumericD"},
>    { 12, 0, "Consumer" },
>        {0, 0x238, "HorizontalWheel"},
>    { 13, 0, "Digitizers" },
> @@ -998,7 +1031,11 @@ static const char *leds[LED_MAX + 1] = {
>  	[LED_SCROLLL] = "ScrollLock",	[LED_COMPOSE] = "Compose",
>  	[LED_KANA] = "Kana",		[LED_SLEEP] = "Sleep",
>  	[LED_SUSPEND] = "Suspend",	[LED_MUTE] = "Mute",
> -	[LED_MISC] = "Misc",
> +	[LED_MISC] = "Misc",		[LED_MAIL] = "Mail",
> +	[LED_CHARGING] = "Charging",	[LED_OFF_HOOK] = "Off-hook",
> +	[LED_RING] = "Ring",		[LED_RINGER] = "Ringer",
> +	[LED_HOLD] = "Hold",		[LED_MICROPHONE] = "Microphone",
> +	[LED_ONLINE] = "Online"
>  };
>  
>  static const char *repeats[REP_MAX + 1] = {
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index fb9ace1..e6649d0 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -509,9 +509,11 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>  	if (field->report_count < 1)
>  		goto ignore;
>  
> -	/* only LED usages are supported in output fields */
> +	/* only LED and TELEPHONY usages are supported in output fields */
>  	if (field->report_type == HID_OUTPUT_REPORT &&
> -			(usage->hid & HID_USAGE_PAGE) != HID_UP_LED) {
> +			(usage->hid & HID_USAGE_PAGE) != HID_UP_LED &&
> +			(usage->hid & HID_USAGE_PAGE) != HID_UP_TELEPHONY) {
> +
>  		goto ignore;
>  	}
>  
> @@ -667,11 +669,35 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>  		case 0x03:  map_led (LED_SCROLLL);  break;    /*   "Scroll Lock"              */
>  		case 0x04:  map_led (LED_COMPOSE);  break;    /*   "Compose"                  */
>  		case 0x05:  map_led (LED_KANA);     break;    /*   "Kana"                     */
> -		case 0x27:  map_led (LED_SLEEP);    break;    /*   "Stand-By"                 */
> -		case 0x4c:  map_led (LED_SUSPEND);  break;    /*   "System Suspend"           */
>  		case 0x09:  map_led (LED_MUTE);     break;    /*   "Mute"                     */
> -		case 0x4b:  map_led (LED_MISC);     break;    /*   "Generic Indicator"        */
> +		case 0x17: /* "Off hook" */
> +			map_led(LED_OFF_HOOK);
> +			break;
> +		case 0x18: /* "Ring" */
> +			map_led(LED_RING);
> +			break;
>  		case 0x19:  map_led (LED_MAIL);     break;    /*   "Message Waiting"          */
> +		case 0x1e:
> +			map_led(LED_SPEAKER);
> +			break;
> +		case 0x20: /* "Hold" */
> +			map_led(LED_HOLD);
> +			break;
> +		case 0x21: /* "Microphone" */
> +			map_led(LED_MICROPHONE);
> +			break;
> +		case 0x27: /* "Stand-By" */
> +			map_led(LED_SLEEP);
> +			break;
> +		case 0x2a: /* "Online" */
> +			map_led(LED_ONLINE);
> +			break;
> +		case 0x4b: /* "Generic Indicator" */
> +			map_led(LED_MISC);
> +			break;
> +		case 0x4c: /* "System Suspend" */
> +			map_led(LED_SUSPEND);
> +			break;
>  		case 0x4d:  map_led (LED_CHARGING); break;    /*   "External Power Connected" */
>  
>  		default: goto ignore;
> @@ -741,7 +767,34 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>  
>  	case HID_UP_TELEPHONY:
>  		switch (usage->hid & HID_USAGE) {
> +		case 0x07:
> +			map_key_clear(KEY_PROGRAMMABLE);
> +			break;
> +		case 0x20:
> +			map_key_clear(KEY_HOOK_SWITCH);
> +			break;
> +		case 0x21:
> +			map_key_clear(KEY_FLASH);
> +			break;
> +		case 0x23:
> +			map_key_clear(KEY_HOLD);
> +			break;
> +		case 0x24:
> +			map_key_clear(KEY_REDIAL);
> +			break;
> +		case 0x2a:
> +			map_key_clear(KEY_LINE);
> +			break;
> +		case 0x2b:
> +			map_key_clear(KEY_SPEAKER_PHONE);
> +			break;
>  		case 0x2f: map_key_clear(KEY_MICMUTE);		break;
> +		case 0x50:
> +			map_key_clear(KEY_SPEED_DIAL);
> +			break;
> +		case 0x9e:
> +			map_led(LED_RINGER);
> +			break;
>  		case 0xb0: map_key_clear(KEY_NUMERIC_0);	break;
>  		case 0xb1: map_key_clear(KEY_NUMERIC_1);	break;
>  		case 0xb2: map_key_clear(KEY_NUMERIC_2);	break;
> diff --git a/drivers/input/input-leds.c b/drivers/input/input-leds.c
> index 766bf26..0977dc5 100644
> --- a/drivers/input/input-leds.c
> +++ b/drivers/input/input-leds.c
> @@ -36,6 +36,12 @@ static const struct {
>  	[LED_MISC]	= { "misc" },
>  	[LED_MAIL]	= { "mail" },
>  	[LED_CHARGING]	= { "charging" },
> +	[LED_OFF_HOOK]	= { "off-hook" },
> +	[LED_RING]	= { "ring" },
> +	[LED_HOLD]	= { "hold" },
> +	[LED_MICROPHONE] = { "microphone" },
> +	[LED_ONLINE]	= { "online" },
> +	[LED_RINGER]	= { "ringer" },
>  };
>  
>  struct input_led {
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index b2ec827..bdc5984 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -764,7 +764,17 @@ struct hid_ll_driver {
>  
>  /* Applications from HID Usage Tables 4/8/99 Version 1.1 */
>  /* We ignore a few input applications that are not widely used */
> -#define IS_INPUT_APPLICATION(a) (((a >= 0x00010000) && (a <= 0x00010008)) || (a == 0x00010080) || (a == 0x000c0001) || ((a >= 0x000d0002) && (a <= 0x000d0006)))
> +#define IS_INPUT_APPLICATION(a) (				\
> +		((a >= 0x00010000) && (a <= 0x00010008)) ||	\
> +		(a == 0x00010080) ||				\
> +		(a == 0x000b0001) ||				\
> +		(a == 0x000b0002) ||				\
> +		(a == 0x000b0003) ||				\
> +		(a == 0x000b0004) ||				\
> +		(a == 0x000b0005) ||				\
> +		(a == 0x000c0001) ||				\
> +		((a >= 0x000d0002) && (a <= 0x000d0006)))
> +
>  
>  /* HID core API */
>  
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> index ed84c07..e342d3f 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -288,7 +288,7 @@ struct pcmcia_device_id {
>  #define INPUT_DEVICE_ID_REL_MAX		0x0f
>  #define INPUT_DEVICE_ID_ABS_MAX		0x3f
>  #define INPUT_DEVICE_ID_MSC_MAX		0x07
> -#define INPUT_DEVICE_ID_LED_MAX		0x0f
> +#define INPUT_DEVICE_ID_LED_MAX		0x11
>  #define INPUT_DEVICE_ID_SND_MAX		0x07
>  #define INPUT_DEVICE_ID_FF_MAX		0x7f
>  #define INPUT_DEVICE_ID_SW_MAX		0x0f
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index d6d071f..eaa368b 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -593,6 +593,15 @@
>  
>  #define KEY_ALS_TOGGLE		0x230	/* Ambient light sensor */
>  
> +#define KEY_HOOK_SWITCH	0x231
> +#define KEY_FLASH		0x232
> +#define KEY_HOLD		0x233
> +#define KEY_REDIAL		0x234
> +#define KEY_PROGRAMMABLE	0x235
> +#define KEY_LINE		0x236
> +#define KEY_SPEAKER_PHONE	0x237
> +#define KEY_SPEED_DIAL		0x238
> +
>  #define KEY_BUTTONCONFIG		0x240	/* AL Button Configuration */
>  #define KEY_TASKMANAGER		0x241	/* AL Task/Project Manager */
>  #define KEY_JOURNAL		0x242	/* AL Log/Journal/Timecard */
> @@ -812,7 +821,14 @@
>  #define LED_MISC		0x08
>  #define LED_MAIL		0x09
>  #define LED_CHARGING		0x0a
> -#define LED_MAX			0x0f
> +#define LED_OFF_HOOK		0x0b
> +#define LED_RING		0x0c
> +#define LED_RINGER		0x0d
> +#define LED_HOLD		0x0e
> +#define LED_MICROPHONE		0x0f
> +#define LED_SPEAKER		0x10
> +#define LED_ONLINE		0x11
> +#define LED_MAX		0x11
>  #define LED_CNT			(LED_MAX+1)
>  
>  /*
> -- 
> 2.7.4
> 

-- 
Dmitry
