From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [RFC RESEND 5/5] Input: evdev - add new EVIOCGABSRANGE ioctl
Date: Mon, 11 Aug 2014 12:02:28 +0200
Message-ID: <CANq1E4Rgo9cU8PCB5ENdzoKCJU_Ob-ak01o7ALiXLMK-v1m3Ng@mail.gmail.com>
References: <1405775445-4454-1-git-send-email-dh.herrmann@gmail.com>
	<1405775445-4454-6-git-send-email-dh.herrmann@gmail.com>
	<20140806013519.GA11429@jelly.redhat.com>
	<CANq1E4QB3wiHRTjb_4xmVvXwOZvdpOQR9nZtnaZt=k2GaLJAmw@mail.gmail.com>
	<20140808174742.GG26820@core.coreip.homeip.net>
	<CANq1E4R14eOiXQ9p7XOPiOBuOnNns+EwgQMqrwOqeVKn4y8vAQ@mail.gmail.com>
	<20140810231759.GA10731@jelly.redhat.com>
	<20140811000134.GA12650@core.coreip.homeip.net>
	<20140811021316.GA26242@jelly.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:39038 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbaHKKC2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Aug 2014 06:02:28 -0400
Received: by mail-ie0-f176.google.com with SMTP id tr6so9601588ieb.35
        for <linux-input@vger.kernel.org>; Mon, 11 Aug 2014 03:02:28 -0700 (PDT)
In-Reply-To: <20140811021316.GA26242@jelly.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Dmitry Torokhov <dtor@google.com>

Hi

On Mon, Aug 11, 2014 at 4:13 AM, Peter Hutterer
<peter.hutterer@who-t.net> wrote:
> On Sun, Aug 10, 2014 at 05:01:35PM -0700, Dmitry Torokhov wrote:
> [...]
>> > >
>> > >    is about handling corner-cases. If we make SYN_DROPPED
>> > >    handling cause SYN_DROPPED, we can just ignore it.
>> >
>> > yep, that too was my first thought. with a plain resync ioctl you're pretty
>> > much guaranteed to get SYN_DROPPED before the client manages to handle the
>> > resync. Even if you reduce the number of events as above because the most
>> > common occurance for SYN_DROPPED is in the ABS_MT range which we cannot
>> > meaningfully reduce.
>>
>> Hmm, that's a problem... But is it? We need to make sure that buffer is large
>> enough for the MT device to transmit all it's contacts properly. We can not
>> expect that we'll always be able to reduce number of events if a user actively
>> uses 10 contacts. IOW we need to solve this issue regardless of this proposed
>> sync ioctl.
>>
>> Maybe we need to review drivers and see if they need to supply their own hints
>> or update hinting logic in core?
>
> The buffer is already large enough for at least one full report from the
> device plus a few extra events [1]. for the devices we see SYN_REPORT most
> frequently dumping the state means filling up the buffer to the almost
> maximum. To give some room for movement, we need to increase the queue by at
> least a factor 2. That gives us with room for one whole sync report and at
> least one full extra event. Anything smaller we get the side-effect
> that a client that is too slow and gets a SYN_DROPPED is actually worse off
> because now the buffer is so full from the sync that a SYN_DROPPED is even
> more likely to occur than before.
>
> We also need to define the behaviour for the queue filling up while the
> client is in the middle of a sync. That means the client must be
> able to handle SYN_DROPPED as well as SYN_SYNC_DONE during a sync or the
> kernel protects the events up to SYN_SYNC_DONE in the queue in the case of
> a SYN_DROPPED.
>
> Either way it's IMO more complicated than having a separate buffer for the
> sync state.

Yepp, fully agree on both points you make (I summarized them way worse
than you did!).

Thanks
David
