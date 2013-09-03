From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH 1/3] Input: introduce BTN/ABS bits for drums and guitars
Date: Tue, 3 Sep 2013 23:14:57 +0200
Message-ID: <CANq1E4RH9ytrY51AVEEyDOBuv3E6B8nWoBj_Le+CR2=EphO2uw@mail.gmail.com>
References: <1377537288-19289-1-git-send-email-dh.herrmann@gmail.com>
	<1377537288-19289-2-git-send-email-dh.herrmann@gmail.com>
	<alpine.LNX.2.00.1309021341090.3796@pobox.suse.cz>
	<20130903180528.GC25985@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:61032 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760880Ab3ICVO6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Sep 2013 17:14:58 -0400
Received: by mail-ie0-f175.google.com with SMTP id u16so10961584iet.6
        for <linux-input@vger.kernel.org>; Tue, 03 Sep 2013 14:14:58 -0700 (PDT)
In-Reply-To: <20130903180528.GC25985@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

Hi

On Tue, Sep 3, 2013 at 8:05 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Mon, Sep 02, 2013 at 01:41:57PM +0200, Jiri Kosina wrote:
>> On Mon, 26 Aug 2013, David Herrmann wrote:
>>
>> > There are a bunch of guitar and drums devices out there that all report
>> > similar data. To avoid reporting this as BTN_MISC or ABS_MISC, we
>> > allocate some proper namespace for them. Note that most of these devices
>> > are toys and we cannot report any sophisticated physics via this API.
>> >
>> > I did some google-images research and tried to provide definitions that
>> > work with all common devices. That's why I went with 4 toms, 4 cymbals,
>> > one bass, one hi-hat. I haven't seen other drums and I doubt that we need
>> > any additions to that. Anyway, the naming-scheme is intentionally done in
>> > an extensible way.
>> >
>> > For guitars, we support 5 frets (normally aligned vertically, compared to
>> > the real horizontal layouts), a single strum-bar with up/down directions,
>> > an optional fret-board and a whammy-bar.
>> >
>> > Most of the devices provide pressure values so I went with ABS_* bits. If
>> > we ever support devices which only provide digital input, we have to
>> > decide whether to emulate pressure data or add additional BTN_* bits.
>> >
>> > If someone is not familiar with these devices, here are two pictures which
>> > provide almost all introduced interfaces (or try the given keywords
>> > with a google-image search):
>> >   Guitar: ("guitar hero world tour guitar")
>> >     http://images1.wikia.nocookie.net/__cb20120911023442/applezone/es/images/f/f9/Wii_Guitar.jpg
>> >   Drums: ("guitar hero drums")
>> >     http://oyster.ignimgs.com/franchises/images/03/55/35526_band-hero-drum-set-hands-on-20090929040735768.jpg
>> >
>> > Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
>>
>> Hi,
>>
>> I have reviewed and like the implementation of 2/3 and 3/3, but I of
>> course would like to have Ack from Dmitry for this, so that I could take
>> it through my tree together with the rest of the patchset.
>>
>> Dmitry, pretty please?
>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> We might want to see how much memory is taken now by ABS structures and
> think if we could reduce it somehow...

Thanks Dmitry! And I thought about the "absinfo"-size, too. Some rough numbers:

sizeof(struct input_absinfo) = 24 bytes
ABS_CNT * sizeof(struct input_absinfo) = 0x50 * 24 bytes = 1920 bytes

sizeof(struct input_dev) = 1824 bytes
name, phys, uniq + misc ~= 100 bytes
dev->vals ~= 10 * sizeof(struct input_value) = 10 * 8 bytes = 80 bytes

So we get 1824 + 100 + 80 = 2008 bytes for an average trivial input device.
The abs-values add 1920 bytes to that. So I don't think it's that bad.

Anyway, some trivial ideas off the top of my head:

1)
Changing "absinfo" to double-indirection:
    struct input_absinfo *absinfo[ABS_CNT];
    struct input_absinfo *real_absinfo;
We allocate "real_absinfo" as array for as many ABS entries as we need
and set the pointers in "absinfo" accordingly (setting everything else
to NULL).
This, however, still adds ABS_CNT * 8 = 0x50 * 8 = 640 bytes only for
the pointer array. So not really much better. And we get the
additional TLB lookup for the double-indirection. I don't know whether
it matters for the quite expensive input-handling, though.

2)
Using idr. But considering that most input-devices only have very few
(<10?) ABS bits set, it probably doesn't scale.

3)
An rbtree for all absinfo objects. Only adds 24 bytes per absinfo and
lookup is only needed once in input_handle_abs_event(). It takes the
least space of all (except for linear search) and it's still
reasonably fast for all setups.
All in all, if we assume <10 input devices on a machine, we would save
around 20kb with 3). I am not sure what impact it has on performance.
But looking at the deep call-chains in input-interrupts, I doubt it
would be noticeable. But that's only a rough guess..

4)
We let drivers manage absinfo objects and pass it together with
input_event() (for ABS only). Would probably be the nicest solution
but require huge codebase changes.

But maybe someone else has some way better ideas.. It's getting late here.

Cheers
David
