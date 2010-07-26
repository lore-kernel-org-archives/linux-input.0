From: Wayne Lin <00601wayne@gmail.com>
Subject: [RFC 18/36]  [Driver][Qualcomm 1070][WIFI] Turn on the Athros WIFI power
Date: Mon, 26 Jul 2010 16:30:27 +0800
Message-ID: <1280133045-25945-18-git-send-email-wayne.lin@quantatw.com>
References: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:46745 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753737Ab0GZIdN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Jul 2010 04:33:13 -0400
Received: by mail-pv0-f174.google.com with SMTP id 7so4321238pvc.19
        for <linux-input@vger.kernel.org>; Mon, 26 Jul 2010 01:33:13 -0700 (PDT)
In-Reply-To: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: wayne <wayne.lin@quantatw.com>

From: wayne <wayne.lin@quantatw.com>

---
 arch/arm/mach-msm/board-qsd8x50.c |  263 +++++++++++++++++++++++++++++++++++++
 1 files changed, 263 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-msm/board-qsd8x50.c b/arch/arm/mach-msm/board-qsd8x50.c
index 633514a..0d44c2d 100644
--- a/arch/arm/mach-msm/board-qsd8x50.c
+++ b/arch/arm/mach-msm/board-qsd8x50.c
@@ -1811,6 +1811,262 @@ exit:
 	return;
 }
 
