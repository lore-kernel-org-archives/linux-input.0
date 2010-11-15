From: "Kim, HeungJun" <riverful.kim@samsung.com>
Subject: Re: [PATCH 1/3] input: keyboard: MCS5080: support suspend/resume.
Date: Mon, 15 Nov 2010 17:21:10 +0900
Message-ID: <4CE0ED76.2010009@samsung.com>
References: <4CE0B7B1.6060404@samsung.com>
 <0680EC522D0CC943BC586913CF3768C003FF834855@dbde02.ent.ti.com>
Reply-To: riverful.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:26560 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757624Ab0KOIVM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Nov 2010 03:21:12 -0500
Received: from epmmp2 (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LBX00KWT37AKUB0@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Mon, 15 Nov 2010 17:21:10 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LBX008Z237AAC@mmp2.samsung.com> for
 linux-input@vger.kernel.org; Mon, 15 Nov 2010 17:21:10 +0900 (KST)
In-reply-to: <0680EC522D0CC943BC586913CF3768C003FF834855@dbde02.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>

Hi shubhrajyoti,


2010-11-15 =BF=C0=C8=C4 2:43, Datta, Shubhrajyoti =BE=B4 =B1=DB:
> Hi Kim,
>=20
>> -----Original Message-----
>> From: linux-input-owner@vger.kernel.org [mailto:linux-input-
>> owner@vger.kernel.org] On Behalf Of Kim, HeungJun
>> Sent: Monday, November 15, 2010 10:02 AM
>> To: linux-input@vger.kernel.org; dmitry.torokhov@gmail.com
>> Cc: kyungmin.park@samsung.com
>> Subject: [PATCH 1/3] input: keyboard: MCS5080: support suspend/resum=
e.
>>
>> This patch supports suspend/resume functions for mcs5080 touchkey
>> driver.
>>
>> Signed-off-by: Heungjun Kim <riverful.kim@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  drivers/input/keyboard/mcs_touchkey.c |   41
>> +++++++++++++++++++++++++++++++++
>>  include/linux/i2c/mcs.h               |    1 +
>>  2 files changed, 42 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/input/keyboard/mcs_touchkey.c
>> b/drivers/input/keyboard/mcs_touchkey.c
>> index 63b849d..06385f5 100644
>> --- a/drivers/input/keyboard/mcs_touchkey.c
>> +++ b/drivers/input/keyboard/mcs_touchkey.c
>> @@ -45,6 +45,8 @@ struct mcs_touchkey_chip {
>>  };
>>
>>  struct mcs_touchkey_data {
>> +       void (*poweron)(int);
> Could you explain what it does?
The MCS5080 chip has enable or poweron key, or may be LDO pins.
So, it used in the platformdata, like above cfg_pin().

There is one reason about using poweron().
The MCS5080 chip must be re-initialize after resume().
If it's not used power off/on method and use only disable/enable irq,
it happened that it dosen't issued interrupt.
This is chip-level issue.

So, I think that it's the very simplest method to support poweron() fun=
ction
to machine or platform data.=20

>=20
>> +
>>         struct i2c_client *client;
>>         struct input_dev *input_dev;
>>         struct mcs_touchkey_chip chip;
>> @@ -168,6 +170,8 @@ static int __devinit mcs_touchkey_probe(struct
>> i2c_client *client,
>>
>>         if (pdata->cfg_pin)
>>                 pdata->cfg_pin();
>> +       if (pdata->poweron)
>> +               data->poweron =3D pdata->poweron;
> Where is it called the first time?
Actually, in the suspend(), this function called the first time.
but, the actual power-up() sequence is possible in the cfg_pin(), too.
So, I use this method.

>=20
>>
>>         error =3D request_threaded_irq(client->irq, NULL,
>> mcs_touchkey_interrupt,
>>                         IRQF_TRIGGER_FALLING, client->dev.driver->na=
me,
>> data);
>> @@ -202,6 +206,41 @@ static int __devexit mcs_touchkey_remove(struct
>> i2c_client *client)
>>         return 0;
>>  }
>>
>> +#ifdef CONFIG_PM
>> +static int mcs_touchkey_suspend(struct i2c_client *client, pm_messa=
ge_t
>> mesg)
>> +{
>> +       struct mcs_touchkey_data *data =3D i2c_get_clientdata(client=
);
>> +
>> +       /* Disable the work */
>> +       disable_irq(client->irq);
>> +
>> +       /* Don't I2C operation since we don't know I2C bus is dead a=
lready
>> */
>> +
>> +       /* Finally turn off the power */
>> +       if (data->poweron)
>> +               data->poweron(0);
>> +
>> +       return 0;
>> +}
>> +
>> +static int mcs_touchkey_resume(struct i2c_client *client)
>> +{
>> +       struct mcs_touchkey_data *data =3D i2c_get_clientdata(client=
);
>> +
>> +       /* Enable the device first */
>> +       if (data->poweron)
>> +               data->poweron(1);
>> +
>> +       /* Enable irq again */
>> +       enable_irq(client->irq);
>> +
>> +       return 0;
>> +}
>> +#else
>> +#define mcs_touchkey_suspend   NULL
>> +#define mcs_touchkey_resume    NULL
>> +#endif
>> +
>>  static const struct i2c_device_id mcs_touchkey_id[] =3D {
>>         { "mcs5000_touchkey", MCS5000_TOUCHKEY },
>>         { "mcs5080_touchkey", MCS5080_TOUCHKEY },
>> @@ -216,6 +255,8 @@ static struct i2c_driver mcs_touchkey_driver =3D=
 {
>>         },
>>         .probe          =3D mcs_touchkey_probe,
>>         .remove         =3D __devexit_p(mcs_touchkey_remove),
>> +       .suspend        =3D mcs_touchkey_suspend,
>> +       .resume         =3D mcs_touchkey_resume,
>>         .id_table       =3D mcs_touchkey_id,
>>  };
>>
>> diff --git a/include/linux/i2c/mcs.h b/include/linux/i2c/mcs.h
>> index 725ae7c..c4a3869 100644
>> --- a/include/linux/i2c/mcs.h
>> +++ b/include/linux/i2c/mcs.h
>> @@ -18,6 +18,7 @@
>>  #define MCS_KEY_CODE(v)                ((v) & 0xffff)
>>
>>  struct mcs_platform_data {
>> +       void (*poweron)(int);
>>         void (*cfg_pin)(void);
>>
>>         /* touchscreen */
>> --
>> 1.7.0.4
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-inpu=
t" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks.
If u any ideas, let me know.

Regards,
Heundjun Kim
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
