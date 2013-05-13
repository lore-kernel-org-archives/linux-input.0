From: Daniel Nicoletti <dantti12@gmail.com>
Subject: PATCH change for HID_BATTERY_STRENGTH kconfig
Date: Mon, 13 May 2013 18:43:46 -0300
Message-ID: <CACo8zOfAf3cUNh4MZcQvYByiu=D5S1aA4qiH_HFuvz5GYMJF7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:33929 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753966Ab3EMVnr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 May 2013 17:43:47 -0400
Received: by mail-wi0-f169.google.com with SMTP id hn14so1128799wib.0
        for <linux-input@vger.kernel.org>; Mon, 13 May 2013 14:43:46 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

Hi,
I'd like to propose this patch while removes the need for
hid to be compiled build-in, as this is the same behavior
that WiiMote and Wacom have.
Is this ok?

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index fb52f3f..d6d85ad 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -27,7 +27,8 @@ if HID

 config HID_BATTERY_STRENGTH
        bool "Battery level reporting for HID devices"
-       depends on HID && POWER_SUPPLY && HID = POWER_SUPPLY
+       depends on HID
+       select POWER_SUPPLY
        default n
        ---help---
        This option adds support of reporting battery strength (for HID devices
