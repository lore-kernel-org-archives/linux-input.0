From: Florian Ragwitz <rafl@debian.org>
Subject: [PATCH 4/4] Input: elantech - Whitelist new models with firmware version 4.1
Date: Sat, 24 Apr 2010 22:41:02 +0200
Message-ID: <1272141662-23431-5-git-send-email-rafl@debian.org>
References: <1272141662-23431-1-git-send-email-rafl@debian.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from weedy.perldition.org ([85.10.210.75]:54457 "EHLO
	weedy.perldition.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338Ab0DXV0n (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 24 Apr 2010 17:26:43 -0400
In-Reply-To: <1272141662-23431-1-git-send-email-rafl@debian.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Florian Ragwitz <rafl@debian.org>

The check is intentionally quite strict. It will probably need to be relaxed
later, but given how easy it is to test a non-whitelisted firmware with
force_elantech, that's OK.

Signed-off-by: Florian Ragwitz <rafl@debian.org>
---
 drivers/input/mouse/elantech.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 254a967..70321b7 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -599,7 +599,8 @@ int elantech_detect(struct psmouse *psmouse, bool set_properties)
 	pr_debug("elantech.c: Elantech version query result 0x%02x, 0x%02x, 0x%02x.\n",
 		 param[0], param[1], param[2]);
 
-	if (param[0] == 0 || param[1] != 0) {
+	if ((param[0] == 0 || param[1] != 0) &&
+	    (param[0] != 4 && param[1] != 1 && param[2] != 1)) {
 		if (!force_elantech) {
 			pr_debug("elantech.c: Probably not a real Elantech touchpad. Aborting.\n");
 			return -1;
-- 
1.7.0.5

