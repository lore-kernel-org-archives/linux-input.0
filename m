From: Roel Kluin <dmitry.torokhov@gmail.com>
Subject: [PATCH 36/37] Input: i8042 - fix incorrect usage of strncpy and strncat
Date: Fri, 18 Apr 2008 00:25:18 -0400
Message-ID: <7b16d9ac49670e27c1c995b21d8108c899eba712.1208783694.git.dmitry.torokhov@gmail.com>
References: <cover.1208783694.git.dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:8681 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759550AbYDUNTV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Apr 2008 09:19:21 -0400
Received: by wa-out-1112.google.com with SMTP id m16so3106317waf.23
        for <linux-input@vger.kernel.org>; Mon, 21 Apr 2008 06:19:20 -0700 (PDT)
In-Reply-To: <cover.1208783694.git.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jkosina@suse.cz, akpm@linux-foundation.org

Fix incorrect length argument for strncpy and strncat by replacing them with
strlcpy and strlcat

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/serio/i8042-x86ia64io.h |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 60931ac..5ece9f5 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -370,10 +370,10 @@ static int i8042_pnp_kbd_probe(struct pnp_dev *dev, const struct pnp_device_id *
 	if (pnp_irq_valid(dev,0))
 		i8042_pnp_kbd_irq = pnp_irq(dev, 0);
 
-	strncpy(i8042_pnp_kbd_name, did->id, sizeof(i8042_pnp_kbd_name));
+	strlcpy(i8042_pnp_kbd_name, did->id, sizeof(i8042_pnp_kbd_name));
 	if (strlen(pnp_dev_name(dev))) {
-		strncat(i8042_pnp_kbd_name, ":", sizeof(i8042_pnp_kbd_name));
-		strncat(i8042_pnp_kbd_name, pnp_dev_name(dev), sizeof(i8042_pnp_kbd_name));
+		strlcat(i8042_pnp_kbd_name, ":", sizeof(i8042_pnp_kbd_name));
+		strlcat(i8042_pnp_kbd_name, pnp_dev_name(dev), sizeof(i8042_pnp_kbd_name));
 	}
 
 	i8042_pnp_kbd_devices++;
@@ -391,10 +391,10 @@ static int i8042_pnp_aux_probe(struct pnp_dev *dev, const struct pnp_device_id *
 	if (pnp_irq_valid(dev, 0))
 		i8042_pnp_aux_irq = pnp_irq(dev, 0);
 
-	strncpy(i8042_pnp_aux_name, did->id, sizeof(i8042_pnp_aux_name));
+	strlcpy(i8042_pnp_aux_name, did->id, sizeof(i8042_pnp_aux_name));
 	if (strlen(pnp_dev_name(dev))) {
-		strncat(i8042_pnp_aux_name, ":", sizeof(i8042_pnp_aux_name));
-		strncat(i8042_pnp_aux_name, pnp_dev_name(dev), sizeof(i8042_pnp_aux_name));
+		strlcat(i8042_pnp_aux_name, ":", sizeof(i8042_pnp_aux_name));
+		strlcat(i8042_pnp_aux_name, pnp_dev_name(dev), sizeof(i8042_pnp_aux_name));
 	}
 
 	i8042_pnp_aux_devices++;
-- 
1.5.5.rc2.6.gf58d


