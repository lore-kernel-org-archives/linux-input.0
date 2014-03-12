From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: fix dependencies of OLPC AP-SP driver
Date: Tue, 11 Mar 2014 23:11:34 -0700
Message-ID: <20140312061134.GA2263@core.coreip.homeip.net>
References: <20140311194253.23daf5e3@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:51718 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754150AbaCLGLh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Mar 2014 02:11:37 -0400
Received: by mail-pa0-f54.google.com with SMTP id lf10so635825pab.27
        for <linux-input@vger.kernel.org>; Tue, 11 Mar 2014 23:11:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140311194253.23daf5e3@endymion.delvare>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-input@vger.kernel.org

Hi Jean,

On Tue, Mar 11, 2014 at 07:42:53PM +0100, Jean Delvare wrote:
> I don't think the OLPC AP-SP driver is generally useful without OLPC
> support. So make it depend on OLPC, unless build testing is enabled.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/serio/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-3.14-rc6.orig/drivers/input/serio/Kconfig	2014-02-09 16:53:02.931633818 +0100
> +++ linux-3.14-rc6/drivers/input/serio/Kconfig	2014-03-11 18:52:42.280541110 +0100
> @@ -263,7 +263,7 @@ config SERIO_APBPS2
>  
>  config SERIO_OLPC_APSP
>  	tristate "OLPC AP-SP input support"
> -	depends on OF
> +	depends on OLPC || (OF && COMPILE_TEST)

Actually for compile coverage we do not actually need OF, I'll make it

	depends on OLPC || COMPILE_TEST

instead.

>  	help
>  	  Say Y here if you want support for the keyboard and touchpad included
>  	  in the OLPC XO-1.75 and XO-4 laptops.
> 
> 

Thanks.

-- 
Dmitry
