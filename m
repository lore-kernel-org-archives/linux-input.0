From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/3] input: axp20x-pek: Check for ACPI0011 gpio button device too
Date: Mon, 17 Apr 2017 22:13:31 +0200
Message-ID: <20170417201332.13983-3-hdegoede@redhat.com>
References: <20170417201332.13983-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50880 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752462AbdDQUNh (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 17 Apr 2017 16:13:37 -0400
In-Reply-To: <20170417201332.13983-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

The ACPI-6.0 standard defines a standard gpio button device using
the ACPI0011 HID replacing the custom PNP0C40 gpio device used on
many devices with an AXP288 pmic. All DSDTs I've seen for Cherry
Trail devices with an AXP288 pmic define both a PNP0C40 and an
ACPI0011 ACPI device, enabling one or the other depending on whether
the BIOS thinks it is going to boot Android or Windows.

But in the future we may see some Windows only devices only defining
the ACPI0011 device, so lets check for both.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/misc/axp20x-pek.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
index 5382e09..be50a7f 100644
--- a/drivers/input/misc/axp20x-pek.c
+++ b/drivers/input/misc/axp20x-pek.c
@@ -282,11 +282,12 @@ static int axp20x_pek_probe(struct platform_device *pdev)
 
 		/*
 		 * On Cherry Trail platforms (hrv == 3), do not register the
-		 * input device if there is an "INTCFD9" gpio
+		 * input device if there is an "INTCFD9" or "ACPI0011" gpio
 		 * button ACPI device, as that handles the power button too,
 		 * and otherwise we end up reporting all presses twice.
 		 */
-		if (hrv == 3 && acpi_dev_found("INTCFD9"))
+		if (hrv == 3 && (acpi_dev_found("INTCFD9") ||
+				 acpi_dev_found("ACPI0011")))
 			register_input_device = false;
 	}
 #endif
-- 
2.9.3

