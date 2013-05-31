From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: [PATCH] doc: specify that ABS_MT_SLOT must have a minimum of 0
Date: Fri, 31 May 2013 16:29:44 +1000
Message-ID: <20130531062944.GA915@yabbi.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:60540 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161Ab3EaG7s (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 May 2013 02:59:48 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>

This is effectively already in force through input_mt_init_slots, and uinput
too ignores the actual minimum.

Since slots are a kernel-genenerated axis only, non-zero minimums make
little sense and are likely to cause errors. Better to treat a non-zero
minimum as kernel bug if it ever happens.

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
I admit that sentence looks a bit lost there, if you want to move this
elsewhere to have more exposure I'm happy to do so once I figure out where.

 Documentation/input/multi-touch-protocol.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/input/multi-touch-protocol.txt b/Documentation/input/multi-touch-protocol.txt
index 2c17961..de139b1 100644
--- a/Documentation/input/multi-touch-protocol.txt
+++ b/Documentation/input/multi-touch-protocol.txt
@@ -80,6 +80,8 @@ Userspace can detect that a driver can report more total contacts than slots
 by noting that the largest supported BTN_TOOL_*TAP event is larger than the
 total number of type B slots reported in the absinfo for the ABS_MT_SLOT axis.
 
+The minimum value of the ABS_MT_SLOT axis must be 0.
+
 Protocol Example A
 ------------------
 
-- 
1.8.2.1

