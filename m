From: Jonathan Clarke <jonathan.a.clarke@gmail.com>
Subject: Re: hid-multitouch: change for touch height/width
Date: Wed, 25 Jan 2017 12:17:58 +0000
Message-ID: <CAFW_ifyutv+=OgnWTr5bqat9-UmJBtXbaO6ZX+FjGWv6hbgMJQ@mail.gmail.com>
References: <CAFW_ifxfBoN=gVQQiE+9-bLTtDFGjP-HMvWxXTVztOgma+JdqQ@mail.gmail.com>
 <20170125103950.GA13244@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36166 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbdAYMSA (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 25 Jan 2017 07:18:00 -0500
Received: by mail-wm0-f44.google.com with SMTP id c85so23541624wmi.1
        for <linux-input@vger.kernel.org>; Wed, 25 Jan 2017 04:17:59 -0800 (PST)
In-Reply-To: <20170125103950.GA13244@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, =?UTF-8?Q?St=C3=A9phane_Chatty?= <chatty@enac.fr>, Jiri Kosina <jkosina@suse.cz>

Thanks for your thoughts Benjamin, all makes sense.  I'll submit a
patch in the next few days.

Cheers, Jonathan

On 25 January 2017 at 10:39, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> Hi Jonathan,
>
> On Jan 24 2017 or thereabouts, Jonathan Clarke wrote:
>> Hi all,
>>
>> I'd like to get your opinion on a proposal for a small change to the
>> hid-multitouch driver.  As you probably know this driver supports
>> multi touch input for various touchscreen/touchpad devices.
>>
>> The change relates to lines 654 & 655 of "hid-multitouch.c" - I would
>> like to remove the "division by 2" applied to the "touch width" and
>> "touch height" values received from the input device.  These values
>> represent the width and height of the area occupied by a finger
>> touching the input device.
>>
>> https://github.com/torvalds/linux/blame/master/drivers/
>> hid/hid-multitouch.c#L654
>>
>> This division by 2 was added along with the the touch width/height
>> fields 6 years ago so that those fields "match the visual scale of the
>> touch" for a specific device (3M PCT) - see comment & associated
>> commit log for line 653.
>>
>> I don't think that this scaling is appropriate for all the other devices
>> that this driver now supports.  On my screen for example (Elan
>> multitouch screen), the touch width and height reported bear no
>> relation to the "visual scale of the touch" with or without this /2
>> scaling applied.  I suspect that the scale of touch width/height
>> values reported are different for every device (though I've not
>> checked any other device).
>>
>> The scaling is also discarding information about touch size (1 bit for
>> each of width/height) which is useful for any application that wants
>> to know about it.
>>
>> So in summary I think the main questions for you are:
>> 1. would making this change have a negative effect on any existing
>> applications that use this information?
>
> It will have a negative effect on the particular models they were a fix
> for. Luckily, the 3M panels already have a specific class for them, so I
> wouldn't be against adding a quirk for those.
>
>> 2. does it seem sensible to (continue to) provide touch width/height
>> values that bear no relation to screen/pixel dimensions?
>
> Unfortunately, that's what the hardware provides, and we can't do much
> about it. IIRC Android has some table to match the incoming data with
> proper values, and that's the only current solution. Miscorsoft enforced
> a much better multitouch protocol in Windows 8, but failed at enforcing
> the width and height of the contacts.
>
> So, after a little bit of re-reading of
> Documentation/input/multi-touch-protocol.txt, I also think we should get
> rid of the divided by 2 in the generic case. WIDTH and HEIGHT are,
> according to this document the diameters of the ellipses, so it makes no
> sense to divide them by 2 (except in the 3M case, where the value was
> too big).
>
> So please submit a patch for this, and add a specific quirk in the MT_CLS_3M
> class to divide by 2 the width and height.
>
> Cheers,
> Benjamin
>
>>
>> I delved into this because I wanted to get as much precision on touch
>> width/height as possible and was surprised at the low resolution of
>> sizes output by my touchscreen.  I got an extra 2 bits of precision
>> from my search!
>>
>> Cheers & thanks for reading.  Jonathan
