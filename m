From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [RFC 1/6] Input: mt: make input_mt_assign_slots() a little bit more readable
Date: Mon, 19 Jan 2015 15:53:50 -0500
Message-ID: <1421700835-22157-2-git-send-email-benjamin.tissoires@redhat.com>
References: <1421700835-22157-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421700835-22157-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Rename "nrc" into "n_elems" and explicitly name the number of
rows and the number of columns.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/input-mt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c
index fbe29fc..b6ee42a 100644
--- a/drivers/input/input-mt.c
+++ b/drivers/input/input-mt.c
@@ -404,7 +404,7 @@ int input_mt_assign_slots(struct input_dev *dev, int *slots,
 			  const struct input_mt_pos *pos, int num_pos)
 {
 	struct input_mt *mt = dev->mt;
-	int nrc;
+	int n_elems, n_rows, n_columns;
 
 	if (!mt || !mt->red)
 		return -ENXIO;
@@ -413,8 +413,10 @@ int input_mt_assign_slots(struct input_dev *dev, int *slots,
 	if (num_pos < 1)
 		return 0;
 
-	nrc = input_mt_set_matrix(mt, pos, num_pos);
-	find_reduced_matrix(mt->red, num_pos, nrc / num_pos, nrc);
+	n_elems = input_mt_set_matrix(mt, pos, num_pos);
+	n_rows = n_elems / num_pos;
+	n_columns = num_pos;
+	find_reduced_matrix(mt->red, n_columns, n_rows, n_elems);
 	input_mt_set_slots(mt, slots, num_pos);
 
 	return 0;
-- 
2.1.0
