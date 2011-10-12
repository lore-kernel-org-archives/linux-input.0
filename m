From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH V3] input: Fix USB autosuspend on bcm5974
Date: Wed, 12 Oct 2011 16:37:22 +0200
Message-ID: <201110121637.22442.oliver@neukum.org>
References: <Pine.LNX.4.44L0.1110121030030.2093-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:44049 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455Ab1JLOhD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Oct 2011 10:37:03 -0400
In-Reply-To: <Pine.LNX.4.44L0.1110121030030.2093-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, dtor@mail.ru

Am Mittwoch, 12. Oktober 2011, 16:33:13 schrieb Alan Stern:

> I admit to not being very familiar with the way usbhid handles 
> autosuspend.  However in general, if a suspend fails because the driver 
> is busy, then when the driver stops being busy it should initiate the 
> next round of autosuspend.  In this case, when the key release has been 
> fully processed, the driver should call usb_put_interface_async() or 
> something similar, which would restart the timer.

I see. I can do this although it is not very elegant, because
the pm counters at this point ought to be 0 already.
Arguably a driver is the wrong layer to do this.

	Regards
		Oliver
