From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] HID: multitouch: report MT_TOOL_PALM for
 non-confident touches
Date: Thu, 10 Aug 2017 23:54:26 -0700
Message-ID: <CAKdAkRRRo-Xz5O7+gVQcAH5=PnEgwhDx4eYvyBZe7Qbves21kg@mail.gmail.com>
References: <20170811004500.13740-1-dmitry.torokhov@gmail.com> <5528ad84-9b42-8826-abb1-1aef06876284@bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f177.google.com ([209.85.217.177]:37179 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752449AbdHKGy2 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 11 Aug 2017 02:54:28 -0400
In-Reply-To: <5528ad84-9b42-8826-abb1-1aef06876284@bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jason Gerecke <killertofu@gmail.com>, Dennis Kempin <denniskempin@google.com>, Andrew de los Reyes <adlr@google.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>

Hi Henrik,

On Thu, Aug 10, 2017 at 11:14 PM, Henrik Rydberg <rydberg@bitmath.org> wrote:
> Hi Dmitry,
>
> On 08/11/2017 02:44 AM, Dmitry Torokhov wrote:
>
>> According to Microsoft specification [1] for Precision Touchpads (and
>> Touchscreens) the devices use "confidence" reports to signal accidental
>> touches, or contacts that are "too large to be a finger". Instead of
>> simply marking contact inactive in this case (which causes issues if
>> contact was originally proper and we lost confidence in it later, as
>> this results in accidental clicks, drags, etc), let's report such
>> contacts as MT_TOOL_PALM and let userspace decide what to do.
>> Additionally, let's report contact size for such touches as maximum
>> allowed for major/minor, which should help userspace that is not yet
>> aware of MT_TOOL_PALM to still perform palm rejection.
>>
>> An additional complication, is that some firmwares do not report
>> non-confident touches as active. To cope with this we delay release of
>> such contact (i.e. if contact was active we first report it as still
>> active MT+TOOL_PALM and then synthesize the release event in a separate
>> frame).
>
> Changing the tool identity to signal the tool property of low confidence
> does not seem quite right to me. Using MT_TOOL_PALM forces a semantic
> distinction between tool identity and touch state, which userland seems
> unprepared for.

The meaning of confidence is literally "contact is too large to be a
finger", so it is not touch state, but really tool identity. We do
allow tool identity to change over time.

The userland either ignores tool type (and then can reject based on
contact size) or, with Peter's changes, can pay attention to
MT_TOOL_PALM. It should work reasonably well for both old and new
userspace.

> The additional kernel state needed to make it work raises
> the question if more considerations will turn up over with time.

The additional state is simply because we have never updated the tool
type on release events and userspace is not expecting it and is likely
to ignore any data in the slot that is accompanied with
ABS_TRACKING_ID == -1. So we synthesize an extra event to have
distinct tool change and release.

There might arise other considerations over time,

>
> Why not add a property event, like BTN_TOOL_PALM, instead? In other words,
> modifying the definition of "active" as you propose, but then use a
> BTN_TOOL_PALM property to signal "s->confidence_state"? It perhaps creates a
> different oddity for applications unaware of palm, but AFAICT, it would not
> complicate the notion of touch state. Or?

Mostly because with BTN_TOOL_PALM we are not able to decide which
contact is turning into palm. Also, other drivers (RMI) use
MT_TOOL_PALM and I would like to report palm state in unified way.

Thanks.

-- 
Dmitry
