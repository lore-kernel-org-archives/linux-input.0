From: Tatsunosuke Tobita <junkpainting@gmail.com>
Subject: Re: [PATCH] Input: Add a driver to support for Wacom I2C Stylus Device
Date: Tue, 20 Dec 2011 15:32:46 +0900
Message-ID: <CA+MtpR27gCd9fCPZT_C9nZhFkDrEVNuhc9W=5vzAe5r2+feuJQ@mail.gmail.com>
References: <1324360008-32641-1-git-send-email-tobita.tatsunosuke@wacom.co.jp>
	<4EF02590.5020409@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52261 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362Ab1LTGcs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Dec 2011 01:32:48 -0500
Received: by eaaj10 with SMTP id j10so5362311eaa.19
        for <linux-input@vger.kernel.org>; Mon, 19 Dec 2011 22:32:46 -0800 (PST)
In-Reply-To: <4EF02590.5020409@cn.fujitsu.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: gaowanlong@cn.fujitsu.com
Cc: linux-input@vger.kernel.org

Hi Wanlong,

Thank you for your review.
But, I'm not sure about driver-core-next; is this in linux-input somewh=
ere?
or should I update my git branch ?

Also, I'm checking with your commit which was made yesterday and
it looks like  "module_i2c_driver" converges both init and exit into
one statement;
is my understanding correct?

If my questions above are clear, I'll be able to correctly rewrite the =
code.
So, please help to answer.

Thanks,

Tats

On Tue, Dec 20, 2011 at 3:05 PM, Wanlong Gao <gaowanlong@cn.fujitsu.com=
> wrote:
> On 12/20/2011 01:46 PM, Tatsunosuke Tobita wrote:
>
>> From: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>
>>
>> This driver supports for Wacom Stylus Device with I2C interface.
>>
>> Signed-off-by: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>
>> ---
>> =A0drivers/input/touchscreen/wacom_i2c.c | =A0250 ++++++++++++++++++=
+++++++++++++++
>> =A0drivers/input/touchscreen/wacom_i2c.h | =A0 55 +++++++
>> =A02 files changed, 305 insertions(+), 0 deletions(-)
>> =A0create mode 100644 drivers/input/touchscreen/wacom_i2c.c
>> =A0create mode 100644 drivers/input/touchscreen/wacom_i2c.h
>>
>> diff --git a/drivers/input/touchscreen/wacom_i2c.c b/drivers/input/t=
ouchscreen/wacom_i2c.c
>> new file mode 100644
>> index 0000000..157bcc5
>> --- /dev/null
>> +++ b/drivers/input/touchscreen/wacom_i2c.c
>
>> +
>> +static struct i2c_driver wacom_i2c_driver =3D {
>> + =A0 =A0 .driver =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "wacom_i2c",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pm =3D &wacom_i2c_pm,
>> + =A0 =A0 },
>> +
>> + =A0 =A0 .probe =3D wacom_i2c_probe,
>> + =A0 =A0 .remove =3D __devexit_p(wacom_i2c_remove),
>> + =A0 =A0 .id_table =3D wacom_i2c_id,
>> +};
>> +
>> +static int __init wacom_i2c_init(void)
>> +{
>> + =A0 =A0 return i2c_add_driver(&wacom_i2c_driver);
>> +}
>> +
>> +static void __exit wacom_i2c_exit(void)
>> +{
>> + =A0 =A0 i2c_del_driver(&wacom_i2c_driver);
>> +}
>> +
>> +module_init(wacom_i2c_init);
>> +module_exit(wacom_i2c_exit);
>
>
> You can use module_i2c_driver(wacom_i2c_driver) instead of module_ini=
t{exit},
> it has been queued to driver-core-next already.
>
>
> Thanks
> -Wanlong Gao
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
