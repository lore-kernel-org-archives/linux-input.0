From: Mike Lothian <mike@fireburn.co.uk>
Subject: Samsung R510
Date: Fri, 11 Sep 2009 09:17:12 +0100
Message-ID: <f3f71ab90909110117t4d9de95cv2f71b42f2a9a7992@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:23990 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144AbZIKIRa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Sep 2009 04:17:30 -0400
Received: by fg-out-1718.google.com with SMTP id 22so1843657fge.1
        for <linux-input@vger.kernel.org>; Fri, 11 Sep 2009 01:17:32 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi

Please could the following patch be added to the kernel

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 95fe045..592623e 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1572,6 +1572,16 @@ static struct dmi_system_id
atkbd_dmi_quirk_table[] __initdata = {
                .callback = atkbd_setup_forced_release,
                .driver_data = atkbd_samsung_forced_release_keys,
        },
+        {
+                .ident = "Samsung R510/P510",
+                .matches = {
+                        DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG
ELECTRONICS CO., LTD."),
+                        DMI_MATCH(DMI_PRODUCT_NAME, "R510/P510"),
+                },
+                .callback = atkbd_setup_forced_release,
+                .driver_data = atkbd_samsung_forced_release_keys,
+        },
+
        {
                .ident = "Fujitsu Amilo PA 1510",
                .matches = {

This fixes the forced release keys for me

Thanks

Mike

PS I'm not subscribed to this list so please CC me
