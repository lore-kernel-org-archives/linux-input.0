From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] synaptics: fix rmi4 bus dependencies
Date: Tue, 2 Jan 2018 11:21:43 -0800
Message-ID: <20180102192143.egooy4onto73qd3y@dtor-ws>
References: <20180102191609.21460-1-mcroce@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:42722 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750928AbeABTVr (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 2 Jan 2018 14:21:47 -0500
Received: by mail-io0-f196.google.com with SMTP id x67so43797198ioi.9
        for <linux-input@vger.kernel.org>; Tue, 02 Jan 2018 11:21:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20180102191609.21460-1-mcroce@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matteo Croce <mcroce@redhat.com>
Cc: linux-input@vger.kernel.org, Andrew Duggan <aduggan@synaptics.com>

On Tue, Jan 02, 2018 at 08:16:09PM +0100, Matteo Croce wrote:
> Make MOUSE_PS2_SYNAPTICS_SMBUS select MOUSE_PS2_SYNAPTICS because if
> the latter is disabled the detection and switching code isn't being run.

Hmm, it should. In synaptics.c:

#if defined(CONFIG_MOUSE_PS2_SYNAPTICS) || \
    defined(CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS)

int synaptics_init(struct psmouse *psmouse)
{
	struct synaptics_device_info info;
	int error;
	int retval;

	psmouse_reset(psmouse);
...
}

The intent was to allow disabling the PS/2 portion of Synaptics driver
while retaining the switching to SMbus capability.

Thanks.

> 
> Signed-off-by: Matteo Croce <mcroce@redhat.com>
> ---
>  drivers/input/mouse/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
> index 89ebb8f39fee..77a0bcb611a4 100644
> --- a/drivers/input/mouse/Kconfig
> +++ b/drivers/input/mouse/Kconfig
> @@ -83,6 +83,7 @@ config MOUSE_PS2_SYNAPTICS_SMBUS
>  	default y
>  	depends on MOUSE_PS2
>  	depends on I2C=y || I2C=MOUSE_PS2
> +	select MOUSE_PS2_SYNAPTICS
>  	select MOUSE_PS2_SMBUS
>  	help
>  	  Say Y here if you have a Synaptics RMI4 touchpad connected to
> -- 
> 2.14.3
> 

-- 
Dmitry
