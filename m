From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: [PATCH] hid-ntrig.c: Single touch mode tap
Date: Tue, 16 Feb 2010 10:22:11 -0500
Message-ID: <1266333731-2166-1-git-send-email-rafi@seas.upenn.edu>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stag.seas.upenn.edu ([158.130.70.79]:43261 "EHLO
	stag.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756167Ab0BPPW3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Feb 2010 10:22:29 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, jkosina@suse.cz, dmitry.torokhov@gmail.com, rafi@seas.upenn.edu

Add DOUBLETAP to events emitted when in single touch only mode.

Signed-off-by: Rafi Rubin <rafi@seas.upenn.edu>
---
 drivers/hid/hid-ntrig.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index f6f882d..3234c72 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -165,6 +165,8 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
 			 * to emit a normal (X, Y) position
 			 */
 			if (!nd->reading_mt) {
+				input_report_key(input, BTN_TOOL_DOUBLETAP,
+						 (nd->confidence != 0));
 				input_event(input, EV_ABS, ABS_X, nd->x);
 				input_event(input, EV_ABS, ABS_Y, nd->y);
 			}
-- 
1.6.6.1

