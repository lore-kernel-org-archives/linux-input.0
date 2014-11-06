From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] Input: synaptics - add min/max quirk for Lenovo T440s
Date: Thu,  6 Nov 2014 16:48:22 +0100
Message-ID: <1415288902-11140-1-git-send-email-tiwai@suse.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55233 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751122AbaKFPso (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 6 Nov 2014 10:48:44 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

The new Lenovo T440s laptop has a different PnP ID "LEN0039", and it
needs the similar min/max quirk to make its clickpad working.

BugLink: https://bugzilla.opensuse.org/show_bug.cgi?id=903748
Reported-and-tested-by: Joschi Brauchle <joschibrauchle@gmx.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/input/mouse/synaptics.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 9031a0a28ea4..2a7a9174c702 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -135,8 +135,8 @@ static const struct min_max_quirk min_max_pnpid_table[] = {
 		1232, 5710, 1156, 4696
 	},
 	{
-		(const char * const []){"LEN0034", "LEN0036", "LEN2002",
-					"LEN2004", NULL},
+		(const char * const []){"LEN0034", "LEN0036", "LEN0039",
+					"LEN2002", "LEN2004", NULL},
 		1024, 5112, 2024, 4832
 	},
 	{
@@ -163,6 +163,7 @@ static const char * const topbuttonpad_pnp_ids[] = {
 	"LEN0036", /* T440 */
 	"LEN0037",
 	"LEN0038",
+	"LEN0039", /* T440s */
 	"LEN0041",
 	"LEN0042", /* Yoga */
 	"LEN0045",
-- 
2.1.3

