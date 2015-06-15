From: Dudley Du <dudl@cypress.com>
Subject: [PATCH v1 7/7] input: cyapa: add CYAP0002 Gen6 device for ACPI configuration
Date: Mon, 15 Jun 2015 17:01:37 +0800
Message-ID: <1434358897-24668-8-git-send-email-dudl@cypress.com>
References: <1434358897-24668-1-git-send-email-dudl@cypress.com>
Mime-Version: 1.0
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.cypress.com ([157.95.67.100]:53486 "EHLO
	smtp1.cypress.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754923AbbFOJJi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Jun 2015 05:09:38 -0400
In-Reply-To: <1434358897-24668-1-git-send-email-dudl@cypress.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org, rydberg@euromail.se
Cc: Dudley Du <dudl@cypress.com>, bleung@google.com, jmmahler@gmail.com, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Add CYTP0002 name for Gen6 device for ACPI configuration
TEST=test on Chromebook.

Signed-off-by: Dudley Du <dudl@cypress.com>
---
 drivers/input/mouse/cyapa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
index 7b6d6d4..7f674aa 100644
--- a/drivers/input/mouse/cyapa.c
+++ b/drivers/input/mouse/cyapa.c
@@ -1558,6 +1558,7 @@ MODULE_DEVICE_TABLE(i2c, cyapa_id_table);
 static const struct acpi_device_id cyapa_acpi_id[] = {
 	{ "CYAP0000", 0 },  /* Gen3 trackpad with 0x67 I2C address. */
 	{ "CYAP0001", 0 },  /* Gen5 trackpad with 0x24 I2C address. */
+	{ "CYAP0002", 0 },  /* Gen6 trackpad with 0x24 I2C address. */
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, cyapa_acpi_id);
-- 
1.9.1


---------------------------------------------------------------
This message and any attachments may contain Cypress (or its
subsidiaries) confidential information. If it has been received
in error, please advise the sender and immediately delete this
message.
---------------------------------------------------------------

