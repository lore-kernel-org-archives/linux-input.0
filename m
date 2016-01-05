From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Patch-V2 1/6] INPUT: xpad: Add minimal support for Logitech
 G920 Wheel
Date: Mon, 4 Jan 2016 17:01:02 -0800
Message-ID: <20160105010102.GB11801@dtor-ws>
References: <20160104095524.GB20222@mail.corp.redhat.com>
 <568ad0ae.ea3d320a.6acab.2b84SMTPIN_ADDED_MISSING@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33315 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753681AbcAEBBH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Jan 2016 20:01:07 -0500
Content-Disposition: inline
In-Reply-To: <568ad0ae.ea3d320a.6acab.2b84SMTPIN_ADDED_MISSING@mx.google.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Wood <simon@mungewell.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Edwin <Edwin@velds.nl>, =?iso-8859-1?Q?=22Michal_Mal=FD=22?= <madcatxster@devoid-pointer.net>, elias vanderstuyft <elias.vds@gmail.com>

Hi Simon,

On Mon, Jan 04, 2016 at 01:05:35PM -0700, Simon Wood wrote:
> 
> On Mon, 4 Jan 2016 02:55:24 -0700, Benjamin Tissoires wrote:
> your next pull request for
> > Linus. We might want to drop it before it hits Linus' tree.
> > 
> > We can still keep the HID work in place even if the device is not
> > switched into the HID protocol at plug.
> > 
> > Simon, do you mind looking into Dmitry's suggestion of having a clean,
> > small usb device which loads itself when the G920 is plugged in and
> > switches it immediately into the HID mode?
> 

> Hi,
>
> As noted 'xpad.c' sends the magic bytes to switch the G920 wheel into
> HID mode, the wheel then detaches and reconnects as a HID+ device
> handled by 'logitech-hidpp.c'.
> 
> I'd like to point that up to this point the wheel _is_ a Xbox One
> control device, that speaks some undocumented protocol from Microsoft.
> To my mind xpad is the correct place to send the magic bytes.

OTOH one can argue if it does not speak protocol that xpad understands
then it does not belong in xpad.

Currently xpad.ko "weighs" at 44K (in my configuration), this is steep
price for sending 1 packet to the device. I am certain that adding a
skeleton usb driver into hid module will be much cheaper.

> 
> It is possible that at some future time that the Xpad devs will
> understand the protocol enough sufficiently to do useful stuff with
> the wheel. In an earlier version of the patch I had a param to disable
> the 'switch to HID', and that might be resurrected.

This is way down the road. We may even end up with a brand new driver
for it, not xpad. And if/when that happens we'll be able to drop hid
potion.

Thanks.

-- 
Dmitry
