From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH] Input: synaptics - Disable kernel tracking on SMBus devices
Date: Thu, 28 Sep 2017 13:07:19 -0700
Message-ID: <1506629239-5940-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-co1nam03on0055.outbound.protection.outlook.com ([104.47.40.55]:20203
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750832AbdI1UHc (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 28 Sep 2017 16:07:32 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, =?UTF-8?q?Kamil=20P=C3=A1ral?= <kparal@redhat.com>

In certain situations kernel tracking seems to be getting confused
and incorrectly reporting the slot of a contact. On example is when
the user does a three finger click or tap and then places two fingers
on the touchpad in the same area. The kernel tracking code seems to
continue to think that there are three contacts on the touchpad and
incorrectly alternates the slot of one of the contacts. The result that
is the input subsystem reports a stream of button press and release
events as the reported slot changes.

Kernel tracking was originally enabled to prevent cursor jumps, but it
is unclear how much of an issue kernel jumps actually are. This patch
simply disabled kernel tracking for now.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1482640

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
Tested-by: Kamil Páral <kparal@redhat.com>
---
 drivers/input/mouse/synaptics.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 5af0b7d..ee5466a 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1709,8 +1709,7 @@ static int synaptics_create_intertouch(struct psmouse *psmouse,
 		.sensor_pdata = {
 			.sensor_type = rmi_sensor_touchpad,
 			.axis_align.flip_y = true,
-			/* to prevent cursors jumps: */
-			.kernel_tracking = true,
+			.kernel_tracking = false,
 			.topbuttonpad = topbuttonpad,
 		},
 		.f30_data = {
-- 
2.7.4

