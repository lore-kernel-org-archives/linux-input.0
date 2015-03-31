From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 1/3] Input: MT - make slot assignment work for overcovered solutions
Date: Tue, 31 Mar 2015 11:07:35 -0400
Message-ID: <1427814457-30120-2-git-send-email-benjamin.tissoires@redhat.com>
References: <1427814457-30120-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46548 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754234AbbCaPHp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Mar 2015 11:07:45 -0400
In-Reply-To: <1427814457-30120-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Hans de Goede <hdegoede@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

The recent inclusion of a deassignment cost in the slot assignment
algorithm did not properly account for the corner cases where the
solutions are overcovered. This patch makes sure the resulting assignment
is unique, allocating new slots when necessary.

Signed-off-by: Henrik Rydberg <rydberg@bitmath.org>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
---

changes in v2:
- used Henrik's version, took authorship and added s-o-b
- acked by Hans

 drivers/input/input-mt.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c
index cb150a1..f4de3ee 100644
--- a/drivers/input/input-mt.c
+++ b/drivers/input/input-mt.c
@@ -365,25 +365,28 @@ static void input_mt_set_slots(struct input_mt *mt,
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
2.3.4

