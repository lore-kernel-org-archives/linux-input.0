From: Gabriel FERNANDEZ <gabriel.fernandez@st.com>
Subject: [PATCH v3 3/7] driver: reset: sti: add keyscan for stih416
Date: Fri, 11 Apr 2014 16:33:32 +0200
Message-ID: <1397226820-5604-6-git-send-email-gabriel.fernandez@linaro.org>
References: <1397226820-5604-1-git-send-email-gabriel.fernandez@linaro.org>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1397226820-5604-1-git-send-email-gabriel.fernandez@linaro.org>
Sender: linux-doc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Grant Likely <grant.likely@linaro.org>
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, kernel@stlinux.com, Lee Jones <lee.jones@linaro.org>, Giuseppe CONDORELLI <giuseppe.condorelli@st.com>, Gabriel Fernandez <gabriel.fernandez@linaro.org>
List-Id: linux-input@vger.kernel.org

From: Giuseppe CONDORELLI <giuseppe.condorelli@st.com>

Add keyscan reset on stih416 reset controller.

Signed-off-by: Giuseppe Condorelli <giuseppe.condorelli@st.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 drivers/reset/sti/reset-stih416.c                     | 1 +
 include/dt-bindings/reset-controller/stih416-resets.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/reset/sti/reset-stih416.c b/drivers/reset/sti/reset-stih416.c
index fe3bf02..5fc9870 100644
--- a/drivers/reset/sti/reset-stih416.c
+++ b/drivers/reset/sti/reset-stih416.c
@@ -104,6 +104,7 @@ static const struct syscfg_reset_channel_data stih416_softresets[] = {
 	[STIH416_COMPO_A_SOFTRESET] = STIH416_SRST_CPU(SYSCFG_7564, 4),
 	[STIH416_VP8_DEC_SOFTRESET] = STIH416_SRST_CPU(SYSCFG_7564, 10),
 	[STIH416_VTG_MAIN_SOFTRESET] = STIH416_SRST_CPU(SYSCFG_7564, 16),
+	[STIH416_KEYSCAN_SOFTRESET] = STIH416_SRST_LPM(LPM_SYSCFG_1, 8),
 };
 
 static struct syscfg_reset_controller_data stih416_powerdown_controller = {
diff --git a/include/dt-bindings/reset-controller/stih416-resets.h b/include/dt-bindings/reset-controller/stih416-resets.h
index 2127743..fcf9af1 100644
--- a/include/dt-bindings/reset-controller/stih416-resets.h
+++ b/include/dt-bindings/reset-controller/stih416-resets.h
@@ -46,5 +46,6 @@
 #define STIH416_COMPO_A_SOFTRESET	25
 #define STIH416_VP8_DEC_SOFTRESET	26
 #define STIH416_VTG_MAIN_SOFTRESET	27
+#define STIH416_KEYSCAN_SOFTRESET	28
 
 #endif /* _DT_BINDINGS_RESET_CONTROLLER_STIH416 */
-- 
1.9.1

