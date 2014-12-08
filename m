From: Amordea Whiteoak <amordea@gmail.com>
Subject: Re: PROBLEM: [HP Stream Notebook - 11-d010nr] clickpad malfunctions
 after performing a hardware click
Date: Mon, 8 Dec 2014 17:50:32 -0500
Message-ID: <CALmnu0b47aPZ+tcZim9bmZS4f3uSpfmQVZrG25BuuV0P-dxViQ@mail.gmail.com>
References: <CALmnu0aD9ys4+QZ+gtdNe61q23A3e6MPq+DSD-Q+NcJoWksWkQ@mail.gmail.com>
	<CAN+gG=EXmDcuNvifZKqLLTxew9ji2FW3jx7i8ThqozE1cg_e6A@mail.gmail.com>
	<CALmnu0Y+n0qGs4jgC=YGKRbBSyVB5B4s_Oafsmvbk6M=67okuw@mail.gmail.com>
	<CAN+gG=E+8277zg3LLW-eFWZb8bNyU_Umf9M2w6+t7Y3sSkkSFg@mail.gmail.com>
	<CALmnu0bPLi4skqUxvjd9DWrZJysvqX-+nxNHdx5APGsoNZsnKA@mail.gmail.com>
	<CAN+gG=Emz8r=17OpUETpVQyjCMDMX=aNEFFHZo3ivGS=xTZHXA@mail.gmail.com>
	<CALmnu0agW-mN9RON1FT9DCxE9POiwS2Jhj7hXZaW+6escc7OGw@mail.gmail.com>
	<CALmnu0aMX8RuDJFozCwP6GmP11Uep=R6bc0EqPYzBknwpHBmpA@mail.gmail.com>
	<20141208223448.GA8143@jelly.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:49357 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755287AbaLHWud (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Dec 2014 17:50:33 -0500
Received: by mail-pa0-f52.google.com with SMTP id eu11so6050274pac.25
        for <linux-input@vger.kernel.org>; Mon, 08 Dec 2014 14:50:33 -0800 (PST)
In-Reply-To: <20141208223448.GA8143@jelly.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>

> look at option MaxDoubleTapTime, see man synaptics. It's been on 180ms for
> at least 8 years though, so unless Ubuntu changed the defaults here nothing
> should've changed recently. there's always the chance of a bug in the xorg
> driver but do try to figure out if that's a Ubuntu issue first please.

I have, in fact, tried this already. And I re-tested it just now to be
sure. I could be wrong about the actual double-tap window duration (it
may very well be even less than 200ms value I quoted but I wouldn't
know how to time it accurately), but whatever it actually is, it is
mightily brief. Too brief for my comfort, and I'm relatively
nimble-fingered on a computer, so I can't imagine an older user
getting by with it too well.

But aye, I will bother Launchpad with it first. Thank you for your
reply, though!

On Mon, Dec 8, 2014 at 5:34 PM, Peter Hutterer <peter.hutterer@who-t.net> wrote:
> On Mon, Dec 08, 2014 at 02:16:48PM -0500, Amordea Whiteoak wrote:
>> While I have the ears of the touchpad gods, there is one more tiny
>> issue I'd like to report. This may be simply a configuration issue,
>> but I would not know how to fix it.
>>
>> The window for double-tapping (tapping the touchpad twice to simulate
>> a double-click) is remarkably brief. Let me be clear, double-tapping
>> on the touchpad does work, however if you do not get the second tap
>> within about a 200ms window after the first, it seems to fail to
>> register as a double-click, counting it as two unrelated single
>> clicks--this is an uncomfortably short window of opportunity. A
>> temporary workaround seems to be triple-tapping which for whatever
>> reason allow for a broader window (much closer to a full second) and
>> registers as a double-tap, but that just seems to be a happy accident
>> and is certainly not an expected feature. Is there any way to broaden
>> that window?
>
> look at option MaxDoubleTapTime, see man synaptics. It's been on 180ms for
> at least 8 years though, so unless Ubuntu changed the defaults here nothing
> should've changed recently. there's always the chance of a bug in the xorg
> driver but do try to figure out if that's a Ubuntu issue first please.
>
> Cheers,
>    Peter
>
>>
>> I did not have this problem on my previous laptop with Lubuntu
>> installed (though it had 14.04 not 14.10--it's no longer operational
>> after suffering an unfortunate accident so I can't do comparison
>> testing with it any longer).
>>
>> I promise this is my last remaining issue with the touchpad. :)
