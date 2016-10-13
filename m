From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 18/18] Input: synaptics-rmi4 - fix documentation of rmi_2d_sensor_platform_data
Date: Thu, 13 Oct 2016 17:51:12 +0200
Message-ID: <1476373872-18027-19-git-send-email-benjamin.tissoires@redhat.com>
References: <1476373872-18027-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38778 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756405AbcJMPwB (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 13 Oct 2016 11:52:01 -0400
In-Reply-To: <1476373872-18027-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Lyude Paul <thatslyude@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Nick Dyer <nick@shmanahar.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Typos...

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v3

new in v2
---
 include/linux/rmi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rmi.h b/include/linux/rmi.h
index 6b22948..2fdb4fb 100644
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

