From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] HID: hid-gfrm: avoid warning for input_configured API change
Date: Tue, 03 Nov 2015 15:56:34 +0100
Message-ID: <14835877.IL6ArpWV8Q@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:50059 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130AbbKCO52 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Nov 2015 09:57:28 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Petri Gynther <pgynther@google.com>, linux-arm-kernel@lists.infradead.org

The input_configured callback was recently changed to return
an 'int', but the newly added driver uses the old API:

drivers/hid/hid-gfrm.c:151:22: warning: initialization from incompatible pointer type [-Wincompatible-pointer-types]

This changes the driver like the other ones.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 34fc1322e7aa ("HID: hid-gfrm: Google Fiber TV Box remote controls")
Fixes: b2c68a2f1bab ("HID: hid-input: allow input_configured callback return errors")
---
Found on ARM allmodconfig with yesterday's linux-next

diff --git a/drivers/hid/hid-gfrm.c b/drivers/hid/hid-gfrm.c
index 4d7b7e7f0792..075b1c020846 100644
--- a/drivers/hid/hid-gfrm.c
+++ b/drivers/hid/hid-gfrm.c
@@ -88,7 +88,7 @@ static int gfrm_raw_event(struct hid_device *hdev, struct hid_report *report,
 	return (ret < 0) ? ret : -1;
 }
 
-static void gfrm_input_configured(struct hid_device *hid, struct hid_input *hidinput)
+static int gfrm_input_configured(struct hid_device *hid, struct hid_input *hidinput)
 {
 	/*
 	 * Enable software autorepeat with:
@@ -96,6 +96,7 @@ static void gfrm_input_configured(struct hid_device *hid, struct hid_input *hidi
 	 * - repeat period: 100 msec
 	 */
 	input_enable_softrepeat(hidinput->input, 400, 100);
+	return 0;
 }
 
 static int gfrm_probe(struct hid_device *hdev, const struct hid_device_id *id)

