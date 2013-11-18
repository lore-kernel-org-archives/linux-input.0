From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH] HID: sony: Add force feedback support for Dualshock3
 USB
Date: Mon, 18 Nov 2013 11:27:51 +0100
Message-ID: <20131118112751.b1c4a66d98740f6d231a454c@studenti.unina.it>
References: <1384021557-24106-1-git-send-email-sven@narfation.org>
	<5434362.OvDlhOjSJd@sven-edge>
	<8249378.0C4gn7PafG@sven-desktop>
	<2105006.tGLFZqe9L3@sven-desktop>
	<0d5dd16c7b4799f333fd4b4077e6c75c.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp206.alice.it ([82.57.200.102]:25250 "EHLO smtp206.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750754Ab3KRK2I (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Nov 2013 05:28:08 -0500
In-Reply-To: <0d5dd16c7b4799f333fd4b4077e6c75c.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: Sven Eckelmann <sven@narfation.org>, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Colin Leitner <colin.leitner@gmail.com>

On Sun, 17 Nov 2013 20:21:04 -0500
simon@mungewell.org wrote:

[...]
> I note that the LED class directory is based on USB ID and node, which
> changes each time the controller is plugged in. This makes assigning LEDs
> in game configurations a pain.
> 
> From my point of view a 'fixed UID' (such as a serial number) would be
> better, but most controllers don't report these. Any suggestions?
> 

The bluez plugin uses libudev, so it knows how to address the right
device when setting the LED.

Ciao,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
