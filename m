From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] HID: debug: improve hid_debug_event()
Date: Tue, 24 Nov 2015 13:33:47 +0100
Message-ID: <1448368427-1669-1-git-send-email-linux@rasmusvillemoes.dk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:32826 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966AbbKXMd4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Nov 2015 07:33:56 -0500
Received: by lfaz4 with SMTP id z4so18552596lfa.0
        for <linux-input@vger.kernel.org>; Tue, 24 Nov 2015 04:33:54 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

The code in hid_debug_event() causes horrible code generation. First,
we do a strlen() call for every byte we copy (we're doing a store to
global memory, so gcc has no way of proving that strlen(buf) doesn't
change). Second, since both i, list->tail and HID_DEBUG_BUFSIZE have
signed type, the modulo computation has to take into account the
possibility that list->tail+i is negative, so it's not just a simple
and.

Fix the former by simply not doing strlen() at all (we have to load
buf[i] anyway, so testing it is almost free) and the latter by
changing i to unsigned. This cuts 29% (69 bytes) of the size of the
function.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/hid/hid-debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 2886b645ced7..acfb522a432a 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -659,13 +659,13 @@ EXPORT_SYMBOL_GPL(hid_dump_device);
 /* enqueue string to 'events' ring buffer */
 void hid_debug_event(struct hid_device *hdev, char *buf)
 {
-	int i;
+	unsigned i;
 	struct hid_debug_list *list;
 	unsigned long flags;
 
 	spin_lock_irqsave(&hdev->debug_list_lock, flags);
 	list_for_each_entry(list, &hdev->debug_list, node) {
-		for (i = 0; i < strlen(buf); i++)
+		for (i = 0; buf[i]; i++)
 			list->hid_debug_buf[(list->tail + i) % HID_DEBUG_BUFSIZE] =
 				buf[i];
 		list->tail = (list->tail + i) % HID_DEBUG_BUFSIZE;
-- 
2.6.1

