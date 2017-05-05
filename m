From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 5/5] HID: wacom: generic: Refactor generic battery
 handling
Date: Fri, 5 May 2017 21:48:04 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1705052146370.26873@cbobk.fhfr.pm>
References: <20170428162534.3051-1-killertofu@gmail.com> <20170428162534.3051-5-killertofu@gmail.com> <CAF8JNh+hK1q-Z5yJMWFUXBu3e7kFvUggyjhAEqaaKnqGMsizSA@mail.gmail.com> <alpine.LSU.2.20.1705051413520.26873@cbobk.fhfr.pm>
 <CANRwn3R0F=gENZ5Ku7C4hm9awiNDZcbqnD5d2xyAU95Vokv2gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60165 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751284AbdEETsG (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 5 May 2017 15:48:06 -0400
In-Reply-To: <CANRwn3R0F=gENZ5Ku7C4hm9awiNDZcbqnD5d2xyAU95Vokv2gw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Ping Cheng <pinglinux@gmail.com>, linux-input <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Fri, 5 May 2017, Jason Gerecke wrote:

> On Fri, May 5, 2017 at 5:15 AM, Jiri Kosina <jikos@kernel.org> wrote:
> > On Wed, 3 May 2017, Ping Cheng wrote:
> >
> >> > Generic battery handling code is spread between the pen and pad codepaths
> >> > since battery usages may appear in reports for either. This makes it
> >> > difficult to concisely see the logic involved. Since battery data is
> >> > not treated like other data (i.e., we report it through the power_supply
> >> > subsystem rather than through the input subsystem), it makes reasonable
> >> > sense to split the functionality out into its own functions.
> >> >
> >> > This commit has the generic battery handling duplicate the same pattern
> >> > that is used by the pen, pad, and touch interfaces. A "mapping" function
> >> > is provided to set up the battery, an "event" function is provided to
> >> > update the battery data, and a "report" function is provided to notify
> >> > the power_supply subsystem after all the data has been read. We look at
> >> > the usage itself rather than its collection to determine if one of the
> >> > battery functions should handle it. Additionally, we unconditionally
> >> > call the "report" function since there is no particularly good way to
> >> > know if a report contained a battery usage; 'wacom_notify_battery()'
> >> > will filter out any duplicate updates, however.
> >> >
> >> > Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> >>
> >> Reviewed-by: Ping Cheng <ping.cheng@wacom,com> for the whole set.

I took the liberty of having maintainer super-powers, and fixed this 
address by replacing comma with dot :)

[ ... snip ... ]
> I have no strong objections to a 4.13 target. This is a feature I had
> forgotten to complete and much more of a "nice to have" than something
> whose omission will cause serious issues. Even without the monitoring,
> its not hard the guess the battery may have died if the pen suddenly
> stops working ;)

Thanks. I've applied this to for-4.13/wacom (not in for-next branch yet -- 
wil be merged after merge window for 4.12 is over).

-- 
Jiri Kosina
SUSE Labs

