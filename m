From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [0/2] Jack reporting
Date: Thu, 17 Jul 2008 11:31:12 +0100
Message-ID: <20080717103111.GB15333@sirena.org.uk>
References: <20080703095026.GA652@sirena.org.uk> <20080714151058.GF25448@sirena.org.uk> <s5hlk02148k.wl%tiwai@suse.de> <20080716125053.GA17134@rakim.wolfsonmicro.main> <20080716112939.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:4220 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801AbYGQKbY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Jul 2008 06:31:24 -0400
Content-Disposition: inline
In-Reply-To: <20080716112939.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-input@vger.kernel.org

On Wed, Jul 16, 2008 at 12:36:06PM -0400, Dmitry Torokhov wrote:
> On Wed, Jul 16, 2008 at 01:50:53PM +0100, Mark Brown wrote:

> > As well as detecting the presence of a connected device typical jack
> > detection implementations also support the implementation of at least
> > one button which would require an input device for at least some jacks

> It really depends on what you can do with this button. If it is just a
> simple circuit breaker then it is not really an input device. However
> is you can remap it for different purposes or map a regular key on a
> keybaord to perform this function then I will agree with you. For example

As far as the hardware is concerned it's just a button - if it's visible
to software then there's no fixed function for it and any action taken
will be application/system specific.  There will normally be a side
effect in hardware muting the microphone but that's not intended to be
the main effect.
