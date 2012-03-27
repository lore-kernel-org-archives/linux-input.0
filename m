From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [patch] Input: wacom - check for allocation failure in probe()
Date: Tue, 27 Mar 2012 15:39:10 -0500
Message-ID: <CAGzDe_a+RWkXz5UA39Bv51sm+Gb=0_5ZnmJMd_CJDmr2jRhtdg@mail.gmail.com>
References: <20120327201511.GA9197@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:48454 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753498Ab2C0UjM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Mar 2012 16:39:12 -0400
Received: by lahj13 with SMTP id j13so330661lah.19
        for <linux-input@vger.kernel.org>; Tue, 27 Mar 2012 13:39:11 -0700 (PDT)
In-Reply-To: <20120327201511.GA9197@elgon.mountain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ping Cheng <pingc@wacom.com>, Eduard Hasenleithner <eduard@hasenleithner.at>, Jason Gerecke <killertofu@gmail.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

Thanks for catch.

Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>

On Tue, Mar 27, 2012 at 3:15 PM, Dan Carpenter <dan.carpenter@oracle.co=
m> wrote:
> We accidentally removed the check for NULL in 3aac0ef10b "Input: waco=
m -
> isolate input registration".
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/=
wacom_sys.c
> index 19ba586..0d26921 100644
> --- a/drivers/input/tablet/wacom_sys.c
> +++ b/drivers/input/tablet/wacom_sys.c
> @@ -1002,6 +1002,8 @@ static int wacom_probe(struct usb_interface *in=
tf, const struct usb_device_id *i
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>
> =A0 =A0 =A0 =A0wacom =3D kzalloc(sizeof(struct wacom), GFP_KERNEL);
> + =A0 =A0 =A0 if (!wacom)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>
> =A0 =A0 =A0 =A0wacom_wac =3D &wacom->wacom_wac;
> =A0 =A0 =A0 =A0wacom_wac->features =3D *((struct wacom_features *)id-=
>driver_info);
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
