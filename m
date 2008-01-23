From: "eric miao" <eric.y.miao@gmail.com>
Subject: [PATCH 6/12] pxa: add debounce_interval configuration to the keypad platform data
Date: Wed, 23 Jan 2008 15:28:37 +0800
Message-ID: <f17812d70801222328t6f149e1y54d5236825d4f0bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:60584 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646AbYAWH2h (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jan 2008 02:28:37 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4885882wah.23
        for <linux-input@vger.kernel.org>; Tue, 22 Jan 2008 23:28:37 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

>From 0a2922e52d091f46dafb22aca227dbf3b573153f Mon Sep 17 00:00:00 2001
From: eric miao <eric.miao@marvell.com>
Date: Wed, 23 Jan 2008 13:26:57 +0800
Subject: [PATCH] pxa: add debounce_interval configuration to the
keypad platform data

Currently, only one debounce_interval is introduced for both direct and
matrix keys. This is true in most cases, although the keypad controller
supports different debounce for direct/matrix keys.

Some platforms do require this to be tuned, instead of the default
reset value of 100ms.

Rotary encoder will always use zero debounce time for now to achieve
certain sensitivity.

Signed-off-by: eric miao <eric.miao@marvell.com>
---
 drivers/input/keyboard/pxa27x_keypad.c   |    1 +
 include/asm-arm/arch-pxa/pxa27x_keypad.h |    6 ++++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/pxa27x_keypad.c
b/drivers/input/keyboard/pxa27x_keypad.c
index ceaf1e0..6224c2f 100644
--- a/drivers/input/keyboard/pxa27x_keypad.c
+++ b/drivers/input/keyboard/pxa27x_keypad.c
@@ -357,6 +357,7 @@ static void pxa27x_keypad_config(struct
pxa27x_keypad *keypad)

 	keypad_writel(KPC, kpc | KPC_RE_ZERO_DEB);
 	keypad_writel(KPREC, DEFAULT_KPREC);
+	keypad_writel(KPKDI, pdata->debounce_interval);
 }

 static int pxa27x_keypad_open(struct input_dev *dev)
diff --git a/include/asm-arm/arch-pxa/pxa27x_keypad.h
b/include/asm-arm/arch-pxa/pxa27x_keypad.h
index 6b83232..644f760 100644
--- a/include/asm-arm/arch-pxa/pxa27x_keypad.h
+++ b/include/asm-arm/arch-pxa/pxa27x_keypad.h
@@ -19,6 +19,9 @@
  *
  * 3. rotary can be either interpreted as a relative input event (e.g.
  *    REL_WHEEL/REL_HWHEEL) or specific keys (e.g. UP/DOWN/LEFT/RIGHT)
+ *
+ * 4. matrix key and direct key will use the same debounce_interval by
+ *    default, which should be sufficient in most cases
  */
 struct pxa27x_keypad_platform_data {

@@ -43,6 +46,9 @@ struct pxa27x_keypad_platform_data {
 	int		rotary1_rel_code;
 	int		rotary1_up_key;
 	int		rotary1_down_key;
+
+	/* key debounce interval */
+	unsigned int	debounce_interval;
 };

 #define KEY(row, col, val)	(((row) << 28) | ((col) << 24) | (val))
-- 
1.5.2.5.GIT



-- 
Cheers
- eric
