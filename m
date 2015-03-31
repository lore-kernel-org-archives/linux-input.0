From: Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: [PATCH 1/3] Input: mt - prevent balanced slot assignment to
 assign twice the slot
Date: Tue, 31 Mar 2015 09:24:30 +0200
Message-ID: <20150331072430.GA25785@polaris.bitmath.org>
References: <1427753368-2795-1-git-send-email-benjamin.tissoires@redhat.com>
 <1427753368-2795-2-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailrelay2.public.one.com ([91.198.169.125]:36648 "EHLO
	mailrelay2.public.one.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628AbbCaHkI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Mar 2015 03:40:08 -0400
Content-Disposition: inline
In-Reply-To: <1427753368-2795-2-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Benjamin,

> If two touches are under the dmax distance, it looks like they can now
> be assigned to the same slot. Add a band aid to prevent such situation
> and be able to use the balanced slot assignment.

Yes, great find. You patch is correct, but it is not a band aid, but a
result stemming from a limitation in how equality constraints (read
unique assignments) can be handled in the iterative algorithm. This
cannot happen in the original algorithm, because of the extra
penalization for overcovers.

Here is an alternative version which cleans up the loop logic
somewhat, together with a different commit message. I did not have any
opportunity to check this in hardware. I you like it and find it
working, then please take over the authorship and just add a
signed-off from me.

Thanks,
Henrik

---

>From e00d63f6cadf20d871bed763b3531428b34d785c Mon Sep 17 00:00:00 2001
From: Henrik Rydberg <rydberg@bitmath.org>
Date: Tue, 31 Mar 2015 09:10:02 +0200
Subject: [PATCH] Input: MT - make slot assignment work for overcovered
 solutions

The recent inclusion of a deassignment cost in the slot assignment
algorithm did not properly account for the corner cases where the
solutions are overcovered. This patch makes sure the resulting assignment
is unique, allocating new slots when necessary.

UNTESTED
---
 drivers/input/input-mt.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c
index fbe29fc..17e80a6 100644
--- a/drivers/input/input-mt.c
+++ b/drivers/input/input-mt.c
@@ -363,25 +363,28 @@ static void input_mt_set_slots(struct input_mt *mt,
 			       int *slots, int num_pos)
 {
 	struct input_mt_slot *s;
-	int *w = mt->red, *p;
+	int *w = mt->red, j;
 
-	for (p = slots; p != slots + num_pos; p++)
-		*p = -1;
+	for (j = 0; j != num_pos; j++)
+		slots[j] = -1;
 
 	for (s = mt->slots; s != mt->slots + mt->num_slots; s++) {
 		if (!input_mt_is_active(s))
 			continue;
-		for (p = slots; p != slots + num_pos; p++)
-			if (*w++ < 0)
-				*p = s - mt->slots;
+		for (j = 0; j != num_pos; j++)
+			if (w[j] < 0) {
+				slots[j] = s - mt->slots;
+				break;
+			}
+		w += num_pos;
 	}
 
 	for (s = mt->slots; s != mt->slots + mt->num_slots; s++) {
 		if (input_mt_is_active(s))
 			continue;
-		for (p = slots; p != slots + num_pos; p++)
-			if (*p < 0) {
-				*p = s - mt->slots;
+		for (j = 0; j != num_pos; j++)
+			if (slots[j] < 0) {
+				slots[j] = s - mt->slots;
 				break;
 			}
 	}
-- 
2.3.0

