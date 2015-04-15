From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: need to get the interface cycled with autopm_get/_put() to let
 a device sleep
Date: Wed, 15 Apr 2015 11:07:35 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1504151104240.1404-100000@iolanthe.rowland.org>
References: <1429108428.31093.12.camel@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:58597 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755967AbbDOPHg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Apr 2015 11:07:36 -0400
In-Reply-To: <1429108428.31093.12.camel@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Wed, 15 Apr 2015, Oliver Neukum wrote:

> Hi,
> 
> I found a problem with the close() function of usbhid.
> It fails to properly suspend device that don't support
> remote wake-up. The power core does not retry an autosuspend
> that failed due to a lack of support for remote wake-up.
> 
> So there needs to be a _put() if the need for remote wake-up
> is rescinded. The current state of affairs leads to joysticks
> never going to sleep again after use.
> 
> But I am not happy with the simple solution. It needlessly
> wakes up suspended devices. So, I tried using
> usb_autopm_get_interface_no_resume(). To my considerable
> surprise that didn't work. I cannot understand why.

In what way did it not work?

> So what is to be done?

Start with a little debugging.  When you do the put, what happens 
inside autosuspend_check()?

Alan Stern

