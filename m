From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: Two regressions on BYT/T ASUS T100TA 4.12-rc: #2 Keyboard no
 longer works
Date: Wed, 7 Jun 2017 19:21:58 +0100
Message-ID: <20170607192158.1eb9db3a@lxorguk.ukuu.org.uk>
References: <20170607162730.48dfc370@lxorguk.ukuu.org.uk>
        <20170607160744.GA8435@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.llwyncelyn.cymru ([82.70.14.225]:43408 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751542AbdFGSWE (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 7 Jun 2017 14:22:04 -0400
In-Reply-To: <20170607160744.GA8435@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, torvalds@linux-foundation.org

On Wed, 7 Jun 2017 18:07:44 +0200
Greg KH <greg@kroah.com> wrote:

> On Wed, Jun 07, 2017 at 04:27:30PM +0100, Alan Cox wrote:
> > Booting 4.12-rc gives you a machine where neither the keyboard or the
> > mouse of the base-station work.
> > 
> > Other USB devices work - including plugging in an external USB keyboard
> > and mouse.
> > 
> > Removing the basestation and replugging it has no effect.
> > 
> > The base station is seen in lsusb.  
> 
> What is the "basestation"?  A USB hub?  Something else?

It's mostly USB. It has a non standard connector that plugs into the
T100TA in tablet form. The non standard connector unfortunately means it
can't be plugged into a standard USB hub to detect.

On unplug it logs the expected

usb-1-3: USB disconnect, device number 14

on reconnect I see

usb 1-3: new full-speed USB device number 16 using xhci_hcd
usb 1-3: New USB device found, idVendor=0b05, idProduct=17e0
usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 1-3: Product: ASUS Base Station(T100)
usb 1-3: Manufacturer: ASUSTek COMPUTER INC.

It's a USB keyboard, touchpad, storage and USB connector for external
device.

The external device connected through it removes and reconnects just fine.

On older kernels it's coupled with a message 

input: ASUSTek COMPUTER INC. ASUS Base Station (T100) as /devices/..... /
input# and binds to a HID Keyboard, HID device and HID mouse as 3 input
devices.

Alan
