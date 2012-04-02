From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH] fixup! Input: of_keymap: Introduce matrix_keypad_of_build_keymap()
Date: Mon, 2 Apr 2012 09:31:51 +0530
Message-ID: <3d33526ed060e70cdd981f990e449d46a4566278.1333339090.git.viresh.kumar@st.com>
References: <406fb8092d6aca97a54add346a2528daefab9c8d.1333009670.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:44038 "EHLO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750717Ab2DBENj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Apr 2012 00:13:39 -0400
In-Reply-To: <406fb8092d6aca97a54add346a2528daefab9c8d.1333009670.git.viresh.kumar@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: swarren@nvidia.com, spear-devel@list.st.com, viresh.linux@gmail.com, devicetree-discuss@lists.ozlabs.org, olof@lixom.net, linux-input@vger.kernel.org, Viresh Kumar <viresh.kumar@st.com>

Hi Dmitry,

This is an incremental patch over patch
"Input: of_keymap: Introduce matrix_keypad_of_build_keymap()"

sent earlier by me. Please squash it to that patch while applying.

This contains last few changes suggested by Stephen on V4 of this patch.
---
 drivers/input/keyboard/tegra-kbc.c  |    4 ++--
 include/linux/input/matrix_keypad.h |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index d1cc006..6300cc7 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -619,8 +619,8 @@ tegra_kbc_check_pin_cfg(const struct tegra_kbc_platform_data *pdata,
 }
 
 #ifdef CONFIG_OF
-static struct tegra_kbc_platform_data * __devinit
-tegra_kbc_dt_parse_pdata(struct device_node *np)
+static inline struct tegra_kbc_platform_data * tegra_kbc_dt_parse_pdata(
+		struct device_node *np)
 {
 	struct tegra_kbc_platform_data *pdata;
 	u32 prop;
diff --git a/include/linux/input/matrix_keypad.h b/include/linux/input/matrix_keypad.h
index 341aca1..02b2118 100644
--- a/include/linux/input/matrix_keypad.h
+++ b/include/linux/input/matrix_keypad.h
@@ -111,7 +111,7 @@ matrix_keypad_build_keymap(const struct matrix_keymap_data *keymap_data,
 int matrix_keypad_of_build_keymap(struct input_dev *idev,
 		unsigned int row_shift, const char *propname);
 #else
-int matrix_keypad_of_build_keymap(struct input_dev *idev,
+static inline int matrix_keypad_of_build_keymap(struct input_dev *idev,
 		unsigned int row_shift, const char *propname)
 {
 	return NULL;
-- 
1.7.9

