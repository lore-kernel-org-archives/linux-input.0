From: Roman Volkov <rvolkov@v1ros.org>
Subject: [PATCH v4 2/4] i8042: Kernel configuration for OF/FDT support
Date: Sat,  4 Jul 2015 20:35:42 +0300
Message-ID: <1436031344-15455-3-git-send-email-rvolkov@v1ros.org>
References: <342234234esdfewrewrwer@dkoi.org>
 <1436031344-15455-1-git-send-email-rvolkov@v1ros.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from v1ros.org ([109.234.34.72]:53241 "EHLO smtp.v1ros.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755361AbbGEJAr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 5 Jul 2015 05:00:47 -0400
In-Reply-To: <1436031344-15455-1-git-send-email-rvolkov@v1ros.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Wolfram Sang <wsa@the-dreams.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Tony Prisk <linux@prisktech.co.nz>, Roman Volkov <rvolkov@v1ros.org>

i8042_of.h should be included when CONFIG_ARCH_MIGHT_HAVE_PC_SERIO and
CONFIG_USE_OF are selected. Kconfig is not modified.

Signed-off-by: Roman Volkov <rvolkov@v1ros.org>
---
 drivers/input/serio/i8042.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/serio/i8042.h b/drivers/input/serio/i8042.h
index fc080be..55fc856 100644
--- a/drivers/input/serio/i8042.h
+++ b/drivers/input/serio/i8042.h
@@ -28,6 +28,9 @@
 #include "i8042-x86ia64io.h"
 #elif defined(CONFIG_UNICORE32)
 #include "i8042-unicore32io.h"
+#elif defined(CONFIG_ARCH_MIGHT_HAVE_PC_SERIO) && defined(CONFIG_USE_OF)
+#define SERIO_I8042_OF
+#include "i8042-of.h"
 #else
 #include "i8042-io.h"
 #endif
-- 
2.4.2

