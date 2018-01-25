From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/3] Input: ims-pcu: Delete an unnecessary variable assignment
 in ims_pcu_setup_gamepad()
Date: Thu, 25 Jan 2018 19:54:47 +0100
Message-ID: <903a941e-a562-0456-da6e-9a801254c853@users.sourceforge.net>
References: <ff77a871-d30a-e873-ab73-2d80198bfbe7@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:49611 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751106AbeAYSy7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 25 Jan 2018 13:54:59 -0500
In-Reply-To: <ff77a871-d30a-e873-ab73-2d80198bfbe7@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Arvind Yadav <arvind.yadav.cs@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, Zhen Lei <thunder.leizhen@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 25 Jan 2018 19:37:34 +0100

An error code was assigned to a local variable in an if branch.
This value was not read again before it was used by a return statement
as a constant value at the end of this function.
Thus remove such an unneeded assignment.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/misc/ims-pcu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index d7778b273151..aa1bb284c714 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -295,7 +295,6 @@ static int ims_pcu_setup_gamepad(struct ims_pcu *pcu)
 	if (!gamepad || !input) {
 		dev_err(pcu->dev,
 			"Not enough memory for gamepad device\n");
-		error = -ENOMEM;
 		goto err_free_mem;
 	}
 
-- 
2.16.1

