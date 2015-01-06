From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: input: fix confusion on conflicting mappings
Date: Tue, 6 Jan 2015 22:42:10 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1501062230090.25732@pobox.suse.cz>
References: <1419862886-1319-1-git-send-email-dh.herrmann@gmail.com> <alpine.LNX.2.00.1501062218200.25732@pobox.suse.cz> <CANq1E4TYhDzpLofxCr05hvHJMAvtMHEM210ALsB_UOi2=4c7kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50450 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932535AbbAFVmM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 6 Jan 2015 16:42:12 -0500
In-Reply-To: <CANq1E4TYhDzpLofxCr05hvHJMAvtMHEM210ALsB_UOi2=4c7kQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Adam Goode <adam@spicenitz.org>, Fredrik Hallenberg <megahallon@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, stable <stable@vger.kernel.org>

On Tue, 6 Jan 2015, David Herrmann wrote:

> >> On an PC-101/103/104 keyboard (American layout) the 'Enter' key and its
> >> neighbours look like this:
> >>
> >>            +---+ +---+ +-------+
> >>            | 1 | | 2 | |   5   |
> >>            +---+ +---+ +-------+
> >>              +---+ +-----------+
> >>              | 3 | |     4     |
> >>              +---+ +-----------+
> >
> > [ ... snip ... ]
> >
> > Alright, I can't really see this introducing any regressions. I have now
> > queued this for 3.20.
> 
> As Fredrik wrote, we need to also check for VARIABLE:

Gah, that's indeed a good catch. For some reason I don't seem to be CCed 
on Fredrik's mail :/

I have now applied the patch below on top of for-3.20/upstream, so that we 
don't keep -next unnecessarily broken.



From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] HID: fixup the conflicting keyboard mappings quirk

The ignore check that got added in 6ce901eb61 ("HID: input: fix confusion
on conflicting mappings") needs to properly check for VARIABLE reports
as well (ARRAY reports should be ignored), otherwise legitimate keyboards
might break.

Cc: <stable@vger.kernel.org>
Fixes: 6ce901eb61 ("HID: input: fix confusion on conflicting mappings")
Reported-by: Fredrik Hallenberg <megahallon@gmail.com>
Reported-by: David Herrmann <dh.herrmann@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/hid/hid-input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 84b6899..a758900 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1113,6 +1113,7 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 	 */
 	if (!(field->flags & (HID_MAIN_ITEM_RELATIVE |
 	                      HID_MAIN_ITEM_BUFFERED_BYTE)) &&
+			      (field->flags & HID_MAIN_ITEM_VARIABLE) &&
 	    usage->usage_index < field->maxusage &&
 	    value == field->value[usage->usage_index])
 		return;
-- 
Jiri Kosina
SUSE Labs
