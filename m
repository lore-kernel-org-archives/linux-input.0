From: Tatsunosuke Tobita <junkpainting@gmail.com>
Subject: Re: [PATCH] Input: Add a driver to support for Wacom I2C Stylus Device
Date: Tue, 20 Dec 2011 06:28:18 -0800
Message-ID: <CA+MtpR0X4pa2D5oLM6-AU_u3CRb6RRZ+s-X=Zf4P9qqoNi75hw@mail.gmail.com>
References: <1324360008-32641-1-git-send-email-tobita.tatsunosuke@wacom.co.jp>
	<4EF02590.5020409@cn.fujitsu.com>
	<CA+MtpR27gCd9fCPZT_C9nZhFkDrEVNuhc9W=5vzAe5r2+feuJQ@mail.gmail.com>
	<4EF03B19.2020208@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33719 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585Ab1LTO2T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Dec 2011 09:28:19 -0500
Received: by eaad14 with SMTP id d14so333723eaa.19
        for <linux-input@vger.kernel.org>; Tue, 20 Dec 2011 06:28:18 -0800 (PST)
In-Reply-To: <4EF03B19.2020208@cn.fujitsu.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: gaowanlong@cn.fujitsu.com
Cc: linux-input@vger.kernel.org, dtor@mail.ru

Hi Wanlong

Thank you for your kind help and explanation of the git branch.

>I hope you can understand what I'm trying to say.
I guess I should wait for the next updated and merged input-next :)

>Yeah, you are right.
OK, I will work on replacing my init and exit soon or later and update
another patch set.

BR,

Tats

On Mon, Dec 19, 2011 at 11:36 PM, Wanlong Gao <gaowanlong@cn.fujitsu.co=
m> wrote:
> On 12/20/2011 02:32 PM, Tatsunosuke Tobita wrote:
>
>> Hi Wanlong,
>>
>> Thank you for your review.
>> But, I'm not sure about driver-core-next; is this in linux-input som=
ewhere?
>> or should I update my git branch ?
>
>
> No, it means Greg's driver-core tree. He queued the changes to next, =
and will
> be merged to linus' tree through next merge window, and input-next is=
 the same, too.
>
> You can do like this:
> git remote add driver-core git://git.kernel.org/pub/scm/linux/kernel/=
git/gregkh/driver-core.git
> git remote update
> git checkout -b driver-core-next driver-core/driver-core-next
>
> Then you can see these module_*_driver changes in this branch,
> but, you are doing input drivers, so, you must cook patches against D=
mitry's input-next tree,
> not Greg's driver-core-next branch.
>
> I hope you can understand what I'm trying to say.
>
>>
>> Also, I'm checking with your commit which was made yesterday and
>> it looks like =A0"module_i2c_driver" converges both init and exit in=
to
>> one statement;
>> is my understanding correct?
>
>
> Yeah, you are right.
>
>>
>> If my questions above are clear, I'll be able to correctly rewrite t=
he code.
>
>
> IMO, please do.
>
> But, Dmitry, what do you think?
>
>
> Thanks
> -Wanlong Gao
>
>> So, please help to answer.
>>
>> Thanks,
>>
>> Tats
>>
>> On Tue, Dec 20, 2011 at 3:05 PM, Wanlong Gao <gaowanlong@cn.fujitsu.=
com> wrote:
>>> On 12/20/2011 01:46 PM, Tatsunosuke Tobita wrote:
>>>
>>>> From: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>
>>>>
>>>> This driver supports for Wacom Stylus Device with I2C interface.
>>>>
>>>> Signed-off-by: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>
>>>> ---
>>>> =A0drivers/input/touchscreen/wacom_i2c.c | =A0250 ++++++++++++++++=
+++++++++++++++++
>>>> =A0drivers/input/touchscreen/wacom_i2c.h | =A0 55 +++++++
>>>> =A02 files changed, 305 insertions(+), 0 deletions(-)
>>>> =A0create mode 100644 drivers/input/touchscreen/wacom_i2c.c
>>>> =A0create mode 100644 drivers/input/touchscreen/wacom_i2c.h
>>>>
>>>> diff --git a/drivers/input/touchscreen/wacom_i2c.c b/drivers/input=
/touchscreen/wacom_i2c.c
>>>> new file mode 100644
>>>> index 0000000..157bcc5
>>>> --- /dev/null
>>>> +++ b/drivers/input/touchscreen/wacom_i2c.c
>>>
>>>> +
>>>> +static struct i2c_driver wacom_i2c_driver =3D {
>>>> + =A0 =A0 .driver =3D {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "wacom_i2c",
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 .pm =3D &wacom_i2c_pm,
>>>> + =A0 =A0 },
>>>> +
>>>> + =A0 =A0 .probe =3D wacom_i2c_probe,
>>>> + =A0 =A0 .remove =3D __devexit_p(wacom_i2c_remove),
>>>> + =A0 =A0 .id_table =3D wacom_i2c_id,
>>>> +};
>>>> +
>>>> +static int __init wacom_i2c_init(void)
>>>> +{
>>>> + =A0 =A0 return i2c_add_driver(&wacom_i2c_driver);
>>>> +}
>>>> +
>>>> +static void __exit wacom_i2c_exit(void)
>>>> +{
>>>> + =A0 =A0 i2c_del_driver(&wacom_i2c_driver);
>>>> +}
>>>> +
>>>> +module_init(wacom_i2c_init);
>>>> +module_exit(wacom_i2c_exit);
>>>
>>>
>>> You can use module_i2c_driver(wacom_i2c_driver) instead of module_i=
nit{exit},
>>> it has been queued to driver-core-next already.
>>>
>>>
>>> Thanks
>>> -Wanlong Gao
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-inpu=
t" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
