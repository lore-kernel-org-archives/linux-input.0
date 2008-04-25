From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [alsa-devel] [RFC] ucb1400 touchscreen, irq auto probing and
 ac97 with its private field
Date: Fri, 25 Apr 2008 13:22:11 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0804251315430.7882@tm8103.perex-int.cz>
References: <20080424140459.GB24212@Chamillionaire.breakpoint.cc>
 <20080424145749.GB22369@sirena.org.uk> <s5hr6cvb5f3.wl%tiwai@suse.de>
 <20080424185658.GA19029@sirena.org.uk> <s5h8wz24dto.wl%tiwai@suse.de>
 <Pine.LNX.4.61.0804250906090.7882@tm8103.perex-int.cz> <s5h4p9q4d2e.wl%tiwai@suse.de>
 <Pine.LNX.4.61.0804250931050.7882@tm8103.perex-int.cz> <s5hve26v0aw.wl%tiwai@suse.de>
 <Pine.LNX.4.61.0804251008270.7882@tm8103.perex-int.cz>
 <20080425105429.GA5664@Chamillionaire.breakpoint.cc> <s5habjikx5k.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail1.perex.cz ([212.20.107.53]:59754 "EHLO mail1.perex.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753353AbYDYLWN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Apr 2008 07:22:13 -0400
In-Reply-To: <s5habjikx5k.wl%tiwai@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Sebastian Siewior <al+sa@ml.breakpoint.cc>, Mark Brown <broonie@opensource.wolfsonmicro.com>, dtor@mail.ru, Dmitry Torokhov <dmitry.torokhov@gmail.com>, ALSA development <alsa-devel@alsa-project.org>, linux-input@vger.kernel.org

On Fri, 25 Apr 2008, Takashi Iwai wrote:

> Your driver does _not_ know what type it is because the data isn't
> created by your driver but the controller driver.  And, it's free to
> attach your driver to any controller.

But controller knows which codec (using ID bytes) is attached, thus it can 
fill appropriate information only for this codec. Of course, it will work 
when only one additional device is sharing bus with codec. See:

http://www.nxp.com/pip/UCB1400-02.html

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

