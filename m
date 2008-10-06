From: Pieter du Preez <pdupreez@gmail.com>
Subject: [PATCH] Input: Remove keyboard warning if CONFIG_INPUT_KEYBOARD is
	not set.
Date: Mon, 6 Oct 2008 23:08:03 +0200
Message-ID: <20081006210803.GB29707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.187]:26282 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752970AbYJFVQL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Oct 2008 17:16:11 -0400
Received: by gv-out-0910.google.com with SMTP id e6so436955gvc.37
        for <linux-input@vger.kernel.org>; Mon, 06 Oct 2008 14:16:09 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Many embedded systems have no keyboard and will have the
CONFIG_INPUT_KEYBOARD option unset. On compilation, they
however get nagged as follows:

#warning "Cannot generate rawmode keyboard for your architecture yet."

There is no reason for this, as there is no keyboard.

This patch removes this warning if CONFIG_INPUT_KEYBOARD
is not set.

Signed-off-by: Pieter du Preez <pdupreez@gmail.com>
---
 drivers/char/keyboard.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
index 7b3a212..d0a8961 100644
--- a/drivers/char/keyboard.c
+++ b/drivers/char/keyboard.c
@@ -1123,7 +1123,9 @@ static int emulate_raw(struct vc_data *vc, unsigned int keycode,
 
 #define HW_RAW(dev)	0
 
+#if defined CONFIG_INPUT_KEYBOARD
 #warning "Cannot generate rawmode keyboard for your architecture yet."
+#endif
 
 static int emulate_raw(struct vc_data *vc, unsigned int keycode, unsigned char up_flag)
 {
-- 
1.5.6.5
