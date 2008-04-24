From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [RFC] ucb1400 touchscreen, irq auto probing and ac97 with its	private field
Date: Thu, 24 Apr 2008 19:56:58 +0100
Message-ID: <20080424185658.GA19029@sirena.org.uk>
References: <20080424140459.GB24212@Chamillionaire.breakpoint.cc> <20080424145749.GB22369@sirena.org.uk> <s5hr6cvb5f3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:3215 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbYDXS5G (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Apr 2008 14:57:06 -0400
Content-Disposition: inline
In-Reply-To: <s5hr6cvb5f3.wl%tiwai@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: dtor@mail.ru, Sebastian Siewior <al+sa@ml.breakpoint.cc>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, alsa-devel@alsa-project.org, linux-input@vger.kernel.org

On Thu, Apr 24, 2008 at 06:09:52PM +0200, Takashi Iwai wrote:

> The problem with void * is that you don't know what it really is.
> Yes, it's exactly the purpose - to be generic.  But, this means that
> the true shape of the tossed data from the ac97 controller driver to
> the platform driver is anonymous, too.

Indeed, but unfortunately if you try to cater for everything that might
need to pass data through you rapidly get a balloning stucture - it's
the same use case as the device_data in struct device (in fact, now that
I think about it it may be best to just do the same thing as the
platform bus does and define accessor macros for getting at this from a
struct snd_ac97).

> > Note that this will also need changes in all the relevant AC97 drivers
> > to support getting the private data from platform/machine definition
> > code to the relevant driver using whatever methods are appropriate for
> > the platform.

> What kind of data are needed be passed?

In the case of the WM97xx driver it currently takes a structure
containing seven function pointers, an interrupt number and a boolean
for managing integration of the touchscreen interface an auxiliary ADCs
with the rest of the system.  It's really not terribly generic and
there's probably more things that could be added if there were use
cases:

/* Machine specific and accelerated touch operations */
struct wm97xx_mach_ops {

        /* accelerated touch readback - coords are transmited on AC97 link */
        int acc_enabled;
        void (*acc_pen_up) (struct wm97xx *);
        int (*acc_pen_down) (struct wm97xx *);
        int (*acc_startup) (struct wm97xx *);
        void (*acc_shutdown) (struct wm97xx *);

        /* interrupt mask control - required for accelerated operation */
        void (*irq_enable) (struct wm97xx *, int enable);

        /* GPIO pin used for accelerated operation */
        int irq_gpio;

        /* pre and post sample - can be used to minimise any analog noise */
        void (*pre_sample) (int);  /* function to run before sampling */
        void (*post_sample) (int);  /* function to run after sampling */
};

