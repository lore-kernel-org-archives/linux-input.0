From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [TRIVIAL, PATCH] hid/hidraw: indent with tabs, not spaces
Date: Fri, 30 Apr 2010 21:49:58 +0200
Message-ID: <1272656998-29307-1-git-send-email-ospite@studenti.unina.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out19.alice.it ([85.33.2.19]:1832 "EHLO
	smtp-out19.alice.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755887Ab0D3TuS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Apr 2010 15:50:18 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <trivial@kernel.org>
Cc: Antonio Ospite <ospite@studenti.unina.it>, linux-input@vger.kernel.org

Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
---
 drivers/hid/hidraw.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 6eadf1a..a9becf9 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -311,7 +311,7 @@ static long hidraw_ioctl(struct file *file, unsigned int cmd,
 						-EFAULT : len;
 					break;
 				}
-                }
+		}
 
 		ret = -ENOTTY;
 	}
-- 
1.7.1

