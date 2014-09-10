From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] Handle spurious backslash key repeats on some keyboards
Date: Wed, 10 Sep 2014 12:09:32 +0200
Message-ID: <CANq1E4S98gWYSHJ=WxNYKB2t=95WY=4tcC3ioFYcm5ZkwFSs=g@mail.gmail.com>
References: <1407664566-5303-1-git-send-email-megahallon@gmail.com>
	<CAMsZVf_h2fODG2UTs6ddZYZLGfF5hdyY+1PdwXO8N5taDahRwg@mail.gmail.com>
	<alpine.LNX.2.00.1409101025430.5523@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:49766 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251AbaIJKJc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Sep 2014 06:09:32 -0400
Received: by mail-ig0-f177.google.com with SMTP id uq10so2720169igb.10
        for <linux-input@vger.kernel.org>; Wed, 10 Sep 2014 03:09:32 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1409101025430.5523@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Fredrik Hallenberg <megahallon@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi

(CC Dmitry for AT details)

On Wed, Sep 10, 2014 at 10:26 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Tue, 9 Sep 2014, Fredrik Hallenberg wrote:
>
>> Hi, time for a bump on this one.
>>
>> On Sun, Aug 10, 2014 at 11:56 AM, Fredrik Hallenberg
>> <megahallon@gmail.com> wrote:
>> > Here is my attempt on a fix for bug 70181, please review it. It is
>> > tested on my nordic Corsair K70, if this solution is deemed acceptable
>> > I can ask some people with other problematic keyboards to test it.
>> >
>> > Signed-off-by: Fredrik Hallenberg <megahallon@gmail.com>
>> > ---
>> >  drivers/hid/hid-input.c | 14 ++++++++++++++
>> >  include/linux/hid.h     |  1 +
>> >  2 files changed, 15 insertions(+)
>> >
>> > diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
>> > index 2619f7f..56429c0 100644
>> > --- a/drivers/hid/hid-input.c
>> > +++ b/drivers/hid/hid-input.c
>> > @@ -1085,6 +1085,20 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
>> >                 return;
>> >         }
>> >
>> > +       /*
>> > +        * Some keyboards will report both HID keys 0x31 (\ and |) and
>> > +        * 0x32 (Non-US # and ~) which are both mapped to
>> > +        * KEY_BACKSLASH. This will cause spurious events causing
>
> Hmm, makes me wonder if this mapping in hid_keyboard[] is even correct.
> The footnote in HUT 1.12 specifies very different mappings for different
> national keyboards.

This is the key that's moved on European layouts due to the different
shape of the 'Enter' key. HID defines two different usage types, key
0x31 and 0x32. It doesn't make sense for a keyboard to enable both, so
this really sounds like a broken hid description to me.

We currently map both those keys to KEY_BACKSLASH, which means
regardless whether it's the European or standard layout, the same
keycodes are generated. So mapping 0x31 and 0x32 to the same key
sounds fine (or at least consistent).

@Fredrik: can you send us your HID descriptor from the broken deivce?
(cat /sys/kernel/debug/hid/<device>/desc).

I wonder why you get key-repeat events, though. I mean, the keyboard
has to send both 0x31 and 0x32 events for you to get those repeat
events. But it really doesn't make sense to me for a keyboard to
report both keys, and furthermore your report sounded like you only
pressed a single key, right?

Thanks
David
