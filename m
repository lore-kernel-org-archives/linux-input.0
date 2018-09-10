From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 4/8] clk: mmp2: add SP clock
Date: Mon, 10 Sep 2018 13:26:50 +0200
Message-ID: <20180910112654.42061-5-lkundrak@v3.sk>
References: <20180910112654.42061-1-lkundrak@v3.sk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180910112654.42061-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>
List-Id: linux-input@vger.kernel.org

The "security processor", sometimes referred to as "wireless trusted
module" or "generic encrypt unit" is a low-power core present on MMP2,
that has nothing to do with security, wireless, trust or encryption.

On an OLPC machine it runs CForth and serves as a keyboard controller:
http://dev.laptop.org/git/users/wmb/cforth/tree/src/app/arm-xo-1.75/ps2.fth

The register address was obtained from the OLPC kernel, since the
datasheet seems to be the Marvell's most important business secret.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/clk/mmp/clk-of-mmp2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/mmp/clk-of-mmp2.c b/drivers/clk/mmp/clk-of-mmp2.c
index 0fc75c395957..1da50f827a15 100644
--- a/drivers/clk/mmp/clk-of-mmp2.c
+++ b/drivers/clk/mmp/clk-of-mmp2.c
@@ -53,6 +53,7 @@
 #define APMU_DISP1	0x110
 #define APMU_CCIC0	0x50
 #define APMU_CCIC1	0xf4
+#define APMU_SP		0x68
 #define MPMU_UART_PLL	0x14
 
 struct mmp2_clk_unit {
@@ -209,6 +210,8 @@ static struct mmp_clk_mix_config ccic1_mix_config = {
 	.reg_info = DEFINE_MIX_REG_INFO(4, 16, 2, 6, 32),
 };
 
+static DEFINE_SPINLOCK(sp_lock);
+
 static struct mmp_param_mux_clk apmu_mux_clks[] = {
 	{MMP2_CLK_DISP0_MUX, "disp0_mux", disp_parent_names, ARRAY_SIZE(disp_parent_names), CLK_SET_RATE_PARENT, APMU_DISP0, 6, 2, 0, &disp0_lock},
 	{MMP2_CLK_DISP1_MUX, "disp1_mux", disp_parent_names, ARRAY_SIZE(disp_parent_names), CLK_SET_RATE_PARENT, APMU_DISP1, 6, 2, 0, &disp1_lock},
@@ -239,6 +242,7 @@ static struct mmp_param_gate_clk apmu_gate_clks[] = {
 	{MMP2_CLK_CCIC1, "ccic1_clk", "ccic1_mix_clk", CLK_SET_RATE_PARENT, APMU_CCIC1, 0x1b, 0x1b, 0x0, 0, &ccic1_lock},
 	{MMP2_CLK_CCIC1_PHY, "ccic1_phy_clk", "ccic1_mix_clk", CLK_SET_RATE_PARENT, APMU_CCIC1, 0x24, 0x24, 0x0, 0, &ccic1_lock},
 	{MMP2_CLK_CCIC1_SPHY, "ccic1_sphy_clk", "ccic1_sphy_div", CLK_SET_RATE_PARENT, APMU_CCIC1, 0x300, 0x300, 0x0, 0, &ccic1_lock},
+	{MMP2_CLK_SP, "sp_clk", NULL, CLK_SET_RATE_PARENT, APMU_SP, 0x1b, 0x1b, 0x0, 0, &sp_lock},
 };
 
 static void mmp2_axi_periph_clk_init(struct mmp2_clk_unit *pxa_unit)
-- 
2.17.1
