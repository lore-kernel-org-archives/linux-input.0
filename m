From: simon@mungewell.org
Subject: Re: Re: Re: [PATCH] HID: sony: Add force feedback support for
 Dualshock3 USB
Date: Sun, 17 Nov 2013 20:21:04 -0500
Message-ID: <0d5dd16c7b4799f333fd4b4077e6c75c.squirrel@mungewell.org>
References: <1384021557-24106-1-git-send-email-sven@narfation.org>
    <5434362.OvDlhOjSJd@sven-edge> <8249378.0C4gn7PafG@sven-desktop>
    <2105006.tGLFZqe9L3@sven-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:41595 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752715Ab3KRBVG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Nov 2013 20:21:06 -0500
In-Reply-To: <2105006.tGLFZqe9L3@sven-desktop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sven Eckelmann <sven@narfation.org>
Cc: Antonio Ospite <ospite@studenti.unina.it>, simon@mungewell.org, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Colin Leitner <colin.leitner@gmail.com>


> @Simon: This may also be interesting for you because you've asked for it
> in 8c40cb08b7c44f373c2c533614d70b6a.squirrel@mungewell.org

Yes, very interesting. Builds on top of the other 2 patches.

This seems to work, however something is causing the LEDs to go out once
they have been set. This seems to happen a few seconds after they are set,
but there does not appear too be USB activity (via usbmon).

If 'testrumble' is used then the previously set LEDs come back on.


I note that the LED class directory is based on USB ID and node, which
changes each time the controller is plugged in. This makes assigning LEDs
in game configurations a pain.

>From my point of view a 'fixed UID' (such as a serial number) would be
better, but most controllers don't report these. Any suggestions?

Simon


