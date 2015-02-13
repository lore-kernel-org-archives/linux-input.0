From: Roman Volkov <v1ron@v1ros.org>
Subject: [PATCH v2 2/5] i8042: Kernel configuration handling for DT support
Date: Fri, 13 Feb 2015 22:52:50 +0300
Message-ID: <1423857173-16432-3-git-send-email-v1ron@v1ros.org>
References: <20150203011051.11999a16@v1ron-s7>
 <1423857173-16432-1-git-send-email-v1ron@v1ros.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423857173-16432-1-git-send-email-v1ron@v1ros.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Wolfram Sang <wsa@the-dreams.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Roman Volkov <v1ron@v1ros.org>
List-Id: linux-input@vger.kernel.org

i8042_dt.h should be included when CONFIG_ARCH_MIGHT_HAVE_PC_SERIO and
CONFIG_USE_OF are selected. It should be not necessary to create
additional options in the kernel config.

Signed-off-by: Roman Volkov <v1ron@v1ros.org>
---
 drivers/input/serio/i8042.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/serio/i8042.h b/drivers/input/serio/i8042.h
index fc080be..d2c1761 100644
--- a/drivers/input/serio/i8042.h
+++ b/drivers/input/serio/i8042.h
@@ -28,6 +28,9 @@
 #include "i8042-x86ia64io.h"
 #elif defined(CONFIG_UNICORE32)
 #include "i8042-unicore32io.h"
+#elif defined(CONFIG_ARCH_MIGHT_HAVE_PC_SERIO) && defined(CONFIG_USE_OF)
+#define SERIO_I8042_DT
+#include "i8042-dt.h"
 #else
 #include "i8042-io.h"
 #endif
-- 
2.3.0
