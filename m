From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 25/97] Input: synaptics - enable RMI on ThinkPad T560
Date: Wed, 26 Dec 2018 17:34:45 -0500
Message-ID: <20181226223557.149329-25-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yussuf Khalil <dev@pp3345.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Yussuf Khalil <dev@pp3345.net>

[ Upstream commit ca5047286c9c93a01e1f471d00a6019536992954 ]

Before commit 7fd6d98b89f3 ("i2c: i801: Allow ACPI AML access I/O
ports not reserved for SMBus"), enabling RMI on the T560 would cause
the touchpad to stop working after resuming from suspend. Now that
this issue is fixed, RMI can be enabled safely and works fine.

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Yussuf Khalil <dev@pp3345.net>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.19.1
