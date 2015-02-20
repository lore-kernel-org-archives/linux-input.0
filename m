From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH 4/6] thinkpad_acpi: Add support for more adaptive kbd
 buttons
Date: Thu, 19 Feb 2015 21:35:09 -0800
Message-ID: <20150220053509.GE790@fury.dvhart.com>
References: <1424292828.32581.48.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:46220 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbbBTFfN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Feb 2015 00:35:13 -0500
Content-Disposition: inline
In-Reply-To: <1424292828.32581.48.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Wed, Feb 18, 2015 at 09:53:48PM +0100, Bastien Nocera wrote:
> This commit adds new elements to the ThinkPad keymaps, and
> will send key events for keys for which an input.h declaration
> exists.
> 
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> ---
>  drivers/platform/x86/thinkpad_acpi.c | 80 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 79 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 562d958..a47a56a 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -1911,6 +1911,27 @@ enum {	/* hot key scan codes (derived from ACPI DSDT) */
>  	TP_ACPI_HOTKEYSCAN_UNK7,
>  	TP_ACPI_HOTKEYSCAN_UNK8,
>  
> +	TP_ACPI_HOTKEYSCAN_MUTE2,
> +	TP_ACPI_HOTKEYSCAN_BRIGHTNESS_ZERO,
> +	TP_ACPI_HOTKEYSCAN_CLIPPING_TOOL,
> +	TP_ACPI_HOTKEYSCAN_CLOUD,
> +	TP_ACPI_HOTKEYSCAN_UNK9,
> +	TP_ACPI_HOTKEYSCAN_VOICE,
> +	TP_ACPI_HOTKEYSCAN_UNK10,
> +	TP_ACPI_HOTKEYSCAN_GESTURES,
> +	TP_ACPI_HOTKEYSCAN_UNK11,
> +	TP_ACPI_HOTKEYSCAN_UNK12,
> +	TP_ACPI_HOTKEYSCAN_UNK13,
> +	TP_ACPI_HOTKEYSCAN_CONFIG,
> +	TP_ACPI_HOTKEYSCAN_NEW_TAB,
> +	TP_ACPI_HOTKEYSCAN_RELOAD,
> +	TP_ACPI_HOTKEYSCAN_BACK,
> +	TP_ACPI_HOTKEYSCAN_MIC_DOWN,
> +	TP_ACPI_HOTKEYSCAN_MIC_UP,
> +	TP_ACPI_HOTKEYSCAN_MIC_CANCELLATION,
> +	TP_ACPI_HOTKEYSCAN_CAMERA_MODE,
> +	TP_ACPI_HOTKEYSCAN_ROTATE_DISPLAY,
> +
>  	/* Hotkey keymap size */
>  	TPACPI_HOTKEY_MAP_LEN
>  };
> @@ -3171,6 +3192,13 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
>  		/* (assignments unknown, please report if found) */
>  		KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
>  		KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
> +
> +		/* no assignments, only used for Adaptive keyboards */

Sentence formatting please.

> +		KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
> +		KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
> +		KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
> +		KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
> +		KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
>  		},
>  
>  	/* Generic keymap for Lenovo ThinkPads */
> @@ -3227,6 +3255,33 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
>  
>  		/* Extra keys in use since the X240 / T440 / T540 */
>  		KEY_CONFIG, KEY_SEARCH, KEY_SCALE, KEY_FILE,
> +
> +		/* Adaptive keyboard keycodes for Carbon X1 2014,
> +		 * The first item in this list is the Mute button
> +		 * which is emitted with 0x103 through
> +		 * adaptive_keyboard_hotkey_notify_hotkey ()
> +		 * when the sound symbol is held
> +		 * We'll need to offset those by 0x20 */

Please follow CodingStyle with /* and */ on their own lines. Also, wrapping is
strange, as is capitalization, etc.  Please terminate sentences with periods,
and only capitalize the beginning of sentences or proper nouns.

> +		KEY_RESERVED,        /* Mute held, 0x103 */
> +		KEY_BRIGHTNESS_MIN,  /* Backlight off */
> +		KEY_RESERVED,        /* Clipping tool */
> +		KEY_RESERVED,        /* Cloud */
> +		KEY_RESERVED,
> +		KEY_VOICECOMMAND,    /* Voice */
> +		KEY_RESERVED,
> +		KEY_RESERVED,        /* Gestures */
> +		KEY_RESERVED,
> +		KEY_RESERVED,
> +		KEY_RESERVED,
> +		KEY_CONFIG,          /* Settings */
> +		KEY_RESERVED,        /* New tab */
> +		KEY_REFRESH,         /* Reload */
> +		KEY_BACK,            /* Back */
> +		KEY_RESERVED,        /* Microphone down */
> +		KEY_RESERVED,        /* Microphone up */
> +		KEY_RESERVED,        /* Microphone cancellation */
> +		KEY_RESERVED,        /* Camera mode */
> +		KEY_RESERVED,        /* Rotate display, 0x116 */
>  		},
>  	};
>  
> @@ -3526,6 +3581,8 @@ const int adaptive_keyboard_modes[] = {
>  
>  #define DFR_CHANGE_ROW			0x101
>  #define DFR_SHOW_QUICKVIEW_ROW		0x102
> +#define FIRST_ADAPTIVE_KEY		0x103
> +#define ADAPTIVE_KEY_OFFSET		0x020
>  
>  /* press Fn key a while second, it will switch to Function Mode. Then
>   * release Fn key, previous mode be restored.
> @@ -3581,6 +3638,7 @@ static bool adaptive_keyboard_hotkey_notify_hotkey(unsigned int scancode)
>  {
>  	u32 current_mode = 0;
>  	int new_mode = 0;
> +	int keycode;
>  
>  	switch (scancode) {
>  	case DFR_CHANGE_ROW:
> @@ -3613,7 +3671,27 @@ static bool adaptive_keyboard_hotkey_notify_hotkey(unsigned int scancode)
>  		return true;
>  
>  	default:
> -		return false;
> +		if (scancode < FIRST_ADAPTIVE_KEY ||
> +			scancode > FIRST_ADAPTIVE_KEY +
> +				TPACPI_HOTKEY_MAP_LEN -
> +				ADAPTIVE_KEY_OFFSET) {
> +			pr_info("Unhandled adaptive keyboard key: 0x%x\n",
> +					scancode);
> +			return false;
> +		}
> +		keycode = hotkey_keycode_map[scancode - FIRST_ADAPTIVE_KEY + ADAPTIVE_KEY_OFFSET];

Please be consistent with your line wrapping. The if block above wraps early and
is a rather difficult to scan, while the keycode index goes well beyond 80
chars.

-- 
Darren Hart
Intel Open Source Technology Center
