From: Chase Douglas <chase.douglas@canonical.com>
Subject: [PATCH 1/2] Input: synaptics - add second variant of two-button clickpad
Date: Mon, 13 Feb 2012 20:21:12 -0800
Message-ID: <1329193273-12486-1-git-send-email-chase.douglas@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:40904 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755767Ab2BNEVQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Feb 2012 23:21:16 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
---
There are two models of Dell netbooks (Inspiron 1011 and 1012 IIRC) with
two-button clickpads that do not match the current two-button clickpad bit
mask. I don't have any docs to tell me which bits are which, but this bit
seems the most probably. For reference, the caps bits for these netbooks are:

caps: 0xd04713/0xa40000/0x2a0000

 drivers/input/mouse/synaptics.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
index fd26ccc..816d7bd 100644
--- a/drivers/input/mouse/synaptics.h
+++ b/drivers/input/mouse/synaptics.h
@@ -80,6 +80,7 @@
  */
 #define SYN_CAP_CLICKPAD(ex0c)		((ex0c) & 0x100000) /* 1-button ClickPad */
 #define SYN_CAP_CLICKPAD2BTN(ex0c)	((ex0c) & 0x000100) /* 2-button ClickPad */
+#define SYN_CAP_CLICKPAD2BTN2(ex0c)	((ex0c) & 0x200000) /* 2-button ClickPad */
 #define SYN_CAP_MAX_DIMENSIONS(ex0c)	((ex0c) & 0x020000)
 #define SYN_CAP_MIN_DIMENSIONS(ex0c)	((ex0c) & 0x002000)
 #define SYN_CAP_ADV_GESTURE(ex0c)	((ex0c) & 0x080000)
-- 
1.7.9

