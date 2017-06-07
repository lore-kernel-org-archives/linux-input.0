From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 7/8] greybus: hid: remove custom locking from gb_hid_open/close
Date: Tue,  6 Jun 2017 23:59:37 -0700
Message-ID: <20170607065938.33332-8-dmitry.torokhov@gmail.com>
References: <20170607065938.33332-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35822 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751584AbdFGG7r (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 7 Jun 2017 02:59:47 -0400
In-Reply-To: <20170607065938.33332-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Now that HID core enforces serialization of transport driver open/close
calls we can remove custom locking from greybus hid driver.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/staging/greybus/hid.c | 43 ++++++++++++++-----------------------------
 1 file changed, 14 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/greybus/hid.c b/drivers/staging/greybus/hid.c
index 730d746fc4c2..465101bbab69 100644
--- a/drivers/staging/greybus/hid.c
+++ b/drivers/staging/greybus/hid.c
@@ -32,8 +32,6 @@ struct gb_hid {
 	char				*inbuf;
 };
 
-static DEFINE_MUTEX(gb_hid_open_mutex);
-
 /* Routines to get controller's information over greybus */
 
 /* Operations performed on greybus */
@@ -346,19 +344,14 @@ static void gb_hid_stop(struct hid_device *hid)
 static int gb_hid_open(struct hid_device *hid)
 {
 	struct gb_hid *ghid = hid->driver_data;
-	int ret = 0;
-
-	mutex_lock(&gb_hid_open_mutex);
-	if (!hid->open++) {
-		ret = gb_hid_set_power(ghid, GB_HID_TYPE_PWR_ON);
-		if (ret < 0)
-			hid->open--;
-		else
-			set_bit(GB_HID_STARTED, &ghid->flags);
-	}
-	mutex_unlock(&gb_hid_open_mutex);
+	int ret;
 
-	return ret;
+	ret = gb_hid_set_power(ghid, GB_HID_TYPE_PWR_ON);
+	if (ret < 0)
+		return ret;
+
+	set_bit(GB_HID_STARTED, &ghid->flags);
+	return 0;
 }
 
 static void gb_hid_close(struct hid_device *hid)
@@ -366,21 +359,13 @@ static void gb_hid_close(struct hid_device *hid)
 	struct gb_hid *ghid = hid->driver_data;
 	int ret;
 
-	/*
-	 * Protecting hid->open to make sure we don't restart data acquistion
-	 * due to a resumption we no longer care about..
-	 */
-	mutex_lock(&gb_hid_open_mutex);
-	if (!--hid->open) {
-		clear_bit(GB_HID_STARTED, &ghid->flags);
-
-		/* Save some power */
-		ret = gb_hid_set_power(ghid, GB_HID_TYPE_PWR_OFF);
-		if (ret)
-			dev_err(&ghid->connection->bundle->dev,
-				"failed to power off (%d)\n", ret);
-	}
-	mutex_unlock(&gb_hid_open_mutex);
+	clear_bit(GB_HID_STARTED, &ghid->flags);
+
+	/* Save some power */
+	ret = gb_hid_set_power(ghid, GB_HID_TYPE_PWR_OFF);
+	if (ret)
+		dev_err(&ghid->connection->bundle->dev,
+			"failed to power off (%d)\n", ret);
 }
 
 static int gb_hid_power(struct hid_device *hid, int lvl)
-- 
2.13.0.506.g27d5fe0cd-goog

