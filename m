From: Ulrik De Bie <ulrik.debie-os@e2big.org>
Subject: [PATCH v1  1/1] Input: elantech - Remove the ETP_SAMPLE_QUERY read that is now redundant
Date: Sat, 22 Aug 2015 23:43:40 +0200
Message-ID: <1440279820-30996-1-git-send-email-ulrik.debie-os@e2big.org>
References: <4478D504-18DD-463D-9CC3-2697A215B9B7@emc.com.tw>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e2big.org ([198.61.226.133]:51082 "EHLO e2big.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751023AbbHVVoj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 22 Aug 2015 17:44:39 -0400
In-Reply-To: <4478D504-18DD-463D-9CC3-2697A215B9B7@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, ulrik.debie-os@e2big.org, Duson Lin <dusonlin@emc.com.tw>

commit 6b30c73e9f37183ad60c7f7050acf8e8edf91e9c introduced a read of
ETP_SAMPLE_QUERY to etd->samples on line 1662. Because of that
introduction, this other read of ETP_SAMPLE_QUERY at line 1040 becomes
redundant and the already read etd->samples can be used instead.

This line 1040 read will only be called when
(etd->fw_version >> 16) == 0x14 and consequentially
hardware version != 1 so the line 1662 read is also called.

Signed-off-by: Ulrik De Bie <ulrik.debie-os@e2big.org>
CC: Duson Lin <dusonlin@emc.com.tw>
---
 drivers/input/mouse/elantech.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 2955f1d..825be4b 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1037,11 +1037,10 @@ static int elantech_set_range(struct psmouse *psmouse,
 			fixed_dpi = param[1] & 0x10;
 
 			if (((etd->fw_version >> 16) == 0x14) && fixed_dpi) {
-				if (etd->send_cmd(psmouse, ETP_SAMPLE_QUERY, param))
-					return -1;
-
-				*x_max = (etd->capabilities[1] - i) * param[1] / 2;
-				*y_max = (etd->capabilities[2] - i) * param[2] / 2;
+				*x_max = (etd->capabilities[1] - i) *
+					etd->samples[1] / 2;
+				*y_max = (etd->capabilities[2] - i) *
+					etd->samples[2] / 2;
 			} else if (etd->fw_version == 0x040216) {
 				*x_max = 819;
 				*y_max = 405;
-- 
2.5.0

