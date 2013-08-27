From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH] Input: add SYN_MAX and SYN_CNT constants
Date: Tue, 27 Aug 2013 13:23:52 +0200
Message-ID: <1377602632-23259-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f50.google.com ([74.125.83.50]:52246 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753296Ab3H0LYG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Aug 2013 07:24:06 -0400
Received: by mail-ee0-f50.google.com with SMTP id d51so2199487eek.37
        for <linux-input@vger.kernel.org>; Tue, 27 Aug 2013 04:24:05 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Herrmann <dh.herrmann@gmail.com>

SYN_* events are special and not enabled via set_bit() for devices. Hence,
they haven't been really needed, yet. However, user-space can still make
great use of that for int->string debugging helpers or alike.

Also, I haven't seen any reason not to define these, so here they are.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 include/uapi/linux/input.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index 4649ee3..2fb6fae 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -194,6 +194,8 @@ struct input_keymap_entry {
 #define SYN_CONFIG		1
 #define SYN_MT_REPORT		2
 #define SYN_DROPPED		3
+#define SYN_MAX			0xf
+#define SYN_CNT			(SYN_MAX+1)
 
 /*
  * Keys and buttons
-- 
1.8.4

