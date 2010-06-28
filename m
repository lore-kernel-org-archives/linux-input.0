From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] wistron_btns: fix a memory leak in wb_module_init error
	path
Date: Mon, 28 Jun 2010 14:30:20 +0800
Message-ID: <1277706620.4148.2.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57961 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752794Ab0F1G2I (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Jun 2010 02:28:08 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Miloslav Trmac <mitr@volny.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rakib Mullick <rakib.mullick@gmail.com>, TJ <ubuntu@tjworld.net>, Julia Lawall <julia@diku.dk>, Samu Onkalo <samu.p.onkalo@nokia.com>, linux-input@vger.kernel.org

select_keymap calls copy_keymap to allocate a memory for keymap.
This patch adds a missing kfree(keymap) in wb_module_init error path.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/input/misc/wistron_btns.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/misc/wistron_btns.c b/drivers/input/misc/wistron_btns.c
index 4dac8b7..55ce70e 100644
--- a/drivers/input/misc/wistron_btns.c
+++ b/drivers/input/misc/wistron_btns.c
@@ -1371,6 +1371,7 @@ static int __init wb_module_init(void)
 	platform_driver_unregister(&wistron_driver);
  err_unmap_bios:
 	unmap_bios();
+	kfree(keymap);
 
 	return err;
 }
-- 
1.5.4.3



