From: Oliver Neukum <oneukum@suse.de>
Subject: Re: proposal for deletion of drivers/hid/hid-ids.h
Date: Fri, 27 Mar 2015 09:49:49 +0100
Message-ID: <1427446189.5783.29.camel@suse.de>
References: <1427370288.2075.19.camel@suse.de>
	 <CAN+gG=EJUwfzvNeud76RNa-hMQrttbNm03uKYJhqfTeJxjjF5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37323 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751638AbbC0Iu0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Mar 2015 04:50:26 -0400
In-Reply-To: <CAN+gG=EJUwfzvNeud76RNa-hMQrttbNm03uKYJhqfTeJxjjF5Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, pavel@ucw.cz

On Thu, 2015-03-26 at 10:06 -0400, Benjamin Tissoires wrote:
> On Thu, Mar 26, 2015 at 7:44 AM, Oliver Neukum <oneukum@suse.de> wrote:
> > Hi,
> >
> > I would like to kill drivers/hid/hid-ids.h and replace it
> > with numerical IDs in the files using it.
> >
> > There are two reasons for that.
> >
> > 1. It is a layering violation. There should not be a private
> > data base for USB IDs in HID.
> 
> Technically, this DB is not only for USB devices. We also have
> Bluetooth and I2C devices here.

Well, the token IDs ;)

> > 2. It serves no purpose and adds work. Anyone who adds a quirk
> > or a special case for devices needs to operate on the numbers,
> > as those are what he gets from the descriptors. Looking up or
> > adding a symbolic name for a device is just more work without
> > a benefit. These numbers have no intrinsic meaning beyond
> > being unique and it rarely matters (and should not matter)
> > for which vendor a particular fix is intended.
> 
> I disagree. This list might not be useful for the
> drivers/hid/usbhid/hid-quirks.c by itself in most cases.
> However, we mainly rely on this list to add the device in
> hid_have_special_driver and hid_ignore in hid-core and in the
> submodule that should handle it.

Can you explain how we depend on it? We certainly use it, but
how do we depend on it? I don't see how just the numbers would
be worse. In fact they would be better as you again save a lookup.

> Many times, already having the VID/PID registered in hid-ids.h saved
> some time when debugging and adding a subdriver for a special device
> because if the VID/PID is already in hid-ids.h, that means that

Again, I see how having the VID/PID pair is an advantage. I don't
see why having symbolic names for that pair is an advantage.
Just having the numbers in a list of quirky devices would serve
the same purpose.

> someone already dealt with it, and it gives us a way to clean it when
> the quirk was not appropriate. For instance, many multitouch devices
> were added before the creation of hid-multitouch and were registered
> with the quirk MULTI_INPUT.

Well, yes, so you needed to grep for MULTI_INPUT. The entries would
still have been present, just with nummerical IDs.

	Regards
		Oliver


