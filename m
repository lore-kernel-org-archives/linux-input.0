From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch]race between disconnect and open in usbtouchscreen
Date: Mon, 23 Nov 2009 09:21:33 -0800
Message-ID: <20091123172133.GA17813@core.coreip.homeip.net>
References: <200911202213.47916.oliver@neukum.org> <20091120212259.GC16447@core.coreip.homeip.net> <200911202249.56591.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:51656 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbZKWRVe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Nov 2009 12:21:34 -0500
Content-Disposition: inline
In-Reply-To: <200911202249.56591.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Ondrej Zary <linux@rainbow-software.org>, Jiri Kosina <jkosina@suse.cz>, Daniel Ritz <daniel.ritz@gmx.ch>

On Fri, Nov 20, 2009 at 10:49:56PM +0100, Oliver Neukum wrote:
> Am Freitag, 20. November 2009 22:22:59 schrieb Dmitry Torokhov:
> > Hi Oliver,
> > 
> > On Fri, Nov 20, 2009 at 10:13:47PM +0100, Oliver Neukum wrote:
> > > Hi,
> > >
> > > an open() between killing the urb and unregistering the device
> > > can lead to IO to a disconnected device.
> > 
> > usbtouch_close() calls usb_kill_urb() so there is no race.
> > usb_kill_urb() simply not needed in usbtouch_disconnect().
> 
> Then it needs to go.
> 

Applied, thank you Oliver.

-- 
Dmitry
