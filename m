From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 1/3] Input: mt - prevent balanced slot assignment to assign twice the slot
Date: Mon, 30 Mar 2015 18:09:26 -0400
Message-ID: <1427753368-2795-2-git-send-email-benjamin.tissoires@redhat.com>
References: <1427753368-2795-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427753368-2795-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Hans de Goede <hdegoede@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

If two touches are under the dmax distance, it looks like they can now
be assigned to the same slot. Add a band aid to prevent such situation
and be able to use the balanced slot assignment.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/input-mt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c
index cb150a1..ad74f64 100644
--- a/drivers/input/input-mt.c
+++ b/drivers/input/input-mt.c
@@ -371,11 +371,16 @@ static void input_mt_set_slots(struct input_mt *mt,
 		*p = -1;
 
 	for (s = mt->slots; s != mt->slots + mt->num_slots; s++) {
+		bool found = false;
+
 		if (!input_mt_is_active(s))
 			continue;
 		for (p = slots; p != slots + num_pos; p++)
-			if (*w++ < 0)
+			if ((*w++ < 0) && !found) {
 				*p = s - mt->slots;
+				/* no break here: w won't be incremented */
+				found = true;
+			}
 	}
 
 	for (s = mt->slots; s != mt->slots + mt->num_slots; s++) {
-- 
2.3.4
