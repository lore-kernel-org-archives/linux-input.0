From: "Kim, HeungJun" <riverful.kim@samsung.com>
Subject: Re: [PATCH 1/3] input: keyboard: MCS5080: support suspend/resume.
Date: Thu, 18 Nov 2010 11:54:19 +0900
Message-ID: <4CE4955B.3030607@samsung.com>
References: <4CE0B7B1.6060404@samsung.com>
 <20101115083235.GA11594@core.coreip.homeip.net>
Reply-To: riverful.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:8537 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850Ab0KRCyV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Nov 2010 21:54:21 -0500
Received: from epmmp1 (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LC200H1R82JCME0@mailout3.samsung.com> for
 linux-input@vger.kernel.org; Thu, 18 Nov 2010 11:54:19 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LC2001ZL82J3D@mmp1.samsung.com> for
 linux-input@vger.kernel.org; Thu, 18 Nov 2010 11:54:19 +0900 (KST)
In-reply-to: <20101115083235.GA11594@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Dmitry,

I'll fix the following points, and re-send patches, soon.
And, I gonna send the led-trigger patch, later.
Actually, the led-blink command & method is changed according to touchk=
ey F/W, as you know.
The cause of my sending led-patch is that I think it's the just basic f=
unction.
But, If the touchkey-drv use led-trigger framework, the driver code is =
heavy, I guess.

After I consider that deeply, I'll re-send patch.=20

Thansk to review.

2010-11-15 =EC=98=A4=ED=9B=84 5:32, Dmitry Torokhov =EC=93=B4 =EA=B8=80=
:
> Hi Kim,
>=20
> On Mon, Nov 15, 2010 at 01:31:45PM +0900, Kim, HeungJun wrote:
>> This patch supports suspend/resume functions for mcs5080 touchkey
>> driver.
>>
>> Signed-off-by: Heungjun Kim <riverful.kim@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  drivers/input/keyboard/mcs_touchkey.c |   41 ++++++++++++++++++++++=
+++++++++++
>>  include/linux/i2c/mcs.h               |    1 +
>>  2 files changed, 42 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/input/keyboard/mcs_touchkey.c b/drivers/input/k=
eyboard/mcs_touchkey.c
>> index 63b849d..06385f5 100644
>> --- a/drivers/input/keyboard/mcs_touchkey.c
>> +++ b/drivers/input/keyboard/mcs_touchkey.c
>> @@ -45,6 +45,8 @@ struct mcs_touchkey_chip {
>>  };
>>
>>  struct mcs_touchkey_data {
>> +       void (*poweron)(int);
>=20
> int (*poweron)(bool);
>=20
> The method must be able to signal errors.
Ok, I'll fix this.

>=20
>> +
>>         struct i2c_client *client;
>>         struct input_dev *input_dev;
>>         struct mcs_touchkey_chip chip;
>> @@ -168,6 +170,8 @@ static int __devinit mcs_touchkey_probe(struct i=
2c_client *client,
>>
>>         if (pdata->cfg_pin)
>>                 pdata->cfg_pin();
>> +       if (pdata->poweron)
>> +               data->poweron =3D pdata->poweron;
>>
>>         error =3D request_threaded_irq(client->irq, NULL, mcs_touchk=
ey_interrupt,
>>                         IRQF_TRIGGER_FALLING, client->dev.driver->na=
me, data);
>> @@ -202,6 +206,41 @@ static int __devexit mcs_touchkey_remove(struct=
 i2c_client *client)
>>         return 0;
>>  }
>>
>> +#ifdef CONFIG_PM
>> +static int mcs_touchkey_suspend(struct i2c_client *client, pm_messa=
ge_t mesg)
>=20
> Newer code should use dev_pm_ops please.
I got it. I'll adapt new runtime-pm framework.

> `
>> +{
>> +       struct mcs_touchkey_data *data =3D i2c_get_clientdata(client=
);
>> +
>> +       /* Disable the work */
>> +       disable_irq(client->irq);
>> +
>> +       /* Don't I2C operation since we don't know I2C bus is dead a=
lready */
>=20
> ? I am not quite sure what you are trying to say here...
It's kind of defensive(?) code for sure.
If don't use this code and the I2C operation is crashed once,
after I2C operation is crashed, too.
It happened very frequently in the MCS5080 chip.
But fortunatly, It affects just own bus, not any other one.

>=20
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
>=20
> Shouldn't you call poweron() at driver bind and unbind time (if you d=
o not want to
> supply open() and close() methods which wold be the best option)?
I got it. I'll locate poweron() function at the bind & unbind time.

>=20
> Thanks.
>=20

Regards,
HeundJun Kim
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
