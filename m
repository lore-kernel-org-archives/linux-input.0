From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 03/16 v2] Input: atmel_mxt_ts - refactor
 mxt_read/write_reg to take a length
Date: Sat, 14 Apr 2012 12:12:16 +0800
Message-ID: <CAGS+omDgJJ2o0gAzV=FLXy7vPZuCxftC1+bwz2qOye7DiOb7uw@mail.gmail.com>
References: <1333039766-8617-1-git-send-email-djkurtz@chromium.org>
 <1333039766-8617-4-git-send-email-djkurtz@chromium.org> <20120411090556.GA32061@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:35763 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707Ab2DNEMi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 14 Apr 2012 00:12:38 -0400
Received: by qcro28 with SMTP id o28so2278830qcr.19
        for <linux-input@vger.kernel.org>; Fri, 13 Apr 2012 21:12:37 -0700 (PDT)
In-Reply-To: <20120411090556.GA32061@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Nick Dyer <nick.dyer@itdev.co.uk>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>

On Wed, Apr 11, 2012 at 5:05 PM, Henrik Rydberg <rydberg@bitmath.se> wr=
ote:
>
> Hi Daniel,
>
> > The i2c bus requires 5 bytes to do a 1 byte read (1-byte i2c addres=
s + 2
> > byte offset + 1-byte i2c address + 1 byte data), or 4 bytes to do a
> > 1-byte write (1 byte i2c address + 2 byte offset + 1 byte data).
> >
> > By taking a length with reads and writes, the driver can amortize
> > transaction overhead by performing larger transactions where
> > appropriate.
> >
> > This patch just sets up the new API. =A0Later patches refactor
> > reads/writes
> > to take advantage of the larger transactions.
> >
> > Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> > Reviewed-by: Joonyoung Shim <jy0922.shim@samsung.com>
> > ---
> > =A0drivers/input/touchscreen/atmel_mxt_ts.c | =A0 47
> > +++++++++++++----------------
> > =A01 files changed, 21 insertions(+), 26 deletions(-)
> >
> > diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c
> > b/drivers/input/touchscreen/atmel_mxt_ts.c
> > index 15ae6fd..971f9dc 100644
> > --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> > +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> > @@ -397,8 +397,7 @@ static int mxt_fw_write(struct i2c_client *clie=
nt,
> > =A0 =A0 =A0 return 0;
> > =A0}
> >
> > -static int __mxt_read_reg(struct i2c_client *client,
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u16 reg, u=
16 len, void *val)
> > +static int mxt_read_reg(struct i2c_client *client, u16 reg, u16 le=
n,
> > void *val)
> > =A0{
> > =A0 =A0 =A0 struct i2c_msg xfer[2];
> > =A0 =A0 =A0 u8 buf[2];
> > @@ -419,28 +418,25 @@ static int __mxt_read_reg(struct i2c_client
> > *client,
> > =A0 =A0 =A0 xfer[1].buf =3D val;
> >
> > =A0 =A0 =A0 if (i2c_transfer(client->adapter, xfer, 2) !=3D 2) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "%s: i2c transfer f=
ailed\n",
> > __func__);
> > + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "%s: i2c read faile=
d\n", __func__);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
> > =A0 =A0 =A0 }
> >
> > =A0 =A0 =A0 return 0;
> > =A0}
> >
> > -static int mxt_read_reg(struct i2c_client *client, u16 reg, u8 *va=
l)
> > +static int mxt_write_reg(struct i2c_client *client, u16 reg, u16 l=
en,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const void *val)
> > =A0{
> > - =A0 =A0 return __mxt_read_reg(client, reg, 1, val);
> > -}
> > -
> > -static int mxt_write_reg(struct i2c_client *client, u16 reg, u8 va=
l)
> > -{
> > - =A0 =A0 u8 buf[3];
> > + =A0 =A0 size_t count =3D 2 + len; =A0 =A0 =A0 =A0 /* + 2-byte off=
set */
> > + =A0 =A0 u8 buf[count];
>
> How much stack space are you planning to use here?

I missed this one when removing the other stack allocated array since
they are (rightly) frowned upon in the kernel.  I will replace with a
malloc, unless you have a better suggestion?

>
> >
> > =A0 =A0 =A0 buf[0] =3D reg & 0xff;
> > =A0 =A0 =A0 buf[1] =3D (reg >> 8) & 0xff;
> > - =A0 =A0 buf[2] =3D val;
> > + =A0 =A0 memcpy(&buf[2], val, len);
> >
> > - =A0 =A0 if (i2c_master_send(client, buf, 3) !=3D 3) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "%s: i2c send faile=
d\n", __func__);
> > + =A0 =A0 if (i2c_master_send(client, buf, count) !=3D count) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "%s: i2c write fail=
ed\n", __func__);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
> > =A0 =A0 =A0 }
> >
> > @@ -450,8 +446,7 @@ static int mxt_write_reg(struct i2c_client *cli=
ent,
> > u16 reg, u8 val)
> > =A0static int mxt_read_object_table(struct i2c_client *client,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 u16 reg, u8 *object_buf)
> > =A0{
> > - =A0 =A0 return __mxt_read_reg(client, reg, MXT_OBJECT_SIZE,
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ob=
ject_buf);
> > + =A0 =A0 return mxt_read_reg(client, reg, MXT_OBJECT_SIZE, object_=
buf);
> > =A0}
> >
> > =A0static struct mxt_object *
> > @@ -481,8 +476,8 @@ static int mxt_read_message(struct mxt_data *da=
ta,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> >
> > =A0 =A0 =A0 reg =3D object->start_address;
> > - =A0 =A0 return __mxt_read_reg(data->client, reg,
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(struct mxt_message=
), message);
> > + =A0 =A0 return mxt_read_reg(data->client, reg, sizeof(struct mxt_=
message),
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 message);
> > =A0}
> >
> > =A0static int mxt_read_object(struct mxt_data *data,
> > @@ -496,7 +491,7 @@ static int mxt_read_object(struct mxt_data *dat=
a,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> >
> > =A0 =A0 =A0 reg =3D object->start_address;
> > - =A0 =A0 return __mxt_read_reg(data->client, reg + offset, 1, val)=
;
> > + =A0 =A0 return mxt_read_reg(data->client, reg + offset, 1, val);
> > =A0}
> >
> > =A0static int mxt_write_object(struct mxt_data *data,
> > @@ -510,7 +505,7 @@ static int mxt_write_object(struct mxt_data *da=
ta,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> >
> > =A0 =A0 =A0 reg =3D object->start_address;
> > - =A0 =A0 return mxt_write_reg(data->client, reg + offset, val);
> > + =A0 =A0 return mxt_write_reg(data->client, reg + offset, 1, &val)=
;
> > =A0}
> >
> > =A0static void mxt_input_report(struct mxt_data *data, int single_i=
d)
> > @@ -757,27 +752,27 @@ static int mxt_get_info(struct mxt_data *data=
)
> > =A0 =A0 =A0 int error;
> > =A0 =A0 =A0 u8 val;
> >
> > - =A0 =A0 error =3D mxt_read_reg(client, MXT_FAMILY_ID, &val);
> > + =A0 =A0 error =3D mxt_read_reg(client, MXT_FAMILY_ID, 1, &val);
> > =A0 =A0 =A0 if (error)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 return error;
> > =A0 =A0 =A0 info->family_id =3D val;
> >
> > - =A0 =A0 error =3D mxt_read_reg(client, MXT_VARIANT_ID, &val);
> > + =A0 =A0 error =3D mxt_read_reg(client, MXT_VARIANT_ID, 1, &val);
> > =A0 =A0 =A0 if (error)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 return error;
> > =A0 =A0 =A0 info->variant_id =3D val;
> >
> > - =A0 =A0 error =3D mxt_read_reg(client, MXT_VERSION, &val);
> > + =A0 =A0 error =3D mxt_read_reg(client, MXT_VERSION, 1, &val);
> > =A0 =A0 =A0 if (error)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 return error;
> > =A0 =A0 =A0 info->version =3D val;
> >
> > - =A0 =A0 error =3D mxt_read_reg(client, MXT_BUILD, &val);
> > + =A0 =A0 error =3D mxt_read_reg(client, MXT_BUILD, 1, &val);
> > =A0 =A0 =A0 if (error)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 return error;
> > =A0 =A0 =A0 info->build =3D val;
> >
> > - =A0 =A0 error =3D mxt_read_reg(client, MXT_OBJECT_NUM, &val);
> > + =A0 =A0 error =3D mxt_read_reg(client, MXT_OBJECT_NUM, 1, &val);
> > =A0 =A0 =A0 if (error)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 return error;
> > =A0 =A0 =A0 info->object_num =3D val;
> > @@ -860,12 +855,12 @@ static int mxt_initialize(struct mxt_data *da=
ta)
> > =A0 =A0 =A0 msleep(MXT_RESET_TIME);
> >
> > =A0 =A0 =A0 /* Update matrix size at info struct */
> > - =A0 =A0 error =3D mxt_read_reg(client, MXT_MATRIX_X_SIZE, &val);
> > + =A0 =A0 error =3D mxt_read_reg(client, MXT_MATRIX_X_SIZE, 1, &val=
);
> > =A0 =A0 =A0 if (error)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 return error;
> > =A0 =A0 =A0 info->matrix_xsize =3D val;
> >
> > - =A0 =A0 error =3D mxt_read_reg(client, MXT_MATRIX_Y_SIZE, &val);
> > + =A0 =A0 error =3D mxt_read_reg(client, MXT_MATRIX_Y_SIZE, 1, &val=
);
> > =A0 =A0 =A0 if (error)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 return error;
> > =A0 =A0 =A0 info->matrix_ysize =3D val;
> > --
> > 1.7.7.3
> >
>
> Thanks,
> Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
