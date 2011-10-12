From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH V3] input: Fix USB autosuspend on bcm5974
Date: Wed, 12 Oct 2011 09:03:00 +0200
Message-ID: <201110120903.00651.oliver@neukum.org>
References: <Pine.LNX.4.44L0.1110111240210.2177-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:59710 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686Ab1JLHCl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Oct 2011 03:02:41 -0400
In-Reply-To: <Pine.LNX.4.44L0.1110111240210.2177-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

Am Dienstag, 11. Oktober 2011, 18:43:55 schrieb Alan Stern:
> On Tue, 11 Oct 2011, Dmitry Torokhov wrote:
 
> > Hmm, reading Alan's comment I can see why wakeup might be beneficial
> > when system is in the sleep state, but while it is running and there is
> > no driver or driver wants to disable wakeups I think we should
> > accommodate it.
> 
> Currently, wakeup is enabled for USB devices during autosuspend if and
> only if one or more of the interface drivers has set the
> intf->needs_remote_wakeup flag.  Therefore all that usbhid should need 
> to do is clear that flag when the device file is closed.

Now I am confused because Matthew reported that his device generated
remote wakeups without setting needs_remote_wakeup at all.
Matthew, could you clarify?

	Regards
		Oliver
