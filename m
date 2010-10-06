From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [RFC] input: syfs switches for SKE keypad
Date: Wed, 6 Oct 2010 12:19:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010061214070.2047-100000@iolanthe.rowland.org>
References: <20101006154331.GA28913@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:49165 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1759339Ab0JFQTO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Oct 2010 12:19:14 -0400
In-Reply-To: <20101006154331.GA28913@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Trilok Soni <tsoni@codeaurora.org>, samu.p.onkalo@nokia.com, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, "linux-pm@lists.osdl.org" <linux-pm@lists.osdl.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, ext Sundar R IYER <sundar.iyer@stericsson.com>

On Wed, 6 Oct 2010, Dmitry Torokhov wrote:

> > I think this can be solved with pm_runtime, isn't it? Though I am not expert
> > at pm_runtime, but this framework can be explored to enable these features.
> 
> I think last time Rafael mentioned that runtime PM did not allow for
> forcing power state from userspace but I wonder if it would be possible
> for userspace to signal and "accelerate" the idle state for a device and
> then standard runtime PM framework would kick in...

Yes; drivers can implement their runtime power policy any way they
want.  For example, a driver could create a sysfs attribute file which
userspace could use to ask for changes in the power state.

The real question is whether the driver is platform-specific.  If it is 
then fine, it can do whatever it wants.  If it isn't then it should 
try to avoid doing things that are tied to a specific platform.

Alan Stern

