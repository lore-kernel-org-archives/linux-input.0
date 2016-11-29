From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 01/13] Input: synaptics-rmi4 - fix documentation of rmi_2d_sensor_platform_data
Date: Tue, 29 Nov 2016 11:08:12 +0100
Message-ID: <1480414104-8524-2-git-send-email-benjamin.tissoires@redhat.com>
References: <1480414104-8524-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933146AbcK2KIb (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 29 Nov 2016 05:08:31 -0500
In-Reply-To: <1480414104-8524-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Lyude Paul <thatslyude@gmail.com>, Nick Dyer <nick@shmanahar.org>, Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Typos...

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---
 include/linux/rmi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rmi.h b/include/linux/rmi.h
index 8499b6a..27dd9aa 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -108,7 +108,7 @@ struct rmi_2d_sensor_platform_data {
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

