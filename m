From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: i8042 - add Acer Aspire 5536 to the noloop list
Date: Mon, 17 Aug 2009 22:24:29 -0700
Message-ID: <20090818055542.CB3F6526EA5@mailhub.coreip.homeip.net>
References: <1250471002-20780-1-git-send-email-eugen@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.229]:3711 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbZHRFYg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Aug 2009 01:24:36 -0400
Received: by rv-out-0506.google.com with SMTP id f6so929637rvb.1
        for <linux-input@vger.kernel.org>; Mon, 17 Aug 2009 22:24:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1250471002-20780-1-git-send-email-eugen@debian.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eugeniy Meshcheryakov <eugen@debian.org>
Cc: linux-input@vger.kernel.org

On Mon, Aug 17, 2009 at 03:03:22AM +0200, Eugeniy Meshcheryakov wrote:
> Without this patch it is not possible to reenable touchpad
> after disabling it using disable button.

Applied, thank you Eugeniy.

However for 2.6.32 I am looking for more generic solution,
could you please try the patch below (without yours applied)?

Thanks!

-- 
Dmitry

Input: i8042 - bypass AUX IRQ delivery test on laptops

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

It seems that many laptops do not fully implement AUX LOOP command
in their keyboard controllers, causing issues with touchpad detection.
Hovewer we know that almost every laptop/portable uses PS/2 pointing
device and even if user disables it in favor of external mouse the
system will not use IRQ 12 for anything else. Therefore we may bypass
AUX IRQ delivery test when running on a laptop and assume that it is
routed properly.

Just to be safe we require the box to have good PNP data in order to
bypass the test.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/serio/i8042-x86ia64io.h |   34 +++++++++++++++++++++++++++++++++
 drivers/input/serio/i8042.c           |    4 +++-
 2 files changed, 37 insertions(+), 1 deletions(-)


diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index ae04d8a..6747b9d 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -449,6 +449,34 @@ static struct dmi_system_id __initdata i8042_dmi_nopnp_table[] = {
 	},
 	{ }
 };
+
+static struct dmi_system_id __initdata i8042_dmi_laptop_table[] = {
+	{
+		.ident = "Portable",
+		.matches = {
+			DMI_MATCH(DMI_CHASSIS_TYPE, "8"), /* Portable */
+		},
+	},
+	{
+		.ident = "Laptop",
+		.matches = {
+			DMI_MATCH(DMI_CHASSIS_TYPE, "9"), /* Laptop */
+		},
+	},
+	{
+		.ident = "Notebook",
+		.matches = {
+			DMI_MATCH(DMI_CHASSIS_TYPE, "10"), /* Notebook */
+		},
+	},
+	{
+		.ident = "Sub-Notebook",
+		.matches = {
+			DMI_MATCH(DMI_CHASSIS_TYPE, "14"), /* Sub-Notebook */
+		},
+	},
+
+};
 #endif
 
 /*
@@ -727,6 +755,12 @@ static int __init i8042_pnp_init(void)
 	i8042_kbd_irq = i8042_pnp_kbd_irq;
 	i8042_aux_irq = i8042_pnp_aux_irq;
 
+#ifdef CONFIG_X86
+	i8042_bypass_aux_irq_test = !i8042_noaux &&
+				    !pnp_data_busted &&
+				    dmi_check_system(i8042_dmi_laptop_table);
+#endif
+
 	return 0;
 }
 
diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 9f5c050..b53a015 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -83,6 +83,8 @@ module_param_named(debug, i8042_debug, bool, 0600);
 MODULE_PARM_DESC(debug, "Turn i8042 debugging mode on and off");
 #endif
 
+static bool i8042_bypass_aux_irq_test;
+
 #include "i8042.h"
 
 static DEFINE_SPINLOCK(i8042_lock);
@@ -641,7 +643,7 @@ static int __devinit i8042_check_aux(void)
  * used it for a PCI card or somethig else.
  */
 
-	if (i8042_noloop || aux_loop_broken) {
+	if (i8042_noloop || i8042_bypass_aux_irq_test || aux_loop_broken) {
 /*
  * Without LOOP command we can't test AUX IRQ delivery. Assume the port
  * is working and hope we are right.
