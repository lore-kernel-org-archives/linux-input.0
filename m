From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] Input: new EVIOCGKEYF to get keystate and flush queues
Date: Wed, 27 Mar 2013 22:02:31 +0100
Message-ID: <CANq1E4Sr_BBhWqYGbzQ5cejOTD-aB_A-wc=sjoycDQP_A0ittA@mail.gmail.com>
References: <1357559903-1881-1-git-send-email-dh.herrmann@googlemail.com>
	<20130216211017.GB22044@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ia0-f172.google.com ([209.85.210.172]:61801 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522Ab3C0VCb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Mar 2013 17:02:31 -0400
Received: by mail-ia0-f172.google.com with SMTP id l29so7801538iag.31
        for <linux-input@vger.kernel.org>; Wed, 27 Mar 2013 14:02:31 -0700 (PDT)
In-Reply-To: <20130216211017.GB22044@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Herrmann <dh.herrmann@googlemail.com>, linux-input@vger.kernel.org

Hi Dmitry

On Sat, Feb 16, 2013 at 10:10 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi David,
>
> On Mon, Jan 07, 2013 at 12:58:23PM +0100, David Herrmann wrote:
>> EVIOCGKEYF returns the current keystate similar to EVIOCGKEY but also
>> flushes the outgoing evdev event queue. This allows user-space devices to
>> reliably retrieve the current state without having old events still in the
>> read()-queue.
>>
>> Userspace libraries like XKB/xkbcommon use stacking key trackers, so they
>> allow the kernel to map multiple keys to the same keycode. For instance if
>> left-shift and right-shift map to the same keycode, xkbcommon allows the
>> kernel to send key-down twice but also requires it to send key-up twice. A
>> single input device doesn't support that, but this is very useful if you want
>> multiple connected keyboards to have one shared modifier state: Pressing Shift
>> on the one keyboard affects keys on the other keyboard. This is not the usual
>> setup but it is supported and known to be used (for instance if you have
>> external num-pads etc.).
>>
>> When a program opens input devices, it can read the keystate via EVIOCGKEY
>> to update its internal keyboard state. This allows to keep CTRL pressed
>> while switching VTs and having both applications remember that CTRL is
>> still pressed.
>> However, if there are still outgoing events in the evdev queue, the
>> application will update its internal keyboard state and then read the
>> event again, even though it already processed it via EVIOCGKEY.
>>
>> EVIOCGKEYF solves this race condition by flushing the evdev queue while
>> returning the keystate. We cannot change EVIOCGKEY because we don't know
>> whether userspace depends on a clean read() history and flushing the queue
>> effectively drops events.
>>
>> This race could be fixed in user-space by keeping an exact copy of the keystate
>> array for each input device that we opened and ignoring double-events for a
>> single keycode. However, if we, as mentioned, want a shared keyboard-state, it
>> seems to be a waste of computing power and memory to keep another copy for each
>> input device if we could just use something like EVIOCGKEYF.
>
> I do not think we should introduce the new ioctl as I really doubt
> anyone is using it and even if they do I really doubt they will have
> problems if we flush the events.
>
> But rather that flushing all events we should only flush the key events.
> The relative, absolute, and other events should be kept in the queue.

(seems we have nearly the same delay for responses, sorry..)

I'm not entirely sure whether I understand you correctly. Do you
propose to just fix EVIOCGKEY to flush the queues? It does break
semantics, but I agree, that this probably fixes existing userspace
and does not break it.

So if you agree, I will prepare a fix that flushes pending KEY-events
for EVIOCGKEY. And I will try to do the same for ABS/REL events. And
if you're too busy, I'll send it anyway ;)

I'm also talking to XKB developers and it really seems that userspace
already expects those semantics. I haven't found any application that
expects the queues to report the duplicate events.

But I'd really like to see this fixed. I hate knowing that there is a
theoretical race-condition and I keep reminding myself of it..

Thanks
David
