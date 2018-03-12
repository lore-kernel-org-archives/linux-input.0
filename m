From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH v5 4/4] ARM: rockchip: Set name of regmap_config
Date: Mon, 12 Mar 2018 17:51:42 +0800
Message-ID: <20180312095142.30854-5-jeffy.chen@rock-chips.com>
References: <20180312095142.30854-1-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180312095142.30854-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, broonie@kernel.org, alexandre.belloni@bootlin.com
Cc: Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>, Joseph Lo <josephl@nvidia.com>, Rob Herring <robh+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, lee.jones@linaro.org, Emil Renner Berthing <kernel@esmil.dk>, Heiko Stuebner <heiko@sntech.de>, Brian Norris <briannorris@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>, linux-rockchip@lists.infradead.org, Kate Stewart <kstewart@linuxfoundation.org>, linux-input@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, Matthias Kaehlcke <mka@chromium.org>, devicetree@vger.kernel.org, stephen lu <lumotuwe@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arvind Yadav <arvind.yadav.cs@gmail.com>
List-Id: linux-input@vger.kernel.org

We are now allowing to register debugfs without a valid device, and not
having a valid name will end up using "dummy*" to create debugfs dir.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None

 arch/arm/mach-rockchip/platsmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-rockchip/platsmp.c b/arch/arm/mach-rockchip/platsmp.c
index ecec340ca345..51984a40b097 100644
--- a/arch/arm/mach-rockchip/platsmp.c
+++ b/arch/arm/mach-rockchip/platsmp.c
@@ -208,6 +208,7 @@ static int __init rockchip_smp_prepare_sram(struct device_node *node)
 }
 
 static const struct regmap_config rockchip_pmu_regmap_config = {
+	.name = "rockchip-pmu",
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
-- 
2.11.0
