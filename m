From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: Re: [PATCH] [v4]Input: evdev - drop partial events after emptying the buffer
Date: Wed, 13 Jan 2016 20:38:47 +0530
Message-ID: <CADYu308d0pfu=TyciqA_YX2MoF4nu12cOFKR2aEJp0cdszj7wQ@mail.gmail.com>
References: <1451944601-1376-1-git-send-email-a.mathur@samsung.com>
	<20160111041134.GA24860@jelly.redhat.com>
	<CADYu309KOBo0DecJYuWv7T2T9OJhnX0G98CvFWy8OdT60d-W+A@mail.gmail.com>
	<20160112005255.GD7838@jelly.redhat.com>
	<CADYu309BSJZTn_AWapWVFO-C+xifa+rKnVqp5C_UUMksTs-Guw@mail.gmail.com>
	<CAKdAkRSfD6h0PVgBiLtdrD8fJHcHZ5KsoWz1zY9gDxa+NjkYEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:33480 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbcAMPIs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jan 2016 10:08:48 -0500
In-Reply-To: <CAKdAkRSfD6h0PVgBiLtdrD8fJHcHZ5KsoWz1zY9gDxa+NjkYEA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, Aniroop Mathur <a.mathur@samsung.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, David Herrmann <dh.herrmann@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, s.samuel@samsung.com, r.mahale@samsung.com

On Tue, Jan 12, 2016 at 11:23 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Tue, Jan 12, 2016 at 12:09 AM, Aniroop Mathur
> <aniroop.mathur@gmail.com> wrote:
>> On Tue, Jan 12, 2016 at 6:22 AM, Peter Hutterer
>> <peter.hutterer@who-t.net> wrote:
>>> On Mon, Jan 11, 2016 at 07:46:53PM +0530, Aniroop Mathur wrote:
>>>> On Mon, Jan 11, 2016 at 9:41 AM, Peter Hutterer
>>>> <peter.hutterer@who-t.net> wrote:
>>>> > On Tue, Jan 05, 2016 at 03:26:41AM +0530, Aniroop Mathur wrote:
>>>> >> This patch introduces concept to drop partial events in evdev handler
>>>> >> itself after emptying the buffer which are dropped by all evdev
>>>> >> clients in userspace after SYN_DROPPED occurs and this in turn reduces
>>>> >> evdev client reading requests plus saves memory space filled by partial
>>>> >> events in evdev handler buffer.
>>>> >> Also, this patch prevents dropping of full packet by evdev client after
>>>> >> SYN_DROPPED occurs in case last stored event was SYN_REPORT.
>>>> >> (like after clock change request)
>>>> >
>>>> > this patch looks technically correct now, thanks. but tbh, especially after
>>>> > reading the EVIOCGBUFSIZE patch I'm wondering why you need to optimise this
>>>> > path. ignoring events after a SYN_DROPPED is easy in userspace, and you'll
>>>> > need the code to do so anyway because even with your patch, there is no API
>>>> > guarantee that this will always happen - if you rely on it, your code may
>>>> > break on a future kernel.
>>>> >
>>>> > From userland, this patch has no real effect, it only slightly reduces the
>>>> > chance that you get a SYN_DROPPED while reading events after a SYN_DROPPED
>>>> > has already occured. And if that's a problem, fixing the kernel is likely
>>>> > the wrong solution anyway. so yeah, still in doubt about whether this patch
>>>> > provides any real benefit.
>>>> >
>>>>
>>>> Hello Mr. Peter,
>>>>
>>>> I'm sorry that I'm really not able to understand you fully above.
>>>> Please, provide your opinion after seeing below reason of this patch and
>>>> elaborate more on above, if still required.
>>>>
>>>> As you can understand by seeing the patch code, this patch is required for
>>>> three reasons as follows:
>>>>
>>>> 1. To fix bug of dropping full valid packet events by userspace clients in case
>>>> last packet was fully stored and then syn_dropped occurs.
>>>>
>>>> For example:
>>>> Consider kernel buf contains:
>>>> ... SYN_REPORT REL_X, REL_Y, SYN_REPORT <one event space>
>>>> Now consider case that clock type is changed, so these events will be dropped
>>>> and syn_dropped will be queued.
>>>> OR
>>>> consider second case that new first packet event occur and that is stored in
>>>> last event space left, so all stored events will be dropped and syn_dropped
>>>> will be queued + newest event as per current code.
>>>> So now for first case, kernel buf contains: SYN_DROPPED
>>>> and for second case, kernel buf contains: SYN_DROPPED REL_X
>>>> Next consider that full packet is finished storing for both cases and
>>>> user-space is notified that events are ready to be read.
>>>> So now kernel buf contains: SYN_DROPPED REL_X REL_Y SYN_REPORT
>>>> But this new valid full packet event will be ignored by the userspace client
>>>> as mentioned in documentation that userspace clients ignore all events up to
>>>> and including next SYN_REPORT. As you know, this valid full event should not
>>>> be ignored by the userspace. So this patch fixes this bug.
>>>>
>>
>> How about 1st point above? (a bug fix)
>
> OK, I can see that we might want to generate EV_SYN/SYN_REPORT
> immediately after queuing EV_SYN/SYN_DROPPED if last event in the old
> queue that was dropped was EV_SYN/SYN_REPORT. This might be borderline
> useful in case when we switch clock type and then user presses mouse
> button to make sure button press is not ignored.
>
> The rest of the changes I'd drop.
>

Thank you, Mr. Torokhov.
I've sent the v5 which included this fix only.
Title: Input: evdev: fix bug of dropping full valid packet after syn_dropped

BR,
Aniroop Mathur

> Thanks.
>
> --
> Dmitry
