From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH 3/3] Input/spear-keyboard: Configure device according to supplied mode
Date: Thu, 23 Feb 2012 14:42:04 +0530
Message-ID: <5a253aa71179da9b0a28972f8bedfa1d78fc979e.1329988205.git.viresh.kumar@st.com>
References: <9cc556b1cf3ca466a477f8fa32efd325c3aced65.1329988205.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog108.obsmtp.com ([207.126.144.125]:45782 "EHLO
	eu1sys200aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754850Ab2BWJX2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Feb 2012 04:23:28 -0500
In-Reply-To: <9cc556b1cf3ca466a477f8fa32efd325c3aced65.1329988205.git.viresh.kumar@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, armando.visconti@st.com, shiraz.hashim@st.com, vipin.kumar@st.com, rajeev-dlh.kumar@st.com, deepak.sikri@st.com, vipulkumar.samar@st.com, amit.virdi@st.com, viresh.kumar@st.com, pratyush.anand@st.com, bhupesh.sharma@st.com, viresh.linux@gmail.com, bhavna.yadav@st.com, vincenzo.frascino@st.com, mirko.gardi@st.com

From: Rajeev Kumar <rajeev-dlh.kumar@st.com>

Let platform pass mode information to keyboard driver according to which
it configures itself. The mode can be
 - KEYPAD_9x9     0
 - KEYPAD_6x6     1
 - KEYPAD_2x2     2

Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/plat-spear/include/plat/keyboard.h |    6 ++++++
 drivers/input/keyboard/spear-keyboard.c     |    7 ++++++-
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-spear/include/plat/keyboard.h b/arch/arm/plat-spear/include/plat/keyboard.h
index 130c045..c16cc31 100644
--- a/arch/arm/plat-spear/include/plat/keyboard.h
+++ b/arch/arm/plat-spear/include/plat/keyboard.h
@@ -140,10 +140,15 @@ int _name[] = { \
 	KEY(5, 5, KEY_ZENKAKUHANKAKU), \
 }
 
+#define KEYPAD_9x9     0
+#define KEYPAD_6x6     1
+#define KEYPAD_2x2     2
+
 /**
  * struct kbd_platform_data - spear keyboard platform data
  * keymap: pointer to keymap data (table and size)
  * rep: enables key autorepeat
+ * mode: choose keyboard support(9x9, 6x6, 2x2)
  *
  * This structure is supposed to be used by platform code to supply
  * keymaps to drivers that implement keyboards.
@@ -151,6 +156,7 @@ int _name[] = { \
 struct kbd_platform_data {
 	const struct matrix_keymap_data *keymap;
 	bool rep;
+	unsigned int mode;
 };
 
 /* This function is used to set platform data field of pdev->dev */
diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
index c88bd63..0e7f686 100644
--- a/drivers/input/keyboard/spear-keyboard.c
+++ b/drivers/input/keyboard/spear-keyboard.c
@@ -50,6 +50,7 @@
 #define ROW_MASK	0xF0
 #define COLUMN_MASK	0x0F
 #define ROW_SHIFT	4
+#define KEY_MATRIX_SHIFT	6
 
 struct spear_kbd {
 	struct input_dev *input;
@@ -58,6 +59,7 @@ struct spear_kbd {
 	struct clk *clk;
 	unsigned int irq;
 	unsigned short last_key;
+	unsigned int mode;
 	unsigned short keycodes[256];
 };
 
@@ -106,7 +108,8 @@ static int spear_kbd_open(struct input_dev *dev)
 		return error;
 
 	/* program keyboard */
-	val = SCAN_RATE_80 | MODE_KEYBOARD | PCLK_FREQ_MSK;
+	val = SCAN_RATE_80 | MODE_KEYBOARD | PCLK_FREQ_MSK |
+		(kbd->mode << KEY_MATRIX_SHIFT);
 	writew(val, kbd->io_base + MODE_REG);
 	writeb(1, kbd->io_base + STATUS_REG);
 
@@ -176,6 +179,8 @@ static int __devinit spear_kbd_probe(struct platform_device *pdev)
 
 	kbd->input = input_dev;
 	kbd->irq = irq;
+	kbd->mode = pdata->mode;
+
 	kbd->res = request_mem_region(res->start, resource_size(res),
 				      pdev->name);
 	if (!kbd->res) {
-- 
1.7.8.110.g4cb5d

