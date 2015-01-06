From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH trivial] HID: Spelling s/Keayboard/Keyboard/
Date: Tue, 6 Jan 2015 09:28:55 -0500
Message-ID: <20150106142854.GA26291@mail.corp.redhat.com>
References: <1420531753-10668-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420531753-10668-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Jan 06 2015 or thereabouts, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Good catch.

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> ---
>  drivers/hid/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 230b6f887cd86e9b..303b295a5413d39b 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -388,7 +388,7 @@ config HID_LOGITECH_HIDPP
>  	Say Y if you want support for Logitech devices relying on the HID++
>  	specification. Such devices are the various Logitech Touchpads (T650,
>  	T651, TK820), some mice (Zone Touch mouse), or even keyboards (Solar
> -	Keayboard).
> +	Keyboard).
>  
>  config LOGITECH_FF
>  	bool "Logitech force feedback support"
> -- 
> 1.9.1
> 
