From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 3/3] Input: wacom - Send proper tablet state info when pen leaves proximity
Date: Thu, 22 Aug 2013 18:15:37 -0700
Message-ID: <1377220537-1474-3-git-send-email-killertofu@gmail.com>
References: <1377220537-1474-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:44760 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753301Ab3HWBQ3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Aug 2013 21:16:29 -0400
Received: by mail-pb0-f43.google.com with SMTP id md4so18263pbc.2
        for <linux-input@vger.kernel.org>; Thu, 22 Aug 2013 18:16:29 -0700 (PDT)
In-Reply-To: <1377220537-1474-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linuxwacom-devel@lists.sourceforge.net, linux-input@vger.kernel.org, pinglinux@gmail.com
Cc: Jason Gerecke <killertofu@gmail.com>

The EMR sensor of Intuos4 and newer devices can send a packet with
0x20 in its second byte which contains only location information.
This packet is sent when the pen is too far away to reliably obtain
other information. Because only the location is updated userspace
will continue to see stale information for other values, most notably
TOUCH, PRESSURE, and DISTANCE.

This patch ensures userspace is not left with stale device state
information when the pen re-enters proximity (possibly leading to
the assumption the pen is still in contact even though it is
actually hovering).

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
 drivers/input/tablet/wacom_wac.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 869e9c9..f67a75a 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -425,6 +425,13 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 			(features->type == WACOM_21UX2))
 		return 1;
 
+	/* Range Report */
+	if ((data[1] & 0xfe) == 0x20) {
+		input_report_key(input, BTN_TOUCH, 0);
+		input_report_abs(input, ABS_PRESSURE, 0);
+		input_report_abs(input, ABS_DISTANCE, wacom->features.distance_max);
+	}
+
 	/* Exit report */
 	if ((data[1] & 0xfe) == 0x80) {
 		if (features->quirks == WACOM_QUIRK_MULTI_INPUT)
-- 
1.8.3.4

