From: Shailendra Verma <shailendra.capricorn@gmail.com>
Subject: [PATCH] Input:mouse:psmouse-base - Change 1 to true for bool type variable.
Date: Mon, 25 May 2015 22:41:28 +0530
Message-ID: <1432573888-3070-1-git-send-email-shailendra.capricorn@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34084 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbbEYRLl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 May 2015 13:11:41 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Mathias Gottschlag <mgottschlag@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Thomas Hellstrom <thellstrom@vmware.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Shailendra Verma <shailendra.capricorn@gmail.com>

The variable psmouse_smartscroll is bool type so assigning true
instead of 1.

Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
---
 drivers/input/mouse/psmouse-base.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 5bb1658..7c4ba43 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -63,7 +63,7 @@ static unsigned int psmouse_rate = 100;
 module_param_named(rate, psmouse_rate, uint, 0644);
 MODULE_PARM_DESC(rate, "Report rate, in reports per second.");
 
-static bool psmouse_smartscroll = 1;
+static bool psmouse_smartscroll = true;
 module_param_named(smartscroll, psmouse_smartscroll, bool, 0644);
 MODULE_PARM_DESC(smartscroll, "Logitech Smartscroll autorepeat, 1 = enabled (default), 0 = disabled.");
 
-- 
1.7.9.5

