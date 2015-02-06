From: Daniel Martin <daniel.martin@secunet.com>
Subject: [PATCH 3/5] Input: synaptics - Query min dimensions for fw v8.1
Date: Fri, 6 Feb 2015 14:25:06 +0100
Message-ID: <1423229108-29268-4-git-send-email-daniel.martin@secunet.com>
References: <1423229108-29268-1-git-send-email-daniel.martin@secunet.com>
Reply-To: Daniel Martin <consume.noise@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from a.mx.secunet.com ([195.81.216.161]:41585 "EHLO a.mx.secunet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754046AbbBFNT3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 6 Feb 2015 08:19:29 -0500
In-Reply-To: <1423229108-29268-1-git-send-email-daniel.martin@secunet.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Daniel Martin <consume.noise@gmail.com>

From: Daniel Martin <consume.noise@gmail.com>

Query the min dimensions even if the check
    SYN_EXT_CAP_REQUESTS(priv->capabilities) >= 7
fails, but we know that the firmware version 8.1 is safe.

With that we don't need quirks for post-2013 models anymore as they
expose correct min and max dimensions.

v2: Don't use a list for safe firmwares.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=91541
Signed-off-by: Daniel Martin <consume.noise@gmail.com>
---
 drivers/input/mouse/synaptics.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 7a78d75..0b7805c 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -368,8 +368,13 @@ static int synaptics_resolution(struct psmouse *psmouse)
 		}
 	}
 
-	if (SYN_EXT_CAP_REQUESTS(priv->capabilities) >= 7 &&
-	    SYN_CAP_MIN_DIMENSIONS(priv->ext_cap_0c)) {
+	if ((SYN_EXT_CAP_REQUESTS(priv->capabilities) >= 7 &&
+	     SYN_CAP_MIN_DIMENSIONS(priv->ext_cap_0c)) ||
+	    /* Firmware v8.1 doesn't stand the previous checks, though has
+	     * been proven to report correct min coordinates.
+	     *     https://bugzilla.kernel.org/show_bug.cgi?id=91541 */
+	    (SYN_ID_MAJOR(priv->identity) == 8 &&
+	     SYN_ID_MINOR(priv->identity) == 1)) {
 		if (synaptics_send_cmd(psmouse, SYN_QUE_EXT_MIN_COORDS, resp)) {
 			psmouse_warn(psmouse,
 				     "device claims to have min coordinates query, but I'm not able to read it.\n");
-- 
2.2.2

