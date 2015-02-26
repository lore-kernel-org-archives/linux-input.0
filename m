From: Stefan Sauer <ensonic@google.com>
Subject: Re: [PATCH] Input: mma8450 - convert to using managed resources
Date: Thu, 26 Feb 2015 13:12:01 +0100
Message-ID: <CAGX7z0whP6y4cnve+pX2=2oCTnFZkK+aNByPBUFhO7Z56zz5RA@mail.gmail.com>
References: <20150226014818.GA2469@dtor-ws>
	<CAGX7z0w4dES=DsSJ-7sqYTjkeWZhGZVCN_mJ=Y+cLU74g+e9=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:46422 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753423AbbBZMMC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Feb 2015 07:12:02 -0500
Received: by mail-qg0-f52.google.com with SMTP id h3so8049244qgf.11
        for <linux-input@vger.kernel.org>; Thu, 26 Feb 2015 04:12:01 -0800 (PST)
In-Reply-To: <CAGX7z0w4dES=DsSJ-7sqYTjkeWZhGZVCN_mJ=Y+cLU74g+e9=w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Thanks, tested it and confirming it works them same.

On Thu, Feb 26, 2015 at 1:11 PM, Stefan Sauer <ensonic@google.com> wrot=
e:
> Thanks, tested it and confirming it works them same.
>
> On Thu, Feb 26, 2015 at 2:48 AM, Dmitry Torokhov <dmitry.torokhov@gma=
il.com>
> wrote:
>>
>> This simplifies error handling and device removal code. Also let's
>> get rid of setting driver's owner since i2c core does it for us.
>>
>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> ---
>>
>> Note that the following removal was intentional as
>> devm_input_allocate_polled_device() does this for us:
>>
>> -       idev->input->dev.parent =3D &c->dev;
>>
>>
>>  drivers/input/misc/mma8450.c | 35 ++++++++-------------------------=
--
>>  1 file changed, 8 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/input/misc/mma8450.c b/drivers/input/misc/mma84=
50.c
>> index 9822877..19c7357 100644
>> --- a/drivers/input/misc/mma8450.c
>> +++ b/drivers/input/misc/mma8450.c
>> @@ -174,12 +174,13 @@ static int mma8450_probe(struct i2c_client *c,
>>         struct mma8450 *m;
>>         int err;
>>
>> -       m =3D kzalloc(sizeof(struct mma8450), GFP_KERNEL);
>> -       idev =3D input_allocate_polled_device();
>> -       if (!m || !idev) {
>> -               err =3D -ENOMEM;
>> -               goto err_free_mem;
>> -       }
>> +       m =3D devm_kzalloc(&c->dev, sizeof(*m), GFP_KERNEL);
>> +       if (!m)
>> +               return -ENOMEM;
>> +
>> +       idev =3D devm_input_allocate_polled_device(&c->dev);
>> +       if (!idev)
>> +               return -ENOMEM;
>>
>>         m->client =3D c;
>>         m->idev =3D idev;
>> @@ -187,7 +188,6 @@ static int mma8450_probe(struct i2c_client *c,
>>         idev->private           =3D m;
>>         idev->input->name       =3D MMA8450_DRV_NAME;
>>         idev->input->id.bustype =3D BUS_I2C;
>> -       idev->input->dev.parent =3D &c->dev;
>>         idev->poll              =3D mma8450_poll;
>>         idev->poll_interval     =3D POLL_INTERVAL;
>>         idev->poll_interval_max =3D POLL_INTERVAL_MAX;
>> @@ -202,29 +202,12 @@ static int mma8450_probe(struct i2c_client *c,
>>         err =3D input_register_polled_device(idev);
>>         if (err) {
>>                 dev_err(&c->dev, "failed to register polled input
>> device\n");
>> -               goto err_free_mem;
>> +               return err;
>>         }
>>
>>         i2c_set_clientdata(c, m);
>>
>>         return 0;
>> -
>> -err_free_mem:
>> -       input_free_polled_device(idev);
>> -       kfree(m);
>> -       return err;
>> -}
>> -
>> -static int mma8450_remove(struct i2c_client *c)
>> -{
>> -       struct mma8450 *m =3D i2c_get_clientdata(c);
>> -       struct input_polled_dev *idev =3D m->idev;
>> -
>> -       input_unregister_polled_device(idev);
>> -       input_free_polled_device(idev);
>> -       kfree(m);
>> -
>> -       return 0;
>>  }
>>
>>  static const struct i2c_device_id mma8450_id[] =3D {
>> @@ -242,11 +225,9 @@ MODULE_DEVICE_TABLE(of, mma8450_dt_ids);
>>  static struct i2c_driver mma8450_driver =3D {
>>         .driver =3D {
>>                 .name   =3D MMA8450_DRV_NAME,
>> -               .owner  =3D THIS_MODULE,
>>                 .of_match_table =3D mma8450_dt_ids,
>>         },
>>         .probe          =3D mma8450_probe,
>> -       .remove         =3D mma8450_remove,
>>         .id_table       =3D mma8450_id,
>>  };
>>
>> --
>> 2.2.0.rc0.207.ga3a616c
>>
>>
>> --
>> Dmitry
>
>
>
>
> --
> Stefan Sauer | Software Engineer | ensonic@google.com
>
> Google Germany GmbH | Maximilianstrasse 11-15 | 80539 M=C3=BCnchen | =
Germany
> Registergericht und -nummer: Hamburg, HRB 86891
> Sitz der Gesellschaft: Hamburg
> Gesch=C3=A4ftsf=C3=BChrer: Graham Law, Christine Elizabeth Flores



--=20
Stefan Sauer | Software Engineer | ensonic@google.com

Google Germany GmbH | Maximilianstrasse 11-15 | 80539 M=C3=BCnchen | Ge=
rmany
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Graham Law, Christine Elizabeth Flores
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
