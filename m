From: Florian Ragwitz <rafl@debian.org>
Subject: [PATCH 1/4] Input: elantech - Assume all firmware versions >= 2.48 use 6 byte packets
Date: Sat, 24 Apr 2010 22:40:59 +0200
Message-ID: <1272141662-23431-2-git-send-email-rafl@debian.org>
References: <1272141662-23431-1-git-send-email-rafl@debian.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from weedy.perldition.org ([85.10.210.75]:54453 "EHLO
	weedy.perldition.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048Ab0DXV0k (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 24 Apr 2010 17:26:40 -0400
In-Reply-To: <1272141662-23431-1-git-send-email-rafl@debian.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Florian Ragwitz <rafl@debian.org>

This way firmware versions with a major version > 2, but a minor version < 48,
like version 4.1, will be recognized correctly.

Signed-off-by: Florian Ragwitz <rafl@debian.org>
---
 drivers/input/mouse/elantech.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index a138b5d..07f6b17 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -666,7 +666,8 @@ int elantech_init(struct psmouse *psmouse)
 	 * Assume every version greater than this is new EeePC style
 	 * hardware with 6 byte packets
 	 */
-	if (etd->fw_version_maj >= 0x02 && etd->fw_version_min >= 0x30) {
+	if ((etd->fw_version_maj == 0x02 && etd->fw_version_min >= 0x30) ||
+	    etd->fw_version_maj > 0x02) {
 		etd->hw_version = 2;
 		/* For now show extra debug information */
 		etd->debug = 1;
-- 
1.7.0.5

