From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] HID: intel_ish-hid: Remove duplicated include from bus.c
Date: Sun, 21 Aug 2016 15:31:35 +0000
Message-ID: <1471793495-24402-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34395 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752877AbcHUPcA (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 21 Aug 2016 11:32:00 -0400
Received: by mail-pa0-f65.google.com with SMTP id hh10so6550902pac.1
        for <linux-input@vger.kernel.org>; Sun, 21 Aug 2016 08:32:00 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, linux-input@vger.kernel.org

Remove duplicated include.

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 drivers/hid/intel-ish-hid/ishtp/bus.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c b/drivers/hid/intel-ish-hid/ishtp/bus.c
index 0183eac..c0b4583 100644
--- a/drivers/hid/intel-ish-hid/ishtp/bus.c
+++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
@@ -16,7 +16,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/kernel.h>
 #include <linux/device.h>
 #include <linux/sched.h>
 #include <linux/slab.h>



