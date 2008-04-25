From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [RFC] ucb1400 touchscreen, irq auto probing and
	ac97 with its private field
Date: Fri, 25 Apr 2008 10:51:07 +0100
Message-ID: <20080425095107.GA22926@rakim.wolfsonmicro.main>
References: <20080424140459.GB24212@Chamillionaire.breakpoint.cc> <20080424145749.GB22369@sirena.org.uk> <s5hr6cvb5f3.wl%tiwai@suse.de> <20080424185658.GA19029@sirena.org.uk> <s5h8wz24dto.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:43755 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753927AbYDYJvJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Apr 2008 05:51:09 -0400
Content-Disposition: inline
In-Reply-To: <s5h8wz24dto.wl%tiwai@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, dtor@mail.ru, Sebastian Siewior <al+sa@ml.breakpoint.cc>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, perex@perex.cz, alsa-devel@alsa-project.org, linux-input@vger.kernel.org

On Fri, Apr 25, 2008 at 09:02:27AM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > I think about it it may be best to just do the same thing as the
> > platform bus does and define accessor macros for getting at this from a
> > struct snd_ac97).

> Not really as same as device_data.  Normally, device data is handled
> by superseding the base device class (just includes struct device) and
> retrieve the class via container_of() or such.

That's normal usage for getting generic class data, not for obtaining
information specific to a particular driver.

> In this case, however, you don't know exactly whether the given struct
> ac97 is really created by the specific controller, and thus you cannot
> assume that the ac97 can be cast to its specific class.

Right, which is why the device_data pointer is used by things like
platform drivers for getting device-specific (as opposed to class
specific) data into the driver from the machine code.

> For multiple anonymous data, we can use a data with a key like below:

This sounds like a reinvention of OpenFirmware, which presents pretty
much the same sort of key/value interface.  It'd be nice to be able to
share the same client code.

> and the controller driver assigns the data like

Doing this would mean that the controller would need to be modified for
each system that wants to pass configuration data to a driver - at that
point much of the win from providing an interface like this is lost.
