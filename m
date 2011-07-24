From: jeffbrown@android.com
Subject: [PATCH 1/3] hid-debug: Show application usage for each collection.
Date: Sun, 24 Jul 2011 15:07:39 -0700
Message-ID: <1311545261-34067-1-git-send-email-jeffbrown@android.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:37291 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423Ab1GXWHv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 24 Jul 2011 18:07:51 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, rydberg@euromail.se, chatty@enac.fr, benjamin.tissoires@enac.fr, Jeff Brown <jeffbrown@google.com>, jeffbrown@android.com

From: Jeff Brown <jeffbrown@google.com>

Signed-off-by: jeffbrown@android.com
---
 drivers/hid/hid-debug.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index bae4874..9a243ca 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -450,6 +450,11 @@ void hid_dump_field(struct hid_field *field, int n, struct seq_file *f) {
 		seq_printf(f, "Logical(");
 		hid_resolv_usage(field->logical, f); seq_printf(f, ")\n");
 	}
+	if (field->application) {
+		tab(n, f);
+		seq_printf(f, "Application(");
+		hid_resolv_usage(field->application, f); seq_printf(f, ")\n");
+	}
 	tab(n, f); seq_printf(f, "Usage(%d)\n", field->maxusage);
 	for (j = 0; j < field->maxusage; j++) {
 		tab(n+2, f); hid_resolv_usage(field->usage[j].hid, f); seq_printf(f, "\n");
-- 
1.7.0.4

