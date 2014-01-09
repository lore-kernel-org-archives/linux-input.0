From: simon@mungewell.org
Subject: Re: [PATCH 1/2] HID: sony: Add force feedback for the Dualshock 4
Date: Wed, 8 Jan 2014 22:46:36 -0500
Message-ID: <e14a0771e48b8c1d72ee9182eb7d2593.squirrel@mungewell.org>
References: <alpine.DEB.2.10.1401031518010.29517@franz-virtual-machine>
    <c6470a2c8d6a5ad2e6d3c023ae49e7ef.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:44095 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753385AbaAIDqh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Jan 2014 22:46:37 -0500
In-Reply-To: <c6470a2c8d6a5ad2e6d3c023ae49e7ef.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: Frank Praznik <frank.praznik@oh.rr.com>, linux-input@vger.kernel.org


> However I am seeing some weird behaviour in whether FF/LED actually
> functions. It seems that in a 'complete' kernel installation the driver
> does not present FF or LED.
>
> But if I use a stock 3.13rc6 kernel, load the 'hid-sony' module from that
> and then remove and install the patched one it does work.
> --
> $ sudo modprobe hid-sony (stock)
> $ sudo rmmod hid-sony
> $ sudo insmod hid-sony.ko (patched)
> --

I note that using the above modprobe/rmmod/insmod trick the message log
shows additional lines
--
Jan  8 20:12:29 atom kernel: [  144.840112] input: Sony Computer
Entertainment Wireless Controller as
/devices/pci0000:00/0000:00:1d.1/usb3/3-1/3-1:1.0/input/input9
Jan  8 20:12:29 atom kernel: [  144.841044] sony 0003:054C:05C4.0001:
input,hidraw0: USB HID v1.11 Gamepad [Sony Computer Entertainment Wireless
Controller] on usb-0000:00:1d.1-1/input0
Jan  8 20:12:29 atom kernel: [  144.841560] usbcore: registered new
interface driver usbhid
Jan  8 20:12:29 atom kernel: [  144.841563] usbhid: USB HID core driver
--

and the Sony driver is being used
--
root@atom:/sys/bus/usb/devices/3-1:1.0# ls -al 0003\:054C\:05C4.0001/
total 0
drwxr-xr-x 5 root root    0 Jan  8 20:12 .
drwxr-xr-x 7 root root    0 Jan  8 20:12 ..
lrwxrwxrwx 1 root root    0 Jan  8 20:13 driver ->
../../../../../../../bus/hid/drivers/sony
--

Whereas with the fully patched kernel it is not
--
root@atom:/sys/bus/usb/devices/3-1:1.0# ls -al 0003\:054C\:05C4.0001/
total 0
drwxr-xr-x 4 root root    0 Jan  8 20:20 .
drwxr-xr-x 7 root root    0 Jan  8 20:20 ..
lrwxrwxrwx 1 root root    0 Jan  8 20:21 driver ->
../../../../../../../bus/hid/drivers/hid-generic
--


Further more my DS3-SixAxis appears to work OK with the full kernel, where
the DS4 does not.... any suggestions?

Simon

