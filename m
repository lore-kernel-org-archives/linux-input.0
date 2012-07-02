From: Shiraz Hashim <shiraz.hashim@st.com>
Subject: [PATCH 2/6] input/spear_keyboard: fix clock handling during suspend/resume
Date: Mon, 2 Jul 2012 12:20:10 +0530
Message-ID: <1341211814-15173-2-git-send-email-shiraz.hashim@st.com>
References: <1341211814-15173-1-git-send-email-shiraz.hashim@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog109.obsmtp.com ([207.126.144.127]:53294 "EHLO
	eu1sys200aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752176Ab2GBGue (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Jul 2012 02:50:34 -0400
In-Reply-To: <1341211814-15173-1-git-send-email-shiraz.hashim@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: spear-devel@list.st.com, linux-input@vger.kernel.org, Shiraz Hashim <shiraz.hashim@st.com>

SPEAr keyboard should normally disable clock during suspend and enable it
during resume.

For cases where it is expected to act as a wakeup source the clock can
remain in the same state i.e. kept enabled if it is being used.

Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
---
 drivers/input/keyboard/spear-keyboard.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
index 67d9afb..ef147f3 100644
--- a/drivers/input/keyboard/spear-keyboard.c
+++ b/drivers/input/keyboard/spear-keyboard.c
@@ -318,12 +318,12 @@ static int spear_kbd_suspend(struct device *dev)
 
 	mutex_lock(&input_dev->mutex);
 
-	if (input_dev->users)
-		clk_enable(kbd->clk);
-
 	if (device_may_wakeup(&pdev->dev)) {
 		if (!enable_irq_wake(kbd->irq))
 			kbd->irq_wake = 1;
+	} else {
+		if (input_dev->users)
+			clk_disable(kbd->clk);
 	}
 
 	mutex_unlock(&input_dev->mutex);
@@ -344,11 +344,11 @@ static int spear_kbd_resume(struct device *dev)
 			kbd->irq_wake = 0;
 			disable_irq_wake(kbd->irq);
 		}
+	} else {
+		if (input_dev->users)
+			clk_enable(kbd->clk);
 	}
 
-	if (input_dev->users)
-		clk_enable(kbd->clk);
-
 	mutex_unlock(&input_dev->mutex);
 
 	return 0;
-- 
1.7.10

