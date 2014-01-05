From: simon@mungewell.org
Subject: Re: [PATCH 1/2] HID: sony: Add force feedback for the Dualshock 4
Date: Sat, 4 Jan 2014 20:10:01 -0500
Message-ID: <c6470a2c8d6a5ad2e6d3c023ae49e7ef.squirrel@mungewell.org>
References: <alpine.DEB.2.10.1401031518010.29517@franz-virtual-machine>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:55127 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755152AbaAEBKD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 4 Jan 2014 20:10:03 -0500
In-Reply-To: <alpine.DEB.2.10.1401031518010.29517@franz-virtual-machine>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input@vger.kernel.org

> This patch adds force feedback support for Sony's Dualshock 4 controller.
> It does this by adding a device ID for the new controller and creating a
> new dualshock4_worker function to send data commands formatted for the
> controller.  Unlike the Sixaxis, the Dualshock 4 requires a magnitude
> value for the small motor so the actual value is now sent to the worker
> function and the sixaxis worker was modified to clamp it to 1 or 0 as
> required.

I was able to build this and the LED patch against the 3.13rc6 kernel
having first applied this sequence of patches:
https://patchwork.kernel.org/patch/3203761/

However I am seeing some weird behaviour in whether FF/LED actually
functions. It seems that in a 'complete' kernel installation the driver
does not present FF or LED.

But if I use a stock 3.13rc6 kernel, load the 'hid-sony' module from that
and then remove and install the patched one it does work.
--
$ sudo modprobe hid-sony (stock)
$ sudo rmmod hid-sony
$ sudo insmod hid-sony.ko (patched)
--

Not sure what this means, lsmod looks to be the same in both. Perhaps
there is something which is only initialised in the stock version.

Willing to test if anyone has suggestions/comments. I am testing with the
DS4 connected with USB (not BT).
--
Jan  4 17:55:14 simon-virtual-machine kernel: [  138.964626] usb 1-1: new
full-speed USB device number 3 using ohci-pci
Jan  4 17:55:14 simon-virtual-machine mtp-probe: checking bus 1, device 3:
"/sys/devices/pci0000:00/0000:00:06.0/usb1/1-1"
Jan  4 17:55:14 simon-virtual-machine mtp-probe: bus: 1, device: 3 was not
an MTP device
Jan  4 17:55:14 simon-virtual-machine kernel: [  139.416656] usb 1-1: New
USB device found, idVendor=054c, idProduct=05c4
Jan  4 17:55:14 simon-virtual-machine kernel: [  139.416661] usb 1-1: New
USB device strings: Mfr=1, Product=2, SerialNumber=0
Jan  4 17:55:14 simon-virtual-machine kernel: [  139.416663] usb 1-1:
Product: Wireless Controller
Jan  4 17:55:14 simon-virtual-machine kernel: [  139.416665] usb 1-1:
Manufacturer: Sony Computer Entertainment
Jan  4 17:55:14 simon-virtual-machine kernel: [  139.517356] input: Sony
Computer Entertainment Wireless Controller as
/devices/pci0000:00/0000:00:06.0/usb1/1-1/1-1:1.0/input/input6
Jan  4 17:55:14 simon-virtual-machine kernel: [  139.518359] hid-generic
0003:054C:05C4.0002: input,hidraw0: USB HID v1.11 Gamepad [Sony Computer
Entertainment Wireless Controller] on usb-0000:00:06.0-1/input0
--
simon@simon-virtual-machine:~$ ls /sys/class/leds/
simon@simon-virtual-machine:~$
--

Cheers,
Simon

