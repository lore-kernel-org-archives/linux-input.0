From: Elias Vanderstuyft <elias.vds@gmail.com>
Subject: Re: ff-core effect id handling in case of a failed effect upload
Date: Sun, 23 Feb 2014 15:27:45 +0100
Message-ID: <CADbOyBQ8yUhaqz7DshbkSzsN-=Lci=QAOhVAJmTAvjQrrrUw4A@mail.gmail.com>
References: <CADbOyBRX8Zd=WyXpgWo8Kkg5HkAJHjSA0KCiJD_36PLiSKAQJQ@mail.gmail.com>
	<5304E0A0.5070007@iki.fi>
	<20140219210523.GA13951@core.coreip.homeip.net>
	<CADbOyBSR+CWouAQ+f7VjJcoqiC_J++O7cnjkx+2DqmQorhQ7wg@mail.gmail.com>
	<20140223063043.GB10151@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f175.google.com ([209.85.220.175]:64209 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132AbaBWO1q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 23 Feb 2014 09:27:46 -0500
Received: by mail-vc0-f175.google.com with SMTP id ij19so4902672vcb.34
        for <linux-input@vger.kernel.org>; Sun, 23 Feb 2014 06:27:45 -0800 (PST)
In-Reply-To: <20140223063043.GB10151@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Anssi Hannula <anssi.hannula@iki.fi>, linux-input@vger.kernel.org, wine-devel@winehq.org

I sent a patch, see:
http://www.mail-archive.com/linux-input@vger.kernel.org/msg08572.html
("[PATCH 1/1] Input: don't modify the id of ioctl-provided ff effect
on upload failure")

Elias

On Sun, Feb 23, 2014 at 7:30 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wed, Feb 19, 2014 at 11:14:18PM +0100, Elias Vanderstuyft wrote:
>> On Wed, Feb 19, 2014 at 10:05 PM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> > On Wed, Feb 19, 2014 at 06:49:36PM +0200, Anssi Hannula wrote:
>> >> (added Dmitry to CC)
>> >>
>> >> 19.02.2014 13:42, Elias Vanderstuyft kirjoitti:
>> >> > Hi,
>> >> >
>> >>
>> >> Hi,
>> >>
>> >> > In the process of reviewing the Wine DInput translation layer, I
>> >> > noticed an inconvenience (in the ff-core implementation?) that can
>> >> > possibly lead to confusing problems to application developers (not
>> >> > only for Wine), in short:
>> >> > If a new (id==-1) effect was uploaded (look at
>> >> > ff-core.c::input_ff_upload(...)) that failed (e.g. returning EINVAL),
>> >> > ff-core will have assigned a positive number to the effect id. This
>> >> > can be confusing because the dev->ff->effects[] array will not contain
>> >> > an element at the index of that new effect id.
>> >>
>> >> I agree that this is a bit confusing, and the kernel code should
>> >> probably be modified to not clobber the ioctl-provided effect on failure
>> >> (effect->id is set to an "undefined" value, i.e. next free effect slot).
>> >>
>> >> Dmitry, WDYT?
>> >
>> > Yeah, it looks like we need to change evdev.c to read:
>> >
>> >                 error = input_ff_upload(dev, &effect, file);
>> >                 if (error)
>> >                         return error;
>> >
>> >                 if (put_user(effect.id, &(((struct ff_effect __user *)p)->id)))
>> >                         return -EFAULT;
>> >
>> >                 return 0;
>>
>> Alright, who will create the patch?
>> Do I may / have to do it?
>
> If you could create the patch that would be appreciated.
>
> Thanks.
>
> --
> Dmitry
