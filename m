From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH 1/2] Input/spear-keyboard: Fix for balancing the enable_irq_wake in Power Mgmt
Date: Thu, 23 Feb 2012 15:10:51 +0530
Message-ID: <c65186b4c05cca4b233a56630a87b7e7c94ccc9d.1329990021.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog110.obsmtp.com ([207.126.144.129]:60552 "EHLO
	eu1sys200aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752271Ab2BWJwM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Feb 2012 04:52:12 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, armando.visconti@st.com, shiraz.hashim@st.com, vipin.kumar@st.com, rajeev-dlh.kumar@st.com, deepak.sikri@st.com, vipulkumar.samar@st.com, amit.virdi@st.com, viresh.kumar@st.com, pratyush.anand@st.com, bhupesh.sharma@st.com, viresh.linux@gmail.com, bhavna.yadav@st.com, vincenzo.frascino@st.com, mirko.gardi@st.com

From: Deepak Sikri <deepak.sikri@st.com>

This patch handles the fix for unbalanced irq for the cases when
enable_irq_wake fails, and a warning related to same is displayed
on the console. The workaround is handled at the driver level.

Signed-off-by: Deepak Sikri <deepak.sikri@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
 drivers/input/keyboard/spear-keyboard.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
index 0e7f686..6eb2dd8 100644
--- a/drivers/input/keyboard/spear-keyboard.c
+++ b/drivers/input/keyboard/spear-keyboard.c
@@ -58,6 +58,7 @@ struct spear_kbd {
 	void __iomem *io_base;
 	struct clk *clk;
 	unsigned int irq;
+	unsigned int irq_wake;
 	unsigned short last_key;
 	unsigned int mode;
 	unsigned short keycodes[256];
@@ -287,8 +288,10 @@ static int spear_kbd_suspend(struct device *dev)
 	if (input_dev->users)
 		clk_enable(kbd->clk);
 
-	if (device_may_wakeup(&pdev->dev))
-		enable_irq_wake(kbd->irq);
+	if (device_may_wakeup(&pdev->dev)) {
+		if (!enable_irq_wake(kbd->irq))
+			kbd->irq_wake = 1;
+	}
 
 	mutex_unlock(&input_dev->mutex);
 
@@ -303,8 +306,12 @@ static int spear_kbd_resume(struct device *dev)
 
 	mutex_lock(&input_dev->mutex);
 
-	if (device_may_wakeup(&pdev->dev))
-		disable_irq_wake(kbd->irq);
+	if (device_may_wakeup(&pdev->dev)) {
+		if (kbd->irq_wake) {
+			kbd->irq_wake = 0;
+			disable_irq_wake(kbd->irq);
+		}
+	}
 
 	if (input_dev->users)
 		clk_enable(kbd->clk);
-- 
1.7.8.110.g4cb5d

