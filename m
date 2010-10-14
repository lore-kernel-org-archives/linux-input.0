From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [RFC] input: syfs switches for SKE keypad
Date: Thu, 14 Oct 2010 09:50:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010140946030.1645-100000@iolanthe.rowland.org>
References: <201010132226.02933.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:44205 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754869Ab0JNNuJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Oct 2010 09:50:09 -0400
In-Reply-To: <201010132226.02933.rjw@sisk.pl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Sundar <sunder.svit@gmail.com>, linux-pm@lists.linux-foundation.org, "samu.p.onkalo@nokia.com" <samu.p.onkalo@nokia.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, Sundar R IYER <sundar.iyer@stericsson.com>

On Wed, 13 Oct 2010, Rafael J. Wysocki wrote:

> On Wednesday, October 13, 2010, Sundar wrote:
> > On Wed, Oct 13, 2010 at 11:12 PM, Sundar <sunder.svit@gmail.com> wrote:
> > > On Wed, Oct 13, 2010 at 11:07 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > >>
> > >> Sorry, I don't quite understand your question.  I think it would be
> > >> okay to add an interface for userspace to cut short a runtime-suspend
> > >> delay, but I don't think anything more is needed.
> 
> I'm not 100% sure how that interface is supposed to work.  Can you elaborate
> a bit, please?

There could be a new attribute file, or we could use a blank line
written to autosuspend_delay_ms for this purpose.  Either way, the
result would be to call pm_runtime_suspend.  If the device is idle,
merely awaiting the timer expiration for a scheduled suspend or
autosuspend, this would cause it to suspend immediately.

Alan Stern

