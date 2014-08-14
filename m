From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: Re: [Question: Drivers/input/evdev.c] What is the use of write
 function in evdev_fops?
Date: Fri, 15 Aug 2014 00:55:35 +0530
Message-ID: <CADYu30_oB94oORguEu3+Ri4YFu6Vuo1qBvsmFmFbSpZufJ49aQ@mail.gmail.com>
References: <CADYu30-WqEUF-BiefJBo9yWUpKKX_zoLZGXsrJSdC46N8w0OVg@mail.gmail.com>
	<20140813170639.GA16164@core.coreip.homeip.net>
	<CADYu30-OBXKQTMD_kAmjfrYoXvO0NkcaPac5kpe1hmbXy473Ww@mail.gmail.com>
	<20140813185851.GA34103@core.coreip.homeip.net>
	<CADYu30_XWpoYmFyGB7Pe9xkG0kyCUJo03NO0U2kycBfY83J3OA@mail.gmail.com>
	<a3bd7d64-136e-42ea-98ca-e7992b48cc01@email.android.com>
	<CADYu308G3_50JTEfwOnRy4U4x8U_FTpuxqLhHqmqWiCAwAYH7w@mail.gmail.com>
	<8453fbc4-dfb7-4d93-acc9-e0151c8901ed@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:51047 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774AbaHNTZh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Aug 2014 15:25:37 -0400
Received: by mail-la0-f50.google.com with SMTP id pi18so1569345lab.37
        for <linux-input@vger.kernel.org>; Thu, 14 Aug 2014 12:25:35 -0700 (PDT)
In-Reply-To: <8453fbc4-dfb7-4d93-acc9-e0151c8901ed@email.android.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thu, Aug 14, 2014 at 1:12 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On August 13, 2014 12:28:46 PM PDT, Aniroop Mathur <aniroop.mathur@gmail.com> wrote:
>>On Thu, Aug 14, 2014 at 12:50 AM, Dmitry Torokhov
>><dmitry.torokhov@gmail.com> wrote:
>>> On August 13, 2014 12:10:16 PM PDT, Aniroop Mathur
>><aniroop.mathur@gmail.com> wrote:
>>>>On Thu, Aug 14, 2014 at 12:28 AM, Dmitry Torokhov
>>>><dmitry.torokhov@gmail.com> wrote:
>>>>> On Wed, Aug 13, 2014 at 11:41:20PM +0530, Aniroop Mathur wrote:
>>>>>> Hello Mr. Torokhov :)
>>>>>>
>>>>>> On Wed, Aug 13, 2014 at 10:36 PM, Dmitry Torokhov
>>>>>> <dmitry.torokhov@gmail.com> wrote:
>>>>>> > Hi Aniroop,
>>>>>> >
>>>>>> > On Wed, Aug 13, 2014 at 10:16:34PM +0530, Aniroop Mathur wrote:
>>>>>> >> Dear Mr. Torokhov and Linux-Input Community,
>>>>>> >> Greetings of the day !! :)
>>>>>> >>
>>>>>> >> I have not seen some good use of write function in input
>>>>subsystem.
>>>>>> >> I am trying find the good uses of write function in Input
>>>>subsystem,
>>>>>> >> but could not find the solution over internet.
>>>>>> >> Can you please help in answering my query below:
>>>>>> >>
>>>>>> >> As you know, in evdev.c file, fops is defined as below
>>>>>> >> struct file_operations evdev_fops = {
>>>>>> >> .read           = evdev_read,
>>>>>> >> .write          = evdev_write,
>>>>>> >> ...
>>>>>> >> }
>>>>>> >>
>>>>>> >> So in what cases, evdev_write function is used ?
>>>>>> >> One case I can think of is that, it can be used in input device
>>>>simulator
>>>>>> >> to write the recorded data back into buffer.
>>>>>> >
>>>>>> > You are right, majority of times you are reading from the
>>buffer.
>>>>Still,
>>>>>> > sometimes you want to control hardware state, for example,
>>toggle
>>>>keyboard LED.
>>>>>> > That can be achieved by writing appropriate event to the event
>>>>device.
>>>>>> >
>>>>>>
>>>>>> Okay. :)
>>>>>> So it means application upon receiving some key value,
>>>>>> it can write EV_LED type of event to keyboard input device node
>>>>>> and if  dev->event function is defined in driver, driver can
>>request
>>>>>> hardware to toggle led.
>>>>>> Similarly, it can be done for cases like sound (EV_SND, force
>>>>>> feedback(EV_FF), etc
>>>>>> Right ?
>>>>>
>>>>> Yes.
>>>>>
>>>>>>
>>>>>> > For simulators I think uinput is suited the best.
>>>>>> >
>>>>>>
>>>>>> As i know, in case of uinput, there is only one device node
>>>>>> /dev/uinput or /dev/input/uinput.
>>>>>> and to distinguish the events, we can use event type and code.
>>>>>>
>>>>>> But, if we are simulating multiple devices together like
>>>>>> accelerometer, gyro, mag, light, compass, etc
>>>>>> then any two devices can have same event type and code.
>>>>>> Like accel and gyro can both have EV_REL and REL_X/Y/Z.
>>>>>> In such a case, we won't be able to distinguish between accel and
>>>>gyro events.
>>>>>>
>>>>>> Instead if we use accel and gyro separate device nodes,
>>>>>> there is no such problem because device nodes itself are
>>different.
>>>>:)
>>>>>> So for such case, I think simulation through proper device node is
>>>>better.
>>>>>
>>>>> Even though there is only one /dev/input/uinput every user (an
>>entity
>>>>> opening that device node) will end up creating it's very own and
>>>>> separate input device, with separate bitmasks, events, etc, etc.
>>>>>
>>>>
>>>>How to use bitmasks to distinguish between two events ?
>>>>In below code, I can only see type and code as
>>>>identification variables.
>>>>Can we use bitmask too here ?
>>>>
>>>>fd = open("/dev/uinput", O_RDWR);
>>>>
>>>
>>> You need to open 2 separate file descriptors.
>>>
>>
>>2 separate file descriptors like below ?
>>int fd1 = open("/dev/uinput", O_RDWR);
>>int fd2 = open("/dev/uinput", O_RDWR);
>>
>>But my reading data will still come in struct input_event as mentioned
>>above.
>>It has only time, type, code and value.
>>So, how we can use bitmask here ?
>>
>>struct input_event {
>>struct timeval time;
>>__u16 type;
>>__u16 code;
>>__s32 value;
>> };
>
> By opening 2 fds you'll end up creating 2 separate input devices with separate evdev nodes, etc, so you will not mix up input events.
>
> I think at this time you should just try actually using uinput and that should clear things for you.
>

Can you please explain what do you mean by separate evdev nodes ?
Do you mean two separate evdev nodes for uinput ?
But as we discussed before, there is only one node in case of uinput
i.e. /dev/uinput.

Kindly elaborate more.

Thanks,
Aniroop
