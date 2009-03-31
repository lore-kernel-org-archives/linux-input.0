From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: lockdep report at resume
Date: Tue, 31 Mar 2009 10:36:01 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0903311034560.14346@wotan.suse.de>
References: <1234022517.4175.107.camel@johannes.local>  <1237536764.5100.124.camel@johannes.local>  <alpine.LNX.2.00.0903201535470.14346@wotan.suse.de> <1237800572.19647.97.camel@johannes.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59913 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751075AbZCaIgG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Mar 2009 04:36:06 -0400
In-Reply-To: <1237800572.19647.97.camel@johannes.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>

On Mon, 23 Mar 2009, Johannes Berg wrote:

> > > > [20920.458587] =======================================================
> > > > [20920.458944] [ INFO: possible circular locking dependency detected ]
> > > > [20920.459231] 2.6.29-rc3-wl-12787-g17d9115-dirty #38
> > > > [20920.459449] -------------------------------------------------------
> > > > [20920.459736] events/0/9 is trying to acquire lock:
> > > > [20920.459951]  (&dev->mutex){--..}, at: [<ffffffff804be0ac>] input_disconnect_device+0x2c/0xf0
> > > > [20920.460369] 
> > > > [20920.460370] but task is already holding lock:
> > > > [20920.460637]  (&usbhid->reset_work){--..}, at: [<ffffffff8025a933>] run_workqueue+0xb3/0x250
> > > > [20920.461049] 
> > > > [20920.461050] which lock already depends on the new lock.
> > > Ping? I just ran into it again on 2.6.29-rc8-wl-18593-gef1cb6f-dirty.
> > I haven't still fully gone through the whole dependency chain, was quite 
> > overloaded lately, sorry.
> > 
> > There is a patch from Oliver Neukum, that fixes workqueue usage semantics 
> > around hid_reset() on [1], could you please check whether it also fixes 
> > the report you are seeing? Thanks.
> > [1] http://lkml.org/lkml/2009/3/18/39
> That patch doesn't even apply against a current tree.

I wasn't able to reproduce this report on my test systems; did you use 
only Linus' current tree, or did it have any other trees pulled in? (I am 
referring to the -wl- in the version string).

Could you please send me your config?

-- 
Jiri Kosina
SUSE Labs
