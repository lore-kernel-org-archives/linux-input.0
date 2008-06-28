From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [rft]power management for usbtouch
Date: Sat, 28 Jun 2008 12:33:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0806281230510.23173-100000@netrider.rowland.org>
References: <200806281453.17896.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:3575 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752287AbYF1Qdc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Jun 2008 12:33:32 -0400
In-Reply-To: <200806281453.17896.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Ville =?iso-8859-1?q?Syrj=E4l=E4?= <syrjala@sci.fi>, daniel.ritz@gmx.ch, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Sat, 28 Jun 2008, Oliver Neukum wrote:

> In hindsight adding that interface at all was an error. I was in favor
> of it and that was a mistake. Maybe it should be removed.
> Complicating good drivers for its sake I therefore consider an error.
> Possibly we should consider a forcible suspension a form of disconnection.

Are you suggesting that the "off" value in /sys/.../power/level 
shouldn't be allowed?  I don't see it that way -- there's no other 
mechanism for userspace to force a USB device into the low-power state.

Forcing a disconnection during suspend might be a good idea.  But if 
you do, is there any reason to consider manual suspension different 
from system sleep?

Alan Stern

