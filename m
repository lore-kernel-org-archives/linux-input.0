From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] HID: logitech-dj: small cleanup in rdcat()
Date: Sat, 19 Oct 2013 12:08:59 +0300
Message-ID: <20131019090859.GD9312@longonot.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:36006 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940Ab3JSJMI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Oct 2013 05:12:08 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

We could pass the "rdsec" pointer instead of the address of the "rdesc"
and it's a little simpler.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 2e53024..a7947d8 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -542,9 +542,9 @@ static int logi_dj_output_hidraw_report(struct hid_device *hid, u8 * buf,
 	return 0;
 }
 
-static void rdcat(char **rdesc, unsigned int *rsize, const char *data, unsigned int size)
+static void rdcat(char *rdesc, unsigned int *rsize, const char *data, unsigned int size)
 {
-	memcpy(*rdesc + *rsize, data, size);
+	memcpy(rdesc + *rsize, data, size);
 	*rsize += size;
 }
 
@@ -567,31 +567,31 @@ static int logi_dj_ll_parse(struct hid_device *hid)
 	if (djdev->reports_supported & STD_KEYBOARD) {
 		dbg_hid("%s: sending a kbd descriptor, reports_supported: %x\n",
 			__func__, djdev->reports_supported);
-		rdcat(&rdesc, &rsize, kbd_descriptor, sizeof(kbd_descriptor));
+		rdcat(rdesc, &rsize, kbd_descriptor, sizeof(kbd_descriptor));
 	}
 
 	if (djdev->reports_supported & STD_MOUSE) {
 		dbg_hid("%s: sending a mouse descriptor, reports_supported: "
 			"%x\n", __func__, djdev->reports_supported);
-		rdcat(&rdesc, &rsize, mse_descriptor, sizeof(mse_descriptor));
+		rdcat(rdesc, &rsize, mse_descriptor, sizeof(mse_descriptor));
 	}
 
 	if (djdev->reports_supported & MULTIMEDIA) {
 		dbg_hid("%s: sending a multimedia report descriptor: %x\n",
 			__func__, djdev->reports_supported);
-		rdcat(&rdesc, &rsize, consumer_descriptor, sizeof(consumer_descriptor));
+		rdcat(rdesc, &rsize, consumer_descriptor, sizeof(consumer_descriptor));
 	}
 
 	if (djdev->reports_supported & POWER_KEYS) {
 		dbg_hid("%s: sending a power keys report descriptor: %x\n",
 			__func__, djdev->reports_supported);
-		rdcat(&rdesc, &rsize, syscontrol_descriptor, sizeof(syscontrol_descriptor));
+		rdcat(rdesc, &rsize, syscontrol_descriptor, sizeof(syscontrol_descriptor));
 	}
 
 	if (djdev->reports_supported & MEDIA_CENTER) {
 		dbg_hid("%s: sending a media center report descriptor: %x\n",
 			__func__, djdev->reports_supported);
-		rdcat(&rdesc, &rsize, media_descriptor, sizeof(media_descriptor));
+		rdcat(rdesc, &rsize, media_descriptor, sizeof(media_descriptor));
 	}
 
 	if (djdev->reports_supported & KBD_LEDS) {
