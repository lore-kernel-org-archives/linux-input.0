From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 1/2] add ad714x platform_data definition
Date: Tue, 1 Sep 2009 11:55:29 +0800
Message-ID: <1251777330-16994-2-git-send-email-21cnbao@gmail.com>
References: <1251777330-16994-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:49278 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733AbZIADyK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 31 Aug 2009 23:54:10 -0400
In-Reply-To: <1251777330-16994-1-git-send-email-21cnbao@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dbrownell@users.sourceforge.net, dmitry.torokhov@gmail.com, dtor@mail.ru
Cc: spi-devel-general@lists.sourceforge.net, linux-input@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, Barry Song <21cnbao@gmail.com>

AD714x is very flexible, it can be used as buttons, scrollwheel,
slider, touchpad at the same time. That depends on the boards.
The platform_data for the device's "struct device" holds these
information.
The data-struct defined in this file descript the hardware feature
of button/scrollwheel/slider/touchpad components on target boards,
which need be filled in the arch/mach-/.

Signed-off-by: Barry Song <21cnbao@gmail.com>
---
 include/linux/spi/ad714x.h |   60 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 60 insertions(+), 0 deletions(-)
 create mode 100644 include/linux/spi/ad714x.h

diff --git a/include/linux/spi/ad714x.h b/include/linux/spi/ad714x.h
new file mode 100644
index 0000000..f6439a9
--- /dev/null
+++ b/include/linux/spi/ad714x.h
@@ -0,0 +1,60 @@
+/*
+ * include/linux/ad714x.h
+ *
+ * AD714x is very flexible, it can be used as buttons, scrollwheel,
+ * slider, touchpad at the same time. That depends on the boards.
+ * The platform_data for the device's "struct device" holds this
+ * information.
+ */
+
+
+#ifndef AD714X_HW_H
+#define AD714X_HW_H
+
+#define STAGE_NUM              12
+#define STAGE_CFGREG_NUM       8
+#define SYS_CFGREG_NUM         8
+
+/* board information which need be initialized in arch/mach... */
+struct ad714x_slider_plat {
+	int start_stage;
+	int end_stage;
+	int max_coord;
+};
+
+struct ad714x_wheel_plat {
+	int start_stage;
+	int end_stage;
+	int max_coord;
+};
+
+struct ad714x_touchpad_plat {
+	int x_start_stage;
+	int x_end_stage;
+	int x_max_coord;
+
+	int y_start_stage;
+	int y_end_stage;
+	int y_max_coord;
+};
+
+struct ad714x_button_plat {
+	int keycode;
+	unsigned short l_mask;
+	unsigned short h_mask;
+};
+
+struct ad714x_platform_data {
+	int slider_num;
+	int wheel_num;
+	int touchpad_num;
+	int button_num;
+	struct ad714x_slider_plat *slider;
+	struct ad714x_wheel_plat *wheel;
+	struct ad714x_touchpad_plat *touchpad;
+	struct ad714x_button_plat *button;
+	unsigned short stage_cfg_reg[STAGE_NUM][STAGE_CFGREG_NUM];
+	unsigned short sys_cfg_reg[SYS_CFGREG_NUM];
+};
+
+#endif
-- 
1.5.6.3

