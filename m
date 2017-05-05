From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH 5/5] HID: wacom: generic: Refactor generic battery handling
Date: Fri, 5 May 2017 11:24:30 -0700
Message-ID: <CANRwn3R0F=gENZ5Ku7C4hm9awiNDZcbqnD5d2xyAU95Vokv2gw@mail.gmail.com>
References: <20170428162534.3051-1-killertofu@gmail.com> <20170428162534.3051-5-killertofu@gmail.com>
 <CAF8JNh+hK1q-Z5yJMWFUXBu3e7kFvUggyjhAEqaaKnqGMsizSA@mail.gmail.com> <alpine.LSU.2.20.1705051413520.26873@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f181.google.com ([209.85.217.181]:36596 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751194AbdEESYb (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 5 May 2017 14:24:31 -0400
Received: by mail-ua0-f181.google.com with SMTP id p8so10696129uaa.3
        for <linux-input@vger.kernel.org>; Fri, 05 May 2017 11:24:31 -0700 (PDT)
In-Reply-To: <alpine.LSU.2.20.1705051413520.26873@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Ping Cheng <pinglinux@gmail.com>, linux-input <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Fri, May 5, 2017 at 5:15 AM, Jiri Kosina <jikos@kernel.org> wrote:
> On Wed, 3 May 2017, Ping Cheng wrote:
>
>> > Generic battery handling code is spread between the pen and pad codepa=
ths
>> > since battery usages may appear in reports for either. This makes it
>> > difficult to concisely see the logic involved. Since battery data is
>> > not treated like other data (i.e., we report it through the power_supp=
ly
>> > subsystem rather than through the input subsystem), it makes reasonabl=
e
>> > sense to split the functionality out into its own functions.
>> >
>> > This commit has the generic battery handling duplicate the same patter=
n
>> > that is used by the pen, pad, and touch interfaces. A "mapping" functi=
on
>> > is provided to set up the battery, an "event" function is provided to
>> > update the battery data, and a "report" function is provided to notify
>> > the power_supply subsystem after all the data has been read. We look a=
t
>> > the usage itself rather than its collection to determine if one of the
>> > battery functions should handle it. Additionally, we unconditionally
>> > call the "report" function since there is no particularly good way to
>> > know if a report contained a battery usage; 'wacom_notify_battery()'
>> > will filter out any duplicate updates, however.
>> >
>> > Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
>>
>> Reviewed-by: Ping Cheng <ping.cheng@wacom,com> for the whole set.
>
> Do these fix any user-triggerable problems in the real world, or are they
> "nice to have"s?
>
> IOW, I see this currently as 4.13 merge window material, unless you
> convince me otherwise.
>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>

I have no strong objections to a 4.13 target. This is a feature I had
forgotten to complete and much more of a "nice to have" than something
whose omission will cause serious issues. Even without the monitoring,
its not hard the guess the battery may have died if the pen suddenly
stops working ;)

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....
