From: Oskari Saarenmaa <os@ohmu.fi>
Subject: [PATCH] Input: sentelic - filter on-pad clicks in absolute mode
Date: Sun, 1 Apr 2012 21:30:37 +0300
Message-ID: <20120401183037.GA23849@timantti.taisia.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from timantti.taisia.fi ([213.157.67.233]:35274 "EHLO mail.taisia.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751601Ab2DASaj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 1 Apr 2012 14:30:39 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tai-hwa Liang <avatar@sentelic.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On-pad clicks in absolute positioning single-finger mode are reported
without the PHY_BTN bit set, the on-pad clicks are handled by userspace
so the kernel shouldn't report them as real clicks.

Signed-off-by: Oskari Saarenmaa <os@ohmu.fi>
---
 Applies to v3.4-rc1

 drivers/input/mouse/sentelic.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/input/mouse/sentelic.c b/drivers/input/mouse/sentelic.c
index a977bfa..d4df8cd 100644
--- a/drivers/input/mouse/sentelic.c
+++ b/drivers/input/mouse/sentelic.c
@@ -741,6 +741,14 @@ static psmouse_ret_t fsp_process_byte(struct psmouse *psmouse)
 			}
 		} else {
 			/* SFAC packet */
+			if ((packet[0] & FSP_PB0_LBTN|FSP_PB0_PHY_BTN) ==
+				FSP_PB0_LBTN) {
+				/* On-pad click in SFAC mode should be handled
+				 * by userspace.  On-pad clicks in MFMC mode
+				 * are real clickpad clicks, and not ignored.
+				 */
+				packet[0] &= ~FSP_PB0_LBTN;
+			}
 
 			/* no multi-finger information */
 			ad->last_mt_fgr = 0;
-- 
1.7.7.6

