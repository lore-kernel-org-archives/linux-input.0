From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [0/2] Jack reporting
Date: Sun, 20 Jul 2008 20:30:17 +0100
Message-ID: <20080720193015.GC6719@sirena.org.uk>
References: <20080703095026.GA652@sirena.org.uk> <20080714151058.GF25448@sirena.org.uk> <s5hlk02148k.wl%tiwai@suse.de> <20080716125053.GA17134@rakim.wolfsonmicro.main> <20080716112939.ZZRA012@mailhub.coreip.homeip.net> <20080717103111.GB15333@sirena.org.uk> <20080720052320.GB7853@anvil.corenet.prv> <20080720121745.GA27546@sirena.org.uk> <s5hzlocd1g1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:2539 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbYGTTa3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Jul 2008 15:30:29 -0400
Content-Disposition: inline
In-Reply-To: <s5hzlocd1g1.wl%tiwai@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Sun, Jul 20, 2008 at 05:23:26PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > Takashi, what's the best way to handle the ALSA bits?  The first patch
> > doesn't depend on the new switch type so could be applied as-is but the
> > second (adding the microphone switch type) depends on the input switch
> > type being added - should I resubmit that when the switch type has been
> > merged?

> Yes, please.  We need also some consensus how to handle these patches
> covering both areas.

OK, I'll add all the bits that apply to my patch queue for you.
Hopefully we shouldn't find too many changes that need to touch both
sides of things.  For those that do hopefully we can do something
similar to what we do with ARM and agree to merge both via one of the
trees.

> BTW, I'll be on vacation for the next week, so the reply will be
> delayed.

Enjoy your holiday!
