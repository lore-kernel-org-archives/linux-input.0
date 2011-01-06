From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] input: move check for same handler in input_pass_event
Date: Thu,  6 Jan 2011 14:24:48 -0800
Message-ID: <1294352688-29564-1-git-send-email-kristen@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:3362 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754373Ab1AFWXS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 6 Jan 2011 17:23:18 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Kristen Carlson Accardi <kristen@linux.intel.com>

If the handler that injected an event is the same,
just skip the filter, but allow the handler->event()
routine to be called.  This allows evdev to be able to
be used to loopback events.
---
 drivers/input/input.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index db409d6..cdeb929 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -98,16 +98,15 @@ static void input_pass_event(struct input_dev *dev,
 			 * particular event we want to skip it to avoid
 			 * filters firing again and again.
 			 */
-			if (handler == src_handler)
-				continue;
-
 			if (!handler->filter) {
 				if (filtered)
 					break;
 
 				handler->event(handle, type, code, value);
 
-			} else if (handler->filter(handle, type, code, value))
+			} else if (handler != src_handler &&
+					handler->filter(handle, type, code,
+								value))
 				filtered = true;
 		}
 	}
-- 
1.7.2.3

