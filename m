From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: holtekff: move MODULE_* parameters out of #ifdef
 block
Date: Mon, 27 Nov 2017 09:18:20 +0100
Message-ID: <20171127081820.GC30708@mail.corp.redhat.com>
References: <20171126043404.11621-1-dja@axtens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34548 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751138AbdK0ISY (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 27 Nov 2017 03:18:24 -0500
Content-Disposition: inline
In-Reply-To: <20171126043404.11621-1-dja@axtens.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Axtens <dja@axtens.net>
Cc: jikos@kernel.org, linux-input@vger.kernel.org, anssi.hannula@iki.fi

On Nov 26 2017 or thereabouts, Daniel Axtens wrote:
> If you compile with:
> CONFIG_HID_HOLTEK=m
> CONFIG_HOLTEK_FF is not set
> 
> You get the following warning:
> WARNING: modpost: missing MODULE_LICENSE() in drivers/hid/hid-holtekff.o
> see include/linux/module.h for more information
> 
> Fix this by moving the module info out of the #ifdef CONFIG_HOLTEK_FF
> block and into the un-guarded part of the file.
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/hid/hid-holtekff.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hid/hid-holtekff.c b/drivers/hid/hid-holtekff.c
> index 9325545fc3ae..edc0f64bb584 100644
> --- a/drivers/hid/hid-holtekff.c
> +++ b/drivers/hid/hid-holtekff.c
> @@ -32,10 +32,6 @@
>  
>  #ifdef CONFIG_HOLTEK_FF
>  
> -MODULE_LICENSE("GPL");
> -MODULE_AUTHOR("Anssi Hannula <anssi.hannula@iki.fi>");
> -MODULE_DESCRIPTION("Force feedback support for Holtek On Line Grip based devices");
> -
>  /*
>   * These commands and parameters are currently known:
>   *
> @@ -223,3 +219,7 @@ static struct hid_driver holtek_driver = {
>  	.probe = holtek_probe,
>  };
>  module_hid_driver(holtek_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Anssi Hannula <anssi.hannula@iki.fi>");
> +MODULE_DESCRIPTION("Force feedback support for Holtek On Line Grip based devices");
> -- 
> 2.11.0
> 
