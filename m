From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [RFC] input: syfs switches for SKE keypad
Date: Wed, 13 Oct 2010 22:26:02 +0200
Message-ID: <201010132226.02933.rjw@sisk.pl>
References: <AANLkTi=ouKDuPgUgLOwfBPhWKM=RCoh8hb0tY3h53i2r@mail.gmail.com> <AANLkTikqNNY=gNC96ZEo5ar+Adw80h=M3_XGe3A--unu@mail.gmail.com> <AANLkTin0cLmmCyWuQS=OyrOVp-wTEmW65PRqR7S_ez4b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:42930 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752641Ab0JMU1C (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Oct 2010 16:27:02 -0400
In-Reply-To: <AANLkTin0cLmmCyWuQS=OyrOVp-wTEmW65PRqR7S_ez4b@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sundar <sunder.svit@gmail.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, "samu.p.onkalo@nokia.com" <samu.p.onkalo@nokia.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, Sundar R IYER <sundar.iyer@stericsson.com>

On Wednesday, October 13, 2010, Sundar wrote:
> On Wed, Oct 13, 2010 at 11:12 PM, Sundar <sunder.svit@gmail.com> wrote:
> > On Wed, Oct 13, 2010 at 11:07 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> >>
> >> Sorry, I don't quite understand your question.  I think it would be
> >> okay to add an interface for userspace to cut short a runtime-suspend
> >> delay, but I don't think anything more is needed.

I'm not 100% sure how that interface is supposed to work.  Can you elaborate
a bit, please?

> > I was just confirming that it is agreed by all that we can definitely wrap
> > this up via the standard PM helpers; through the accelerated suspend
> > if no one has any other reservations.
> >
> 
> And I forgot one more point. Since this switch feature was one of the
> requirements for the Meego framework, wouldnt it be nice if the Meego
> people also put out their opinions on this newer solution?

Yes, it would.

There's a PM track at the Linux Plumbers conference in a few weeks and I think
it would be good to discuss the issue in there.

Thanks,
Rafael
