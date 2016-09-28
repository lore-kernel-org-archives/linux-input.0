From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 12/12] Input: synaptics-rmi4 - fix documentation of rmi_2d_sensor_platform_data
Date: Wed, 28 Sep 2016 10:35:47 +0200
Message-ID: <1475051747-25988-13-git-send-email-benjamin.tissoires@redhat.com>
References: <1475051747-25988-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47542 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752204AbcI1IgR (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 28 Sep 2016 04:36:17 -0400
In-Reply-To: <1475051747-25988-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lyude Paul <thatslyude@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Typos...

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

new in v2
---
 include/linux/rmi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rmi.h b/include/linux/rmi.h
index 02e1dae..a4bbe90 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -106,7 +106,7 @@ struct rmi_2d_sensor_platform_data {
  * @buttonpad - the touchpad is a buttonpad, so enable only the first actual
  * button that is found.
  * @trackstick_buttons - Set when the function 30 is handling the physical
- * buttons of the trackstick (as a PD/2 passthrough device.
+ * buttons of the trackstick (as a PS/2 passthrough device).
  * @disable - the touchpad incorrectly reports F30 and it should be ignored.
  * This is a special case which is due to misconfigured firmware.
  */
-- 
2.7.4

