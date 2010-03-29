From: Jan-Hendrik Zab <jan@jhz.name>
Subject: [PATCH] Add Sony Vaio VPCZ1 series to the nopnp table
Date: Tue, 30 Mar 2010 01:32:57 +0200
Message-ID: <20100329233257.GA85504@jhz.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from red.unix-ag.uni-hannover.de ([130.75.176.204]:12223 "EHLO
	jhz.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751312Ab0C2Xqq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Mar 2010 19:46:46 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: torvalds@linux-foundation.org, linux-input@vger.kernel.org

The entire Sony Vaio VPCZ1 series seems to need the nopnp option set to
get the touchpad working. This patch adds the laptops to the nopnp table
to automatically set it.

Signed-off-by: Jan-Hendrik Zab <jan@jhz.name>

---
 drivers/input/serio/i8042-x86ia64io.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index ead0494..7c0cb87 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -495,6 +495,14 @@ static const struct dmi_system_id __initconst i8042_dmi_nopnp_table[] = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "MICRO-STAR INTERNATIONAL CO., LTD"),
 		},
 	},
+	{
+		/* Sony Vaio VPCZ1 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "VAIO"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "Sony Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "VPCZ1"),
+		},
+	},
 	{ }
 };
 
-- 
1.7.0.3

