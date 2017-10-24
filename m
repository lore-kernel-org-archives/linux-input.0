From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: gtco - fix potential out-of-bound access
Date: Mon, 23 Oct 2017 22:28:23 -0700
Message-ID: <20171024052823.jpetpk2bfazfvfah@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:45657 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751399AbdJXF21 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 24 Oct 2017 01:28:27 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Andrey Konovalov <andreyknvl@google.com>, linux-kernel@vger.kernel.org

parse_hid_report_descriptor() has a while (i < length) loop, which
only guarantees that there's at least 1 byte in the buffer, but the
loop body can read multiple bytes which causes out-of-bounds access.

Reported-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/tablet/gtco.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/input/tablet/gtco.c b/drivers/input/tablet/gtco.c
index b796e891e2ee..0351203b8c24 100644
--- a/drivers/input/tablet/gtco.c
+++ b/drivers/input/tablet/gtco.c
@@ -230,13 +230,24 @@ static void parse_hid_report_descriptor(struct gtco *device, char * report,
 
 	/* Walk  this report and pull out the info we need */
 	while (i < length) {
-		prefix = report[i];
-
-		/* Skip over prefix */
-		i++;
+		prefix = report[i++];
 
 		/* Determine data size and save the data in the proper variable */
-		size = PREF_SIZE(prefix);
+		if (PREF_SIZE(prefix) < 1) {
+			dev_err(ddev,
+				"Invalid size %d in element at offset %d\n",
+				PREF_SIZE(prefix), i);
+			break;
+		}
+
+		size = 1U << (PREF_SIZE(prefix) - 1);
+		if (i + size >= length) {
+			dev_err(ddev,
+				"Not enough data (need %d, have %d)\n",
+				i + size, length);
+			break;
+		}
+
 		switch (size) {
 		case 1:
 			data = report[i];
@@ -244,8 +255,7 @@ static void parse_hid_report_descriptor(struct gtco *device, char * report,
 		case 2:
 			data16 = get_unaligned_le16(&report[i]);
 			break;
-		case 3:
-			size = 4;
+		case 4:
 			data32 = get_unaligned_le32(&report[i]);
 			break;
 		}
-- 
2.15.0.rc0.271.g36b669edcc-goog


-- 
Dmitry
