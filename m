From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] [PATCH] Input: synaptics-rmi4 - select 'SERIO' when
 needed
Date: Tue, 7 Feb 2017 10:01:18 -0800
Message-ID: <20170207180118.GB38092@dtor-ws>
References: <20170207131357.694909-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35981 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754831AbdBGSBV (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 7 Feb 2017 13:01:21 -0500
Content-Disposition: inline
In-Reply-To: <20170207131357.694909-1-arnd@arndb.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Duggan <aduggan@synaptics.com>, Guenter Roeck <linux@roeck-us.net>, Christopher Heiny <cheiny@synaptics.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Nick Dyer <nick@shmanahar.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Feb 07, 2017 at 02:13:28PM +0100, Arnd Bergmann wrote:
> With CONFIG_SERIO=m, we get a build error for the rmi4-f03 driver,
> added in linux-4.10:
> 
> warning: (HID_RMI) selects RMI4_F03 which has unmet direct dependencies (!UML && INPUT && RMI4_CORE && (SERIO=y || RMI4_CORE=SERIO))
> drivers/input/built-in.o: In function `rmi_f03_attention':
> rmi_f03.c:(.text+0xcfe0): undefined reference to `serio_interrupt'
> rmi_f03.c:(.text+0xd055): undefined reference to `serio_interrupt'
> drivers/input/built-in.o: In function `rmi_f03_remove':
> rmi_f03.c:(.text+0xd115): undefined reference to `serio_unregister_port'
> drivers/input/built-in.o: In function `rmi_f03_probe':
> rmi_f03.c:(.text+0xd209): undefined reference to `__serio_register_port'
> 
> An earlier patch tried to fix this, but missed the HID_RMI driver that
> does a 'select' on the F03 backend.
> 
> This adds a hidden Kconfig symbol that enforces 'serio' to be enabled
> when RMI4-F03 is, which covers all cases.
> 
> Fixes: d7ddad0acc4a ("Input: synaptics-rmi4 - fix F03 build error when serio is module")
> Fixes: c5e8848fc98e ("Input: synaptics-rmi4 - add support for F03")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thank you.

> ---
> Sorry for dropping the ball on this earlier, I had the patch in my
> randconfig tree but didn't mark it appropriately so I only stumbled
> over it today when it failed to apply.
> ---
>  drivers/input/rmi4/Kconfig | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/rmi4/Kconfig b/drivers/input/rmi4/Kconfig
> index 78a78b99ec31..fd98a17925da 100644
> --- a/drivers/input/rmi4/Kconfig
> +++ b/drivers/input/rmi4/Kconfig
> @@ -43,13 +43,19 @@ config RMI4_SMB
>  
>  config RMI4_F03
>  	bool "RMI4 Function 03 (PS2 Guest)"
> -	depends on SERIO=y || RMI4_CORE=SERIO
>  	help
>  	  Say Y here if you want to add support for RMI4 function 03.
>  
>  	  Function 03 provides PS2 guest support for RMI4 devices. This
>  	  includes support for TrackPoints on TouchPads.
>  
> +config RMI4_F03_SERIO
> +	tristate
> +	depends on RMI4_CORE
> +	depends on RMI4_F03
> +	default RMI4_CORE
> +	select SERIO
> +
>  config RMI4_2D_SENSOR
>  	bool
>  
> -- 
> 2.9.0
> 

-- 
Dmitry
