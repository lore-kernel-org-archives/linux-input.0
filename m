From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [rft]power management for usbtouch
Date: Sun, 29 Jun 2008 00:47:55 +0200
Message-ID: <200806290047.56736.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0806281230510.23173-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:40952 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177AbYF1Wr2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Jun 2008 18:47:28 -0400
In-Reply-To: <Pine.LNX.4.44L0.0806281230510.23173-100000@netrider.rowland.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ville =?iso-8859-1?q?Syrj=E4l=E4?= <syrjala@sci.fi>, daniel.ritz@gmx.ch, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

Am Samstag 28 Juni 2008 18:33:30 schrieb Alan Stern:
> On Sat, 28 Jun 2008, Oliver Neukum wrote:
> 
> > In hindsight adding that interface at all was an error. I was in favor
> > of it and that was a mistake. Maybe it should be removed.
> > Complicating good drivers for its sake I therefore consider an error.
> > Possibly we should consider a forcible suspension a form of disconnection.
> 
> Are you suggesting that the "off" value in /sys/.../power/level 
> shouldn't be allowed?  I don't see it that way -- there's no other 
> mechanism for userspace to force a USB device into the low-power state.

Unfortunately.

> Forcing a disconnection during suspend might be a good idea.  But if 
> you do, is there any reason to consider manual suspension different 
> from system sleep?

During system sleep user space is asleep and cannot make demands
on drivers. If you force a device to sleep, the driver cannot work. Therefore
it should not be bound to such a device. It's cleaner to disconnect.

	Regards
		Oliver

