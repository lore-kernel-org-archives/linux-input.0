From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [0000/0003]full power management for usb touchscreens
Date: Fri, 18 Jun 2010 20:22:07 +0200
Message-ID: <201006182022.07496.oliver@neukum.org>
References: <201006071513.29478.oneukum@suse.de> <201006101546.55460.oliver@neukum.org> <201006101613.52736.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:35783 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754707Ab0FRSVq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Jun 2010 14:21:46 -0400
In-Reply-To: <201006101613.52736.linux@rainbow-software.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Daniel Ritz <daniel.ritz@gmx.ch>

Am Donnerstag, 10. Juni 2010 16:13:51 schrieb Ondrej Zary:
> > > I haven't tested the patches before. Now I tested them and the Nexio
> > > touchscreen does not play well with suspend. It always reconnects after
> > > resume from STR or hibernation. Autosuspend is probably never activated
> > > at the URBs are submitted continuously.
> >
> > I see. Can you compile with CONFIG_USB_DEBUG and send me the log?
> 
> This can't be fixed - no matter what you do, the device reconnects if you stop 
> talking to it.

Have you tried setting it back to config 0?

	Regards
		Oliver
