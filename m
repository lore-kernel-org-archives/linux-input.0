From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH 2/2] mfd: axp20x: use correct platform device id for many PEK
Date: Mon, 17 Jul 2017 11:53:07 +0200
Message-ID: <20170717095307.15986-3-quentin.schulz@free-electrons.com>
References: <20170717095307.15986-1-quentin.schulz@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170717095307.15986-1-quentin.schulz@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, wens@csie.org, lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>, hdegoede@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, thomas.petazzoni@free-electrons.com, maxime.ripard@free-electrons.com
List-Id: linux-input@vger.kernel.org

According to their datasheets, the AXP221, AXP223, AXP288, AXP803,
AXP809 and AXP813 PEK have different values for startup time bits from
the AXP20X, let's use the platform device id with the correct values.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 drivers/mfd/axp20x.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index ec4271ca065c..336de66ca408 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -677,7 +677,7 @@ static struct mfd_cell axp20x_cells[] = {
 
 static struct mfd_cell axp221_cells[] = {
 	{
-		.name		= "axp20x-pek",
+		.name		= "axp221-pek",
 		.num_resources	= ARRAY_SIZE(axp22x_pek_resources),
 		.resources	= axp22x_pek_resources,
 	}, {
@@ -702,7 +702,7 @@ static struct mfd_cell axp221_cells[] = {
 
 static struct mfd_cell axp223_cells[] = {
 	{
-		.name			= "axp20x-pek",
+		.name			= "axp221-pek",
 		.num_resources		= ARRAY_SIZE(axp22x_pek_resources),
 		.resources		= axp22x_pek_resources,
 	}, {
@@ -835,7 +835,7 @@ static struct mfd_cell axp288_cells[] = {
 		.resources = axp288_fuel_gauge_resources,
 	},
 	{
-		.name = "axp20x-pek",
+		.name = "axp221-pek",
 		.num_resources = ARRAY_SIZE(axp288_power_button_resources),
 		.resources = axp288_power_button_resources,
 	},
@@ -846,7 +846,7 @@ static struct mfd_cell axp288_cells[] = {
 
 static struct mfd_cell axp803_cells[] = {
 	{
-		.name			= "axp20x-pek",
+		.name			= "axp221-pek",
 		.num_resources		= ARRAY_SIZE(axp803_pek_resources),
 		.resources		= axp803_pek_resources,
 	},
@@ -862,7 +862,7 @@ static struct mfd_cell axp806_cells[] = {
 
 static struct mfd_cell axp809_cells[] = {
 	{
-		.name			= "axp20x-pek",
+		.name			= "axp221-pek",
 		.num_resources		= ARRAY_SIZE(axp809_pek_resources),
 		.resources		= axp809_pek_resources,
 	}, {
@@ -873,7 +873,7 @@ static struct mfd_cell axp809_cells[] = {
 
 static struct mfd_cell axp813_cells[] = {
 	{
-		.name			= "axp20x-pek",
+		.name			= "axp221-pek",
 		.num_resources		= ARRAY_SIZE(axp803_pek_resources),
 		.resources		= axp803_pek_resources,
 	}
-- 
2.11.0
