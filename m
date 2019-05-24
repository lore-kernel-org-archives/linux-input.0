From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 8/8] Input: elantech: remove P52 and P72 from SMBus blacklist
Date: Fri, 24 May 2019 15:50:46 +0200
Message-ID: <20190524135046.17710-9-benjamin.tissoires@redhat.com>
References: <20190524135046.17710-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190524135046.17710-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, KT Liao <kt.liao@emc.com.tw>, Rob Herring <robh+dt@kernel.org>, Aaron Ma <aaron.ma@canonical.com>, Hans de Goede <hdegoede@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

Both now works correctly over SMBus. Let's use this driver so we can
update all five fingers every 8ms.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

--

changes in v3:
- added the P72 too

new in v2
---
 drivers/input/mouse/elantech.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index ca10fd97d9d5..ea1ee0f44a65 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1779,10 +1779,6 @@ static const char * const i2c_blacklist_pnp_ids[] = {
 	 * These are known to not be working properly as bits are missing
 	 * in elan_i2c.
 	 */
-	"LEN2131", /* ThinkPad P52 w/ NFC */
-	"LEN2132", /* ThinkPad P52 */
-	"LEN2133", /* ThinkPad P72 w/ NFC */
-	"LEN2134", /* ThinkPad P72 */
 	NULL
 };
 
-- 
2.21.0
