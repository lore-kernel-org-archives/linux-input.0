From: paul <paul@crapouillou.net>
Subject: Re: [PATCH] input: goodix: Check the 'data ready' bit before
 reading data
Date: Mon, 27 Apr 2015 11:00:26 +0200
Message-ID: <df24297181d7b061f4c31f7fe118bdf6@mail.crapouillou.net>
References: <1429958890-10366-1-git-send-email-paul@crapouillou.net>
 <1429966457.2525.54.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rev33.vpn.fdn.fr ([80.67.179.33]:33217 "EHLO
	marvin.crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbbD0JAf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Apr 2015 05:00:35 -0400
In-Reply-To: <1429966457.2525.54.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Bastien,

Ok, I will send a V2 with a better commit message then.

-Paul

Le 2015-04-25 14:54, Bastien Nocera a =C3=A9crit=C2=A0:
> On Sat, 2015-04-25 at 12:48 +0200, Paul Cercueil wrote:
>> The MSB of the first byte read via I2C seems to indicate whether the
>> data is valid (or ready) when an interrupt is raised. Previously,
>> this
>> bit was ignored, which resulted in a lot of incorrect detections of
>> "finger removed" events.
>=20
> This seems correct, but the wording doesn't match the language used i=
n
> the Goodix docs that were posted here some time ago[1].
>=20
> I would have written:
> The MSB of the first byte read via I2C at the coordinates address
> indicate whether the data is valid or ready (called "buffer status" i=
n
> the datasheets) when an interrupt is raised. Previously, this bit was
> ignored, which resulted in a lot of incorrect detections of "finger
> removed" events.
>=20
> And for the commit subject:
> input: goodix: Check the 'buffer status' bit before reading data
>=20
> This seems correct otherwise.
>=20
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
>=20
> with the fixed commit message/subject
>=20
> [1]: Linked from the device tree support patch:
> https://patchwork.ozlabs.org/patch/446838/
> Page 16, table c, 0x814E is what we read for coordinates
>=20
>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>> ---
>>  drivers/input/touchscreen/goodix.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>=20
>> diff --git a/drivers/input/touchscreen/goodix.c
>> b/drivers/input/touchscreen/goodix.c
>> index ca19668..9fa6c5f 100644
>> --- a/drivers/input/touchscreen/goodix.c
>> +++ b/drivers/input/touchscreen/goodix.c
>> @@ -98,6 +98,9 @@ static int goodix_ts_read_input_report(struct
>> goodix_ts_data *ts, u8 *data)
>>               return error;
>>       }
>>=20
>> +     if (!(data[0] & 0x80))
>> +             return -EAGAIN;
>> +
>>       touch_num =3D data[0] & 0x0f;
>>       if (touch_num > GOODIX_MAX_CONTACTS)
>>               return -EPROTO;
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
