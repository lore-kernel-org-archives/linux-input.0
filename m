From: Oskari Saarenmaa <os@ohmu.fi>
Subject: [PATCHv2] Input: sentelic - filter taps in absolute mode
Date: Tue, 3 Apr 2012 09:59:09 +0300
Message-ID: <20120403065909.GA32166@timantti.taisia.fi>
References: <20120401183037.GA23849@timantti.taisia.fi> <4F79B620.7030800@canonical.com> <4F79BE70.90005@ohmu.fi> <4F79C029.3040606@canonical.com> <4F79C7A0.6060601@ohmu.fi> <4F79D54E.4060500@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from timantti.taisia.fi ([213.157.67.233]:38860 "EHLO mail.taisia.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750821Ab2DCG7M (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 3 Apr 2012 02:59:12 -0400
Content-Disposition: inline
In-Reply-To: <4F79D54E.4060500@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Tai-hwa Liang <avatar@sentelic.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Taps in absolute positioning single-finger mode are currently reported
as physical clicks by the driver. This should be handled by userspace,
not the kernel.

When a tap occurs, the FSP_PB0_LBTN bit is set, but the FSP_PB0_PHY_BTN
is not. We use this to filter out physical clicks from taps.

Signed-off-by: Oskari Saarenmaa <os@ohmu.fi>
Reviewed-by: Tai-hwa Liang <avatar@sentelic.com> 
Reviewed-by: Chase Douglas <chase.douglas@canonical.com>
Cc: Dmitry Torokhov <dtor@mail.ru>
---
 Added missing braces around the bitwise or operation, reworded the
 commit message and added reviewed-by and cc lines.

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
+			if ((packet[0] & (FSP_PB0_LBTN|FSP_PB0_PHY_BTN)) ==
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

