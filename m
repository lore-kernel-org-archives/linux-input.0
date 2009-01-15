From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [Bugme-new] [Bug 12447] New: usbtouchscreen submits URB too
 quickly if built in to kernel
Date: Thu, 15 Jan 2009 10:09:43 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0901151008560.2490-100000@iolanthe.rowland.org>
References: <200901142111.14203.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:57840 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753779AbZAOPJp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Jan 2009 10:09:45 -0500
In-Reply-To: <200901142111.14203.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Hagood <david.hagood@aeroflex.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, USB list <linux-usb@vger.kernel.org>, linux-input@vger.kernel.org, bugme-daemon@bugzilla.kernel.org

On Wed, 14 Jan 2009, Dmitry Torokhov wrote:

> > I suppose this is device-specific and will have to be worked around in
> > the driver buy resubmitting request a few times until it "sticks".
> 
> Hmm, I take it back... the message comes from the IRQ routine; that
> means we were able to submit IRQ at least once. Plus we do send a
> few control messages for mtouch. So I don't understand why it would
> start returning -ENODEV out of sudden.

A usbmon trace might come in useful here.  See the instructions in 
Documentation/usb/usbmon.txt.

Alan Stern

