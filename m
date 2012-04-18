From: Randy Dunlap <rdunlap@xenotime.net>
Subject: [PATCH] input: fix input.h kernel-doc warning
Date: Tue, 17 Apr 2012 17:03:46 -0700
Message-ID: <4F8E04E2.3090607@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from oproxy7-pub.bluehost.com ([67.222.55.9]:51040 "HELO
	oproxy7-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753438Ab2DRADJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Apr 2012 20:03:09 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

From: Randy Dunlap <rdunlap@xenotime.net>

Fix kernel-doc warning in input.h:

Warning(include/linux/input.h:140): No description found for parameter 'len'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 include/linux/input.h |    1 +
 1 file changed, 1 insertion(+)

--- lnx-34-rc3.orig/include/linux/input.h
+++ lnx-34-rc3/include/linux/input.h
@@ -116,6 +116,7 @@ struct input_keymap_entry {
 
 /**
  * EVIOCGMTSLOTS(len) - get MT slot values
+ * @len: size of the data buffer in bytes
  *
  * The ioctl buffer argument should be binary equivalent to
  *
