From: Teika Kazura <teika@gmx.com>
Subject: [PATCH v2] Input: synaptics - Lenovo ThinkPad T25 and T480 devices
 should use RMI
Date: Fri, 24 Aug 2018 14:07:56 +0900 (JST)
Message-ID: <20180824.140756.2287821275533434713.teika@gmx.com>
References: <20180707051913.24035-1-kitsunyan@inbox.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180707051913.24035-1-kitsunyan@inbox.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kitsunyan@inbox.ru, benjamin.tissoires@redhat.com
List-Id: linux-input@vger.kernel.org

The touchpads on both T25 and T480 are accessible over SMBUS/RMI.

---
v2

Only a tag change.
The original author wants to use a pseudonym, and agrees with the usurpation of the signed-off-by tag. See https://patchwork.kernel.org/patch/10512751/

Reported-by: kitsunyan <kitsunyan@inbox.ru>
Signed-off-by: Teika Kazura <teika@gmx.com>
---
 drivers/input/mouse/synaptics.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 55d33500d55e..be934a082424 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -175,7 +175,9 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN0071", /* T480 */
 	"LEN0072", /* X1 Carbon Gen 5 (2017) - Elan/ALPS trackpoint */
 	"LEN0073", /* X1 Carbon G5 (Elantech) */
+	"LEN008e", /* T25 */
 	"LEN0092", /* X1 Carbon 6 */
+	"LEN0093", /* T480 */
 	"LEN0096", /* X280 */
 	"LEN0097", /* X280 -> ALPS trackpoint */
 	"LEN200f", /* T450s */
-- 
2.18.0
