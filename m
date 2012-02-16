From: Akio Idehara <zbe64533@gmail.com>
Subject: [PATCH v2] Input: ALPS - Fix ALPS touchpad detection
Date: Thu, 16 Feb 2012 22:11:55 +0900
Message-ID: <4F3D009B.8080506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55432 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944Ab2BPNL6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Feb 2012 08:11:58 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: rubini@ipvvis.unipv.it, seth.forshee@canonical.com, linux-input@vger.kernel.org, inux-kernel@vger.kernel.org

ALPS touchpad detection fails if some buttons of ALPS are pressed.
The reason is that the "E6" query response byte is different from
what is expected.
This was tested on a Toshiba Portege R500.

Cc: stable <stable@vger.kernel.org>
Signed-off-by: Akio Idehara <zbe64533@gmail.com>
---
  Documentation/input/alps.txt |    3 ++-
  drivers/input/mouse/alps.c   |    7 +++++--
  2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/input/alps.txt b/Documentation/input/alps.txt
index f274c28..2f95308 100644
--- a/Documentation/input/alps.txt
+++ b/Documentation/input/alps.txt
@@ -13,7 +13,8 @@ Detection

  All ALPS touchpads should respond to the "E6 report" command sequence:
  E8-E6-E6-E6-E9. An ALPS touchpad should respond with either 00-00-0A or
-00-00-64.
+00-00-64 if no buttons are pressed. The bits 0-2 of the first byte will be 1s
+if some buttons are pressed.

  If the E6 report is successful, the touchpad model is identified using the "E7
  report" sequence: E8-E7-E7-E7-E9. The response is the model signature and is
diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index bd87380..4c6a72d 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -952,7 +952,9 @@ static const struct alps_model_info *alps_get_model(struct psmouse *psmouse, int

  	/*
  	 * First try "E6 report".
-	 * ALPS should return 0,0,10 or 0,0,100
+	 * ALPS should return 0,0,10 or 0,0,100 if no buttons are pressed.
+	 * The bits 0-2 of the first byte will be 1s if some buttons are
+	 * pressed.
  	 */
  	param[0] = 0;
  	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES) ||
@@ -968,7 +970,8 @@ static const struct alps_model_info *alps_get_model(struct psmouse *psmouse, int
  	psmouse_dbg(psmouse, "E6 report: %2.2x %2.2x %2.2x",
  		    param[0], param[1], param[2]);

-	if (param[0] != 0 || param[1] != 0 || (param[2] != 10 && param[2] != 100))
+	if ((param[0] & 0xf8) != 0 || param[1] != 0 ||
+	    (param[2] != 10 && param[2] != 100))
  		return NULL;

  	/*
-- 
1.7.9
