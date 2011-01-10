From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] input: Add new button type
Date: Mon, 10 Jan 2011 14:01:32 +0000
Message-ID: <20110110140131.11536.46959.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:59737 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994Ab1AJO2t (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Jan 2011 09:28:49 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: x86@kernel.org, linux-input@vger.kernel.org, jekyll_lai@wistron.com

From: Jekyll Lai <jekyll.lai@gmail.com>

This patch added a new switch event, SW_ROTATE_LOCK, which is used on one
of the Moorestown platforms.

Signed-off-by: Jekyll Lai <jekyll_lai@wistron.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 arch/x86/platform/mrst/mrst.c |    2 ++
 include/linux/input.h         |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)


diff --git a/arch/x86/platform/mrst/mrst.c b/arch/x86/platform/mrst/mrst.c
index a9686c3..cc749dc 100644
--- a/arch/x86/platform/mrst/mrst.c
+++ b/arch/x86/platform/mrst/mrst.c
@@ -822,6 +822,8 @@ static struct gpio_keys_button gpio_button[] = {
 	{KEY_CAMERA_FOCUS,	-1, 1, "camera_half",	EV_KEY, 0, 20},
 	{SW_KEYPAD_SLIDE,	-1, 1, "MagSw1",	EV_SW,  0, 20},
 	{SW_KEYPAD_SLIDE,	-1, 1, "MagSw2",	EV_SW,  0, 20},
+	{KEY_HOMEPAGE,		-1, 1, "home_btn",	EV_KEY, 0, 20},
+	{SW_ROTATE_LOCK,	-1, 1, "rot_lock",	EV_SW, 0, 20},
 };
 
 static struct gpio_keys_platform_data mrst_gpio_keys = {
diff --git a/include/linux/input.h b/include/linux/input.h
index c4e9d91..79fc30e 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -802,6 +802,7 @@ struct input_keymap_entry {
 #define SW_CAMERA_LENS_COVER	0x09  /* set = lens covered */
 #define SW_KEYPAD_SLIDE		0x0a  /* set = keypad slide out */
 #define SW_FRONT_PROXIMITY	0x0b  /* set = front proximity sensor active */
+#define SW_ROTATE_LOCK		0x0c  /* set = rotate lock */
 #define SW_MAX			0x0f
 #define SW_CNT			(SW_MAX+1)
 

