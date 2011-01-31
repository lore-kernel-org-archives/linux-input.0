From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: Elo TouchSystems touchscreen support? (04e7:0022)
Date: Mon, 31 Jan 2011 22:28:42 +0100
Message-ID: <20110131212842.GB1603@polaris.bitmath.org>
References: <1296485689.7756.9.camel@novo.hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out12.han.skanova.net ([195.67.226.212]:34070 "EHLO
	smtp-out12.han.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753949Ab1AaV1d (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 31 Jan 2011 16:27:33 -0500
Content-Disposition: inline
In-Reply-To: <1296485689.7756.9.camel@novo.hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org

Hi Bastien,

> Built into my Lenovo A700 all-in-one is a touchscreen. lsusb says:
> $ lsusb | grep -i touch
> Bus 002 Device 006: ID 04e7:0022 Elo TouchSystems

I take it this is a dual-touch device?

> The touchscreen "works", in that tapping it will create a click event,
> though that click event is always in the top left of the screen.

This is quite common for HID multitouch devices without proper driver
support. Sometimes using the HID_MULTI_INPUT quirk helps. Check
usbhid/hid-quirks.c for examples.

> Full output of lsusb -vvv attached.
> 
> Anybody with ideas as to what I'm missing, or whether that particular
> device is supported?

You probably noted already that the 04e7:0020 device is listed in
usbhid. Unless the device claims to be win7 compliant (implying
patching up hid-multitouch), going with the evtouch X driver might get
you a bit on the way. Or - god forbid - the binary blob drivers...

> Using kernel 2.6.38-rc2-git5 (from Fedora rawhide).

The serial elo driver has not been updated since 2007...

Cheers,
Henrik
