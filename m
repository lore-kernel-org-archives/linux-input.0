From: simon@mungewell.org
Subject: Re: Re: Re: [PATCH] HID: sony: Add force feedback support for
 Dualshock3 USB
Date: Sun, 17 Nov 2013 14:11:00 -0500
Message-ID: <8c40cb08b7c44f373c2c533614d70b6a.squirrel@mungewell.org>
References: <1384021557-24106-1-git-send-email-sven@narfation.org>
    <1567991.TNa7UhjX8Q@sven-desktop>
    <CANq1E4RN2vpFvLcT6jdPw59wyJN-cBfFRQhMFzak7kJpPL86Nw@mail.gmail.com>
    <2014555.nmU692BQMt@sven-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:42988 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360Ab3KQTLC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Nov 2013 14:11:02 -0500
In-Reply-To: <2014555.nmU692BQMt@sven-desktop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sven Eckelmann <sven@narfation.org>
Cc: David Herrmann <dh.herrmann@gmail.com>, Simon Wood <simon@mungewell.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Colin Leitner <colin.leitner@gmail.com>


> Maybe Simon Wood can test his devices because I am unsure whether PS3
> dualshock clones will work with the interrupt or control urbs. For example
> the script from Simon didn't work at all for me.

With the proof of concept both my devices work OK with 'testhaptic' and
'testrumble' - the controllers rumble and the computer does not lock up.

My script is from a couple of years ago, and it didn't work for me with
the dualshock.

Simon.

PS. We know that some of the bits of that data frame are used to control
the LEDs. Anyone interested on getting them working via the LED class?

