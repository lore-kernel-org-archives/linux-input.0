From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] Input: introduce BTN/ABS bits for drums and guitars
Date: Tue, 3 Sep 2013 11:05:29 -0700
Message-ID: <20130903180528.GC25985@core.coreip.homeip.net>
References: <1377537288-19289-1-git-send-email-dh.herrmann@gmail.com>
 <1377537288-19289-2-git-send-email-dh.herrmann@gmail.com>
 <alpine.LNX.2.00.1309021341090.3796@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:65257 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760065Ab3ICSFm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Sep 2013 14:05:42 -0400
Received: by mail-pd0-f176.google.com with SMTP id q10so6307151pdj.35
        for <linux-input@vger.kernel.org>; Tue, 03 Sep 2013 11:05:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1309021341090.3796@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: David Herrmann <dh.herrmann@gmail.com>, linux-input@vger.kernel.org, Nicolas Adenis-Lamarre <nicolas.adenis.lamarre@gmail.com>

On Mon, Sep 02, 2013 at 01:41:57PM +0200, Jiri Kosina wrote:
> On Mon, 26 Aug 2013, David Herrmann wrote:
> 
> > There are a bunch of guitar and drums devices out there that all report
> > similar data. To avoid reporting this as BTN_MISC or ABS_MISC, we
> > allocate some proper namespace for them. Note that most of these devices
> > are toys and we cannot report any sophisticated physics via this API.
> > 
> > I did some google-images research and tried to provide definitions that
> > work with all common devices. That's why I went with 4 toms, 4 cymbals,
> > one bass, one hi-hat. I haven't seen other drums and I doubt that we need
> > any additions to that. Anyway, the naming-scheme is intentionally done in
> > an extensible way.
> > 
> > For guitars, we support 5 frets (normally aligned vertically, compared to
> > the real horizontal layouts), a single strum-bar with up/down directions,
> > an optional fret-board and a whammy-bar.
> > 
> > Most of the devices provide pressure values so I went with ABS_* bits. If
> > we ever support devices which only provide digital input, we have to
> > decide whether to emulate pressure data or add additional BTN_* bits.
> > 
> > If someone is not familiar with these devices, here are two pictures which
> > provide almost all introduced interfaces (or try the given keywords
> > with a google-image search):
> >   Guitar: ("guitar hero world tour guitar")
> >     http://images1.wikia.nocookie.net/__cb20120911023442/applezone/es/images/f/f9/Wii_Guitar.jpg
> >   Drums: ("guitar hero drums")
> >     http://oyster.ignimgs.com/franchises/images/03/55/35526_band-hero-drum-set-hands-on-20090929040735768.jpg
> > 
> > Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> 
> Hi,
> 
> I have reviewed and like the implementation of 2/3 and 3/3, but I of 
> course would like to have Ack from Dmitry for this, so that I could take 
> it through my tree together with the rest of the patchset.
> 
> Dmitry, pretty please?

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

We might want to see how much memory is taken now by ABS structures and
think if we could reduce it somehow...

Thanks.

 
Dmitry
