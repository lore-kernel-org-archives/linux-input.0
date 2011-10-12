From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH V3] input: Fix USB autosuspend on bcm5974
Date: Wed, 12 Oct 2011 19:11:53 +0200
Message-ID: <201110121911.53918.oliver@neukum.org>
References: <Pine.LNX.4.44L0.1110121101420.2093-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:44391 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769Ab1JLRyb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Oct 2011 13:54:31 -0400
In-Reply-To: <Pine.LNX.4.44L0.1110121101420.2093-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, dtor@mail.ru

Am Mittwoch, 12. Oktober 2011, 17:28:06 schrieb Alan Stern:
> > Arguably a driver is the wrong layer to do this.
> 
> Are you suggesting the usb_runtime_suspend() should call 
> usb_mark_last_busy() and pm_runtime_autosuspend() if usb_suspend_both() 
> returns -EBUSY or -EAGAIN?

Yes.

	Regards
		Oliver
