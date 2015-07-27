From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: ALPS DualPoint double click bug
Date: Mon, 27 Jul 2015 18:40:10 +0200
Message-ID: <55B65EEA.5080404@redhat.com>
References: <CANuv8QyimosOLwtvLpSLjjEk2SemgxTrZDJxWnzQG-M3q20CHg@mail.gmail.com>
 <20150720065446.GA13879@dtor-ws> <20150720072548.GA25910@pali>
 <CANuv8Qx0QyYg0SCYqx=auVd9__UjHBj0DEuF-xcA4Ar4Ha=aVw@mail.gmail.com>
 <20150721071218.GA27290@pali>
 <CANuv8QxKap=K=OoCufcM-Yxujmg+3sUOjWX2D9r7qf==EQoTFQ@mail.gmail.com>
 <20150722072116.GA22138@pali>
 <CAN+gG=Eonx4Fh1HccsLdCL_ONNDXb-QgUvhMPM2B6nAaTVDFLQ@mail.gmail.com>
 <55B0B48D.7010603@redhat.com>
 <CANuv8Qy3FAL0-iWF3usbN2y2VmR4+Si7DqbqwW5aK0ppE8B60Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55847 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751342AbbG0SXe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jul 2015 14:23:34 -0400
In-Reply-To: <CANuv8Qy3FAL0-iWF3usbN2y2VmR4+Si7DqbqwW5aK0ppE8B60Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Douglas Christman <douglaschristman@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, cpaul@redhat.com

Hi,

On 25-07-15 16:07, Douglas Christman wrote:
> On Thu, Jul 23, 2015 at 5:31 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 22-07-15 17:08, Benjamin Tissoires wrote:
>>>
>>> Douglas, can you please make a recording of your touchpad/trackstick
>>> with ps2emu-record?
>>> Download it from https://github.com/Lyude/ps2emu , compile it and run
>>> it as root:
>>> - once the touchpad gets re-initialized:
>>> - click once, wait a few seconds
>>> - click twice, wait a few seconds
>>> - click three times, wait few seconds
>>> - use the touchpad a bit, wait a few secs
>>> - use the trackstick (and its buttons) a bit
>>> - Ctrl-C
>>>
>>> And send us the resulting file ps2emu_record.txt that will be created
>>> in the current directory.
>>>
>>> Can you also confirm that your laptop has a trackstick as seen on
>>> http://www.newegg.com/Product/Product.aspx?Item=N82E16834114551 ?
>>
>>
>> Douglas,
>>
>> Can you please also make an evemu recording (install evemu, run
>> evemu-record)
>> of clicking of the 4 buttons? PLease make 1 recording per button click.
>>
>> Also can you confirm that reverting commit 92bac83dd79e on an otherwise
>> unmodified 4.1 kernel fixes things for you ?
>>
>> Regards,
>>
>> Hans
>
> I've uploaded all of my recordings to
> https://github.com/dobyrch/alps-recordings.  I made recordings on both
> kernel versions, as indicated by the "good" or "bad" suffix.

Thanks.

> Benjamin, I can confirm that my touchpad looks just like the one in
> the picture--four buttons and a trackstick.
>
> While making these recordings, I discovered another strange behavior.
> The two lower mouse buttons do not trigger any mouse events when
> clicked on their own.  However, If I click one of the top mouse
> buttons followed by a lower mouse button, it triggers a press event
> (but no release) for all three mouse buttons--left, right, and middle
> (even though I don't have a middle mouse button).
>
> Hans, I'll have to double-check that reverting 92bac on v4.1 fixes
> things.  When I have a chance to recompile I'll let you know the
> outcome.

OK, please let me know soon, I would like to get to the bottom
of this, and knowing the exact commit causing the problem will
help a lot.

Regards,

hans
