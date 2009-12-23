From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [patch 1/1] hid: Logitech G13 driver 0.0.2
Date: Wed, 23 Dec 2009 01:16:03 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0912230111010.3755@pobox.suse.cz>
References: <200912220022.nBM0MMS8005004@imap1.linux-foundation.org> <alpine.LNX.2.00.0912230056120.3755@pobox.suse.cz> <20091222160307.0018bda9.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:59278 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751117AbZLWAQE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Dec 2009 19:16:04 -0500
In-Reply-To: <20091222160307.0018bda9.akpm@linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-input@vger.kernel.org, rvinyard@cs.nmsu.edu, dtor@mail.ru, oliver@neukum.org

On Tue, 22 Dec 2009, Andrew Morton wrote:

> > drivers/hid/hid-g13.c:121: error: field ___fb_defio___ has incomplete type
> > drivers/hid/hid-g13.c:1207: error: variable ___g13_fb_defio___ has initializerbut incomplete type
> > drivers/hid/hid-g13.c:1208: error: unknown field ___delay___ specified ininitializer
> > drivers/hid/hid-g13.c:1208: warning: excess elements in struct initializer
> > drivers/hid/hid-g13.c:1208: warning: (near initialization for ___g13_fb_defio___)
> > drivers/hid/hid-g13.c:1209: error: unknown field ___deferred_io___ specified in initializer
> > drivers/hid/hid-g13.c:1209: warning: excess elements in struct initializer
> > drivers/hid/hid-g13.c:1209: warning: (near initialization for ___g13_fb_defio___)
> > drivers/hid/hid-g13.c: In function ___g13_probe___:drivers/hid/hid-g13.c:1351: error: ___struct fb_info___ has no member named ___fbdefio___
> > 
> 
> Missing CONFIG_FB_DEFERRED_IO, I assume?
> 
> --- a/drivers/hid/Kconfig~hid-logitech-g13-driver-002-fix
> +++ a/drivers/hid/Kconfig
> @@ -187,6 +187,7 @@ config LOGITECH_G13
>  	tristate "Logitech G13 gameboard support"
>  	depends on HID_LOGITECH
>  	depends on FB
> +	depends on FB_DEFERRED_IO

Indeed, FB_DEFFERED_IO seems to be the culprit for this particular build 
problem ("select" instead of "depends" might be better here though).

Still, this is not the only build problem of this driver. Apparently it 
also doesn't like to be built as module (together with all the 
HID_LOGITECH stuff).

drivers/hid/hid-g13.o:(.rodata+0x1e0): multiple definition of `__mod_hid_device_table'
drivers/hid/hid-lg.o:(.rodata+0x540): first defined here
ld: Warning: size of symbol `__mod_hid_device_table' changed from 552 in drivers/hid/hid-lg.o to 48 in drivers/hid/hid-g13.o
drivers/hid/hid-g13.o: In function `g13_init':
/home/jkosina/src/hid/drivers/hid/hid-g13.c:1513: multiple definition of `init_module'
drivers/hid/hid-lg.o:/home/jkosina/src/hid/drivers/hid/hid-lg.c:354: first defined here
drivers/hid/hid-g13.o: In function `g13_exit':
/home/jkosina/src/hid/drivers/hid/hid-g13.c:1518: multiple definition of `cleanup_module'
drivers/hid/hid-lg.o:/home/jkosina/src/hid/drivers/hid/hid-lg.c:359: first defined here
make[1]: *** [drivers/hid/hid-logitech.o] Error 1

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
