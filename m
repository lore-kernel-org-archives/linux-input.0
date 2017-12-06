From: Anthony Kim <anthony.kim@hideep.com>
Subject: [PATCH] Input: include "linux/gpio/consumer.h" header file.
Date: Wed,  6 Dec 2017 10:41:15 +0900
Message-ID: <1512524475-32624-1-git-send-email-anthony.kim@hideep.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dennis.hong@hideep.com, Anthony Kim <anthony.kim@hideep.com>
List-Id: linux-input@vger.kernel.org

An error occurred during compile because there is no header file
at x86 configure.

Signed-off-by: Anthony Kim <anthony.kim@hideep.com>
---
 drivers/input/touchscreen/hideep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/hideep.c b/drivers/input/touchscreen/hideep.c
index fc080a7..037da00 100644
--- a/drivers/input/touchscreen/hideep.c
+++ b/drivers/input/touchscreen/hideep.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/gpio.h>
 #include <linux/gpio/machine.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/acpi.h>
 #include <linux/interrupt.h>
-- 
2.7.4
