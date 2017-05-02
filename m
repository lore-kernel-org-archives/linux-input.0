From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
Subject: [PATCH] input: edt-ft5x06: increase allowed data range for threshold parameter
Date: Tue, 2 May 2017 17:00:59 +0200
Message-ID: <1493737259-26210-1-git-send-email-martin.kepplinger@ginzinger.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.ginzinger.com ([31.193.165.229]:56162 "EHLO
        mail.ginzinger.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbdEBPB6 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 2 May 2017 11:01:58 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, simon.budig@kernelconcepts.de, daniel.wagener@kernelconcepts.de, mchehab@kernel.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Martin Kepplinger <martin.kepplinger@ginzinger.com>, Schoefegger Stefan <stefan.schoefegger@ginzinger.com>, Manfred Schlaegl <manfred.schlaegl@ginzinger.com>

The datasheet and application note does not mention an allowed range for
the M09_REGISTER_THRESHOLD parameter. One of our customers needs to set
lower values than 20 and they seem to work just fine on EDT EP0xx0M09 with
T5x06 touch.

So, lacking a known lower limit, we increase the range for thresholds,
and set the lower limit to 0. The documentation is updated accordingly.

Signed-off-by: Schoefegger Stefan <stefan.schoefegger@ginzinger.com>
Signed-off-by: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
---
 Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt | 2 +-
 Documentation/input/devices/edt-ft5x06.rst                         | 2 +-
 drivers/input/touchscreen/edt-ft5x06.c                             | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
index 6db2210..025cf8c 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
@@ -36,7 +36,7 @@ Optional properties:
                 control gpios
 
  - threshold:   allows setting the "click"-threshold in the range
-                from 20 to 80.
+                from 0 to 80.
 
  - gain:        allows setting the sensitivity in the range from 0 to
                 31. Note that lower values indicate higher
diff --git a/Documentation/input/devices/edt-ft5x06.rst b/Documentation/input/devices/edt-ft5x06.rst
index 2032f0b..1ccc94b 100644
--- a/Documentation/input/devices/edt-ft5x06.rst
+++ b/Documentation/input/devices/edt-ft5x06.rst
@@ -15,7 +15,7 @@ It has been tested with the following devices:
 The driver allows configuration of the touch screen via a set of sysfs files:
 
 /sys/class/input/eventX/device/device/threshold:
-    allows setting the "click"-threshold in the range from 20 to 80.
+    allows setting the "click"-threshold in the range from 0 to 80.
 
 /sys/class/input/eventX/device/device/gain:
     allows setting the sensitivity in the range from 0 to 31. Note that
diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 8cf8d8d..f872817 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -471,7 +471,7 @@ static EDT_ATTR(gain, S_IWUSR | S_IRUGO, WORK_REGISTER_GAIN,
 static EDT_ATTR(offset, S_IWUSR | S_IRUGO, WORK_REGISTER_OFFSET,
 		M09_REGISTER_OFFSET, 0, 31);
 static EDT_ATTR(threshold, S_IWUSR | S_IRUGO, WORK_REGISTER_THRESHOLD,
-		M09_REGISTER_THRESHOLD, 20, 80);
+		M09_REGISTER_THRESHOLD, 0, 80);
 static EDT_ATTR(report_rate, S_IWUSR | S_IRUGO, WORK_REGISTER_REPORT_RATE,
 		NO_REGISTER, 3, 14);
 
-- 
2.1.4

