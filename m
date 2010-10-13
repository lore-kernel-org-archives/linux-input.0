From: "Rick L. Vinyard, Jr." <rvinyard@cs.nmsu.edu>
Subject: How to approach a USB HID device with a specialized interface???
Date: Wed, 13 Oct 2010 09:41:05 -0600
Message-ID: <8875c50ab92da6095e09d2022b1041a0.squirrel@intranet.cs.nmsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [128.123.64.3] ([128.123.64.3]:40077 "EHLO mail.cs.nmsu.edu"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751298Ab0JMQFQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Oct 2010 12:05:16 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux Input <linux-input@vger.kernel.org>, Linux USB <linux-usb@vger.kernel.org>

Hello,

I've been playing around with the Ergodex DX1 keypad and am trying to
figure out how to approach the driver.

It has two USB interfaces.

Interface 1:
 - A pure USB HID keyboard interface
 - No problems with the stock usbkbd driver

Interface 2:
 - Vendor specific interface
 - Programs keys with keycodes emitted on interface 1
 - Controls two LEDS
 - Emits events when an unmapped key is pressed
 - Sets/clears device test mode

I've tested the device using libusb to program the keys and control the
LEDS. But, I think there are several advantages to a driver:
 - Supporting the EVIOCGKEYCODE and EVIOCSKEYCODE ioctls
 - Handling suspend/resumes properly
 - Creating LED class devices
 - Emitting MSC_SCAN events on unmapped keys

I've been digging through drivers/hid and drivers/usb/keyboard looking for
examples of how to pick up a specific interface and handle it, but I
haven't found one yet.

Any suggestions?


