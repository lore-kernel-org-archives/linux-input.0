From: JJ Ding <jj_ding@emc.com.tw>
Subject: [RFC PATCH 2/2] Input: elantech - convert v1 ~ v3 hardware to use PSMOUSE_SHIFT_PACKET
Date: Wed,  7 Dec 2011 19:38:44 +0800
Message-ID: <1323257924-12773-3-git-send-email-jj_ding@emc.com.tw>
References: <1323257924-12773-1-git-send-email-jj_ding@emc.com.tw>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:15410 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755139Ab1LGLk3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Dec 2011 06:40:29 -0500
In-Reply-To: <1323257924-12773-1-git-send-email-jj_ding@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, JJ Ding <jj_ding@emc.com.tw>, JJ Ding <dgdunix@gmail.com>

From: JJ Ding <dgdunix@gmail.com>

This makes the driver resemble the bebavior documented in
Documentation/input/elantech.txt

Signed-off-by: JJ Ding <dgdunix@gmail.com>
---
 drivers/input/mouse/elantech.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index d2c0db1..674cd78 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -728,7 +728,7 @@ static psmouse_ret_t elantech_process_byte(struct psmouse *psmouse)
 	switch (etd->hw_version) {
 	case 1:
 		if (etd->paritycheck && !elantech_packet_check_v1(psmouse))
-			return PSMOUSE_BAD_DATA;
+			return PSMOUSE_SHIFT_PACKET;
 
 		elantech_report_absolute_v1(psmouse);
 		break;
@@ -739,7 +739,7 @@ static psmouse_ret_t elantech_process_byte(struct psmouse *psmouse)
 			return PSMOUSE_FULL_PACKET;
 
 		if (etd->paritycheck && !elantech_packet_check_v2(psmouse))
-			return PSMOUSE_BAD_DATA;
+			return PSMOUSE_SHIFT_PACKET;
 
 		elantech_report_absolute_v2(psmouse);
 		break;
@@ -751,7 +751,7 @@ static psmouse_ret_t elantech_process_byte(struct psmouse *psmouse)
 			return PSMOUSE_FULL_PACKET;
 
 		if (packet_type == PACKET_UNKNOWN)
-			return PSMOUSE_BAD_DATA;
+			return PSMOUSE_SHIFT_PACKET;
 
 		elantech_report_absolute_v3(psmouse, packet_type);
 		break;
-- 
1.7.8

