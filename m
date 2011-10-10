From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH v5 2/3] Input: cyttsp - add support for Cypress TTSP
 touchscreen I2C bus interface
Date: Mon, 10 Oct 2011 20:51:18 +0200
Message-ID: <CAAwP0s0rgn=eihEJSrH03aP54Dtd3bEb++82ReWAb9MEnr+zCQ@mail.gmail.com>
References: <1318099080-26227-1-git-send-email-martinez.javier@gmail.com>
 <1318099080-26227-3-git-send-email-martinez.javier@gmail.com> <CAM=Q2cvpw4hUA5zY8Gc9xM4wi1wVNJB92iD=X65u1ip6K72pSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:55183 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972Ab1JJSvi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Oct 2011 14:51:38 -0400
In-Reply-To: <CAM=Q2cvpw4hUA5zY8Gc9xM4wi1wVNJB92iD=X65u1ip6K72pSA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mohan Pallaka <mpallaka@codeaurora.org>, Kevin McNeely <kev@cypress.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Oct 10, 2011 at 3:55 PM, Shubhrajyoti Datta
<omaplinuxkernel@gmail.com> wrote:
> Hello Martinez,
> Some=C2=A0 small comments.
>
>

Hi Shubhrajyoti,

Thanks for the review.

> On Sun, Oct 9, 2011 at 12:07 AM, Javier Martinez Canillas
> <martinez.javier@gmail.com> wrote:
>>
>> The driver is composed of a core driver that process the data sent b=
y
>> the contacts and a set of bus specific interface modules.
>>
>> Signed-off-by: Javier Martinez Canillas <martinez.javier@gmail.com>
>> ---
>>
>> v2: Fix issues called out by Dmitry Torokhov
>> =C2=A0 =C2=A0- Extract the IRQ from the i2c client data and pass to
>> cyttsp_core_init()
>>
>> v3: Fix issues called out by Henrik Rydberg and Mohan Pallaka
>> =C2=A0 =C2=A0- Remove bus type info since it is not used.
>>
>> =C2=A0drivers/input/touchscreen/cyttsp/cyttsp_i2c.c | =C2=A0190
>> +++++++++++++++++++++++++
>> =C2=A01 files changed, 190 insertions(+), 0 deletions(-)
>> =C2=A0create mode 100644 drivers/input/touchscreen/cyttsp/cyttsp_i2c=
=2Ec
>>
>> diff --git a/drivers/input/touchscreen/cyttsp/cyttsp_i2c.c
>> b/drivers/input/touchscreen/cyttsp/cyttsp_i2c.c
>> new file mode 100644
>> index 0000000..146a16d
>> --- /dev/null
>> +++ b/drivers/input/touchscreen/cyttsp/cyttsp_i2c.c
>> @@ -0,0 +1,190 @@
>> +/*
>> + * Source for:
>> + * Cypress TrueTouch(TM) Standard Product (TTSP) I2C touchscreen dr=
iver.
>> + * For use with Cypress Txx3xx parts.
>> + * Supported parts include:
>> + * CY8CTST341
>> + * CY8CTMA340
>> + *
>> + * Copyright (C) 2009, 2010, 2011 Cypress Semiconductor, Inc.
>> + * Copyright (C) 2011 Javier Martinez Canillas
>> <martinez.javier@gmail.com>
>> + *
>> + * Multi-touch protocol type B support and cleanups by Javier Marti=
nez
>> Canillas
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * version 2, and only version 2, as published by the
>> + * Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =C2=A0See t=
he
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public Licens=
e
>> along
>> + * with this program; if not, write to the Free Software Foundation=
,
>> Inc.,
>> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
>> + *
>> + * Contact Cypress Semiconductor at www.cypress.com <kev@cypress.co=
m>
>> + *
>> + */
>> +
>> +#include "cyttsp_core.h"
>> +
>> +#include <linux/i2c.h>
>> +#include <linux/slab.h>
>> +
>> +#define CY_I2C_DATA_SIZE =C2=A0128
>> +
>> +struct cyttsp_i2c {
>> + =C2=A0 =C2=A0 =C2=A0 struct cyttsp_bus_ops ops;
>> + =C2=A0 =C2=A0 =C2=A0 struct i2c_client *client;
>> + =C2=A0 =C2=A0 =C2=A0 void *ttsp_client;
>> + =C2=A0 =C2=A0 =C2=A0 u8 wr_buf[CY_I2C_DATA_SIZE];
>> +};
>> +
>> +static s32 ttsp_i2c_read_block_data(void *handle, u8 addr,
>> + =C2=A0 =C2=A0 =C2=A0 u8 length, void *values)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 struct cyttsp_i2c *ts =3D container_of(handle=
, struct cyttsp_i2c,
>> ops);
>> + =C2=A0 =C2=A0 =C2=A0 int retval =3D 0;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 retval =3D i2c_master_send(ts->client, &addr,=
 1);
