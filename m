From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: Re: [PATCH] Input: Avoid kernel panic during device unregistration
Date: Mon, 29 Dec 2014 22:11:54 +0530
Message-ID: <CADYu3085LoexcdGsbFY7xoii3SqrAu96b9976ZVhr0WL8dLixw@mail.gmail.com>
References: <1419790325-4004-1-git-send-email-aniroop.mathur@gmail.com>
	<20141228202149.GA21544@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:54320 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbaL2Qlz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Dec 2014 11:41:55 -0500
Received: by mail-lb0-f169.google.com with SMTP id p9so11375881lbv.28
        for <linux-input@vger.kernel.org>; Mon, 29 Dec 2014 08:41:54 -0800 (PST)
In-Reply-To: <20141228202149.GA21544@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, a.mathur@samsung.com

Hello Mr. Torokhov,

On Mon, Dec 29, 2014 at 1:51 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Aniroop,
>
> On Sun, Dec 28, 2014 at 11:42:05PM +0530, Aniroop Mathur wrote:
>> This patch adds null check before actually unregistering the input device
>> to avoid null pointer exception which leads to kernel panic.
>>
>> So now, input device drivers won't have to worry about or add null case
>> condition before calling input_unregister_device() in shutdown and
>> remove functions.
>
> input_unregister_device() should be called only if
> input_register_device() succeeded, which it would not with input device
> being NULL.
>
> Unlike input_free_device() which does handle NULL argument, similar to
> many other "free" APIs I do not believe that input_unregister_device
> should be handling such cases.
>

Right !!
Actually, quite recently I worked on one input device hub driver in which many
devices are registered in probe and in shutdown and remove functions,
they are unregistered.

probe() {
...
...
accel_dev = input_register_device();
gyro_dev = input_register_device();
mag_dev = input_register_device();
prox_dev = input_register_device();
light_dev = input_register_device();
baro_dev = input_register_device();
more ...
...
}

shutdown() {
...
...
if (accel_dev)
input_unregister_device(accel_dev);
if (gyro_dev)
input_unregister_device(gyro_dev);
if (mag_dev)
input_unregister_device(mag_dev);
if (prox_dev )
input_unregister_device(prox_dev);
if (light_dev)
input_unregister_device(light_dev);
if (baro_dev)
input_unregister_device(baro_dev);
more ...
...
}

In probe, few registrations may fail and so it is freed in probe itself.
And in driver shutdown function, we need to unregister or free devices
registered in probe.
So adding null check before every input_device_unregister() looks not
quite good.
Similar thing for remove function in driver.
The best solution I thought is to add null check in input subsystem
unregister function itself.
Umm... Is there any better way possible ?


Regards,
Aniroop

>>
>> Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
>> ---
>>  drivers/input/input.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/input/input.c b/drivers/input/input.c
>> index 01fe49e..575219d 100644
>> --- a/drivers/input/input.c
>> +++ b/drivers/input/input.c
>> @@ -2170,6 +2170,9 @@ EXPORT_SYMBOL(input_register_device);
>>   */
>>  void input_unregister_device(struct input_dev *dev)
>>  {
>> +     if (!dev)
>> +             return;
>> +
>>       if (dev->devres_managed) {
>>               WARN_ON(devres_destroy(dev->dev.parent,
>>                                       devm_input_device_unregister,
>> --
>> 1.9.1
>>
>
> Thanks.
>
> --
> Dmitry
