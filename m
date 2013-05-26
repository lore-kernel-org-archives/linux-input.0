From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 28/26] HID: wiimote: discard invalid EXT data reports
Date: Sun, 26 May 2013 22:55:03 +0200
Message-ID: <1369601704-2311-2-git-send-email-dh.herrmann@gmail.com>
References: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
 <1369601704-2311-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f48.google.com ([209.85.214.48]:61803 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755145Ab3EZU4D (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 26 May 2013 16:56:03 -0400
Received: by mail-bk0-f48.google.com with SMTP id jf20so1840722bkc.7
        for <linux-input@vger.kernel.org>; Sun, 26 May 2013 13:56:02 -0700 (PDT)
In-Reply-To: <1369601704-2311-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

If an extension device isn't initialized properly, or during hardware
initialization, a device might send extension data which is all 0xff.
This is ambigious because this is also a valid normal data report. But
it is impossible, under normal conditions, to trigger valid reports with
all 0xff. Hence, we can safely ignore them.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/hid-wiimote-core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index f54595c..40fdc62 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -1335,11 +1335,19 @@ static bool valid_ext_handler(const struct wiimod_ops *ops, size_t len)
 static void handler_ext(struct wiimote_data *wdata, const __u8 *payload,
 			size_t len)
 {
+	static const __u8 invalid[21] = { 0xff, 0xff, 0xff, 0xff,
+					  0xff, 0xff, 0xff, 0xff,
+					  0xff, 0xff, 0xff, 0xff,
+					  0xff, 0xff, 0xff, 0xff,
+					  0xff, 0xff, 0xff, 0xff,
+					  0xff };
 	const __u8 *iter, *mods;
 	const struct wiimod_ops *ops;
 	bool is_mp;
 
-	if (len < 6)
+	if (len > 21)
+		len = 21;
+	if (len < 6 || !memcmp(payload, invalid, len))
 		return;
 
 	/* if MP is active, track MP slot hotplugging */
-- 
1.8.2.3

