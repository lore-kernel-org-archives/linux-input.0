From: Giuseppe <g.mazzotta@iragan.com>
Subject: [PATCH 1/1] wistron_btns DMI info to recognize Maxdata Pro 7000 notebooks
Date: Sun, 05 Jul 2009 19:19:02 +0200
Message-ID: <4A50E086.5090206@iragan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from m-04.th.seeweb.it ([217.64.195.227]:54225 "EHLO
	m-04.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbZGERi6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 Jul 2009 13:38:58 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: mitr@volny.cz, stable@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

This patch adds DMI recognition information to automatically load the 
correct layout for the Maxdata Pro 7000X/DX notebook models. Such 
notebooks are clones of Fujitsu Amilo V2000, the hook for the v2000 is 
being used and I have tested that perfectly works.

The immediate result of integrating this patch is that the five special 
buttons will work on these specific notebook models and that the RF 
killswitch will not be activated after suspend. This patch definitively 
obsoletes the fsam7400 module which I was still needing to enable wifi 
and to fix the RF killswitch suspend problem; in the current 2.6.30 
kernel it is necessary to load the wistron_btns module with options 
'force=1 keymap=1557/MS2141', which was not anyway a complete workaround.

Signed-off-by: Giuseppe Mazzotta <g.mazzotta@iragan.com>

--- linux-2.6.30/drivers/input/misc/wistron_btns.c.orig 2009-07-05 
14:07:10.000000000 +0200
+++ linux-2.6.30/drivers/input/misc/wistron_btns.c      2009-07-05 
14:07:36.000000000 +0200
@@ -646,6 +646,15 @@ static struct dmi_system_id dmi_ids[] __
         },
         {
                 .callback = dmi_matched,
+               .ident = "Maxdata Pro 7000 DX",
+               .matches = {
+                       DMI_MATCH(DMI_SYS_VENDOR, "MAXDATA"),
+                       DMI_MATCH(DMI_PRODUCT_NAME, "Pro 7000"),
+               },
+               .driver_data = keymap_fs_amilo_pro_v2000
+       },
+       {
+               .callback = dmi_matched,
                 .ident = "Fujitsu N3510",
                 .matches = {
                         DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
