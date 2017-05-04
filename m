From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: ASUS G752VS Touchpad does not work
Date: Thu, 4 May 2017 15:58:49 +0800
Message-ID: <CAAd53p57p7nj2AEoUK-wrEETZEsQweVAmhXMGqEM6JbZtbXAZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38456 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751721AbdEDH6v (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 4 May 2017 03:58:51 -0400
Received: by mail-wm0-f46.google.com with SMTP id 142so2338243wma.1
        for <linux-input@vger.kernel.org>; Thu, 04 May 2017 00:58:51 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: kt.liao@emc.com.tw, dusonlin@emc.com.tw
Cc: linux-input@vger.kernel.org

Hi KT Liao, Duson Lin,

A user reported that the touchpad on ASUS G752VS does not work [1],
it's an ELAN touchapd.

I did the following change, the touchpad correctly loads elan-i2c
instead of hid-multitouch, but it's still not working.

Thanks.

[1] https://bugs.launchpad.net/bugs/1653456

--

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index da62a7695e77..acddb407e766 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2377,6 +2377,7 @@ static const struct hid_device_id hid_ignore_list[] = {
        { HID_USB_DEVICE(USB_VENDOR_ID_DELORME,
USB_DEVICE_ID_DELORME_EM_LT20) },
        { HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, 0x0400) },
        { HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, 0x0401) },
+       { HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, 0x3043) },
        { HID_USB_DEVICE(USB_VENDOR_ID_ESSENTIAL_REALITY,
USB_DEVICE_ID_ESSENTIAL_REALITY_P5) },
        { HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC5UH) },
        { HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC4UM) },
diff --git a/drivers/input/mouse/elan_i2c_core.c
b/drivers/input/mouse/elan_i2c_core.c
index a26f44c28d82..bf661ce5dccc 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1235,6 +1238,7 @@ static const struct acpi_device_id elan_acpi_id[] = {
        { "ELAN0600", 0 },
        { "ELAN0605", 0 },
        { "ELAN1000", 0 },
+       { "ELAN1203", 0 },
        { }
 };
 MODULE_DEVICE_TABLE(acpi, elan_acpi_id);
