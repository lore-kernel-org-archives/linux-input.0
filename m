From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v3 2/2] Input: axp20x-pek: add support for AXP221 PEK
Date: Wed,  9 Aug 2017 11:45:55 +0200
Message-ID: <d683600a390ba25187ff7d260a2efb3c00cc4b5f.1502271751.git-series.quentin.schulz@free-electrons.com>
References: <cover.634526c9e3d069f72bc162cdcaa9bb7c822d346a.1502271751.git-series.quentin.schulz@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.634526c9e3d069f72bc162cdcaa9bb7c822d346a.1502271751.git-series.quentin.schulz@free-electrons.com>
In-Reply-To: <cover.634526c9e3d069f72bc162cdcaa9bb7c822d346a.1502271751.git-series.quentin.schulz@free-electrons.com>
References: <cover.634526c9e3d069f72bc162cdcaa9bb7c822d346a.1502271751.git-series.quentin.schulz@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, wens@csie.org, lee.jones@linaro.org
Cc: hdegoede@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, thomas.petazzoni@free-electrons.com, maxime.ripard@free-electrons.com, Quentin Schulz <quentin.schulz@free-electrons.com>
List-Id: linux-input@vger.kernel.org

The AXP221 has different values for startup time bits from the AXP20X.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/input/misc/axp20x-pek.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
index f616fe5..a542906 100644
--- a/drivers/input/misc/axp20x-pek.c
+++ b/drivers/input/misc/axp20x-pek.c
@@ -56,6 +56,13 @@ static const struct axp20x_time startup_time[] = {
 	{ .time = 2000, .idx = 3 },
 };
 
+static const struct axp20x_time axp221_startup_time[] = {
+	{ .time = 128,  .idx = 0 },
+	{ .time = 1000, .idx = 1 },
+	{ .time = 2000, .idx = 2 },
+	{ .time = 3000, .idx = 3 },
+};
+
 static const struct axp20x_time shutdown_time[] = {
 	{ .time = 4000,  .idx = 0 },
 	{ .time = 6000,  .idx = 1 },
@@ -70,6 +77,13 @@ static const struct axp20x_info axp20x_info = {
 	.shutdown_mask = AXP20X_PEK_SHUTDOWN_MASK,
 };
 
+static const struct axp20x_info axp221_info = {
+	.startup_time = axp221_startup_time,
+	.startup_mask = AXP20X_PEK_STARTUP_MASK,
+	.shutdown_time = shutdown_time,
+	.shutdown_mask = AXP20X_PEK_SHUTDOWN_MASK,
+};
+
 static ssize_t axp20x_show_attr(struct device *dev,
 				const struct axp20x_time *time,
 				unsigned int mask, char *buf)
@@ -382,6 +396,9 @@ static const struct platform_device_id axp_pek_id_match[] = {
 	{
 		.name = "axp20x-pek",
 		.driver_data = (kernel_ulong_t)&axp20x_info,
+	}, {
+		.name = "axp221-pek",
+		.driver_data = (kernel_ulong_t)&axp221_info,
 	},
 };
 
-- 
git-series 0.9.1
