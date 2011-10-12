From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH V3] input: Fix USB autosuspend on bcm5974
Date: Wed, 12 Oct 2011 13:41:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1110121341010.2093-100000@iolanthe.rowland.org>
References: <20111012172631.GA29762@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:37231 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752139Ab1JLRlb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Oct 2011 13:41:31 -0400
In-Reply-To: <20111012172631.GA29762@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Oliver Neukum <oliver@neukum.org>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, dtor@mail.ru

On Wed, 12 Oct 2011, Matthew Garrett wrote:

> On Wed, Oct 12, 2011 at 01:24:42PM -0400, Alan Stern wrote:
> > On Wed, 12 Oct 2011, Matthew Garrett wrote:
> > > True. That makes things rather more awkward.
> > 
> > What about the second idea I mentioned?  If autosuspend fails with
> > -EBUSY or -EAGAIN, usbcore could schedule another autosuspend attempt.
> 
> Yeah, that sounds better.

Does this patch help?

Alan Stern


 drivers/usb/core/driver.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: usb-3.1/drivers/usb/core/driver.c
===================================================================
--- usb-3.1.orig/drivers/usb/core/driver.c
+++ usb-3.1/drivers/usb/core/driver.c
@@ -1667,6 +1667,13 @@ int usb_runtime_suspend(struct device *d
 		return -EAGAIN;
 
 	status = usb_suspend_both(udev, PMSG_AUTO_SUSPEND);
+
+	/* Retry if autosuspend failed temporarily */
+	if (status == -EBUSY || status == -EAGAIN) {
+		usb_mark_last_busy(udev);
+		pm_request_autosuspend(dev);
+	}
+
 	/* The PM core reacts badly unless the return code is 0,
 	 * -EAGAIN, or -EBUSY, so always return -EBUSY on an error.
 	 */

