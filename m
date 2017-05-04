From: =?utf-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>
Subject: RE: ASUS G752VS Touchpad does not work
Date: Thu, 4 May 2017 17:47:15 +0800
Message-ID: <005e01d2c4bb$6961c7f0$3c2557d0$@emc.com.tw>
References: <CAAd53p57p7nj2AEoUK-wrEETZEsQweVAmhXMGqEM6JbZtbXAZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:55345 "EHLO
        emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751897AbdEDJ4k (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 4 May 2017 05:56:40 -0400
In-Reply-To: <CAAd53p57p7nj2AEoUK-wrEETZEsQweVAmhXMGqEM6JbZtbXAZQ@mail.gmail.com>
Content-Language: zh-tw
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Kai-Heng Feng' <kai.heng.feng@canonical.com>
Cc: linux-input@vger.kernel.org

Hi Kai-Heng

-----Original Message-----
From: Kai-Heng Feng [mailto:kai.heng.feng@canonical.com] 
Sent: Thursday, May 04, 2017 3:59 PM
To: kt.liao@emc.com.tw; dusonlin@emc.com.tw
Cc: linux-input@vger.kernel.org
Subject: ASUS G752VS Touchpad does not work

Hi KT Liao, Duson Lin,

A user reported that the touchpad on ASUS G752VS does not work [1], it's an ELAN touchapd.

I did the following change, the touchpad correctly loads elan-i2c instead of hid-multitouch, but it's still not working.

[KT] I check the touchpad of this model, it's MS precision touchpad.
It must use "hid-multitouch", not "elan-i2c".



Thanks.

[1] https://bugs.launchpad.net/bugs/1653456

--

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c index da62a7695e77..acddb407e766 100644
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
        { HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC4UM) }, diff --git a/drivers/input/mouse/elan_i2c_core.c
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

