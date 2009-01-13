From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Add N-Trig to USB HID quirks
Date: Tue, 13 Jan 2009 23:52:16 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0901132350270.5377@jikos.suse.cz>
References: <1231838198.8132.27.camel@micki-desktop.n-trig.com> <20090113103323.26dbe085@lxorguk.ukuu.org.uk> <alpine.LNX.1.10.0901131136470.5377@jikos.suse.cz> <496CC8EE.5030105@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:43757 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752888AbZAMWwS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Jan 2009 17:52:18 -0500
In-Reply-To: <496CC8EE.5030105@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Micki <micki@n-trig.com>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Tue, 13 Jan 2009, Rafi Rubin wrote:

> The patches I wrote make minimal pertubations to help the hid driver 
> recognize and communicate with the digitizer.  The result has been an 
> event device that actually works reasonably well with the existing X11 
> wacom driver (at least with version 0.8.1.6).

Micki, could you please look into the current drivers/hid/hid-ntrig.c 
driver to see if it is easily possible to have your driver based on top of 
that code?

Thanks,

-- 
Jiri Kosina
SUSE Labs
