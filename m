From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH] HID: Wacom: switch Dell canvas into highres mode
Date: Thu, 9 Nov 2017 14:32:23 -0800
Message-ID: <CANRwn3ShBkgwdzUT9Gvky7aUz0J++AKWDDDN9wgeuAQOR3sa2g@mail.gmail.com>
References: <20171103172947.15156-1-benjamin.tissoires@redhat.com>
 <DE35351F-500C-41C5-90E2-18BC2B48A803@gmail.com> <20171106080503.GB9728@mail.corp.redhat.com>
 <nycvar.YFH.7.76.1711091242000.32604@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f179.google.com ([209.85.217.179]:48997 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751225AbdKIWcZ (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 9 Nov 2017 17:32:25 -0500
In-Reply-To: <nycvar.YFH.7.76.1711091242000.32604@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Linux Input <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Thu, Nov 9, 2017 at 3:42 AM, Jiri Kosina <jikos@kernel.org> wrote:
> On Mon, 6 Nov 2017, Benjamin Tissoires wrote:
>
>> > >well, this is not the cleanest way of handling this mode set, but it
>> > >is the less intrusive AFAICT.
>> > >
>> > >I was thinking that we might want to add a new field in struct
>> > >wacom_feature, but then it wouldn't make sense to keep the set mode
>> > >specifics in _wacom_query_tablet_data().
>> > >
>> > >So I am open to any better suggestion, but this one works and the
>> > >impact on other HID generic tablets is null.
>> > >
>> >
>> > Hmm. Agreed that this isn't ideal. I'd like to take a look at the
>> > descriptor, if you wouldn't mind sharing it. The hardware should be
>> > similar to other devices of ours and it might be possible to piggyback
>> > on existing code.
>> >
>>
>> Sure, here it comes in the hid-replay format (and with a recording
>> of a single dot from the pen):
>
> Jason,
>
> any word on the descriptor please, did you have time to analyze it?
>
> Merge window for 4.15 is almost there, so in case you don't want to miss
> it, I'd need your Ack/Nack/Postopne rather quickly.
>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>

I spent some time checking for similar devices and didn't anything
with a descriptor quite like it. That said, there's a good chance that
we'll see something similar in the future...

I'm still not entirely happy with the one-off approach, but I'll but
my stamp of approval on it. We can work out a more generic way to
detect and configure these dual-resolution devices going forward :)

Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....
