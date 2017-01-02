From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] Input: mousedev - stop offering PS/2 to userspace by
 default
Date: Mon, 2 Jan 2017 10:44:37 +0100
Message-ID: <20170102094437.GC5767@mail.corp.redhat.com>
References: <20161229180731.GA5321@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45330 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932202AbdABJop (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 2 Jan 2017 04:44:45 -0500
Content-Disposition: inline
In-Reply-To: <20161229180731.GA5321@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Peter Hutterer <peter.hutterer@who-t.net>, Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org

On Dec 29 2016 or thereabouts, Dmitry Torokhov wrote:
> Evdev interface has been available for many years and by now everyone
> is switched to using it, so let's stop offering /dev/input/mouseN
> and /dev/psaux by default.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Makes sense to me

Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

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
> -- 
> 2.8.0.rc3.226.g39d4020
> 
> 
> -- 
> Dmitry
