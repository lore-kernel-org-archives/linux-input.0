From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 1/2] Input: ads7846 - allow specifying irq trigger type
 in platform data
Date: Tue, 29 Jun 2010 09:24:20 +0200
Message-ID: <20100629092420.0f432622@wker>
References: <1272630181-5364-1-git-send-email-agust@denx.de>
	<20100531212820.322d5bfd@wker>
	<20100625113534.77524c85@wker>
	<20100628083208.GD25287@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:55005 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363Ab0F2HY2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jun 2010 03:24:28 -0400
In-Reply-To: <20100628083208.GD25287@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Detlev Zundel <dzu@denx.de>

On Mon, 28 Jun 2010 01:32:08 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Fri, Jun 25, 2010 at 11:35:34AM +0200, Anatolij Gustschin wrote:
> > On Mon, 31 May 2010 21:28:20 +0200
> > Anatolij Gustschin <agust@denx.de> wrote:
> > 
> > > Hi Dmitry,
> > > 
> > > On Fri, 30 Apr 2010 14:23:00 +0200
> > > Anatolij Gustschin <agust@denx.de> wrote:
> > > 
> > > > On some platforms, for example with GPIO interrupts
> > > > on mpc5121, it is not possible to configure falling edge
> > > > interrupts.
> > > > 
> > > > Specifying irq trigger type in platform data structure
> > > > allows using ads7846 driver on such platforms.
> > > > 
> > > > Signed-off-by: Anatolij Gustschin <agust@denx.de>
> > > > ---
> > > >  drivers/input/touchscreen/ads7846.c |    5 ++++-
> > > >  include/linux/spi/ads7846.h         |    1 +
> > > >  2 files changed, 5 insertions(+), 1 deletions(-)
> > > 
> > > Any comments on these patches?
> > 
> > Ping? The patches still apply on top of the input.git/next branch.
> > 
> 
> I applied the first one (however changed irq_trigger to be unsigned
> long) however I'd like better changelog for 7845 changes.

Thanks. I'll submit v2 patch for 7845 changes with a better
changelog soon.

Anatolij
