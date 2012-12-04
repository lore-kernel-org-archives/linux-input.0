From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: [PATCH 05/14] HID: i2c-hid: fix i2c_hid_dbg macro
Date: Tue,  4 Dec 2012 16:27:46 +0100
Message-ID: <1354634875-5182-6-git-send-email-benjamin.tissoires@gmail.com>
References: <1354634875-5182-1-git-send-email-benjamin.tissoires@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:62769 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353Ab2LDPfX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Dec 2012 10:35:23 -0500
In-Reply-To: <1354634875-5182-1-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Jean Delvare <khali@linux-fr.org>, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

This avoids the problematic case:

if (condition)
	i2c_hid_dbg(ihid, "Blah blah %d\n", i);
else
	do_something_very_important();

Which looks correct, however with the previous macro definition,
this expands to the unexpected:

if (condition) {
	if (debug)	\
		dev_printk(KERN_DEBUG, &ihid->client->dev,
				"Blah blah %d\n", i);
	else
		do_something_very_important();
}

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
---
 drivers/hid/i2c-hid/i2c-hid.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 9ee6555..54950be 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -50,9 +50,11 @@ static bool debug;
 module_param(debug, bool, 0444);
 MODULE_PARM_DESC(debug, "print a lot of debug information");
 
-#define i2c_hid_dbg(ihid, fmt, arg...)	\
-	if (debug)			\
-		dev_printk(KERN_DEBUG, &(ihid)->client->dev, fmt, ##arg)
+#define i2c_hid_dbg(ihid, fmt, arg...)					  \
+do {									  \
+	if (debug)							  \
+		dev_printk(KERN_DEBUG, &(ihid)->client->dev, fmt, ##arg); \
+} while (0)
 
 struct i2c_hid_desc {
 	__le16 wHIDDescLength;
-- 
1.8.0.1

