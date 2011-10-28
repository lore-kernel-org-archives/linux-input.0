From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: BUG: hid-multitouch causes 10 second delay and error
Date: Fri, 28 Oct 2011 19:14:52 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1110281913010.3541@pobox.suse.cz>
References: <20111026213705.GA32664@pequod.mess.org> <CAN+gG=E0sUd3WOzAuT1LOTz_U9jLrGg2Bq_jRjha8Dcptk6Zcw@mail.gmail.com> <4EA9466F.4000508@gmail.com> <20111028111605.GA23693@polaris.bitmath.org> <CAN+gG=EiJJR464q_eoJuJYpWOPMsk61W6sAKD18SdT+2tQfmQA@mail.gmail.com>
 <20111028140033.GA2155@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:54085 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752104Ab1J1ROy (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Oct 2011 13:14:54 -0400
In-Reply-To: <20111028140033.GA2155@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Sean Young <sean@mess.org>, linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?ISO-8859-15?Q?St=E9phane_Chatty?= <chatty@enac.fr>

On Fri, 28 Oct 2011, Henrik Rydberg wrote:

> > for-next since nearly a month.
> > I'll let you do the reverts, because on my local trees, it was quite
> > difficult (and I'm still on a 3.0.x, so I can not test against
> > for-next)
> 
> Ok, let's see how Jiri wants to play it, and I can prepare either a
> rewind-and-patch or a revert-and-patch or a keep-and-patch set.

As I have already flushed my initial 3.1 queue to Linus already, I'd like 
to ask you guys to send me a patch based on Linus' tree (or my 
'upstream-fixes' branch, which is what I am going to be sending as fixes 
for 3.2 still).

I will then make sure that it reaches Linus before 3.2 has been released.

> > Please add here the link to
> > http://www.microsoft.com/whdc/device/input/DigitizerDrvs_touch.mspx
> > to keep the origin of this statement: ContactID means multitouch
> 
> Thanks, I will also make sure authorship is preserved where appropriate.

Thanks a lot to both of you, and also an excellent bugreport by Sean.

-- 
Jiri Kosina
SUSE Labs
