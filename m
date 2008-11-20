From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Lockdep violation in 2.6.28-rc4 + gregkh-all
Date: Thu, 20 Nov 2008 16:18:08 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0811201616210.19853@jikos.suse.cz>
References: <Pine.LNX.4.44L0.0811131027190.2380-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:59843 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755451AbYKTPSJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Nov 2008 10:18:09 -0500
In-Reply-To: <Pine.LNX.4.44L0.0811131027190.2380-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-input@vger.kernel.org

On Thu, 13 Nov 2008, Alan Stern wrote:

> Here's what the lockdep trace indicates:
> 
> 	Somewhere in the input_register_device / input_attach_handler
> 	path, you lock input_dev->mutex.  While that lock is held,
> 	kbd_connect calls down to usbhid_open, which calls
> 	usb_autopm_get_interface, which acquires usb_dev->pm_mutex.
> 
> 	hid_suspend is called with usb_dev->pm_mutex held.  It
> 	acquires usbhid->setup.

Jiri, do we really need the ->setup mutex in fact? Aren't 
test_bit()/set_bit() for HID_STARTED and HID_SUSPENDED on the iofl 
sufficient to prevent races between start/resume and stop/suspend?

-- 
Jiri Kosina
SUSE Labs
