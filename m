From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [RFC] input: syfs switches for SKE keypad
Date: Thu, 14 Oct 2010 21:00:58 +0200
Message-ID: <201010142100.58496.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1010140946030.1645-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:46701 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755019Ab0JNTBz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Oct 2010 15:01:55 -0400
In-Reply-To: <Pine.LNX.4.44L0.1010140946030.1645-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Sundar <sunder.svit@gmail.com>, linux-pm@lists.linux-foundation.org, "samu.p.onkalo@nokia.com" <samu.p.onkalo@nokia.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, Sundar R IYER <sundar.iyer@stericsson.com>

On Thursday, October 14, 2010, Alan Stern wrote:
> On Wed, 13 Oct 2010, Rafael J. Wysocki wrote:
> 
> > On Wednesday, October 13, 2010, Sundar wrote:
> > > On Wed, Oct 13, 2010 at 11:12 PM, Sundar <sunder.svit@gmail.com> wrote:
> > > > On Wed, Oct 13, 2010 at 11:07 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > > >>
> > > >> Sorry, I don't quite understand your question.  I think it would be
> > > >> okay to add an interface for userspace to cut short a runtime-suspend
> > > >> delay, but I don't think anything more is needed.
> > 
> > I'm not 100% sure how that interface is supposed to work.  Can you elaborate
> > a bit, please?
> 
> There could be a new attribute file, or we could use a blank line
> written to autosuspend_delay_ms for this purpose.  Either way, the
> result would be to call pm_runtime_suspend.  If the device is idle,
> merely awaiting the timer expiration for a scheduled suspend or
> autosuspend, this would cause it to suspend immediately.

That sounds reasonable.

I wonder what the interested people think about it.

Thanks,
Rafael
