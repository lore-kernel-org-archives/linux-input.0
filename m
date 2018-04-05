From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v6 11/30] drm/bridge: analogix_dp: Fix AUX_PD bit for Rockchip
Date: Thu,  5 Apr 2018 11:49:41 +0200
Message-ID: <20180405095000.9756-12-enric.balletbo@collabora.com>
References: <20180405095000.9756-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180405095000.9756-1-enric.balletbo@collabora.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: architt@codeaurora.org, inki.dae@samsung.com, thierry.reding@gmail.com, hjc@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie, tfiga@chromium.org, heiko@sntech.de
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com, ykk@rock-chips.com, kernel@collabora.com, m.szyprowski@samsung.com, linux-samsung-soc@vger.kernel.org, jy0922.shim@samsung.com, rydberg@bitmath.org, krzk@kernel.org, linux-rockchip@lists.infradead.org, kgene@kernel.org, linux-input@vger.kernel.org, orjan.eide@arm.com, wxt@rock-chips.com, jeffy.chen@rock-chips.com, linux-arm-kernel@lists.infradead.org, mark.yao@rock-chips.com, wzz@rock-chips.com, hl@rock-chips.com, jingoohan1@gmail.com, sw0312.kim@samsung.com, dianders@chromium.org, kyungmin.park@samsung.com, Enric Balletbo i Serra <enric.balletbo@collabora.com>, kuankuan.y@gmail.com, hshi@chromium.org
List-Id: linux-input@vger.kernel.org

From: zain wang <wzz@rock-chips.com>

There are some different bits between Rockchip and Exynos in register
"AUX_PD". This patch fixes the incorrect operations about it.

Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: zain wang <wzz@rock-chips.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Archit Taneja <architt@codeaurora.org>
---

 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c | 117 ++++++++++++----------
 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h |   2 +
 2 files changed, 65 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index bb72f8b0e603..dee1ba109b5f 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -248,76 +248,85 @@ void analogix_dp_set_analog_power_down(struct analogix_dp_device *dp,
 {
 	u32 reg;
 	u32 phy_pd_addr = ANALOGIX_DP_PHY_PD;
+	u32 mask;
 
 	if (dp->plat_data && is_rockchip(dp->plat_data->dev_type))
 		phy_pd_addr = ANALOGIX_DP_PD;
 
 	switch (block) {
 	case AUX_BLOCK:
-		if (enable) {
-			reg = readl(dp->reg_base + phy_pd_addr);
-			reg |= AUX_PD;
-			writel(reg, dp->reg_base + phy_pd_addr);
-		} else {
-			reg = readl(dp->reg_base + phy_pd_addr);
-			reg &= ~AUX_PD;
-			writel(reg, dp->reg_base + phy_pd_addr);
-		}
+		if (dp->plat_data && is_rockchip(dp->plat_data->dev_type))
+			mask = RK_AUX_PD;
+		else
+			mask = AUX_PD;
+
+		reg = readl(dp->reg_base + phy_pd_addr);
+		if (enable)
+			reg |= mask;
+		else
+			reg &= ~mask;
+		writel(reg, dp->reg_base + phy_pd_addr);
 		break;
 	case CH0_BLOCK:
-		if (enable) {
-			reg = readl(dp->reg_base + phy_pd_addr);
-			reg |= CH0_PD;
-			writel(reg, dp->reg_base + phy_pd_addr);
-		} else {
-			reg = readl(dp->reg_base + phy_pd_addr);
-			reg &= ~CH0_PD;
-			writel(reg, dp->reg_base + phy_pd_addr);
-		}
+		mask = CH0_PD;
+		reg = readl(dp->reg_base + phy_pd_addr);
+
+		if (enable)
+			reg |= mask;
+		else
+			reg &= ~mask;
+		writel(reg, dp->reg_base + phy_pd_addr);
 		break;
 	case CH1_BLOCK:
-		if (enable) {
-			reg = readl(dp->reg_base + phy_pd_addr);
-			reg |= CH1_PD;
-			writel(reg, dp->reg_base + phy_pd_addr);
-		} else {
-			reg = readl(dp->reg_base + phy_pd_addr);
-			reg &= ~CH1_PD;
-			writel(reg, dp->reg_base + phy_pd_addr);
-		}
+		mask = CH1_PD;
+		reg = readl(dp->reg_base + phy_pd_addr);
+
+		if (enable)
+			reg |= mask;
+		else
+			reg &= ~mask;
+		writel(reg, dp->reg_base + phy_pd_addr);
 		break;
 	case CH2_BLOCK:
-		if (enable) {
-			reg = readl(dp->reg_base + phy_pd_addr);
-			reg |= CH2_PD;
-			writel(reg, dp->reg_base + phy_pd_addr);
-		} else {
-			reg = readl(dp->reg_base + phy_pd_addr);
-			reg &= ~CH2_PD;
-			writel(reg, dp->reg_base + phy_pd_addr);
-		}
+		mask = CH2_PD;
+		reg = readl(dp->reg_base + phy_pd_addr);
+
+		if (enable)
+			reg |= mask;
+		else
+			reg &= ~mask;
+		writel(reg, dp->reg_base + phy_pd_addr);
 		break;
 	case CH3_BLOCK:
-		if (enable) {
-			reg = readl(dp->reg_base + phy_pd_addr);
-			reg |= CH3_PD;
-			writel(reg, dp->reg_base + phy_pd_addr);
-		} else {
-			reg = readl(dp->reg_base + phy_pd_addr);
-			reg &= ~CH3_PD;
-			writel(reg, dp->reg_base + phy_pd_addr);
-		}
+		mask = CH3_PD;
+		reg = readl(dp->reg_base + phy_pd_addr);
+
+		if (enable)
+			reg |= mask;
+		else
+			reg &= ~mask;
+		writel(reg, dp->reg_base + phy_pd_addr);
 		break;
 	case ANALOG_TOTAL:
-		if (enable) {
-			reg = readl(dp->reg_base + phy_pd_addr);
-			reg |= DP_PHY_PD;
-			writel(reg, dp->reg_base + phy_pd_addr);
-		} else {
-			reg = readl(dp->reg_base + phy_pd_addr);
-			reg &= ~DP_PHY_PD;
-			writel(reg, dp->reg_base + phy_pd_addr);
-		}
+		/*
+		 * There is no bit named DP_PHY_PD, so We used DP_INC_BG
+		 * to power off everything instead of DP_PHY_PD in
+		 * Rockchip
+		 */
+		if (dp->plat_data && is_rockchip(dp->plat_data->dev_type))
+			mask = DP_INC_BG;
+		else
+			mask = DP_PHY_PD;
+
+		reg = readl(dp->reg_base + phy_pd_addr);
+		if (enable)
+			reg |= mask;
+		else
+			reg &= ~mask;
+
+		writel(reg, dp->reg_base + phy_pd_addr);
+		if (dp->plat_data && is_rockchip(dp->plat_data->dev_type))
+			usleep_range(10, 15);
 		break;
 	case POWER_ALL:
 		if (enable) {
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h
index 9602668669f4..b633a4a5082a 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h
@@ -345,7 +345,9 @@
 #define DP_INC_BG				(0x1 << 7)
 #define DP_EXP_BG				(0x1 << 6)
 #define DP_PHY_PD				(0x1 << 5)
+#define RK_AUX_PD				(0x1 << 5)
 #define AUX_PD					(0x1 << 4)
+#define RK_PLL_PD				(0x1 << 4)
 #define CH3_PD					(0x1 << 3)
 #define CH2_PD					(0x1 << 2)
 #define CH1_PD					(0x1 << 1)
-- 
2.16.3
