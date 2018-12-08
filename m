From: Yussuf Khalil <dev@pp3345.net>
Subject: [PATCH RESEND] Input: synaptics - enable RMI on ThinkPad T560
Date: Sat,  8 Dec 2018 22:44:26 +0100
Message-ID: <20181208214426.6628-1-dev@pp3345.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: benjamin.tissoires@redhat.com, teika@gmx.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Yussuf Khalil <dev@pp3345.net>
List-Id: linux-input@vger.kernel.org

Before commit 7fd6d98b89f3 ("i2c: i801: Allow ACPI AML access I/O
ports not reserved for SMBus"), enabling RMI on the T560 would cause
the touchpad to stop working after resuming from suspend. Now that
this issue is fixed, RMI can be enabled safely and works fine.

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Yussuf Khalil <dev@pp3345.net>
---
Originally sent this patch in August. Resending because it has a 
merge conflict with v4.20-rc5.
---
 drivers/input/mouse/synaptics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 2bd5bb11c8ba..7bdf8fc2c3b5 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -171,6 +171,7 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN0046", /* X250 */
 	"LEN004a", /* W541 */
 	"LEN005b", /* P50 */
+	"LEN005e", /* T560 */
 	"LEN0071", /* T480 */
 	"LEN0072", /* X1 Carbon Gen 5 (2017) - Elan/ALPS trackpoint */
 	"LEN0073", /* X1 Carbon G5 (Elantech) */
-- 
2.19.2
