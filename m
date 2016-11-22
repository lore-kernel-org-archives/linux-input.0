From: =?UTF-8?B?SsOpcsOpbXkgTGFs?= <kapouer@melix.org>
Subject: Re: hig_magicmouse HID_BATTERY_QUIRK_IGNORE
Date: Wed, 23 Nov 2016 00:00:40 +0100
Message-ID: <CAJxTCxxN7=fjNFQ4BJPKfU0jHY=uAQNq_g3iN_0mYhSHdc28ug@mail.gmail.com>
References: <CAJxTCxxMvwdrLZnsMsOG4vLDNbYmtdGgAXLofUMLvPvoepTk7Q@mail.gmail.com>
 <1E169F84-8B4E-4E63-B9BD-213FBBC1B36E@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.polytechnique.org ([129.104.30.34]:34656 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755611AbcKVXIn (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 22 Nov 2016 18:08:43 -0500
Received: from mail-io0-f177.google.com (mail-io0-f177.google.com [209.85.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 5720B5647CB
        for <linux-input@vger.kernel.org>; Wed, 23 Nov 2016 00:00:44 +0100 (CET)
Received: by mail-io0-f177.google.com with SMTP id c21so86244785ioj.1
        for <linux-input@vger.kernel.org>; Tue, 22 Nov 2016 15:00:44 -0800 (PST)
In-Reply-To: <1E169F84-8B4E-4E63-B9BD-213FBBC1B36E@holtmann.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,
i've been using this patch for a while, as a workaround for
https://bugzilla.kernel.org/show_bug.cgi?id=103631
(mouse freeze when battery reports).

--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -321,6 +321,9 @@
 { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
   USB_DEVICE_ID_APPLE_ALU_WIRELESS_ANSI),
   HID_BATTERY_QUIRK_PERCENT | HID_BATTERY_QUIRK_FEATURE },
+  { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
+    USB_DEVICE_ID_APPLE_MAGICMOUSE),
+    HID_BATTERY_QUIRK_IGNORE },
 { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM,
   USB_DEVICE_ID_ELECOM_BM084),
   HID_BATTERY_QUIRK_IGNORE },


Greetings,
Jérémy

