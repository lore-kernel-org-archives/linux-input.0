From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: New Alps protocol in the wild?
Date: Fri, 27 Jul 2012 11:52:52 -0500
Message-ID: <20120727165252.GC13122@thinkpad-t410>
References: <87vch9w51w.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:42504 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664Ab2G0Qw5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Jul 2012 12:52:57 -0400
Content-Disposition: inline
In-Reply-To: <87vch9w51w.fsf@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Gamari <bgamari.foss@gmail.com>
Cc: linux-input@vger.kernel.org, Andrew Skalski <askalski@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Vojtech Pavlik <vojtech@suse.cz>, Peter Osterlund <pekero2@telia.com>, Laura Dietz <dietz@cs.umass.edu>

On Fri, Jul 27, 2012 at 12:18:51PM -0400, Ben Gamari wrote:
> Recently I took shipment of a Dell Latitude E6430 (supposedly
> "certified" by Canonical). Sadly, out of the box the multitouch-capable
> Alps Dualpoint mouse is detected as a generic PS/2 device (bug filed
> here[1]). After a bit of poking around I figured out the signature
> ({0x73, 0x03, 0x0a}) and command_mode_resp (0x1d) of the device.
> 
> Based on the other recent Dell models listed in alps_model_data, I tried
> configuring the device as a protocol v3 device. While in appearance the
> driver succeeded in configuring the device, it was clear that it was
> still operating in bare PS/2 mode (only bare PS/2 reports were received
> and 0x04 register was read to be 0x00 --- assuming the register read
> command is correct).  This is supported by Seth's alps-reg-dump tool[2],
> which declares that the device is "Not a v3 ALPS touchpad".  Trying to
> configure the device with protocol v4 resulted in the driver to fail
> during configuration (failing to enter absolute mode).  Given this
> evidence, it seems fairly clear that this device differs appreciably
> from any device currently supported by alps.c.

That's likely. It's known that there's at least one ALPS protocol
version that isn't supported.

> I've tried to collect PS/2 traces from a Windows 7 installation running
> under a patched Qemu[3]. Unfortunately, while Windows running on bare
> hardware configures the device perfectly, an installation from the same
> media seems to treat the device as a bare PS/2 device when running under
> virtualization. The PS/2 trace produced clearly shows the driver probing
> the device as an Intellimouse and failing that falls back to generic
> PS/2 reports. Can anyone think of what might have changed between the bare
> metal and the virtualized environment?

I'm thinking that when I was looking at the initialization from Windows
drivers it would first initialize it like a normal PS/2 mouse then later
the ALPS initialization would show up, almost like the default driver
ran through it's initialization first before the ALPS driver did. Did
you look further down in the logs to see if anything similar to the ALPS
initialization is happening later?

Otherwise I don't have any ideas off the top of my head. This approach
generally worked fine with the machines/drivers I worked with.

> I would love to take a stab at reversing this protocol variant, but
> the inability to get a trace from a virtualized working configuration is
> a real blocker. I suppose I could try writing a Windows filter driver
> but the virtualization approach seems orders of magnitude more
> convenient. Any ideas would be greatly appreciated.
> 
> As a final note, I have read various places that ALPS had intended on
> releasing a closed source driver for some of their devices. Has anything
> happened on this front? Perhaps it would be easier to get a trace from a
> closed-source driver running on Linux than a closed-source driver
> running on Windows.

I've heard that such a driver exists, but I don't know where you can get
it. I _think_ some factory preinstalled Linux systems might ship with
it, so it's possible that it's something ALPS provides to its customers
but doesn't make publicly available.

Cheers,
Seth

