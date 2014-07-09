From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 13/14] alps: Cache firmware version
Date: Wed,  9 Jul 2014 17:24:18 +0200
Message-ID: <1404919459-23561-14-git-send-email-hdegoede@redhat.com>
References: <1404919459-23561-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60241 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932604AbaGIPYr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Jul 2014 11:24:47 -0400
In-Reply-To: <1404919459-23561-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yunkang Tang <yunkang.tang@cn.alps.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/alps.c | 3 +++
 drivers/input/mouse/alps.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 140471d..ad3a708 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -1901,6 +1901,9 @@ static int alps_identify(struct psmouse *psmouse, struct alps_data *priv)
 	    alps_exit_command_mode(psmouse))
 		return -EIO;
 
+	/* Save the Firmware version */
+	memcpy(priv->fw_ver, ec, 3);
+
 	if (alps_match_table(psmouse, priv, e7, ec) == 0) {
 		return 0;
 	} else if (e7[0] == 0x73 && e7[1] == 0x03 && e7[2] == 0x50 &&
diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
index 17e3ae3..e3d0f09 100644
--- a/drivers/input/mouse/alps.h
+++ b/drivers/input/mouse/alps.h
@@ -124,6 +124,7 @@ struct alps_fields {
  *   known format for this model.  The first byte of the report, ANDed with
  *   mask0, should match byte0.
  * @mask0: The mask used to check the first byte of the report.
+ * @fw_ver: cached copy of firmware version (EC report)
  * @flags: Additional device capabilities (passthrough port, trackstick, etc.).
  * @x_max: Largest possible X position value.
  * @y_max: Largest possible Y position value.
@@ -149,6 +150,7 @@ struct alps_data {
 	int addr_command;
 	unsigned char proto_version;
 	unsigned char byte0, mask0;
+	unsigned char fw_ver[3];
 	int flags;
 	int x_max;
 	int y_max;
-- 
2.0.0

