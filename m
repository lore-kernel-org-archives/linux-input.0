From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 3/4] Input: twl6040-vibra: Use accessor to get revision information
Date: Fri,  2 Sep 2011 18:03:04 +0300
Message-ID: <1314975785-25081-4-git-send-email-peter.ujfalusi@ti.com>
References: <1314975785-25081-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1314975785-25081-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <samuel.ortiz@intel.com>, Dmitry Torokhov <dtor@mail.ru>, Misael Lopez Cruz <misael.lopez@ti.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/input/misc/twl6040-vibra.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/twl6040-vibra.c
index c43002e..154b7a3 100644
--- a/drivers/input/misc/twl6040-vibra.c
+++ b/drivers/input/misc/twl6040-vibra.c
@@ -97,7 +97,7 @@ static void twl6040_vibra_enable(struct vibra_info *info)
 	}
 
 	twl6040_power(info->twl6040, 1);
-	if (twl6040->rev <= TWL6040_REV_ES1_1) {
+	if (twl6040_get_revid(twl6040) <= TWL6040_REV_ES1_1) {
 		/*
 		 * ERRATA: Disable overcurrent protection for at least
 		 * 3ms when enabling vibrator drivers to avoid false
-- 
1.7.6.1
