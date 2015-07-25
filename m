From: Douglas Christman <douglaschristman@gmail.com>
Subject: Re: ALPS DualPoint double click bug
Date: Sat, 25 Jul 2015 10:07:53 -0400
Message-ID: <CANuv8Qy3FAL0-iWF3usbN2y2VmR4+Si7DqbqwW5aK0ppE8B60Q@mail.gmail.com>
References: <CANuv8QyimosOLwtvLpSLjjEk2SemgxTrZDJxWnzQG-M3q20CHg@mail.gmail.com>
	<20150720065446.GA13879@dtor-ws>
	<20150720072548.GA25910@pali>
	<CANuv8Qx0QyYg0SCYqx=auVd9__UjHBj0DEuF-xcA4Ar4Ha=aVw@mail.gmail.com>
	<20150721071218.GA27290@pali>
	<CANuv8QxKap=K=OoCufcM-Yxujmg+3sUOjWX2D9r7qf==EQoTFQ@mail.gmail.com>
	<20150722072116.GA22138@pali>
	<CAN+gG=Eonx4Fh1HccsLdCL_ONNDXb-QgUvhMPM2B6nAaTVDFLQ@mail.gmail.com>
	<55B0B48D.7010603@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:34082 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754818AbbGYOHy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 25 Jul 2015 10:07:54 -0400
Received: by igk11 with SMTP id 11so23155218igk.1
        for <linux-input@vger.kernel.org>; Sat, 25 Jul 2015 07:07:54 -0700 (PDT)
In-Reply-To: <55B0B48D.7010603@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, cpaul@redhat.com

On Thu, Jul 23, 2015 at 5:31 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 22-07-15 17:08, Benjamin Tissoires wrote:
>>
>> Douglas, can you please make a recording of your touchpad/trackstick
>> with ps2emu-record?
>> Download it from https://github.com/Lyude/ps2emu , compile it and run
>> it as root:
>> - once the touchpad gets re-initialized:
>> - click once, wait a few seconds
>> - click twice, wait a few seconds
>> - click three times, wait few seconds
>> - use the touchpad a bit, wait a few secs
>> - use the trackstick (and its buttons) a bit
>> - Ctrl-C
>>
>> And send us the resulting file ps2emu_record.txt that will be created
>> in the current directory.
>>
>> Can you also confirm that your laptop has a trackstick as seen on
>> http://www.newegg.com/Product/Product.aspx?Item=N82E16834114551 ?
>
>
> Douglas,
>
> Can you please also make an evemu recording (install evemu, run
> evemu-record)
> of clicking of the 4 buttons? PLease make 1 recording per button click.
>
> Also can you confirm that reverting commit 92bac83dd79e on an otherwise
> unmodified 4.1 kernel fixes things for you ?
>
> Regards,
>
> Hans

I've uploaded all of my recordings to
https://github.com/dobyrch/alps-recordings.  I made recordings on both
kernel versions, as indicated by the "good" or "bad" suffix.

Benjamin, I can confirm that my touchpad looks just like the one in
the picture--four buttons and a trackstick.

While making these recordings, I discovered another strange behavior.
The two lower mouse buttons do not trigger any mouse events when
clicked on their own.  However, If I click one of the top mouse
buttons followed by a lower mouse button, it triggers a press event
(but no release) for all three mouse buttons--left, right, and middle
(even though I don't have a middle mouse button).

Hans, I'll have to double-check that reverting 92bac on v4.1 fixes
things.  When I have a chance to recompile I'll let you know the
outcome.

Thanks everyone,
Doug
