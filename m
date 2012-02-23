From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH 2/2] Input/spear-keyboard: Provide thaw and poweroff routines
Date: Thu, 23 Feb 2012 15:10:52 +0530
Message-ID: <94d1fcbd230297361d8137e06fdb5d4e2b741529.1329990021.git.viresh.kumar@st.com>
References: <c65186b4c05cca4b233a56630a87b7e7c94ccc9d.1329990021.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149]:45349 "EHLO
	eu1sys200aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752779Ab2BWJwG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Feb 2012 04:52:06 -0500
In-Reply-To: <c65186b4c05cca4b233a56630a87b7e7c94ccc9d.1329990021.git.viresh.kumar@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, armando.visconti@st.com, shiraz.hashim@st.com, vipin.kumar@st.com, rajeev-dlh.kumar@st.com, deepak.sikri@st.com, vipulkumar.samar@st.com, amit.virdi@st.com, viresh.kumar@st.com, pratyush.anand@st.com, bhupesh.sharma@st.com, viresh.linux@gmail.com, bhavna.yadav@st.com, vincenzo.frascino@st.com, mirko.gardi@st.com

Thaw and poweroff routines are missing for spear-keyboard. They are required for:
- Error case scenarios during freeze
- Using test features, of hibernate.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/input/keyboard/spear-keyboard.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
index 6eb2dd8..6e83828 100644
--- a/drivers/input/keyboard/spear-keyboard.c
+++ b/drivers/input/keyboard/spear-keyboard.c
@@ -321,10 +321,7 @@ static int spear_kbd_resume(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops spear_kbd_pm_ops = {
-	.suspend	= spear_kbd_suspend,
-	.resume		= spear_kbd_resume,
-};
+static SIMPLE_DEV_PM_OPS(spear_kbd_pm_ops, spear_kbd_suspend, spear_kbd_resume);
 #endif
 
 static struct platform_driver spear_kbd_driver = {
-- 
1.7.8.110.g4cb5d

