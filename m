From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH 1/3] Input/spear-keyboard: delete redundant key definitions from 9x9 keyboard
Date: Thu, 23 Feb 2012 14:42:02 +0530
Message-ID: <9cc556b1cf3ca466a477f8fa32efd325c3aced65.1329988205.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147]:43647 "EHLO
	eu1sys200aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753646Ab2BWJXX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Feb 2012 04:23:23 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, armando.visconti@st.com, shiraz.hashim@st.com, vipin.kumar@st.com, rajeev-dlh.kumar@st.com, deepak.sikri@st.com, vipulkumar.samar@st.com, amit.virdi@st.com, viresh.kumar@st.com, pratyush.anand@st.com, bhupesh.sharma@st.com, viresh.linux@gmail.com, bhavna.yadav@st.com, vincenzo.frascino@st.com, mirko.gardi@st.com

From: Rajeev Kumar <rajeev-dlh.kumar@st.com>

Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/plat-spear/include/plat/keyboard.h |   18 ------------------
 1 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/arch/arm/plat-spear/include/plat/keyboard.h b/arch/arm/plat-spear/include/plat/keyboard.h
index 68b5394..004195f 100644
--- a/arch/arm/plat-spear/include/plat/keyboard.h
+++ b/arch/arm/plat-spear/include/plat/keyboard.h
@@ -62,24 +62,6 @@ int _name[] = { \
 	KEY(4, 6, KEY_Z), \
 	KEY(4, 7, KEY_X), \
 	KEY(4, 8, KEY_C), \
-	KEY(4, 0, KEY_L), \
-	KEY(4, 1, KEY_SEMICOLON), \
-	KEY(4, 2, KEY_APOSTROPHE), \
-	KEY(4, 3, KEY_GRAVE), \
-	KEY(4, 4, KEY_LEFTSHIFT), \
-	KEY(4, 5, KEY_BACKSLASH), \
-	KEY(4, 6, KEY_Z), \
-	KEY(4, 7, KEY_X), \
-	KEY(4, 8, KEY_C), \
-	KEY(4, 0, KEY_L), \
-	KEY(4, 1, KEY_SEMICOLON), \
-	KEY(4, 2, KEY_APOSTROPHE), \
-	KEY(4, 3, KEY_GRAVE), \
-	KEY(4, 4, KEY_LEFTSHIFT), \
-	KEY(4, 5, KEY_BACKSLASH), \
-	KEY(4, 6, KEY_Z), \
-	KEY(4, 7, KEY_X), \
-	KEY(4, 8, KEY_C), \
 	KEY(5, 0, KEY_V), \
 	KEY(5, 1, KEY_B), \
 	KEY(5, 2, KEY_N), \
-- 
1.7.8.110.g4cb5d

