From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 3/3] Input: ALPS - Detect Pinnacle AGx using EC report
 instead of E7 report
Date: Sun, 20 Jan 2013 01:31:16 -0800
Message-ID: <57b6e6cb34a2e5f58a16032fadffc844@localhost>
References: <10bf6ea5c8f86eca66cd39498ca38d58@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [69.28.251.93] ([69.28.251.93]:45602 "EHLO b32.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751679Ab3ATJnh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Jan 2013 04:43:37 -0500
In-Reply-To: <10bf6ea5c8f86eca66cd39498ca38d58@localhost>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: seth.forshee@canonical.com, linux-input@vger.kernel.org

The E7 report output can be ambiguous for newer touchpads; the
manufacturer's own drivers use the EC report instead, and check a wider
range of IDs than what is in the current table.  Implement similar
behavior in alps.c.

Tested on Dell E6410 (E7 report: 73 02 64; EC report: 88 07 9d)

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/input/mouse/alps.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 338e97e..21fc8c9 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -109,8 +109,6 @@ static const struct alps_model_info alps_model_data[] = {
 	{ { 0x73, 0x02, 0x50 }, 0x00, ALPS_PROTO_V2, 0xcf, 0xcf, ALPS_FOUR_BUTTONS },		/* Dell Vostro 1400 */
 	{ { 0x52, 0x01, 0x14 }, 0x00, ALPS_PROTO_V2, 0xff, 0xff,
 		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED },				/* Toshiba Tecra A11-11L */
-	{ { 0x73, 0x02, 0x64 },	0x9b, ALPS_PROTO_V3, 0x8f, 0x8f, ALPS_DUALPOINT },
-	{ { 0x73, 0x02, 0x64 },	0x9d, ALPS_PROTO_V3, 0x8f, 0x8f, ALPS_DUALPOINT },
 	{ { 0x73, 0x02, 0x64 },	0x8a, ALPS_PROTO_V4, 0x8f, 0x8f, 0 },
 };
 
@@ -118,6 +116,10 @@ static const struct alps_model_info alps_model_rushmore = {
 	{ ALPS_RUSHMORE }, 0x00, ALPS_PROTO_V3, 0x8f, 0x8f, ALPS_DUALPOINT
 };
 
+static const struct alps_model_info alps_model_pinnacle_agx = {
+	{ ALPS_PINAGX }, 0x00, ALPS_PROTO_V3, 0x8f, 0x8f, ALPS_DUALPOINT
+};
+
 /*
  * XXX - this entry is suspicious. First byte has zero lower nibble,
  * which is what a normal mouse would report. Also, the value 0x0e
@@ -1040,13 +1042,13 @@ static const struct alps_model_info *alps_probe_pinnacle(
 	    (param[1] != 0x07 && param[1] != 0x08))
 		goto out;
 
-	/* For now this code has only been verified to detect Rushmore */
+	/* This code has not been tested with Pinnacle AG or Pinnacle */
 	if (param[1] == 0x08)
 		model = &alps_model_rushmore;
 	else if (param[2] >= 0x80 && param[2] <= 0x8f)
 		psmouse_info(psmouse, "detected Pinnacle AG via EC report\n");
 	else if (param[2] >= 0x90 && param[2] <= 0x9d)
-		psmouse_info(psmouse, "detected Pinnacle AGx via EC report\n");
+		model = &alps_model_pinnacle_agx;
 	else if (param[2] < 0x80)
 		psmouse_info(psmouse, "detected Pinnacle via EC report\n");
 
-- 
1.7.10.4

