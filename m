From: Pravin Shedge <pravin.shedge4linux@gmail.com>
Subject: [PATCH 08/45] drivers: input: remove duplicate includes
Date: Tue,  5 Dec 2017 07:31:08 +0530
Message-ID: <1512439272-15824-1-git-send-email-pravin.shedge4linux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41635 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751756AbdLED6V (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 4 Dec 2017 22:58:21 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: pravin.shedge4linux@gmail.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Nick Dyer <nick@shmanahar.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Colin Ian King <colin.king@canonical.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

These duplicate includes have been found with scripts/checkincludes.pl but
they have been removed manually to avoid removing false positives.

Signed-off-by: Pravin Shedge <pravin.shedge4linux@gmail.com>
---
 drivers/input/rmi4/rmi_f34.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_f34.c b/drivers/input/rmi4/rmi_f34.c
index 4cfe970..f1f5ac5 100644
--- a/drivers/input/rmi4/rmi_f34.c
+++ b/drivers/input/rmi4/rmi_f34.c
@@ -11,7 +11,6 @@
 #include <linux/rmi.h>
 #include <linux/firmware.h>
 #include <asm/unaligned.h>
-#include <asm/unaligned.h>
 #include <linux/bitops.h>
 
 #include "rmi_driver.h"
-- 
2.7.4

