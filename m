From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Subject: acer-wmi: Initialize wlan/bluetooth/wwan rfkill software block state
Date: Mon, 13 Dec 2010 10:02:41 +0800
Message-ID: <1292205761-13001-1-git-send-email-jlee@novell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:47321 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756189Ab0LMCEk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 12 Dec 2010 21:04:40 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: platform-driver-x86@vger.kernel.org
Cc: mjg59@srcf.ucam.org, dmitry.torokhov@gmail.com, corentin.chary@gmail.com, corentincj@iksaif.net, tiwai@novell.com, carlos@strangeworlds.co.uk, jbenc@suse.cz, jdelvare@suse.de, trenn@suse.de, linux-input@vger.kernel.org, "Lee, Chun-Yi" <jlee@novell.com>

Initial wlan/bluetooth/wwan rfkill software block state when acer-wmi driver
probe. Acer notebook can save the devices state and this patch can use it to
initial the devices' rfkill state.

Signed-off-by: Lee, Chun-Yi <jlee@novell.com>
Acked-by: Thomas Renninger <trenn@suse.de>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>
---
 drivers/platform/x86/acer-wmi.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index dc23140..52426ca 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -1102,6 +1102,31 @@ static acpi_status wmid3_get_device_status(u32 *value, u16 device)
 	return status;
 }
 
+static acpi_status get_device_status(u32 *value, u32 cap)
+{
+	if (wmi_has_guid(WMID_GUID3)) {
+		u16 device;
+
+		switch (cap) {
+		case ACER_CAP_WIRELESS:
+			device = ACER_WMID3_GDS_WIRELESS;
+			break;
+		case ACER_CAP_BLUETOOTH:
+			device = ACER_WMID3_GDS_BLUETOOTH;
+			break;
+		case ACER_CAP_THREEG:
+			device = ACER_WMID3_GDS_THREEG;
+			break;
+		default:
+			return AE_ERROR;
+		}
+		return wmid3_get_device_status(value, device);
+
+	} else {
+		return get_u32(value, cap);
+	}
+}
+
 /*
  * Rfkill devices
  */
@@ -1152,6 +1177,8 @@ static struct rfkill *acer_rfkill_register(struct device *dev,
 {
 	int err;
 	struct rfkill *rfkill_dev;
+	u32 state;
+	acpi_status status;
 
 	rfkill_dev = rfkill_alloc(name, dev, type,
 				  &acer_rfkill_ops,
@@ -1159,6 +1186,10 @@ static struct rfkill *acer_rfkill_register(struct device *dev,
 	if (!rfkill_dev)
 		return ERR_PTR(-ENOMEM);
 
+	status = get_device_status(&state, cap);
+	if (ACPI_SUCCESS(status))
+		rfkill_init_sw_state(rfkill_dev, !state);
+
 	err = rfkill_register(rfkill_dev);
 	if (err) {
 		rfkill_destroy(rfkill_dev);
-- 
1.6.0.2

