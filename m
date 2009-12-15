From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: evdev and Trust TB-5300 tablet: wrong axis labels
Date: Tue, 15 Dec 2009 20:32:06 +1000
Message-ID: <20091215103204.GA2144@salty>
References: <200912130058.46220.dan@riga.lv> <200912131825.03872.dan@riga.lv>
	<6a12d2f30912131835taa8086dic17562bb71543a68@mail.gmail.com>
	<200912150106.07482.dan@riga.lv>
	<20091214234652.GB23029@barra.redhat.com>
	<6a12d2f30912142343j7d012bc0x91275c14630f83df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xorg-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <6a12d2f30912142343j7d012bc0x91275c14630f83df@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
To: Matthew Helsley <matt.helsley@gmail.com>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, xorg@lists.freedesktop.org
List-Id: linux-input@vger.kernel.org

On Mon, Dec 14, 2009 at 11:43:21PM -0800, Matthew Helsley wrote:
> > <match key="input.product" contains="U-LOGIC">
> 
> Mine reports "UC-Logic Technology Corp." as the usb.vendor string. My
> "input.product" for that device is exactly "    Tablet PF1209" (space
> included). So the rule would have to check the usb.vendor_id of the
> parent "node".
> 
> For my tablet I chose to be quite specific:
> 
> <match key="info.capabilities" contains="input.touchpad">
> <match key="info.product" contains="Tablet PF1209">
> <match key="/org/freedesktop/Hal/devices/computer:system.kernel.name"
> string="Linux">
> 
> (I chose the last since evdev is a Linux driver and I didn't know
> whether my changes to these .fdi files might eventually be useful on a
> *BSD.)
> 
> >       <merge key="input.x11_driver" type="string">evdev</merge>
> > </match>
> 
> Yes, I've hit this problem and I keep forgetting about it because it's
> hidden in the .fdi files, waiting for whenever my distro "upgrades"
> them. Sorry, Daniil, I completely forgot to mention this problem :(.

the distro fdi files are usually in /usr/share/hal, the user-specific ones
in /etc/hal. hence once you drop your custom fdi into /etc/hal, it'll stay
there and override the distro ones.
 
> <tangent>
> The .fdi file that assigns the synaptic driver to these devices based
> solely on the "input.touchpad" capability seems quite wrong to me. My
> guess is most tablets that rely on evdev will report absolute
> coordinates. If anything, based on their comparably-small physical
> size, I'd expect "touchpads" would report relative coordinates. Plus
> synaptic can't be the only touchpad vendor/whatnot, can it? Why should
> its driver try to claim them all?

> 
> Perhaps it should have it's own match key:
> 
> <match key="info.product" contains="Synaptics TouchPad">
> 
> (which works for my touchpad at least) rather than:
> 
> <match key="info.capabilities" contains="input.touchpad">
> 
> Sorry, I don't know: Who maintains the .fdi files -- the driver
> developer, the distro, or HAL developers? In my distro they're in
> /usr/share/hal/policy and the way its packaged suggests the driver
> developers are responsible.
> 
> Peter am I way off here?

maybe partly. the fdi file is shipped with the synaptics tarballs, though
distros are of course free to create their own. we used to have a similar
match rule but synaptics is just the driver name, the driver supports alps,
appletouch, bcm5974, elantech and synaptics touchpads. that is on linux
anyway - the hardware-specific parts are handled by the kernel.
so the synaptics driver is really more of a generic touchpad driver.

on BSD the evdev backend doesn't come into play so I guess synaptics is
overly eager claiming devices it shouldn't. If you have any suggestions for
improving the fdi, don't hesitate to send in a patch. 
In a separate thread maybe, no need to spam the kernel lists for this.

Cheers,
  Peter
