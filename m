From: srinivas pandruvada <srinivas.pandruvada@intel.com>
Subject: [PATCH] hid_parse failure
Date: Thu, 10 May 2012 16:45:31 -0700
Message-ID: <1336693531-13613-1-git-send-email-srinivas.pandruvada@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:40088 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751239Ab2EJX5s (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 10 May 2012 19:57:48 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, srinivas pandruvada <srinivas.pandruvada@intel.com>

When logical maximum is 0xffffffff, the parser fails even if
logical minimum is more than 0.
By HID specification this is a valid combination.

Signed-off-by: srinivas pandruvada <srinivas.pandruvada@intel.com>
---
 drivers/hid/hid-core.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 4da66b4..b7d758c 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -230,9 +230,15 @@ static int hid_add_field(struct hid_parser *parser, unsigned report_type, unsign
 		return -1;
 	}
 
-	if (parser->global.logical_maximum < parser->global.logical_minimum) {
-		hid_err(parser->device, "logical range invalid %d %d\n",
-				parser->global.logical_minimum, parser->global.logical_maximum);
+	if ((parser->global.logical_minimum < 0 &&
+		parser->global.logical_maximum <
+		parser->global.logical_minimum) ||
+		(parser->global.logical_minimum >= 0 &&
+		(__u32)parser->global.logical_maximum <
+		(__u32)parser->global.logical_minimum)) {
+		dbg_hid("logical range invalid 0x%x 0x%x\n",
+			parser->global.logical_minimum,
+			parser->global.logical_maximum);
 		return -1;
 	}
 
-- 
1.7.7.6

