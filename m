From: duson <dusonlin@emc.com.tw>
Subject: [PATCH] Input: elan_i2c - Add ic type 0x03
Date: Mon, 21 Sep 2015 10:14:13 +0800
Message-ID: <6BDEAA47-E505-451C-B2C3-F82099D24737@emc.com.tw>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The 0x03 is valid 3000 serial ic type too.

Signed-off-by: Duson Lin <dusonlin@emc.com.tw>
---
 drivers/input/mouse/elan_i2c_core.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index fa94530..16ac595 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -102,6 +102,7 @@ static int elan_get_fwinfo(u8 iap_version, u16 *validpage_count,
 		*validpage_count = 512;
 		break;
 	case 0x09:
+	case 0x03:
 		*validpage_count = 768;
 		break;
 	case 0x0D:
-- 
1.7.9.5
