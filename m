From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 3/8] Input: tm2-touchkey: Use predefined device name
Date: Fri,  7 Dec 2018 11:58:06 +0100
Message-ID: <20181207105811.1831-4-pawel.mikolaj.chmiel@gmail.com>
References: <20181207105811.1831-1-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181207105811.1831-1-pawel.mikolaj.chmiel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, pawel.mikolaj.chmiel@gmail.com, xc-racer2@live.ca, simon@lineageos.org
List-Id: linux-input@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

Purely a cosmetic fix, using the names defined earlier

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/input/keyboard/tm2-touchkey.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/tm2-touchkey.c b/drivers/input/keyboard/tm2-touchkey.c
index 37a5ced24009..cc713b901bf2 100644
--- a/drivers/input/keyboard/tm2-touchkey.c
+++ b/drivers/input/keyboard/tm2-touchkey.c
@@ -57,13 +57,13 @@ struct tm2_touchkey_data {
 };
 
 static struct touchkey_variant tm2_touchkey_variant = {
-	.name = "tm2-touchkey",
+	.name = TM2_TOUCHKEY_DEV_NAME,
 	.keycode_reg = 0x03,
 	.base_reg = 0x00,
 };
 
 static struct touchkey_variant midas_touchkey_variant = {
-	.name = "midas-touchkey",
+	.name = MIDAS_TOUCHKEY_DEV_NAME,
 	.keycode_reg = 0x00,
 	.base_reg = 0x00,
 };
-- 
2.17.1
