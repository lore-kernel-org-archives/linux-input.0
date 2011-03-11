From: Bastien Nocera <hadess@hadess.net>
Subject: Re: which handlers should bind to a device
Date: Fri, 11 Mar 2011 15:39:02 +0000
Message-ID: <1299857944.25856.32.camel@novo.hadess.net>
References: <201103111624.50552.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay2-v.mail.gandi.net ([217.70.178.76]:44862 "EHLO
	relay2-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417Ab1CKPjH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Mar 2011 10:39:07 -0500
In-Reply-To: <201103111624.50552.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-input@vger.kernel.org

On Fri, 2011-03-11 at 16:24 +0100, Oliver Neukum wrote:
> Hi,
> 
> I have a set of USB speakers which also implement HID:
<snip>
> According to the Usage Page the device is not a keyboard, yet the keyboard handler
> binds. Is this really sensible?
> I: Bus=0003 Vendor=0471 Product=0104 Version=0100
> N: Name="Philips Electronics Philips USB Digital Speaker System"
> P: Phys=usb-0000:00:1d.0-1/input2
> S: Sysfs=/devices/pci0000:00/0000:00:1d.0/usb6/6-1/6-1:1.2/input/input15
> U: Uniq=
> H: Handlers=kbd event11 
> B: PROP=0
> B: EV=13
> B: KEY=e000000000000 0
> B: MSC=10

As long as it's not the only thing that binds. We're just missing udev
level information to be able to match the audio device and the sound
device, so that pressing the buttons would change the volume on that
device. See:
https://bugzilla.gnome.org/show_bug.cgi?id=340720

Cheers

