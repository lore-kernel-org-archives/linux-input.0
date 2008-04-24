From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] ucb1400 touchscreen,
	irq auto probing and	ac97 with its private field
Date: Thu, 24 Apr 2008 21:04:46 +0100
Message-ID: <20080424200444.GB19029@sirena.org.uk>
References: <20080424140459.GB24212@Chamillionaire.breakpoint.cc>
	<20080424145749.GB22369@sirena.org.uk>
	<20080424153520.GC26452@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20080424153520.GC26452@Chamillionaire.breakpoint.cc>
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

On Thu, Apr 24, 2008 at 05:35:20PM +0200, Sebastian Siewior wrote:
> * Mark Brown | 2008-04-24 15:57:52 [+0100]:
> >On Thu, Apr 24, 2008 at 04:04:59PM +0200, Sebastian Siewior wrote:

> >cite you're using OpenFirmware.  In that case isn't modifying the driver
> >to query OpenFirmware an idiomatic solution anyway (though it still
> >leaves other platforms in the lurch)?

> Not really. I have to parse the whole device tree and pick one single
> value. This isn't done by any other driver as far as I can see and it
> equals a global variable.

There are several PCI device drivers which have OpenFirmware support -
they appear to deal with this using the pci_device_to_OF_node() call
rather than by groveling through the entire OF tree.  I've not looked
much further than that.

In any case, this is a bit of a sidetrack since it doesn't remove the need
for something beyond OpenFirmware given that there's quite a few
architectures that don't use it at all (at least so far).

> >Something that worked for more than just AC97 would be nice - a method
> >for getting platform data to drivers for devices on buses that are
> >normally autoprobed.

> I thing here is a miss understanding. What would be something beside
> ac97? Gimme a real world example plz. According to grep ucb1400 is the

Most of the examples I've encountered come when PCI devices (and other
devices for buses which do autoprobing) are used in embedded systems and
in order to save component costs the SEPROMs normally used to hold
essential device configuration data (such as MAC addresses for ethernet
devices) are not fitted and instead a single configuration source is
used for the system.

When I've seen it this has generally been handled with ifdefed calls
into machine specific code to read from wherever the data should be read
from - many of the OpenFirmware-using PCI devices appear to be doing
basically this.

> driver attached to ac97 bus (well, nothing else matches on ac97_bus_type
> except the sound & codec thing in sound/ which don't need any extra
> parameters).

The WM97xx drivers should appear in the kernel during this merge window,
FWIW.
