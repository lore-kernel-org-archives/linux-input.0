From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH] evdev: flush ABS_* events during EVIOCGABS
Date: Wed, 23 Apr 2014 17:09:02 +1000
Message-ID: <20140423070902.GA18956@yabbi.redhat.com>
References: <1397156944-5991-1-git-send-email-dh.herrmann@gmail.com>
 <20140422041535.GA10735@yabbi.redhat.com>
 <CANq1E4RQtaNNab9PzoBchmx2qqpJ5_PdrZjf2+ZQkq4YTNzXkA@mail.gmail.com>
 <20140423002103.GA6917@yabbi.bne.redhat.com>
 <20140423053849.GA4036@yabbi.redhat.com>
 <20140423054647.GA24854@core.coreip.homeip.net>
 <20140423055528.GA10740@yabbi.redhat.com>
 <20140423060747.GE24854@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:52642 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865AbaDWHJK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Apr 2014 03:09:10 -0400
Content-Disposition: inline
In-Reply-To: <20140423060747.GE24854@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Herrmann <dh.herrmann@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>

On Tue, Apr 22, 2014 at 11:07:47PM -0700, Dmitry Torokhov wrote:
> On Wed, Apr 23, 2014 at 03:55:28PM +1000, Peter Hutterer wrote:
> > On Tue, Apr 22, 2014 at 10:46:47PM -0700, Dmitry Torokhov wrote:
> > > On Wed, Apr 23, 2014 at 03:38:49PM +1000, Peter Hutterer wrote:
> > > > On Wed, Apr 23, 2014 at 10:21:03AM +1000, Peter Hutterer wrote:
> > > > > On Tue, Apr 22, 2014 at 08:21:54AM +0200, David Herrmann wrote:

..

> > > > 
> > > > any comments?
> > > 
> > > Do we really need to optimize the case when we are dropping events?
> > 
> > It happens frequently, to the point where on some laptops you're pretty much
> > guaranteed to get SYN_DROPPED events on resume and sometimes even during
> > normal multi-finger user.
> > 
> > I don't have any measurements on how many events are dropped on average.
> > Could be one or two, could be several buffer sizes, I honestly don't know.
> 
> I think we need to figure this out. The idea is that dropping events
> should be an exception, not a rule.

increase the buffer size for the devices I guess, with some heuristics
maybe. you could dynamically grow the buffer in the kernel, if the buffer
gets full or close to full, grow it.

but really, this is a moving target, eventually you will get the
SYN_DROPPED. if a client sleeps for a second or more, the events from a
second ago are likely useless anyway, so the need for an atomic sync exists
regardless. fwiw, I can live with a atomic sync that clears the client
buffer provided I get the correct state. any optimisation on top of that can
be done afterwards.

Cheers,
   Peter
