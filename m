From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 18/20] Input: atmel_mxt_ts - read num messages, then all messages
Date: Wed, 14 Mar 2012 11:13:58 +0800
Message-ID: <CAGS+omAPBSqs9BZQJ4dLYADE=htZdXOZkAne=eD_4GNLmoUv4w@mail.gmail.com>
References: <1331640263-18935-1-git-send-email-djkurtz@chromium.org>
 <1331640263-18935-19-git-send-email-djkurtz@chromium.org> <4F600355.5040605@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36473 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843Ab2CNDOT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Mar 2012 23:14:19 -0400
Received: by iagz16 with SMTP id z16so1681654iag.19
        for <linux-input@vger.kernel.org>; Tue, 13 Mar 2012 20:14:18 -0700 (PDT)
In-Reply-To: <4F600355.5040605@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Iiro Valkonen <iiro.valkonen@atmel.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>

On Wed, Mar 14, 2012 at 10:32 AM, Joonyoung Shim
<jy0922.shim@samsung.com> wrote:
> On 03/13/2012 09:04 PM, Daniel Kurtz wrote:
>>
>> Implement the MXT DMA method of reading messages.
>> On an interrupt, the T44 report always contains the number of messag=
es
>> pending to be read. =A0So, read 1 byte from T44 in 1 i2c transaction=
, then
>> read the N pending messages in a second transaction.
>
>
> My mXT224 chip datasheet hasn't T44 object, is it updated?
> If not, need to consider chips which doesn't have T44 object.

I could consider merging the use of T44 with the older 'check reportid
0xff' method, but would require help verifying the change with
hardware that doesn't have T44.
Does anybody out there have such hardware and is willing to test?

Thanks,
-Daniel

