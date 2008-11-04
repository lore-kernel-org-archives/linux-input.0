From: Oliver Neukum <oliver@neukum.org>
Subject: Re: cleanup of hiddev
Date: Tue, 4 Nov 2008 23:51:27 +0100
Message-ID: <200811042351.28526.oliver@neukum.org>
References: <200811031731.38055.oliver@neukum.org> <200811041856.47950.oliver@neukum.org> <4910B1E3.8090908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:32818 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757397AbYKDWvR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Nov 2008 17:51:17 -0500
In-Reply-To: <4910B1E3.8090908@gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Jiri Kosina <jikos@jikos.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

Am Dienstag, 4. November 2008 21:34:43 schrieb Jiri Slaby:
> Oliver Neukum napsal(a):
> > Am Dienstag, 4. November 2008 16:33:49 schrieb Jiri Slaby:
> >> Oliver Neukum napsal(a):
> >>> Yes, I see. However, the device must not be registered before the table
> >>> is correctly filled and the minor must be filled out before. A mutex then?
> >> It's enough to assign the hiddev_table after the register, isn't it?
> >> Actually, it's how it's done now... BTW what was the reason to move with that?
> > 
> > No, you have a race condition where open() for an announced device
> > will fail.
> 
> Could you expand this? I don't understand.
> 

If you call usb_register_dev() before you set
hiddev_table[usbhid->intf->minor - HIDDEV_MINOR_BASE]
this check in hiddev_open() may fail:
	if (i >= HIDDEV_MINORS || i < 0 || !hiddev_table[i])
		return -ENODEV;

	Regards
		Oliver
