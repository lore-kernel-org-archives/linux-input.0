From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: New Alps protocol in the wild?
Date: Mon, 30 Jul 2012 10:43:03 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1207301042290.30412@pobox.suse.cz>
References: <87vch9w51w.fsf@gmail.com> <20120727165252.GC13122@thinkpad-t410> <87zk6lunsf.fsf@gmail.com> <5012E8BE.1080803@dahetral.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55410 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751351Ab2G3InN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Jul 2012 04:43:13 -0400
In-Reply-To: <5012E8BE.1080803@dahetral.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dturvene <dturvene@dahetral.com>
Cc: Ben Gamari <bgamari.foss@gmail.com>, Seth Forshee <seth.forshee@canonical.com>, opensource@dell.com, linux-input@vger.kernel.org, Andrew Skalski <askalski@gmail.com>, Vojtech Pavlik <vojtech@suse.cz>, Peter Osterlund <pekero2@telia.com>, Laura Dietz <dietz@cs.umass.edu>, Dmitry Torokhov <dmitry.torokhov@gmail.com>


[ Dmitry should be CCed on this ... adding him ]

On Fri, 27 Jul 2012, dturvene wrote:

> Coming late the discussion, responses inline - Dave
> 
> On 07/27/2012 01:17 PM, Ben Gamari wrote:
> > Seth Forshee <seth.forshee@canonical.com> writes:
> > 
> > > On Fri, Jul 27, 2012 at 12:18:51PM -0400, Ben Gamari wrote:
> > > > Recently I took shipment of a Dell Latitude E6430 (supposedly
> > > > "certified" by Canonical). Sadly, out of the box the multitouch-capable
> > > > Alps Dualpoint mouse is detected as a generic PS/2 device (bug filed
> > > > here[1]). After a bit of poking around I figured out the signature
> > > > ({0x73, 0x03, 0x0a}) and command_mode_resp (0x1d) of the device.
> > > > 
> > > > Based on the other recent Dell models listed in alps_model_data, I tried
> > > > configuring the device as a protocol v3 device. While in appearance the
> > > > driver succeeded in configuring the device, it was clear that it was
> > > > still operating in bare PS/2 mode (only bare PS/2 reports were received
> > > > and 0x04 register was read to be 0x00 --- assuming the register read
> > > > command is correct).  This is supported by Seth's alps-reg-dump tool[2],
> > > > which declares that the device is "Not a v3 ALPS touchpad".  Trying to
> > > > configure the device with protocol v4 resulted in the driver to fail
> > > > during configuration (failing to enter absolute mode).  Given this
> > > > evidence, it seems fairly clear that this device differs appreciably
> > > > from any device currently supported by alps.c.
> > > That's likely. It's known that there's at least one ALPS protocol
> > > version that isn't supported.
> > > 
> > I suspected that was the case.
> I have a Dell I15R N5110 running Ubuntu 12.04 with the same signature and
> behavior.
> 
> Vbox with sforshee patch running Vista shows only ps/2 packets.  I
> hypothesized that the Vista driver didn't recognize the device either, but
> handled keyboard/touchpad event separation better.
> 
> I wrote a small serio_raw program to test the device.  Alps command mode
> works, but the GETINFO response when entering command mode is: 0x73, 0x01,
> 0x0d, which fails the 0x88, 0x07 check in the alps.c code.  Once in command
> mode, the v3 logic (PSMOUSE_CMD_RESET_WRAP) works and I get the register
> number and value back from PSMOUSE_CMD_GETINFO.  v4 logic returns garbage.
> 
> > > > I've tried to collect PS/2 traces from a Windows 7 installation running
> > > > under a patched Qemu[3]. Unfortunately, while Windows running on bare
> > > > hardware configures the device perfectly, an installation from the same
> > > > media seems to treat the device as a bare PS/2 device when running under
> > > > virtualization. The PS/2 trace produced clearly shows the driver probing
> > > > the device as an Intellimouse and failing that falls back to generic
> > > > PS/2 reports. Can anyone think of what might have changed between the
> > > > bare
> > > > metal and the virtualized environment?
> > > I'm thinking that when I was looking at the initialization from Windows
> > > drivers it would first initialize it like a normal PS/2 mouse then later
> > > the ALPS initialization would show up, almost like the default driver
> > > ran through it's initialization first before the ALPS driver did. Did
> > > you look further down in the logs to see if anything similar to the ALPS
> > > initialization is happening later?
> > > 
> > Sadly no. The driver comes with a configuration tool which when launched
> > appears to trigger a reconfiguration.
> > 
> > > Otherwise I don't have any ideas off the top of my head. This approach
> > > generally worked fine with the machines/drivers I worked with.
> > > 
> > Hmmm, that is truly unfortunate. I guess given this I'll just have to
> > try piecing together a filter driver and collect the initialization
> > process on bare metal. Hopefully at that point I'll be able to do the
> > reversing of the data format over serio.
> Yeah, unfortunate.  I may just use a usb mouse if it comes to that...
> > 
> > > > I would love to take a stab at reversing this protocol variant, but
> > > > the inability to get a trace from a virtualized working configuration is
> > > > a real blocker. I suppose I could try writing a Windows filter driver
> > > > but the virtualization approach seems orders of magnitude more
> > > > convenient. Any ideas would be greatly appreciated.
> > > > 
> > > > As a final note, I have read various places that ALPS had intended on
> > > > releasing a closed source driver for some of their devices. Has anything
> > > > happened on this front? Perhaps it would be easier to get a trace from a
> > > > closed-source driver running on Linux than a closed-source driver
> > > > running on Windows.
> > > I've heard that such a driver exists, but I don't know where you can get
> > > it. I _think_ some factory preinstalled Linux systems might ship with
> > > it, so it's possible that it's something ALPS provides to its customers
> > > but doesn't make publicly available.
> > > 
> > Naturally. I never would have suspected that such a despicable company
> > could be found in making something as innocuous as touchpads. Sheesh.
> > 
> > Given the difficulty of the reverse engineering process and the
> > proliferation of incompatible hardware variants, it seems a major
> > customer really needs to step up and demand some sanity from these
> > people. My understanding is that Dell currently does not have access to
> > Alps specifications but given the volume they move it seems they are in
> > a fairly unique position to exert pressure. Being a Dell partner, has
> > Canonical taken any steps to start this dialogue?
> > 
> > On that note, Canonical's certification certificate for the E6430 is
> > currently incorrect. The desktop program guidelines clearly state that
> > vertical scroll is on the grey list yet, as far as I can tell, the
> > certificate makes no mention of the lacking support of the input
> > hardware of this model.
> 
> My I15R was certified also, and currently incorrect.  I posted a query to Dell
> about Alps support but haven't heard anything back.  I suspect Alps and Dell
> are wary of offending Microsoft.
> 
> > 
> > Cheers,
> > 
> > - Ben

-- 
Jiri Kosina
SUSE Labs
