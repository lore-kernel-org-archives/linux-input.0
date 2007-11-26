From: Ron <ron@debian.org>
Subject: Re: [Linuxwacom-devel] [PATCH] Use hid blacklist in usbmouse/usbkbd
Date: Tue, 27 Nov 2007 00:34:17 +1030
Message-ID: <20071126140417.GA20041@homer.shelbyville.oz>
References: <1196074688.12642.10.camel@plop> <20071126111328.GA9235@homer.shelbyville.oz> <1196081174.12642.13.camel@plop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ppp121-45-25-139.lns10.adl2.internode.on.net ([121.45.25.139]:33897
	"EHLO homer.shelbyville.oz" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752862AbXKZOD0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Nov 2007 09:03:26 -0500
Content-Disposition: inline
In-Reply-To: <1196081174.12642.13.camel@plop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pascal Terjan <pterjan@mandriva.com>
Cc: linuxwacom-devel@lists.sourceforge.net, linux-input@vger.kernel.org

On Mon, Nov 26, 2007 at 01:46:14PM +0100, Pascal Terjan wrote:
> On lun, 2007-11-26 at 21:43 +1030, Ron wrote:
> > There is a less intrusive way to handle this for any reasonably modern
> > 2.6 kernel...  see the check_driver script in the Debian package.
> 
> Yes this can be workarounded in userspace, but why having a blacklist in
> HID if the individual usbhid drivers still take the device ?

I do agree the other drivers should respect the blacklist, but in the
case of the wacom device, I'm less sure that it should still be in it ...

It was the _only_ answer before we gained the ability to dynamically
rebind devices though.

> And why having a driver to handle a device when a better one exists ?

Internally the device probing doesn't really have any sense of 'better'
at this stage, so the first driver probed that accepts the device will
get it.  The tablet can however work perfectly well with the mouse or
generic evdev driver, so in the _absence_ of a better one, I don't
really see why we should blindly prohibit such degraded operating modes.

(a clear example of the value in that: for the last few weeks we have
not had a working tablet driver for the new XOrg 7.3 ABI -- if the
tablet was not blacklisted, people would still have been able to use
it as a 'mouse-like' device, but right now it's either a useless brick to
them, or they need to hand hack their kernel to remove the blacklisting)

If drivers that support extended features are available, the choice of
which to use really is a policy decision, so it seems appropriate that
this should be under user-space control.  That's what this script does,
it gives the choice of what is 'better' to the local admin without
requiring them to patch/rebuild their kernel to exercise it.

Cheers,
Ron