>
>> The end result is a much much faster read time for all pending messa=
ges.
>> Using 400kHz i2c, it is possible to read 10 pending messages (e.g. f=
or 10
>> moving contatcts) in less than 2.8ms, which is well less than the ty=
pical
>> 10-15ms update rate.
>>
>> Note: There is a possible optimization here. =A0The T44 byte is guar=
anteed
>> to always be right before the T5 address. =A0Thus, it should be poss=
ible
>> to always fetch the T44 message count and the first message in a sin=
gle
>> transaction. =A0This would eliminate the overhead of a second comple=
te read
>> transaction for the case where there is only a single pending messag=
e.
>> (This is actually the most common case, for instance with just 1-con=
tact
>> on the device touch surface). This optimization, however, is not don=
e in
>> this patch.
>>
>> Signed-off-by: Daniel Kurtz<djkurtz@chromium.org>
>> ---
>> =A0drivers/input/touchscreen/atmel_mxt_ts.c | =A0 92
>> ++++++++++++++++++++----------
>> =A01 files changed, 61 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c
>> b/drivers/input/touchscreen/atmel_mxt_ts.c
>> index 88a474e..dafc030 100644
>> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
>> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
>> @@ -251,8 +251,10 @@ struct mxt_data {
>> =A0 =A0 =A0 =A0unsigned int max_y;
>>
>> =A0 =A0 =A0 =A0/* Cached parameters from object table */
>> + =A0 =A0 =A0 u16 T5_address;
>> =A0 =A0 =A0 =A0u8 T9_reportid_min;
>> =A0 =A0 =A0 =A0u8 T9_reportid_max;
>> + =A0 =A0 =A0 u16 T44_address;
>> =A0};
>>
>> =A0static bool mxt_object_readable(unsigned int type)
>> @@ -486,21 +488,6 @@ static int mxt_read_object(struct mxt_data *dat=
a,
>> struct mxt_object *object,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0val);
>> =A0}
>>
>> -static int mxt_read_message(struct mxt_data *data,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0str=
uct mxt_message *message)
>> -{
>> - =A0 =A0 =A0 struct mxt_object *object;
>> - =A0 =A0 =A0 u16 reg;
>> -
>> - =A0 =A0 =A0 object =3D mxt_get_object(data, MXT_GEN_MESSAGE_T5);
>> - =A0 =A0 =A0 if (!object)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> -
>> - =A0 =A0 =A0 reg =3D object->start_address;
>> - =A0 =A0 =A0 return mxt_read_reg(data->client, reg, sizeof(struct m=
xt_message),
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 message);
>> -}
>> -
>> =A0static int mxt_write_object(struct mxt_data *data,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 t=
ype, u8 offset, u8 val)
>> =A0{
>> @@ -515,6 +502,19 @@ static int mxt_write_object(struct mxt_data *da=
ta,
>> =A0 =A0 =A0 =A0return mxt_write_reg(data->client, reg + offset, 1,&v=
al);
>> =A0}
>>
>> +static int mxt_read_num_messages(struct mxt_data *data, u8 *count)
>> +{
>> + =A0 =A0 =A0 /* TODO: Optimization: read first message along with m=
essage count
>> */
>> + =A0 =A0 =A0 return mxt_read_reg(data->client, data->T44_address, 1=
, count);
>> +}
>> +
>> +static int mxt_read_messages(struct mxt_data *data, u8 count,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct mxt_=
message *messages)
>> +{
>> + =A0 =A0 =A0 return mxt_read_reg(data->client, data->T5_address,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(struct =
mxt_message) * count, messages);
>> +}
>> +
>> =A0static void mxt_input_touchevent(struct mxt_data *data,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 stru=
ct mxt_message *message)
>> =A0{
>> @@ -575,26 +575,50 @@ static void mxt_input_touchevent(struct mxt_da=
ta
>> *data,
>> =A0 =A0 =A0 =A0input_sync(input_dev);
>> =A0}
>>
>> -static irqreturn_t mxt_interrupt(int irq, void *dev_id)
>> +static int mxt_proc_messages(struct mxt_data *data, u8 count)
>> =A0{
>> - =A0 =A0 =A0 struct mxt_data *data =3D dev_id;
>> - =A0 =A0 =A0 struct mxt_message message;
>> =A0 =A0 =A0 =A0struct device *dev =3D&data->client->dev;
>>
>> + =A0 =A0 =A0 struct mxt_message messages[count], *msg;
>> + =A0 =A0 =A0 int ret;
>>
>> - =A0 =A0 =A0 do {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mxt_read_message(data,&message)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Failed t=
o read message\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto end;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 ret =3D mxt_read_messages(data, count, messages);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Failed to read %u messag=
es (%d).\n", count,
>> ret);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 for (msg =3D messages; msg< =A0&messages[count]; msg++=
) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mxt_dump_message(dev, msg);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (msg->reportid>=3D data->T9_reporti=
d_min&&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg->reportid<=3D data->T9_rep=
ortid_max)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mxt_input_touchevent(d=
ata, msg);
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static int mxt_handle_messages(struct mxt_data *data)
>> +{
>> + =A0 =A0 =A0 struct device *dev =3D&data->client->dev;
>>
>> + =A0 =A0 =A0 int ret;
>> + =A0 =A0 =A0 u8 count;
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (message.reportid>=3D data->T9_repo=
rtid_min&&
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 message.reportid<=3D data->T9_=
reportid_max)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mxt_input_touchevent(d=
ata,&message);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mxt_dump_message(dev,&=
message);
>> - =A0 =A0 =A0 } while (message.reportid !=3D 0xff);
>> + =A0 =A0 =A0 ret =3D mxt_read_num_messages(data,&count);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Failed to read message c=
ount (%d).\n", ret);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 }
>>
>> -end:
>> + =A0 =A0 =A0 if (count> =A00)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D mxt_proc_messages(data, count)=
;
>> +
>> + =A0 =A0 =A0 return ret;
>> +}
>> +
>> +static irqreturn_t mxt_interrupt(int irq, void *dev_id)
>> +{
>> + =A0 =A0 =A0 mxt_handle_messages(dev_id);
>> =A0 =A0 =A0 =A0return IRQ_HANDLED;
>> =A0}
>>
>> @@ -642,7 +666,7 @@ static int mxt_make_highchg(struct mxt_data *dat=
a)
>>
>> =A0 =A0 =A0 =A0/* Read dummy message to make high CHG pin */
>> =A0 =A0 =A0 =A0do {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D mxt_read_message(data,&messa=
ge);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D mxt_read_messages(data, 1,&m=
essage);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (error)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return error;
>> =A0 =A0 =A0 =A0} while (message.reportid !=3D 0xff&& =A0--count);
>>
>> @@ -743,11 +767,17 @@ static int mxt_get_object_table(struct mxt_dat=
a
>> *data)
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Save data for objects used when pr=
ocessing interrupts */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0switch (object->type) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case MXT_GEN_MESSAGE_T5:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->T5_address =3D o=
bject->start_address;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case MXT_TOUCH_MULTI_T9:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->T9_reportid_max=
 =3D object->max_reportid;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->T9_reportid_min=
 =3D data->T9_reportid_max -
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0object->num_report_ids + 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case MXT_SPT_MESSAGECOUNT_T44:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->T44_address =3D =
object->start_address;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0}
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
