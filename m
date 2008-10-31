From: Oliver Neukum <oliver@neukum.org>
Subject: Re: proposal on runtime power management in hid
Date: Sat, 1 Nov 2008 00:59:15 +0100
Message-ID: <200811010059.15989.oliver@neukum.org>
References: <200810301704.01005.oliver@neukum.org> <200810311026.29916.oliver@neukum.org> <d7e40be30810311553s579db3abiea69be2c2f30cf4e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:42668 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769AbYJaX7O (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Oct 2008 19:59:14 -0400
In-Reply-To: <d7e40be30810311553s579db3abiea69be2c2f30cf4e@mail.gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Klein <shacklein@gmail.com>
Cc: linux-input@vger.kernel.org

Am Freitag, 31. Oktober 2008 23:53:59 schrieb Ben Klein:
> 2008/10/31 Oliver Neukum <oliver@neukum.org>
> 
> > Am Freitag, 31. Oktober 2008 00:17:38 schrieb Jiri Kosina:

> > That we already have. That's the simple copout. Do not enable autosuspend
> > if you allow hidraw for a device. However, if normal users shall be able to
> > use
> > the hidraw device that means that autosuspend can never be enabled for the
> > device, as we don't know when someone will use the device.
> >
> So you're saying if a device *can be* opened, autosuspend is not enabled?

No. With the current version of the hid autosuspend patch a system that
allows autosuspend for a device to be used with hidraw is misconfigured.
 
> > For hiddev we can do better, the device is not autosuspended while it is
> > open. This allows allowing ordinary users to use the device. Doing so for
> > hidraw would require to extended the low level hid API. But not as
> > extensively
> > as I suggested.
> >
> > But I consider this to be a lost opportunity.
> > Currently the ll driver must assume that the device is required to be fully
> > operational when it is open. This means different things for ordinary input
> > devices and "raw" devices. Raw devices must not be autosuspended when
> > open at all. Ordinary devices must be able to process input.
> >
>  And now you're saying that hidraw devices should not be autosuspended when
> the device is open ... which is what the other guys are saying too.

True, but it is not all I am saying.

> But that is often overkill. In many situations, for example when a the
> > screen
> > saver is running, you only care that a key has been pressed, not which key.
> > Drivers can save more power if they know this.
> 
> Maybe they can, but this is not the point of hidraw. The point of hidraw is

The question here is how the problem is to be fixed. Should only hidraw
be fixed or a broader fix be made that can be used for input devices?

> that the driver doesn't know/care what type of device it's connected to, and
> that the device is processed by some userspace program/library. That
> userspace system can identify the device and process it correctly, even
> possibly adjust its suspension via sysfs interfaces.

Thereby making a generic interface moot. If you have to find out whether
it is USB you can just use hiddev.
 
> Quote Alan Stern:
> > > Would it make more sense never to autosuspend a device that has an open
> > > hidraw interface?  Then if you want to, you could add an API allowing
> >
> > That is the sane default.
> >
> > > the user to tell the kernel to suspend or to resume (if the existing
> > > sysfs interface isn't sufficient).
> >
> > The existing sysfs interface is clearly not designed for this. It's
> > designed
> > for system administration work. We are talking about ordinary user tasks
> > accessing a generic interface. This leads to the following deficiencies:
> >
> > - the sysfs interface is specific to USB, hidraw is for all HID devices
> > - the sysfs interface operates on physical devices, hidraw on logical
> > devices
> > - the sysfs interface is not designed to be shared among tasks
> > - user space tasks know a device node, not the sysfs directory
> >
> Let me get this straight ... you're complaining that Linux kernel internals
> are not user-friendly? This is why people write userspace libraries that

No, I am saying that they are not useable for certain purposes.

> wrap around kernel interfaces - libjsw for joysticks, libasound for ALSA,
> and if still don't like those there's SDL, or you can write your own.

That means you can no longer operate with only a file descriptor.
No inheritance by fork, exec or passing fds over sockets.
 
> As for the USB-device/HID-device argument, can you autosuspend HID devices
> that aren't USB, such as PS/2 or serial/parallel port keyboards and mice? If
> so, then a generic HID interface for sysfs may be appropriate.

Bluetooth. We are discussing HID, not input devices in a generic sense.

> Note that user space tasks don't have to know just a device node; after all,
> there is HAL.

That won't do. Simply telling a programm to work on a device by name has to
work. Even only a fd should work.

	Regards
		Oliver
