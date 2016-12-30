From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH] Input: mousedev - stop offering PS/2 to userspace by
 default
Date: Fri, 30 Dec 2016 11:11:15 +1000
Message-ID: <110f81ed-e0c0-3651-01c2-34b06461e530@who-t.net>
References: <20161229180731.GA5321@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161229180731.GA5321@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 30/12/2016 04:07 , Dmitry Torokhov wrote:
> Evdev interface has been available for many years and by now everyone
> is switched to using it, so let's stop offering /dev/input/mouseN
> and /dev/psaux by default.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Peter Hutterer <peter.hutterer@who-t.net>

Cheers,
   Peter

> ---
>  drivers/input/Kconfig | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/input/Kconfig b/drivers/input/Kconfig
> index 6261874..ff80377 100644
> --- a/drivers/input/Kconfig
> +++ b/drivers/input/Kconfig
> @@ -94,7 +94,6 @@ comment "Userland interfaces"
>
>  config INPUT_MOUSEDEV
>  	tristate "Mouse interface"
> -	default y
>  	help
>  	  Say Y here if you want your mouse to be accessible as char devices
>  	  13:32+ - /dev/input/mouseX and 13:63 - /dev/input/mice as an
> @@ -109,7 +108,6 @@ config INPUT_MOUSEDEV
>
>  config INPUT_MOUSEDEV_PSAUX
>  	bool "Provide legacy /dev/psaux device"
> -	default y
>  	depends on INPUT_MOUSEDEV
>  	help
>  	  Say Y here if you want your mouse also be accessible as char device
> @@ -118,7 +116,6 @@ config INPUT_MOUSEDEV_PSAUX
>
>  	  If unsure, say Y.
>
> -
>  config INPUT_MOUSEDEV_SCREEN_X
>  	int "Horizontal screen resolution"
>  	depends on INPUT_MOUSEDEV
>
