From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH resend] Input: silead - add Chuwi Hi8 support
Date: Tue, 13 Feb 2018 16:42:38 +0100
Message-ID: <20180213154238.19181-2-hdegoede@redhat.com>
References: <20180213154238.19181-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50216 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933672AbeBMPmn (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 13 Feb 2018 10:42:43 -0500
In-Reply-To: <20180213154238.19181-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, Maruyama Shohei <cheat.sc.linux@outlook.com>

From: Maruyama Shohei <cheat.sc.linux@outlook.com>

This commit add ACPI support for Chuwi Hi8 tablet. On the ACPI table of
the tablet, GSL1680 is registered as MSSL0001, so the driver does not
recognize the device. This commit resolve it.

Signed-off-by: Shohei Maruyama <cheat.sc.linux@outlook.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/touchscreen/silead.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
index 646b1e768e6b..ff7043f74a3d 100644
--- a/drivers/input/touchscreen/silead.c
+++ b/drivers/input/touchscreen/silead.c
@@ -602,6 +602,7 @@ static const struct acpi_device_id silead_ts_acpi_match[] = {
 	{ "GSL3675", 0 },
 	{ "GSL3692", 0 },
 	{ "MSSL1680", 0 },
+	{ "MSSL0001", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, silead_ts_acpi_match);
-- 
2.14.3

