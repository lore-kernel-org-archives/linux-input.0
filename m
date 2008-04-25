From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [RFC] ucb1400 touchscreen, irq auto probing and
	ac97 with its private field
Date: Fri, 25 Apr 2008 11:28:31 +0100
Message-ID: <20080425102831.GB22926@rakim.wolfsonmicro.main>
References: <20080424140459.GB24212@Chamillionaire.breakpoint.cc> <20080424145749.GB22369@sirena.org.uk> <s5hr6cvb5f3.wl%tiwai@suse.de> <20080424185658.GA19029@sirena.org.uk> <s5h8wz24dto.wl%tiwai@suse.de> <20080425095107.GA22926@rakim.wolfsonmicro.main> <s5hej8ukzop.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:53764 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755461AbYDYK2d (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Apr 2008 06:28:33 -0400
Content-Disposition: inline
In-Reply-To: <s5hej8ukzop.wl%tiwai@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, dtor@mail.ru, Sebastian Siewior <al+sa@ml.breakpoint.cc>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, perex@perex.cz, alsa-devel@alsa-project.org, linux-input@vger.kernel.org

On Fri, Apr 25, 2008 at 12:15:50PM +0200, Takashi Iwai wrote:

> Now, you want to make it general so that you can use it for other
> purposes -- but what are the other purpose exactly?

In the case of the WM97xx touchscreen driver it is providing information
about non-standard functionality provided by the chips which depends
very strongly on how the chip has been built into the system.  The touch
functionality of the devices can use several multi-function pins on the
device to improve performance, usually in conjunction with
multi-function pins on the SoC.  The driver can also use callback
functions to synchronise touchscreen samples with display updates in
order to minimise electrical interference to the touch panel caused by
activity sending data to the LCD.

This part of the devices is effectively using AC97 as a generic device
access bus rather than using the standard device classes AC97 codecs
normally implement (there is standard AC97 codec functionality in the
devices as well, this is in addition to that).

>                                                       IOW, such data
> must be passed through ac97 struct inevitably?

Well, the wm97xx-ts driver is currently using an alternative method of
getting what it needs but the way it does that leaves something to be
desired.  This comes back to what I was saying about providing a generic
way of getting platform-specific data into devices enumerated via auto
probed buses.
