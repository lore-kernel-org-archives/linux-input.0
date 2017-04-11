From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH v4 2/5] input: add an EV_REL event for high-res vertical wheel
Date: Tue, 11 Apr 2017 10:29:39 -0300
Message-ID: <5656f59d7fb0590dd139c5e6b597bd56e823bd94.1491917052.git.mchehab@s-opensource.com>
References: <cover.1491917052.git.mchehab@s-opensource.com>
 <34b4f3e6baedde818516ceb1d009f6568b953345.1491917052.git.mchehab@s-opensource.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:59460
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751966AbdDKNaQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 11 Apr 2017 09:30:16 -0400
In-Reply-To: <34b4f3e6baedde818516ceb1d009f6568b953345.1491917052.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1491917052.git.mchehab@s-opensource.com>
References: <cover.1491917052.git.mchehab@s-opensource.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Jonathan Corbet <corbet@lwn.net>, Roderick Colenbrander <roderick.colenbrander@sony.com>, Ping Cheng <pinglinux@gmail.com>, Hans Verkuil <hans.verkuil@cisco.com>, Kamil Debski <kamil@wypas.org>, Douglas Anderson <dianders@chromium.org>, linux-doc@vger.kernel.org

As some devices can produce either low-res or high-res
vertical wheel EV_REL events, add a new event to allow
userspace to distinguish between them.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 Documentation/input/event-codes.txt    | 17 ++++++++++++++---
 include/uapi/linux/input-event-codes.h |  1 +
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/input/event-codes.txt b/Documentation/input/event-codes.txt
index 575415f4cef0..50352ab5f6d4 100644
--- a/Documentation/input/event-codes.txt
+++ b/Documentation/input/event-codes.txt
@@ -156,9 +156,20 @@ instead of EV_REL codes.
 
 A few EV_REL codes have special meanings:
 
-* REL_WHEEL, REL_HWHEEL:
-  - These codes are used for vertical and horizontal scroll wheels,
-    respectively.
+* REL_WHEEL:
+
+  - These codes are used for vertical scroll wheels.
+
+  - REL_WHEEL is for normal wheel operational mode, e. g. low-resolution
+    (line-based) scroll.
+
+  - REL_HIRES_WHEEL should be used when the wheel has two resolutions and it
+    is in high-resolution mode, e. g. the same angular movement that would
+    produce a single REL_WHEEL will produce multiple REL_HIRES_WHEEL events.
+
+* REL_HWHEEL:
+
+  - This code is used for horizontal scroll wheels.
 
 EV_ABS:
 ----------
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 444956ba832c..da48d4079511 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -710,6 +710,7 @@
 #define REL_MISC_4		0x0d
 #define REL_MISC_5		0x0e
 #define REL_MISC_6		0x0f
+#define REL_HIRES_WHEEL		0x10
 #define REL_MAX			0x1f
 #define REL_CNT			(REL_MAX+1)
 
-- 
2.9.3

