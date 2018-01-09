From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [RFC PATCH] input: Add disable sysfs entry for every input device
Date: Tue, 9 Jan 2018 12:04:24 +1000
Message-ID: <20180109020424.GC29886@jelly>
References: <1482660296-8432-1-git-send-email-pali.rohar@gmail.com>
 <1483370825.2420.8.camel@hadess.net>
 <201701021809.58943@pali>
 <1483442481.2420.12.camel@hadess.net>
 <60c21c4d-bb81-342a-45e1-7e92313e05d7@gmail.com>
 <1483540655.2420.18.camel@hadess.net>
 <20180102215437.i3x2j6jvxtac4ntt@pali>
 <1514944049.2523.28.camel@hadess.net>
 <20180103093133.u7wszegjk2msxryl@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:51212 "EHLO
        mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758094AbeAICE1 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 8 Jan 2018 21:04:27 -0500
Content-Disposition: inline
In-Reply-To: <20180103093133.u7wszegjk2msxryl@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Chuck Ebbert <cebbert.lkml@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jan 03, 2018 at 10:31:33AM +0100, Pali Rohár wrote:
> On Wednesday 03 January 2018 02:47:29 Bastien Nocera wrote:
> > On Tue, 2018-01-02 at 22:54 +0100, Pali Rohár wrote:
> > > On Wednesday 04 January 2017 15:37:35 Bastien Nocera wrote:
> > > > I don't doubt that the use cases should be catered for, I
> > > > essentially
> > > > did that same work without kernel changes for GNOME. What I doubt
> > > > is
> > > > the fuzzy semantics, the fact that the device is kept opened but no
> > > > data is sent (that's not power saving), that whether users are
> > > > revoked
> > > > or should be revoked isn't clear, and that the goal is basically to
> > > > work around stupid input handling when at the console. When running
> > > > a
> > > > display manager, this is all avoided.
> > > > 
> > > > If this were to go through, then the semantics and behaviour needs
> > > > to
> > > > be better explained, power saving actually made possible, and make
> > > > sure
> > > > that libinput can proxy that state to the users on the console. Or
> > > > an
> > > > ioctl added to the evdev device to disable them.
> > > 
> > > So, do you mean to implement this "disable" action as ioctl for
> > > particular /dev/input/event* device (instead of sysfs entry)?
> > 
> > Yes, so the device can be powered down without the device node being
> > closed and made unavailable. I don't know whether that's something
> > that's already possible for all cases, but there's already
> > opportunistic in a lot of drivers and subsystems.
> > 
> > This opens up a whole new wave of potential problems, but it's a more
> > generally useful mechanism, I would think.
> 
> Ok. How should API for this ioctl looks like? And do you have an idea
> for name of that ioctl?
> 
> Dmitry, what do you think about it? It is acceptable for you?

first: sysfs files are pretty terrible because writing to them requires root
and we don't have the benefit of logind. so for any sysfs toggle expect
a nicely integrated userspace solution to be less than optimal.

besides: 99% of the above is figuring out the policy *when* to disable the
device. disabling it is trivial by just closing the evdev nodes and tbh I
don't think we (in userspace) should care about whether the device is
powered down or now, it should be the default assumption that it is powered
down when not in use.

for the cases where you must keep the device open but you don't want events, 
EVIOCSMASK is likely the best solution. improving the kernel so it powers
down the device when the mask excludes all events (and there are no other
listeners) could be an interesting task.

right now, I really question the need for another ioctl.

Cheers,
   Peter
