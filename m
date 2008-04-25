From: Sebastian Siewior <al+sa@ml.breakpoint.cc>
Subject: Re: [alsa-devel] [RFC] ucb1400 touchscreen, irq auto probing and
	ac97 with its private field
Date: Fri, 25 Apr 2008 09:46:12 +0200
Message-ID: <20080425074612.GD4460@Chamillionaire.breakpoint.cc>
References: <20080424140459.GB24212@Chamillionaire.breakpoint.cc> <20080424145749.GB22369@sirena.org.uk> <s5hr6cvb5f3.wl%tiwai@suse.de> <20080424185658.GA19029@sirena.org.uk> <s5h8wz24dto.wl%tiwai@suse.de> <Pine.LNX.4.61.0804250906090.7882@tm8103.perex-int.cz> <s5h4p9q4d2e.wl%tiwai@suse.de> <Pine.LNX.4.61.0804250931050.7882@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-input-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:41217 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756580AbYDYHqQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Apr 2008 03:46:16 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0804250931050.7882@tm8103.perex-int.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, dtor@mail.ru, Dmitry Torokhov <dmitry.torokhov@gmail.com>, ALSA development <alsa-devel@alsa-project.org>, linux-input@vger.kernel.org

* Jaroslav Kysela | 2008-04-25 09:35:47 [+0200]:

>On Fri, 25 Apr 2008, Takashi Iwai wrote:
>
>> > Sure. I applied the simple 'void *device_private_data' patch, because 
>> > current usage request is really trivial. We can implement complex code to 
>> > handle data for multiple "extra" devices on AC97 bus later.
>> 
>> Actually, it's not "used" yet.  The ucb1000 reads the data but no one
>> stores yet.  And, if its usage request is trivial, we should use "int
>
>Yes, I hope that the appropriate initialization code will be added to SoC 
>drivers, too.

My driver is OOT right now. The HW isn't final yet and there are no
users (except me and the HW folks). Parts of the driver will certainly
change.

>
>					Jaroslav

Sebastian
