From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH] input/spear-keyboard: Remove kbd_set_plat_data()
Date: Mon, 27 Feb 2012 11:09:25 +0530
Message-ID: <8acf668a2c8d67aec3dc79dfe2895b2fd80a18be.1330320826.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, armando.visconti@st.com, shiraz.hashim@st.com, vipin.kumar@st.com, rajeev-dlh.kumar@st.com, deepak.sikri@st.com, vipulkumar.samar@st.com, amit.virdi@st.com, viresh.kumar@st.com, pratyush.anand@st.com, bhupesh.sharma@st.com, viresh.linux@gmail.com, bhavna.yadav@st.com, vincenzo.frascino@st.com, mirko.gardi@st.com, salvatore.dedominicis@st.com, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

We must use platform_device_add_data() instead of kbd_set_plat_data(). Remove
definition of kbd_set_plat_data().

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/plat-spear/include/plat/keyboard.h |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-spear/include/plat/keyboard.h b/arch/arm/plat-spear/include/plat/keyboard.h
index c16cc31..0562f13 100644
--- a/arch/arm/plat-spear/include/plat/keyboard.h
+++ b/arch/arm/plat-spear/include/plat/keyboard.h
@@ -159,11 +159,4 @@ struct kbd_platform_data {
 	unsigned int mode;
 };
 
-/* This function is used to set platform data field of pdev->dev */
-static inline void
-kbd_set_plat_data(struct platform_device *pdev, struct kbd_platform_data *data)
-{
-	pdev->dev.platform_data = data;
-}
-
 #endif /* __PLAT_KEYBOARD_H */
-- 
1.7.8.110.g4cb5d
