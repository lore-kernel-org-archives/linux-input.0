From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: synaptics - enable RMI mode for HP Spectre X360
Date: Sat, 13 Jul 2019 00:41:50 -0700
Message-ID: <20190713074150.GA241222@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Nate Graham <pointedstick@zoho.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The 2016 kabylake HP Spectre X360 (model number 13-w013dx) works much better
with psmouse.synaptics_intertouch=1 kernel parameter, so let's enable RMI4
mode automatically.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=204115
Reported-by: Nate Graham <pointedstick@zoho.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/synaptics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 7f8f4780b511..c0e188cd3811 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -182,6 +182,7 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN2055", /* E580 */
 	"SYN3052", /* HP EliteBook 840 G4 */
 	"SYN3221", /* HP 15-ay000 */
+	"SYN323d", /* HP Spectre X360 13-w013dx */
 	NULL
 };
 

-- 
Dmitry
