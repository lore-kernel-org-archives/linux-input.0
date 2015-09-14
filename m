From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 1/2] Input: pm8941-pwrkey - remove unneded semicolon
Date: Mon, 14 Sep 2015 14:43:57 +0200
Message-ID: <1442234638-31460-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:36022 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751300AbbINMoJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Sep 2015 08:44:09 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Courtney Cavin <courtney.cavin@sonymobile.com>, Bjorn Andersson <bjorn.andersson@sonymobile.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

It's not needed and is just creating a null statement so remove it.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/input/misc/pm8941-pwrkey.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
index 867db8a91372..e317b75357a0 100644
--- a/drivers/input/misc/pm8941-pwrkey.c
+++ b/drivers/input/misc/pm8941-pwrkey.c
@@ -93,7 +93,7 @@ static int pm8941_reboot_notify(struct notifier_block *nb,
 	default:
 		reset_type = PON_PS_HOLD_TYPE_HARD_RESET;
 		break;
-	};
+	}
 
 	error = regmap_update_bits(pwrkey->regmap,
 				   pwrkey->baseaddr + PON_PS_HOLD_RST_CTL,
-- 
2.4.3

