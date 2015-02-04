From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] Input - mt: Fix input_mt_get_slot_by_key
Date: Wed, 4 Feb 2015 10:15:04 -0500
Message-ID: <20150204151504.GA16434@mail.corp.redhat.com>
References: <1422982530-4906-1-git-send-email-benjamin.tissoires@redhat.com>
 <54D121C8.80206@bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54792 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933635AbbBDPPQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Feb 2015 10:15:16 -0500
Content-Disposition: inline
In-Reply-To: <54D121C8.80206@bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Feb 03 2015 or thereabouts, Henrik Rydberg wrote:
> Hi Benjamin,
> 
> > Slot 0 is released correclty, but when we look for Contact ID 2, the slot
> > 0 is then picked up again because it is marked as inactive (trackingID < 0).
> > 
> > This is wrong, and we should not reuse a slot in the same frame.
> > The test should also check for input_mt_is_used().
> 
> Good catch! However...
> 
> > @@ -453,7 +456,7 @@ int input_mt_get_slot_by_key(struct input_dev *dev, int key)
> >  			return s - mt->slots;
> >  
> >  	for (s = mt->slots; s != mt->slots + mt->num_slots; s++)
> > -		if (!input_mt_is_active(s)) {
> > +		if (!input_mt_is_active(s) && !input_mt_is_used(mt, s)) {
> >  			s->key = key;
> >  			return s - mt->slots;
> >  		}
> > 
> 
> Here, you are changing the preconditions of the function without explicit
> reference to all its users. For one, it is now assumed that input_mt_is_used()
> is up-to-date, which requires either input_mt_drop_unused() or
> input_mt_sync_frame(), which does not seem to be true for all users of
> input_mt_get_slot_by_key(). After a couple of iterations with
> input_mt_report_slot_state() in those drivers, input_mt_is_used() will be true
> for all slots, and the driver will stop working.

Hmm... You are right. Thanks for pointing this out. This is something I
should have definitively thought.

So, on the kernel tree, I have only 5 drivers matching
input_mt_get_slot_by_key:

$ grep -lIr input_mt_get_slot_by_key | grep -E "\.[ch]$"
drivers/hid/hid-logitech-hidpp.c
drivers/hid/hid-multitouch.c
drivers/hid/wacom_wac.c
drivers/input/input-mt.c
drivers/input/touchscreen/sur40.c
drivers/input/touchscreen/pixcir_i2c_ts.c
include/linux/input/mt.h

On these five drivers, 4 are using properly input_mt_sync_frame, and
only one is not. This one is the Wacom one :)

For most of the touch devices (except those that are auto-detected and
handled), the code just calls input_mt_report_pointer_emulation()
instead of input_mt_sync_frame().

Changing the 5 calls in this driver and adding a requirement to call
input_mt_sync_frame() when using input_mt_get_slot_by_key() does not
seem terrible.

> 
> How about defering the deassignments until the end of the loop instead? That
> would remove possible reuse.
> 

I don't think this is feasible. There is no loop in the slot assignment
case. The state is stored by the input subsystem, and when we process
a touch, all the previous touches have already been processed and forwarded
to the user space.

We *could* defer the slot release before sending the EV_SYN event, but
that would force users to call input_mt_sync_frame() anyway to release
the slots. So we would get an even greater requirement, because now, all
users of the slotted protocol would have to call input_mt_sync_frame().

Cheers,
Benjamin
