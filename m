From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [linux-pm] [RFC] input: syfs switches for SKE keypad
Date: Wed, 6 Oct 2010 10:18:12 -0700
Message-ID: <201010061018.14714.dmitry.torokhov@gmail.com>
References: <Pine.LNX.4.44L0.1010061214070.2047-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38501 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861Ab0JFRSY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Oct 2010 13:18:24 -0400
Received: by iwn5 with SMTP id 5so9983512iwn.19
        for <linux-input@vger.kernel.org>; Wed, 06 Oct 2010 10:18:23 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1010061214070.2047-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Trilok Soni <tsoni@codeaurora.org>, samu.p.onkalo@nokia.com, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, "linux-pm@lists.osdl.org" <linux-pm@lists.osdl.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, ext Sundar R IYER <sundar.iyer@stericsson.com>

On Wednesday, October 06, 2010 09:19:13 am Alan Stern wrote:
> On Wed, 6 Oct 2010, Dmitry Torokhov wrote:
> > > I think this can be solved with pm_runtime, isn't it? Though I am not
> > > expert at pm_runtime, but this framework can be explored to enable
> > > these features.
> > 
> > I think last time Rafael mentioned that runtime PM did not allow for
> > forcing power state from userspace but I wonder if it would be possible
> > for userspace to signal and "accelerate" the idle state for a device and
> > then standard runtime PM framework would kick in...
> 
> Yes; drivers can implement their runtime power policy any way they
> want.  For example, a driver could create a sysfs attribute file which
> userspace could use to ask for changes in the power state.
> 
> The real question is whether the driver is platform-specific.  If it is
> then fine, it can do whatever it wants.  If it isn't then it should
> try to avoid doing things that are tied to a specific platform.
>

No, I really think it is wrong. This what leads us to the situation we
are in at the moment. Every device [re]implements  its own little knobs
to do power management. Accelerometers export their (often tailored to a
specific platform) attributes in sysfs in nonstandard way. And so on,
and so forth.

Here I'd like to see these (PM) hooks done on device core level, i.e.
the knobs should be unified and live in /sys/devices/.../deviceX/power/

Thanks.

-- 
Dmitry
