From: "Jiejing.Zhang " <kzjeef@gmail.com>
Subject: Re: [PATCH] input: add EETI eGalax I2C capacitive multi touch driver.
Date: Fri, 29 Jul 2011 13:28:14 +0800
Message-ID: <CACrgxGDpQw7bdeJYSZg-hgt-NEwhTdbaTFeAWprr-0Qi0WsAbw@mail.gmail.com>
References: <1311672354-15453-1-git-send-email-jiejing.zhang@freescale.com> <4E2E8D4E.8070803@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:37810 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753758Ab1G2F2f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 29 Jul 2011 01:28:35 -0400
Received: by vxh35 with SMTP id 35so2419366vxh.19
        for <linux-input@vger.kernel.org>; Thu, 28 Jul 2011 22:28:34 -0700 (PDT)
In-Reply-To: <4E2E8D4E.8070803@cn.fujitsu.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: gaowanlong@cn.fujitsu.com
Cc: Zhang Jiejing <jiejing.zhang@freescale.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

Hi Gao,

2011/7/26 Wanlong Gao <gaowanlong@cn.fujitsu.com>
>
> On 07/26/2011 05:25 PM, Zhang Jiejing wrote:
>>
>> this patch adds EETI eGalax serial multi touch controller driver.
>>
>> EETI eGalax serial touch screen controller is a I2C based multiple
>> capacitive touch screen controller, it can supports 5 touch events m=
aximum.
>>
>> Signed-off-by: Zhang Jiejing<jiejing.zhang@freescale.com>
>> ---
>> =A0drivers/input/touchscreen/Kconfig =A0 =A0 | =A0 10 +
>> =A0drivers/input/touchscreen/Makefile =A0 =A0| =A0 =A01 +
>> =A0drivers/input/touchscreen/egalax_ts.c | =A0314 ++++++++++++++++++=
+++++++++++++++
>> =A03 files changed, 325 insertions(+), 0 deletions(-)
>> =A0create mode 100644 drivers/input/touchscreen/egalax_ts.c
>>
>
>> +
>> + =A0 =A0 =A0 if (down) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* since egalax only report one of mul=
ti touch event,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* so we need record pervious event =
with different id
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* and report them.*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 events[id].valid =3D valid;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 events[id].status =3D down;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 events[id].x =3D x;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 events[id].y =3D y;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i< =A0MAX_SUPPORT_POINTS=
; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!events[i].valid)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 contin=
ue;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&client->dev, =
"report id:%d valid:%d x:%d y:%d",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i, val=
id, x, y);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input=
_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0ABS_MT_TRACKING_ID, i);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input=
_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0ABS_MT_TOUCH_MAJOR, 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input=
_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0ABS_MT_POSITION_X, events[i].x);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input=
_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0ABS_MT_POSITION_Y, events[i].y);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_sync(input_de=
v);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&client->dev, "release id:%d\n=
", id);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 events[id].valid =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 events[id].status =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input_dev, ABS_MT_TRA=
CKING_ID, id);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_event(input_dev, EV_ABS, ABS_MT_=
TOUCH_MAJOR, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_sync(input_dev);
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 input_sync(input_dev);
>
> need re-sync here ?

it's not re-sync, input_mt_sync() is different from input_sync(), the
mt_sync is used to notify a multi touch event is finish. but a
input_sync() means a input event is finished.
eg,
one input event may have many multi touch event.
[MT 1, =A0x, y]
[mt sync]
[MT 2, x, y]
[mt sync]
[input sync]
[MT 1, =A0x, y]
[mt sync]
[MT 2, x, y]
[mt sync]
[input sync]
=2E..

>
>> + =A0 =A0 =A0 data->client =3D client;
>> + =A0 =A0 =A0 data->input_dev =3D input_dev;
>> + =A0 =A0 =A0 /* controller may be in sleep, wake it up. */
>> + =A0 =A0 =A0 egalax_wake_up_device(client);
>> + =A0 =A0 =A0 ret =3D egalax_firmware_version(client);
>> + =A0 =A0 =A0 if (ret< =A00) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "egalax_ts: failed to =
read firmware version\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EIO;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_dev;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 input_dev->name =3D "EETI eGalax Touch Screen";
>> + =A0 =A0 =A0 input_dev->phys =3D "I2C",
>> + =A0 =A0 =A0 input_dev->id.bustype =3D BUS_I2C;
>> + =A0 =A0 =A0 input_dev->dev.parent =3D&client->dev;
>> +
>> + =A0 =A0 =A0 __set_bit(EV_ABS, input_dev->evbit);
>> + =A0 =A0 =A0 __set_bit(EV_KEY, input_dev->evbit);
>> + =A0 =A0 =A0 __set_bit(BTN_TOUCH, input_dev->keybit);
>> + =A0 =A0 =A0 __set_bit(ABS_X, input_dev->absbit);
>> + =A0 =A0 =A0 __set_bit(ABS_Y, input_dev->absbit);
>> + =A0 =A0 =A0 input_set_abs_params(input_dev, ABS_X, 0, 32767, 0, 0)=
;
>> + =A0 =A0 =A0 input_set_abs_params(input_dev, ABS_Y, 0, 32767, 0, 0)=
;
>
> make 32767 to macro here ?

This is a=A0constant=A0to the controller,=A0resolution of x, and y.
maybe you want this become a macro, but it's just style things.

you can find lots of example by grep" input_set_abs_params" under
driver/input/touchscreen.

>
> --
> Thanks
> Best Regards
> Wanlong Gao

Thanks.

BR,
Jiejing
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
