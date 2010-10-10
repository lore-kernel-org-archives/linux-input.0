From: =?ISO-8859-1?Q?fran=E7ois?= Jaouen <francois.jaouen@laposte.net>
Subject: Re: [PATCH] Add Cando touch screen 15.6-inch product id with
 Signed-off-by
Date: Sun, 10 Oct 2010 10:06:39 +0200
Message-ID: <1286697999.1643.4.camel@francois-laptop>
References: <1286642783.5459.36.camel@francois-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-7"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp2b.orange.fr ([80.12.242.145]:15099 "EHLO smtp2b.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751921Ab0JJIGp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Oct 2010 04:06:45 -0400
In-Reply-To: <1286642783.5459.36.camel@francois-laptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz

This add the product id of the touch screen found on ACER Aspire 5738PZ. 
Works with hid-cando driver.
Added Signed-off-by tag.

Signed-off-by: Francois Jaouen +ADw-francois.jaouen+AEA-laposte.net+AD4

---
 drivers/hid/hid-cando.c +AHw    2 +-+-
 drivers/hid/hid-core.c  +AHw    1 +-
 drivers/hid/hid-ids.h   +AHw    3 +-+--
 3 files changed, 5 insertions(+-), 1 deletions(-)

diff --git a/drivers/hid/hid-cando.c b/drivers/hid/hid-cando.c
index 4267a6f..ab231cd 100644
--- a/drivers/hid/hid-cando.c
+-+-+- b/drivers/hid/hid-cando.c
+AEAAQA -237,6 +-237,8 +AEAAQA static const struct hid+AF8-device+AF8-id cando+AF8-devices+AFsAXQ +AD0
+AHs
 			USB+AF8-DEVICE+AF8-ID+AF8-CANDO+AF8-MULTI+AF8-TOUCH) +AH0,
 	+AHs HID+AF8-USB+AF8-DEVICE(USB+AF8-VENDOR+AF8-ID+AF8-CANDO,
 			USB+AF8-DEVICE+AF8-ID+AF8-CANDO+AF8-MULTI+AF8-TOUCH+AF8-11+AF8-6) +AH0,
+-	+AHs HID+AF8-USB+AF8-DEVICE(USB+AF8-VENDOR+AF8-ID+AF8-CANDO,
+-			USB+AF8-DEVICE+AF8-ID+AF8-CANDO+AF8-MULTI+AF8-TOUCH+AF8-15+AF8-6) +AH0,
 	+AHs +AH0
 +AH0AOw
 MODULE+AF8-DEVICE+AF8-TABLE(hid, cando+AF8-devices)+ADs
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 3f72924..a0dea3d 100644
--- a/drivers/hid/hid-core.c
+-+-+- b/drivers/hid/hid-core.c
+AEAAQA -1292,6 +-1292,7 +AEAAQA static const struct hid+AF8-device+AF8-id hid+AF8-blacklist+AFsAXQ
+AD0 +AHs
 	+AHs HID+AF8-USB+AF8-DEVICE(USB+AF8-VENDOR+AF8-ID+AF8-BTC,
USB+AF8-DEVICE+AF8-ID+AF8-BTC+AF8-EMPREX+AF8-REMOTE+AF8-2) +AH0,
 	+AHs HID+AF8-USB+AF8-DEVICE(USB+AF8-VENDOR+AF8-ID+AF8-CANDO,
USB+AF8-DEVICE+AF8-ID+AF8-CANDO+AF8-MULTI+AF8-TOUCH) +AH0,
 	+AHs HID+AF8-USB+AF8-DEVICE(USB+AF8-VENDOR+AF8-ID+AF8-CANDO,
USB+AF8-DEVICE+AF8-ID+AF8-CANDO+AF8-MULTI+AF8-TOUCH+AF8-11+AF8-6) +AH0,
+-	+AHs HID+AF8-USB+AF8-DEVICE(USB+AF8-VENDOR+AF8-ID+AF8-CANDO,
USB+AF8-DEVICE+AF8-ID+AF8-CANDO+AF8-MULTI+AF8-TOUCH+AF8-15+AF8-6) +AH0,
 	+AHs HID+AF8-USB+AF8-DEVICE(USB+AF8-VENDOR+AF8-ID+AF8-CHERRY,
USB+AF8-DEVICE+AF8-ID+AF8-CHERRY+AF8-CYMOTION) +AH0,
 	+AHs HID+AF8-USB+AF8-DEVICE(USB+AF8-VENDOR+AF8-ID+AF8-CHERRY,
USB+AF8-DEVICE+AF8-ID+AF8-CHERRY+AF8-CYMOTION+AF8-SOLAR) +AH0,
 	+AHs HID+AF8-USB+AF8-DEVICE(USB+AF8-VENDOR+AF8-ID+AF8-CHICONY,
USB+AF8-DEVICE+AF8-ID+AF8-CHICONY+AF8-TACTICAL+AF8-PAD) +AH0,
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 765a4f5..3d46d9f 100644
--- a/drivers/hid/hid-ids.h
+-+-+- b/drivers/hid/hid-ids.h
+AEAAQA -133,7 +-133,8 +AEAAQA
 
 +ACM-define USB+AF8-VENDOR+AF8-ID+AF8-CANDO		0x2087
 +ACM-define USB+AF8-DEVICE+AF8-ID+AF8-CANDO+AF8-MULTI+AF8-TOUCH	0x0a01
-+ACM-define USB+AF8-DEVICE+AF8-ID+AF8-CANDO+AF8-MULTI+AF8-TOUCH+AF8-11+AF8-6 0x0b03
+-+ACM-define USB+AF8-DEVICE+AF8-ID+AF8-CANDO+AF8-MULTI+AF8-TOUCH+AF8-11+AF8-6	0x0b03
+-+ACM-define USB+AF8-DEVICE+AF8-ID+AF8-CANDO+AF8-MULTI+AF8-TOUCH+AF8-15+AF8-6	0x0f01
 
 +ACM-define USB+AF8-VENDOR+AF8-ID+AF8-CH		0x068e
 +ACM-define USB+AF8-DEVICE+AF8-ID+AF8-CH+AF8-PRO+AF8-PEDALS	0x00f2
-- 
1.7.0.4






