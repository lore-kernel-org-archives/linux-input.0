From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] Input: synaptics - switch t460s 20FN to use RMI4 over SMBus
Date: Mon, 26 Jun 2017 10:26:26 +0200
Message-ID: <20170626082626.797-1-benjamin.tissoires@redhat.com>
References: <CAE4xfVLxhF29jLoFWwa4o6_0G_5VMQ8YN1BVP4=8+Y3u_BERPw@mail.gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49622 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751364AbdFZI0l (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 26 Jun 2017 04:26:41 -0400
In-Reply-To: <CAE4xfVLxhF29jLoFWwa4o6_0G_5VMQ8YN1BVP4=8+Y3u_BERPw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Bachner <b.christopher.92@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

Hi Christopher,

Could you please test this patch without appending synaptics_intertouch=1
to the boot command line? If this still works, we will have the RMI4 over
SMBus by default for your laptop.

Cheers,
Benjamin

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/mouse/synaptics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index f4fbe1a..a8fb26bc 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -173,6 +173,7 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN0046", /* X250 */
 	"LEN004a", /* W541 */
 	"LEN200f", /* T450s */
+	"LEN2016", /* T460 20FN */
 	NULL
 };
 
-- 
2.9.4

