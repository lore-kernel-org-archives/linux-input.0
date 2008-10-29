From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [patch]aggessive autosuspend for HID devices (resent due to corruption)
Date: Wed, 29 Oct 2008 15:06:00 +0100
Message-ID: <200810291506.02234.oliver@neukum.org>
References: <200810271042.37365.oliver@neukum.org> <alpine.LNX.1.10.0810291425400.12928@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:49167 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752991AbYJ2OGG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Oct 2008 10:06:06 -0400
In-Reply-To: <alpine.LNX.1.10.0810291425400.12928@jikos.suse.cz>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, "Yang, Yi Y" <yi.y.yang@intel.com>

Am Mittwoch, 29. Oktober 2008 14:28:12 schrieb Jiri Kosina:
> On Mon, 27 Oct 2008, Oliver Neukum wrote:
> 
> > This uses the USB busy mechanism for aggessive autosuspend of USB HID 
> > devices. It autosuspends all opened devices supporting remote wakeup 
> > after a timeout unless
> > 
> > - output is being done to the device
> > - a key is being held down (remote wakeup isn't triggered upon key release)
> > - LED(s) are lit
> > - hiddev is opened
> 
> Hi Oliver,
> 
> doesn't hidraw (the generic transport-independent variant of 
> USB-specific hiddev) need also some handling?

Good point. Yes, it does.

This leaves me with two problems.

1. The HID API doesn't tell me why a device is opened. Add a flag?
2. hidraw calls open with a spinlock held. I suggest converting it to a mutex.

What do you think?

	Regards
		Oliver
