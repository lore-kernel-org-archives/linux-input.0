From: simon@mungewell.org
Subject: Re: Linux joystick driver bugreport
Date: Mon, 27 Jun 2011 16:01:28 -0400
Message-ID: <563e944385d52f20d80a72176e57d611.squirrel@host171.canaca.com>
References: <20110625011015.6f397f6f@Giskard>
    <20110627193814.GB13829@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:46950 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753274Ab1F0UBd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jun 2011 16:01:33 -0400
In-Reply-To: <20110627193814.GB13829@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pablo Cabrera <binchmod777@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Linux Input <linux-input@vger.kernel.org>

Hi Pablo,

>> For device 0079:0011 DragonRise Inc. arrows buttons are mapped to axes 3
>> and 4.
>> For device 0e8f: 0002 GreenAsia Motion Inc. arrows buttons are mapped
>> to axes 2 and 3

This sounds like the arrows are on a D-Pad and that the D-Pad is described
as a 'HAT' in the HID descriptor, which is like a n-position dial with a
NULL state.

I have a Logitech game pad which does the same, the HID descriptor contains
--
Logical Maximum (7),
Physical Maximum (315),
Report Size (4),
Report Count (1),
Unit (Degrees),
Usage (Hat Switch), ; Hat switch (39h, dynamic value)
Input (Variable, Null State),
Unit,
--

Linux converts these '8 buttons' to a 'vector' to the edge of a circle,
hence the two extra axis.

You can use an application from DigiMend
(http://digimend.sourceforge.net/) to read the HID descriptor for your
device.


A possible work around (if you just want the use the joystick to play) is
described here:
http://hans.fugal.net/blog/2007/06/02/joystick-hat-in-x-plane-in-linux/

Cheers (and good luck),
Simon.

