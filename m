From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] Input: ts4800: add hardware dependency
Date: Fri, 4 Mar 2016 11:42:01 -0800
Message-ID: <20160304194201.GD17145@dtor-ws>
References: <20160209111549.7e9b4fbb@endymion>
 <20160209111847.21902883@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35539 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758765AbcCDTmF (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Mar 2016 14:42:05 -0500
Content-Disposition: inline
In-Reply-To: <20160209111847.21902883@endymion>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>, Damien Riegel <damien.riegel@savoirfairelinux.com>, linux-input@vger.kernel.org

On Tue, Feb 09, 2016 at 11:18:47AM +0100, Jean Delvare wrote:
> The Technologic Systems TS-4800 is an i.MX515 board, so its drivers
> are useless unless building a SOC_IMX51 kernel, except for build
> testing purposes.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>

Applied, thank you.

> Cc: Damien Riegel <damien.riegel@savoirfairelinux.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/touchscreen/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-4.5-rc3.orig/drivers/input/touchscreen/Kconfig	2016-02-02 09:02:08.180924572 +0100
> +++ linux-4.5-rc3/drivers/input/touchscreen/Kconfig	2016-02-09 08:58:50.693442294 +0100
> @@ -941,6 +941,7 @@ config TOUCHSCREEN_TOUCHIT213
>  config TOUCHSCREEN_TS4800
>  	tristate "TS-4800 touchscreen"
>  	depends on HAS_IOMEM && OF
> +	depends on SOC_IMX51 || COMPILE_TEST
>  	select MFD_SYSCON
>  	select INPUT_POLLDEV
>  	help
> 
> -- 
> Jean Delvare
> SUSE L3 Support

-- 
Dmitry
