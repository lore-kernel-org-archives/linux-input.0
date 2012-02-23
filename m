From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH 2/3] Input/spear-keyboard: Add 6x6 keypad matrix definitions
Date: Thu, 23 Feb 2012 14:42:03 +0530
Message-ID: <7f47b013dce7208e65dd9865b831db1a6c52ce1d.1329988205.git.viresh.kumar@st.com>
References: <9cc556b1cf3ca466a477f8fa32efd325c3aced65.1329988205.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:59931 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754616Ab2BWJX0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Feb 2012 04:23:26 -0500
In-Reply-To: <9cc556b1cf3ca466a477f8fa32efd325c3aced65.1329988205.git.viresh.kumar@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, armando.visconti@st.com, shiraz.hashim@st.com, vipin.kumar@st.com, rajeev-dlh.kumar@st.com, deepak.sikri@st.com, vipulkumar.samar@st.com, amit.virdi@st.com, viresh.kumar@st.com, pratyush.anand@st.com, bhupesh.sharma@st.com, viresh.linux@gmail.com, bhavna.yadav@st.com, vincenzo.frascino@st.com, mirko.gardi@st.com

From: Rajeev Kumar <rajeev-dlh.kumar@st.com>

Add 6x6 keypad matrix and rename 9x9 keymap

Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/plat-spear/include/plat/keyboard.h |   42 ++++++++++++++++++++++++++-
 1 files changed, 41 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-spear/include/plat/keyboard.h b/arch/arm/plat-spear/include/plat/keyboard.h
index 004195f..130c045 100644
--- a/arch/arm/plat-spear/include/plat/keyboard.h
+++ b/arch/arm/plat-spear/include/plat/keyboard.h
@@ -15,7 +15,7 @@
 #include <linux/input/matrix_keypad.h>
 #include <linux/types.h>
 
-#define DECLARE_KEYMAP(_name) \
+#define DECLARE_9x9_KEYMAP(_name) \
 int _name[] = { \
 	KEY(0, 0, KEY_ESC), \
 	KEY(0, 1, KEY_1), \
@@ -100,6 +100,46 @@ int _name[] = { \
 	KEY(8, 8, KEY_KP0), \
 }
 
+#define DECLARE_6x6_KEYMAP(_name) \
+int _name[] = { \
+	KEY(0, 0, KEY_RESERVED), \
+	KEY(0, 1, KEY_1), \
+	KEY(0, 2, KEY_2), \
+	KEY(0, 3, KEY_3), \
+	KEY(0, 4, KEY_4), \
+	KEY(0, 5, KEY_5), \
+	KEY(1, 0, KEY_Q), \
+	KEY(1, 1, KEY_W), \
+	KEY(1, 2, KEY_E), \
+	KEY(1, 3, KEY_R), \
+	KEY(1, 4, KEY_T), \
+	KEY(1, 5, KEY_Y), \
+	KEY(2, 0, KEY_D), \
+	KEY(2, 1, KEY_F), \
+	KEY(2, 2, KEY_G), \
+	KEY(2, 3, KEY_H), \
+	KEY(2, 4, KEY_J), \
+	KEY(2, 5, KEY_K), \
+	KEY(3, 0, KEY_B), \
+	KEY(3, 1, KEY_N), \
+	KEY(3, 2, KEY_M), \
+	KEY(3, 3, KEY_COMMA), \
+	KEY(3, 4, KEY_DOT), \
+	KEY(3, 5, KEY_SLASH), \
+	KEY(4, 0, KEY_F6), \
+	KEY(4, 1, KEY_F7), \
+	KEY(4, 2, KEY_F8), \
+	KEY(4, 3, KEY_F9), \
+	KEY(4, 4, KEY_F10), \
+	KEY(4, 5, KEY_NUMLOCK), \
+	KEY(5, 0, KEY_KP2), \
+	KEY(5, 1, KEY_KP3), \
+	KEY(5, 2, KEY_KP0), \
+	KEY(5, 3, KEY_KPDOT), \
+	KEY(5, 4, KEY_RO), \
+	KEY(5, 5, KEY_ZENKAKUHANKAKU), \
+}
+
 /**
  * struct kbd_platform_data - spear keyboard platform data
  * keymap: pointer to keymap data (table and size)
-- 
1.7.8.110.g4cb5d

