From: Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH] HID: intel-ish-hid: Remove unneeded linux/miscdevice.h include
Date: Thu, 15 Dec 2016 16:27:11 +0100
Message-ID: <20161215152711.9069-1-clabbe.montjoie@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wj0-f195.google.com ([209.85.210.195]:34182 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752131AbcLOP3P (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 15 Dec 2016 10:29:15 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: srinivas.pandruvada@linux.intel.com, jikos@kernel.org, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Corentin Labbe <clabbe.montjoie@gmail.com>

hid/intel-ish-hid does not use any miscdevice so this patch remove
this unnecessary inclusion.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/hid/intel-ish-hid/ipc/pci-ish.c | 1 -
 drivers/hid/intel-ish-hid/ishtp/hbm.c   | 1 -
 drivers/hid/intel-ish-hid/ishtp/init.c  | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index 20d647d..d20da39 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -24,7 +24,6 @@
 #include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/workqueue.h>
-#include <linux/miscdevice.h>
 #define CREATE_TRACE_POINTS
 #include <trace/events/intel_ish.h>
 #include "ishtp-dev.h"
diff --git a/drivers/hid/intel-ish-hid/ishtp/hbm.c b/drivers/hid/intel-ish-hid/ishtp/hbm.c
index 59460b6..b721360 100644
--- a/drivers/hid/intel-ish-hid/ishtp/hbm.c
+++ b/drivers/hid/intel-ish-hid/ishtp/hbm.c
@@ -19,7 +19,6 @@
 #include <linux/sched.h>
 #include <linux/wait.h>
 #include <linux/spinlock.h>
-#include <linux/miscdevice.h>
 #include "ishtp-dev.h"
 #include "hbm.h"
 #include "client.h"
diff --git a/drivers/hid/intel-ish-hid/ishtp/init.c b/drivers/hid/intel-ish-hid/ishtp/init.c
index ac36441..d27e035 100644
--- a/drivers/hid/intel-ish-hid/ishtp/init.c
+++ b/drivers/hid/intel-ish-hid/ishtp/init.c
@@ -16,7 +16,6 @@
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
-#include <linux/miscdevice.h>
 #include "ishtp-dev.h"
 #include "hbm.h"
 #include "client.h"
-- 
2.10.2

