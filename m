From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: atmel_mxt_ts maxtouch.cfg firmware ?
Date: Fri, 12 Feb 2016 08:51:17 -0800
Message-ID: <CAB=NE6UWaTv1EN1XPByMucW2Ftv9G9GtOauR9uQTsWb+N8z7wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37416 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751723AbcBLQvj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Feb 2016 11:51:39 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Iiro Valkonen <iiro.valkonen@atmel.com>, Henrik Rydberg <rydberg@bitmath.org>
Cc: Kyle McMartin <kyle@kernel.org>, linux-firmware@kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

I've recently taken up picking up the Chromebook Pixel off the floor
as a brick as I was finally able to replace the stupid BIOS to let me
have a decent development OS on it, while grooming the kernel log on
firmware_class I see this laptop uses the atmel_mxt_ts touch screen
driver and that it looks for the maxtouch.cfg firmware, but doesn't
not seem to fail if it doesn't find it.

The source code seems to also say:

xxd -r -p mXTXXX__APP_VX-X-XX.enc > maxtouch.fw

And that Atmel provides such firmwaere in .enc form. Is this firmware
optional? If so why? If it gives me a few bells and whistles, what are
they ? Can we just put the firmware into the linux-firmware tree? If
not, why not.

Can the firmware be open sourced? If not why not? [0]

  Luis

[0] Please note, I've heard all excuses about firmware not being
opened up, everything is just excuses, I've been able to open source
firmware before even for 802.11 devices which are far more complex
devices, can someone at Atmel just really try asking? The Chromebook
Pixel 2013, given it has no firmware even for 802.11, and you can use
coreboot, is likely one of the few devices in the market that you
might get without oddball proprietary fuzz. Granted if the firmware is
not needed this is moot, but if we can get some enhancements with it
and the firmware be opened why not.

  Luis
