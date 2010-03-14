From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: [PATCH] i8042 add ALDI/MEDION netbook E1222 to qurik reset table
Date: Sun, 14 Mar 2010 03:49:01 +0100
Message-ID: <1268534941.3777.2.camel@lovely>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f227.google.com ([209.85.220.227]:47651 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755975Ab0CNCog (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Mar 2010 21:44:36 -0500
Received: by fxm27 with SMTP id 27so2650721fxm.28
        for <linux-input@vger.kernel.org>; Sat, 13 Mar 2010 18:44:34 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

ALDI/MEDION netbook E1222 needs to be in the reset quirk 
list for its touchpad's proper function.


Reported-by: Michael Fischer <mifi@gmx.de>
Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 drivers/input/serio/i8042-x86ia64io.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/input/serio/i8042-x86ia64io.h
b/drivers/input/serio/i8042-x86ia64io.h
index 2a5982e..525b9b9 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -442,6 +442,13 @@ static const struct dmi_system_id __initconst
i8042_dmi_reset_table[] = {
 		},
 	},
 	{
+		/* Medion Akoya E1222 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "E122X"),
+		},
+	},
+	{
 		/* Mivvy M310 */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "VIOOO"),
-- 
1.5.6.5

