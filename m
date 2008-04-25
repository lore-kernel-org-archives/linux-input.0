From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [alsa-devel] [RFC] ucb1400 touchscreen, irq auto probing and
 ac97 with its private field
Date: Fri, 25 Apr 2008 09:35:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0804250931050.7882@tm8103.perex-int.cz>
References: <20080424140459.GB24212@Chamillionaire.breakpoint.cc>
 <20080424145749.GB22369@sirena.org.uk> <s5hr6cvb5f3.wl%tiwai@suse.de>
 <20080424185658.GA19029@sirena.org.uk> <s5h8wz24dto.wl%tiwai@suse.de>
 <Pine.LNX.4.61.0804250906090.7882@tm8103.perex-int.cz> <s5h4p9q4d2e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail1.perex.cz ([212.20.107.53]:47118 "EHLO mail1.perex.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758591AbYDYHft (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Apr 2008 03:35:49 -0400
In-Reply-To: <s5h4p9q4d2e.wl%tiwai@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, dtor@mail.ru, Sebastian Siewior <al+sa@ml.breakpoint.cc>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, ALSA development <alsa-devel@alsa-project.org>, linux-input@vger.kernel.org

On Fri, 25 Apr 2008, Takashi Iwai wrote:

> > Sure. I applied the simple 'void *device_private_data' patch, because 
> > current usage request is really trivial. We can implement complex code to 
> > handle data for multiple "extra" devices on AC97 bus later.
> 
> Actually, it's not "used" yet.  The ucb1000 reads the data but no one
> stores yet.  And, if its usage request is trivial, we should use "int

Yes, I hope that the appropriate initialization code will be added to SoC 
drivers, too.

> irq" as in the original patch instead of void data and cast.

But other SoC (or other) drivers might want to pass to extra devices on 
AC97 bus something different or more complex. Mark Brown already noted
that. I would keep it as 'void *'.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

