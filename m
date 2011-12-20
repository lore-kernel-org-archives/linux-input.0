From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [PATCH] Input: Add a driver to support for Wacom I2C Stylus Device
Date: Tue, 20 Dec 2011 15:36:57 +0800
Message-ID: <4EF03B19.2020208@cn.fujitsu.com>
References: <1324360008-32641-1-git-send-email-tobita.tatsunosuke@wacom.co.jp> <4EF02590.5020409@cn.fujitsu.com> <CA+MtpR27gCd9fCPZT_C9nZhFkDrEVNuhc9W=5vzAe5r2+feuJQ@mail.gmail.com>
Reply-To: gaowanlong@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:52989 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752950Ab1LTHiG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Dec 2011 02:38:06 -0500
In-Reply-To: <CA+MtpR27gCd9fCPZT_C9nZhFkDrEVNuhc9W=5vzAe5r2+feuJQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tatsunosuke Tobita <junkpainting@gmail.com>
Cc: linux-input@vger.kernel.org, dtor@mail.ru

On 12/20/2011 02:32 PM, Tatsunosuke Tobita wrote:

> Hi Wanlong,
> 
> Thank you for your review.
> But, I'm not sure about driver-core-next; is this in linux-input somewhere?
> or should I update my git branch ?


No, it means Greg's driver-core tree. He queued the changes to next, and will
be merged to linus' tree through next merge window, and input-next is the same, too.

You can do like this:
git remote add driver-core git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
git remote update
git checkout -b driver-core-next driver-core/driver-core-next

Then you can see these module_*_driver changes in this branch,
but, you are doing input drivers, so, you must cook patches against Dmitry's input-next tree,
not Greg's driver-core-next branch.

I hope you can understand what I'm trying to say.

> 
> Also, I'm checking with your commit which was made yesterday and
> it looks like  "module_i2c_driver" converges both init and exit into
> one statement;
> is my understanding correct?


Yeah, you are right.

> 
> If my questions above are clear, I'll be able to correctly rewrite the code.


IMO, please do.

But, Dmitry, what do you think?


Thanks
-Wanlong Gao

> So, please help to answer.
> 
> Thanks,
> 
> Tats
> 
> On Tue, Dec 20, 2011 at 3:05 PM, Wanlong Gao <gaowanlong@cn.fujitsu.com> wrote:
>> On 12/20/2011 01:46 PM, Tatsunosuke Tobita wrote:
>>
>>> From: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>
>>>
>>> This driver supports for Wacom Stylus Device with I2C interface.
>>>
>>> Signed-off-by: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>
>>> ---
>>>  drivers/input/touchscreen/wacom_i2c.c |  250 +++++++++++++++++++++++++++++++++
>>>  drivers/input/touchscreen/wacom_i2c.h |   55 +++++++
>>>  2 files changed, 305 insertions(+), 0 deletions(-)
>>>  create mode 100644 drivers/input/touchscreen/wacom_i2c.c
>>>  create mode 100644 drivers/input/touchscreen/wacom_i2c.h
>>>
>>> diff --git a/drivers/input/touchscreen/wacom_i2c.c b/drivers/input/touchscreen/wacom_i2c.c
>>> new file mode 100644
>>> index 0000000..157bcc5
>>> --- /dev/null
>>> +++ b/drivers/input/touchscreen/wacom_i2c.c
>>
>>> +
>>> +static struct i2c_driver wacom_i2c_driver = {
>>> +     .driver = {
>>> +             .name = "wacom_i2c",
>>> +             .owner = THIS_MODULE,
>>> +             .pm = &wacom_i2c_pm,
>>> +     },
>>> +
>>> +     .probe = wacom_i2c_probe,
>>> +     .remove = __devexit_p(wacom_i2c_remove),
>>> +     .id_table = wacom_i2c_id,
>>> +};
>>> +
>>> +static int __init wacom_i2c_init(void)
>>> +{
>>> +     return i2c_add_driver(&wacom_i2c_driver);
>>> +}
>>> +
>>> +static void __exit wacom_i2c_exit(void)
>>> +{
>>> +     i2c_del_driver(&wacom_i2c_driver);
>>> +}
>>> +
>>> +module_init(wacom_i2c_init);
>>> +module_exit(wacom_i2c_exit);
>>
>>
>> You can use module_i2c_driver(wacom_i2c_driver) instead of module_init{exit},
>> it has been queued to driver-core-next already.
>>
>>
>> Thanks
>> -Wanlong Gao
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


