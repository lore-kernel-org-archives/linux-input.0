From: Roderick Colenbrander <roderick@gaikai.com>
Subject: Re: [PATCH 4/8] HID: sony: Report DS4 motion sensors through a
 separate device
Date: Fri, 27 Jan 2017 19:19:51 -0800
Message-ID: <CANndSK=fkAx9-QNrqV+sGjuh9hNF=D03JG_CFfPm+huYiMErdQ@mail.gmail.com>
References: <1479938833-26424-1-git-send-email-roderick@gaikai.com>
 <1479938833-26424-5-git-send-email-roderick@gaikai.com> <c7d7015a773b2199ce5187bc1a8939df.squirrel@mungewell.org>
 <CANndSK=vwg6bTL1RCCaFRYQ9aJX_kQ47g-x6jJR_hHrPLnVH+w@mail.gmail.com>
 <alpine.LNX.2.00.1611281452280.29400@cbobk.fhfr.pm> <CANndSKkq4WnXi7Fsm+OT0U1=1uz1ZwMNq_4ZOuuvu-uxEnhuOw@mail.gmail.com>
 <CANndSKno77dbXgop=nvbfL3ABBjB2TrHvV9BfvHTaiM+KiqH4g@mail.gmail.com>
 <20161205094455.GN1280@mail.corp.redhat.com> <alpine.LSU.2.20.1701271449020.25515@cbobk.fhfr.pm>
 <CANndSK=d=D0i2pJJqjpiSWJ9MJVKZOzF8LYF2kPU3sdmcR2Kng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:33455 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbdA1D2P (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 27 Jan 2017 22:28:15 -0500
Received: by mail-oi0-f43.google.com with SMTP id w204so168296564oiw.0
        for <linux-input@vger.kernel.org>; Fri, 27 Jan 2017 19:28:15 -0800 (PST)
In-Reply-To: <CANndSK=d=D0i2pJJqjpiSWJ9MJVKZOzF8LYF2kPU3sdmcR2Kng@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Fri, Jan 27, 2017 at 6:25 PM, Roderick Colenbrander
<roderick@gaikai.com> wrote:
> On Fri, Jan 27, 2017 at 5:50 AM, Jiri Kosina <jikos@kernel.org> wrote:
>>
>> On Mon, 5 Dec 2016, Benjamin Tissoires wrote:
>>
>> > In your case, I think using IIO is just non sense. The accelerometers
>> > found on the DS4 are meant to be used as a stream of data, which is not
>> > what IIO was made for. Plus, if you start exporting accelerometers as
>> > IIO, how will the DE differentiate between the DS4 accelerometer and the
>> > integrated one.
>>
>> Fair enough, after re-reading the whole thing, I agree that IIO is not the
>> best aproach here. So let's just proceed as originally planned.
>>
>> Thanks,
>>
>> --
>> Jiri Kosina
>> SUSE Labs
>>
>
> That's great news :) Do you want me to resend the patches? The series from
> December should still apply though. We may add another 1 or 2 patches later,
> but they will build on top of the ones sent so far.

(resubmit in plain form)

That's great news :) Do you want me to resend the patches? The series from
December should still apply though. We may add another 1 or 2 patches
later, but they will build on top of the ones sent so far.
