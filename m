From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] drivers/hid/hid-debug.c should #include <linux/hid-debug.h>
Date: Wed, 21 Feb 2007 12:57:30 +0100
Message-ID: <20070221115730.GG13958@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Every file should include the headers containing the prototypes for
it's global functions.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---
--- linux-2.6.20-mm2/drivers/hid/hid-debug.c.old	2007-02-20 23:07:32.000000000 +0100
+++ linux-2.6.20-mm2/drivers/hid/hid-debug.c	2007-02-21 00:00:41.000000000 +0100
@@ -29,6 +29,7 @@
  */
 
 #include <linux/hid.h>
+#include <linux/hid-debug.h>
 
 struct hid_usage_entry {
 	unsigned  page;
