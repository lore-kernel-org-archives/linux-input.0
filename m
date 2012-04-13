From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 11/16 v2] Input: atmel_mxt_ts - refactor reading object table
Date: Fri, 13 Apr 2012 17:21:13 +0800
Message-ID: <CAGS+omD5WxL4mrt8Czw7M3OAbuBH2CVO-EmFmhG3VucSNRuLCw@mail.gmail.com>
References: <1333039766-8617-1-git-send-email-djkurtz@chromium.org>
 <1333039766-8617-12-git-send-email-djkurtz@chromium.org> <20120413091147.GA3923@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46023 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757864Ab2DMJVe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Apr 2012 05:21:34 -0400
Received: by mail-iy0-f174.google.com with SMTP id z16so4004887iag.19
        for <linux-input@vger.kernel.org>; Fri, 13 Apr 2012 02:21:34 -0700 (PDT)
In-Reply-To: <20120413091147.GA3923@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Nick Dyer <nick.dyer@itdev.co.uk>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>

On Fri, Apr 13, 2012 at 5:11 PM, Henrik Rydberg <rydberg@euromail.se> w=
rote:
> Hi Daniel,
>
>> Instead of reading each object separately, fetch the whole table in =
one
>> large i2c transaction. =A0A 6 byte table object requires 10 bytes to=
 read,
