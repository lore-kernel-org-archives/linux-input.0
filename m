From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch]race between disconnect and open in usbtouchscreen
Date: Fri, 20 Nov 2009 13:22:59 -0800
Message-ID: <20091120212259.GC16447@core.coreip.homeip.net>
References: <200911202213.47916.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:48702 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755604AbZKTVXA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Nov 2009 16:23:00 -0500
Content-Disposition: inline
In-Reply-To: <200911202213.47916.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Ondrej Zary <linux@rainbow-software.org>, Jiri Kosina <jkosina@suse.cz>, Daniel Ritz <daniel.ritz@gmx.ch>

Hi Oliver,

On Fri, Nov 20, 2009 at 10:13:47PM +0100, Oliver Neukum wrote:
> Hi,
> 
> an open() between killing the urb and unregistering the device
> can lead to IO to a disconnected device.
> 

usbtouch_close() calls usb_kill_urb() so there is no race.
usb_kill_urb() simply not needed in usbtouch_disconnect().

Thanks.

-- 
Dmitry
