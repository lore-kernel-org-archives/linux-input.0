From: Ben Gamari <bgamari.foss@gmail.com>
Subject: New Alps protocol in the wild?
Date: Fri, 27 Jul 2012 12:18:51 -0400
Message-ID: <87vch9w51w.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:58121 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929Ab2G0QSy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Jul 2012 12:18:54 -0400
Received: by vbbff1 with SMTP id ff1so2865112vbb.19
        for <linux-input@vger.kernel.org>; Fri, 27 Jul 2012 09:18:53 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>, Andrew Skalski <askalski@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Vojtech Pavlik <vojtech@suse.cz>, Peter Osterlund <pekero2@telia.com>
Cc: Laura Dietz <dietz@cs.umass.edu>

Recently I took shipment of a Dell Latitude E6430 (supposedly
"certified" by Canonical). Sadly, out of the box the multitouch-capable
Alps Dualpoint mouse is detected as a generic PS/2 device (bug filed
here[1]). After a bit of poking around I figured out the signature
({0x73, 0x03, 0x0a}) and command_mode_resp (0x1d) of the device.

Based on the other recent Dell models listed in alps_model_data, I tried
configuring the device as a protocol v3 device. While in appearance the
driver succeeded in configuring the device, it was clear that it was
still operating in bare PS/2 mode (only bare PS/2 reports were received
and 0x04 register was read to be 0x00 --- assuming the register read
command is correct).  This is supported by Seth's alps-reg-dump tool[2],
which declares that the device is "Not a v3 ALPS touchpad".  Trying to
configure the device with protocol v4 resulted in the driver to fail
during configuration (failing to enter absolute mode).  Given this
evidence, it seems fairly clear that this device differs appreciably
from any device currently supported by alps.c.

I've tried to collect PS/2 traces from a Windows 7 installation running
under a patched Qemu[3]. Unfortunately, while Windows running on bare
hardware configures the device perfectly, an installation from the same
media seems to treat the device as a bare PS/2 device when running under
virtualization. The PS/2 trace produced clearly shows the driver probing
the device as an Intellimouse and failing that falls back to generic
PS/2 reports. Can anyone think of what might have changed between the bare
metal and the virtualized environment?

I would love to take a stab at reversing this protocol variant, but
the inability to get a trace from a virtualized working configuration is
a real blocker. I suppose I could try writing a Windows filter driver
but the virtualization approach seems orders of magnitude more
convenient. Any ideas would be greatly appreciated.

As a final note, I have read various places that ALPS had intended on
releasing a closed source driver for some of their devices. Has anything
happened on this front? Perhaps it would be easier to get a trace from a
closed-source driver running on Linux than a closed-source driver
running on Windows.

Thanks again.

Cheers,

- Ben


[1] https://bugzilla.kernel.org/show_bug.cgi?id=45201
[2] http://kernel.ubuntu.com/git?p=sforshee/alps-reg-dump.git;a=summary
[3] http://swapspace.forshee.me/2011/11/touchpad-protocol-reverse-engineering.html
