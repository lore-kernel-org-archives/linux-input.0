From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: synaptics - Lenovo Carbon X1 Gen5 (2017) devices
 should use RMI
Date: Fri, 18 Aug 2017 12:34:36 -0700
Message-ID: <20170818193436.GA31365@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33753 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751660AbdHRTek (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 18 Aug 2017 15:34:40 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org

The touchpad on Lenovo Carbon X1 Gen 5 (2017 - Kabylake) is accessible over
SMBUS/RMI, so let's activate it by default.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/synaptics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 9a8d81efd329..248c7c9dcbaa 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -172,6 +172,7 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN0048", /* X1 Carbon 3 */
 	"LEN0046", /* X250 */
 	"LEN004a", /* W541 */
+	"LEN0072", /* X1 Carbon Gen 5 (2017) */
 	"LEN200f", /* T450s */
 	NULL
 };
-- 
2.14.1.480.gb18f417b89-goog


-- 
Dmitry
