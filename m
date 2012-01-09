From: Jussi Pakkanen <jussi.pakkanen@canonical.com>
Subject: [PATCH] Documented input device properties.
Date: Mon,  9 Jan 2012 18:44:14 +0200
Message-ID: <1326127454-11695-1-git-send-email-jussi.pakkanen@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:46552 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932178Ab2AIQoQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Jan 2012 11:44:16 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

---
 Documentation/input/event-codes.txt |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/Documentation/input/event-codes.txt b/Documentation/input/event-codes.txt
index 23fcb05..7c515a5 100644
--- a/Documentation/input/event-codes.txt
+++ b/Documentation/input/event-codes.txt
@@ -220,6 +220,33 @@ EV_PWR:
 EV_PWR events are a special type of event used specifically for power
 mangement. Its usage is not well defined. To be addressed later.
 
+Device properties:
+=================
+
+INPUT_PROP_POINTER:
+------------------
+There is a one to one mapping between the device coordinates and
+screen coordinates. This property only has meaning for non-touch based
+input such as a pen or an eraser. A drawing tablet would have this property
+set.
+INPUT_PROP_DIRECT:
+------------------
+The same as INPUT_PROP_POINTER, but for touches. An example would be a
+touchscreen.
+INPUT_PROP_BUTTONPAD:
+--------------------
+The device has one or more physical buttons beneath the active surface area.
+This means that you can generate button clicks by pressing down on the
+trackpad area. Examples include aluminium body MacBook trackpads and 
+Synaptics clickpads.
+INPUT_PROP_SEMI_MT:
+------------------
+The device is a semi multitouch device. This means that it does not
+provide proper touch locations; it only reports the total number of
+touches and a bounding box that is defined by two of the
+touches. There is no way to know which two touches the device chooses
+to report.
+
 Guidelines:
 ==========
 The guidelines below ensure proper single-touch and multi-finger functionality.
-- 
1.7.5.4

