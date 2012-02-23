From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 1/1] Input: cyttsp - Fix check after pointer dereferencing
Date: Thu, 23 Feb 2012 13:33:09 +0100
Message-ID: <CABxcv=mYjk+kFkT-bWfLgda3GAy5HhSoCsg+H6iFbJTg1FZLfg@mail.gmail.com>
References: <1329302572-1651-1-git-send-email-javier@dowhile0.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44412 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429Ab2BWMdK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Feb 2012 07:33:10 -0500
Received: by iacb35 with SMTP id b35so1480271iac.19
        for <linux-input@vger.kernel.org>; Thu, 23 Feb 2012 04:33:10 -0800 (PST)
In-Reply-To: <1329302572-1651-1-git-send-email-javier@dowhile0.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Dan Carpenter <dan.carpenter@oracle.com>, linux-input@vger.kernel.org

On Wed, Feb 15, 2012 at 11:42 AM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:
> From: Javier Martinez Canillas <martinez.javier@dowhile0.org>
>
> In the cyttsp_probe() function the struct device *dev pointer was
> dereferenced before checking if it was NULL.
>
> Now dev is never NULL since both I2C and SPI bus drivers pass a point=
er to a
> member of an previously allocated structure. But others bus drivers c=
an do
> it differently so is better to sanity check instead of trust in the c=
allers.
>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
> ---
> =C2=A0drivers/input/touchscreen/cyttsp_core.c | =C2=A0 11 +++++++++--
> =C2=A01 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/touchscreen/cyttsp_core.c b/drivers/input/=
touchscreen/cyttsp_core.c
> index 8be2247..071e5ae8 100644
> --- a/drivers/input/touchscreen/cyttsp_core.c
> +++ b/drivers/input/touchscreen/cyttsp_core.c
> @@ -518,12 +518,19 @@ static void cyttsp_close(struct input_dev *dev)
> =C2=A0struct cyttsp *cyttsp_probe(const struct cyttsp_bus_ops *bus_op=
s,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *dev, int irq, size_t xfer_bu=
f_size)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 const struct cyttsp_platform_data *pdata =3D d=
ev->platform_data;
> + =C2=A0 =C2=A0 =C2=A0 const struct cyttsp_platform_data *pdata;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct cyttsp *ts;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct input_dev *input_dev;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int error;
>
> - =C2=A0 =C2=A0 =C2=A0 if (!dev || !bus_ops || !pdata || !pdata->name=
 || irq <=3D 0) {
> + =C2=A0 =C2=A0 =C2=A0 if (!dev || !bus_ops || !dev->platform_data ||=
 irq <=3D 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error =3D -EINVAL;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_out;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 pdata =3D dev->platform_data;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!pdata->name) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error =3D -EIN=
VAL;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_out;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> --
> 1.7.7.6
>

Hello,

Any feedback on this?

Is not a bug with today cyttsp driver since both I2C and SPI transport
drivers can't pass a NULL pointer, but I think Dan is right that is
better to sanity check since others transport drivers can be added in
the future.

Or this check is being to paranoiac?

Regards,
Javier
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
