From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [0/2] Jack reporting
Date: Sun, 20 Jul 2008 13:17:48 +0100
Message-ID: <20080720121745.GA27546@sirena.org.uk>
References: <20080703095026.GA652@sirena.org.uk> <20080714151058.GF25448@sirena.org.uk> <s5hlk02148k.wl%tiwai@suse.de> <20080716125053.GA17134@rakim.wolfsonmicro.main> <20080716112939.ZZRA012@mailhub.coreip.homeip.net> <20080717103111.GB15333@sirena.org.uk> <20080720052320.GB7853@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:2672 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626AbYGTMRv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Jul 2008 08:17:51 -0400
Content-Disposition: inline
In-Reply-To: <20080720052320.GB7853@anvil.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-input@vger.kernel.org

On Sun, Jul 20, 2008 at 01:23:20AM -0400, Dmitry Torokhov wrote:

> I added the switch definition to input.h and it shoudl hit the mainline
> when I ask Linus to pull early next week. 

Excellent, thanks.

Takashi, what's the best way to handle the ALSA bits?  The first patch
doesn't depend on the new switch type so could be applied as-is but the
second (adding the microphone switch type) depends on the input switch
type being added - should I resubmit that when the switch type has been
merged?
