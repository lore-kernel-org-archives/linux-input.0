From: Andrew Deason <adeason@dson.org>
Subject: synaptics_usb trackpoint
Date: Tue, 3 Sep 2013 23:42:34 -0500
Message-ID: <20130903234234.4c56267a8ec32ecec8440a5a@dson.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:48897 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755821Ab3IDEmg (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Sep 2013 00:42:36 -0400
Received: by mail-ie0-f182.google.com with SMTP id aq17so12248904iec.41
        for <linux-input@vger.kernel.org>; Tue, 03 Sep 2013 21:42:35 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I have an ultranav usb keyboard, which is recognized by the
synaptics_usb driver (model SK-8835, FRU 02R0400, USB device 06CB:0009).
When the kernel is built with synaptics_usb support, the device uses the
"advanced" non-HID interface and the trackpoint becomes very difficult
to use, and certainly does not "feel" like other trackpoint devices. I
believe this is due to incorrect interpretation of the data from the
relevant USB device; the module comments indeed indicate that the driver
has not been well tested with pointing sticks.

I want to make some changes to the driver wrt trackpoints, but I wanted
to ask for some feedback on this before I go off down the wrong path.
Jan Steinhoff kindly directed me here. Anyway, details:


Right now, synaptics_usb just sends the raw numbers from the USB
responses as input event relative coordinates after trimming off some
low-order bits (see synusb_report_stick). That is, we get (0x52, 0x42)
from the device, and we report relative movement of around (0x5, 0x4).
But the values we get from the USB device don't seem very much like
coordinates to me. They appear to be readings from the force sensors on
the trackpoint in the x, y, and z directions. From what I have found
when reading about trackpoint devices, these forces do not directly
correspond to relative cursor movement, but are supposed to be
interpreted through a transfer function that translates them to cursor
velocity, which is then to be translated into movements at certain
intervals.

There may be different transfer functions that are possible to use, but
one such transfer function I've found is in the trackpoint 4 engineering
spec [1]. That's where the various settings like 'sensitivity', 'speed',
etc come into play for trackpoint devices where this translation is done
in the hardware. That document doesn't give all of the necessary
constants for generating that specific function, but it gives a general
idea. I've got some code to roughly approximate that curve in an x.org
input driver, and it seems to work pretty well considering that I'm
making some guesses.

But it seems like this translation should occur in the synaptics_usb
driver. Or at least, even if it doesn't, the reported values should not
be reported as REL_X and REL_Y events, since they are not relative
cursor coordinates. The z coordinate still seems like it could just stay
as ABS_PRESSURE, and features like "Press to Select" could be
implemented in a userspace driver. But I personally don't really care
about the z axis at all, since I never use any of the PtS functionality.

Furthermore, I really think there should be a runtime option to switch
the device between "advanced" mode and HID mode. Especially for the
trackpoint, the transfer function is not trivial and its "correctness"
may be subjective. Right now a system without a synaptics_usb-like
driver is better off than Linux, since such a system would use the
generic HID mode, and would be more usable. Maybe even the HID mode
should be the default, and we only switch to 'advanced' mode on request,
if the user wants to change e.g. sensitivity settings or PtS.

So, thoughts? I haven't fiddled with adding anything like this to the
synaptics_usb driver yet, but I was planning on doing that as soon as I
sent this out and didn't hear any objections.


[1] <http://blogs.epfl.ch/icenet/documents/Ykt3Eext.pdf>. A graph of the
transfer function is on page 43, and some of the other relevant
parameters are described on page 24 and 44.

-- 
Andrew Deason
adeason@dson.org