>> + =C2=A0 =C2=A0 =C2=A0 if (retval < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return retval;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 retval =3D i2c_master_recv(ts->client, values=
, length);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 return (retval < 0) ? retval : 0;
>
> Trivial comment:
> Could we check the bytes written ?
> Feel free to ignore if you feel so.

Yes, you are right. I also think that I should check if retval =3D=3D
length and return an error code otherwise.

>>
>> +}
>> +
>> +static s32 ttsp_i2c_write_block_data(void *handle, u8 addr,
>> + =C2=A0 =C2=A0 =C2=A0 u8 length, const void *values)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 struct cyttsp_i2c *ts =3D container_of(handle=
, struct cyttsp_i2c,
>> ops);
>> + =C2=A0 =C2=A0 =C2=A0 int retval;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 ts->wr_buf[0] =3D addr;
>> + =C2=A0 =C2=A0 =C2=A0 memcpy(&ts->wr_buf[1], values, length);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 retval =3D i2c_master_send(ts->client, ts->wr=
_buf, length+1);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 return (retval < 0) ? retval : 0;
>> +}
>> +
>> +static s32 ttsp_i2c_tch_ext(void *handle, void *values)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 struct cyttsp_i2c *ts =3D container_of(handle=
, struct cyttsp_i2c,
>> ops);
>> + =C2=A0 =C2=A0 =C2=A0 int retval =3D 0;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* TODO: Add custom touch extension hand=
ling code here
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* set: retval < 0 for any returned syst=
em errors,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0 =C2=A0 =C2=A0retval =3D 0 if n=
ormal touch handling is required,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0 =C2=A0 =C2=A0retval > 0 if nor=
mal touch handling is *not* required
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 =C2=A0 if (!ts || !values)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D -EINVA=
L;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 return retval;
>> +}
>> +
>> +static int __devinit cyttsp_i2c_probe(struct i2c_client *client,
>> + =C2=A0 =C2=A0 =C2=A0 const struct i2c_device_id *id)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 struct cyttsp_i2c *ts;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 if (!i2c_check_functionality(client->adapter,=
 I2C_FUNC_I2C))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EIO;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 /* allocate and clear memory */
