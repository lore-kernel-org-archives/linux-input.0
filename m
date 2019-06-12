From: Christian Oder <me@myself5.de>
Subject: [PATCH] platform/x86: touchscreen_dmi: Update Hi10 Air filter
Date: Wed, 12 Jun 2019 14:40:53 +0200
Message-ID: <20190612124053.119182-1-me@myself5.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Christian Oder <me@myself5.de>, Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Turns out the Hi10 Air is built by multiple companies so using Hampoo
as a filter is not enough to cover all variants.

This has been verified as working on the Hampoo and Morshow version.

Signed-off-by: Christian Oder <me@myself5.de>
---
 drivers/platform/x86/touchscreen_dmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index b662cb2d7cd5..61e7c4987d0d 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -597,7 +597,8 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
 		/* Chuwi Hi10 Air */
 		.driver_data = (void *)&chuwi_hi10_air_data,
 		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "Hampoo"),
+			DMI_MATCH(DMI_SYS_VENDOR, "CHUWI INNOVATION AND TECHNOLOGY(SHENZHEN)CO.LTD"),
+			DMI_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
 			DMI_MATCH(DMI_PRODUCT_SKU, "P1W6_C109D_B"),
 		},
 	},
-- 
2.21.0
