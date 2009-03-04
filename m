From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] thinkpad-acpi: use correct key names for sleep states
	in driver
Date: Wed, 4 Mar 2009 09:04:40 -0300
Message-ID: <20090304120439.GA31850@khazad-dum.debian.net>
References: <1235992429.3858.58.camel@hughsie-work.lan> <20090302112400.GA2356@khazad-dum.debian.net> <1236164049.3936.17.camel@hughsie-work.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1236164049.3936.17.camel@hughsie-work.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Peter Hutterer <peter.hutterer@redhat.com>, mjg <mjg@redhat.com>, linux-input <linux-input@vger.kernel.org>, Matthias Clasen <mclasen@redhat.com>
List-Id: linux-input@vger.kernel.org

On Wed, 04 Mar 2009, Richard Hughes wrote:
> >From d3ce499f80ba7526e83e7b16f85124ccf77ac1f4 Mon Sep 17 00:00:00 2001
> From: Richard Hughes <richard@hughsie.com>
> Date: Wed, 4 Mar 2009 10:51:52 +0000
> Subject: thinkpad-acpi: use correct key names for sleep keys in driver
> 
> Use the new key KEY_HIBERNATE and correct the use of KEY_SUSPEND.
> 
> KEY_HIBERNATE is used when the decal on the key indicates sleep to disk,
> KEY_SUSPEND is used when the decal indicates sleep to memory, and
> KEY_SLEEP is used when the sleep type is unknown or unspecified
> 
> We've already converted Xorg, HAL, and most of userspace to use the same names.
> 
> With this patch, the sleep keys can be labeled consistently all the way
> through the stack. More patches to other device drivers are to follow.
> 
> Signed-off-by: Richard Hughes <hughsient@gmail.com>

Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

> ---
>  drivers/platform/x86/thinkpad_acpi.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index bcbc051..d89015d 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -2241,9 +2241,9 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
>  	 */
>  	static u16 ibm_keycode_map[] __initdata = {
>  		/* Scan Codes 0x00 to 0x0B: ACPI HKEY FN+F1..F12 */
> -		KEY_FN_F1,	KEY_FN_F2,	KEY_COFFEE,	KEY_SLEEP,
> +		KEY_FN_F1,	KEY_FN_F2,	KEY_COFFEE,	KEY_SUSPEND,
>  		KEY_WLAN,	KEY_FN_F6, KEY_SWITCHVIDEOMODE, KEY_FN_F8,
> -		KEY_FN_F9,	KEY_FN_F10,	KEY_FN_F11,	KEY_SUSPEND,
> +		KEY_FN_F9,	KEY_FN_F10,	KEY_FN_F11,	KEY_HIBERNATE,
>  
>  		/* Scan codes 0x0C to 0x1F: Other ACPI HKEY hot keys */
>  		KEY_UNKNOWN,	/* 0x0C: FN+BACKSPACE */
> @@ -2277,9 +2277,9 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
>  	};
>  	static u16 lenovo_keycode_map[] __initdata = {
>  		/* Scan Codes 0x00 to 0x0B: ACPI HKEY FN+F1..F12 */
> -		KEY_FN_F1,	KEY_COFFEE,	KEY_BATTERY,	KEY_SLEEP,
> +		KEY_FN_F1,	KEY_COFFEE,	KEY_BATTERY,	KEY_SUSPEND,
>  		KEY_WLAN,	KEY_FN_F6, KEY_SWITCHVIDEOMODE, KEY_FN_F8,
> -		KEY_FN_F9,	KEY_FN_F10,	KEY_FN_F11,	KEY_SUSPEND,
> +		KEY_FN_F9,	KEY_FN_F10,	KEY_FN_F11,	KEY_HIBERNATE,
>  
>  		/* Scan codes 0x0C to 0x1F: Other ACPI HKEY hot keys */
>  		KEY_UNKNOWN,	/* 0x0C: FN+BACKSPACE */


-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
