From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: full usbhid autosuspend
Date: Fri, 4 Apr 2008 17:11:24 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0804041708100.32130@jikos.suse.cz>
References: <200804011603.05998.oliver@neukum.org> <200804041628.14793.oliver@neukum.org>
 <Pine.LNX.4.64.0804041637150.32130@jikos.suse.cz> <200804041645.40301.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:35204 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752150AbYDDPLZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 4 Apr 2008 11:11:25 -0400
In-Reply-To: <200804041645.40301.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org

On Fri, 4 Apr 2008, Oliver Neukum wrote:

> > Yes. Just letting the USB keyboard go auto-suspend, then fiddling with 
> > LEDs on PS2 keyboard and then hitting key on USB keyboard triggers it for 
> > me quite reliably (not 100% though, so you may have to retry).
> I mean did you hit e.g. CAPS LOCK or any key that should have switched an
> LED or just any other key?

OK, so the quite reliable sequence seems to be

- let the USB keyboard go to sleep
- press CAPS on PS2 keyboard
- let the USB keyboard go to sleep again
- press 'a' on USB keyboard
- let the USB keyboard go to sleep again
- press CAPS on PS2 keyboard
- let the USB keyboard go to sleep again
- press 'a' on the USB keyboard

=> deadlock.

-- 
Jiri Kosina
SUSE Labs
