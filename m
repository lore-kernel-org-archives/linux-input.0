From: =?UTF-8?Q?Cl=C3=A9ment_VUCHENER?= <clement.vuchener@gmail.com>
Subject: Re: [PATCH] HID: corsair: Convert to use module_hid_driver
Date: Sun, 20 Dec 2015 12:08:42 +0100
Message-ID: <CAM4jgCoegj+ryKwffL0TZvtO_y6pFsT8W-GCSWH0OkUrzSErrw@mail.gmail.com>
References: <1450256199.17220.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:35323 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932509AbbLTLIn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Dec 2015 06:08:43 -0500
Received: by mail-ig0-f171.google.com with SMTP id to4so20194564igc.0
        for <linux-input@vger.kernel.org>; Sun, 20 Dec 2015 03:08:43 -0800 (PST)
In-Reply-To: <1450256199.17220.1.camel@ingics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input <linux-input@vger.kernel.org>

2015-12-16 9:56 GMT+01:00 Axel Lin <axel.lin@ingics.com>:
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
I am not sure if I am required to ack trivial patches, but no one answe=
red.

I have no preference toward the old or new code. If it is the prefered
way to do that, I have no problem with it.

Acked-by: Cl=C3=A9ment Vuchener <clement.vuchener@gmail.com>
> ---
>  drivers/hid/hid-corsair.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/drivers/hid/hid-corsair.c b/drivers/hid/hid-corsair.c
> index bcefb9e..5855196 100644
> --- a/drivers/hid/hid-corsair.c
> +++ b/drivers/hid/hid-corsair.c
> @@ -655,18 +655,7 @@ static struct hid_driver corsair_driver =3D {
>         .input_mapping =3D corsair_input_mapping,
>  };
>
> -static int __init corsair_init(void)
> -{
> -       return hid_register_driver(&corsair_driver);
> -}
> -
> -static void corsair_exit(void)
> -{
> -       hid_unregister_driver(&corsair_driver);
> -}
> -
> -module_init(corsair_init);
> -module_exit(corsair_exit);
> +module_hid_driver(corsair_driver);
>
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Clement Vuchener");
> --
> 2.1.4
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
