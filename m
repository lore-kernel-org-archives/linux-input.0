From: Danct12 <danct12@disroot.org>
Subject: [PATCH] input: silead: Add MSSL0017 to acpi_device_id.
Date: Wed, 22 May 2019 11:54:55 +0700
Message-ID: <20190522045455.15769-1-danct12@disroot.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: hdegoede@redhat.com
Cc: Danct12 <danct12@disroot.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Chuwi Hi10 Plus, the Silead device id is MSSL0017.

Signed-off-by: Danct12 <danct12@disroot.org>
---
 drivers/input/touchscreen/silead.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
index 09241d4cdebc..06f0eb04a8fd 100644
--- a/drivers/input/touchscreen/silead.c
+++ b/drivers/input/touchscreen/silead.c
@@ -617,6 +617,7 @@ static const struct acpi_device_id silead_ts_acpi_match[] = {
 	{ "MSSL1680", 0 },
 	{ "MSSL0001", 0 },
 	{ "MSSL0002", 0 },
+	{ "MSSL0017", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, silead_ts_acpi_match);
-- 
2.21.0
