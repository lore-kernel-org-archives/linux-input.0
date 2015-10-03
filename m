From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v2 3/3] Input: turbografx - store object in correct index
Date: Sat,  3 Oct 2015 14:54:58 +0530
Message-ID: <1443864298-20950-3-git-send-email-sudipm.mukherjee@gmail.com>
References: <1443864298-20950-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443864298-20950-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: linux-input@vger.kernel.org

The variable i is used to check the port to attach to and we are
supposed to save the reference of struct tgfx in the location given by
tgfx_base[i]. But after finding out the index, i is getting modified
again so we saved in a wrong index.

Fixes: 4de27a638a99 ("Input: turbografx - use parallel port device model")
Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/input/joystick/turbografx.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/input/joystick/turbografx.c b/drivers/input/joystick/turbografx.c
index 01e8ea9..9f5bca2 100644
--- a/drivers/input/joystick/turbografx.c
+++ b/drivers/input/joystick/turbografx.c
@@ -162,27 +162,29 @@ static void tgfx_attach(struct parport *pp)
 	struct tgfx *tgfx;
 	struct input_dev *input_dev;
 	struct pardevice *pd;
-	int i, j;
+	int i, j, port_idx;
 	int *n_buttons, n_devs;
 	struct pardev_cb tgfx_parport_cb;
 
-	for (i = 0; i < TGFX_MAX_PORTS; i++) {
-		if (tgfx_cfg[i].nargs == 0 || tgfx_cfg[i].args[0] < 0)
+	for (port_idx = 0; port_idx < TGFX_MAX_PORTS; port_idx++) {
+		if (tgfx_cfg[port_idx].nargs == 0 ||
+		    tgfx_cfg[port_idx].args[0] < 0)
 			continue;
-		if (tgfx_cfg[i].args[0] == pp->number)
+		if (tgfx_cfg[port_idx].args[0] == pp->number)
 			break;
 	}
 
-	if (i == TGFX_MAX_PORTS) {
+	if (port_idx == TGFX_MAX_PORTS) {
 		pr_debug("Not using parport%d.\n", pp->number);
 		return;
 	}
-	n_buttons = tgfx_cfg[i].args + 1;
-	n_devs = tgfx_cfg[i].nargs - 1;
+	n_buttons = tgfx_cfg[port_idx].args + 1;
+	n_devs = tgfx_cfg[port_idx].nargs - 1;
 
 	tgfx_parport_cb.flags = PARPORT_FLAG_EXCL;
 
-	pd = parport_register_dev_model(pp, "turbografx", &tgfx_parport_cb, i);
+	pd = parport_register_dev_model(pp, "turbografx", &tgfx_parport_cb,
+					port_idx);
 	if (!pd) {
 		pr_err("parport busy already - lp.o loaded?\n");
 		return;
@@ -250,7 +252,7 @@ static void tgfx_attach(struct parport *pp)
 		goto err_free_tgfx;
         }
 
-	tgfx_base[i] = tgfx;
+	tgfx_base[port_idx] = tgfx;
 	return;
 
  err_free_dev:
-- 
1.9.1
