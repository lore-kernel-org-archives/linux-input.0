From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v2 3/3] Input: axp20x-pek: add support for AXP221 PEK
Date: Wed, 19 Jul 2017 09:43:37 +0200
Message-ID: <20170719074337.19189-4-quentin.schulz@free-electrons.com>
References: <20170719074337.19189-1-quentin.schulz@free-electrons.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:54402 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752492AbdGSHoC (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 19 Jul 2017 03:44:02 -0400
In-Reply-To: <20170719074337.19189-1-quentin.schulz@free-electrons.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, wens@csie.org, lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>, hdegoede@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, thomas.petazzoni@free-electrons.com, maxime.ripard@free-electrons.com

The AXP221 has different values for startup time bits from the AXP20X.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 drivers/input/misc/axp20x-pek.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
index fa49f45c0f0e..71fd0dc7dad4 100644
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
@@ -397,6 +411,9 @@ static const struct platform_device_id axp_pek_id_match[] = {
 	{
 		.name = "axp20x-pek",
 		.driver_data = (kernel_ulong_t)&axp20x_info,
+	}, {
+		.name = "axp221-pek",
+		.driver_data = (kernel_ulong_t)&axp221_info,
 	},
 };
 
-- 
2.11.0

