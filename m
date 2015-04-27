From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2] Input - mt: Fix input_mt_get_slot_by_key
Date: Mon, 27 Apr 2015 14:02:53 -0400
Message-ID: <20150427180253.GD25614@mail.corp.redhat.com>
References: <1427741655-4142-1-git-send-email-benjamin.tissoires@redhat.com>
 <20150406163349.GD36770@dtor-ws>
 <alpine.LNX.2.00.1504071517260.30181@pobox.suse.cz>
 <CAKdAkRROn=tCuSDmCqsugPAFBsTa5jEZsOEoTBCAFUrheM2X8Q@mail.gmail.com>
 <5539279F.4050400@bitmath.org>
 <20150423182046.GF34808@dtor-ws>
 <20150423183827.GA10937@mail.corp.redhat.com>
 <20150423184709.GG34808@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57777 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964912AbbD0SC4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Apr 2015 14:02:56 -0400
Content-Disposition: inline
In-Reply-To: <20150423184709.GG34808@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, Henrik Rydberg <rydberg@bitmath.org>, Jiri Kosina <jkosina@suse.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

On Apr 23 2015 or thereabouts, Dmitry Torokhov wrote:
> On Thu, Apr 23, 2015 at 02:38:27PM -0400, Benjamin Tissoires wrote:
> > On Apr 23 2015 or thereabouts, Dmitry Torokhov wrote:
> > > On Thu, Apr 23, 2015 at 07:10:55PM +0200, Henrik Rydberg wrote:
> > > > > "Creation, replacement and destruction of contacts is achieved by
> > > > > modifying the ABS_MT_TRACKING_ID of the associated slot.  A
> > > > > non-negative tracking id is interpreted as a contact, and the value -1
> > > > > denotes an unused slot.  A tracking id not previously present is
> > > > > considered new, and a tracking id no longer present is considered
> > > > > removed."
> > > > > 
> > > > > If some userspace is confused with missing -1 tracking ID for that
> > > > > slot, that userspace should be fixed.
> > > > 
> > > > I agree. Some userland applications work with add/remove out of convenience, and
> > > > cannot handle the more compressed notation the kernel slot handling allows.
> > > > Fixing those applications will be a good thing.
> > > > 
> > > > Unfortunately the patch already appeared in Linus' tree...
> > > 
> > > It's in 4.1-rc0 so we can just revert it.
> > > 
> > 
> > Before we call for a revert, I'd like to hear Peter thoughts about it,
> > as he is the main user of the slotted protocol.
> > 
> > Also, Dmitry, can you check if the ChromeOS driver and (or) the android
> > one would need to be adapted? My guess is that none of these drivers are
> > able to handle a silent closing of a slot
> 
> I will, at least for Chrome. But if it is broken I'll simply open a big
> to fix it ;)
> 
> > and the easiest solution might
> > be to simply change the documentation if in fact nobody uses the
> > compressed notation (which removes just one ABS_SLOT event within the
> > frame, so not sure we can call it compressed BTW).
> 
> No, it is more that that I think. Wouldn't we need to allocate memory
> for 2*n slots to actually reliably track all contacts if they all happen
> to get released and put back onto the surface in different place very
> very quickly if we insist on sending tracking id -1 for previously used
> slots?
> 

In addition to Peter's answer, I thought about this case a little bit
more. For most of the devices, this won't be a problem: at the HID
level, the device needs to send a release event. And we declare the
slots according to what the HID protocol is capable of.

So in most of the cases (i.e. with a Win 8 certified touchscreen that
uses the HID protocol), you don't need to augment the slot count to 2*n
given that the pre-filtering will be done by the firmware to ensure the
compatibility with the HID touch specification.

For other devices, we write an ad-hoc driver, and there we can be
smarter and eventually rely on Peter's proposal to add extra EV_SYN for
releasing the unsuded slots.

Note that this discussion came from a HID device which doesn't need to
allocate 2*n slots, but input_mt_get_slot_by key() reallocate the same
slot twice within the same frame while other slots were free to be used.

Cheers,
Benjamin
