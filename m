From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH 2/3] usbtouchscreen: Implement runtime power management
Date: Tue, 8 Jun 2010 12:14:18 +0200
Message-ID: <201006081214.18184.oliver@neukum.org>
References: <Pine.LNX.4.44L0.1006071622260.1332-100000@iolanthe.rowland.org> <201006072247.33068.oliver@neukum.org> <20100608083751.GA27348@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:33999 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754396Ab0FHKOS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Jun 2010 06:14:18 -0400
In-Reply-To: <20100608083751.GA27348@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Daniel Ritz <daniel.ritz@gmx.ch>

Am Dienstag, 8. Juni 2010 10:37:51 schrieb Dmitry Torokhov:
> On Mon, Jun 07, 2010 at 10:47:33PM +0200, Oliver Neukum wrote:
> > Am Montag, 7. Juni 2010 22:22:54 schrieb Alan Stern:
> > > On Mon, 7 Jun 2010, Oliver Neukum wrote:

> > > But other drivers don't do this.  What's special about usbtouch?
> > 
> > Then I'd say the other drivers are wrong. We cannot leak USB specific
> > codes. Maybe we should pass -ENOMEM and -ENODEV, but the others
> > really don't mean anything as generic codes.
> > 
> 
> No, I'd say that usb_autopm_get_interface() is wrong - since it is
> supposed to be used by drivers who are not concerned about USB-specific
> codes these functions should not leak them to the callers but rather
> provide ones suitable for reporting upstream.

But the driver may need to know why its request failed to handle errors
properly, for example it makes no sense to reset a device if you get -ENODEV.

	Regards
		Oliver
