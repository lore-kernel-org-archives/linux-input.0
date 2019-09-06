From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] Input - elan_i2c: remove Lenovo Legion Y7000 PnpID
Date: Fri,  6 Sep 2019 10:59:48 +0200
Message-ID: <20190906085948.27470-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

Looks like the Bios of the Lenovo Legion Y7000 is using ELAN061B
when the actual device is supposed to be used with hid-multitouch.

Remove it from the list of the supported device, hoping that
no one will complain about the loss in functionality.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=203467
Fixes: Fixes: 738c06d0e456 ("Input: elan_i2c - add hardware ID for multiple Lenovo laptops")
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

Note to self: once this gets in, we need to send a similar patch
to stable, as there are a few stable branches with this PnpID.


 include/linux/input/elan-i2c-ids.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/input/elan-i2c-ids.h b/include/linux/input/elan-i2c-ids.h
index ceabb01a6a7d..1ecb6b45812c 100644
--- a/include/linux/input/elan-i2c-ids.h
+++ b/include/linux/input/elan-i2c-ids.h
@@ -48,7 +48,7 @@ static const struct acpi_device_id elan_acpi_id[] = {
 	{ "ELAN0618", 0 },
 	{ "ELAN0619", 0 },
 	{ "ELAN061A", 0 },
-	{ "ELAN061B", 0 },
+/*	{ "ELAN061B", 0 }, not working on the Lenovo Legion Y7000 */
 	{ "ELAN061C", 0 },
 	{ "ELAN061D", 0 },
 	{ "ELAN061E", 0 },
-- 
2.21.0
