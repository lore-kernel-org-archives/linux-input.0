From: Chris Schlund <chrisschlund@gmx.de>
Subject: Re: Re: [PATCH] hid kernel module for wireless remote LC Power model
 RC1000MCE
Date: Mon, 07 Feb 2011 17:53:10 +0100
Message-ID: <4D502376.5040505@gmx.de>
References: <4D4019EC.8060301@gmx.de> <alpine.LNX.2.00.1102031642260.2160@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:35596 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752745Ab1BGQxN (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Feb 2011 11:53:13 -0500
In-Reply-To: <alpine.LNX.2.00.1102031642260.2160@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

Hi Jiri,

I already got some feedback for this module, telling me red and blue keys are exchanged.
I checked it, and they are right. Due to my incorrect userspace settings I missed this during my testing.
So here is the fixed mapping.
I am sorry for the inconvenience.

Thanks, Chris


Signed-off-by: Chris Schlund <chrisschlund@gmx.de>
---

diff -urN linux-2.6.37/drivers/hid/hid-lcpower.c linux/drivers/hid/hid-lcpower.c
--- linux-2.6.37/drivers/hid/hid-lcpower.c      2011-02-07 17:31:49.000000000 +0100
+++ linux/drivers/hid/hid-lcpower.c     2011-02-07 17:32:50.000000000 +0100
@@ -30,8 +30,8 @@
        switch (usage->hid & HID_USAGE) {
        case 0x046: ts_map_key_clear(KEY_YELLOW);         break;
        case 0x047: ts_map_key_clear(KEY_GREEN);          break;
-        case 0x049: ts_map_key_clear(KEY_RED);            break;
-        case 0x04a: ts_map_key_clear(KEY_BLUE);           break;
+        case 0x04a: ts_map_key_clear(KEY_RED);            break;
+        case 0x049: ts_map_key_clear(KEY_BLUE);           break;
        case 0x00d: ts_map_key_clear(KEY_HOME);           break;
        case 0x025: ts_map_key_clear(KEY_TV);             break;
        case 0x048: ts_map_key_clear(KEY_VCR);            break;
