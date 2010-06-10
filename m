From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [0000/0003]full power management for usb touchscreens
Date: Thu, 10 Jun 2010 15:46:55 +0200
Message-ID: <201006101546.55460.oliver@neukum.org>
References: <201006071513.29478.oneukum@suse.de> <201006091836.14136.oliver@neukum.org> <201006101333.58693.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:60231 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421Ab0FJNqk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Jun 2010 09:46:40 -0400
In-Reply-To: <201006101333.58693.linux@rainbow-software.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Daniel Ritz <daniel.ritz@gmx.ch>

Am Donnerstag, 10. Juni 2010 13:33:57 schrieb Ondrej Zary:
> On Wednesday 09 June 2010, Oliver Neukum wrote:
> > Am Mittwoch, 9. Juni 2010 15:40:04 schrieb Ondrej Zary:
> > > Looking at the patches from archive:
> > >
> > > If I understand it correctly, usbtouch_resume submits the irq URB only if
> > > the input device is open. That will fail with Nexio as it has an internal
> > > watchdog which needs URBs or the device will reconnect - see irq_always
> > > (Zytronic seems to need it too).
> >
> > Thank you for the review. Does this patch fix the issues?
> 
> I haven't tested the patches before. Now I tested them and the Nexio 
> touchscreen does not play well with suspend. It always reconnects after 
> resume from STR or hibernation. Autosuspend is probably never activated at 
> the URBs are submitted continuously.

I see. Can you compile with CONFIG_USB_DEBUG and send me the log?

	Thank you
		Oliver
