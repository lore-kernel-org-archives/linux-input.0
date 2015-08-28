From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Potential data race in psmouse_interrupt
Date: Fri, 28 Aug 2015 10:51:47 -0700
Message-ID: <CAKdAkRTtxBNstw+XkOVeY5RPqT8hOOOaA0==-nDiSjYYrV+xWQ@mail.gmail.com>
References: <CAAeHK+wZ=fXCRDUvkQdSmFWxU1fqN5suF=P1kL_CT1L8p3ybDg@mail.gmail.com>
	<CAAeHK+wmUwTG=4afGd+LHw7FCcnjsRZY7j_3XnvUYna2Qkx-+A@mail.gmail.com>
	<20150723130844.GA29125@pali>
	<CAAeHK+xyvq3XnN2FZuO35i+DBDYoi1OFWvHmAdZmC=k7kq9q5Q@mail.gmail.com>
	<20150729115326.GE13518@pali>
	<CACT4Y+aG1zHHhfUmV_vMh-XsDLqwj3oSH54wobrf77=qyxVUhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:36352 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350AbbH1Rvs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Aug 2015 13:51:48 -0400
In-Reply-To: <CACT4Y+aG1zHHhfUmV_vMh-XsDLqwj3oSH54wobrf77=qyxVUhA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Vyukov <dvyukov@google.com>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Andrey Konovalov <andreyknvl@google.com>, Hans de Goede <hdegoede@redhat.com>, Mathias Gottschlag <mgottschlag@gmail.com>, Shailendra Verma <shailendra.capricorn@gmail.com>, Rusty Russell <rusty@rustcorp.com.au>, "Luis R. Rodriguez" <mcgrof@suse.com>, Thomas Hellstrom <thellstrom@vmware.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Kostya Serebryany <kcc@google.com>, Alexander Potapenko <glider@google.com>, ktsan@googlegroups.com

On Fri, Aug 28, 2015 at 10:34 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
> Hello,
>
> I am looking at this code in __ps2_command again:
>
> /*
> * The reset command takes a long time to execute.
> */
> timeout = msecs_to_jiffies(command == PS2_CMD_RESET_BAT ? 4000 : 500);
>
> timeout = wait_event_timeout(ps2dev->wait,
>     !(READ_ONCE(ps2dev->flags) & PS2_FLAG_CMD1), timeout);
>
> if (smp_load_acquire(&ps2dev->cmdcnt) &&
>     !(smp_load_acquire(&ps2dev->flags) & PS2_FLAG_CMD1)) {
>               timeout = ps2_adjust_timeout(ps2dev, command, timeout);
>               wait_event_timeout(ps2dev->wait,
>                         !(smp_load_acquire(&ps2dev->flags) &
> PS2_FLAG_CMD), timeout);
> }
>
> if (param)
>     for (i = 0; i < receive; i++)
>               param[i] = ps2dev->cmdbuf[(receive - 1) - i];
>
>
> Here are two moments I don't understand:
> 1. The last parameter of ps2_adjust_timeout is timeout in jiffies (it
> is compared against 100ms). However, timeout is assigned to result of
> wait_event_timeout, which returns 0 or 1. This does not make sense to
> me. What am I missing?

The fact that wait_event_timeout can return value greater than one:

 * Returns:
 * 0 if the @condition evaluated to %false after the @timeout elapsed,
 * 1 if the @condition evaluated to %true after the @timeout elapsed,
 * or the remaining jiffies (at least 1) if the @condition evaluated
              ^^^^^^^^^^^^^^^^^^^^^^^^^

> 2. This code pays great attention to timeouts, but in the end I don't
> see how it handles timeouts. That is, if a timeout is happened, we
> still copyout (garbage) from cmdbuf. What am I missing here?

Once upon a time wait_event() did not return positive value when
timeout expired and then condition satisfied. So we just examine the
final state (psmpouse->cmdcnt should be 0 if command actually
succeeded) and even if we copy in garbage nobody should care since
we'll return error in this case.

Thanks.

-- 
Dmitry
