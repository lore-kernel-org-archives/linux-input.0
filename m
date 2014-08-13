From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: Re: [Question: Drivers/input/evdev.c] What is the use of write
 function in evdev_fops?
Date: Wed, 13 Aug 2014 23:41:20 +0530
Message-ID: <CADYu30-OBXKQTMD_kAmjfrYoXvO0NkcaPac5kpe1hmbXy473Ww@mail.gmail.com>
References: <CADYu30-WqEUF-BiefJBo9yWUpKKX_zoLZGXsrJSdC46N8w0OVg@mail.gmail.com>
	<20140813170639.GA16164@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:39955 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372AbaHMSLW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Aug 2014 14:11:22 -0400
Received: by mail-la0-f46.google.com with SMTP id b8so96566lan.5
        for <linux-input@vger.kernel.org>; Wed, 13 Aug 2014 11:11:20 -0700 (PDT)
In-Reply-To: <20140813170639.GA16164@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hello Mr. Torokhov :)

On Wed, Aug 13, 2014 at 10:36 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Aniroop,
>
> On Wed, Aug 13, 2014 at 10:16:34PM +0530, Aniroop Mathur wrote:
>> Dear Mr. Torokhov and Linux-Input Community,
>> Greetings of the day !! :)
>>
>> I have not seen some good use of write function in input subsystem.
>> I am trying find the good uses of write function in Input subsystem,
>> but could not find the solution over internet.
>> Can you please help in answering my query below:
>>
>> As you know, in evdev.c file, fops is defined as below
>> struct file_operations evdev_fops = {
>> .read           = evdev_read,
>> .write          = evdev_write,
>> ...
>> }
>>
>> So in what cases, evdev_write function is used ?
>> One case I can think of is that, it can be used in input device simulator
>> to write the recorded data back into buffer.
>
> You are right, majority of times you are reading from the buffer. Still,
> sometimes you want to control hardware state, for example, toggle keyboard LED.
> That can be achieved by writing appropriate event to the event device.
>

Okay. :)
So it means application upon receiving some key value,
it can write EV_LED type of event to keyboard input device node
and if  dev->event function is defined in driver, driver can request
hardware to toggle led.
Similarly, it can be done for cases like sound (EV_SND, force
feedback(EV_FF), etc
Right ?

> For simulators I think uinput is suited the best.
>

As i know, in case of uinput, there is only one device node
/dev/uinput or /dev/input/uinput.
and to distinguish the events, we can use event type and code.

But, if we are simulating multiple devices together like
accelerometer, gyro, mag, light, compass, etc
then any two devices can have same event type and code.
Like accel and gyro can both have EV_REL and REL_X/Y/Z.
In such a case, we won't be able to distinguish between accel and gyro events.

Instead if we use accel and gyro separate device nodes,
there is no such problem because device nodes itself are different. :)
So for such case, I think simulation through proper device node is better.
Is my point of view correct ?

Please share your opinion too.

Thanks,
Aniroop
