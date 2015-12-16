From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [patch] HID: wacom: bitwise vs logical ORs
Date: Wed, 16 Dec 2015 09:49:56 -0800
Message-ID: <CANRwn3TvwFr85A=dbVTY2gXVdL0y=uw10f1eJBLYWzd3BfNg1Q@mail.gmail.com>
References: <20151209102205.GB3173@mwanda>
	<alpine.LNX.2.00.1512161557060.9922@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1512161557060.9922@cbobk.fhfr.pm>
Sender: kernel-janitors-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Henrik Rydberg <rydberg@bitmath.org>, Linux Input <linux-input@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Dec 16, 2015 at 6:57 AM, Jiri Kosina <jikos@kernel.org> wrote:
> On Wed, 9 Dec 2015, Dan Carpenter wrote:
>
>> Smatch complains that these should probably be bitwise ORs instead o=
f
>> logical.  It doesn't matter for "prox" but it makes a difference for
>> "strip1" and "strip2".
>>
>> Fixes: c7f0522a1ad1 ('HID: wacom: Slim down wacom_intuos_pad process=
ing')
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> Jason, could you please provide your Ack for this one?
>
> It's obviously a Correct Thing To Do(TM), but I assume you've tested =
on
> your devices with this patch, so some other changes might potentially=
 be
> needed to "compensate" for the fix ...
>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>

This patch looks fine to me (the 'prox' calculation /should/ be
logical, but I suppose bitwise works too :D). Found two other bugs
from c7f0522 while reviewing though -- I'll have patches for you
shortly.

Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....
--
To unsubscribe from this list: send the line "unsubscribe kernel-janito=
rs" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
