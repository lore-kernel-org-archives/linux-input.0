From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/3] input: axp20x-pek: Only check for "INTCFD9" ACPI device on Cherry Trail
Date: Mon, 17 Apr 2017 22:13:30 +0200
Message-ID: <20170417201332.13983-2-hdegoede@redhat.com>
References: <20170417201332.13983-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42628 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752462AbdDQUNg (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 17 Apr 2017 16:13:36 -0400
In-Reply-To: <20170417201332.13983-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

Commit 9b13a4ca8d2c ("Input: axp20x-pek - do not register input device
on some systems") added a check for the INTCFD9 ACPI device which also
handles the powerbutton as on some systems the powerbutton is connected
to both the PMIC, handled by axp20x-pek, and to a gpio on the SoC, handled
by soc_button_array which attaches itself to the INTCFD9 ACPI device.

Testing + comparing DSDTs has shown that this only happens on Cherry
Trail devices with an AXP288 PMIC, the AXP288 PMIC is also used on
Bay Trail devices but there the power button is only connected to
the PMIC and not handled by soc_button_array.

This means that the INTCFD9 check has caused a regression on Bay Trail
devices, causing power-button presses to no longer be seen.

This commit fixes this by limiting the check to devices where the ACPI
node for the AXP288 contains a _HRV (hardware revision) attribute with
a value of 3 which indicates we are dealing with a Cherry Trail platform.

Fixes: 9b13a4ca8d2c ("Input: axp20x-pek - do not register input ...")
Reported-by: Сергей Трусов <t.rus76@ya.ru>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/misc/axp20x-pek.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
index dbd2c89..5382e09 100644
--- a/drivers/input/misc/axp20x-pek.c
+++ b/drivers/input/misc/axp20x-pek.c
@@ -259,6 +259,11 @@ static int axp20x_pek_probe_input_device(struct axp20x_pek *axp20x_pek,
 static int axp20x_pek_probe(struct platform_device *pdev)
 {
 	struct axp20x_pek *axp20x_pek;
+	bool register_input_device = true;
+#ifdef CONFIG_ACPI
+	unsigned long long hrv = 0;
+	acpi_status status;
+#endif
 	int error;
 
 	axp20x_pek = devm_kzalloc(&pdev->dev, sizeof(struct axp20x_pek),
@@ -268,12 +273,25 @@ static int axp20x_pek_probe(struct platform_device *pdev)
 
 	axp20x_pek->axp20x = dev_get_drvdata(pdev->dev.parent);
 
-	/*
-	 * Do not register the input device if there is an "INTCFD9"
-	 * gpio button ACPI device, that handles the power button too,
-	 * and otherwise we end up reporting all presses twice.
-	 */
-	if (!acpi_dev_found("INTCFD9")) {
+#ifdef CONFIG_ACPI
+	if (axp20x_pek->axp20x->variant == AXP288_ID) {
+		status = acpi_evaluate_integer(ACPI_HANDLE(pdev->dev.parent),
+					       "_HRV", NULL, &hrv);
+		if (ACPI_FAILURE(status))
+			dev_err(&pdev->dev, "Failed to get PMIC hardware revision\n");
+
+		/*
+		 * On Cherry Trail platforms (hrv == 3), do not register the
+		 * input device if there is an "INTCFD9" gpio
+		 * button ACPI device, as that handles the power button too,
+		 * and otherwise we end up reporting all presses twice.
+		 */
+		if (hrv == 3 && acpi_dev_found("INTCFD9"))
+			register_input_device = false;
+	}
+#endif
+
+	if (register_input_device) {
 		error = axp20x_pek_probe_input_device(axp20x_pek, pdev);
 		if (error)
 			return error;
-- 
2.9.3

