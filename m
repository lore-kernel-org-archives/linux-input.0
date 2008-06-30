From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [rft]power management for usbtouch
Date: Tue, 1 Jul 2008 00:46:33 +0200
Message-ID: <200807010046.34219.oliver@neukum.org>
References: <20080630112709.ZZRA012@mailhub.coreip.homeip.net> <Pine.LNX.4.44L0.0806301145020.2708-100000@iolanthe.rowland.org> <20080630115953.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:55689 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932307AbYF3WqF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Jun 2008 18:46:05 -0400
In-Reply-To: <20080630115953.ZZRA012@mailhub.coreip.homeip.net>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Ville Syrj?l? <syrjala@sci.fi>, daniel.ritz@gmx.ch, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

Am Montag 30 Juni 2008 18:02:44 schrieb Dmitry Torokhov:
> On Mon, Jun 30, 2008 at 11:47:28AM -0400, Alan Stern wrote:
> > On Mon, 30 Jun 2008, Dmitry Torokhov wrote:
> > 
> > > > > Forcing a disconnection during suspend might be a good idea.  But if 
> > > > > you do, is there any reason to consider manual suspension different 
> > > > > from system sleep?
> > > > 
> > > > During system sleep user space is asleep and cannot make demands
> > > > on drivers. If you force a device to sleep, the driver cannot work. Therefore
> > > > it should not be bound to such a device. It's cleaner to disconnect.
> > > 
> > > I'd agree with this. Otherwise we need somehow to be able to resync
> > > the state of the device (like have LEDs and repeat rate reset,
> > > re-upload force-feedback effects, etc, etc) once device is resumed.
> > > So... what is the consensus? Do we need to worry about manual
> > > device-level suspension or it will be reworked/removed?
> > 
> > My feeling is that we will leave manual suspension in the kernel.  The
> > code passed to the USB driver's suspend method will be changed so that
> > the method can tell whether it is being called for a system sleep vs.
> > an autosuspend vs. a manual suspend.
> > 
> 
> Ok, I see... So what does a device do when it is suspended and a
> request comes in? Does it automatically resume and service the request
> (and potentially goes back to sleep)? Does it queue the request for
> later? Ignore it? Is it a system-wide policy or up to the device
> [class]?

Return an error. If you queue, how much would you queue?
There's no sane answer, so you better fail right away.

	Regards
		Oliver
