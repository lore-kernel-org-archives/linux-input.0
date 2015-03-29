From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 41/86] input/keyboard: use uapi/linux/pci_ids.h directly
Date: Sun, 29 Mar 2015 15:40:48 +0200
Message-ID: <1427635734-24786-42-git-send-email-mst@redhat.com>
References: <1427635734-24786-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427635734-24786-1-git-send-email-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Nicholas Mc Guire <der.herr@hofr.at>, Helge Deller <deller@gmx.de>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Header moved from linux/pci_ids.h to uapi/linux/pci_ids.h,
use the new header directly so we can drop
the wrapper in include/linux/pci_ids.h.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/input/keyboard/hil_kbd.c | 2 +-
 drivers/input/keyboard/hilkbd.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/hil_kbd.c b/drivers/input/keyboard/hil_kbd.c
index 5b152f2..45af0ab 100644
--- a/drivers/input/keyboard/hil_kbd.c
+++ b/drivers/input/keyboard/hil_kbd.c
@@ -38,7 +38,7 @@
 #include <linux/module.h>
 #include <linux/completion.h>
 #include <linux/slab.h>
-#include <linux/pci_ids.h>
+#include <uapi/linux/pci_ids.h>
 
 #define PREFIX "HIL: "
 
diff --git a/drivers/input/keyboard/hilkbd.c b/drivers/input/keyboard/hilkbd.c
index 198dc07..fca1831 100644
--- a/drivers/input/keyboard/hilkbd.c
+++ b/drivers/input/keyboard/hilkbd.c
@@ -15,7 +15,7 @@
  * archive for more details.
  */
 
-#include <linux/pci_ids.h>
+#include <uapi/linux/pci_ids.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
 #include <linux/errno.h>
-- 
MST
