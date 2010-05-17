From: Robert Schedel <r.schedel@yahoo.de>
Subject: Re: [PATCH 2.6.34-rc7 v4] HID: hid-samsung: add support for Creative
 Desktop Wireless 6000
Date: Mon, 17 May 2010 19:11:25 +0200
Message-ID: <4BF178BD.2000209@yahoo.de>
References: <4BF11D9F.80605@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp131.mail.ukl.yahoo.com ([77.238.184.62]:38942 "HELO
	smtp131.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751560Ab0EQRLx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 May 2010 13:11:53 -0400
In-Reply-To: <4BF11D9F.80605@yahoo.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dhprince.devel@yahoo.co.uk, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

sorry for one late observation:

On 17.05.2010 12:42, Don Prince wrote:
> Add support for the multimedia buttons of the Creative Desktop Wireless
> 6000 keyboard/mouse combo which are not currently handled by the
> default/samsung HID driver.
> 
> Signed-off-by: Don Prince <dhprince-devel@yahoo.co.uk>
> 
> ---
> 
> Added comments as requested by Robert Schedel <r.schedel@yahoo.de>
> 
> As requested by Jiri Kosina, made key mapping code more concise
> i.e. ignored checkpatch.pl's wingeing about code style.
[...]
> +	switch (usage->hid & HID_USAGE) {
> +	/* report 2 */
> +	case 0x0b5: samsung_kbd_mouse_map_key_clear(KEY_NEXTSONG); break;
> +	case 0x0b6: samsung_kbd_mouse_map_key_clear(KEY_PREVIOUSSONG); break;
> +	case 0x0b7: samsung_kbd_mouse_map_key_clear(KEY_STOPCD); break;
> +	case 0x0cd: samsung_kbd_mouse_map_key_clear(KEY_PLAYPAUSE); break;
> +	case 0x0e2: samsung_kbd_mouse_map_key_clear(KEY_MUTE); break;
> +	case 0x0e9: samsung_kbd_mouse_map_key_clear(KEY_VOLUMEUP); break;
> +	case 0x0ea: samsung_kbd_mouse_map_key_clear(KEY_VOLUMEDOWN); break;

Those seven are identical to hid-input.c mapping (HUT 1.1 compliant) and could simply be deleted. Daisy chaining via default case below, right?

> +	case 0x183: samsung_kbd_mouse_map_key_clear(KEY_MEDIA); break;
> +	case 0x195: samsung_kbd_mouse_map_key_clear(KEY_EMAIL);	break;
> +	case 0x196: samsung_kbd_mouse_map_key_clear(KEY_CALC); break;
> +	case 0x197: samsung_kbd_mouse_map_key_clear(KEY_COMPUTER); break;
> +	case 0x22b: samsung_kbd_mouse_map_key_clear(KEY_SEARCH); break;
> +	case 0x22c: samsung_kbd_mouse_map_key_clear(KEY_WWW); break;
> +	case 0x22d: samsung_kbd_mouse_map_key_clear(KEY_BACK); break;
> +	case 0x22e: samsung_kbd_mouse_map_key_clear(KEY_FORWARD); break;
> +	case 0x22f: samsung_kbd_mouse_map_key_clear(KEY_FAVORITES); break;
> +	case 0x230: samsung_kbd_mouse_map_key_clear(KEY_REFRESH); break;
> +	case 0x231: samsung_kbd_mouse_map_key_clear(KEY_STOP); break;
> +	default:
> +		return 0;

Regards,
Robert Schedel
