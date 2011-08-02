From: "Jiejing.Zhang " <kzjeef@gmail.com>
Subject: Re: [PATCH] input: add EETI eGalax I2C capacitive multi touch driver.
Date: Tue, 2 Aug 2011 16:49:13 +0800
Message-ID: <CACrgxGB9nvLCVqAMNYMHid0r1W1TE82huhy5xKbcjr7kxBut0w@mail.gmail.com>
References: <1311672354-15453-1-git-send-email-jiejing.zhang@freescale.com> <20110801063409.GB32118@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:48047 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418Ab1HBIte convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Aug 2011 04:49:34 -0400
Received: by yia27 with SMTP id 27so3934064yia.19
        for <linux-input@vger.kernel.org>; Tue, 02 Aug 2011 01:49:33 -0700 (PDT)
In-Reply-To: <20110801063409.GB32118@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Zhang Jiejing <jiejing.zhang@freescale.com>, linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

Hi Dmitry,

Thanks for your review.

2011/8/1 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> Hi Zhang,
>
> On Tue, Jul 26, 2011 at 05:25:54PM +0800, Zhang Jiejing wrote:
>> +
>> + =A0 =A0 if (buf[0] =3D=3D REPORT_MODE_SINGLE) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input_dev, ABS_X, x);
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input_dev, ABS_Y, y);
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input_dev, BTN_TOUCH, !!s=
tate);
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_sync(input_dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
>
> In what cases does the device signal REPORT_MODE_SINGLE? When only on=
e
> finger touches the surface? Because we should still be using MT proto=
col
> even if at the moment only one finger touches the surface. And it is
> nice to provide non-MT compatibility data for legacy applications
> regardless of the number of contacts currently active (see
> drivers/input/input-mt.c for helpers).

This report single mode was wroted in Chip's I2C programming manual.
but in fact, at least in my touch panel, the event type(buf[0]) was
REPORT_MODE_MTTOUCH regardless one finger or two finger pressed on
panel.

I add this code is in case someone's panel is configured with
REPORT_MODE_SINGLE.

It was no tested, maybe I should remove this part of code ? what's
your opinion ?

>
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* deal with multiple touch =A0*/
>> + =A0 =A0 valid =3D state & EVENT_VAILD_MASK;
>> + =A0 =A0 id =3D (state & EVENT_ID_MASK) >> EVENT_ID_OFFSET;
>> + =A0 =A0 down =3D state & EVENT_DOWN_UP;
>> +
>> + =A0 =A0 if (!valid || id > MAX_SUPPORT_POINTS) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&client->dev, "point invalid\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (down) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* since egalax only report one of multi t=
ouch event,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* so we need record pervious event with=
 different id
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* and report them.*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 events[id].valid =3D valid;
>> + =A0 =A0 =A0 =A0 =A0 =A0 events[id].status =3D down;
>> + =A0 =A0 =A0 =A0 =A0 =A0 events[id].x =3D x;
>> + =A0 =A0 =A0 =A0 =A0 =A0 events[id].y =3D y;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < MAX_SUPPORT_POINTS; i++)=
 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!events[i].valid)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&client->dev, "rep=
ort id:%d valid:%d x:%d y:%d",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i, valid, =
x, y);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input_dev=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0ABS_MT_TRACKING_ID, i);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input_dev=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0ABS_MT_TOUCH_MAJOR, 1);
>
> This does not provide any information, please drop.
will do.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input_dev=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0ABS_MT_POSITION_X, events[i].x);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input_dev=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0ABS_MT_POSITION_Y, events[i].y);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_sync(input_dev);
>
> It would be much better to use MT-B protocol since the device seems t=
o
> provide proper tracking IDs for the contacts.
I will adjust it to MT-B protocol in next version.
>
>> +
>> + =A0 =A0 __set_bit(EV_ABS, input_dev->evbit);
>> + =A0 =A0 __set_bit(EV_KEY, input_dev->evbit);
>> + =A0 =A0 __set_bit(BTN_TOUCH, input_dev->keybit);
>> + =A0 =A0 __set_bit(ABS_X, input_dev->absbit);
>> + =A0 =A0 __set_bit(ABS_Y, input_dev->absbit);
>> + =A0 =A0 input_set_abs_params(input_dev, ABS_X, 0, 32767, 0, 0);
>> + =A0 =A0 input_set_abs_params(input_dev, ABS_Y, 0, 32767, 0, 0);
>
> You do not set any ABS_MT_* events here so your MT events will be
> suppressed by input core.
ok.
>
>> +
>> +static __devexit int egalax_ts_remove(struct i2c_client *client)
>> +{
>> + =A0 =A0 struct egalax_ts *data =3D i2c_get_clientdata(client);
>> +
>> + =A0 =A0 free_irq(client->irq, data);
>> + =A0 =A0 input_unregister_device(data->input_dev);
>> + =A0 =A0 input_free_device(data->input_dev);
>
> No calls to input_free_device() after calling input_unregister_device=
().
>
ok
> Thanks.
>
> --
> Dmitry
>

Thanks,
Jiejing
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
