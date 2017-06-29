From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Spurious touchpad events with closed LID
Date: Thu, 29 Jun 2017 12:37:39 +0200
Message-ID: <1498732659.6564.8.camel@hadess.net>
References: <201706261854.53970@pali> <20170626170312.GB4965@dtor-ws>
         <201706262109.42628@pali> <20170628201530.GB18101@amd>
         <1498689867.6564.6.camel@hadess.net> <20170629073102.GG25196@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:47483 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751595AbdF2Khn (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 29 Jun 2017 06:37:43 -0400
In-Reply-To: <20170629073102.GG25196@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Thu, 2017-06-29 at 09:31 +0200, Pali Rohár wrote:
> On Thursday 29 June 2017 00:44:27 Bastien Nocera wrote:
> > On Wed, 2017-06-28 at 22:15 +0200, Pavel Machek wrote:
> > > 
> > 
> > <snip>
> > > While policy normally belongs to userspace, I'd argue this is
> > > workaround for a hardware bug, and in-kernel solution would be
> > > acceptable.
> > > 
> > > Anyway, disable attribute would be nice first step.
> > 
> > It's already fixed for those of us on recent distributions. The
> > "ID_INPUT_TOUCHPAD_INTEGRATION=internal" touchpads will be disabled
> > when the lid is closed, when libinput is used to process the
> > events.
> 
> But this does not fix other usage of /dev/input/* and also does not
> fix
> pressing spurious keys in linux virtual tty (ctrl+alt+f1). So it is
> not
> a fix.
> 
> Also important question is: How you detect which input device is
> "internal", non-removable part of notebook and which one is external?

We have heuristics and a database. Look at the hwdb/ subdirectory in
systemd.

> Maybe ACPI/DSDT provides some information? (No idea, just asking)

It could and should, but it's usually empty because when some hardware
makers can't be bothered to change the device's name, they'll hardly
spend that time adding location information, are they?
