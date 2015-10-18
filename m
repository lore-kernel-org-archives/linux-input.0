From: Geliang Tang <geliangtang@163.com>
Subject: [PATCH 7/9] input: keyboard: fix a trivial typo
Date: Sun, 18 Oct 2015 23:31:13 +0800
Message-ID: <305aab717640ce43bfd609be20f2fff24190f207.1445181079.git.geliangtang@163.com>
References: <949f6f3c99f87b57666986dc9f2d1c916935e215.1445181079.git.geliangtang@163.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from m50-133.163.com ([123.125.50.133]:56899 "EHLO m50-133.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752766AbbJRPcf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 18 Oct 2015 11:32:35 -0400
In-Reply-To: <949f6f3c99f87b57666986dc9f2d1c916935e215.1445181079.git.geliangtang@163.com>
In-Reply-To: <88b679770e91ce8e3aa2cd25912c6d589563388c.1445181079.git.geliangtang@163.com>
References: <949f6f3c99f87b57666986dc9f2d1c916935e215.1445181079.git.geliangtang@163.com> <557286dd38beb4d8d1be28e787ad89611e7cc077.1445181079.git.geliangtang@163.com> <5fea4cd474d5fe49688f88d91cdf5e8019844806.1445181079.git.geliangtang@163.com> <918fdb002ec3b2a9fc5a5d364c0fbaff2f77c5cc.1445181079.git.geliangtang@163.com> <eb89ced1dda5b521dba1ed6095deef09d577e37a.1445181079.git.geliangtang@163.com> <88b679770e91ce8e3aa2cd25912c6d589563388c.1445181079.git.geliangtang@163.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <trivial@kernel.org>
Cc: Geliang Tang <geliangtang@163.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

s/regsiter/register/

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 drivers/input/keyboard/nomadik-ske-keypad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/nomadik-ske-keypad.c b/drivers/input/keyboard/nomadik-ske-keypad.c
index c7d5b16..8567ee4 100644
--- a/drivers/input/keyboard/nomadik-ske-keypad.c
+++ b/drivers/input/keyboard/nomadik-ske-keypad.c
@@ -54,7 +54,7 @@
 /**
  * struct ske_keypad  - data structure used by keypad driver
  * @irq:	irq no
- * @reg_base:	ske regsiters base address
+ * @reg_base:	ske registers base address
  * @input:	pointer to input device object
  * @board:	keypad platform device
  * @keymap:	matrix scan code table for keycodes
-- 
2.5.0


