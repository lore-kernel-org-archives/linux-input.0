From: Chase Douglas <chase.douglas@canonical.com>
Subject: [PATCH] HID: bump maximum global item tag report size to 96 bytes
Date: Mon,  7 Nov 2011 11:08:05 -0800
Message-ID: <1320692885-25733-1-git-send-email-chase.douglas@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:40104 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752933Ab1KGTIL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Nov 2011 14:08:11 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

This allows the latest N-Trig devices to function properly.

BugLink: https://bugs.launchpad.net/bugs/724831

Cc: stable@vger.kernel.org
Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
---
I have no clue if this is according to spec or not. I only know that this
change makes two users' N-Trig devices work properly in the above bug.

 drivers/hid/hid-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 848a56c..6113996 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -362,7 +362,7 @@ static int hid_parser_global(struct hid_parser *parser, struct hid_item *item)
 
 	case HID_GLOBAL_ITEM_TAG_REPORT_SIZE:
 		parser->global.report_size = item_udata(item);
-		if (parser->global.report_size > 32) {
+		if (parser->global.report_size > 96) {
 			dbg_hid("invalid report_size %d\n",
 					parser->global.report_size);
 			return -1;
-- 
1.7.5.4

