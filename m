From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] ucb1400 touchscreen,
	irq auto probing and ac97 with its	private field
Date: Thu, 24 Apr 2008 15:57:52 +0100
Message-ID: <20080424145749.GB22369@sirena.org.uk>
References: <20080424140459.GB24212@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20080424140459.GB24212@Chamillionaire.breakpoint.cc>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sebastian Siewior <al+sa@ml.breakpoint.cc>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, dtor@mail.ru, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Apr 24, 2008 at 04:04:59PM +0200, Sebastian Siewior wrote:

> I've sent a RFC to the alsa mailing list [1] about adding an extra field in
> order to pass the IRQ from the AC97 driver to the ucb1400 driver. The
> result was:

> Now I'm curious what solution the people here prefer:
> - adding a private field [1] (my favorite)

As I indicated in reply to your initial RFC any such private field
ought to be a void * in order to allow other information to be passed
through to drivers.

Note that this will also need changes in all the relevant AC97 drivers
to support getting the private data from platform/machine definition
code to the relevant driver using whatever methods are appropriate for
the platform.

> - hacking up the ucb1400 [2] (doesn't solve [3] and needs addition code
>   to solve [4]).

[3] is the issue with the WM97xx touchscreen drivers.  That's currently
solved by exactly this issue - as far as I can see from the patch you
cite you're using OpenFirmware.  In that case isn't modifying the driver
to query OpenFirmware an idiomatic solution anyway (though it still
leaves other platforms in the lurch)?

[4] appears to be be handling of IRQs greater than 32 - ISTR that
autoprobing of IRQs greater than 32 is now handled as a result of a
patch in the past week.

> - something totally different what did not come to my attention yet.

Something that worked for more than just AC97 would be nice - a method
for getting platform data to drivers for devices on buses that are
normally autoprobed.
