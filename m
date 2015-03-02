From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 4/4] thinkpad_acpi: Add support for more adaptive kbd buttons
Date: Mon, 02 Mar 2015 14:17:01 -0300
Message-ID: <1425316621.517951.234432209.03ABFEFA@webmail.messagingengine.com>
References: <1425303931.16791.35.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40727 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751610AbbCBRRC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Mar 2015 12:17:02 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 19BCE20A9A
	for <linux-input@vger.kernel.org>; Mon,  2 Mar 2015 12:17:01 -0500 (EST)
In-Reply-To: <1425303931.16791.35.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>, Darren Hart <dvhart@infradead.org>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

On Mon, Mar 2, 2015, at 10:45, Bastien Nocera wrote:
> This commit adds new elements to the ThinkPad keymaps, and
> will send key events for keys for which an input.h declaration
> exists.
> 
> Signed-off-by: Bastien Nocera <hadess@hadess.net>

Reviewed-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

> ---
>  drivers/platform/x86/thinkpad_acpi.c | 80
>  +++++++++++++++++++++++++++++++++++-
>  1 file changed, 79 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c
> b/drivers/platform/x86/thinkpad_acpi.c
> index ae528cf..5d76f18 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -1912,6 +1912,27 @@ enum {   /* hot key scan codes (derived from ACPI
> DSDT) */
>  	TP_ACPI_HOTKEYSCAN_UNK7,
>  	TP_ACPI_HOTKEYSCAN_UNK8,
>  
> +       TP_ACPI_HOTKEYSCAN_MUTE2,
> +       TP_ACPI_HOTKEYSCAN_BRIGHTNESS_ZERO,
> +       TP_ACPI_HOTKEYSCAN_CLIPPING_TOOL,
> +       TP_ACPI_HOTKEYSCAN_CLOUD,
> +       TP_ACPI_HOTKEYSCAN_UNK9,
> +       TP_ACPI_HOTKEYSCAN_VOICE,
> +       TP_ACPI_HOTKEYSCAN_UNK10,
> +       TP_ACPI_HOTKEYSCAN_GESTURES,
> +       TP_ACPI_HOTKEYSCAN_UNK11,
> +       TP_ACPI_HOTKEYSCAN_UNK12,
> +       TP_ACPI_HOTKEYSCAN_UNK13,
> +       TP_ACPI_HOTKEYSCAN_CONFIG,
> +       TP_ACPI_HOTKEYSCAN_NEW_TAB,
> +       TP_ACPI_HOTKEYSCAN_RELOAD,
> +       TP_ACPI_HOTKEYSCAN_BACK,
> +       TP_ACPI_HOTKEYSCAN_MIC_DOWN,
> +       TP_ACPI_HOTKEYSCAN_MIC_UP,
> +       TP_ACPI_HOTKEYSCAN_MIC_CANCELLATION,
> +       TP_ACPI_HOTKEYSCAN_CAMERA_MODE,
> +       TP_ACPI_HOTKEYSCAN_ROTATE_DISPLAY,
> +
>  	/* Hotkey keymap size */
>  	TPACPI_HOTKEY_MAP_LEN
>  };
> @@ -3170,6 +3191,13 @@ static int __init hotkey_init(struct
> ibm_init_struct *iibm)
>  		/* (assignments unknown, please report if found) */
>  		KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
>  		KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
> +
> +               /* No assignments, only used for Adaptive keyboards. */
> +               KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
> +               KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
> +               KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
> +               KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
> +               KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
>  		},
>  
>  	/* Generic keymap for Lenovo ThinkPads */
> @@ -3226,6 +3254,35 @@ static int __init hotkey_init(struct
> ibm_init_struct *iibm)
>  
>  		/* Extra keys in use since the X240 / T440 / T540 */
>  		KEY_CONFIG, KEY_SEARCH, KEY_SCALE, KEY_FILE,
> +
> +               /*
> +                * These are the adaptive keyboard keycodes for Carbon X1
> 2014.
> +                * The first item in this list is the Mute button which
> is
> +                * emitted with 0x103 through
> +                * adaptive_keyboard_hotkey_notify_hotkey() when the
> sound
> +                * symbol is held.
> +                * We'll need to offset those by 0x20.
> +                */
> +               KEY_RESERVED,        /* Mute held, 0x103 */
> +               KEY_BRIGHTNESS_MIN,  /* Backlight off */
> +               KEY_RESERVED,        /* Clipping tool */
> +               KEY_RESERVED,        /* Cloud */
> +               KEY_RESERVED,
> +               KEY_VOICECOMMAND,    /* Voice */
> +               KEY_RESERVED,
> +               KEY_RESERVED,        /* Gestures */
> +               KEY_RESERVED,
> +               KEY_RESERVED,
> +               KEY_RESERVED,
> +               KEY_CONFIG,          /* Settings */
> +               KEY_RESERVED,        /* New tab */
> +               KEY_REFRESH,         /* Reload */
> +               KEY_BACK,            /* Back */
> +               KEY_RESERVED,        /* Microphone down */
> +               KEY_RESERVED,        /* Microphone up */
> +               KEY_RESERVED,        /* Microphone cancellation */
> +               KEY_RESERVED,        /* Camera mode */
> +               KEY_RESERVED,        /* Rotate display, 0x116 */
>  		},
>  	};
>  
> @@ -3527,6 +3584,8 @@ static const int adaptive_keyboard_modes[] = {
>  
>  #define DFR_CHANGE_ROW                  0x101
>  #define DFR_SHOW_QUICKVIEW_ROW          0x102
> +#define FIRST_ADAPTIVE_KEY             0x103
> +#define ADAPTIVE_KEY_OFFSET            0x020
>  
>  /* press Fn key a while second, it will switch to Function Mode. Then
>   * release Fn key, previous mode be restored.
> @@ -3582,6 +3641,7 @@ static bool
> adaptive_keyboard_hotkey_notify_hotkey(unsigned int scancode)
>  {
>  	u32 current_mode = 0;
>  	int new_mode = 0;
> +       int keycode;
>  
>  	switch (scancode) {
>  	case DFR_CHANGE_ROW:
> @@ -3614,7 +3674,25 @@ static bool
> adaptive_keyboard_hotkey_notify_hotkey(unsigned int scancode)
>  		return true;
>  
>  	default:
> -               return false;
> +               if (scancode < FIRST_ADAPTIVE_KEY || scancode >
> FIRST_ADAPTIVE_KEY +
> +                               TPACPI_HOTKEY_MAP_LEN -
> ADAPTIVE_KEY_OFFSET) {
> +                       pr_info("Unhandled adaptive keyboard key:
> 0x%x\n",
> +                                       scancode);
> +                       return false;
> +               }
> +               keycode = hotkey_keycode_map[scancode -
> FIRST_ADAPTIVE_KEY + ADAPTIVE_KEY_OFFSET];
> +               if (keycode != KEY_RESERVED) {
> +                       mutex_lock(&tpacpi_inputdev_send_mutex);
> +
> +                       input_report_key(tpacpi_inputdev, keycode, 1);
> +                       input_sync(tpacpi_inputdev);
> +
> +                       input_report_key(tpacpi_inputdev, keycode, 0);
> +                       input_sync(tpacpi_inputdev);
> +
> +                       mutex_unlock(&tpacpi_inputdev_send_mutex);
> +               }
> +               return true;
>  	}
>  }
>  
> -- 
> 2.1.0
> 
> 


-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
