From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [RFC] input: mt: Support for touch cancel
Date: Tue, 12 Mar 2013 09:59:44 +0100
Message-ID: <CAN+gG=F280vzLM_43zU1biJf+p+Jq+=z5egFc+KOYAvth3+BZQ@mail.gmail.com>
References: <CAPDwgkMbwTtf2a5Xuvb3_B18FBJ7w6VJx1CJN=gGwaaRSKzDbA@mail.gmail.com>
	<20130312013605.GA31587@yabbi.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:37397 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755176Ab3CLI7q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Mar 2013 04:59:46 -0400
Received: by mail-la0-f41.google.com with SMTP id fo12so4914232lab.28
        for <linux-input@vger.kernel.org>; Tue, 12 Mar 2013 01:59:44 -0700 (PDT)
In-Reply-To: <20130312013605.GA31587@yabbi.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Yufeng Shen <miletus@chromium.org>, linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>, Daniel Kurtz <djkurtz@chromium.org>, rbyers@chromium.org

On Tue, Mar 12, 2013 at 2:36 AM, Peter Hutterer
<peter.hutterer@who-t.net> wrote:
> On Mon, Mar 11, 2013 at 04:34:27PM -0400, Yufeng Shen wrote:
>> I have ran into cases where I want to make a touch end event to have a
>> touch cancel indication.
>>
>> This comes from trying to solve the problem of :
>>
>> If the touch sequence happens before the system suspends, and the touch
>> release event is
>> never received after the system resumes, userspace MT state tracking could
>> be in a bad state.
>>
>> ( see #5 from
>> https://bugs.launchpad.net/ubuntu/+source/xserver-xorg-input-synaptics/+bug/968845
>> for an example of how this could happen from lid close/open on MBA)
>
> ftr, this a bug in the driver and should be fixed now.
>
>> One possible workaround is to let the touch device driver to release all
>> existing touches on
>> resume, which has the effect of clearing all the MT states in userspace
>> touch stacks.
>> But the touch release/end event often will result in some gesture being
>> recognized and performed,
>> like a tap-to-click being generated.
>>
>> So I am wondering what's the best way to solve the problem of clearing the
>> touch states with
>> minimal side effect. One way I can think of is to have MTB protocol add
>> support of
>> a touch cancel indication on touch release, e.g. making TRACKING_ID = -2
>> meaning that
>> the touch release is synthesized from the system and really has the meaning
>> of releasing and canceling the current touch, while TRACKING_ID = -1
>> meaning that the touch release is reported back from the device.
>>
>> And from Xf86-input driver level, we can add a corresponding TouchCancel
>> for this.
>
> I can handle touch-cancel events in the synaptics driver to avoid
> tap-to-click but further details get a bit nasty.
>
> To actually add TouchCancel to the client-protocol means a new XI protocol
> revision, plus the stuff in the server _and_ the stuff in the client. that
> is quite some lag time here, and if a client cannot handle TouchCancel all
> we can do is do a TouchEnd - which will still trigger the gesture.
>
> even if you update the touch clients you're still lacking any solution for
> pointer-emulated clients. again, here we can only do a ButtonRelease event
> which again will trigger whatever it did.
>
> All the above can be implemented though. In fact, I suspect the protocol
> part is the easy bit (just a flag on TouchEnd) but the server part is
> reasonably nasty.
>
> the real counter-argument is that I think it is a partial solution only.
> From an X perspective touches also end when you vt-switch away from the
> server (device is disabled). but the kernel won't cancel the touch event for
> that. Or when the device is disabled by the client ("disable touchpad while
> typing" feature), So we'd have to maintain both implicit cancel and explicit
> cancel in the driver anyway.
>
> so yeah, I don't think adding this to the kernel would provide any
> significant benefit since we still need to handle all the other cases
> anyway.

If the same effect is seen when VT-switching, it's definitively a user
space synchronization problem, not a kernel problem.

I think we have all the pieces in term of protocol in the kernel for
this use case:
When coming back from resume, the kernel should guarantee that the
current input state is correct. If fingers are still present, then
their slots are still assigned, if they are missing, their slots
should be silently released (as if the released occurs while
sleeping). This is something the kernel can work on.
As for the user-space, when coming back from a situation where
inconsistency may have occurred (VT-switching, sleep/resume, events
dropped due to a SYN_DROPPED event, or device disabled by the client),
the user-space driver has to retrieve the current state of the kernel
driver through the correct ioctls. If it doesn't do it, then that
means that he is not following the evdev protocol. It's up to it to
notify or not the toolkit/gesture recognizer that events have been
dropped.

Cheers,
Benjamin
