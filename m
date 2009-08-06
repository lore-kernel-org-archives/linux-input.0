From: akpm@linux-foundation.org
Subject: [patch 1/3] hid: fix read buffer overflow
Date: Thu, 06 Aug 2009 16:03:16 -0700
Message-ID: <200908062303.n76N3GP7000930@imap1.linux-foundation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47652 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752978AbZHFXDV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 6 Aug 2009 19:03:21 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org, roel.kluin@gmail.com

From: Roel Kluin <roel.kluin@gmail.com>

Check whether index is within bounds before testing the element.

declared in drivers/hid/usbhid/hid-core.c:62:
static char *quirks_param[MAX_USBHID_BOOT_QUIRKS] = ...

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/hid/usbhid/hid-quirks.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/hid/usbhid/hid-quirks.c~hid-fix-read-buffer-overflow drivers/hid/usbhid/hid-quirks.c
--- a/drivers/hid/usbhid/hid-quirks.c~hid-fix-read-buffer-overflow
+++ a/drivers/hid/usbhid/hid-quirks.c
@@ -201,7 +201,7 @@ int usbhid_quirks_init(char **quirks_par
 	u32 quirks;
 	int n = 0, m;
 
-	for (; quirks_param[n] && n < MAX_USBHID_BOOT_QUIRKS; n++) {
+	for (; n < MAX_USBHID_BOOT_QUIRKS && quirks_param[n]; n++) {
 
 		m = sscanf(quirks_param[n], "0x%hx:0x%hx:0x%x",
 				&idVendor, &idProduct, &quirks);
_
