From: Shiraz Hashim <shiraz.hashim@st.com>
Subject: [PATCH V2 2/6] input/spear_keyboard: fix clock handling during suspend/resume
Date: Mon, 9 Jul 2012 12:05:45 +0530
Message-ID: <1341815745-23618-1-git-send-email-shiraz.hashim@st.com>
References: <1341211814-15173-2-git-send-email-shiraz.hashim@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:60447 "EHLO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751684Ab2GIGgM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 9 Jul 2012 02:36:12 -0400
In-Reply-To: <1341211814-15173-2-git-send-email-shiraz.hashim@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: spear-devel@list.st.com, linux-input@vger.kernel.org, vipulkumar.samar@st.com, Shiraz Hashim <shiraz.hashim@st.com>

SPEAr keyboard should normally disable clock during suspend and enable it
during resume.

For cases where it is expected to act as a wakeup source the clock can
remain in the same state i.e. kept enabled if it is being used.

Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
---
Changes since V1:
 * remove discarded irq balancing patch dependency

 drivers/input/keyboard/spear-keyboard.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
index 45dd02c..aa1259a 100644
--- a/drivers/input/keyboard/spear-keyboard.c
+++ b/drivers/input/keyboard/spear-keyboard.c
@@ -317,11 +317,12 @@ static int spear_kbd_suspend(struct device *dev)
 
 	mutex_lock(&input_dev->mutex);
 
-	if (input_dev->users)
-		clk_enable(kbd->clk);
-
-	if (device_may_wakeup(&pdev->dev))
+	if (device_may_wakeup(&pdev->dev)) {
 		enable_irq_wake(kbd->irq);
+	} else {
+		if (input_dev->users)
+			clk_disable(kbd->clk);
+	}
 
 	mutex_unlock(&input_dev->mutex);
 
@@ -336,11 +337,12 @@ static int spear_kbd_resume(struct device *dev)
 
 	mutex_lock(&input_dev->mutex);
 
-	if (device_may_wakeup(&pdev->dev))
+	if (device_may_wakeup(&pdev->dev)) {
 		disable_irq_wake(kbd->irq);
-
-	if (input_dev->users)
-		clk_enable(kbd->clk);
+	} else {
+		if (input_dev->users)
+			clk_enable(kbd->clk);
+	}
 
 	mutex_unlock(&input_dev->mutex);
 
-- 
1.7.10

