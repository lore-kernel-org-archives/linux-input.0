From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] HID: Kconfig: add USB_HID dependency to UC-LOGIC
Date: Wed,  4 Mar 2015 11:24:55 -0500
Message-ID: <1425486295-27283-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44222 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758572AbbCDQZJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Mar 2015 11:25:09 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>

In commit 08177f4 (HID: uclogic: merge hid-huion driver in hid-uclogic)
HID_HUION depends explicitely on USB_HID because it contained quite some
USB-isms.

Now that hid-uclogic is the new home of Huion tablets, we need to also
add the dependency on USB_HID to this driver.

Reported-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

[CCing the DIGImend folks as a followup, this one is for upstream only]

 drivers/hid/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 8a55fd7..60c34cc 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -306,7 +306,7 @@ config HID_KYE
 
 config HID_UCLOGIC
 	tristate "UC-Logic"
-	depends on HID
+	depends on USB_HID
 	---help---
 	Support for UC-Logic and Huion tablets.
 
-- 
2.1.0

