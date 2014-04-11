From: Gabriel FERNANDEZ <gabriel.fernandez@st.com>
Subject: [PATCH v4 7/7] ARM: multi_v7_defconfig: add ST Keyscan driver
Date: Fri, 11 Apr 2014 17:07:36 +0200
Message-ID: <1397228856-9218-8-git-send-email-gabriel.fernandez@linaro.org>
References: <1397228856-9218-1-git-send-email-gabriel.fernandez@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1397228856-9218-1-git-send-email-gabriel.fernandez@linaro.org>
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
Cc: devicetree@vger.kernel.org, kernel@stlinux.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Gabriel Fernandez <gabriel.fernandez@linaro.org>, linux-input@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

This patch adds KEYBOARD_ST_KEYSCAN config

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index d4e8a47..4f0dce1 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -143,6 +143,7 @@ CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_GPIO=y
 CONFIG_KEYBOARD_TEGRA=y
 CONFIG_KEYBOARD_SPEAR=y
+CONFIG_KEYBOARD_ST_KEYSCAN=y
 CONFIG_KEYBOARD_CROS_EC=y
 CONFIG_MOUSE_PS2_ELANTECH=y
 CONFIG_INPUT_MISC=y
-- 
1.9.1