>> + =C2=A0 =C2=A0 =C2=A0 ts =3D kzalloc(sizeof(*ts), GFP_KERNEL);
>> + =C2=A0 =C2=A0 =C2=A0 if (!ts) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_dbg(&client->=
dev, "%s: Error, kzalloc.\n", __func__);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
>> + =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 /* register driver_data */
>> + =C2=A0 =C2=A0 =C2=A0 ts->client =3D client;
>> + =C2=A0 =C2=A0 =C2=A0 i2c_set_clientdata(client, ts);
>> + =C2=A0 =C2=A0 =C2=A0 ts->ops.write =3D ttsp_i2c_write_block_data;
>> + =C2=A0 =C2=A0 =C2=A0 ts->ops.read =3D ttsp_i2c_read_block_data;
>> + =C2=A0 =C2=A0 =C2=A0 ts->ops.ext =3D ttsp_i2c_tch_ext;
>> + =C2=A0 =C2=A0 =C2=A0 ts->ops.dev =3D &client->dev;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 ts->ttsp_client =3D cyttsp_core_init(&ts->ops=
, &client->dev,
>> client->irq);
>> + =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(ts->ttsp_client)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int retval =3D PT=
R_ERR(ts->ttsp_client);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree(ts);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return retval;
>> + =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 dev_dbg(ts->ops.dev, "%s: Registration comple=
te\n", __func__);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 return 0;
>> +}
>> +
>> +
>> +/* registered in driver struct */
>> +static int __devexit cyttsp_i2c_remove(struct i2c_client *client)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 struct cyttsp_i2c *ts;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 ts =3D i2c_get_clientdata(client);
>> + =C2=A0 =C2=A0 =C2=A0 cyttsp_core_release(ts->ttsp_client);
>> + =C2=A0 =C2=A0 =C2=A0 kfree(ts);
>> + =C2=A0 =C2=A0 =C2=A0 return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM
>> +static int cyttsp_i2c_suspend(struct i2c_client *client, pm_message=
_t
>> message)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 struct cyttsp_i2c *ts =3D i2c_get_clientdata(=
client);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 return cyttsp_suspend(ts->ttsp_client);
>> +}
>> +
>> +static int cyttsp_i2c_resume(struct i2c_client *client)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 struct cyttsp_i2c *ts =3D i2c_get_clientdata(=
client);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 return cyttsp_resume(ts->ttsp_client);
>> +}
>> +#endif
>> +
>> +static const struct i2c_device_id cyttsp_i2c_id[] =3D {
>> + =C2=A0 =C2=A0 =C2=A0 { CY_I2C_NAME, 0 }, =C2=A0{ }
>> +};
>> +
>> +static struct i2c_driver cyttsp_i2c_driver =3D {
>> + =C2=A0 =C2=A0 =C2=A0 .driver =3D {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D CY_I2C_=
NAME,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .owner =3D THIS_M=
ODULE,
>> + =C2=A0 =C2=A0 =C2=A0 },
>> + =C2=A0 =C2=A0 =C2=A0 .probe =3D cyttsp_i2c_probe,
>> + =C2=A0 =C2=A0 =C2=A0 .remove =3D __devexit_p(cyttsp_i2c_remove),
>> + =C2=A0 =C2=A0 =C2=A0 .id_table =3D cyttsp_i2c_id,
>> +#ifdef CONFIG_PM
>> + =C2=A0 =C2=A0 =C2=A0 .suspend =3D cyttsp_i2c_suspend,
>> + =C2=A0 =C2=A0 =C2=A0 .resume =3D cyttsp_i2c_resume,
>> +#endif
>
> How about moving to dev pm ops ?

Yes, I can move there.

Thank you for your comments, probably Henrik and others find issues
too. I will include these two in the next version of the driver.

>>
>> +};
>> +
>> +static int __init cyttsp_i2c_init(void)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 return i2c_add_driver(&cyttsp_i2c_driver);
>> +}
>> +
>> +static void __exit cyttsp_i2c_exit(void)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 return i2c_del_driver(&cyttsp_i2c_driver);
>> +}
>> +
>> +module_init(cyttsp_i2c_init);
>> +module_exit(cyttsp_i2c_exit);
>> +
>> +MODULE_ALIAS("i2c:cyttsp");
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("Cypress TrueTouch(R) Standard Product (TTSP) I2=
C
>> driver");
>> +MODULE_AUTHOR("Cypress");
>> +MODULE_DEVICE_TABLE(i2c, cyttsp_i2c_id);
>> --
>> 1.7.4.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-inpu=
t" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>
>

Best regards,

--=20
Javier Mart=C3=ADnez Canillas
(+34) 682 39 81 69
Barcelona, Spain
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
