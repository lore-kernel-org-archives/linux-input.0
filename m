From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH -next] HID: use module_hid_driver() to simplify the
 code
Date: Mon, 26 Aug 2013 13:23:46 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1308261323410.2077@pobox.suse.cz>
References: <CAPgLHd9pb+49BC7BOOSrgkOWMQJQ76GcEGStt-UeaqGqtYfpFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47997 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752036Ab3HZLXv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Aug 2013 07:23:51 -0400
In-Reply-To: <CAPgLHd9pb+49BC7BOOSrgkOWMQJQ76GcEGStt-UeaqGqtYfpFQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: yongjun_wei@trendmicro.com.cn, linux-input@vger.kernel.org

On Fri, 23 Aug 2013, Wei Yongjun wrote:

> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> module_hid_driver() makes the code simpler by eliminating
> boilerplate code.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/hid/hid-xinmo.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/hid/hid-xinmo.c b/drivers/hid/hid-xinmo.c
> index 6153e50..7df5227 100644
> --- a/drivers/hid/hid-xinmo.c
> +++ b/drivers/hid/hid-xinmo.c
> @@ -57,16 +57,5 @@ static struct hid_driver xinmo_driver = {
>  	.event = xinmo_event
>  };
>  
> -static int __init xinmo_init(void)
> -{
> -	return hid_register_driver(&xinmo_driver);
> -}
> -
> -static void __exit xinmo_exit(void)
> -{
> -	hid_unregister_driver(&xinmo_driver);
> -}
> -
> -module_init(xinmo_init);
> -module_exit(xinmo_exit);
> +module_hid_driver(xinmo_driver);
>  MODULE_LICENSE("GPL");

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
