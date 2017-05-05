From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 5/5] HID: wacom: generic: Refactor generic battery
 handling
Date: Fri, 5 May 2017 14:15:23 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1705051413520.26873@cbobk.fhfr.pm>
References: <20170428162534.3051-1-killertofu@gmail.com> <20170428162534.3051-5-killertofu@gmail.com> <CAF8JNh+hK1q-Z5yJMWFUXBu3e7kFvUggyjhAEqaaKnqGMsizSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45703 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751237AbdEEMPZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 5 May 2017 08:15:25 -0400
In-Reply-To: <CAF8JNh+hK1q-Z5yJMWFUXBu3e7kFvUggyjhAEqaaKnqGMsizSA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Jason Gerecke <killertofu@gmail.com>, linux-input <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Wed, 3 May 2017, Ping Cheng wrote:

> > Generic battery handling code is spread between the pen and pad codepaths
> > since battery usages may appear in reports for either. This makes it
> > difficult to concisely see the logic involved. Since battery data is
> > not treated like other data (i.e., we report it through the power_supply
> > subsystem rather than through the input subsystem), it makes reasonable
> > sense to split the functionality out into its own functions.
> >
> > This commit has the generic battery handling duplicate the same pattern
> > that is used by the pen, pad, and touch interfaces. A "mapping" function
> > is provided to set up the battery, an "event" function is provided to
> > update the battery data, and a "report" function is provided to notify
> > the power_supply subsystem after all the data has been read. We look at
> > the usage itself rather than its collection to determine if one of the
> > battery functions should handle it. Additionally, we unconditionally
> > call the "report" function since there is no particularly good way to
> > know if a report contained a battery usage; 'wacom_notify_battery()'
> > will filter out any duplicate updates, however.
> >
> > Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> 
> Reviewed-by: Ping Cheng <ping.cheng@wacom,com> for the whole set.

Do these fix any user-triggerable problems in the real world, or are they 
"nice to have"s?

IOW, I see this currently as 4.13 merge window material, unless you 
convince me otherwise.

Thanks,

-- 
Jiri Kosina
SUSE Labs

