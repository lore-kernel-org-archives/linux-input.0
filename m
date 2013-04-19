From: Ray Dillinger <bear@sonic.net>
Subject: Corsair k90 keyboard
Date: Fri, 19 Apr 2013 01:13:35 -0700
Message-ID: <5170FCAF.9030506@sonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from a.mail.sonic.net ([64.142.16.245]:49257 "EHLO a.mail.sonic.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757667Ab3DSIlq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Apr 2013 04:41:46 -0400
Received: from [192.168.1.2] (173-228-13-4.dsl.static.sonic.net [173.228.13.4])
	(authenticated bits=0)
	by a.mail.sonic.net (8.13.8.Beta0-Sonic/8.13.7) with ESMTP id r3J8DZjQ015852
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <linux-input@vger.kernel.org>; Fri, 19 Apr 2013 01:13:36 -0700
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Does Corsair cooperate with us when we need technical specs?

I have a Corsair K90 gaming keyboard.  The "standard" keys work,
but the macro keys (there are twelve), the macro record button,
the mode switch button, and the winkey lockout button do not
work.  The LED status light for caps lock works, but the numlock,
scroll lock, macro recording, and mode lock lights do not work.

The keyboard backlighting works, but I can't set the backlighting
light level to either of the other two brightness levels.  As a result
I'm not entirely sure which brightness level it's on now.

Most of the multimedia keys work, but the volume adjustment wheel
doesn't work.

It has two USB connectors and appears to register itself as three
USB devices.  One of these devices is recognized as a keyboard by
the current linux driver.

Three of the macro keys appear to report using the same USB ID as
the (recognized) keyboard, albeit with scan codes not known to the
driver.  They can be I/O mapped using codes from showkey. All
twelve, as well as the winkey lockout and macro-record button,
appear to send signals on the second of the three USB channels.

The third channel is probably supposed to appear as a USB-drive
interface, but it's unrecognized by anything on my system at this
time. I'm betting it appears as a memory device under some
circumstance because the keyboard has 360k of flash memory
for macro storage and the windows driver Corsair provides claims
to be able to load and unload macro profiles to the hard drive.

I want to write a driver (or tweek the driver) to handle this keyboard;
mechanically it's an excellent keyboard to type on, and the macro
keys they intended for gaming would be very handy in many
applications, not least of which would be in an IDE.

Can we get real technical specs from Corsair, or do I need to experiment
with this thing and risk bricking it?

             Ray Dillinger


