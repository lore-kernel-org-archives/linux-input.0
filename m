From: Tai-hwa Liang <avatar@sentelic.com>
Subject: [PATCH 4/5] Input: sentelic - minor code cleaning up
Date: Wed, 22 Feb 2012 21:52:36 +0800
Message-ID: <1329918757-16128-5-git-send-email-avatar@sentelic.com>
References: <1329918757-16128-1-git-send-email-avatar@sentelic.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hermod.sentelic.com ([203.69.18.19]:14428 "EHLO
	hermod.sentelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023Ab2BVNxL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Feb 2012 08:53:11 -0500
In-Reply-To: <1329918757-16128-1-git-send-email-avatar@sentelic.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Tai-hwa Liang <avatar@sentelic.com>

Improving code readability by converting yet another magic number into a
pre-defined constant.

Signed-off-by: Tai-hwa Liang <avatar@sentelic.com>
---
 drivers/input/mouse/sentelic.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/mouse/sentelic.c b/drivers/input/mouse/sentelic.c
index 0b57fe4..4fe9474 100644
--- a/drivers/input/mouse/sentelic.c
+++ b/drivers/input/mouse/sentelic.c
@@ -767,7 +767,7 @@ static psmouse_ret_t fsp_process_byte(struct psmouse *psmouse)
 	case FSP_PKT_TYPE_NORMAL_OPC:
 		/* on-pad click, filter it if necessary */
 		if ((ad->flags & FSPDRV_FLAG_EN_OPC) != FSPDRV_FLAG_EN_OPC)
-			packet[0] &= ~BIT(0);
+			packet[0] &= ~FSP_PB0_LBTN;
 		/* fall through */
 
 	case FSP_PKT_TYPE_NORMAL:
-- 
1.7.9

