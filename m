From: Zoltan Karcagi <zkr@freemail.hu>
Subject: [PATCH] HID: Fix dropped device-specific quirks
Date: Mon, 04 May 2009 18:57:55 +0200
Message-ID: <49FF1E93.7010704@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from viefep18-int.chello.at ([62.179.121.38]:62628 "EHLO
	viefep18-int.chello.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752320AbZEDRN0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 May 2009 13:13:26 -0400
Received: from edge02.upc.biz ([192.168.13.237]) by viefep16-int.chello.at
          (InterMail vM.7.09.01.00 201-2219-108-20080618) with ESMTP
          id <20090504165757.HKCT3549.viefep16-int.chello.at@edge02.upc.biz>
          for <linux-input@vger.kernel.org>; Mon, 4 May 2009 18:57:57 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

(Originally sent to linux-usb, description slightly rephrased.)

Please consider for merging. Without this patch, the device below does not work at all on kernel 2.6.28
and upwards.

Device-specific quirks are set up correctly in their respective vendor-specific driver, then
get overwritten in usbhid_parse().
Found on a Microsoft Wireless Optical Desktop 3.0 [045e:009d].

Signed-off-by: Zoltan Karcagi <zkr@freemail.hu>

diff -r -U 5 linux-2.6.30-rc4/drivers/hid/usbhid/hid-core.c linux-2.6.30-rc4-fixed/drivers/hid/usbhid/hid-core.c
--- linux-2.6.30-rc4/drivers/hid/usbhid/hid-core.c    2009-05-01 12:06:18.000000000 +0200
+++ linux-2.6.30-rc4-fixed/drivers/hid/usbhid/hid-core.c    2009-05-03 14:43:47.000000000 +0200
@@ -896,11 +896,11 @@
 if (ret) {
     dbg_hid("parsing report descriptor failed\n");
     goto err;
 }

-    hid->quirks = quirks;
+    hid->quirks |= quirks;

 return 0;
err:
 return ret;
}



