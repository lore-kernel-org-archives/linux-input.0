From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [patch]full autosuspend for USB HID
Date: Wed, 7 May 2008 17:59:15 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0805071758240.11363@jikos.suse.cz>
References: <Pine.LNX.4.44L0.0805071156300.2174-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:48272 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756024AbYEGP7Q (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 7 May 2008 11:59:16 -0400
In-Reply-To: <Pine.LNX.4.44L0.0805071156300.2174-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oliver@neukum.org>, USB list <linux-usb@vger.kernel.org>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Wed, 7 May 2008, Alan Stern wrote:

> > Unfortunately, I vaguely remember that some keyboards exposed the 
> > behaviors only when connected to certain HCI controllers, so building 
> > the whitelist might not be completely trivial.
> Can we find out what Windows and OS-X do and copy them?

Actually I don't think they do runtime power management on USB HID 
devices. At least I have never seen any windows machine to make the 
USB keyboard LEDs to go off :)

-- 
Jiri Kosina
SUSE Labs
