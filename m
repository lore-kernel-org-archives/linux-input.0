From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH -next] HID: steelseries: use module_hid_driver() to
 simplify the code
Date: Mon, 18 Mar 2013 10:53:03 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1303181052560.9529@pobox.suse.cz>
References: <CAPgLHd_6y1mr1moejftWGgrpO=vGxQUZ5Dz2v022kaFHdF-pVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59518 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753327Ab3CRJxM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Mar 2013 05:53:12 -0400
In-Reply-To: <CAPgLHd_6y1mr1moejftWGgrpO=vGxQUZ5Dz2v022kaFHdF-pVg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: yongjun_wei@trendmicro.com.cn, linux-input@vger.kernel.org

On Fri, 15 Mar 2013, Wei Yongjun wrote:

> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> module_hid_driver() makes the code simpler by eliminating
> boilerplate code..
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/hid/hid-steelseries.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
> index 98e66ac..9b0efb0 100644
> --- a/drivers/hid/hid-steelseries.c
> +++ b/drivers/hid/hid-steelseries.c
> @@ -377,16 +377,5 @@ static struct hid_driver steelseries_srws1_driver = {
>  	.report_fixup = steelseries_srws1_report_fixup
>  };
>  
> -static int __init steelseries_srws1_init(void)
> -{
> -	return hid_register_driver(&steelseries_srws1_driver);
> -}
> -
> -static void __exit steelseries_srws1_exit(void)
> -{
> -	hid_unregister_driver(&steelseries_srws1_driver);
> -}
> -
> -module_init(steelseries_srws1_init);
> -module_exit(steelseries_srws1_exit);
> +module_hid_driver(steelseries_srws1_driver);
>  MODULE_LICENSE("GPL");

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
