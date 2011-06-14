From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [RFC 00/12] Nintendo Wii Remote Device Driver
Date: Wed, 15 Jun 2011 01:45:45 +0200
Message-ID: <1308095157-4699-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36667 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370Ab1FNXqO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jun 2011 19:46:14 -0400
Received: by fxm17 with SMTP id 17so41764fxm.19
        for <linux-input@vger.kernel.org>; Tue, 14 Jun 2011 16:46:13 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, padovan@profusion.mobi, dh.herrmann@googlemail.com

Hi

I currently work on an HID driver for the Nintendo Wii Remote as Bluez GSoC
project. Following, the basic driver implementation with wiimote button-input
and led support.

The Wii Remote (further wiimote) is a small wireless device that communicates
with the host via bluetooth. It uses the HID ports but does not provide any
proper HID descriptor sets and doesn't really fit into the HID class so a
special driver is needed to control the device.

Wiimote device:
 http://en.wikipedia.org/wiki/Wiimote

Bluetooth details and reverse-engineered protocol:
 https://github.com/dvdhrm/xwiimote/blob/master/doc/PROTOCOL

Protocol details (reverse engineered):
 http://wiibrew.org/wiki/Wiimote


Since the protocol used by the wiimote is fairly complex and does not work
well with HIDINPUT, I tried to copy the hidraw driver. I need to send complex
initialization sequences and memory writes to the wiimote which do not fit
into the "struct input_event" and thus cannot be fed to the basic output_report
function.
Instead I use the same function that HIDRAW uses to insert raw hid commands.
However, this function is unbuffered so I added an own buffer to the driver.

This patchset includes basic input-button parsing and provides the information
via evdev and also provides LED support which can be set via:
 echo [1/0] >/sys/bus/hid/devices/<dev>/led1 or led2, led3, led4

My tree is available at (based on jikos/master):
 https://github.com/dvdhrm/xwiimote_kernel
It gets rebased on jikos/master regularily.

Userspace tools/documentation are available at:
 https://github.com/dvdhrm/xwiimote

This is still a work in progress. Any comments are appreciated. My tree already
includes further peripheral support for the wiimote like IR-cam and accelerometer,
however, these peripherals get fairly complex in initialization sequences and
other stuff, so I excluded them from this first patchset.

Any comments are appreciated.
Kind regards

David
