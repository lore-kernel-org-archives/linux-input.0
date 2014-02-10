From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH RESEND] input: Add commonly used event types
Date: Mon, 10 Feb 2014 08:21:49 +0400
Message-ID: <1392006109-10113-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp31.i.mail.ru ([94.100.177.91]:47125 "EHLO smtp31.i.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751556AbaBJEWF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 9 Feb 2014 23:22:05 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Alexander Shiyan <shc_work@mail.ru>

Patch adds commonly used event types (EV_KEY and EV_SW) to
devicetree bindings header for input subsystem.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 include/dt-bindings/input/input.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/input/input.h b/include/dt-bindings/input/input.h
index 042e7b3..3a141d92 100644
--- a/include/dt-bindings/input/input.h
+++ b/include/dt-bindings/input/input.h
@@ -9,6 +9,9 @@
 #ifndef _DT_BINDINGS_INPUT_INPUT_H
 #define _DT_BINDINGS_INPUT_INPUT_H
 
+#define EV_KEY			0x01
+#define EV_SW			0x05
+
 #define KEY_RESERVED		0
 #define KEY_ESC			1
 #define KEY_1			2
-- 
1.8.3.2

