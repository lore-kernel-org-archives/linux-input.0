From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: Allow drivers without listeners to remain on the
 bus
Date: Fri, 20 Jul 2012 09:45:38 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1207200944530.21929@pobox.suse.cz>
References: <1342559541-22421-1-git-send-email-dh.herrmann@googlemail.com> <20120717215045.GA562@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52577 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751542Ab2GTHpq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Jul 2012 03:45:46 -0400
In-Reply-To: <20120717215045.GA562@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: David Herrmann <dh.herrmann@googlemail.com>, linux-input@vger.kernel.org

On Tue, 17 Jul 2012, Henrik Rydberg wrote:

> > hid-picolcd and hid-wiimote do not allow any of hidinput, hiddev or hidraw
> > to claim the device but still want to remain on the bus. Hence, if a
> > driver uses the raw_event callback but no listener claimed the device, we
> > still leave it on the bus as the driver probably handles everything by
> > itself.
> > 
> > Under some circumstances (eg., hidinput_connect() fails and raw_event set)
> > a device may not be left on the bus even though it has no listeners. But
> > then if hidinput_connect() fails there are bigger issues than a device
> > that is left unhandled. So we can safely use this heuristic to avoid
> > adding another flag for special devices like hid-picolcd and hid-wiimote.
> > 
> > This also removes the ugly hack from hid-picolcd as this is no longer
> > required.
> > 
> > Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> > ---
> > Hi Jiri
> > 
> > I posted another patchset that introduced HID_CLAIMED_OTHER to avoid this
> > heuristic but Henrik convinced me that this trivial check is the cleaner and
> > less intrusive implementation. If you're interested, the old patchset was here:
> >   http://thread.gmane.org/gmane.linux.kernel.input/25945
> > 
> > Henrik, can you add your signed-off-by as this was your idea?
> 
> Gladly, but I would like to change the wording slightly, since a driver
> with raw_event set is a listener, and we are still bailing out if
> there are no listeners at all. The title is thus misleading.

So could you guys please come up with a revised version of the patch? I 
like the aproach much more than the previous one, so would like to queue 
it for 3.6 merge window.

Thanks,

-- 
Jiri Kosina
SUSE Labs
