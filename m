From: Gabriel FERNANDEZ <gabriel.fernandez@st.com>
Subject: [PATCH v3 2/7] driver: reset: sti: add keyscan for stih415
Date: Fri, 11 Apr 2014 16:33:30 +0200
Message-ID: <1397226820-5604-4-git-send-email-gabriel.fernandez@linaro.org>
References: <1397226820-5604-1-git-send-email-gabriel.fernandez@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1397226820-5604-1-git-send-email-gabriel.fernandez@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Grant Likely <grant.likely@linaro.org>
Cc: devicetree@vger.kernel.org, kernel@stlinux.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Giuseppe CONDORELLI <giuseppe.condorelli@st.com>, linux-input@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

From: Giuseppe CONDORELLI <giuseppe.condorelli@st.com>

Add keyscan reset on stih415 reset controller.

Signed-off-by: Giuseppe Condorelli <giuseppe.condorelli@st.com>
---
 drivers/reset/sti/reset-stih415.c                     | 1 +
 include/dt-bindings/reset-controller/stih415-resets.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/reset/sti/reset-stih415.c b/drivers/reset/sti/reset-stih415.c
index e6f6c41..c93fd26 100644
--- a/drivers/reset/sti/reset-stih415.c
+++ b/drivers/reset/sti/reset-stih415.c
@@ -73,6 +73,7 @@ static const struct syscfg_reset_channel_data stih415_softresets[] = {
 	[STIH415_USB0_SOFTRESET] = STIH415_SRST_REAR(SYSCFG_376, 9),
 	[STIH415_USB1_SOFTRESET] = STIH415_SRST_REAR(SYSCFG_376, 10),
 	[STIH415_USB2_SOFTRESET] = STIH415_SRST_REAR(SYSCFG_376, 11),
+	[STIH415_KEYSCAN_SOFTRESET] = STIH415_SRST_LPM(LPM_SYSCFG_1, 8),
 };
 
 static struct syscfg_reset_controller_data stih415_powerdown_controller = {
diff --git a/include/dt-bindings/reset-controller/stih415-resets.h b/include/dt-bindings/reset-controller/stih415-resets.h
index c2f8a66..c2329fe 100644
--- a/include/dt-bindings/reset-controller/stih415-resets.h
+++ b/include/dt-bindings/reset-controller/stih415-resets.h
@@ -22,5 +22,6 @@
 #define STIH415_USB0_SOFTRESET		3
 #define STIH415_USB1_SOFTRESET		4
 #define STIH415_USB2_SOFTRESET		5
+#define STIH415_KEYSCAN_SOFTRESET	6
 
 #endif /* _DT_BINDINGS_RESET_CONTROLLER_STIH415 */
-- 
1.9.1
