From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] HID: debug: fix error handling in hid_debug_events_read()
Date: Thu, 9 Apr 2015 13:32:35 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1504091331420.10724@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40380 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932993AbbDILcg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 9 Apr 2015 07:32:36 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jslaby@suse.cz, linux-kernel@vger.kernel.org

In the unlikely case of hdev vanishing while hid_debug_events_read() was 
sleeping, we can really break out of the case switch as with other cases, 
as on the way out we'll try to remove ourselves from the hdev waitqueue.

Fix this by taking a shortcut exit path and avoiding cleanup that doesn't 
make sense in case hdev doesn't exist any more anyway.

Reported-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/hid/hid-debug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 8bf61d2..f5021fb 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -1127,7 +1127,8 @@ static ssize_t hid_debug_events_read(struct file *file, char __user *buffer,
 
 				if (!list->hdev || !list->hdev->debug) {
 					ret = -EIO;
-					break;
+					set_current_state(TASK_RUNNING);
+					goto out;
 				}
 
 				/* allow O_NONBLOCK from other threads */
-- 
Jiri Kosina
SUSE Labs
