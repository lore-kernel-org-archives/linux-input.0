From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [RFC] ucb1400 touchscreen, irq auto probing and ac97 with its	private field
Date: Thu, 24 Apr 2008 16:02:12 +0100
Message-ID: <20080424150211.GC22369@sirena.org.uk>
References: <20080424140459.GB24212@Chamillionaire.breakpoint.cc> <20080424145749.GB22369@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:1495 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758481AbYDXPCR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Apr 2008 11:02:17 -0400
Content-Disposition: inline
In-Reply-To: <20080424145749.GB22369@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Siewior <al+sa@ml.breakpoint.cc>, Jaroslav Kysela <perex@perex.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, dtor@mail.ru, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-

On Thu, Apr 24, 2008 at 03:57:52PM +0100, Mark Brown wrote:

> > - hacking up the ucb1400 [2] (doesn't solve [3] and needs addition code
> >   to solve [4]).

> [3] is the issue with the WM97xx touchscreen drivers.  That's currently
> solved by exactly this issue - as far as I can see from the patch you

The second issue should be method.
