From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [alsa-devel] [RFC] ucb1400 touchscreen, irq auto probing and
	ac97 with its private field
Date: Fri, 25 Apr 2008 11:31:03 -0400
Message-ID: <20080425112954.ZZRA012@mailhub.coreip.homeip.net>
References: <20080424140459.GB24212@Chamillionaire.breakpoint.cc> <20080424145749.GB22369@sirena.org.uk> <s5hr6cvb5f3.wl%tiwai@suse.de> <20080424185658.GA19029@sirena.org.uk> <s5h8wz24dto.wl%tiwai@suse.de> <Pine.LNX.4.61.0804250906090.7882@tm8103.perex-int.cz> <s5h4p9q4d2e.wl%tiwai@suse.de> <Pine.LNX.4.61.0804250931050.7882@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.226]:32191 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754372AbYDYPcM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Apr 2008 11:32:12 -0400
Received: by wx-out-0506.google.com with SMTP id h31so3180787wxd.4
        for <linux-input@vger.kernel.org>; Fri, 25 Apr 2008 08:32:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0804250931050.7882@tm8103.perex-int.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sebastian Siewior <al+sa@ml.breakpoint.cc>, ALSA development <alsa-devel@alsa-project.org>, linux-input@vger.kernel.org

On Fri, Apr 25, 2008 at 09:35:47AM +0200, Jaroslav Kysela wrote:
> On Fri, 25 Apr 2008, Takashi Iwai wrote:
> 
> > > Sure. I applied the simple 'void *device_private_data' patch, because 
> > > current usage request is really trivial. We can implement complex code to 
> > > handle data for multiple "extra" devices on AC97 bus later.
> > 
> > Actually, it's not "used" yet.  The ucb1000 reads the data but no one
> > stores yet.  And, if its usage request is trivial, we should use "int
> 
> Yes, I hope that the appropriate initialization code will be added to SoC 
> drivers, too.
> 
> > irq" as in the original patch instead of void data and cast.
> 
> But other SoC (or other) drivers might want to pass to extra devices on 
> AC97 bus something different or more complex. Mark Brown already noted
> that. I would keep it as 'void *'.

Need to pass irq data will be fairly common so we should probably have
it in its own right and allow additional data be attached via a void
*.

-- 
Dmitry
