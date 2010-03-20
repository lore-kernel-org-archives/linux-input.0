From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH] input: mt: clarify the no-finger event
Date: Sat, 20 Mar 2010 23:18:06 +0100
Message-ID: <1269123486-2621-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:57417 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752246Ab0CTWT6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 20 Mar 2010 18:19:58 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

The current documentation does not explicitly specify how to report
zero fingers, leaving a potential problem in the driver implementations
and giving no parsing directive to userland. This patch defines two
equally valid ways.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 Documentation/input/multi-touch-protocol.txt |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/Documentation/input/multi-touch-protocol.txt b/Documentation/input/multi-touch-protocol.txt
index 8490480..eacb226 100644
--- a/Documentation/input/multi-touch-protocol.txt
+++ b/Documentation/input/multi-touch-protocol.txt
@@ -68,6 +68,22 @@ like:
    SYN_MT_REPORT
    SYN_REPORT
 
+Here is the sequence after lifting one of the fingers:
+
+   ABS_MT_POSITION_X
+   ABS_MT_POSITION_Y
+   SYN_MT_REPORT
+   SYN_REPORT
+
+And here is the sequence after lifting the remaining finger:
+
+   SYN_MT_REPORT
+   SYN_REPORT
+
+If the driver reports one of BTN_TOUCH or ABS_PRESSURE in addition to the
+ABS_MT events, the last SYN_MT_REPORT event may be omitted. Otherwise, the
+last SYN_REPORT will be dropped by the input core, resulting in no
+zero-finger event reaching userland.
 
 Event Semantics
 ---------------
-- 
1.6.3.3

