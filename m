From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: Re: [PATCH] Input: Avoid kernel panic during device unregistration
Date: Mon, 29 Dec 2014 23:08:08 +0530
Message-ID: <CADYu30-bi60RXx86_PZiydxaz8aSdaytpj_jAeugZTkDPe_Qjw@mail.gmail.com>
References: <1419790325-4004-1-git-send-email-aniroop.mathur@gmail.com>
	<20141228202149.GA21544@dtor-ws>
	<CADYu3085LoexcdGsbFY7xoii3SqrAu96b9976ZVhr0WL8dLixw@mail.gmail.com>
	<20141229172324.GA9565@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:54418 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202AbaL2RiJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Dec 2014 12:38:09 -0500
Received: by mail-la0-f45.google.com with SMTP id gq15so11507535lab.4
        for <linux-input@vger.kernel.org>; Mon, 29 Dec 2014 09:38:08 -0800 (PST)
In-Reply-To: <20141229172324.GA9565@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, a.mathur@samsung.com

Hello Mr. Torokhov,

On Mon, Dec 29, 2014 at 10:53 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Aniroop,
>
> On Mon, Dec 29, 2014 at 10:11:54PM +0530, Aniroop Mathur wrote:
>> Hello Mr. Torokhov,
>>
>> On Mon, Dec 29, 2014 at 1:51 AM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> > Hi Aniroop,
>> >
>> > On Sun, Dec 28, 2014 at 11:42:05PM +0530, Aniroop Mathur wrote:
>> >> This patch adds null check before actually unregistering the input device
>> >> to avoid null pointer exception which leads to kernel panic.
>> >>
>> >> So now, input device drivers won't have to worry about or add null case
>> >> condition before calling input_unregister_device() in shutdown and
>> >> remove functions.
>> >
>> > input_unregister_device() should be called only if
>> > input_register_device() succeeded, which it would not with input device
>> > being NULL.
>> >
>> > Unlike input_free_device() which does handle NULL argument, similar to
>> > many other "free" APIs I do not believe that input_unregister_device
>> > should be handling such cases.
>> >
>>
>> Right !!
>> Actually, quite recently I worked on one input device hub driver in which many
>> devices are registered in probe and in shutdown and remove functions,
>> they are unregistered.
>>
>> probe() {
>> ...
>> ...
>> accel_dev = input_register_device();
>> gyro_dev = input_register_device();
>> mag_dev = input_register_device();
>> prox_dev = input_register_device();
>> light_dev = input_register_device();
>> baro_dev = input_register_device();
>> more ...
>> ...
>> }
>>
>> shutdown() {
>> ...
>> ...
>> if (accel_dev)
>> input_unregister_device(accel_dev);
>> if (gyro_dev)
>> input_unregister_device(gyro_dev);
>> if (mag_dev)
>> input_unregister_device(mag_dev);
>> if (prox_dev )
>> input_unregister_device(prox_dev);
>> if (light_dev)
>> input_unregister_device(light_dev);
>> if (baro_dev)
>> input_unregister_device(baro_dev);
>> more ...
>> ...
>> }
>>
>> In probe, few registrations may fail and so it is freed in probe itself.
>
> Why would they fail? Is it because the hardware is not there or other
> errors?
>

They never fail as such.
But still handling error chances for very rare cases like memory not
avaliable, etc.

>> And in driver shutdown function, we need to unregister or free devices
>> registered in probe.
>> So adding null check before every input_device_unregister() looks not
>> quite good.
>> Similar thing for remove function in driver.
>> The best solution I thought is to add null check in input subsystem
>> unregister function itself.
>> Umm... Is there any better way possible ?
>
> I would look into using devm_* infrastructure instead and simply not
> allocate input devices for any sub-devices of your "hub" that are not
> present and simply aborting the probe() for other errors. Then you
> would not need pretty much any code in your remove() method.
>
> If not devm_ then you can consider creating array of struct input_dev *
> and iterating it in error paths and remove() instead of long open-coded
> sequence of unregistering. Then a single NULL check won't be seen as
> such an issue.
>

Seems better approach. I'll try to follow the same.

Thanks,
Aniroop


> Thanks.
>
> --
> Dmitry
