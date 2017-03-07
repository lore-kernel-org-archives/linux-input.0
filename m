From: Tomasz Kramkowski <tk@the-tk.com>
Subject: Re: [PATCH v2 0/2] patches for Innomedia INNEX GENESIS/ATARI adapter
Date: Tue, 7 Mar 2017 13:10:36 +0000
Message-ID: <20170307131036.GA853@gaia.local>
References: <20170214231433.27060-1-tk@the-tk.com>
 <20170303161501.GT7064@mail.corp.redhat.com>
 <20170304101920.GA30340@gaia.local>
 <20170306090450.GW7064@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from erebus.the-tk.com ([109.74.205.187]:54542 "EHLO
        erebus.the-tk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbdCGNNi (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 7 Mar 2017 08:13:38 -0500
Content-Disposition: inline
In-Reply-To: <20170306090450.GW7064@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Denilson Figueiredo de =?iso-8859-1?Q?S=E1?= <denilsonsa@gmail.com>

On Mon, Mar 06, 2017 at 10:04:50AM +0100, Benjamin Tissoires wrote:
> Well, the HID spec is not very clear, that the least we can agree on :)
> 
> But Microsoft's interpretation is rather clear in the
> multitouch/touchpad/pen specification:
> https://msdn.microsoft.com/en-us/library/windows/hardware/dn672278(v=vs.85).aspx
> paragraph "Required HID usages for pen digitizers":
> 
> "It should be noted that the host will recognize the values outside the
> logical range as signifying the implementation of this protocol only if
> the report descriptor specifically includes the bit signifying the fact
> that X and Y support NULL states. Otherwise, values outside the logical
> range are simply moved to the nearest boundary value."
> 
> And the 2 report descriptors written after are correct concerning the
> NULL state bit.
> 
> For Microsoft (in the pointer delivery protocol):
> - NULL state -> ignore out of range values
> - No NULL State -> clamp at the nearest boundary.
> 
> Following this would solve both issues If I understand correctly. Your
> controller would be clamped to [-1..1] (No Null State), and the ones
> that need to be ignored (like the ones from Denilson will be thanks to
> the NULL state bit set.

The clamping behaviour is the best of both worlds, it still matches how
I interpret the spec and provides a concrete definition of what should
happen when an out of bounds value is reported with the "No Null
Position | Null State" bit unset.

However, currently we just let the value pass through unchanged. So I
propose another patch on top of this one (at the bottom of the email,
done against for-4.12/hid-core-null-state-handling). The original change
which ignores the out of range value does a dbg_hid, I'm not sure if
that's necessary for the clamping scenario. I'll leave a few days for
any comments and if testing goes well (I don't see why not) I'll post it
on here as a patch. I'm not sure if that would be a v3 or a new patch.

> Maybe we can follow this to say we are mimicking Microsoft's driver and
> hope for the best?

Their approach to the ambiguity takes the safest bet and compatibility
with them might not be a bad idea anyway so I agree with following their
interpretation. I will note a link to that website in my commit message.

-- 
Tomasz Kramkowski | GPG: 40B037BA0A5B8680 | Web: https://the-tk.com/

---
 drivers/hid/hid-input.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index cf8256aac2bd..cf38ff79cfe9 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1157,12 +1157,15 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 	 * don't specify logical min and max.
 	 */
 	if ((field->flags & HID_MAIN_ITEM_VARIABLE) &&
-	    (field->flags & HID_MAIN_ITEM_NULL_STATE) &&
 	    (field->logical_minimum < field->logical_maximum) &&
 	    (value < field->logical_minimum ||
 	     value > field->logical_maximum)) {
-		dbg_hid("Ignoring out-of-range value %x\n", value);
-		return;
+		if (field->flags & HID_MAIN_ITEM_NULL_STATE) {
+			dbg_hid("Ignoring out-of-range value %x\n", value);
+			return;
+		}
+		value = value < field->logical_minimum ?
+			field->logical_minimum : field->logical_maximum;
 	}
 
 	/*
-- 
2.12.0

