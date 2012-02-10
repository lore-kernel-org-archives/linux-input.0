From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: Input: add Cypress TTSP capacitive multi-touch screen support
Date: Fri, 10 Feb 2012 01:04:00 +0100
Message-ID: <CABxcv=kg4VmiLqbsB7y=Ohwgofm5_rr0qkMg90gy7980pm3dkg@mail.gmail.com>
References: <20120201094039.GA20690@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50309 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756580Ab2BJAEB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Feb 2012 19:04:01 -0500
Received: by iacb35 with SMTP id b35so3218338iac.19
        for <linux-input@vger.kernel.org>; Thu, 09 Feb 2012 16:04:00 -0800 (PST)
In-Reply-To: <20120201094039.GA20690@elgon.mountain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-input@vger.kernel.org

On Wed, Feb 1, 2012 at 10:40 AM, Dan Carpenter <dan.carpenter@oracle.co=
m> wrote:
> Hello Javier Martinez Canillas,
>
> This is a semi-automatic email about new static checker warnings.
>
> The patch 4065d1e7b216: "Input: add Cypress TTSP capacitive
> multi-touch screen support" from Jan 31, 2012, leads to the following
> Smatch complaint:
>
> drivers/input/touchscreen/cyttsp_core.c +526 cyttsp_probe()
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 warn: variable dereferenced before check =
'dev' (see line 521)
>
> drivers/input/touchscreen/cyttsp_core.c
> =C2=A0 520 =C2=A0{
> =C2=A0 521 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct cyttsp_plat=
form_data *pdata =3D dev->platform_data;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^^^^^
> dereference.
>
> =C2=A0 522 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct cyttsp *ts;
> =C2=A0 523 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct input_dev *input_=
dev;
> =C2=A0 524 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int error;
> =C2=A0 525
> =C2=A0 526 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!dev || !bus_ops || =
!pdata || !pdata->name || irq <=3D 0) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
^^^^
> check.
>
> =C2=A0 527 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0error =3D -EINVAL;
> =C2=A0 528 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0goto err_out;
>
> "dev" is never NULL here so the check can be removed probably.
>
> regards,
> dan carpenter

Hello Dan,

Thank you for running smatch on this driver.
dev is never NULL since both i2c and spi bus drivers pass as an
argument a pointer to a member of an previously allocated structure
(struct i2c_client and struct spi_device respectively).

But you are right that is wrong to check after dereferencing the
pointer. Instead of remove the !dev check I will move the pdata
assignment after the check. I'll send a patch now to fix the issue.

Thank you and best regards,
Javier
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
