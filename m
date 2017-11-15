From: Aaron Ma <aaron.ma@canonical.com>
Subject: [PATCH] Input: ALPS - fix DualPoint flag for 74 03 28 devices
Date: Wed, 15 Nov 2017 14:34:04 +0800
Message-ID: <20171115063404.10066-1-aaron.ma@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:45832 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbdKOGeQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 15 Nov 2017 01:34:16 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, masaki.ota@jp.alps.com, pali.rohar@gmail.com

There is a regression of commit 4a646580f793 ("Input: ALPS - fix
two-finger scroll breakage"), ALPS device fails with log:

psmouse serio1: alps: Rejected trackstick packet from non DualPoint device

ALPS device with id "74 03 28" report OTP[0] data 0xCE after
commit 4a646580f793, after restore the OTP reading order,
it becomes to 0x10 as before and reports the right flag.

Fixes: 4a646580f793 ("Input: ALPS - fix two-finger scroll breakage")
Cc: <stable@vger.kernel.org>
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/input/mouse/alps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 579b899add26..c59b8f7ca2fc 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -2562,8 +2562,8 @@ static int alps_set_defaults_ss4_v2(struct psmouse *psmouse,
 
 	memset(otp, 0, sizeof(otp));
 
-	if (alps_get_otp_values_ss4_v2(psmouse, 1, &otp[1][0]) ||
-	    alps_get_otp_values_ss4_v2(psmouse, 0, &otp[0][0]))
+	if (alps_get_otp_values_ss4_v2(psmouse, 0, &otp[0][0]) ||
+	    alps_get_otp_values_ss4_v2(psmouse, 1, &otp[1][0]))
 		return -1;
 
 	alps_update_device_area_ss4_v2(otp, priv);
-- 
2.13.6

