From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH] Input: bma150 - constify bma150_cfg structure
Date: Wed, 30 Dec 2015 12:11:19 +0100
Message-ID: <1451473879-10443-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:62688 "EHLO
	mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754019AbbL3LYE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Dec 2015 06:24:04 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

The bma150_cfg structure is never modified, so declare it as const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/input/misc/bma150.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/bma150.c b/drivers/input/misc/bma150.c
index 1d0e61d..b0d4453 100644
--- a/drivers/input/misc/bma150.c
+++ b/drivers/input/misc/bma150.c
@@ -147,7 +147,7 @@ struct bma150_data {
  * are stated and verified by Bosch Sensortec where they are configured
  * to provide a generic sensitivity performance.
  */
-static struct bma150_cfg default_cfg = {
+static const struct bma150_cfg default_cfg = {
 	.any_motion_int = 1,
 	.hg_int = 1,
 	.lg_int = 1,

