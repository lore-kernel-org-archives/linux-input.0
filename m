From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH V2] Input/spear-keyboard: Provide thaw and poweroff routines
Date: Fri, 24 Feb 2012 10:59:12 +0530
Message-ID: <cd834b2f6765ec892f72ad4213c24093f659eb79.1329990021.git.viresh.kumar@st.com>
References: <94d1fcbd230297361d8137e06fdb5d4e2b741529.1329990021.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147]:41912 "EHLO
	eu1sys200aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752558Ab2BXFsa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Feb 2012 00:48:30 -0500
In-Reply-To: <94d1fcbd230297361d8137e06fdb5d4e2b741529.1329990021.git.viresh.kumar@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, armando.visconti@st.com, shiraz.hashim@st.com, vipin.kumar@st.com, rajeev-dlh.kumar@st.com, deepak.sikri@st.com, vipulkumar.samar@st.com, amit.virdi@st.com, viresh.kumar@st.com, pratyush.anand@st.com, bhupesh.sharma@st.com, viresh.linux@gmail.com, bhavna.yadav@st.com, vincenzo.frascino@st.com, mirko.gardi@st.com

Thaw and poweroff routines are missing for spear-keyboard. They are required for:
- Error case scenarios during freeze
- Using test features, of hibernate.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
Changes since V1:
- moved spear_kbd_pm_ops's definition/usage outside of CONFIG_PM macro

 drivers/input/keyboard/spear-keyboard.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
index 6eb2dd8..782e947 100644
--- a/drivers/input/keyboard/spear-keyboard.c
+++ b/drivers/input/keyboard/spear-keyboard.c
@@ -320,22 +320,17 @@ static int spear_kbd_resume(struct device *dev)
 
 	return 0;
 }
-
-static const struct dev_pm_ops spear_kbd_pm_ops = {
-	.suspend	= spear_kbd_suspend,
-	.resume		= spear_kbd_resume,
-};
 #endif
 
+static SIMPLE_DEV_PM_OPS(spear_kbd_pm_ops, spear_kbd_suspend, spear_kbd_resume);
+
 static struct platform_driver spear_kbd_driver = {
 	.probe		= spear_kbd_probe,
 	.remove		= __devexit_p(spear_kbd_remove),
 	.driver		= {
 		.name	= "keyboard",
 		.owner	= THIS_MODULE,
-#ifdef CONFIG_PM
 		.pm	= &spear_kbd_pm_ops,
-#endif
 	},
 };
 module_platform_driver(spear_kbd_driver);
-- 
1.7.8.110.g4cb5d

