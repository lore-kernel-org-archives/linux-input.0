From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/4] input: keyboard: tegra: fix build warning
Date: Fri, 4 Jan 2013 16:32:07 +0530
Message-ID: <1357297330-28878-2-git-send-email-ldewangan@nvidia.com>
References: <1357297330-28878-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1357297330-28878-1-git-send-email-ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Fix the following build warning when building driver with CONFIG_PM_SLEEP
not selected.

tegra-kbc.c:360:13: warning: 'tegra_kbc_set_keypress_interrupt' defined but not used [-Wunused-function]

Signed-off-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/input/keyboard/tegra-kbc.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index c76f968..f1d3ba0 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -357,18 +357,6 @@ static void tegra_kbc_set_fifo_interrupt(struct tegra_kbc *kbc, bool enable)
 	writel(val, kbc->mmio + KBC_CONTROL_0);
 }
 
-static void tegra_kbc_set_keypress_interrupt(struct tegra_kbc *kbc, bool enable)
-{
-	u32 val;
-
-	val = readl(kbc->mmio + KBC_CONTROL_0);
-	if (enable)
-		val |= KBC_CONTROL_KEYPRESS_INT_EN;
-	else
-		val &= ~KBC_CONTROL_KEYPRESS_INT_EN;
-	writel(val, kbc->mmio + KBC_CONTROL_0);
-}
-
 static void tegra_kbc_keypress_timer(unsigned long data)
 {
 	struct tegra_kbc *kbc = (struct tegra_kbc *)data;
@@ -866,6 +854,18 @@ static int tegra_kbc_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM_SLEEP
+static void tegra_kbc_set_keypress_interrupt(struct tegra_kbc *kbc, bool enable)
+{
+	u32 val;
+
+	val = readl(kbc->mmio + KBC_CONTROL_0);
+	if (enable)
+		val |= KBC_CONTROL_KEYPRESS_INT_EN;
+	else
+		val &= ~KBC_CONTROL_KEYPRESS_INT_EN;
+	writel(val, kbc->mmio + KBC_CONTROL_0);
+}
+
 static int tegra_kbc_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
-- 
1.7.1.1
