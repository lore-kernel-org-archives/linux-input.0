From: Peter Stein <peter@stuntstein.dk>
Subject: Re: [PATCH] Fix for out of range for THT 2p arcade controller
Date: Fri, 10 Feb 2017 10:38:59 -0800
Message-ID: <CAJRvzP-B1A2eUXT+5w0E7fA1kAV7HWxsX_Uu=-axBmxTsUaZTg@mail.gmail.com>
References: <CAJRvzP98MyLzm5OZgUm6zVWFFVtwr2fe42FxY8UMeAQwyARmcw@mail.gmail.com>
 <alpine.LSU.2.20.1702100304250.24579@cbobk.fhfr.pm>
Reply-To: peter@stuntstein.dk
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:36577 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751959AbdBJSsc (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 10 Feb 2017 13:48:32 -0500
Received: by mail-io0-f195.google.com with SMTP id q20so6573440ioi.3
        for <linux-input@vger.kernel.org>; Fri, 10 Feb 2017 10:47:33 -0800 (PST)
In-Reply-To: <alpine.LSU.2.20.1702100304250.24579@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org

Hi Jiri,

I am so sorry that I screw it up. I forgot to activate plain text in
gmail. I hope this time it is received in proper format.
BTW, some of the files that I have changes in, the indent is tabs
instead of spaces. Just so you know.


There is a new clone of the XIN MO arcade controller which has the
same issue with out of range like the original.
This fix will solve the issue where 2 directions on the joystick are
not recognized by the new THT 2P arcade controller with device ID
0x75e1.
In details the new device ID is added the hid-id list and the
hid-xinmo source code.

Signed-off-by: Peter Stein <peter@stuntstein.dk>

commit c16f015221d72f4ab11515a9b8bf0d3d14fbfd76
Author: Peter Stein <peter@stuntstein.dk>
Date:   Thu Feb 9 10:56:32 2017 -0800

    Fix for out of range for THT 2P arcade controller.

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 936960202cf4..24586876d43e 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2052,6 +2052,7 @@ static const struct hid_device_id
hid_have_special_driver[] = {
  { HID_USB_DEVICE(USB_VENDOR_ID_WALTOP,
USB_DEVICE_ID_WALTOP_SIRIUS_BATTERY_FREE_TABLET) },
  { HID_USB_DEVICE(USB_VENDOR_ID_X_TENSIONS,
USB_DEVICE_ID_SPEEDLINK_VAD_CEZANNE) },
  { HID_USB_DEVICE(USB_VENDOR_ID_XIN_MO, USB_DEVICE_ID_XIN_MO_DUAL_ARCADE) },
+ { HID_USB_DEVICE(USB_VENDOR_ID_XIN_MO, USB_DEVICE_ID_THT_2P_ARCADE) },
  { HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, 0x0005) },
  { HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, 0x0030) },
  { HID_USB_DEVICE(USB_VENDOR_ID_ZYDACRON,
USB_DEVICE_ID_ZYDACRON_REMOTE_CONTROL) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index e37030624165..5e985046b255 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1014,6 +1014,7 @@

 #define USB_VENDOR_ID_XIN_MO 0x16c0
 #define USB_DEVICE_ID_XIN_MO_DUAL_ARCADE 0x05e1
+#define USB_DEVICE_ID_THT_2P_ARCADE 0x75e1

 #define USB_VENDOR_ID_XIROKU 0x1477
 #define USB_DEVICE_ID_XIROKU_SPX 0x1006
diff --git a/drivers/hid/hid-xinmo.c b/drivers/hid/hid-xinmo.c
index 7df5227a7e61..9ad7731d2e10 100644
--- a/drivers/hid/hid-xinmo.c
+++ b/drivers/hid/hid-xinmo.c
@@ -46,6 +46,7 @@ static int xinmo_event(struct hid_device *hdev,
struct hid_field *field,

 static const struct hid_device_id xinmo_devices[] = {
  { HID_USB_DEVICE(USB_VENDOR_ID_XIN_MO, USB_DEVICE_ID_XIN_MO_DUAL_ARCADE) },
+ { HID_USB_DEVICE(USB_VENDOR_ID_XIN_MO, USB_DEVICE_ID_THT_2P_ARCADE) },
  { }
 };
