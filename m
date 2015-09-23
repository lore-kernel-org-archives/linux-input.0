From: duson <dusonlin@emc.com.tw>
Subject: [PATCH] Input: elan_i2c - Add all valid ic type for i2c/smbus
Date: Wed, 23 Sep 2015 09:26:23 +0800
Message-ID: <A8DECB9C-843A-41B1-A3DF-965C7593ACB9@emc.com.tw>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:39971 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366AbbIWB0Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Sep 2015 21:26:25 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Signed-of-by: Duson Lin <dusonlin@emc.com.tw>
---
 drivers/input/mouse/elan_i2c_core.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 16ac595..357670e 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -98,16 +98,25 @@ static int elan_get_fwinfo(u8 iap_version, u16 *validpage_count,
 			   u16 *signature_address)
 {
 	switch (iap_version) {
+	case 0x00:
+	case 0x06:
 	case 0x08:
 		*validpage_count = 512;
 		break;
-	case 0x09:
 	case 0x03:
+	case 0x07:
+	case 0x09:
+	case 0x0A:
+	case 0x0B:
+	case 0x0C:
 		*validpage_count = 768;
 		break;
 	case 0x0D:
 		*validpage_count = 896;
 		break;
+	case 0x0E:
+		*validpage_count = 640;
+		break;
 	default:
 		/* unknown ic type clear value */
 		*validpage_count = 0;
-- 
1.7.9.5


