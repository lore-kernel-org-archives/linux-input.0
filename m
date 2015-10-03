From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v2 2/3] Input: gamecon - store object at correct index
Date: Sat,  3 Oct 2015 14:54:57 +0530
Message-ID: <1443864298-20950-2-git-send-email-sudipm.mukherjee@gmail.com>
References: <1443864298-20950-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35570 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007AbbJCJZM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 3 Oct 2015 05:25:12 -0400
In-Reply-To: <1443864298-20950-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>

The variable i is used to check the port to attach to and we are
supposed to save the reference of struct gc in the location given by
gc_base[i]. But after finding out the index, i is getting modified again
so we saved in a wrong index.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: a517e87c3dfc ("Input: gamecon - use parallel port device model")
Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/input/joystick/gamecon.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/input/joystick/gamecon.c b/drivers/input/joystick/gamecon.c
index 394ccbe..5a672dc 100644
--- a/drivers/input/joystick/gamecon.c
+++ b/drivers/input/joystick/gamecon.c
@@ -931,29 +931,30 @@ static void gc_attach(struct parport *pp)
 {
 	struct gc *gc;
 	struct pardevice *pd;
-	int i;
+	int i, port_idx;
 	int count = 0;
 	int *pads, n_pads;
 	struct pardev_cb gc_parport_cb;
 
-	for (i = 0; i < GC_MAX_PORTS; i++) {
-		if (gc_cfg[i].nargs == 0 || gc_cfg[i].args[0] < 0)
+	for (port_idx = 0; port_idx < GC_MAX_PORTS; port_idx++) {
+		if (gc_cfg[port_idx].nargs == 0 || gc_cfg[port_idx].args[0] < 0)
 			continue;
 
-		if (gc_cfg[i].args[0] == pp->number)
+		if (gc_cfg[port_idx].args[0] == pp->number)
 			break;
 	}
 
-	if (i == GC_MAX_PORTS) {
+	if (port_idx == GC_MAX_PORTS) {
 		pr_debug("Not using parport%d.\n", pp->number);
 		return;
 	}
-	pads = gc_cfg[i].args + 1;
-	n_pads = gc_cfg[i].nargs - 1;
+	pads = gc_cfg[port_idx].args + 1;
+	n_pads = gc_cfg[port_idx].nargs - 1;
 
 	gc_parport_cb.flags = PARPORT_FLAG_EXCL;
 
-	pd = parport_register_dev_model(pp, "gamecon", &gc_parport_cb, i);
+	pd = parport_register_dev_model(pp, "gamecon", &gc_parport_cb,
+					port_idx);
 	if (!pd) {
 		pr_err("parport busy already - lp.o loaded?\n");
 		return;
@@ -985,7 +986,7 @@ static void gc_attach(struct parport *pp)
 		goto err_free_gc;
 	}
 
-	gc_base[i] = gc;
+	gc_base[port_idx] = gc;
 	return;
 
  err_unreg_devs:
-- 
1.9.1

