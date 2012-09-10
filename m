From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH] Input: synaptics - Adjust threshold for treating
 position values as negative
Date: Mon, 10 Sep 2012 09:29:10 -0500
Message-ID: <20120910142910.GA17662@thinkpad-t410>
References: <1347281227-20973-1-git-send-email-seth.forshee@canonical.com>
 <CAGS+omA_bX6FEYP1CU7bD6_UUG3dkpyzbHu1iOQhRWpWpT2tuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:58997 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257Ab2IJO3O (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Sep 2012 10:29:14 -0400
Content-Disposition: inline
In-Reply-To: <CAGS+omA_bX6FEYP1CU7bD6_UUG3dkpyzbHu1iOQhRWpWpT2tuw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Mon, Sep 10, 2012 at 09:31:52PM +0800, Daniel Kurtz wrote:
> On Mon, Sep 10, 2012 at 8:47 PM, Seth Forshee <seth.forshee@canonical.com>wrote:
> 
> > Commit c039450 (Input: synaptics - handle out of bounds values from the
> > hardware) caused any hardware reported values over 7167 to be treated as
> > a wrapped-around negative value. It turns out that some firmware uses
> > the value 8176 to indicate a finger near the edge of the touchpad whose
> > actual position cannot be determined. This value now gets treated as
> > negative, which can cause pointer jumps and broken edge scrolling on
> > these machines.
> 
> 
> > I only know of one touchpad which reports negative values, and this
> > hardware never reports any value lower than -8 (i.e. 8184). Moving the
> > threshold for treating a value as negative up to 8176 should work fine
> > then for any hardware we currently know about, and since we're dealing
> > with unspecified behavior it's probably the best we can do. The special
> > 8176 value is also likely to result in sudden jumps in position, so
> > let's also clamp this to the maximum speicified value for the axis.
> >
> 
> Would 8176 still be reported if it was near the X/Y_MIN edge but cannot be
> determined?

I've been told 0 is reported in that case.

> If we just report MAX, will that warp the position all the way across the
> pad?

I don't follow. How would this have any impact on the other positions?

The only place where I'd expect to see some sort of impact is
immediately above or to the left of the location where the touchpad
starts reporting this value. Reporting MAX seems more reasonable to me
than reporting 8176, since the adjacent position is almost certainly
nowhere near 8176. An argument could be made for using the bezel limits
instead, which probably would be better for devices conforming to the
published documentation, but then we know that some devices operate
outside of these parameters.

Or we could just go back to reporting 8176 directly, which is what we
were doing before my previous patch.

> If this behavior gets too bizarre, instead of making this "one size fits
> all" solution, is it possible to use some quirks?  I recently added a patch
> that reads the board_id for the synaptics pads - we could use this to
> identify a particular type of pad and handle it appropriately.

That could make sense for the touchpad that reports negative values, as
this appears to be a problem isolated to one or a very small number of
machines.

But I've had reports of multiple machines reporting 8176, two of which
I've confirmed and one of which is almost certainly the same issue.
These are all Asus machines, but different models. There's also a report
on an Acer machine that could be the same thing, but it's far less
certain. The bug reports are coming from a 3.2-based kernel, so I don't
have the board and firmware ids printed in dmesg.

Seth

