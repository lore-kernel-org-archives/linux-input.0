From: Jiri Slaby <jirislaby@gmail.com>
Subject: [PATCH 1/1] HID: fix hidraw_exit section mismatch
Date: Fri, 17 Oct 2008 18:04:48 +0200
Message-ID: <1224259488-11467-1-git-send-email-jirislaby@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.wellnetcz.com ([212.24.148.102]:42766 "EHLO
	smtp.wellnetcz.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754314AbYJQQEy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Oct 2008 12:04:54 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@gmail.com>

hidraw_exit() marked as __exit is called from __init function
from HID core. Remove the section placement from that function.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
---
 drivers/hid/hidraw.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index af3edb9..1c23813 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -403,7 +403,7 @@ out:
 	return result;
 }
 
-void __exit hidraw_exit(void)
+void hidraw_exit(void)
 {
 	dev_t dev_id = MKDEV(hidraw_major, 0);
 
-- 
1.6.0.2

