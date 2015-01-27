From: Daniel Martin <daniel.martin@secunet.com>
Subject: [PATCH v2 3/5] Input: synaptics - Query min dimensions when safe firmware
Date: Tue, 27 Jan 2015 09:34:03 +0100
Message-ID: <1422347645-5194-4-git-send-email-daniel.martin@secunet.com>
References: <1421945201-1528-1-git-send-email-daniel.martin@secunet.com>
 <1422347645-5194-1-git-send-email-daniel.martin@secunet.com>
Reply-To: Daniel Martin <consume.noise@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from a.mx.secunet.com ([195.81.216.161]:52769 "EHLO a.mx.secunet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753539AbbA0I2d (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Jan 2015 03:28:33 -0500
In-Reply-To: <1422347645-5194-1-git-send-email-daniel.martin@secunet.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: hdegoede@redhat.com, Daniel Martin <consume.noise@gmail.com>

From: Daniel Martin <consume.noise@gmail.com>

Query the min dimensions even if the check
    SYN_EXT_CAP_REQUESTS(priv->capabilities) >= 7
fails, but we know that the firmware version is safe. Atm. this is
version 8.1 only.

With that we don't need quirks for post-2013 models anymore as they
expose correct min and max dimensions.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=91541
Signed-off-by: Daniel Martin <consume.noise@gmail.com>
---
 drivers/input/mouse/synaptics.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 7a78d75..37d4dff 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -333,6 +333,30 @@ static int synaptics_identify(struct psmouse *psmouse)
 	return -1;
 }
 
+struct fw_version {
+	unsigned char major;
+	unsigned char minor;
+};
+
+static const struct fw_version safe_fw_list[] = {
+	{8, 1}, /* safe for SYN_QUE_EXT_MIN_COORDS */
+	{ }
+};
+
+static bool synaptics_is_safe_fw(struct psmouse *psmouse)
+{
+	struct synaptics_data *priv = psmouse->private;
+	int i;
+
+	for (i = 0; safe_fw_list[i].major; i++) {
+		if (safe_fw_list[i].major == SYN_ID_MAJOR(priv->identity) &&
+		    safe_fw_list[i].minor == SYN_ID_MINOR(priv->identity))
+			return true;
+	}
+
+	return false;
+}
+
 /*
  * Read touchpad resolution and maximum reported coordinates
  * Resolution is left zero if touchpad does not support the query
@@ -368,7 +392,8 @@ static int synaptics_resolution(struct psmouse *psmouse)
 		}
 	}
 
-	if (SYN_EXT_CAP_REQUESTS(priv->capabilities) >= 7 &&
+	if ((SYN_EXT_CAP_REQUESTS(priv->capabilities) >= 7 ||
+	     synaptics_is_safe_fw(psmouse)) &&
 	    SYN_CAP_MIN_DIMENSIONS(priv->ext_cap_0c)) {
 		if (synaptics_send_cmd(psmouse, SYN_QUE_EXT_MIN_COORDS, resp)) {
 			psmouse_warn(psmouse,
-- 
2.2.2

