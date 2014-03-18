From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH RESEND] input: dts: Add commonly used event types
Date: Tue, 18 Mar 2014 22:04:47 +0400
Message-ID: <1395165888-17434-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp37.i.mail.ru ([94.100.177.97]:46416 "EHLO smtp37.i.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756991AbaCRSFE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Mar 2014 14:05:04 -0400
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

