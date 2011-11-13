From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 16/16] HID: wiimote: Enable NO_INIT_REPORTS quirk
Date: Sun, 13 Nov 2011 14:27:19 +0100
Message-ID: <1321190839-3517-17-git-send-email-dh.herrmann@googlemail.com>
References: <1321190839-3517-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48117 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753673Ab1KMN2S (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Nov 2011 08:28:18 -0500
Received: by mail-bw0-f46.google.com with SMTP id 11so4910943bke.19
        for <linux-input@vger.kernel.org>; Sun, 13 Nov 2011 05:28:17 -0800 (PST)
In-Reply-To: <1321190839-3517-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, David Herrmann <dh.herrmann@googlemail.com>

Newer bluetooth core supports the NO_INIT_REPORTS quirk. We need this for the
wiimote as it does not support report-initialization.
Also bump version level as we are almost feature complete now.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote-core.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 745667e..7ea8754 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -22,7 +22,7 @@
 #include "hid-ids.h"
 #include "hid-wiimote.h"
 
-#define WIIMOTE_VERSION "0.2"
+#define WIIMOTE_VERSION "0.3"
 
 enum wiiproto_keys {
 	WIIPROTO_KEY_LEFT,
@@ -1177,6 +1177,8 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 	struct wiimote_data *wdata;
 	int ret;
 
+	hdev->quirks |= HID_QUIRK_NO_INIT_REPORTS;
+
 	wdata = wiimote_create(hdev);
 	if (!wdata) {
 		hid_err(hdev, "Can't alloc device\n");
-- 
1.7.7.3

