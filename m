From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] xpad: Kudos to the reverse-engineering work
Date: Tue, 14 Apr 2015 10:21:12 -0700
Message-ID: <20150414172112.GD29874@dtor-ws>
References: <1428913295-14332-1-git-send-email-mwei@lxde.org>
 <1428913295-14332-2-git-send-email-mwei@lxde.org>
 <20150414171925.GC29874@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:37830 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933003AbbDNRVQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Apr 2015 13:21:16 -0400
Received: by igblo3 with SMTP id lo3so20446077igb.0
        for <linux-input@vger.kernel.org>; Tue, 14 Apr 2015 10:21:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150414171925.GC29874@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ming-ting Yao Wei <mwei@lxde.org>
Cc: linux-input@vger.kernel.org

On Tue, Apr 14, 2015 at 10:19:25AM -0700, Dmitry Torokhov wrote:
> Hi Ming-ting,
> 
> On Mon, Apr 13, 2015 at 04:21:35PM +0800, Ming-ting Yao Wei wrote:
> > This adds credits to the reverse engineering work.
> 
> I squashed this into the previous patch (1/2) and applied.
> 
> Thank you.

Oh, wait, I need your "Signed-off-by", please.

> 
> > 
> > ---
> >  drivers/input/joystick/xpad.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> > index 9b08c47..882b528 100644
> > --- a/drivers/input/joystick/xpad.c
> > +++ b/drivers/input/joystick/xpad.c
> > @@ -10,6 +10,7 @@
> >   *               2006 Adam Buchbinder <adam.buchbinder@gmail.com>
> >   *               2007 Jan Kratochvil <honza@jikos.cz>
> >   *               2010 Christoph Fritz <chf.fritz@googlemail.com>
> > + *               2015 Ming-ting Yao Wei <mwei@lxde.org>
> >   *
> >   * This program is free software; you can redistribute it and/or
> >   * modify it under the terms of the GNU General Public License as
> > @@ -31,6 +32,7 @@
> >   *  - the iForce driver    drivers/char/joystick/iforce.c
> >   *  - the skeleton-driver  drivers/usb/usb-skeleton.c
> >   *  - Xbox 360 information http://www.free60.org/wiki/Gamepad
> > + *  - Xbox One information https://github.com/quantus/xbox-one-controller-protocol
> >   *
> >   * Thanks to:
> >   *  - ITO Takayuki for providing essential xpad information on his website
> > -- 
> > 2.3.2 (Apple Git-55)
> > 
> 
> -- 
> Dmitry

-- 
Dmitry