>> so doing this dramatically reduces overhead.
>>
>> Also, as a cleanup, move object_table allocation (and post-fw-update
>> reallocation) into mxt_get_object_table().
>>
>> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
>> ---
>> =A0drivers/input/touchscreen/atmel_mxt_ts.c | =A0 66 +++++++++++++++=
---------------
>> =A01 files changed, 33 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/inpu=
t/touchscreen/atmel_mxt_ts.c
>> index 9d88faf..0d0dab6 100644
>> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
>> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
>> @@ -437,14 +437,7 @@ static int mxt_write_reg(struct i2c_client *cli=
ent, u16 reg, u16 len,
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> -static int mxt_read_object_table(struct i2c_client *client,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 u16 reg, u8 *object_buf)
>> -{
>> - =A0 =A0 return mxt_read_reg(client, reg, MXT_OBJECT_SIZE, object_b=
uf);
>> -}
>> -
>> -static struct mxt_object *
>> -mxt_get_object(struct mxt_data *data, u8 type)
>> +static struct mxt_object *mxt_get_object(struct mxt_data *data, u8 =
type)
>> =A0{
>> =A0 =A0 =A0 struct mxt_object *object;
>> =A0 =A0 =A0 int i;
>> @@ -733,25 +726,41 @@ static void mxt_handle_pdata(struct mxt_data *=
data)
>>
>> =A0static int mxt_get_object_table(struct mxt_data *data)
>> =A0{
>> + =A0 =A0 struct i2c_client *client =3D data->client;
>> + =A0 =A0 struct device *dev =3D &client->dev;
>> =A0 =A0 =A0 int error;
>> =A0 =A0 =A0 int i;
>> - =A0 =A0 u16 reg;
>> =A0 =A0 =A0 u8 reportid =3D 0;
>> - =A0 =A0 u8 buf[MXT_OBJECT_SIZE];
>> + =A0 =A0 u8 *buf;
>> + =A0 =A0 size_t buf_size;
>>
>> - =A0 =A0 for (i =3D 0; i < data->info.object_num; i++) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 struct mxt_object *object =3D data->object=
_table + i;
>> + =A0 =A0 /* Free old object table, if there was one. */
>> + =A0 =A0 kfree(data->object_table);
>> + =A0 =A0 data->object_table =3D kcalloc(data->info.object_num,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
sizeof(struct mxt_object), GFP_KERNEL);
>> + =A0 =A0 if (!data->object_table) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Failed to allocate object ta=
ble\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> + =A0 =A0 }
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 reg =3D MXT_OBJECT_START + MXT_OBJECT_SIZE=
 * i;
>> - =A0 =A0 =A0 =A0 =A0 =A0 error =3D mxt_read_object_table(data->clie=
nt, reg, buf);
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (error)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return error;
>> + =A0 =A0 buf_size =3D MXT_OBJECT_SIZE * data->info.object_num;
>> + =A0 =A0 buf =3D kmalloc(buf_size, GFP_KERNEL);
>> + =A0 =A0 if (!buf)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 object->type =3D buf[0];
>> - =A0 =A0 =A0 =A0 =A0 =A0 object->start_address =3D (buf[2] << 8) | =
buf[1];
>> - =A0 =A0 =A0 =A0 =A0 =A0 object->size =3D buf[3] + 1;
>> - =A0 =A0 =A0 =A0 =A0 =A0 object->instances =3D buf[4] + 1;
>> - =A0 =A0 =A0 =A0 =A0 =A0 object->num_report_ids =3D buf[5];
>> + =A0 =A0 error =3D mxt_read_reg(client, MXT_OBJECT_START, buf_size,=
 buf);
>> + =A0 =A0 if (error)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto done;
>> +
>> + =A0 =A0 for (i =3D 0; i < data->info.object_num; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct mxt_object *object =3D &data->objec=
t_table[i];
>> + =A0 =A0 =A0 =A0 =A0 =A0 u8 *obj_buf =3D &buf[i * MXT_OBJECT_SIZE];
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 object->type =3D obj_buf[0];
>> + =A0 =A0 =A0 =A0 =A0 =A0 object->start_address =3D (obj_buf[2] << 8=
) | obj_buf[1];
>> + =A0 =A0 =A0 =A0 =A0 =A0 object->size =3D obj_buf[3] + 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 object->instances =3D obj_buf[4] + 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 object->num_report_ids =3D obj_buf[5];
>
> Putting this conversion in a function would be nice, it would also
> make it clear that the inverse, used for writing, is currently
> missing. Alternatively, how about making the object struct actually
> match the read data? To top it off, one could introduce a collection,
> prepending the buffer size, making the write operation trivial.

AFAIK, there is no corresponding "object table" write. The "object
table" (maybe more aptly named the "object descriptor table") is an
immutable blob read from firmware that describes some actual data
objects elsewhere in device memory.  It is those actual objects that
are writable.  When they are written, it is the actual size, location
and number of instances (not their raw '-1' values) that is useful.

Thanks,
-Daniel

>
> struct mxt_raw_object {
> =A0 =A0 =A0 =A0u8 type;
> =A0 =A0 =A0 =A0__le16 start_address_le;
> =A0 =A0 =A0 =A0u8 size_minus_one;
> =A0 =A0 =A0 =A0u8 instances_minus_one;
> =A0 =A0 =A0 =A0u8 num_report_ids;
> };
>
> struct mxt_raw_object_collection {
> =A0 =A0 =A0 __le16 total_bytes_le;
> =A0 =A0 =A0 struct mxt_raw_object instance[MAX_NUM_OBJECTS];
> };
>
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (object->num_report_ids) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reportid +=3D object->nu=
m_report_ids * object->instances;
>> @@ -759,7 +768,9 @@ static int mxt_get_object_table(struct mxt_data =
*data)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 return 0;
>> +done:
>> + =A0 =A0 kfree(buf);
>> + =A0 =A0 return error;
>> =A0}
>>
>> =A0static int mxt_initialize(struct mxt_data *data)
>> @@ -774,14 +785,6 @@ static int mxt_initialize(struct mxt_data *data=
)
>> =A0 =A0 =A0 if (error)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return error;
>>
>> - =A0 =A0 data->object_table =3D kcalloc(info->object_num,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
sizeof(struct mxt_object),
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
GFP_KERNEL);
>> - =A0 =A0 if (!data->object_table) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "Failed to allocate =
memory\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> - =A0 =A0 }
>> -
>> =A0 =A0 =A0 /* Get object table information */
>> =A0 =A0 =A0 error =3D mxt_get_object_table(data);
>> =A0 =A0 =A0 if (error)
>> @@ -971,9 +974,6 @@ static ssize_t mxt_update_fw_store(struct device=
 *dev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Wait for reset */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 msleep(MXT_FWRESET_TIME);
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 kfree(data->object_table);
>> - =A0 =A0 =A0 =A0 =A0 =A0 data->object_table =3D NULL;
>> -
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mxt_initialize(data);
>> =A0 =A0 =A0 }
>>
>> --
>> 1.7.7.3
>>
>
> Thanks,
> Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
