From: Daniel Nicoletti <dantti12@gmail.com>
Subject: Re: PATCH change for HID_BATTERY_STRENGTH kconfig
Date: Mon, 23 Jun 2014 16:08:23 -0300
Message-ID: <CACo8zOcm3B7WdQpHA3J2ZtP6AWUrtAo_L63mpYJR0w13jNwLpQ@mail.gmail.com>
References: <CACo8zOfAf3cUNh4MZcQvYByiu=D5S1aA4qiH_HFuvz5GYMJF7g@mail.gmail.com>
	<alpine.LNX.2.00.1305240016180.13213@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:51804 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952AbaFWTI0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Jun 2014 15:08:26 -0400
Received: by mail-wg0-f52.google.com with SMTP id b13so6783736wgh.11
        for <linux-input@vger.kernel.org>; Mon, 23 Jun 2014 12:08:23 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1305240016180.13213@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

2013-05-23 19:16 GMT-03:00 Jiri Kosina <jkosina@suse.cz>:
> On Mon, 13 May 2013, Daniel Nicoletti wrote:
>
>> Hi,
>> I'd like to propose this patch while removes the need for
>> hid to be compiled build-in, as this is the same behavior
>> that WiiMote and Wacom have.
>> Is this ok?
>
> Makes sense to me. Could you please resend with proper changelog and
> Signed-off-by: line?
>
> Thanks.

Sorry it took more than a year for me to do this,
so I called git send-email, and so far the CC and
linux-input didn't get it, tho it said result OK.
git send-email --to "Jiri Kosina <jkosina@suse.cz>" --cc
"linux-input@vger.kernel.org"
0001-HID-Allows-for-HID_BATTERY_STRENGTH-config-be-enable.patch

I'm pasting it here hoping gmail doesn't screw
it, if you prefer that I send it using the above
command mind you telling what I did wrong?

Thanks.

>From df740fd81dffbb74e13c622392fe9a945006fd3c Mon Sep 17 00:00:00 2001
From: Daniel Nicoletti <dantti12@gmail.com>
Date: Mon, 23 Jun 2014 10:31:47 -0300
Subject: [PATCH] HID: Allows for HID_BATTERY_STRENGTH config be enabled
 without the need for HID module to be built-in.

Signed-off-by: Daniel Nicoletti <dantti12@gmail.com>
---
 drivers/hid/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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
-- 
2.0.0
