From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: PROBLEM: [HP Stream Notebook - 11-d010nr] clickpad malfunctions
 after performing a hardware click
Date: Tue, 9 Dec 2014 08:34:48 +1000
Message-ID: <20141208223448.GA8143@jelly.redhat.com>
References: <CALmnu0aD9ys4+QZ+gtdNe61q23A3e6MPq+DSD-Q+NcJoWksWkQ@mail.gmail.com>
 <CAN+gG=EXmDcuNvifZKqLLTxew9ji2FW3jx7i8ThqozE1cg_e6A@mail.gmail.com>
 <CALmnu0Y+n0qGs4jgC=YGKRbBSyVB5B4s_Oafsmvbk6M=67okuw@mail.gmail.com>
 <CAN+gG=E+8277zg3LLW-eFWZb8bNyU_Umf9M2w6+t7Y3sSkkSFg@mail.gmail.com>
 <CALmnu0bPLi4skqUxvjd9DWrZJysvqX-+nxNHdx5APGsoNZsnKA@mail.gmail.com>
 <CAN+gG=Emz8r=17OpUETpVQyjCMDMX=aNEFFHZo3ivGS=xTZHXA@mail.gmail.com>
 <CALmnu0agW-mN9RON1FT9DCxE9POiwS2Jhj7hXZaW+6escc7OGw@mail.gmail.com>
 <CALmnu0aMX8RuDJFozCwP6GmP11Uep=R6bc0EqPYzBknwpHBmpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:50533 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755352AbaLHW7Y (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Dec 2014 17:59:24 -0500
Content-Disposition: inline
In-Reply-To: <CALmnu0aMX8RuDJFozCwP6GmP11Uep=R6bc0EqPYzBknwpHBmpA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Amordea Whiteoak <amordea@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>

On Mon, Dec 08, 2014 at 02:16:48PM -0500, Amordea Whiteoak wrote:
> While I have the ears of the touchpad gods, there is one more tiny
> issue I'd like to report. This may be simply a configuration issue,
> but I would not know how to fix it.
> 
> The window for double-tapping (tapping the touchpad twice to simulate
> a double-click) is remarkably brief. Let me be clear, double-tapping
> on the touchpad does work, however if you do not get the second tap
> within about a 200ms window after the first, it seems to fail to
> register as a double-click, counting it as two unrelated single
> clicks--this is an uncomfortably short window of opportunity. A
> temporary workaround seems to be triple-tapping which for whatever
> reason allow for a broader window (much closer to a full second) and
> registers as a double-tap, but that just seems to be a happy accident
> and is certainly not an expected feature. Is there any way to broaden
> that window?

look at option MaxDoubleTapTime, see man synaptics. It's been on 180ms for
at least 8 years though, so unless Ubuntu changed the defaults here nothing
should've changed recently. there's always the chance of a bug in the xorg
driver but do try to figure out if that's a Ubuntu issue first please.

Cheers,
   Peter

> 
> I did not have this problem on my previous laptop with Lubuntu
> installed (though it had 14.04 not 14.10--it's no longer operational
> after suffering an unfortunate accident so I can't do comparison
> testing with it any longer).
> 
> I promise this is my last remaining issue with the touchpad. :)
