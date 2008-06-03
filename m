From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Jack reporting v2
Date: Tue, 3 Jun 2008 16:36:53 +0100
Message-ID: <20080603153652.GA3245@rakim.wolfsonmicro.main>
References: <1212095345928-git-send-email-broonie@opensource.wolfsonmicro.com> <20080603104048.GA17007@rakim.wolfsonmicro.main> <s5h8wxm7ev1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:59643 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752788AbYFCPgz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 3 Jun 2008 11:36:55 -0400
Content-Disposition: inline
In-Reply-To: <s5h8wxm7ev1.wl%tiwai@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Dmitry Torokhov <dtor@insightbb.com>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-input@vger.kernel.org

On Tue, Jun 03, 2008 at 04:49:38PM +0200, Takashi Iwai wrote:

> Yeah, it looks horrible at a first glance, but it's a known workaround
> for reverse selections...

Indeed - that was the main other solution I'd looked at.  It seemed like
too much splatter in the configuration for the drivers but it's about as
good as it looks like it'll get if simply depending on input isn't going
to be OK.

Looking at all this I'm thinking we may as well leave the jack stuff as
a module - it'd at least make the dependency stuff at runtime slightly
easier and if we're going to put in the effort to support all these
mixes of SND and INPUT it's probably as well to remove the runtime
dependency between ALSA and input if jacks aren't actually in use too.

> Also, sound/jack.h should provide empty inline functions for the case 
> CONFIG_SND_JACK=n.  Then you'll be able to reduce ifdefs in the driver
> codes.

Yeah, probably.  Though from that point of view it might be as well to
cut out the SND_JACK middleman...
