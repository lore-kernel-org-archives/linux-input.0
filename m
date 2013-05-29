From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH -next] HID: holtek-mouse: use module_hid_driver() to
 simplify the code
Date: Wed, 29 May 2013 15:05:19 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1305291504520.30576@pobox.suse.cz>
References: <CAPgLHd-B1fsT0fAbJZq2KZEZW4wOogC=_cBKiS67Mp4PXtkDbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:54145 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934624Ab3E2NFe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 29 May 2013 09:05:34 -0400
In-Reply-To: <CAPgLHd-B1fsT0fAbJZq2KZEZW4wOogC=_cBKiS67Mp4PXtkDbw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: chr.ohm@gmx.net, yongjun_wei@trendmicro.com.cn, linux-input@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>

On Wed, 29 May 2013, Wei Yongjun wrote:

> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> module_hid_driver() makes the code simpler by eliminating
> boilerplate code.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/hid/hid-holtek-mouse.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/hid/hid-holtek-mouse.c b/drivers/hid/hid-holtek-mouse.c
> index 6a23ee6..7e6db3c 100644
> --- a/drivers/hid/hid-holtek-mouse.c
> +++ b/drivers/hid/hid-holtek-mouse.c
> @@ -73,16 +73,5 @@ static struct hid_driver holtek_mouse_driver = {
>  	.report_fixup = holtek_mouse_report_fixup,
>  };
>  
> -static int __init holtek_mouse_init(void)
> -{
> -	return hid_register_driver(&holtek_mouse_driver);
> -}
> -
> -static void __exit holtek_mouse_exit(void)
> -{
> -	hid_unregister_driver(&holtek_mouse_driver);
> -}
> -
> -module_exit(holtek_mouse_exit);
> -module_init(holtek_mouse_init);
> +module_hid_driver(holtek_mouse_driver);
>  MODULE_LICENSE("GPL");

Added

	Reported-by: Andy Shevchenko <andy.shevchenko@gmail.com>

and applied, thanks.

-- 
Jiri Kosina
SUSE Labs
