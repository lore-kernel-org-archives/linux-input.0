From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 1/3] Input: db9 - store object at correct index
Date: Fri,  2 Oct 2015 16:58:33 +0530
Message-ID: <1443785315-31495-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35728 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbbJBL2o (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 2 Oct 2015 07:28:44 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

The variable i is used to check the port to attach to and we are
supposed to save the reference of struct db9 in the location given by
db9_base[i]. But after finding out the index i is getting modified again
so we saved in a wrong index.

Fixes: 2260c419b52b ("Input: db9 - use parallel port device model")
Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/input/joystick/db9.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joystick/db9.c b/drivers/input/joystick/db9.c
index cf1f602..f6ecd4a 100644
--- a/drivers/input/joystick/db9.c
+++ b/drivers/input/joystick/db9.c
@@ -560,7 +560,7 @@ static void db9_attach(struct parport *pp)
 	const struct db9_mode_data *db9_mode;
 	struct pardevice *pd;
 	struct input_dev *input_dev;
-	int i, j;
+	int i, j, k;
 	int mode;
 	struct pardev_cb db9_parport_cb;
 
@@ -577,6 +577,7 @@ static void db9_attach(struct parport *pp)
 		pr_debug("Not using parport%d.\n", pp->number);
 		return;
 	}
+	k = i;
 
 	mode = db9_cfg[i].args[DB9_ARG_MODE];
 
@@ -649,7 +650,7 @@ static void db9_attach(struct parport *pp)
 			goto err_free_dev;
 	}
 
-	db9_base[i] = db9;
+	db9_base[k] = db9;
 	return;
 
  err_free_dev:
@@ -676,6 +677,7 @@ static void db9_detach(struct parport *port)
 		return;
 
 	db9 = db9_base[i];
+	db9_base[i] = NULL;
 
 	for (i = 0; i < min(db9_modes[db9->mode].n_pads, DB9_MAX_DEVICES); i++)
 		input_unregister_device(db9->dev[i]);
-- 
1.9.1

