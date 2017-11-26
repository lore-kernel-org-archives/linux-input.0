From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH] HID: holtekff: move =?UTF-8?Q?MODULE=5F*=20parameters?=
 =?UTF-8?Q?=20out=20of=20=23ifdef=20block?=
Date: Sun, 26 Nov 2017 13:33:41 +0200
Message-ID: <1c7617b1459da7d5663bd79a5017d7ac@mail.onse.fi>
References: <20171126043404.11621-1-dja@axtens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from webmail.tpnet.fi ([62.106.63.33]:44529 "EHLO webmail.tpnet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752071AbdKZLjy (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 26 Nov 2017 06:39:54 -0500
In-Reply-To: <20171126043404.11621-1-dja@axtens.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Axtens <dja@axtens.net>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, jikos@kernel.org

Hi,

Daniel Axtens kirjoitti 2017-11-26 06:34:
> If you compile with:
> CONFIG_HID_HOLTEK=m
> CONFIG_HOLTEK_FF is not set
> 
> You get the following warning:
> WARNING: modpost: missing MODULE_LICENSE() in 
> drivers/hid/hid-holtekff.o
> see include/linux/module.h for more information
> 
> Fix this by moving the module info out of the #ifdef CONFIG_HOLTEK_FF
> block and into the un-guarded part of the file.
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Thanks!

Acked-by: Anssi Hannula <anssi.hannula@iki.fi>

> ---
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
> -MODULE_DESCRIPTION("Force feedback support for Holtek On Line Grip
> based devices");
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
> +MODULE_DESCRIPTION("Force feedback support for Holtek On Line Grip
> based devices");

-- 
Anssi Hannula
