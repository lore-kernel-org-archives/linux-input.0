From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] usbhid: correct PM failure with closed devices
Date: Wed, 15 Apr 2015 10:56:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1504151042140.1404-100000@iolanthe.rowland.org>
References: <1429103925-31304-1-git-send-email-oneukum@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:58579 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752289AbbDOO4e (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Apr 2015 10:56:34 -0400
In-Reply-To: <1429103925-31304-1-git-send-email-oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: jkosina@suse.cz, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Wed, 15 Apr 2015, Oliver Neukum wrote:

> When usbhid closes a device which was awake only because remote
> wakeup was required but not provided, the interface must go through
> a get/put cycle or the core will never reattempt to suspend the device.
> This brakes runtime PM for all joysticks.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.de>

This seems reasonable, although it would be nice if there was a way to 
do this without waking up the device if it was already in runtime 
suspend.  Perhaps make the get/put conditional on 
pm_runtime_active(&usbhid->intf->dev)?  It's okay to do the get/put 
cycle after setting needs_remote_wakeup to 0.

By the way, how does the HID core handle the case where the device file 
is closed long after the device has disconnected?

Alan Stern

