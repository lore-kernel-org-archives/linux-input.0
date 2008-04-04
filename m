From: Oliver Neukum <oliver@neukum.org>
Subject: Re: full usbhid autosuspend
Date: Fri, 4 Apr 2008 16:45:39 +0200
Message-ID: <200804041645.40301.oliver@neukum.org>
References: <200804011603.05998.oliver@neukum.org> <200804041628.14793.oliver@neukum.org> <Pine.LNX.4.64.0804041637150.32130@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:51364 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757033AbYDDOvX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Apr 2008 10:51:23 -0400
In-Reply-To: <Pine.LNX.4.64.0804041637150.32130@jikos.suse.cz>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org

Am Freitag, 4. April 2008 16:38:18 schrieb Jiri Kosina:
> > > triggered it on my test system trivially by just attaching one PS2 and one 
> > > USB keyboard to the system, fiddling a bit with leds on PS2 keyboard and 
> > > then tried to perform remote-wakeup on the suspended USB keyboard.
> > That is you hit a key on the USB keyboard?
> 
> Yes. Just letting the USB keyboard go auto-suspend, then fiddling with 
> LEDs on PS2 keyboard and then hitting key on USB keyboard triggers it for 
> me quite reliably (not 100% though, so you may have to retry).

I mean did you hit e.g. CAPS LOCK or any key that should have switched an
LED or just any other key?

	Regards
		Oliver

