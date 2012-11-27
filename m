From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/2] hid: usbhid: Return -ENOMEM instead of -1 for memory
 allocation failure
Date: Tue, 27 Nov 2012 10:12:25 +0530
Message-ID: <CAK9yfHxRAqau-Xj6uSjjoy0zxLf=47rN0LcLEPKrPvHJ0P8DiA@mail.gmail.com>
References: <1353478830-23788-1-git-send-email-sachin.kamat@linaro.org>
	<alpine.LNX.2.00.1211222202530.4609@pobox.suse.cz>
	<20121126180530.GE14623@core.coreip.homeip.net>
	<alpine.LNX.2.00.1211262308230.15521@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:64069 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478Ab2K0EmZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Nov 2012 23:42:25 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so6460094vbb.19
        for <linux-input@vger.kernel.org>; Mon, 26 Nov 2012 20:42:25 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1211262308230.15521@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, jic23@kernel.org, patches@linaro.org

Hi Jiri,

On 27 November 2012 03:39, Jiri Kosina <jkosina@suse.cz> wrote:
> On Mon, 26 Nov 2012, Dmitry Torokhov wrote:
>
>> > > Silences the following smatch warning:
>> > > drivers/hid/usbhid/hiddev.c:897 hiddev_connect() warn:
>> > > returning -1 instead of -ENOMEM is sloppy
>> > >
>> > > Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> > > ---
>> > >  drivers/hid/usbhid/hiddev.c |    2 +-
>> > >  1 files changed, 1 insertions(+), 1 deletions(-)
>> > >
>> > > diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
>> > > index 14599e2..50e2ab8 100644
>> > > --- a/drivers/hid/usbhid/hiddev.c
>> > > +++ b/drivers/hid/usbhid/hiddev.c
>> > > @@ -894,7 +894,7 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
>> > >   }
>> > >
>> > >   if (!(hiddev = kzalloc(sizeof(struct hiddev), GFP_KERNEL)))
>> > > -         return -1;
>> > > +         return -ENOMEM;
>> > >
>> > >   init_waitqueue_head(&hiddev->wait);
>> > >   INIT_LIST_HEAD(&hiddev->list);
>> >
>> > Well, this would make sense only if the callers would be actualling doing
>> > something useful with that return value. But the only check we are
>> > performing at callsites is non-zero test ...
>>
>> It is chicken and egg problem - callers can't use the result unless it
>> is meaningful and callee's do not bother to send anything meaningful
>> because nobody uses it...
>>
>> If someone takes time to convert to proper return codes I think it would
>> be a good thing.
>
> Fully agree with you.
>
> But I'd like to have both sides changed together once someone starts
> taking care of fixing it.

The proposed change is done in the function hiddev_connect which
returns 0 on success.
The caller only checks if the return value is 0 or not
(!hdev->hiddev_connect(...)). In this case
what is the change that you would like to see on the caller side?

>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs



-- 
With warm regards,
Sachin
