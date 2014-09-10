From: Fredrik Hallenberg <megahallon@gmail.com>
Subject: Re: [PATCH] Handle spurious backslash key repeats on some keyboards
Date: Wed, 10 Sep 2014 13:13:48 +0200
Message-ID: <CAMsZVf9_RHYMRmpvenYcHwXFN3B=D5KnZ0zGOR+zzTw1eOqWHw@mail.gmail.com>
References: <1407664566-5303-1-git-send-email-megahallon@gmail.com>
	<CAMsZVf_h2fODG2UTs6ddZYZLGfF5hdyY+1PdwXO8N5taDahRwg@mail.gmail.com>
	<alpine.LNX.2.00.1409101025430.5523@pobox.suse.cz>
	<CANq1E4S98gWYSHJ=WxNYKB2t=95WY=4tcC3ioFYcm5ZkwFSs=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:53853 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbaIJLNs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Sep 2014 07:13:48 -0400
Received: by mail-qc0-f171.google.com with SMTP id x3so18658751qcv.2
        for <linux-input@vger.kernel.org>; Wed, 10 Sep 2014 04:13:48 -0700 (PDT)
In-Reply-To: <CANq1E4S98gWYSHJ=WxNYKB2t=95WY=4tcC3ioFYcm5ZkwFSs=g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

The keyboards in question have n-key rollover, this seems to be
implemented by sending every single key id every time the keyboard is
polled, this includes several keys that does not exist physically for
example 0x31. This may be a bit excessive but not broken. If I press
a-key and '-key in rapid succession, I get the following events
(omitting all other keys):

VALUE 1 CODE 30 HID 0x4
VALUE 0 CODE 43 HID 0x31
VALUE 0 CODE 43 HID 0x32
Output: a

VALUE 1 CODE 30 HID 0x4
VALUE 0 CODE 43 HID 0x31  - 43 is up
VALUE 1 CODE 43 HID 0x32  - 43 is down
Output: '

VALUE 0 CODE 30 HID 0x4
VALUE 0 CODE 43 HID 0x31  - 43 is up
VALUE 1 CODE 43 HID 0x32  - 43 is down
Output: '

VALUE 0 CODE 30 HID 0x4
VALUE 0 CODE 43 HID 0x31  - 43 is up
VALUE 1 CODE 43 HID 0x32  - 43 is down
Output: '

So even though the keyboard is behaving a bit weird the problem is in
the kernel as it will interpret 0x31 and 0x32 as the same key.

I don't have access to the keyboard at the moment, I will send the
descriptor later today.


On Wed, Sep 10, 2014 at 12:09 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
> Hi
>
> (CC Dmitry for AT details)
>
> On Wed, Sep 10, 2014 at 10:26 AM, Jiri Kosina <jkosina@suse.cz> wrote:
>> On Tue, 9 Sep 2014, Fredrik Hallenberg wrote:
>>
>>> Hi, time for a bump on this one.
>>>
>>> On Sun, Aug 10, 2014 at 11:56 AM, Fredrik Hallenberg
>>> <megahallon@gmail.com> wrote:
>>> > Here is my attempt on a fix for bug 70181, please review it. It is
>>> > tested on my nordic Corsair K70, if this solution is deemed acceptable
>>> > I can ask some people with other problematic keyboards to test it.
>>> >
>>> > Signed-off-by: Fredrik Hallenberg <megahallon@gmail.com>
>>> > ---
>>> >  drivers/hid/hid-input.c | 14 ++++++++++++++
>>> >  include/linux/hid.h     |  1 +
>>> >  2 files changed, 15 insertions(+)
>>> >
>>> > diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
>>> > index 2619f7f..56429c0 100644
>>> > --- a/drivers/hid/hid-input.c
>>> > +++ b/drivers/hid/hid-input.c
>>> > @@ -1085,6 +1085,20 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
>>> >                 return;
>>> >         }
>>> >
>>> > +       /*
>>> > +        * Some keyboards will report both HID keys 0x31 (\ and |) and
>>> > +        * 0x32 (Non-US # and ~) which are both mapped to
>>> > +        * KEY_BACKSLASH. This will cause spurious events causing
>>
>> Hmm, makes me wonder if this mapping in hid_keyboard[] is even correct.
>> The footnote in HUT 1.12 specifies very different mappings for different
>> national keyboards.
>
> This is the key that's moved on European layouts due to the different
> shape of the 'Enter' key. HID defines two different usage types, key
> 0x31 and 0x32. It doesn't make sense for a keyboard to enable both, so
> this really sounds like a broken hid description to me.
>
> We currently map both those keys to KEY_BACKSLASH, which means
> regardless whether it's the European or standard layout, the same
> keycodes are generated. So mapping 0x31 and 0x32 to the same key
> sounds fine (or at least consistent).
>
> @Fredrik: can you send us your HID descriptor from the broken deivce?
> (cat /sys/kernel/debug/hid/<device>/desc).
>
> I wonder why you get key-repeat events, though. I mean, the keyboard
> has to send both 0x31 and 0x32 events for you to get those repeat
> events. But it really doesn't make sense to me for a keyboard to
> report both keys, and furthermore your report sounded like you only
> pressed a single key, right?
>
> Thanks
> David
