From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: corsair: Convert to use module_hid_driver
Date: Mon, 28 Dec 2015 13:12:03 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1512281311510.9922@cbobk.fhfr.pm>
References: <1450256199.17220.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34655 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751479AbbL1MMF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Dec 2015 07:12:05 -0500
In-Reply-To: <1450256199.17220.1.camel@ingics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: =?ISO-8859-15?Q?Cl=E9ment_Vuchener?= <clement.vuchener@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On Wed, 16 Dec 2015, Axel Lin wrote:

> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/hid/hid-corsair.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/hid/hid-corsair.c b/drivers/hid/hid-corsair.c
> index bcefb9e..5855196 100644
> --- a/drivers/hid/hid-corsair.c
> +++ b/drivers/hid/hid-corsair.c
> @@ -655,18 +655,7 @@ static struct hid_driver corsair_driver = {
>  	.input_mapping = corsair_input_mapping,
>  };
>  
> -static int __init corsair_init(void)
> -{
> -	return hid_register_driver(&corsair_driver);
> -}
> -
> -static void corsair_exit(void)
> -{
> -	hid_unregister_driver(&corsair_driver);
> -}
> -
> -module_init(corsair_init);
> -module_exit(corsair_exit);
> +module_hid_driver(corsair_driver);
>  
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Clement Vuchener");

Applied to for-4.5/upstream.

-- 
Jiri Kosina
SUSE Labs

