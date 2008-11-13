From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Lockdep violation in 2.6.28-rc4 + gregkh-all
Date: Thu, 13 Nov 2008 10:37:36 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0811131027190.2380-100000@iolanthe.rowland.org>
References: <alpine.LNX.1.10.0811131244320.32143@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:35139 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751918AbYKMPhh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Nov 2008 10:37:37 -0500
In-Reply-To: <alpine.LNX.1.10.0811131244320.32143@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-input@vger.kernel.org

On Thu, 13 Nov 2008, Jiri Kosina wrote:

> On Wed, 12 Nov 2008, Alan Stern wrote:
> 
> > [  795.103175] =======================================================
> > [  795.103347] [ INFO: possible circular locking dependency detected ]
> > [  795.103439] 2.6.28-rc4 #1
> > [  795.103522] -------------------------------------------------------
> > [  795.103614] rmmod/2553 is trying to acquire lock:
> > [  795.103703]  (&dev->mutex){--..}, at: [<c054680e>] input_unregister_device+0x16/0x15d
> > [  795.103957] 
> > [  795.103958] but task is already holding lock:
> > [  795.104060]  (&usbhid->setup){--..}, at: [<f077a69e>] usbhid_stop+0x40/0xf8 [usbhid]
> > [  795.104060] which lock already depends on the new lock.
> 
> Hmm, I don't think I really understand the root cause here on a first 
> sight. We always take usbhid->setup mutex in usbhid_stop() and after that 
> call into input_unregister_device(), which acquires the corresponding 
> input_dev->mutex.
> 
> But I don't seem to be able find where we take input_dev->mutex before 
> taking usbhid->setup mutex ... I somehow don't see that neither from the 
> lockdep traces nor the code.

Here's what the lockdep trace indicates:

	Somewhere in the input_register_device / input_attach_handler
	path, you lock input_dev->mutex.  While that lock is held,
	kbd_connect calls down to usbhid_open, which calls
	usb_autopm_get_interface, which acquires usb_dev->pm_mutex.

	hid_suspend is called with usb_dev->pm_mutex held.  It
	acquires usbhid->setup.

Therefore we end up with the following 3-way loop:

	The unregister path acquires input_dev->mutex while holding
	usbhid->setup.

	The register/attach/open path acquires usb_dev->pm_mutex
	while holding input_dev->mutex.

	The suspend path acquires usbhid->setup while holding
	usb_dev->pm_mutex.

I'm not familiar enough with the usbhid subsystem to know the right way
to break this loop.

Alan Stern