+static void set_st15_voltage(void)
+{
+        struct vreg *vreg_pa;
+        struct vreg *vreg_gp1;
+        struct vreg *vreg_gp2;
+        struct vreg *vreg_ruim;
+        struct vreg *vreg_gp5;
+        struct vreg *vreg_rfrx2;
+        struct vreg *vreg_synth;
+        struct vreg *vreg_gp4;
+	int rc;
+
+        vreg_pa = vreg_get(NULL, "pa");
+        if (IS_ERR(vreg_pa)) {
+                printk(KERN_ERR "%s: vreg pa get failed (%ld)\n",
+                       __func__, PTR_ERR(vreg_pa));
+                return;
+        }
+        rc = vreg_set_level(vreg_pa, 2100);
+        if (rc) {
+                printk(KERN_ERR "%s: vreg pa set level failed (%d)\n",
+                       __func__, rc);
+                return;
+        }
+        rc = vreg_enable(vreg_pa);
+        if (rc) {
+                printk(KERN_ERR "%s: vreg pa enable failed (%d)\n",
+                       __func__, rc);
+                return;
+        }
+        msleep(100);
+
+	vreg_gp1 = vreg_get(NULL, "gp1");
+        if (IS_ERR(vreg_gp1)) {
+                printk(KERN_ERR "%s: vreg gp1 get failed (%ld)\n",
+                       __func__, PTR_ERR(vreg_gp1));
+                return;
+        }
+        rc = vreg_set_level(vreg_gp1, 1800);
+        if (rc) {
+                printk(KERN_ERR "%s: vreg gp1 set level failed (%d)\n",
+                       __func__, rc);
+                return;
+        }
+        rc = vreg_enable(vreg_gp1);
+        if (rc) {
+                printk(KERN_ERR "%s: vreg gp1 enable failed (%d)\n",
+                       __func__, rc);
+                return;
+        }
+        msleep(100);
+
+	vreg_gp2 = vreg_get(NULL, "gp2");
+        if (IS_ERR(vreg_gp2)) {
+                printk(KERN_ERR "%s: vreg gp2 get failed (%ld)\n",
+                       __func__, PTR_ERR(vreg_gp2));
+                return;
+        }
+        rc = vreg_set_level(vreg_gp2, 2850);
+        if (rc) {
+                printk(KERN_ERR "%s: vreg gp2 set level failed (%d)\n",
+                       __func__, rc);
+                return;
+        }
+        rc = vreg_enable(vreg_gp2);
+        if (rc) {
+                printk(KERN_ERR "%s: vreg gp2 enable failed (%d)\n",
+                       __func__, rc);
+                return;
+        }
+        msleep(100);
+
+	vreg_ruim = vreg_get(NULL, "ruim");
+        if (IS_ERR(vreg_ruim)) {
+                printk(KERN_ERR "%s: vreg ruim get failed (%ld)\n",
+                       __func__, PTR_ERR(vreg_ruim));
+                return;
+        }
+        rc = vreg_set_level(vreg_ruim, 2850);
+        if (rc) {
+                printk(KERN_ERR "%s: vreg ruim set level failed (%d)\n",
+                       __func__, rc);
+                return;
+        }
+        rc = vreg_enable(vreg_ruim);
+        if (rc) {
+                printk(KERN_ERR "%s: vreg ruim enable failed (%d)\n",
+                       __func__, rc);
+                return;
+        }
+        msleep(100);
+
+	vreg_gp5 = vreg_get(NULL, "gp5");
+        if (IS_ERR(vreg_gp5)) {
+                printk(KERN_ERR "%s: vreg gp5 get failed (%ld)\n",
+                       __func__, PTR_ERR(vreg_gp5));
+                return;
+        }
+        rc = vreg_set_level(vreg_gp5, 1800);
+        if (rc) {
+                printk(KERN_ERR "%s: vreg gp5 set level failed (%d)\n",
+                       __func__, rc);
+                return;
+        }
+        rc = vreg_enable(vreg_gp5);
+        if (rc) {
+                printk(KERN_ERR "%s: vreg gp5 enable failed (%d)\n",
+                       __func__, rc);
+                return;
+        }
+        msleep(100);
+
+	vreg_rfrx2 = vreg_get(NULL, "rfrx2");
+        if (IS_ERR(vreg_rfrx2)) {
+                printk(KERN_ERR "%s: vreg rfrx2 get failed (%ld)\n",
+                       __func__, PTR_ERR(vreg_rfrx2));
+                return;
+        }
+        rc = vreg_set_level(vreg_rfrx2, 2100);
+        if (rc) {
+                printk(KERN_ERR "%s: vreg rfrx2 set level failed (%d)\n",
+                       __func__, rc);
+                return;
+        }
+        rc = vreg_enable(vreg_rfrx2);
+        if (rc) {
+                printk(KERN_ERR "%s: vreg rfrx2 enable failed (%d)\n",
+                       __func__, rc);
+                return;
+        }
+        msleep(100);
+
+	vreg_synth = vreg_get(NULL, "synt");
+        if (IS_ERR(vreg_synth)) {
+                printk(KERN_ERR "%s: vreg synth get failed (%ld)\n",
+                       __func__, PTR_ERR(vreg_synth));
+                return;
+        }
+        rc = vreg_set_level(vreg_synth, 2850);
+        if (rc) {
+                printk(KERN_ERR "%s: vreg synth set level failed (%d)\n",
+                       __func__, rc);
+                return;
+        }
+        rc = vreg_enable(vreg_synth);
+        if (rc) {
+                printk(KERN_ERR "%s: vreg synth enable failed (%d)\n",
+                       __func__, rc);
+                return;
+        }
+        msleep(100);
+
+	vreg_gp4 = vreg_get(NULL, "gp4");
+        if (IS_ERR(vreg_gp4)) {
+                printk(KERN_ERR "%s: vreg gp4 get failed (%ld)\n",
+                       __func__, PTR_ERR(vreg_gp4));
+                return;
+        }
+        rc = vreg_set_level(vreg_gp4, 2850);
+        if (rc) {
+                printk(KERN_ERR "%s: vreg gp4 set level failed (%d)\n",
+                       __func__, rc);
+                return;
+        }
+        rc = vreg_enable(vreg_gp4);
+        if (rc) {
+                printk(KERN_ERR "%s: vreg gp4 enable failed (%d)\n",
+                       __func__, rc);
+                return;
+        }
+        msleep(100);
+}
+
+static void enable_wlan_bt(void)
+{
+	struct vreg *vreg_gp6;
+        struct vreg *vreg_wlan;
+        struct vreg *vreg_gp3;
+	int rc;
+
+	vreg_gp3 = vreg_get(NULL, "gp3");
+        if (IS_ERR(vreg_gp3)) {
+                printk(KERN_ERR "%s: vreg gp3 get failed (%ld)\n",
+                       __func__, PTR_ERR(vreg_gp3));
+                return;
+        }
+        rc = vreg_set_level(vreg_gp3, 2600);
+        if (rc) {
+                printk(KERN_ERR "%s: vreg gp3 set level failed (%d)\n",
+                       __func__, rc);
+                return;
+        }
+        rc = vreg_enable(vreg_gp3);
+        if (rc) {
+                printk(KERN_ERR "%s: vreg gp3 enable failed (%d)\n",
+                       __func__, rc);
+                return;
+        }
+        msleep(100);
+
+        vreg_wlan = vreg_get(NULL, "wlan");
+        if (IS_ERR(vreg_wlan)) {
+                printk(KERN_ERR "%s: vreg wlan get failed (%ld)\n",
+                       __func__, PTR_ERR(vreg_wlan));
+                return;
+        }
+        rc = vreg_set_level(vreg_wlan, 2850);
+        if (rc) {
+                printk(KERN_ERR "%s: vreg wlan set level failed (%d)\n",
+                       __func__, rc);
+                return;
+        }
+        rc = vreg_enable(vreg_wlan);
+        if (rc) {
+                printk(KERN_ERR "%s: vreg wlan enable failed (%d)\n",
+                       __func__, rc);
+                return;
+        }
+	msleep(100);
+
+	gpio_tlmm_config(GPIO_CFG(26, 0, GPIO_OUTPUT, GPIO_NO_PULL, GPIO_2MA), GPIO_ENABLE);
+        gpio_set_value(26, 1);
+        msleep(100);
+
+        vreg_gp6 = vreg_get(NULL, "gp6");
+        if (IS_ERR(vreg_gp6)) {
+                printk(KERN_ERR "%s: vreg get failed (%ld)\n",
+                       __func__, PTR_ERR(vreg_gp6));
+                return;
+        }
+        rc = vreg_disable(vreg_gp6);
+        if (rc) {
+                printk(KERN_ERR "%s: vreg gp6 enable failed (%d)\n",
+                       __func__, rc);
+                return;
+        }
+        rc = vreg_set_level(vreg_gp6, 1800);
+        if (rc) {
+                printk(KERN_ERR "%s: vreg gp6 set level failed (%d)\n",
+                       __func__, rc);
+                return;
+        }
+        rc = vreg_enable(vreg_gp6);
+        if (rc) {
+                printk(KERN_ERR "%s: vreg gp6 enable failed (%d)\n",
+                       __func__, rc);
+                return;
+        }
+        msleep(100);
+        gpio_tlmm_config(GPIO_CFG(41, 0, GPIO_OUTPUT, GPIO_NO_PULL, GPIO_2MA), GPIO_ENABLE);
+
+	gpio_set_value(41, 0);
+        msleep(100);
+        gpio_set_value(41, 1);
+}
+
 static void __attribute__((unused)) __init bt_power_init_st_1_5(void)
 {
 	int rc;
@@ -3245,7 +3501,11 @@ static void __init qsd8x50_init(void)
 	qsd8x50_init_host();
 	qsd8x50_init_mmc();
 	if (machine_is_qsd8x50a_st1_5())
+	{
 		bt_power_init_st_1_5();
+		/* power on wlan_bt module(AR6000) */
+		enable_wlan_bt();
+	}
 	else
 		bt_power_init();
 	audio_gpio_init();
@@ -3285,6 +3545,9 @@ static void __init qsd8x50_init(void)
 	else
 		platform_device_register(&keypad_device_surf);
 #endif
+	/* set regulator voltage */
+	if (machine_is_qsd8x50a_st1_5())
+               set_st15_voltage();
 }
 
 static void __init qsd8x50_allocate_memory_regions(void)
-- 
1.7.0.4

