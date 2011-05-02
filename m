From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: USB keyboard recognized as HID keyboard but doesn't work
Date: Mon, 2 May 2011 18:29:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1105021826040.8810-100000@netrider.rowland.org>
References: <4DBF1FD6.1000809@sieker.io>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:34348 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753971Ab1EBW3I (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 May 2011 18:29:08 -0400
In-Reply-To: <4DBF1FD6.1000809@sieker.io>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Adi J. Sieker" <adi@sieker.io>, Jiri Kosina <jkosina@suse.cz>
Cc: Oliver Neukum <oliver@neukum.org>, USB list <linux-usb@vger.kernel.org>, linux-input@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

On Mon, 2 May 2011, Adi J. Sieker wrote:

> > Interestingly, the usbmon trace shows that the interrupt endpoint for
> > interface 1 isn't being used by usbhid.  I don't know why, but it
> > shouldn't make much difference for your purposes since that interface
> > appears to be associated with the gaming interface.  But maybe I'm
> > wrong and it is important somehow...
> >
> > The other noticeable thing is that the keyboard didn't accept the
> > Set-Idle request for interface 1.
> >
> > You said before that the keyboard worked okay when driven by a guest
> > Windows OS, right?  Can you collect an equivalent usbmon trace for
> > that?  Comparing the two traces may be instructive.
> 
> I hope this is what you meant. :)
> Attached is a usbmon trace when I attach the keyboard to a VBox VM 
> running a Windows XP guest. I have no idea how to get a USB trace from 
> within Windows. The last block is when I pressed h twice in the Windows 
> XP guest.

This is perfect.  It shows that the H key is reported using the 
interrupt endpoint on interface 1, which explains why it's not working 
with usbhid.  It also shows that the rejected Set-Idle request doesn't 
matter.

At this point I don't know what the problem is, but now there's plenty 
of information in the email thread for the people on linux-input to 
debug this.

Alan Stern

