From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] HID: intel-ish-hid: use module_pci_driver to simplify the code
Date: Sun, 21 Aug 2016 15:28:36 +0000
Message-ID: <1471793316-23880-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33986 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752877AbcHUP3c (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 21 Aug 2016 11:29:32 -0400
Received: by mail-pa0-f65.google.com with SMTP id hh10so6548163pac.1
        for <linux-input@vger.kernel.org>; Sun, 21 Aug 2016 08:29:00 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-input@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Use the module_pci_driver() macro to make the code simpler
by eliminating module_init and module_exit calls.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/hid/intel-ish-hid/ipc/pci-ish.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index b14d6f4..42f0bee 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -311,18 +311,7 @@ static struct pci_driver ish_driver = {
 	.driver.pm = ISHTP_ISH_PM_OPS,
 };
 
-static int __init ish_driver_init(void)
-{
-	return pci_register_driver(&ish_driver);
-}
-
-static void __exit ish_driver_exit(void)
-{
-	pci_unregister_driver(&ish_driver);
-}
-
-module_init(ish_driver_init);
-module_exit(ish_driver_exit);
+module_pci_driver(ish_driver);
 
 /* Original author */
 MODULE_AUTHOR("Daniel Drubin <daniel.drubin@intel.com>");



