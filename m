From: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Subject: [PATCH resend] input/spear-keyboard fix: return IRQ_NONE if (status reg & DATA_AVAIL)
Date: Mon, 28 Mar 2011 17:29:06 +0530
Message-ID: <1301313546-24420-1-git-send-email-rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog105.obsmtp.com ([207.126.144.119]:60182 "EHLO
	eu1sys200aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753555Ab1C1L7u (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Mar 2011 07:59:50 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, shiraz.hashim@st.com, armando.visconti@st.com, viresh.kumar@st.com, amit.goel@st.com, Rajeev Kumar <rajeev-dlh.kumar@st.com>

We should return IRQ_NONE from interrupt handler in case data is not
avail for keyboard

Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
 drivers/input/keyboard/spear-keyboard.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
index f18dc67..c6ab1df 100644
--- a/drivers/input/keyboard/spear-keyboard.c
+++ b/drivers/input/keyboard/spear-keyboard.c
@@ -70,7 +70,7 @@ static irqreturn_t spear_kbd_interrupt(int irq, void *dev_id)
 	u8 sts, val;
 
 	sts = readb(kbd->io_base + STATUS_REG);
-	if (sts & DATA_AVAIL)
+	if (!(sts & DATA_AVAIL))
 		return IRQ_NONE;
 
 	if (kbd->last_key != KEY_RESERVED) {
-- 
1.6.0.2

