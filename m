From: Martin Kepplinger <martink@posteo.de>
Subject: [PATCH 1/2] Input: mk712: update documentation web link
Date: Mon,  2 Apr 2018 14:55:50 +0200
Message-ID: <20180402125551.13641-1-martink@posteo.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: corbet@lwn.net, dmitry.torokhov@gmail.com
Cc: gregkh@linuxfoundation.org, logang@deltatee.com, stefanha@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Martin Kepplinger <martink@posteo.de>
List-Id: linux-input@vger.kernel.org

At the mentioned address there's nothing found. By searching information
on the controller chip still can be found, so update the link to the
resulting page.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
 drivers/input/touchscreen/mk712.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/mk712.c b/drivers/input/touchscreen/mk712.c
index bd5352824f77..c179060525ae 100644
--- a/drivers/input/touchscreen/mk712.c
+++ b/drivers/input/touchscreen/mk712.c
@@ -17,7 +17,7 @@
  * found in Gateway AOL Connected Touchpad computers.
  *
  * Documentation for ICS MK712 can be found at:
- *	http://www.idt.com/products/getDoc.cfm?docID=18713923
+ *	https://www.idt.com/general-parts/mk712-touch-screen-controller
  */
 
 /*
-- 
2.16.2
